unit UntDAOFactory;

interface

uses
  Data.DB, System.Contnrs, Generics.Collections, RTTI, UntDaoUtils, UntMensagem, UntQueryBuilder, uFrwUtils;

type
  IDaoBase = interface(IInvokable)
    function GetPorChave(FChave: Integer): TObject;

    function GetModeloBD: TModeloBD;

    procedure Insert(pObjeto: TObject);
    procedure Update(pObjeto: TObject);
    procedure Delete(pObjeto: TObject); overload;
    procedure Delete(ID: Integer); overload;
    function GetListWhere(const pWhere: String): TObjectList; overload;
    procedure GetListWhere(pList: TObjectList; const pWhere: String); overload;

    property ModeloBD: TModeloBD read GetModeloBD;
  end;

  IDaoGeneric<T: Class> = interface(IDaoBase)
    function GetModeloBD: TModeloBD;
    function GetPorChave(FChave: Integer): T;
    procedure Insert(pObjeto: T);
    procedure Update(pObjeto: T);
    procedure Delete(pObjeto: T); overload;
    procedure Delete(ID: Integer); overload;
    function GetListWhere(const pWhere: String): TFrwObjectList<T>; overload;
    procedure GetListWhere(pObjectList: TFrwObjectList<T>; const pWhere: String; pNewObjectFunction: TFuncNewObject = nil); overload;

    property ModeloBD: TModeloBD read GetModeloBD;
  end;

  TDaoBase = class(TInterfacedObject, IDaoBase)
  private
    fQueryBuilder: TQueryBuilderBase;
    fOwnsModelo: Boolean;
    fModeloBD: TModeloBD;
    procedure SetModeloBD(const Value: TModeloBD);
    procedure InicializaObjeto;
    procedure AtualizaValorChave(pObjeto: TObject);
  protected
    function GetModeloBD: TModeloBD; virtual;
  public
    property QueryBuilder: TQueryBuilderBase read fQueryBuilder write fQueryBuilder;
    property ModeloBD: TModeloBD read fModeloBD write SetModeloBD;

    constructor Create; overload;
    constructor Create(pModeloBD: TModeloBD; pOwnsModelo: Boolean = true); overload;
    constructor Create(pNomeTabela: String; pCampoChave: string; pItemClass: TClass); overload;
    destructor Destroy; override;

    function GetPorChave(FChave: Integer): TObject;

    procedure Insert(pObjeto: TObject); virtual;
    procedure Update(pObjeto: TObject); virtual;
    procedure Delete(pObjeto: TObject); overload; virtual;
    procedure Delete(ID: Integer); overload; virtual;

    function GetListWhere(const pWhere: String): TObjectList; overload;
    procedure GetListWhere(pList: TObjectList; const pWhere: String); overload;
    function GetGenericListWhere<T: Class>(const pWhere: String): TFrwObjectList<T>; overload;
    procedure GetGenericListWhere<T: Class>(pObjectList: TFrwObjectList<T>; const pWhere: String; pNewObjectFunction: TFuncNewObject = nil); overload;
  end;

  TDaoGeneric<T: class> = class(TDaoBase, IDaoGeneric<T>)
  private
//    fDaoBase: TDaoBase;
  public
    constructor Create; overload;
    constructor Create(pModeloBD: TModeloBD; pOwnsModelo: Boolean = true); overload;
    constructor Create(pNomeTabela: String; pCampoChave: string); overload;
    destructor Destroy; override;

    function GetPorChave(FChave: Integer): T; virtual;
    procedure Insert(pObjeto: T); reintroduce; virtual;
    procedure Update(pObjeto: T); reintroduce; virtual;
    procedure Delete(pObjeto: T); reintroduce; overload; virtual;
    procedure Delete(ID: Integer); reintroduce; overload; virtual;
    function GetListWhere(const pWhere: String): TFrwObjectList<T>; overload; virtual;
    procedure GetListWhere(pObjectList: TFrwObjectList<T>; const pWhere: String; pNewObjectFunction: TFuncNewObject = nil); overload; virtual;
  end;

  // Classe Dao sem nenhuma ação, não persiste ou busca informações,
  // Null Object Pattern: https://en.wikipedia.org/wiki/Null_Object_pattern
  TNullDao<T: Class> = class(TDaoGeneric<T>, IDaoGeneric<T>)
  private
    class var fModeloBDNulo: TModeloBD;
  public
    function GetModeloBD: TModeloBD; override;
    function GetPorChave(FChave: Integer): T; override;
    procedure Insert(pObjeto: T); override;
    procedure Update(pObjeto: T); override;
    procedure Delete(pObjeto: T); overload; override;
    procedure Delete(ID: Integer); overload; override;
    function GetListWhere(const pWhere: String): TFrwObjectList<T>; overload; override;
    procedure GetListWhere(pObjectList: TFrwObjectList<T>; const pWhere: String; pNewObjectFunction: TFuncNewObject = nil); overload; override;

    property ModeloBD: TModeloBD read GetModeloBD;
  end;


{  IDaoFactory = interface
    function NewDao(ModeloBD: TModeloBD): IDaoBase; overload;
    function NewDao<T>(TModeloBD: TModeloBD): TDaoGeneric<T>; overload;
    function NewQueryBuilder: TQueryBuilderBase;
  end;         }

  TDaoFactory = class(TObject)
  private
    // Não é singleton
  public
    function NewDao(ModeloBD: TModeloBD): TDaoBase; overload;
    function NewDao<T: class>(ModeloBD: TModeloBD): TDaoGeneric<T>; overload;
    function NewQueryBuilder: TQueryBuilderBase;
  end;

var
 // Singleton
  DaoFactory: TDaoFactory;

implementation

uses
  SysUtils, Classes, TypInfo, Controls;

{ TDaoBase }

procedure TDaoBase.InicializaObjeto;
begin
  fOwnsModelo:= False;
  fQueryBuilder:= DaoFactory.NewQueryBuilder;
end;

constructor TDaoBase.Create;
begin
  inherited;

  // raise error if DaoUtils is not assigned
  TDaoUtils.CheckAssigned;

  InicializaObjeto;
end;

constructor TDaoBase.Create(pModeloBD: TModeloBD; pOwnsModelo: Boolean = true);
begin
  Create;

  ModeloBD:= pModeloBD;
  fOwnsModelo:= pOwnsModelo;
end;

constructor TDaoBase.Create(pNomeTabela, pCampoChave: string;
  pItemClass: TClass);
begin
  Create;

  ModeloBD:= TModeloBD.Create(pNomeTabela, pCampoChave, pItemClass);

  fOwnsModelo:= True;
end;

destructor TDaoBase.Destroy;
begin
  if fOwnsModelo then
    if assigned(fModeloBD) then
      fModeloBD.Free;

  fQueryBuilder.Free;

  inherited;
end;

function TDaoBase.GetListWhere(const pWhere: String): TObjectList;
begin
  Result:= ModeloBD.ObjectListFromSql(QueryBuilder.SelectWhere(pWhere));
end;

procedure TDaoBase.GetListWhere(pList: TObjectList; const pWhere: String);
begin
  ModeloBD.PopulaObjectListFromSql(pList, QueryBuilder.SelectWhere(pWhere));
end;

function TDaoBase.GetModeloBD: TModeloBD;
begin
  Result:= fModeloBD;
end;

procedure TDaoBase.GetGenericListWhere<T>(pObjectList: TFrwObjectList<T>; const pWhere: String; pNewObjectFunction: TFuncNewObject = nil);
begin
  ModeloBD.PopulaObjectListFromSql<T>(pObjectList, QueryBuilder.SelectWhere(pWhere), pNewObjectFunction);
end;

function TDaoBase.GetGenericListWhere<T>(const pWhere: String): TFrwObjectList<T>;
begin
  Result:= ModeloBD.ObjectListFromSql<T>(QueryBuilder.SelectWhere(pWhere));
end;

function TDaoBase.GetPorChave(FChave: Integer): TObject;
begin
  Result:= ModeloBD.ObjectFromSql(QueryBuilder.SelectWhereChave(FChave));
end;

procedure TDaoBase.AtualizaValorChave(pObjeto: TObject);
var
  FValChave: Integer;
begin
  FValChave:= DaoUtils.RetornaInteiro(QueryBuilder.SelectValorUltimaChave);
  ModeloBD.SetValorChave(pObjeto, fValChave);
end;

procedure TDaoBase.Delete(pObjeto: TObject);
begin
  DaoUtils.ExecutaProcedure(QueryBuilder.Delete(ModeloBD.GetValorChave(pObjeto)));
end;

procedure TDaoBase.Delete(ID: Integer);
begin
  DaoUtils.ExecutaProcedure(QueryBuilder.Delete(ID));
end;

procedure TDaoBase.Insert(pObjeto: TObject);
begin
  DaoUtils.ExecutaProcedure(QueryBuilder.Insert((pObjeto)));

  if ModeloBD.ChaveIncremental then
    AtualizaValorChave(pObjeto);
end;

procedure TDaoBase.Update(pObjeto: TObject);
begin
  DaoUtils.ExecutaProcedure(QueryBuilder.Update(pObjeto));
end;

procedure TDaoBase.SetModeloBD(const Value: TModeloBD);
begin
  fModeloBD := Value;
  QueryBuilder.ModeloBD:= fModeloBD;
end;

{ TDaoFactory }

function TDaoFactory.NewDao(ModeloBD: TModeloBD): TDaoBase;
begin
  Result:= TDaoBase.Create(ModeloBD);
  Result.QueryBuilder:= NewQueryBuilder;
end;

function TDaoFactory.NewDao<T>(ModeloBD: TModeloBD): TDaoGeneric<T>;
var
  fQueryBuilder: TSqlServerQueryBuilder;
begin
  Result:= TDaoGeneric<T>.Create(ModeloBD);
  Result.QueryBuilder:= NewQueryBuilder;
end;

function TDaoFactory.NewQueryBuilder: TQueryBuilderBase;
begin
  Result:= TSqlServerQueryBuilder.Create;
end;

{ TDaoGeneric<T> }

constructor TDaoGeneric<T>.Create;
begin
  inherited;

//  fDaoBase:= TDaoBase.Create;
end;

constructor TDaoGeneric<T>.Create(pModeloBD: TModeloBD; pOwnsModelo: Boolean);
begin
  inherited Create(pModeloBD, pOwnsModelo);

//  fDaoBase:= TDaoBase.Create(pModeloBD, pOwnsModelo);
end;

constructor TDaoGeneric<T>.Create(pNomeTabela, pCampoChave: string);
begin
  inherited Create(pNomeTabela, pCampoChave, T);

//  fDaoBase:= TDaoBase.Create(pNomeTabela, pCampoChave, T);
end;

destructor TDaoGeneric<T>.Destroy;
begin
//  fDaoBase.Free;

  inherited;
end;

function TDaoGeneric<T>.GetListWhere(const pWhere: String): TFrwObjectList<T>;
begin
//  Result:= fDaoBase.GetGenericListWhere<T>(pWhere);
  Result:= inherited GetGenericListWhere<T>(pWhere);
end;

procedure TDaoGeneric<T>.GetListWhere(pObjectList: TFrwObjectList<T>;
  const pWhere: String; pNewObjectFunction: TFuncNewObject = nil);
begin
  inherited GetGenericListWhere<T>(pObjectList, pWhere, pNewObjectFunction);
end;

function TDaoGeneric<T>.GetPorChave(FChave: Integer): T;
begin
//  Result:= T(fDaoBase.GetPorChave(FChave));
  Result:= T(inherited GetPorChave(FChave));
end;

procedure TDaoGeneric<T>.Delete(pObjeto: T);
begin
  inherited Delete(pObjeto);
end;

procedure TDaoGeneric<T>.Delete(ID: Integer);
begin
  inherited Delete(ID);
end;

procedure TDaoGeneric<T>.Insert(pObjeto: T);
begin
//  Result:= fDaoBase.Insert(pObjeto);
  inherited Insert(pObjeto);
end;

procedure TDaoGeneric<T>.Update(pObjeto: T);
begin
//  Result:= fDaoBase.Update(pObjeto);
  inherited Update(pObjeto);
end;

{ TNullDao<T> }

procedure TNullDao<T>.Delete(ID: Integer);
begin
  // Não faz nada;
end;

procedure TNullDao<T>.Delete(pObjeto: T);
begin

end;

function TNullDao<T>.GetModeloBD: TModeloBD;
begin
  if not Assigned(fModeloBDNulo) then
    fModeloBDNulo.Create('Nulo', 'Nulo', TObject);

  Result:= fModeloBDNulo;
end;

function TNullDao<T>.GetPorChave(FChave: Integer): T;
begin
  // Não faz nada
end;

procedure TNullDao<T>.Insert(pObjeto: T);
begin
  // Não faz nada
end;

procedure TNullDao<T>.Update(pObjeto: T);
begin
  // Não faz nada
end;

function TNullDao<T>.GetListWhere(const pWhere: String): TFrwObjectList<T>;
begin
  Result:= TFrwObjectList<T>.Create;
end;

procedure TNullDao<T>.GetListWhere(pObjectList: TFrwObjectList<T>;
  const pWhere: String; pNewObjectFunction: TFuncNewObject = nil);
begin
  // Não faz nada
end;

initialization
  DaoFactory:= TDaoFactory.Create;

end.
