unit Ladder.ORM.SQLDBRowsDataSet;

interface

uses
  SynDB, Data.DB, SynCommons, SynTable, SysUtils, System.Classes;

type
  // Wrapper for a TDataSet to implement basic functionality of ISQLDBRows interface
  TSqlDBRowDataSet = class(TInterfacedObject, ISQLDBRows)
  private
    FDataSet: TDataSet;
  public
    property DataSet: TDataSet read FDataSet;
    constructor Create(pDataSet: TDataSet);
    function ColumnCount: integer;
    function ColumnName(Col: integer): RawUTF8;
    function ColumnIndex(const aColumnName: RawUTF8): integer;
    function ColumnType(Col: integer; FieldSize: PInteger=nil): TSQLDBFieldType;
    function ColumnNull(Col: integer): boolean;
    function ColumnInt(Col: integer): Int64; overload;
    function ColumnDouble(Col: integer): double; overload;
    function ColumnDateTime(Col: integer): TDateTime; overload;
    function ColumnCurrency(Col: integer): currency; overload;
    function ColumnUTF8(Col: integer): RawUTF8; overload;
    function ColumnString(Col: integer): string; overload;
    function ColumnVariant(Col: integer): Variant; overload;
    function ColumnToVariant(Col: integer; var Value: Variant): TSQLDBFieldType; overload;
    procedure ColumnBlobToStream(Col: integer; Stream: TStream); overload;
    procedure ColumnBlobFromStream(Col: integer; Stream: TStream); overload;

    function ColumnInt(const ColName: RawUTF8): Int64; overload;
    function ColumnDouble(const ColName: RawUTF8): double; overload;
    function ColumnDateTime(const ColName: RawUTF8): TDateTime; overload;
    function ColumnCurrency(const ColName: RawUTF8): currency; overload;
    function ColumnUTF8(const ColName: RawUTF8): RawUTF8; overload;
    function ColumnString(const ColName: RawUTF8): string; overload;
    function ColumnVariant(const ColName: RawUTF8): Variant; overload;
    function GetColumnVariant(const ColName: RawUTF8): Variant;
    procedure ColumnBlobToStream(const ColName: RawUTF8; Stream: TStream); overload;
    procedure ColumnBlobFromStream(const ColName: RawUTF8; Stream: TStream); overload;
    property Column[const ColName: RawUTF8]: Variant read GetColumnVariant; default;

    function Step(SeekFirst: boolean=false): boolean;
    procedure ReleaseRows;
    function ColumnTimestamp(Col: integer): TTimeLog; overload;
    function ColumnBlob(Col: integer): RawByteString; overload;
    function ColumnBlobBytes(Col: integer): TBytes; overload;
    procedure ColumnToSQLVar(Col: Integer; var Value: TSQLVar; var Temp: RawByteString);
    function ColumnCursor(Col: integer): ISQLDBRows; overload;
    function ColumnBlob(const ColName: RawUTF8): RawByteString; overload;
    function ColumnBlobBytes(const ColName: RawUTF8): TBytes; overload;
    function ColumnTimestamp(const ColName: RawUTF8): TTimeLog; overload;
    function ColumnCursor(const ColName: RawUTF8): ISQLDBRows; overload;
    function RowData: Variant;
    procedure RowDocVariant(out aDocument: variant; aOptions: TDocVariantOptions=JSON_OPTIONS_FAST);
    function Instance: TSQLDBStatement;
    function FetchAllAsJSON(Expanded: boolean; ReturnedRowCount: PPtrInt=nil): RawUTF8;
    function FetchAllToJSON(JSON: TStream; Expanded: boolean): PtrInt;
    function FetchAllToBinary(Dest: TStream; MaxRowCount: cardinal=0; DataRowPosition: PCardinalDynArray=nil): cardinal;
  end;


implementation

{ TSqlDBRowDataSet }

procedure RaiseNotImplementedError(pMessage: String = '');
begin
  raise Exception.Create(Format('Method not implemented. %s', [pMessage]));
end;

function TSqlDBRowDataSet.ColumnBlob(Col: integer): RawByteString;
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.ColumnBlob(const ColName: RawUTF8): RawByteString;
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.ColumnBlobBytes(Col: integer): TBytes;
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.ColumnBlobBytes(const ColName: RawUTF8): TBytes;
begin
  RaiseNotImplementedError;
end;

procedure TSqlDBRowDataSet.ColumnBlobFromStream(const ColName: RawUTF8;
  Stream: TStream);
begin
  RaiseNotImplementedError;
end;

procedure TSqlDBRowDataSet.ColumnBlobFromStream(Col: integer; Stream: TStream);
begin
  RaiseNotImplementedError;
end;

procedure TSqlDBRowDataSet.ColumnBlobToStream(Col: integer; Stream: TStream);
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.ColumnCount: integer;
begin
  Result:= FDataSet.Fields.Count;
end;

function TSqlDBRowDataSet.ColumnCurrency(const ColName: RawUTF8): currency;
begin
  Result:= FDataSet.FindField(ColName).AsCurrency;
end;

function TSqlDBRowDataSet.ColumnCurrency(Col: integer): currency;
begin
  Result:= FDataSet.Fields[Col].AsCurrency;
end;

function TSqlDBRowDataSet.ColumnCursor(Col: integer): ISQLDBRows;
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.ColumnCursor(const ColName: RawUTF8): ISQLDBRows;
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.ColumnDateTime(const ColName: RawUTF8): TDateTime;
begin
  Result:= FDataSet.FindField(ColName).AsDateTime;
end;

function TSqlDBRowDataSet.ColumnDateTime(Col: integer): TDateTime;
begin
  Result:= FDataSet.Fields[Col].AsDateTime;
end;

function TSqlDBRowDataSet.ColumnDouble(const ColName: RawUTF8): double;
begin
  Result:= FDataSet.FindField(ColName).AsFloat;
end;

function TSqlDBRowDataSet.ColumnDouble(Col: integer): double;
begin
  Result:= FDataSet.Fields[Col].AsFloat;
end;

function TSqlDBRowDataSet.ColumnIndex(const aColumnName: RawUTF8): integer;
begin
  Result:= FDataSet.FindField(aColumnName).Index;
end;

function TSqlDBRowDataSet.ColumnInt(const ColName: RawUTF8): Int64;
begin
  Result:= FDataSet.FindField(ColName).AsInteger;
end;

function TSqlDBRowDataSet.ColumnInt(Col: integer): Int64;
begin
  Result:= FDataSet.Fields[Col].AsInteger;
end;

function TSqlDBRowDataSet.ColumnName(Col: integer): RawUTF8;
begin
  Result:= FDataSet.Fields[Col].FieldName;
end;

function TSqlDBRowDataSet.ColumnNull(Col: integer): boolean;
begin
  Result:= FDataSet.Fields[Col].IsNull;
end;

function TSqlDBRowDataSet.ColumnString(const ColName: RawUTF8): string;
begin
  Result:= FDataSet.FindField(ColName).AsString;
end;

function TSqlDBRowDataSet.ColumnString(Col: integer): string;
begin
  Result:= FDataSet.Fields[Col].AsString;
end;

function TSqlDBRowDataSet.ColumnTimestamp(const ColName: RawUTF8): TTimeLog;
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.ColumnTimestamp(Col: integer): TTimeLog;
begin
  RaiseNotImplementedError;
end;

procedure TSqlDBRowDataSet.ColumnToSQLVar(Col: Integer; var Value: TSQLVar;
  var Temp: RawByteString);
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.ColumnToVariant(Col: integer; var Value: Variant): TSQLDBFieldType;
begin
  Value:= FDataSet.Fields[Col].AsVariant;
  Result:= ColumnType(Col);
end;

function TSqlDBRowDataSet.ColumnType(Col: integer;
  FieldSize: PInteger = nil): TSQLDBFieldType;
begin
  case FDataSet.Fields[Col].DataType of
    ftString, ftWideString, ftFixedChar, ftFixedWideChar: Result:= SynTable.ftUTF8;
    ftInteger, ftSmallint, ftLargeint, ftByte, ftWord, ftBoolean: Result:= SynTable.ftInt64;
    TFieldType.ftDate, ftDateTime: Result:= SynTable.ftDate;
    ftFloat, TFieldType.ftExtended, TFieldType.ftBCD: Result:= SynTable.ftDouble;
    TFieldType.ftCurrency: Result:= SynTable.ftCurrency;
  else
    Result:= SynTable.ftUnknown;
  end;
end;

function TSqlDBRowDataSet.ColumnUTF8(Col: integer): RawUTF8;
begin
  Result:= FDataSet.Fields[Col].AsString;
end;

function TSqlDBRowDataSet.ColumnUTF8(const ColName: RawUTF8): RawUTF8;
begin
  Result:= FDataSet.FindField(ColName).AsString;
end;

function TSqlDBRowDataSet.ColumnVariant(const ColName: RawUTF8): Variant;
begin
  Result:= FDataSet.FindField(ColName).AsVariant;
end;

constructor TSqlDBRowDataSet.Create(pDataSet: TDataSet);
begin
  inherited Create;
  FDataSet:= pDataSet;
end;

function TSqlDBRowDataSet.FetchAllAsJSON(Expanded: boolean;
  ReturnedRowCount: PPtrInt): RawUTF8;
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.FetchAllToBinary(Dest: TStream; MaxRowCount: cardinal;
  DataRowPosition: PCardinalDynArray): cardinal;
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.FetchAllToJSON(JSON: TStream;
  Expanded: boolean): PtrInt;
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.ColumnVariant(Col: integer): Variant;
begin
  Result:= FDataSet.Fields[Col].AsVariant;
end;

function TSqlDBRowDataSet.GetColumnVariant(const ColName: RawUTF8): Variant;
begin
  Result:= ColumnVariant(ColName);
end;

function TSqlDBRowDataSet.Instance: TSQLDBStatement;
begin
  RaiseNotImplementedError;
end;

procedure TSqlDBRowDataSet.ReleaseRows;
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.RowData: Variant;
begin
  RaiseNotImplementedError;
end;

procedure TSqlDBRowDataSet.RowDocVariant(out aDocument: variant;
  aOptions: TDocVariantOptions);
begin
  RaiseNotImplementedError;
end;

function TSqlDBRowDataSet.Step(SeekFirst: boolean): boolean;
begin
  RaiseNotImplementedError;
end;

procedure TSqlDBRowDataSet.ColumnBlobToStream(const ColName: RawUTF8;
  Stream: TStream);
begin
  RaiseNotImplementedError;
end;

end.
