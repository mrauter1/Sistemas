unit Ladder.ORM.Dao;

interface

uses
  Data.DB, System.Contnrs, Generics.Collections, RTTI, Ladder.ORM.DaoUtils, Ladder.Messages, Ladder.ORM.ModeloBD,
  Ladder.ORM.Classes, Ladder.ServiceLocator, Ladder.ORM.QueryBuilder, Spring.Reflection, SynDB;

type
  IDaoBase = interface;

  TChildDaoDefs = class
  private
    FProperty: TRttiMember;
    FChildFieldName: String;
    FMasterFieldName: String;

    FDao: IDaoBase;
    [unsafe]
    FDaoWeakRef: IDaoBase;

    [weak]
    FMasterDao: IDaoBase;

    function GetPropertyName: String;
    function GetDao: IDaoBase;
    function GetMasterDao: IDaoBase;
    procedure SetMasterDao(const Value: IDaoBase);
  public
    // if Dao is self referencing (IE.: is Child of itself) WeakReference must be set to true to avoid memory leak
    constructor Create(pMasterProperty: TRttiMember; pMasterFieldName: String; pChildFieldName: String; pDao: IDaoBase; pWeakReference: Boolean = False);
    destructor Destroy; override;
    property MasterProperty: TRttiMember read FProperty;
    property PropertyName: String read GetPropertyName;
    property MasterFieldName: String read FMasterFieldName write FMasterFieldName;
    property ChildFieldName: String read FChildFieldName write FChildFieldName;
    property Dao: IDaoBase read GetDao;
    property MasterDao: IDaoBase read GetMasterDao write SetMasterDao;

    function PropertyClass: TClass;
    function ItemClass: TClass;
    function ModeloBD: TModeloBD;

    function PropIsSingleObject: Boolean;
    function PropIsObjectList: Boolean;
    function PropIsGenericObjectList: Boolean;
    function GetMasterFieldValue(const pFieldName: String; Instance: TObject; MasterInstance: TObject = nil): Variant;
  end;

  IDaoBase = interface(IInvokable)
    function SelectKey(FChave: Integer): TObject;

    function GetQueryBuilder: TQueryBuilderBase;
    function GetModeloBD: TModeloBD;
    function GetNewObjectFunction: TFunNewObject;
    procedure SetNewObjectFunction(const Value: TFunNewObject);

    function ObjectExists(pObject: TObject): Boolean; // Check if object exists on database
    function KeyExists(ID: Integer): Boolean; // Check if object with ID exists on database

    procedure Insert(pObject: TObject; pMasterInstance: TObject = nil);
    function Update(pObject: TObject; pMasterInstance: TObject = nil): Boolean;
    procedure Save(pObject: TObject; pMasterInstance: TObject = nil);
    procedure SaveList(pObjectList: TObjectList; pMasterInstance: TObject = nil); overload;
    procedure SaveList(pObjectList: TObjectList<TObject>; pMasterInstance: TObject = nil); overload;

    function Delete(pObject: TObject; pMasterInstance: TObject = nil): Integer; overload; // Return the number of deleted rows
    function Delete(ID: Integer): Integer; overload; // Return the number of deleted rows

    function DeleteList(pObjectList: TObjectList; pMasterInstance: TObject = nil): Integer; overload; // Return the number of deleted rows
    function DeleteList(pObjectList: TObjectList<TObject>; pMasterInstance: TObject = nil): Integer; overload;

    function SelectOne(const pWhere: String): TObject; overload;
    procedure SelectOne(pObject: TObject; const pWhere: String); overload;

    function SelectWhere(const pWhere: String): TObjectList; overload;
    procedure SelectWhere(pList: TObjectList; const pWhere: String); overload;
    procedure SelectWhere(pObjectList: TObjectList<TObject>; const pWhere: String); overload;

    procedure InsertChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil);
    function UpdateChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil): Boolean;
    function DeleteChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil): Integer;

    procedure AddChildDao(pPropertyName: String; pMasterFieldName: String; pChildFieldName: String; pDao: IDaoBase);

    property ModeloBD: TModeloBD read GetModeloBD;
    property QueryBuilder: TQueryBuilderBase read GetQueryBuilder;
    property NewObjectFunction: TFunNewObject read GetNewObjectFunction write SetNewObjectFunction;
  end;

  IDaoGeneric<T: Class> = interface(IDaoBase)
    function GetModeloBD: TModeloBD;
    function SelectKey(FChave: Integer): T;

    function KeyExists(ID: Integer): Boolean; // Check if object with ID exists on database

    procedure Insert(pObject: T; pMasterInstance: TObject = nil);
    function Update(pObject: T; pMasterInstance: TObject = nil): Boolean;

    function Delete(pObject: T; pMasterInstance: TObject=nil): Integer; overload;
    function Delete(ID: Integer): Integer; overload;

    function SelectOne(const pWhere: String): T; overload;
    procedure SelectOne(pObject: T; const pWhere: String); overload;

    function SelectWhere(const pWhere: String): TFrwObjectList<T>; overload;
    procedure SelectWhere(pObjectList: TObjectList<T>; const pWhere: String); overload;

    property ModeloBD: TModeloBD read GetModeloBD;
  end;

  TDaoBase = class(TInterfacedObject, IDaoBase)
  private
    fQueryBuilder: TQueryBuilderBase;
    fOwnsModelo: Boolean;
    fModeloBD: TModeloBD;
    fChildDaoList: TObjectList<TChildDaoDefs>;
    procedure SetModeloBD(const Value: TModeloBD);
    procedure InicializaObjeto;
    procedure AtualizaValorChave(pObject: TObject);
    function GetFunPropertyChild(pChildDefs: TChildDaoDefs): TFunGetPropValue;
    function FindChildDefsByPropName(const pPropName: String): TChildDaoDefs;
    function FindChildDefsByClassName(const pClassName: String): TChildDaoDefs;
//    function GetFunChildField(pChildDefs: TChildDaoDefs): TFunGetFieldValue;
    procedure PopulateWhere(pList: TObjectList; const pWhere: String);
    function DeleteMissingChilds(pMasterInstance: TObject; ChildDefs: TChildDaoDefs): Integer;
    function SqlWhereChild(Instance: TObject; pChildDefs: TChildDaoDefs): String;
    function GetNewObjectFunction: TFunNewObject;
    procedure SetNewObjectFunction(const Value: TFunNewObject);
  protected
    function GetQueryBuilder: TQueryBuilderBase;
    function GetModeloBD: TModeloBD; virtual;
    function DaoUtils: TDaoUtils;
  public
    property QueryBuilder: TQueryBuilderBase read GetQueryBuilder write fQueryBuilder;
    property ModeloBD: TModeloBD read fModeloBD write SetModeloBD;
    property NewObjectFunction: TFunNewObject read GetNewObjectFunction write SetNewObjectFunction;

    constructor Create; overload;
    constructor Create(pModeloBD: TModeloBD; pOwnsModelo: Boolean = true); overload;
    constructor Create(pNomeTabela: String; pCampoChave: string; pItemClass: TClass); overload;
    destructor Destroy; override;

    function SelectKey(FChave: Integer): TObject;

    function ObjectExists(pObject: TObject): Boolean; // Check if object exists on database
    function KeyExists(ID: Integer): Boolean; virtual; // Check if object with ID exists on database

    procedure Insert(pObject: TObject; pMasterInstance: TObject = nil); virtual;
    function Update(pObject: TObject; pMasterInstance: TObject = nil): Boolean; virtual;

    procedure Save(pObject: TObject; pMasterInstance: TObject = nil); virtual;
    procedure SaveList(pObjectList: TObjectList; pMasterInstance: TObject = nil); overload; virtual;
    procedure SaveList(pObjectList: TObjectList<TObject>; pMasterInstance: TObject = nil); overload; virtual;

    function Delete(pObject: TObject; pMasterInstance: TObject = nil): Integer; overload; virtual;
    function Delete(ID: Integer): Integer; overload; virtual;

    function DeleteList(pObjectList: TObjectList; pMasterInstance: TObject = nil): Integer; overload; virtual;
    function DeleteList(pObjectList: TObjectList<TObject>; pMasterInstance: TObject = nil): Integer; overload; virtual;

    procedure InsertChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil); virtual;
    function UpdateChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil): Boolean; virtual;
    function DeleteChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil): Integer; overload; virtual;
    function DeleteChild(pMasterInstance: TObject; ChildDefs: TChildDaoDefs): Integer; overload; virtual;
    procedure SaveChild(pMasterInstance: TObject; ChildDefs: TChildDaoDefs); virtual;

    function SelectOne(const pWhere: String): TObject; overload;
    procedure SelectOne(pObject: TObject; const pWhere: String); overload;

    function SelectWhere(const pWhere: String): TObjectList; overload;
    procedure SelectWhere(pList: TObjectList; const pWhere: String); overload;
    procedure SelectWhere(pObjectList: TObjectList<TObject>; const pWhere: String); overload;

    function SelectWhere<T: Class>(const pWhere: String): TFrwObjectList<T>; overload;
    procedure SelectWhere<T: Class>(pObjectList: TObjectList<T>; const pWhere: String); overload;

    procedure AddChildDao(pPropertyName: String; pMasterFieldName: String; pChildFieldName: String; pDao: IDaoBase); virtual;
  end;

  TDaoGeneric<T: class> = class(TDaoBase, IDaoGeneric<T>)
  private
//    fDaoBase: TDaoBase;
  public
    constructor Create; overload;
    constructor Create(pModeloBD: TModeloBD; pOwnsModelo: Boolean = true); overload;
    constructor Create(pNomeTabela: String; pCampoChave: string); overload;
    destructor Destroy; override;

    function SelectKey(FChave: Integer): T; virtual;

    function KeyExists(ID: Integer): Boolean; reintroduce; virtual; // Check if object with ID exists on database

    procedure Insert(pObject: T; pMasterInstance: TObject = nil); reintroduce; virtual;
    function Update(pObject: T; pMasterInstance: TObject = nil): Boolean; reintroduce; virtual;

    function Delete(pObject: T; pMasterInstance: TObject=nil): Integer; reintroduce; overload; virtual;

    function SelectOne(const pWhere: String): T; reintroduce; overload; virtual;
    procedure SelectOne(pObject: T; const pWhere: String); reintroduce; overload; virtual;

    function SelectWhere(const pWhere: String): TFrwObjectList<T>; overload; virtual;
    procedure SelectWhere(pObjectList: TObjectList<T>; const pWhere: String); overload; virtual;
  end;

  // Classe Dao sem nenhuma ação, não persiste ou busca informações,
  // Null Object Pattern: https://en.wikipedia.org/wiki/Null_Object_pattern
{  TNullDao<T: Class> = class(TDaoGeneric<T>, IDaoGeneric<T>)
  private
    class var fModeloBDNulo: TModeloBD;
  public
    function GetModeloBD: TModeloBD; override;
    function SelectKey(FChave: Integer): T; override;
    function KeyExists(ID: Integer): Boolean; reintroduce; virtual; // Check if object with ID exists on database
    procedure Insert(pObject: T); override;
    function Update(pObject: T): Boolean; override;
    function Delete(pObject: T; pMasterInstance: TObject = nil): Integer; overload; override;
    function Delete(ID: Integer; pMasterInstance: TObject = nil): Integer; overload; override;
    function SelectWhere(const pWhere: String): TFrwObjectList<T>; overload; override;
    procedure SelectWhere(pObjectList: TObjectList<T>; const pWhere: String); overload; override;

    property ModeloBD: TModeloBD read GetModeloBD;
  end;}


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

function InheritFromGenericOfType(classType: TRttiType; const genericType: string): Boolean;

var
 // Singleton
  DaoFactory: TDaoFactory;

implementation

uses
  SysUtils, Classes, TypInfo, Controls, StrUtils, Variants;

{ TDaoChildDefinitions }

function InheritFromGenericOfType(classType: TRttiType; const genericType: string): Boolean;
var
  baseType: TRttiType;

  function GetGenericTypeDefinition(classType: TRttiType): String;
  begin
    if not classType.IsGenericType then
      Result:= ''
    else
      Result := Copy(classType.Name, 0, Pos('<', classType.Name)) + DupeString(',', High(classType.GetGenericArguments)) + '>';
  end;

begin
  if SameText(GetGenericTypeDefinition(ClassType), genericType)  then
    Result := True
  else
  begin
    baseType := classType.BaseType;
    Result := Assigned(baseType) and InheritFromGenericOfType(baseType, genericType);
  end;
end;

constructor TChildDaoDefs.Create(pMasterProperty: TRttiMember; pMasterFieldName,
  pChildFieldName: String; pDao: IDaoBase; pWeakReference: Boolean = False);
begin
  inherited Create;
  FProperty:= pMasterProperty;
  fMasterFieldName:= pMasterFieldName;
  FChildFieldName:= pChildFieldName;
  if pWeakReference then
    FDaoWeakRef:= pDao
  else
    FDao:= pDao;
end;

destructor TChildDaoDefs.Destroy;
begin

  inherited;
end;

function TChildDaoDefs.GetDao: IDaoBase;
begin
  if Assigned(FDaoWeakRef) then
    Result:= FDaoWeakRef
  else
    Result:= FDao;
end;

function TChildDaoDefs.GetMasterDao: IDaoBase;
begin
  Result:= FMasterDao;
end;

function TChildDaoDefs.GetMasterFieldValue(const pFieldName: String;
  Instance: TObject; MasterInstance: TObject = nil): Variant;
begin
  Assert(Assigned(MasterDao), 'TChildDaoDefs.GetMasterFieldValue: pChildDefs.MasterDao must be assigned.');
//    Assert(Assigned(pChildDefs.CurrentMaster), 'TDaoBase.GetFunPropertyChild: pChildDefs.CurrentMaster must be assigned.');
  if not Assigned(MasterInstance) then
    Result:= null
  else
    Result:= MasterDao.ModeloBD.GetFieldValue(MasterFieldName, MasterInstance);
end;

function TChildDaoDefs.GetPropertyName: String;
begin
  FProperty.Name;
end;

function TChildDaoDefs.ItemClass: TClass;
begin
  Result:= Dao.ModeloBD.ItemClass;
end;

function TChildDaoDefs.ModeloBD: TModeloBD;
begin
  Result:= Dao.ModeloBD;
end;

function TChildDaoDefs.PropertyClass: TClass;
begin
 Result:= TRttiInstanceType(GetPropertyRttiType(FProperty).AsInstance).MetaclassType;
end;

function TChildDaoDefs.PropIsGenericObjectList: Boolean;
begin
  Result:= InheritFromGenericOfType(TType.GetType(PropertyClass), 'TObjectList<>');
end;

function TChildDaoDefs.PropIsObjectList: Boolean;
begin
  Result:= (PropertyClass = TObjectList) or MasterProperty.InheritsFrom(TObjectList);
end;

function TChildDaoDefs.PropIsSingleObject: Boolean;
begin
  Result:= (PropertyClass = Dao.ModeloBD.ItemClass) or (Dao.ModeloBD.ItemClass.InheritsFrom(PropertyClass));
end;

procedure TChildDaoDefs.SetMasterDao(const Value: IDaoBase);
begin
  FMasterDao:= Value;
end;

{ TDaoBase }

procedure TDaoBase.InicializaObjeto;
begin
  fOwnsModelo:= False;
  fChildDaoList:= TObjectList<TChildDaoDefs>.Create(False); // DaoChilds must be checked to see if it is not recursive before freeing

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
var
  fChildDao: TChildDaoDefs;
begin
  if fOwnsModelo then
    if assigned(fModeloBD) then
      fModeloBD.Free;

  fQueryBuilder.Free;

  for fChildDao in fChildDaoList do
    if TObject(fChildDao.Dao) <> Self then  // do not free if child is self
      fChildDao.Free;

  fChildDaoList.Free;

  inherited;
end;

function TDaoBase.SelectWhere(const pWhere: String): TObjectList;
begin
  Result:= ModeloBD.ObjectListFromSql(QueryBuilder.SelectWhere(pWhere));
end;

procedure TDaoBase.SelectWhere(pList: TObjectList; const pWhere: String);
begin
  ModeloBD.PopulaObjectListFromSql(pList, QueryBuilder.SelectWhere(pWhere));
end;

function TDaoBase.GetModeloBD: TModeloBD;
begin
  Result:= fModeloBD;
end;

function TDaoBase.GetNewObjectFunction: TFunNewObject;
begin
  Result:= ModeloBD.NewObjectFunction;
end;

function TDaoBase.GetQueryBuilder: TQueryBuilderBase;
begin
  Result := fQueryBuilder;
end;

procedure TDaoBase.SelectWhere<T>(pObjectList: TObjectList<T>; const pWhere: String);
begin
  ModeloBD.PopulaObjectListFromSql<T>(pObjectList, QueryBuilder.SelectWhere(pWhere));
end;

function TDaoBase.SelectWhere<T>(const pWhere: String): TFrwObjectList<T>;
begin
  Result:= ModeloBD.ObjectListFromSql<T>(QueryBuilder.SelectWhere(pWhere));
end;

function TDaoBase.SelectKey(FChave: Integer): TObject;
begin
  Result:= ModeloBD.ObjectFromSql(QueryBuilder.SelectWhereChave(FChave));
end;

function TDaoBase.SelectOne(const pWhere: String): TObject;
begin
  Result:= ModeloBD.ObjectFromSql(QueryBuilder.SelectWhere(pWhere));
end;

procedure TDaoBase.SelectOne(pObject: TObject; const pWhere: String);
begin
  ModeloBD.ObjectFromSql(pObject, QueryBuilder.SelectWhere(pWhere));
end;

function TDaoBase.FindChildDefsByClassName(const pClassName: String): TChildDaoDefs;
var
  FChild: TChildDaoDefs;
begin
  for FChild in fChildDaoList do
    if SameText(fChild.ItemClass.ClassName, pClassName) then
    begin
      Result:= fChild;
      Exit;
    end;

  Result:= nil;
end;

function TDaoBase.FindChildDefsByPropName(const pPropName: String): TChildDaoDefs;
var
  FChild: TChildDaoDefs;
begin
  for FChild in fChildDaoList do
    if SameText(pPropName, fChild.PropertyName) then
    begin
      Result:= fChild;
      Exit;
    end;

  Result:= nil;
end;

function TDaoBase.SqlWhereChild(Instance: TObject; pChildDefs: TChildDaoDefs): String;
var
  FMasterFieldMapping: TFieldMapping;
begin
  FMasterFieldMapping:= ModeloBD.FieldMappingByFieldName(pChildDefs.MasterFieldName);

  Result:= Format('%s = %s', [pChildDefs.ChildFieldName,
                                 QueryBuilder.MapToSqlValue(FMasterFieldMapping, Instance)]);

end;

function TDaoBase.GetFunPropertyChild(pChildDefs: TChildDaoDefs): TFunGetPropValue;
begin
  Result:=
    function (const pPropName: String; pCurrentValue: TValue; Instance: TObject; pDBRows: ISqlDBRows): TValue
    var
      FCurrentObject: TObject;
      FWhere: String;

      procedure RaiseInvalidPropertyError;
      begin
        raise Exception.Create(Format('Property %s must be TObjectList, TObjectList<> or %s.', [pPropName, pChildDefs.ItemClass.ClassName]));
      end;

      function SelectObject(var pObject: TObject; pWhere: String): TObject;
      begin
        Result:= pObject;
        if not Assigned(pObject) then
          Result:= pChildDefs.Dao.SelectOne(pWhere)
        else
          pChildDefs.Dao.SelectOne(Result, pWhere);

      end;

      function SelectObjectList(var pObjectList: TObjectList; pWhere: String): TObjectList;
      begin
        if Assigned(pObjectList) then
        begin
          pChildDefs.Dao.SelectWhere(pObjectList, pWhere);
          Result:= pObjectList;
        end
        else begin
          Result:= TObjectList(CreateObjectOfClass(pChildDefs.PropertyClass));
          pChildDefs.Dao.SelectWhere(Result, pWhere);
        end;
      end;

      function SelectGenericObjectList(var pObjectList: TObjectList<TObject>; pWhere: String): TObjectList<TObject>;
      begin
        if Assigned(pObjectList) then
        begin
          pChildDefs.Dao.SelectWhere(pObjectList, pWhere);
          Result:= pObjectList;
        end
        else begin
          Result:= TObjectList<TObject>(CreateObjectOfClass(pChildDefs.PropertyClass));
          pChildDefs.Dao.SelectWhere(Result, pWhere);
        end;
      end;

    begin
      FCurrentObject:= pCurrentValue.AsObject;

      FWhere:= SqlWhereChild(Instance, pChildDefs);

      if (pChildDefs.PropertyClass = pChildDefs.ItemClass) or
        (pChildDefs.ItemClass.InheritsFrom(pChildDefs.PropertyClass)) then // Is a single Object that can be mapped to ItemClass
      begin
        Result:= TValue.From<TObject>(SelectObject(FCurrentObject, FWhere));
      end
      else if (pChildDefs.PropertyClass = TObjectList) or (pChildDefs.PropertyClass.InheritsFrom(TObjectList)) then // Is a TObjectList
      begin
        Result:= TValue.From<TObjectList>(SelectObjectList(TObjectList(FCurrentObject), FWhere));
      end
      else if InheritFromGenericOfType(TType.GetType(pChildDefs.PropertyClass), 'TObjectList<>') then //  Is a generic TObjectList<>
        Result:= TValue.From<TObjectList<TObject>>(SelectGenericObjectList(TObjectList<TObject>(FCurrentObject), FWhere))
      else
         RaiseInvalidPropertyError;

    end;
end;
                 {
function TDaoBase.GetFunChildField(pChildDefs: TChildDaoDefs): TFunGetFieldValue;
begin
  Result:=
    function (const pFieldName: String; Instance: TObject): Variant
    begin
//      Assert(Assigned(pChildDefs.CurrentMaster), 'TDaoBase.GetFunPropertyChild: pChildDefs.CurrentMaster must be assigned.');
      if not Assigned(pChildDefs.CurrentMaster) then
        Result:= null
      else
        Result:= ModeloBD.GetFieldValue(pChildDefs.MasterFieldName, pChildDefs.CurrentMaster);
    end;
end;            }

procedure TDaoBase.AddChildDao(pPropertyName, pMasterFieldName,
  pChildFieldName: String;  pDao: IDaoBase);
var
  FChildDefs: TChildDaoDefs;
  FMasterFieldMapping, FChieldFieldMapping: TFieldMapping;
  FFieldType: TFieldType;
  FProp: TRttiMember;

  procedure CheckPropType(pProp: TRttiMember);
  var
    FPropClass: TClass;

    procedure RaiseInvalidPropertyError;
    begin
      raise Exception.Create(Format('Property %s.%s must be TObjectList or %s.', [ModeloBD.Itemclass.ClassName, pPropertyName, pDao.ModeloBD.ItemClass.ClassName]));
    end;
  begin
    FPropClass:= TRttiInstanceType(GetPropertyRttiType(pProp).AsInstance).MetaclassType;
    if not Assigned(FProp) then
      raise Exception.Create(Format('TDaoBase.AddChildDao: Property %s.%s not found!', [ModeloBD.Itemclass.ClassName, pPropertyName]));

    // Child Property class must be of the same class of the ItemClass of the Child Dao or be a parent class to Item Class or...
    if (FPropClass = pDao.ModeloBD.ItemClass) or (pDao.ModeloBD.ItemClass.InheritsFrom(FPropClass)) then
      Exit //or it must be an TObjectList or TObjectList descendant or ...
    else if (FPropClass = TObjectList) or FPropClass.InheritsFrom(TObjectList) then
      Exit // or it must be a generic TObjectList<> or generic TObjectList<> descendant
    else if InheritFromGenericOfType(TType.GetType(FPropClass), 'TObjectList<>') then
      Exit
    else
      RaiseInvalidPropertyError;
  end;

begin
  FProp:= ModeloBD.GetPropByName(pPropertyName);

  if not Assigned(FProp) then
    raise Exception.Create(Format('TDaoBase.AddChildDao: Property %s.%s not found!', [ModeloBD.ItemClass.ClassName, pPropertyName]));

  CheckPropType(FProp);

  FMasterFieldMapping:= ModeloBD.FieldMappingByFieldName(pMasterFieldName);
  if not Assigned(FMasterFieldMapping) then
    raise Exception.Create(Format('TDaoBase.AddChildDao: Field %s must be a mapped field for class %s!', [pMasterFieldName, ModeloBD.ItemClass.ClassName]));

  FChieldFieldMapping:= ModeloBD.FieldMappingByFieldName(pChildFieldName);

  if Assigned(FChieldFieldMapping) then
    FFieldType:= FChieldFieldMapping.FieldType // if field is mapped on Child class use its fieldType, otherwise use the MasterField Fieldtype
  else
    FFieldType:= FMasterFieldMapping.FieldType;

  FChildDefs:= TChildDaoDefs.Create(FProp, pMasterFieldName, pChildFieldName, pDao, TObject(pDao) = Self);
  fChildDaoList.Add(FChildDefs);
  FChildDefs.MasterDao:= Self;

  ModeloBD.MapProperty(pPropertyName, GetFunPropertyChild(FChildDefs));
  pDao.ModeloBD.MapField(pChildFieldName, FFieldType, FChildDefs.GetMasterFieldValue);
end;

procedure TDaoBase.AtualizaValorChave(pObject: TObject);
var
  FValChave: Integer;
begin
  FValChave:= DaoUtils.SelectInt(QueryBuilder.SelectValorUltimaChave);
  ModeloBD.SetKeyValue(pObject, fValChave);
end;

function TDaoBase.Delete(pObject: TObject; pMasterInstance: TObject = nil): Integer;
var
  FChildDaoDef: TChildDaoDefs;
begin
  Result:= DaoUtils.ExecuteNoResult(QueryBuilder.Delete(pObject, pMasterInstance));
//  DaoUtils.ExecutaProcedure(QueryBuilder.Delete(ModeloBD.GetKeyValue(pObject)));

  for FChildDaoDef in fChildDaoList do
  begin
    DeleteChild(pObject, FChildDaoDef);
    DeleteMissingChilds(pObject, FChildDaoDef); // Delete even the childs that are not currently assigned
  end;
end;

function TDaoBase.Delete(ID: Integer): Integer;
begin
  Result:= DaoUtils.ExecuteNoResult(QueryBuilder.Delete(ID));
end;

function TDaoBase.DaoUtils: TDaoUtils;
begin
  Result:= TFrwServiceLocator.Context.DaoUtils;
end;

function TDaoBase.DeleteChild(pMasterInstance: TObject; ChildDefs: TChildDaoDefs): Integer;
var
  FObject: TObject;
begin
  FObject:= ChildDefs.MasterProperty.GetValue(pMasterInstance).AsObject;

  if not Assigned(FObject) then
    Exit;

  if ChildDefs.PropIsObjectList then
    Result:= ChildDefs.Dao.DeleteList(TObjectList(FObject))
  else if ChildDefs.PropIsGenericObjectList then
    Result:= ChildDefs.Dao.DeleteList(TObjectList<TObject>(FObject))
  else
    Result:= ChildDefs.Dao.Delete(FObject);
end;

function TDaoBase.DeleteList(pObjectList: TObjectList; pMasterInstance: TObject = nil): Integer;
var
  I: Integer;
begin
  Result:= 0;
  for I := 0 to pObjectList.Count-1 do
    Result:= Result+Delete(pObjectList[I]);
end;

function TDaoBase.DeleteList(pObjectList: TObjectList<TObject>; pMasterInstance: TObject = nil): Integer;
var
  FObject: TObject;
begin
  Result:= 0;
  for FObject in pObjectList do
    Result:= Result+Delete(FObject, pMasterInstance);
end;

function TDaoBase.DeleteMissingChilds(pMasterInstance: TObject; ChildDefs: TChildDaoDefs): Integer;

  procedure AddKey(pChildObject: TObject; var pSql: String);
  begin
    if pSql <> '' then
      pSql:= pSql+', ';

    pSql:= pSql+ChildDefs.Dao.QueryBuilder.FieldToSqlValue(ChildDefs.ModeloBD.NomeCampoChave, pChildObject);
  end;

  function GetKeyList(pList: TObjectList): String;
  var
    I: Integer;
  begin
    Result:= '';
    for I := 0 to pList.Count-1 do
      AddKey(pList[I], Result);
  end;

  function GetGenericKeyList(pList: TObjectList<TObject>): String;
  var
    FObject: TObject;
  begin
    Result:= '';
    for FObject in pList do
      AddKey(FObject, Result);
  end;

  function GetObjectKeyList(pObject: TObject): String;
  begin
    if Assigned(pObject) then
      AddKey(pObject, Result);
  end;

var
  FObject: TObject;
  FSqlKeys: String;
  FDeleteWhere: String;
  FChildList: TObjectList;
  I: Integer;
begin
  FObject:= ChildDefs.MasterProperty.GetValue(pMasterInstance).AsObject;

  if not Assigned(FObject) then
    FSqlKeys:= ''
  else if ChildDefs.PropIsObjectList then
    FSqlKeys:= GetKeyList(TObjectList(FObject))
  else if ChildDefs.PropIsGenericObjectList then
    FSqlKeys:= GetGenericKeyList(TObjectList<TObject>(FObject))
  else
    FSqlKeys:= GetObjectKeyList(FObject);

  FDeleteWhere:= SqlWhereChild(pMasterInstance, ChildDefs);
  if FSqlKeys <> '' then
    FDeleteWhere := FDeleteWhere + Format(' AND %s NOT IN (%s) ', [ChildDefs.Dao.ModeloBD.NomeCampoChave, FSqlKeys]);

  Result:= 0;
  FChildList:= ChildDefs.Dao.SelectWhere(FDeleteWhere);
  for I := 0 to FChildList.Count - 1 do
    Result:= Result+DeleteChild(pMasterInstance, FChildList[I], ChildDefs);

end;

function TDaoBase.DeleteChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil): Integer;
begin
  if not Assigned(ChildDefs) then
    ChildDefs:= FindChildDefsByClassName(pChild.ClassName);

  Result:= ChildDefs.Dao.Delete(pChild, pMaster);
end;

procedure TDaoBase.Insert(pObject: TObject; pMasterInstance: TObject = nil);
var
  FValChave: Integer;
  FChildDaoDef: TChildDaoDefs;
begin
  FValChave:= DaoUtils.SelectInt(QueryBuilder.Insert(pObject, pMasterInstance, True));

  if ModeloBD.ChaveIncremental then
    ModeloBD.SetKeyValue(pObject, FValChave);

  for FChildDaoDef in fChildDaoList do
    SaveChild(pObject, FChildDaoDef);

  //  AtualizaValorChave(pObject);
end;

function TDaoBase.Update(pObject: TObject; pMasterInstance: TObject = nil): Boolean;
var
  FChildDaoDef: TChildDaoDefs;
begin
  Result:= DaoUtils.ExecuteNoResult(QueryBuilder.Update(pObject, pMasterInstance)) > 0;

  for FChildDaoDef in fChildDaoList do
  begin
    if TUpdateOption.DeleteMissingChilds in ModeloBD.UpdateOptions then
      DeleteMissingChilds(pObject, FChildDaoDef); // Delete the Childs that do not belong to this object anymore

    SaveChild(pObject, FChildDaoDef); // Insert or update the Childs that are assigned
  end;
end;

procedure TDaoBase.InsertChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil);
begin
  if not Assigned(ChildDefs) then
    ChildDefs:= FindChildDefsByClassName(pChild.ClassName);

  Assert(Assigned(ChildDefs), Format('TDaoBase.InsertChild: ChildDefs of class %s not found for class %s.', [pChild.ClassName, pMaster.ClassName]));

  ChildDefs.Dao.Insert(pChild, pMaster);
end;

function TDaoBase.KeyExists(ID: Integer): Boolean;
begin
  Result:= DaoUtils.SelectInt(QueryBuilder.KeyExists(ID)) > 0;
end;

function TDaoBase.ObjectExists(pObject: TObject): Boolean;
begin
  Result:= DaoUtils.SelectInt(QueryBuilder.ObjectExists(pObject)) > 0;
end;

procedure TDaoBase.PopulateWhere(pList: TObjectList; const pWhere: String);
begin
  ModeloBD.PopulaObjectListFromSql(pList, QueryBuilder.SelectWhere(pWhere));
end;

function TDaoBase.UpdateChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil): Boolean;
begin
  if not Assigned(ChildDefs) then
    ChildDefs:= FindChildDefsByClassName(pChild.ClassName);

  Result:= ChildDefs.Dao.Update(pChild, pMaster);
end;

procedure TDaoBase.Save(pObject: TObject; pMasterInstance: TObject = nil);
begin
  if ObjectExists(pObject) then
    Update(pObject, pMasterInstance)
  else
    Insert(pObject, pMasterInstance);
end;

procedure TDaoBase.SaveChild(pMasterInstance: TObject;
  ChildDefs: TChildDaoDefs);
var
  FObject: TObject;
begin
  FObject:= ChildDefs.MasterProperty.GetValue(pMasterInstance).AsObject;

  if not Assigned(FObject) then
    Exit;

  if ChildDefs.PropIsObjectList then
    ChildDefs.Dao.SaveList(TObjectList(FObject), pMasterInstance)
  else if ChildDefs.PropIsGenericObjectList then
    ChildDefs.Dao.SaveList(TObjectList<TObject>(FObject), pMasterInstance)
  else
    ChildDefs.Dao.Save(FObject, pMasterInstance);
end;

procedure TDaoBase.SaveList(pObjectList: TObjectList; pMasterInstance: TObject = nil);
var
  I: Integer;
  FMaster: TObject;
begin
  for I := 0 to pObjectList.Count-1 do
    Save(pObjectList[I], pMasterInstance);
end;

procedure TDaoBase.SaveList(pObjectList: TObjectList<TObject>; pMasterInstance: TObject = nil);
var
  FObject: TObject;
  FMaster: TObject;
begin
  for FObject in pObjectList do
    Save(FObject, pMasterInstance);
end;

procedure TDaoBase.SetModeloBD(const Value: TModeloBD);
begin
  fModeloBD := Value;
  QueryBuilder.ModeloBD:= fModeloBD;
end;

procedure TDaoBase.SetNewObjectFunction(const Value: TFunNewObject);
begin
  ModeloBD.NewObjectFunction:= Value;
end;

procedure TDaoBase.SelectWhere(pObjectList: TObjectList<TObject>; const pWhere: String);
begin
  SelectWhere<TObject>(pObjectList, pWhere);
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

function TDaoGeneric<T>.SelectWhere(const pWhere: String): TFrwObjectList<T>;
begin
//  Result:= fDaoBase.GetGenericListWhere<T>(pWhere);
  Result:= inherited SelectWhere<T>(pWhere);
end;

procedure TDaoGeneric<T>.SelectWhere(pObjectList: TObjectList<T>; const pWhere: String);
begin
  inherited SelectWhere<T>(pObjectList, pWhere);
end;

function TDaoGeneric<T>.SelectKey(FChave: Integer): T;
begin
//  Result:= T(fDaoBase.SelectKey(FChave));
  Result:= T(inherited SelectKey(FChave));
end;

function TDaoGeneric<T>.SelectOne(const pWhere: String): T;
begin
  Result:= T(inherited SelectOne(pWhere));
end;

procedure TDaoGeneric<T>.SelectOne(pObject: T; const pWhere: String);
begin
  inherited SelectOne(pObject, pWhere);
end;

function TDaoGeneric<T>.Delete(pObject: T; pMasterInstance: TObject=nil): Integer;
begin
  Result:= inherited Delete(pObject, pMasterInstance);
end;

procedure TDaoGeneric<T>.Insert(pObject: T; pMasterInstance: TObject=nil);
begin
//  Result:= fDaoBase.Insert(pObject);
  inherited Insert(pObject, pMasterInstance);
end;

function TDaoGeneric<T>.KeyExists(ID: Integer): Boolean;
begin
  Result:= inherited KeyExists(ID);
end;

function TDaoGeneric<T>.Update(pObject: T; pMasterInstance: TObject=nil): Boolean;
begin
//  Result:= fDaoBase.Update(pObject);
  Result:= inherited Update(pObject, pMasterInstance);
end;

{ TNullDao<T> }
{
function TNullDao<T>.Delete(ID: Integer): Integer;
begin
  // Não faz nada;
end;

function TNullDao<T>.Delete(pObject: T): Integer;
begin

end;

function TNullDao<T>.GetModeloBD: TModeloBD;
begin
  if not Assigned(fModeloBDNulo) then
    fModeloBDNulo.Create('Nulo', 'Nulo', TObject);

  Result:= fModeloBDNulo;
end;

function TNullDao<T>.SelectKey(FChave: Integer): T;
begin
  // Não faz nada
end;

procedure TNullDao<T>.Insert(pObject: T);
begin
  // Não faz nada
end;

function TNullDao<T>.KeyExists(ID: Integer): Boolean;
begin
  Result:= False;
end;

function TNullDao<T>.Update(pObject: T): Boolean;
begin
  Result:= False;
  // Não faz nada
end;

function TNullDao<T>.SelectWhere(const pWhere: String): TFrwObjectList<T>;
begin
  Result:= TFrwObjectList<T>.Create;
end;

procedure TNullDao<T>.SelectWhere(pObjectList: TObjectList<T>; const pWhere: String);
begin
  // Não faz nada
end;}

initialization
  DaoFactory:= TDaoFactory.Create;

end.
