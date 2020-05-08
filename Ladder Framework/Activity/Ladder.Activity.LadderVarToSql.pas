unit Ladder.Activity.LadderVarToSql;

interface

uses
  SysUtils, SynCommons, SynTable;

type
  TLadderVarToSql = class
    class procedure TableDocToInlineSql(pDocVariant: TDocVariantData; pTextWriter: TTextWriter; pNumberOfRows: Integer=0; pOffset: Integer=0); overload;
    class function TableDocToInlineSql(pDocVariant: TDocVariantData; pNumberOfRows: Integer=0; pOffset: Integer=0): String; overload;
    // DO NOT USE!! Use InsertDocVariantData, which uses FireDAC arrayDML and is much faster
    class procedure InsertDocVariantDataInline(pDocVariant: TDocVariantData; const pTableName: String);

    class function ValuesDocToSql(pDocVariant: TDocVariantData): String;
    class function LadderDocVariantToSql(pDocVariant: TDocVariantData): String;

    class function InsertSqlWithParams(pDocVariant: TDocVariantData; const pTableName: String): String; static;
    class procedure InsertDocVariantData(pDocVariant: TDocVariantData; const pTableName: String);

    // Checks the type of the variant to find the Field Type,
    // if pCurrentFieldType is not ftNull, keeps most compatible type between infered variant type and pCurrentFieldType.
    // Ex.: if VariantType is int and pCurrentFieldType is ftCurrency, keeps ftCurrency
    class procedure SetNewFieldType(pValue: PVAriant; var pFieldType: TSQLDBFieldType);
  private
  end;

implementation

uses
  Variants, Ladder.Activity.Classes, Ladder.ORM.QueryBuilder, Ladder.ORM.Functions, Ladder.ServiceLocator, System.Classes,
  FireDAC.Comp.Client, Data.DB, FireDAC.Stan.Option;

function LadderVarToStr(pVar: Variant): String;
begin
  if VarIsNull(pVar) then
    Result:= 'null'
  else if LadderVarIsDateTime(pVar) then
    Result:= TSqlServerQueryBuilder.DateTimeSqlServer(LadderVarToDateTime(pVar))
  else if VarIsStr(pVar) then
    Result:=Format('''%s''', [StringReplace(VarToStr(pVar),'''', '''''', [rfReplaceAll])])
  else if VarIsFloat(pVar) then
    Result:= FloatToSqlStr(pVar)
  else
    Result:= VarToStr(pVar);
end;

class procedure TLadderVarToSql.TableDocToInlineSql(pDocVariant: TDocVariantData; pTextWriter: SynCommons.TTextWriter; pNumberOfRows: Integer=0; pOffset: Integer=0);
var
  I: Integer;
  FRow: TDocVariantData;

  procedure AppendColumn(ColIndex: Integer; AddColNames: Boolean);
  begin
    if ColIndex=0 then
      pTextWriter.AddShort(' SELECT ')
    else
      pTextWriter.AddShort(',');

    if AddColNames then
      pTextWriter.AddString(Format('%s as %s', [LadderVarToStr(FRow.Values[ColIndex]), FRow.Names[ColIndex]]))
    else
      pTextWriter.AddString(Format('%s', [LadderVarToStr(FRow.Values[ColIndex])]));
  end;


  procedure AppendRow(Index: integer);
  var
    I: Integer;
  begin
    FRow:= TDocVariantData(pDocVariant.Values[Index]);

    if Index>pOffset then
      pTextWriter.AddShort(' UNION');

    for I := 0 to FRow.Count-1 do
      AppendColumn(I, Index=pOffset); // Add col names on first row only
  end;

var
  FMaxIndex: Integer;

begin
//  FText:= TTextWriter.CreateOwnedStream(temp);
  if pNumberOfRows=0 then
    FMaxIndex:= pDocVariant.Count
  else if pNumberOfRows > pDocVariant.Count+pOffset then
    FMaxIndex:= pDocVariant.Count
  else
    FMaxIndex:= pOffset+pNumberOfRows;

  for I := pOffset to FMaxIndex-1 do
    AppendRow(I);

end;

class function TLadderVarToSql.TableDocToInlineSql(pDocVariant: TDocVariantData;
  pNumberOfRows, pOffset: Integer): String;
var
  FText: SynCommons.TTextWriter;
  temp: TTextWriterStackBuffer;
begin
 FText:= SynCommons.TTextWriter.CreateOwnedStream(temp);
 try
   TableDocToInlineSql(pDocVariant, FText, pNumberOfRows, pOffset);
   Result:= FText.Text;
 finally
   FText.Free;
 end;
end;

class procedure TLadderVarToSql.SetNewFieldType(pValue: PVAriant; var pFieldType: TSQLDBFieldType);
var
  FNewFieldType: TSQLDBFieldType;
begin
  if pFieldType = SynTable.ftUTF8 then Exit; // If it is a string it does not need to be changed

  FNewFieldType:= VariantVTypeToSQLDBFieldType(VarType(pValue^));

  if FNewFieldType <= SynTable.ftNull then  // if current col FieldType is ftnull or ftUnknown does not need to change
    Exit;

  if pFieldType <= ftNull then
  begin
    if (FNewFieldType = SynTable.ftUTF8) and (LadderVarIsIso8601(pValue^)) then // Check special case when date is stored as string
      pFieldType:= SynTable.ftDate
    else
      pFieldType:= FNewFieldType;

    Exit;
  end;

  if FNewFieldType = pFieldType then
    Exit
  else if Ord(FNewFieldType) > Ord(pFieldType) then
    pFieldType:= FNewFieldType
  else // Ord(FFieldType) < Ord(FieldTypes[Col]
    if pFieldType = SynTable.ftDate then // if current column fieldtype is int, double or currency and prior fieldtype was date, must change to string
      pFieldType:= SynTable.ftUTF8;
end;


class procedure TLadderVarToSql.InsertDocVariantData(
  pDocVariant: TDocVariantData; const pTableName: String);
var
  FieldNames: TRawUTF8DynArray;
  FieldTypes: TSQLDBFieldTypeDynArray;
  FieldValues: TRawUTF8DynArrayDynArray;
  FFieldCount: Integer;
  FFirstRow: PDocVariantData;
  FQry: TFDQuery;

  procedure SetQryParamType(Col: Integer; const pFieldType: TSQLDBFieldType);
  begin
    case pFieldType of
      SynTable.ftUnknown, SynTable.ftNull: FQry.Params[Col].DataType:= Data.DB.ftByte; // Must have a type
      SynTable.ftUTF8: FQry.Params[Col].DataType:= Data.DB.ftString;
      SynTable.ftDate: FQry.Params[Col].DataType:= Data.DB.ftDateTime;
      SynTable.ftInt64: FQry.Params[Col].DataType:= Data.DB.ftInteger;
      SynTable.ftDouble, SynTable.ftCurrency: FQry.Params[Col].DataType:= Data.DB.ftFloat;
    end;
    FQry.Params[Col].ParamType:= ptInput;
  end;

  procedure SetParamValue(Row, Col: Integer; FVar: PVariant);
  var
    basicType: Integer;
  begin
      if VarIsNull(FVar^) then
      begin
        FQry.Params[Col].Values[Row]:= null;
        Exit;
      end;

      case FieldTypes[Col] of
        SynTable.ftUnknown, SynTable.ftNull:  FQry.Params[Col].Values[Row]:= null;
        SynTable.ftUTF8: FQry.Params[Col].AsStrings[Row]:= VarToStr(FVar^);
        SynTable.ftDate: FQry.Params[Col].AsDateTimes[Row]:= LadderVarToDateTime(FVar^);
        SynTable.ftInt64: FQry.Params[Col].AsIntegers[Row]:= FVar^;
        SynTable.ftDouble, SynTable.ftCurrency: FQry.Params[Col].AsFloats[Row]:= FVar^;
      else
        FQry.Params[Col].Values[Row]:= FVar^;
      end;
  end;

  function FDConnection: TFDConnection;
  begin
    Result:= TFrwServiceLocator.Context.DmConnection.FDConnection;
  end;

var
  Col, Row: Integer;
  sStart, sFim: TDateTime;
  FCurOffset, FNumExecutions: Integer;

const
  cBatchSize = 500; // Optimum performance
begin
  if pDocVariant.Count=0 then
    Exit;

  FQry:= TFDQuery.Create(nil);
  try
    FQry.Connection:= FDConnection;
    FQry.SQL.Text:= TLadderVarToSql.InsertSqlWithParams(pDocVariant, pTableName);
    FFirstRow:= @TDocVariantData(pDocVariant.Values[0]);
    FFieldCount:= Length(FFirstRow^.Values);

    SetLength(FieldTypes, FFieldCount);
    SetLength(FieldNames, FFieldCount);
    for Col := 0 to FFieldCount-1 do
    begin
      FieldTypes[Col]:= ftNull;
      FieldNames[Col]:= FFirstRow^.Names[Col];
    end;

    for Col := 0 to FFieldCount-1 do // Have to loop trough all the results to get the Field type beforehand
      for Row := 0 to pDocVariant.Count-1 do
        SetNewFieldType(@pDocVariant._[Row].Values[Col], FieldTypes[Col]);

    for Col := 0 to FFieldCount-1 do
      SetQryParamType(Col, FieldTypes[Col]);

    sStart:= now;
    FDConnection.TxOptions.Isolation := xiDirtyRead;
    FDConnection.TxOptions.AutoCommit:= False;
    FDConnection.StartTransaction;
    try
      FCurOffset:= 0;
      while FCurOffset < pDocVariant.Count do
      begin
        FNumExecutions:= cBatchSize;

        if FNumExecutions+FCurOffset > pDocVariant.Count then
          FNumExecutions:= pDocVariant.Count-FCurOffset;

        FQry.Params.ArraySize:= FNumExecutions;

        for Row := 0 to FNumExecutions-1 do
          for Col := 0 to FFieldCount-1 do
            SetParamValue(Row, Col, @pDocVariant._[Row+FCurOffset].Values[Col]);

        FQry.Execute(FNumExecutions, 0);
        FCurOffset:= FCurOffset+cBatchSize;
      end;
    //  MultipleValuesInsert(Self, '##MFORTESTE', FieldNames, FieldTypes, pDocVariant.Count, FieldValues);
    finally
      FDConnection.Commit;
      sFim:= now;
    end;
//    ShowMessage(IntToStr(MilliSecondsBetween(sStart, sFim)));
  //  Assert(False, IntToStr(MilliSecondsBetween(sStart, sFim)));
  finally
    FQry.Free;
  end;
end;

class procedure TLadderVarToSql.InsertDocVariantDataInline(
  pDocVariant: TDocVariantData; const pTableName: String);
var
  FText: SynCommons.TTextWriter;
  temp: TTextWriterStackBuffer;
  I: Integer;
  FCurOffset, FNumExecutions: Integer;
  FStr: TStringList;
  FResult: String;
const
  cBatchSize = 100;
begin
 FStr:= TStringList.Create;
 try
   FCurOffset:= 0;
   while FCurOffset < pDocVariant.Count do
   begin
      FText:= SynCommons.TTextWriter.CreateOwnedStream(temp);
     try
       FText.AddString(Format('insert into %s select * from (', [pTableName]));
       TLadderVarToSql.TableDocToInlineSql(pDocVariant, FText, cBatchSize, FCurOffset);
       FText.AddShort(')X');

       FCurOffset:= FCurOffset+cBatchSize;
       FResult:= FText.Text;
       FStr.Text:= FResult;
       FStr.SaveToFile('F:\Sistemas\Ladder Framework\Activity\Test\sql.sql');
       TFrwServiceLocator.Context.Connection.ExecuteNoResult(FResult, []);
     finally
       FText.Free;
     end;
    //FText.Empty;
   end;
 finally
   FStr.Free;
 end;
end;

class function TLadderVarToSql.InsertSqlWithParams(pDocVariant: TDocVariantData; const pTableName: String): String;
var
  I: Integer;
  FRow: TDocVariantData;
  temp: TTextWriterStackBuffer;
  FText: SynCommons.TTextWriter;

  procedure AppendColumn(ColIndex: Integer);
  begin
    if ColIndex=0 then
      FText.AddString(Format(' SELECT %s as %s', [LadderVarToStr(FRow.Values[ColIndex]), FRow.Names[ColIndex]]))
    else
      FText.AddString(Format(',%s as %s', [LadderVarToStr(FRow.Values[ColIndex]), FRow.Names[ColIndex]]));

  end;


  procedure AppendRow(Index: integer);
  var
    I: Integer;
  begin
    FRow:= TDocVariantData(pDocVariant.Values[Index]);

    if Index>0 then
      FText.AddShort(' UNION');

    for I := 0 to FRow.Count-1 do
      AppendColumn(I);
  end;

var
  FirstRow: PDocVariantData;
begin
  if pDocVariant.Count=0 then
    Exit;

  FText:= SynCommons.TTextWriter.CreateOwnedStream(temp);
  try
    FText.AddString(Format('insert into %s (', [pTableName]));

    FirstRow:= @TDocVariantData(pDocVariant.Values[0]);

    for I:= 0 to Length(FirstRow^.Names)-1 do
      if I > 0 then
        FText.AddString(Format(', %s', [FirstRow^.Names[I]]))
      else
        FText.AddString(FirstRow^.Names[I]);

    FText.AddShort(') values (');

    for I:= 0 to Length(FirstRow^.Names)-1 do
      if I > 0 then
        FText.AddString(Format(', :%s', [FirstRow^.Names[I]]))
      else
        FText.AddString(Format(':%s', [FirstRow^.Names[I]]));

    FText.AddShort(')');
  {  for I := 0 to pDocVariant.Count-1 do
      AppendRow(I);}

    Result:= FText.Text;
  finally
    FText.Free;
  end;
end;

class function TLadderVarToSql.ValuesDocToSql(pDocVariant: TDocVariantData): String;
begin
  Result:= '';
end;

class function TLadderVarToSql.LadderDocVariantToSql(pDocVariant: TDocVariantData): String;
begin
  Result:= '';

  if pDocVariant.Count = 0 then
    Exit;

  if DocVariantType.IsOfType(pDocVariant.Values[0]) then // Is a table (2 dimensional array, rows and values)
    Result:= TableDocToInlineSql(pDocVariant)
  else
    Result:= ValuesDocToSql(pDocVariant);
end;

end.
