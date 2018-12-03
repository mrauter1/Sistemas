unit udmSqlUtils;

interface

uses
  {JSONConverter, dwsJson  }
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXFirebird,
  Data.FMTBcd, Datasnap.DBClient, Datasnap.Provider, Dialogs;

type
  TDmSqlUtils = class(TDataModule)
  private
    { Private declarations }
  protected
    FSqlConnection: TSQLConnection;
  public
    property SqlConnection: TSqlConnection read FSqlConnection write FSqlConnection;

    function CriaSqlQuery(sql: String = ''): TSqlQuery;
    function RetornaDataSet(sql: String): TDataSet;
    function OrdenaClientDataSet(parCds: TClientDataSet;
      const FieldName: String; PIndexOptions: TIndexOptions = []): Boolean;
    function RetornaValor(Sql: String; ValDefault: Variant): Variant;

//    procedure populateJSON(pJSon: TDwsJSONObject; const pSql: String);
//    function createJSON(const pSql: String): TDwsJSONArray;
  end;

var
  DmSqlUtils: TDmSqlUtils;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDmSqlUtils }
                                  {
procedure TDmSqlUtils.populateJSON(out pJSon: TDwsJSONObject; const pSql: String);
var
  FSql: TDataSet;
begin
  FSql:= RetornaDataSet(pSql);
  try
    TDataSetJSONConverter.UnMarshalToJSON(FSql, pJson);
  finally
    FSql.Free;
  end;
end;                                   }
                                    {
function TDmSqlUtils.createJSON(const pSql: String): TDwsJSONArray;
var
  FSql: TDataSet;
  FJSon: TdwsJSONArray;
begin
  FSql:= RetornaDataSet(pSql);
  try
    TDataSetJSONConverter.UnMarshalToJSON(FSql, FJson);
    Result:= FJSon;
  except
    FSql.Free;
    raise;
  end;
end;                 }

function TDmSqlUtils.CriaSqlQuery(sql: String = ''): TSqlQuery;
begin
  Result:= TSqlQuery.Create(Self);
  try
    Result.SQLConnection:= FSqlConnection;
    Result.SQL.Text:= sql;
  except
    Result.Free;
    raise;
  end;
end;

function TDmSqlUtils.RetornaDataSet(sql: String): TDataSet;
var
  fSqlQuery: TSqlQuery;
begin
  fSqlQuery:= CriaSqlQuery(sql);
  try
    fSqlQuery.Open;
  except
    fSqlQuery.Free;
    raise;
  end;

  Result:= fSqlQuery;
end;

function TDmSqlUtils.RetornaValor(Sql: String; ValDefault: Variant): Variant;
var
  FDataSet: TDataSet;
begin
  Result:= ValDefault;
  FDataSet:= RetornaDataSet(Sql);
  try
     Result:= FDataSet.Fields[0].AsVariant;
  finally
    FDataSet.Free;
  end;
end;

function TDmSqlUtils.OrdenaClientDataSet(parCds: TClientDataSet;
      const FieldName: String; PIndexOptions: TIndexOptions = []): Boolean;
const
  cIdx = 'idxx';
var
  I: Integer;
  Field: TField;
begin
  Result := False;
  Field := parCds.Fields.FindField(FieldName);
 //If invalid field name, exit.
  if Field = nil then Exit;
  if (Field is TObjectField) or (Field is TBlobField) or
    (Field is TAggregateField) or (Field is TVariantField)
     or (Field is TBinaryField) then Exit;
  //Get IndexDefs and IndexName using RTTI
  //Ensure IndexDefs is up-to-date
  parCds.IndexDefs.Update;
  for i := 0 to parCds.IndexDefs.Count - 1 do
  begin
    if parCds.IndexDefs[i].Name = cIdx then
      parCds.DeleteIndex(cIdx);
  end;

  parCds.AddIndex(cIdx, FieldName, pIndexOptions);

  //Set the index
  parCds.IndexName := cIdx;
  Result:= True;
  parCds.IndexDefs.Update;
end;

end.
