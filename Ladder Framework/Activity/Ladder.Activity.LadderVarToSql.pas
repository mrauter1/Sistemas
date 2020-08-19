unit Ladder.Activity.LadderVarToSql;

interface

uses
  SysUtils, SynCommons, SynTable, Data.DB, System.Classes, mormotVCL, Mormot, Ladder.ConnectionPropertiesHelper,
  SynDB, FireDAC.Comp.Client, Ladder.ORM.DaoUtils;

type
  TSqlFieldTypeDynArray = array of TSqlFIeldType;

  TLadderVarToSql = class
  private
    class function FDConnection: TFDConnection; static;
    class function DaoUtils: TDaoUtils; static;

    // Checks the type of the variant to find the Field Type,
    // if pCurrentFieldType is not ftNull, keeps most compatible type between infered variant type and pCurrentFieldType.
    // Ex.: if VariantType is int and pCurrentFieldType is ftCurrency, keeps ftCurrency
    class procedure SetNewFieldType(pValue: PVAriant; var pFieldType: TSQLDBFieldType);
    class procedure SetNewSqlFieldType(pValue: PVAriant; var pFieldType: TSQLFieldType); static;


    class function SqlDBConnection: TSqlDBConnectionProperties; static;
    class function TableExists(const pTableName: String): Boolean; static;
    class procedure TruncateTable(const pTableName: String); static;

  public
    // If pAsString then treat then always quote the value when not null
    class function LadderVarToStr(pVar: Variant; pAsString: Boolean = False): String; static;

    class procedure TableDocToInlineSql(pDocVariant: TDocVariantData; pTextWriter: SynCommons.TTextWriter; pNumberOfRows: Integer=0; pOffset: Integer=0); overload;
    class function TableDocToInlineSql(pDocVariant: TDocVariantData; pNumberOfRows: Integer=0; pOffset: Integer=0): String; overload;
    // DO NOT USE!! Use InsertDocVariantData, which uses FireDAC arrayDML and is much faster
    class function InsertSqlWithParams(const pDocVariant: TDocVariantData; const pTableName: String): String; static;
    class procedure InsertDocVariantDataInline(pDocVariant: TDocVariantData; const pTableName: String);
    class function ValuesDocToSql(pDocVariant: TDocVariantData): String;
    class function LadderDocVariantToSql(pDocVariant: TDocVariantData): String;
    class function DocVariantToDataSet(AOwner: TComponent; pDocVariant: TDocVariantData): TSynSqlTableDataSet;
    class function DataSetToDocVariant(pDataSet: TDataSet; NullValuesWhenEmpty: Boolean = False): TDocVariantData;
    class procedure CreateTableFromDocVariant(const pDocVariant: TDocVariantData; const pTableName: String); overload;
    class procedure CreateTableFromDocVariant(const pDocVariant: TDocVariantData; const pTableName: String; const pFieldTypes: TSqlDBFieldTypeDynArray); overload;

    class procedure InsertDocVariantData(const pDocVariant: TDocVariantData; const pTableName: String; CreateTable: Boolean=True; ResetTable: Boolean=False);

    class procedure SetSqlDBFieldTypes(pDocVariant: TDocVariantData; var pFieldTypes: TSQLDBFieldTypeDynArray); static;
    class procedure SetFieldTypes(pDocVariant: TDocVariantData; var pFieldTypes: TSqlFieldTypeDynArray); static;
  end;

implementation

uses
  Variants, Ladder.Utils, Ladder.ORM.QueryBuilder, Ladder.ServiceLocator,
  FireDAC.Stan.Option, SynVirtualDataSet, Dialogs, DateUtils;

class function TLadderVarToSql.FDConnection: TFDConnection;
begin
  Result:= TFrwServiceLocator.Context.DmConnection.FDConnection;
end;

function SqlDBFieldTypeToSqlFieldType(SqlDBFieldType: TSqlDBFieldType): TSqlFieldType;
begin
  case SqlDBFieldType of
    TSQLDBFieldType.ftUnknown: Result:= TSQLFieldType.sftUnknown;
    TSQLDBFieldType.ftNull: Result:= TSQLFieldType.sftUnknown;
    TSQLDBFieldType.ftInt64: Result:= TSQLFieldType.sftInteger;
    TSQLDBFieldType.ftDouble: Result:= TSQLFieldType.sftFloat;
    TSQLDBFieldType.ftCurrency: Result:= TSQLFieldType.sftCurrency;
    TSQLDBFieldType.ftDate: Result:= TSQLFieldType.sftDateTime;
    TSQLDBFieldType.ftUTF8: Result:= TSQLFieldType.sftUTF8Text;
    else Result:= TSQLFieldType.sftVariant;
  end;
end;

function SqlFieldTypeToSqlDBFIeldType(SqlFieldType: TSqlFieldType): TSqlDBFieldType;
begin
  case SqlFieldType of
    sftAnsiText, sftUTF8Text, sftUTF8Custom: Result:= SynTable.ftUTF8;
    sftBoolean, sftInteger, sftEnumerate: Result:= SynTable.ftInt64;
    sftFloat: Result:= SynTable.ftDouble;
    sftCurrency: Result:= SynTable.ftCurrency;
    sftDateTime, sftDateTimeMS: Result:= SynTable.ftDate;
    else
    Result:= SynTable.ftUnknown;
  end;
end;

function VariantVTypeToSQLFieldType(VType: Cardinal): TSQLFIeldType;
begin
  Result:= SqlDBFieldTypeToSqlFieldType(VariantVTypeToSQLDBFieldType(VType));
end;

class function TLadderVarToSql.LadderVarToStr(pVar: Variant; pAsString: Boolean = False): String;
var
  fFloatValue: Extended;
begin
  if VarIsNull(pVar) then
    Result:= 'null'
  else if pAsString then
    Result:=Format('''%s''', [StringReplace(VarToStr(pVar),'''', '''''', [rfReplaceAll])])
  else if LadderVarIsDateTime(pVar) then
    Result:= TSqlServerQueryBuilder.DateTimeSqlServer(LadderVarToDateTime(pVar))
  else if LadderVarIsFloat(pVar, fFloatValue) then
    Result:= TSqlServerQueryBuilder.FloatToSqlStr(fFloatValue)
  else if VarIsStr(pVar) then
    Result:=Format('''%s''', [StringReplace(VarToStr(pVar),'''', '''''', [rfReplaceAll])])
  else
    Result:= VarToStr(pVar);
end;

class procedure TLadderVarToSql.TableDocToInlineSql(pDocVariant: TDocVariantData; pTextWriter: SynCommons.TTextWriter; pNumberOfRows: Integer=0; pOffset: Integer=0);
var
  I: Integer;
  FRow: TDocVariantData;
  FieldTypes: TSQLDBFieldTypeDynArray;

  procedure AppendColumn(ColIndex: Integer; AFirstRow: Boolean);
  begin
    if ColIndex=0 then
      pTextWriter.AddShort(' SELECT ')
    else
      pTextWriter.AddShort(',');

    if AFirstRow then
      pTextWriter.AddString(Format('%s as %s', [LadderVarToStr(FRow.Values[ColIndex], FieldTypes[ColIndex]=ftUTF8), FRow.Names[ColIndex]]))
    else
      pTextWriter.AddString(Format('%s', [LadderVarToStr(FRow.Values[ColIndex], FieldTypes[ColIndex]=ftUTF8)]));
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
  // TODO: Before adding values as Sql, must first infer the types of all columns

  SetSqlDBFieldTypes(pDocVariant, FieldTypes);

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

class procedure TLadderVarToSql.SetNewSqlFieldType(pValue: PVAriant; var pFieldType: TSQLFieldType);
var
  FCurFieldType: TSQLDBFieldType;
begin
  FCurFieldType:= SqlFieldTypeToSqlDBFIeldType(pFieldType);
  SetNewFieldType(pValue, FCurFieldType);
  pFieldType:= SqlDBFieldTypeToSqlFieldType(FCurFieldType);
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
  else if ((FNewFieldType = SynTable.ftUTF8) and (LadderVarIsIso8601(pValue^))) then // Check special case when date is stored as string
    pFieldType:= SynTable.ftDate
  else if Ord(FNewFieldType) > Ord(pFieldType) then
    pFieldType:= FNewFieldType
  else // Ord(FFieldType) < Ord(FieldTypes[Col]
    if pFieldType = SynTable.ftDate then // if current column fieldtype is int, double or currency and prior fieldtype was date, must change to string
      pFieldType:= SynTable.ftUTF8;
end;

class function TLadderVarToSql.SqlDBConnection: TSqlDBConnectionProperties;
begin
  Result:= TFrwServiceLocator.Context.Connection;
end;

class procedure TLadderVarToSql.CreateTableFromDocVariant(
  const pDocVariant: TDocVariantData; const pTableName: String);
var
  FFieldTypes: TSQLDBFieldTypeDynArray;
begin
  SetSqlDBFieldTypes(pDocVariant, FFieldTypes);
  CreateTableFromDocVariant(pDocVariant, pTableName, FFieldTypes);
end;

class procedure TLadderVarToSql.CreateTableFromDocVariant(const pDocVariant: TDocVariantData; const pTableName: String;
    const pFieldTypes: TSqlDBFieldTypeDynArray);
var
  FFieldCount: Integer;
  FFirstRow: PDocVariantData;
  FColumns: TSQLDBColumnCreateDynArray;
  Col: Integer;
  FSql: String;
begin
  FFirstRow:= @TDocVariantData(pDocVariant.Values[0]);
  FFieldCount:= Length(FFirstRow^.Values);
  SetLength(FColumns, FFieldCount);
  for Col := 0 to FFieldCount-1 do
  begin
    FColumns[Col].DBType:= pFieldTypes[Col];
    FColumns[Col].Name:= FFirstRow^.Names[Col];
    FColumns[Col].Width:= 0;
    FColumns[Col].Unique:= False;
    FColumns[Col].NonNullable:= False;
    FColumns[Col].PrimaryKey:= False;
  end;
  FSql:= SqlDBConnection.SQLCreate(pTableName, FColumns, False);
  SqlDBConnection.ExecuteNoResult(FSql, []);
end;

class function TLadderVarToSql.DaoUtils: TDaoUtils;
begin
  Result:= TFrwServiceLocator.Context.DaoUtils;
end;

class function TLadderVarToSql.DataSetToDocVariant(pDataSet: TDataSet; NullValuesWhenEmpty: Boolean = False): TDocVariantData;
var
  fField: Data.DB.TField;
  fFieldValues: TDocVariantData;
begin
  Result:= TDocVariantData(_JsonFast(DataSetToJson(pDataSet)));
  if (TDocVariantData(Result).Kind <> dvArray) and (NullValuesWhenEmpty) then // if return is not array record count is 0
  begin
    fFieldValues.InitObject([]);
    for fField in pDataSet.Fields do
      fFieldValues.AddValue(fField.FieldName, null);

    TDocVariantData(Result).Clear;
    TDocVariantData(Result).Init();
    TDocVariantData(Result).AddItem(variant(fFieldValues))
  end;
end;

class procedure TLadderVarToSql.SetFieldTypes(pDocVariant: TDocVariantData; var pFieldTypes: TSqlFieldTypeDynArray);
var
  FFieldCount: Integer;
  FFirstRow: PDocVariantData;
  Col, Row: Integer;
begin
  Assert(DocVariantIsTable(pDocVariant), 'TLadderVarToSql.SetFieldTypes: pDocVariant must be table.');
  FFirstRow:= @TDocVariantData(pDocVariant.Values[0]);
  FFieldCount:= Length(FFirstRow^.Values);

  SetLength(pFieldTypes, FFieldCount);
  for Col := 0 to FFieldCount-1 do
    pFieldTypes[Col]:= sftUnknown;

  for Col := 0 to FFieldCount-1 do // Have to loop trough all the results to get the Field type beforehand
    for Row := 0 to pDocVariant.Count-1 do
      SetNewSqlFieldType(@pDocVariant._[Row].Values[Col], pFieldTypes[Col]);
end;

class procedure TLadderVarToSql.SetSqlDBFieldTypes(pDocVariant: TDocVariantData; var pFieldTypes: TSQLDBFieldTypeDynArray);
var
  FFieldCount: Integer;
  FFirstRow: PDocVariantData;
  Col, Row: Integer;
begin
  FFirstRow:= @TDocVariantData(pDocVariant.Values[0]);
  FFieldCount:= Length(FFirstRow^.Values);

  SetLength(pFieldTypes, FFieldCount);
  for Col := 0 to FFieldCount-1 do
    pFieldTypes[Col]:= ftNull;

  for Col := 0 to FFieldCount-1 do // Have to loop trough all the results to get the Field type beforehand
    for Row := 0 to pDocVariant.Count-1 do
      SetNewFieldType(@pDocVariant._[Row].Values[Col], pFieldTypes[Col]);
end;

class function TLadderVarToSql.DocVariantToDataSet(AOwner: TComponent;
  pDocVariant: TDocVariantData): TSynSqlTableDataSet;
var
  SqlFieldTypes: TSqlFieldTypeDynArray;
begin
  SetFieldTypes(pDocVariant, SqlFieldTypes);

  Result:= JSONToDataSet(AOwner, pDocVariant.ToJSON(), SqlFieldTypes);
end;

class function TLadderVarToSql.TableExists(const pTableName: String): Boolean;
begin
  Result:= DaoUtils.SelectInt(TSqlServerQueryBuilder.TableExists(pTableName), 0) > 0;
end;

class procedure TLadderVarToSql.TruncateTable(const pTableName: String);
begin
  DaoUtils.ExecuteNoResult(TSqlServerQueryBuilder.TruncateTable(pTableName));
end;

class procedure TLadderVarToSql.InsertDocVariantData(const pDocVariant: TDocVariantData; const pTableName: String; CreateTable: Boolean=True; ResetTable: Boolean=False);
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
    FQry.Params[Col].ParamType:= Data.DB.ptInput;
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
        SynTable.ftDate: begin
           FQry.Params[Col].AsDateTimes[Row]:= LadderVarToDateTime(FVar^);
           // Have to check for min and max values to avoid bugs on conversion to datetime on sql server
//           if (FQry.Params[Col].AsDateTimes[Row] < MinDateTime) or (FQry.Params[Col].AsDateTimes[Row] > MaxDateTime) then
//             FQry.Params[Col].Values[Row]:= null;
        end;
        SynTable.ftInt64: FQry.Params[Col].AsIntegers[Row]:= FVar^;
        SynTable.ftDouble, SynTable.ftCurrency: FQry.Params[Col].AsFloats[Row]:= FVar^;
      else
        FQry.Params[Col].Values[Row]:= FVar^;
      end;
  end;

var
  Col, Row: Integer;
  FCurOffset, FNumExecutions: Integer;

const
  cBatchSize = 1000; // Optimum performance
begin
  if pDocVariant.Count=0 then
    Exit;

  FQry:= TFDQuery.Create(nil);
  try
    FQry.Connection:= FDConnection;
    FQry.SQL.Text:= TLadderVarToSql.InsertSqlWithParams(pDocVariant, pTableName);
    FFirstRow:= @TDocVariantData(pDocVariant.Values[0]);
    FFieldCount:= Length(FFirstRow^.Values);

    SetLength(FieldNames, FFieldCount);
    for Col := 0 to FFieldCount-1 do
      FieldNames[Col]:= FFirstRow^.Names[Col];

    SetSqlDBFieldTypes(pDocVariant, FieldTypes);

    if TableExists(pTableName) then
    begin
      if ResetTable then
        TruncateTable(pTableName)
    end
    else if CreateTable then
      CreateTableFromDocVariant(pDocVariant, pTableName, FieldTypes)
    else
      raise Exception.Create(Format('TLadderVarToSql.InsertDocVariantData: Table %s does not exists on database %s. Set parameter CreateTable to True to automatically create table in database.',
            [pTableName, SqlDBConnection.DatabaseName]));

    for Col := 0 to FFieldCount-1 do
      SetQryParamType(Col, FieldTypes[Col]);

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
    end;
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
  FResult: String;
const
  cBatchSize = 100;
begin
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
     TFrwServiceLocator.Context.Connection.ExecuteNoResult(FResult, []);
   finally
     FText.Free;
   end;
  //FText.Empty;
 end;
end;

class function TLadderVarToSql.InsertSqlWithParams(const pDocVariant: TDocVariantData; const pTableName: String): String;
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
    FText.AddString(Format('insert into %s WITH (TABLOCK) (', [pTableName]));

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
