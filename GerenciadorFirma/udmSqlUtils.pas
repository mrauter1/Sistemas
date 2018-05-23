unit udmSqlUtils;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXFirebird,
  Data.FMTBcd, Datasnap.DBClient, Datasnap.Provider, Inifiles, Forms;

type
  TDmSqlUtils = class(TDataModule)
    SQLConnection: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function CriaSqlQuery(sql: String = ''): TSqlQuery;
    function RetornaDataSet(sql: String; pAbrirDataSet: Boolean = True): TDataSet;
    procedure ExecutaComando(pSql: String);
    function OrdenaClientDataSet(parCds: TClientDataSet;
      const FieldName: String; PIndexOptions: TIndexOptions = []): Boolean;
    function RetornaValor(Sql: String; ValDefault: Variant): Variant;
  end;

// Retorna um array com o nome dos campos que são diferentes entre um e outro dataset
function ComparaRecord(pDataSet1, pDataSet2: TDataSet; pCamposParaIgnorar: String = ''): TArray<String>;
procedure CopiarRecord(pSource, pDest: TDataSet);
procedure CopiaDadosDataSet(pSource, pDest: TDataSet);

var
  DmSqlUtils: TDmSqlUtils;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDmSqlUtils }

function ComparaRecord(pDataSet1, pDataSet2: TDataSet; pCamposParaIgnorar: String = ''): TArray<String>;
var
  I: Integer;
  FField1, FField2: TField;

  function CampoIgnorado(pCampo: String): Boolean;
  var
    I: Integer;
    fStr: String;
  begin
    Result:= True;

    for fStr in pCamposParaIgnorar.Split(';') do
      if Trim(fStr).ToUpper = pCampo.ToUpper then
        Exit;

    Result:= False;
  end;

begin
  SetLength(Result, 0);
  for FField1 in pDataSet1.Fields do
  begin
    if CampoIgnorado(FField1.FieldName) then
      Continue;

    FField2:= pDataSet2.FindField(FField1.FieldName);
    if Assigned(FField2) then
      if FField2.Value <> FField1.Value then
      begin
        SetLength(Result, Length(Result)+1);
        Result[High(Result)]:= FField1.FieldName;
      end;

  end;
end;

procedure CopiarRecord(pSource, pDest: TDataSet);
var
  I: Integer;
  FSourceField: TField;
begin
  for I := 0 to pDest.Fields.Count - 1 do
  begin
    FSourceField:= pSource.FindField(pDest.Fields[I].FieldName);
    if Assigned(FSourceField) then
      pDest.Fields[I].Value:= FSourceField.Value;

  end;
end;

procedure CopiaDadosDataSet(pSource, pDest: TDataSet);
begin
  pSource.First;
  while not pSource.Eof do
  begin
    pDest.Insert;
    CopiarRecord(pSource, pDest);
    pDest.Post;

    pSource.Next;
  end;
end;

function TDmSqlUtils.CriaSqlQuery(sql: String = ''): TSqlQuery;
begin
  Result:= TSqlQuery.Create(Self);
  try
    Result.SQLConnection:= SqlConnection;
    Result.SQL.Text:= sql;
  except
    Result.Free;
    raise;
  end;
end;

function TDmSqlUtils.RetornaDataSet(Sql: String; pAbrirDataSet: Boolean = True): TDataSet;
var
  fSqlQuery: TSqlQuery;
begin
  fSqlQuery:= CriaSqlQuery(Sql);
  try
    if pAbrirDataSet then
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

procedure TDmSqlUtils.ExecutaComando(pSql: String);
var
  FQry: TSqlQuery;
begin
  FQry:= CriaSqlQuery(pSql);
  try
    FQry.ExecSQL(True);
  finally
    FQry.Free;
  end;
end;

procedure TDmSqlUtils.DataModuleCreate(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'Banco.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Banco.Ini');
      SqlConnection.Params.Values['Database'] :=
          ArqIni.ReadString('Banco', 'Dir', 'C:\Sidicom.new\Dados\Banco.fdb');
      ArqIni.Free;
    end
  else
    SqlConnection.Params.Values['Database']:= 'C:\Sidicom.new\Dados\Banco.fdb';

  SQLConnection.Open;
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
