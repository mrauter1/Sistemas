unit Ladder.ConnectionPropertiesHelper;

interface

uses
  SynTable, SynCommons, SynDB, SynOLEDB;

type
  TSQLDBConnectionPropertiesHelper = class helper for TSQLDBConnectionProperties
  private
    // Warning: This implementation is a slower version, use Ladder.Activity,LadderVarToSql InsertDocVariantData
    procedure InsertDocVariantData(TableName: String; pDocVariant: TDocVariantData);
  public
    procedure ResetFieldDefinitions;
  end;

implementation

uses
  Ladder.Utils, Variants, SysUtils, DateUtils;

{ TLadderSqlServerConnection }

procedure TSQLDBConnectionPropertiesHelper.InsertDocVariantData(
  TableName: String; pDocVariant: TDocVariantData);
var
  FieldNames: TRawUTF8DynArray;
  FieldTypes: TSQLDBFieldTypeArray;
  FieldValues: TRawUTF8DynArrayDynArray;
  FFieldCount: Integer;
  FFirstRow: PDocVariantData;

  procedure QuotePreviousValues(Col, CurrentRow: Integer);
  var
    Row: Integer;
  begin
    for Row := 0 to CurrentRow-1 do
    begin
      if FieldValues[Col, Row] <> 'null' then
        FieldValues[Col, Row]:= QuotedStr(FieldValues[Col, Row]);
    end;
  end;

  procedure SetType(Col, Row: Integer; pValue: PVAriant);
  var
    FFieldType: TSQLDBFieldType;
  begin
    if FieldTypes[Col] = ftUTF8 then Exit; // If it is a string it does not need to be changed

    FFieldType:= VariantVTypeToSQLDBFieldType(VarType(pValue^));

    if FFieldType <= ftNull then  // if current col FieldType is ftnull or ftUnknown does not need to change
      Exit;

    if FieldTypes[Col] <= ftNull then
    begin
      if (FFieldType = ftUTF8) and (LadderVarIsIso8601(pValue^)) then
        FieldTypes[Col]:= ftDate
      else
        FieldTypes[Col]:= FFieldType;

      Exit;
    end;

    if FFieldType = FieldTypes[Col] then
      Exit
    else if Ord(FFieldType) > Ord(FieldTypes[Col]) then
      FieldTypes[Col]:= FFieldType
    else // Ord(FFieldType) < Ord(FieldTypes[Col]
      if FieldTypes[Col] = ftDate then // if current column fieldtype is int, double or currency and prior fieldtype was date, must change to string
        FieldTypes[Col]:= ftUTF8;

    if FieldTypes[Col] = ftUtf8 then
      QuotePreviousValues(Col, Row);
  end;

  procedure SetFieldValue(Row, Col: Integer);
  var
    basicType: Integer;
    FVar: PVariant;
  begin
      FVar:= @pDocVariant._[Row].Values[Col];
      SetType(Col, Row, FVar);
      case FieldTypes[Col] of
        ftUnknown, ftNull: FieldValues[Col, Row] := 'null';
        ftUTF8: FieldValues[Col, Row]:= QuotedStr(VarToStr(FVar^));
      else
        FieldValues[Col, Row]:= VarToStr(FVar^);
      end;
  end;

var
  Col, Row: Integer;
  sStart, sFim: TDateTime;

const
  cBatchSize = 750; // Optimum performance
begin
  if pDocVariant.Count=0 then
    Exit;

  FFirstRow:= @TDocVariantData(pDocVariant.Values[0]);
  FFieldCount:= Length(FFirstRow^.Values);

  Assert(FFieldCount <= Length(FieldTypes),
    Format('TMySqlServerConnectionProperties.InsertDocVariantData: Maximum field count is %d.', [Length(FIeldTypes)]));

  SetLength(FieldNames,FFieldCount);
  for Col := 0 to FFieldCount-1 do
  begin
    FieldTypes[Col]:= ftNull;
    FieldNames[Col]:= FFirstRow^.Names[Col];
  end;

  SetLength(FieldValues, FFieldCount);
  for Col := 0 to FFieldCount-1 do
  begin
    SetLength(FieldValues[Col], pDocVariant.Count);
    for Row := 0 to pDocVariant.Count-1 do
      SetFieldValue(Row, Col);
  end;

  sStart:= now;
  MultipleValuesInsert(Self, TableName, FieldNames, FieldTypes, pDocVariant.Count, FieldValues);
  sFim:= now;
  Assert(False, IntToStr(MilliSecondsBetween(sStart, sFim)));
end;


procedure TSQLDBConnectionPropertiesHelper.ResetFieldDefinitions;
begin
  fSQLCreateField[ftUtf8]:= ' VARCHAR(max)';
  fSQLCreateField[ftDate]:= ' DATETIME2';
end;

end.
