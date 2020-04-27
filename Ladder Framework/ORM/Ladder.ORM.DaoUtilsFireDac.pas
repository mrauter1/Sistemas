unit Ladder.ORM.DaoUtils;

interface

uses
  AdoDB, Ladder.ORM.Functions, System.Contnrs, generics.collections, System.Classes, Data.DB, uDmConnection,
  FireDAC.Comp.Client, System.SysUtils;

type
  TDaoUtils = class
  private
    function CriaQuery(AOwner: TComponent = nil): TFDQuery;
  public
    Funcoes: TFuncoes;
    Connection: TDmConnection;

    constructor Create(pFuncoes: TFuncoes);

    function RetornaDataset(const pSql: String; AOwner: TComponent = nil): TDataSet;

    function ExecutaProcedure(const pSQL: String): Integer;

    function RetornaDouble(const pSQL: String; pValorDef: Double = 0): Double;
    function RetornaInteiro(const pSQL: String; pValorDef: Integer = 0): Integer;
    function RetornaDocVariant(const pSql: String): Variant;
    function RetornaJSon(const pSql: String): String;

    function GetUltimoID: Integer;

    // Popula o record com o primeiro registro retornado pelo banco
    function RetornaRecord(var Rec; TypeInfo: pointer; const pSql: String): Boolean;
    // Retorna um array populado com o retorno da query
    function RetornaArray(var pArray; TypeInfo: pointer; const pSql: String): Boolean;
    // Popula o objeto com o primeiro registro retornado pelo banco
    function RetornaObjeto(var ObjectInstance; const pSql: String): Boolean;

    // Popula um objectlist, cada registro retornado será um objeto na lista. TItemClass = Classe dos Itens do ObjectList
    // ATENÇÃO:: AS PROPRIEDADES DO OBJETO QUE DEVEM SER RETORNADAS TEM QUE ESTAR NA SEÇÃO PUBLISHED!!!
    function RetornaListaObjetos(var ObjectInstance: TObjectList; ItemClass: TClass; const pSql: String): Boolean; overload;
    function RetornaListaObjetos<T: class>(var ObjectList: TObjectList<T>; ItemClass: TClass; const pSql: String): Boolean; overload;
  end;

implementation

{ TDaoUtils }

function TDaoUtils.GetUltimoID: Integer;
begin
  Result:= RetornaInteiro(' SELECT SCOPE_IDENTITY() ');
end;

constructor TDaoUtils.Create(pFuncoes: TFuncoes);
begin
  inherited Create;

  Funcoes:= pFuncoes;
  Connection:= Funcoes.DmConnection;
end;

function TDaoUtils.CriaQuery(AOwner: TComponent = nil): TFDQuery;
begin
  Result:= Connection.CriaFDQuery('', AOwner);
end;

function TDaoUtils.ExecutaProcedure(const pSQL: String): Integer;
begin
  Result:= Connection.ExecutaComando(pSql);
end;

function TDaoUtils.RetornaDataset(const pSql: String; AOwner: TComponent = nil): TDataSet;
var
  fQuery: TFDQuery;
begin
  fQuery:= CriaQuery(AOwner);
  fQuery.SQL.Text:= pSql;
  fQuery.Open;
  Result:= fQuery;
end;

function TDaoUtils.RetornaDocVariant(const pSql: String): Variant;
begin
  Result:= Funcoes.RetornaDocVariant(pSql);
end;

function TDaoUtils.RetornaDouble(const pSQL: String;
  pValorDef: Double = 0): Double;
begin
  Result:= Connection.RetornaDouble(pSql, pValorDef);
end;

function TDaoUtils.RetornaInteiro(const pSQL: String;
  pValorDef: Integer = 0): Integer;
begin
  Result:= Connection.RetornaInteiro(pSql, pValorDef);
end;

function TDaoUtils.RetornaJSon(const pSql: String): String;
begin
  Result:= Funcoes.RetornaJSon(pSql);
end;

function TDaoUtils.RetornaListaObjetos(var ObjectInstance: TObjectList;
  ItemClass: TClass; const pSql: String): Boolean;
begin
  Result:= Funcoes.RetornaListaObjetos(ObjectInstance, ItemClass, pSql);
end;

function TDaoUtils.RetornaListaObjetos<T>(var ObjectList: TObjectList<T>;
  ItemClass: TClass; const pSql: String): Boolean;
begin
  Result:= Funcoes.RetornaListaObjetos<T>(ObjectList, ItemClass, pSql);
end;

function TDaoUtils.RetornaObjeto(var ObjectInstance;
  const pSql: String): Boolean;
begin
  Result:= Funcoes.RetornaObjeto(ObjectInstance, pSql);
end;

function TDaoUtils.RetornaRecord(var Rec; TypeInfo: pointer;
  const pSql: String): Boolean;
begin
  Result:= Funcoes.RetornaRecord(Rec, TypeInfo, pSql);
end;

function TDaoUtils.RetornaArray(var pArray; TypeInfo: pointer;
  const pSql: String): Boolean;
begin
  Result:= Funcoes.RetornaArray(pArray, TypeInfo, pSql);
end;

end.

