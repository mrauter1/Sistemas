unit Ladder.ORM.Dao;

interface

uses
  Data.DB, System.Contnrs, Generics.Collections, RTTI, Ladder.ORM.DaoUtils, Ladder.Messages, Ladder.ORM.ModeloBD,
  Ladder.ORM.Classes, Ladder.ServiceLocator, Ladder.ORM.QueryBuilder;

type
  IDaoBase = interface;

  TDaoChildDefs = class
  private
    FPropertyName: String;
    FChildFieldName: String;
    FMasterFieldName: String;
    [unsafe]
    FDao: IDaoBase;
  public
    constructor Create(pPropertyName: String; pMasterFieldName: String; pChildFieldName: String; pDao: IDaoBase);
    property PropertyName: String read FPropertyName write FPropertyName;
    property MasterFieldName: String read FMasterFieldName write FMasterFieldName;
    property ChildFieldName: String read FChildFieldName write FChildFieldName;
    property Dao: IDaoBase read FDao write FDao;
  end;

  IDaoBase = interface(IInvokable)
    function GetPorChave(FChave: Integer): TObject;

    function GetModeloBD: TModeloBD;

    function KeyExists(ID: Integer): Boolean; // Check if object with ID exists on database

    procedure Insert(pObjeto: TObject);
    function Update(pObjeto: TObject): Boolean;
    procedure Delete(pObjeto: TObject); overload;
    procedure Delete(ID: Integer); overload;
    function GetListWhere(const pWhere: String): TObjectList; overload;
    procedure GetListWhere(pList: TObjectList; const pWhere: String); overload;

    procedure InsertChild(pMaster, pChild: TObject; ChildDefs: TDaoChildDefs = nil);
    function UpdateChild(pMaster, pChild: TObject; ChildDefs: TDaoChildDefs = nil): Boolean;
    procedure DeleteChild(pMaster, pChild: TObject; ChildDefs: TDaoChildDefs = nil);

    property ModeloBD: TModeloBD read GetModeloBD;
  end;

  IDaoGeneric<T: Class> = interface(IDaoBase)
    function GetModeloBD: TModeloBD;
    function GetPorChave(FChave: Integer): T;

    function KeyExists(ID: Integer): Boolean; // Check if object with ID exists on database

    procedure Insert(pObjeto: T);
    function Update(pObjeto: T): Boolean;

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
    FCurrentObject: TObject;
    fChildDaoList: TObjectList<TDaoChildDefs>;
    procedure SetModeloBD(const Value: TModeloBD);
    procedure InicializaObjeto;
    procedure AtualizaValorChave(pObjeto: TObject);
    procedure Save(pObjeto: TObject);
    function GetFunPropertyChild(pChildDefs: TDaoChildDefs): TFunGetPropValue;
    function FindChildDefsByPropName(const pPropName: String): TDaoChildDefs;
    function FindChildDefsByClassName(const pClassName: String): TDaoChildDefs;
    function GetFunChildField(pChildDefs: TDaoChildDefs): TFunGetFieldValue;
  protected
    function GetModeloBD: TModeloBD; virtual;
    function DaoUtils: TDaoUtils;
  public
    property QueryBuilder: TQueryBuilderBase read fQueryBuilder write fQueryBuilder;
    property ModeloBD: TModeloBD read fModeloBD write SetModeloBD;

    constructor Create; overload;
    constructor Create(pModeloBD: TModeloBD; pOwnsModelo: Boolean = true); overload;
    constructor Create(pNomeTabela: String; pCampoChave: string; pItemClass: TClass); overload;
    destructor Destroy; override;

    function GetPorChave(FChave: Integer): TObject;

    function KeyExists(ID: Integer): Boolean; virtual; // Check if object with ID exists on database

    procedure Insert(pObjeto: TObject); virtual;
    function Update(pObjeto: TObject): Boolean; virtual;
    procedure Delete(pObjeto: TObject); overload; virtual;
    procedure Delete(ID: Integer); overload; virtual;

    procedure InsertChild(pMaster, pChild: TObject; ChildDefs: TDaoChildDefs = nil); virtual;
    function UpdateChild(pMaster, pChild: TObject; ChildDefs: TDaoChildDefs = nil): Boolean; virtual;
    procedure DeleteChild(pMaster, pChild: TObject; ChildDefs: TDaoChildDefs = nil); virtual;

    procedure AddChildDao(pPropertyName: String; pMasterFieldName: String; pChildFieldName: String; pDao: IDaoBase); virtual;

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

    function KeyExists(ID: Integer): Boolean; reintroduce; virtual; // Check if object with ID exists on database

    procedure Insert(pObjeto: T); reintroduce; virtual;
    function Update(pObjeto: T): Boolean; reintroduce; virtual;

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
    function KeyExists(ID: Integer): Boolean; reintroduce; virtual; // Check if object with ID exists on database
    procedure Insert(pObjeto: T); override;
    function Update(pObjeto: T): Boolean; override;
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
    function NewQueryBuilder(ModeloBD: TModeloBD): TQueryBuilderBase;
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
  fChildDaoList:= TObjectList<TDaoChildDefs>.Create(True);

  fQueryBuilder:= DaoFactory.NewQueryBuilder(nil);
end;

constructor TDaoBase.Create;
begin
  inherited;

  // raise error if DaoUtils is not assigned
//  TDaoUtils.CheckAssigned;
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

  fChildDaoList.Free;

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

function TDaoBase.FindChildDefsByClassName(const pClassName: String): TDaoChildDefs;
var
  FChild: TDaoChildDefs;
begin
  for FChild in fChildDaoList do
    if SameText(fChild.Dao.ModeloBD.ItemClass.ClassName, pClassName) then
    begin
      Result:= fChild;
      Exit;
    end;

  Result:= nil;
end;

function TDaoBase.FindChildDefsByPropName(const pPropName: String): TDaoChildDefs;
var
  FChild: TDaoChildDefs;
begin
  for FChild in fChildDaoList do
    if SameText(pPropName, fChild.PropertyName) then
    begin
      Result:= fChild;
      Exit;
    end;

  Result:= nil;
end;

function TDaoBase.GetFunPropertyChild(pChildDefs: TDaoChildDefs): TFunGetPropValue;
begin
  Result:=
    function (const pPropName: String; pCurrentValue: TValue): TValue
    var
      FMasterFieldMapping: TFieldMapping;
    begin
      Assert(Assigned(FCurrentObject), 'TDaoBase.GetFunPropertyChild: CurrentObject must be assigned.');

      if pCurrentValue.IsObject then
        pCurrentValue.AsObject.Free;

      FMasterFieldMapping:= ModeloBD.FieldMappingByFieldName(pChildDefs.MasterFieldName);

      Result:= pChildDefs.Dao.GetListWhere(Format('%s = %s', [pChildDefs.ChildFieldName,
                                    QueryBuilder.MapToSqlValue(FMasterFieldMapping, FCurrentObject)]));
    end;

end;

function TDaoBase.GetFunChildField(pChildDefs: TDaoChildDefs): TFunGetFieldValue;
begin
  Result:=
    function (const pFieldName: String): Variant
    begin
      Assert(Assigned(FCurrentObject), 'TDaoBase.GetFunPropertyChild: CurrentObject must be assigned.');

      Result:= ModeloBD.GetPropByName(pChildDefs.PropertyName).GetValue(FCurrentObject).AsVariant;
    end;
end;

procedure TDaoBase.AddChildDao(pPropertyName, pMasterFieldName,
  pChildFieldName: String;  pDao: IDaoBase);
var
  FChildDefs: TDaoChildDefs;
  FMasterFieldMapping, FChieldFieldMapping: TFieldMapping;
  FFieldType: TFieldType;
  FProp: TRttiProperty;
  F: TFunGetPropValue;
begin
  FProp:= ModeloBD.GetPropByName(pPropertyName);

  if Assigned(FProp) then
    raise Exception.Create(Format('TDaoBase.AddChildDao: Property %s not found!', [pPropertyName]));

  FMasterFieldMapping:= ModeloBD.FieldMappingByFieldName(pMasterFieldName);
  if not Assigned(FMasterFieldMapping) then
    raise Exception.Create(Format('TDaoBase.AddChildDao: Field %s not mapped for master class %s!', [pMasterFieldName, ModeloBD.ItemClass.ClassName]));

  FChieldFieldMapping:= ModeloBD.FieldMappingByFieldName(pMasterFieldName);

  if Assigned(FChieldFieldMapping) then
    FFieldType:= FChieldFieldMapping.FieldType // if field is mapped on Child class use its fieldType, otherwise use the MasterField Fieldtype
  else
    FFieldType:= FMasterFieldMapping.FieldType;

  FChildDefs:= TDaoChildDefs.Create(pPropertyName, pMasterFieldName, pChildFieldName, pDao);

  fChildDaoList.Add(FChildDefs);

  ModeloBD.MapProperty(pPropertyName, GetFunPropertyChild(FChildDefs));
  pDao.ModeloBD.MapField(pChildFieldName, FFieldType, GetFunChildField(FChildDefs));
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

function TDaoBase.DaoUtils: TDaoUtils;
begin
  Result:= TFrwServiceLocator.Context.DaoUtils;
end;

procedure TDaoBase.Delete(ID: Integer);
begin
  DaoUtils.ExecutaProcedure(QueryBuilder.Delete(ID));
end;

procedure TDaoBase.DeleteChild(pMaster, pChild: TObject; ChildDefs: TDaoChildDefs = nil);
var
  FChildDef: TDaoChildDefs;
begin
  FChildDef:= FChildDef;

  if not Assigned(FChildDef) then
    FChildDef:= FindChildDefsByClassName(pChild.ClassName);

  FCurrentObject:= pMaster;
  try
    FChildDef.Dao.Delete(pChild);
  finally
    FCurrentObject:= nil;
  end;
end;

procedure TDaoBase.Insert(pObjeto: TObject);
var
  FValChave: Integer;
begin
  FValChave:= DaoUtils.RetornaInteiro(QueryBuilder.Insert(pObjeto, True));

  if ModeloBD.ChaveIncremental then
    ModeloBD.SetValorChave(pObjeto, FValChave);

  //  AtualizaValorChave(pObjeto);
end;

procedure TDaoBase.InsertChild(pMaster, pChild: TObject; ChildDefs: TDaoChildDefs = nil);
var
  FChildDef: TDaoChildDefs;
begin
  FChildDef:= FChildDef;

  if not Assigned(FChildDef) then
    FChildDef:= FindChildDefsByClassName(pChild.ClassName);

  FCurrentObject:= pMaster;
  try
    FChildDef.Dao.Update(pChild);
  finally
    FCurrentObject:= nil;
  end;
end;

function TDaoBase.KeyExists(ID: Integer): Boolean;
begin
  Result:= DaoUtils.RetornaInteiro(QueryBuilder.KeyExists(ID)) > 0;
end;

function TDaoBase.Update(pObjeto: TObject): Boolean;
begin
  Result:= DaoUtils.ExecutaProcedure(QueryBuilder.Update(pObjeto)) > 0;
end;

function TDaoBase.UpdateChild(pMaster, pChild: TObject; ChildDefs: TDaoChildDefs = nil): Boolean;
var
  FChildDef: TDaoChildDefs;
begin
  FChildDef:= FChildDef;

  if not Assigned(FChildDef) then
    FChildDef:= FindChildDefsByClassName(pChild.ClassName);

  FCurrentObject:= pMaster;
  try
    FChildDef.Dao.Update(pChild);
  finally
    FCurrentObject:= nil;
  end;
end;

procedure TDaoBase.Save(pObjeto: TObject);
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
  Result.QueryBuilder:= NewQueryBuilder(ModeloBD);
end;

function TDaoFactory.NewDao<T>(ModeloBD: TModeloBD): TDaoGeneric<T>;
var
  fQueryBuilder: TSqlServerQueryBuilder;
begin
  Result:= TDaoGeneric<T>.Create(ModeloBD);
  Result.QueryBuilder:= NewQueryBuilder(ModeloBD);
end;

function TDaoFactory.NewQueryBuilder(ModeloBD: TModeloBD): TQueryBuilderBase;
begin
  Result:= TSqlServerQueryBuilder.Create(ModeloBD);
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

function TDaoGeneric<T>.KeyExists(ID: Integer): Boolean;
begin
  Result:= inherited KeyExists(ID);
end;

function TDaoGeneric<T>.Update(pObjeto: T): Boolean;
begin
//  Result:= fDaoBase.Update(pObjeto);
  Result:= inherited Update(pObjeto);
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

function TNullDao<T>.KeyExists(ID: Integer): Boolean;
begin
  Result:= False;
end;

function TNullDao<T>.Update(pObjeto: T): Boolean;
begin
  Result:= False;
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

{ TDaoChildDefinitions }

constructor TDaoChildDefs.Create(pPropertyName, pMasterFieldName,
  pChildFieldName: String; pDao: IDaoBase);
begin
  inherited Create;
  FPropertyName:= pPropertyName;
  fMasterFieldName:= pMasterFieldName;
  FChildFieldName:= pChildFieldName;
  Dao:= pDao;
end;

initialization
  DaoFactory:= TDaoFactory.Create;

end.
