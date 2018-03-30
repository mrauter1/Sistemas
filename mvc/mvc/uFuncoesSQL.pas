unit uFuncoesSQL;

interface

uses
  sysutils, classes, uConexaoBase, DB, variants;


function VarToIntDef(vValue: Variant; Def: Integer): Integer;

type
  TFuncoesSQL = class (TComponent)
  private
    fConexao: TConexaoBase;
    fQuery: TDataSet;
  protected
    procedure ChecaConexao;
    procedure SetConexao(Value: TConexaoBase);
  public
    constructor Create(AOwner: TComponent); override;
//    procedure GetFieldList(List: TList; const FieldNames: WideString);
    function RetornaValor(SQL: String): Variant; overload;
    function RetornaValor(sql: string; Campos: string): Variant; overload;
    function RetornaValorDef(SQL: String; def: variant): Variant;
    //function RetornaValor(sql: string; Campos: string; def: Variant): Variant; overload;
    property Conexao: TConexaoBase read fConexao write SetConexao;
    function GeraChavePrimaria(Chave, Tabela: String): Integer;
    function TestaChaveUnica(Chave, NomeTabela: String; DataSet: TDataSet): Boolean;
  end;

var
  FuncoesSQL: TFuncoesSQL;
  
implementation

function VarToIntDef(vValue: Variant; Def: Integer): Integer;
begin
  Result:= StrToIntDef(VarToStrDef(vValue, '0'), 0);
end;

constructor TFuncoesSql.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TFuncoesSql.SetConexao(Value: TConexaoBase);
begin
  if fConexao = value then exit;

  if fQuery <> nil then
    FreeAndNil(fQuery);

  fConexao:= Value;
  if not (fConexao = nil) then
    fQuery:= Conexao.CriaDataSet(Self);
end;

function TFuncoesSql.RetornaValor(SQl: String): variant;
begin
  ChecaConexao;
  Conexao.SetSql(Sql, fQuery);
  fQuery.Open;
  try
    Result:= fQuery.fields[0].AsVariant;
  finally
    fQuery.Close;
  end;
end;


function TFuncoesSql.RetornaValor(sql: string; Campos: string): Variant;
begin
  ChecaConexao;
  Conexao.SetSql(Sql, fQuery);
  fQuery.Open;
  try
    Result:= fQuery.FieldValues[Campos];
  finally
    fQuery.Close;
  end;
end;

function TFuncoesSql.RetornaValorDef(sql: string; Def: Variant): Variant;
var
  ResultAux: Variant;
begin
  Result := RetornaValor(sql);
  ResultAux := Result;

  if VarIsNull(ResultAux) then
    Result := Def
  else
    Result := ResultAux;
end;
  {
function TFuncoesSql.RetornaValor(sql: string; Campos: string; Def: Variant): Variant;
var
  ResultAux: Variant;
begin
  Result := RetornaValor(sql, Campos);
  ResultAux := Result;

  if VarIsNull(ResultAux) then
    Result := Def
  else
    Result := ResultAux;
end;
    }
procedure TFuncoesSql.ChecaConexao;
begin
  if Conexao = nil then
    raise Exception.Create('Não há conexão definida!: '+Self.Name);
end;

function TFuncoesSql.GeraChavePrimaria(Chave, Tabela: String): Integer;
begin
  Result:= RetornaValorDef('Select max('+Chave+') from '+Tabela, 0) + 1;
end;

function TFuncoesSql.TestaChaveUnica(Chave, NomeTabela: String; DataSet: TDataSet): Boolean;
var
  Fields: TList;
  Field: TField;
  cvSQL: string;
  i: integer;
  procedure AddSQL(SQL: string);
  begin
    if cvSQL = '' then
      cvSQL := SQL
    else
      cvSQL := cvSQL + ' AND ' + SQL;
  end;
begin
  Result := True;
  cvSQL := '';
  if (Chave = '') or (NomeTabela = '') then
    Exit;

  if DataSet.State = dsEdit then exit;

  Fields := TList.Create;
  try
    DataSet.GetFieldList(Fields, Chave);
    for i := 0 to Fields.Count - 1 do
      begin
        Field:= TFIeld(Fields[i]);
        case Field.DataType of
          ftString, ftFixedChar, ftWideString, ftGUID:
            AddSQL(Field.FieldName + ' = ' + QuotedStr(Field.AsString));
          ftDate:
            AddSQL(Field.FieldName + ' = ' + QuotedStr(FormatDateTime('dd"."mm"."yyyy"', Field.AsDateTime)));
          ftSmallint, ftInteger, ftWord, ftAutoInc, ftBoolean, ftFloat, ftCurrency, ftBCD, ftLargeInt, ftFMTBcd:
            AddSQL(Field.FieldName + ' = ' + Field.AsString);
        else
          raise Exception.Create(Self.Name+'.TestaChaveUnica: ' + Field.FieldName +
            ' não é um tipo conhecido!');
        end;
      end;
      Result:= RetornaValorDef('SELECT count(*) FROM ' + NomeTabela + ' WHERE ' + cvSQL, 0) = 0;
  finally
    Fields.Free;
  end;
end;


end.
