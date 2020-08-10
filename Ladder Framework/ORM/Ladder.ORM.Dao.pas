unit Ladder.ORM.Dao;

interface

uses
  Data.DB, System.Contnrs, Generics.Collections, RTTI, Ladder.ORM.DaoUtils, Ladder.Messages, Ladder.ORM.ModeloBD,
  Ladder.ORM.Classes, Ladder.ServiceLocator, Ladder.ORM.QueryBuilder, Spring.Reflection, SynDB, SynCommons;

type
  // If this function returns false, the object and its childs will no be inserted/updated.
  // If further operations should be aborted an exception should be thrown
  TOnCheckObjectIsValid = reference to function (pObject: TObject; pMasterInstance: TObject): Boolean;

  IDaoBase = interface;

  TChildDaoDefs = class
  private
    FMasterProperty: TRttiMember;
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
  protected
    property MasterProperty: TRttiMember read FMasterProperty;
  public
    // if Dao is self referencing (IE.: is Child of itself) WeakReference must be set to true to avoid memory leak
    constructor Create(pMasterProperty: TRttiMember; pMasterFieldName: String; pChildFieldName: String; pDao: IDaoBase; pWeakReference: Boolean = False);
    destructor Destroy; override;
    property PropertyName: String read GetPropertyName;
    property MasterFieldName: String read FMasterFieldName write FMasterFieldName;
    property ChildFieldName: String read FChildFieldName write FChildFieldName;
    property Dao: IDaoBase read GetDao;
    property MasterDao: IDaoBase read GetMasterDao write SetMasterDao;

    function PropertyClass: TClass; virtual;
    function ItemClass: TClass;
    function ModeloBD: TModeloBD;

    function PropIsSingleObject: Boolean; virtual;
    function PropIsObjectList: Boolean; virtual;
    function PropIsGenericObjectList: Boolean; virtual;
    function GetMasterFieldValue(const pFieldName: String; Instance: TObject; MasterInstance: TObject = nil): Variant;
    function GetChildObject(pMasterInstance: TObject): TObject; virtual;
  end;

  TCompositeChildDaoDefs = class(TChildDaoDefs)
  private
    PrivateObjectProperty: TObject;
  public
    // Key Field Name is the name of the
    constructor Create(AKeyFieldName: String; pDao: IDaoBase);
    function GetChildObject(pMasterInstance: TObject): TObject; override; // Returns Master Instance
  end;

  IDaoBase = interface(IInvokable)
    function GetQueryBuilder: TQueryBuilderBase;
    function GetModeloBD: TModeloBD;
    function GetNewObjectFunction: TFunNewObject;
    procedure SetNewObjectFunction(const Value: TFunNewObject);

    function ObjectExists(pObject: TObject): Boolean; // Check if object exists on database
    function KeyExists(ID: Integer): Boolean; // Check if object with ID exists on database

    procedure Insert(pObject: TObject; pMasterInstance: TObject = nil);
    function Update(pObject: TObject; pMasterInstance: TObject = nil): Boolean;
    function UpdateProperties(pObject: TObject; APropertyNames: String; pMasterInstance: TObject=nil): Boolean;

    procedure Save(pObject: TObject; pMasterInstance: TObject = nil);
    procedure SaveList(pObjectList: TObjectList; pMasterInstance: TObject = nil); overload;
    procedure SaveList(pObjectList: TObjectList<TObject>; pMasterInstance: TObject = nil); overload;

    function Delete(pObject: TObject; pMasterInstance: TObject = nil): Integer; overload; // Return the number of deleted rows
    function Delete(ID: Integer): Integer; overload; // Return the number of deleted rows

    function DeleteList(pObjectList: TObjectList; pMasterInstance: TObject = nil): Integer; overload; // Return the number of deleted rows
    function DeleteList(pObjectList: TObjectList<TObject>; pMasterInstance: TObject = nil): Integer; overload;

    function SelectKey(FChave: Integer): TObject; overload;
    procedure SelectKey(pObject: TObject; FChave: Integer); overload;

    function SelectOne(const pWhere: String): TObject; overload;
    procedure SelectOne(pObject: TObject; const pWhere: String); overload;

    function SelectWhere(const pWhere: String): TObjectList; overload;
    procedure SelectWhere(pList: TObjectList; const pWhere: String); overload;
    procedure SelectWhere(pObjectList: TObjectList<TObject>; const pWhere: String); overload;

    procedure InsertChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil);
    function UpdateChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil): Boolean;
    function DeleteChild(pMaster, pChild: TObject; ChildDefs: TChildDaoDefs = nil): Integer;

    function ChildDaoByPropName(pPropertyName: String): IDaoBase;
    procedure AddChildDao(pPropertyName: String; pMasterFieldName: String; pChildFieldName: String; pDao: IDaoBase);
    procedure AddCompositeDao(pDao: IDaoBase);

    procedure CreateTableAndFields; // Check if table and mapped fields exists on database and if not create them;

    property ModeloBD: TModeloBD read GetModeloBD;
    property QueryBuilder: TQueryBuilderBase read GetQueryBuilder;
    property NewObjectFunction: TFunNewObject read GetNewObjectFunction write SetNewObjectFunction;
  end;

  IDaoGeneric<T: Class> = interface(IDaoBase)
    function GetModeloBD: TModeloBD;

    procedure SelectKey(pObject: T; FChave: Integer); overload;
    function SelectKey(FChave: Integer): T; overload;

    function KeyExists(ID: Integer): Boolean; // Check if object with ID exists on database

    procedure Insert(pObject: T; pMasterInstance: TObject = nil);
    function Update(pObject: T; pMasterInstance: TObject = nil): Boolean;

    function Delete(pObject: T; pMasterInstance: TObject=nil): Integer; overload;
    function Delete(ID: Integer): Integer; overload;

    function SelectOne(const pWhere: String): T; overload;
    procedure SelectOne(pObject: T; const pWhere: String); overload;

    function SelectWhereG(const pWhere: String): TObjectList<T>; overload;
    procedure SelectWhere(pObjectList: TObjectList<T>; const pWhere: String); overload;

    property ModeloBD: TModeloBD read GetModeloBD;
  end;

  TDaoBase = class(TInterfacedObject, IDaoBase)
  private
    fQueryBuilder: TQueryBuilderBase;
    fOwnsModelo: Boolean;
    fModeloBD: TModeloBD;
    fChildDaoList: TObjectList<TChildDaoDefs>;
    FLoadCount: Integer;
    procedure IncLoadCount; // Number of loads needs to be counted to work on recursive Dao.
    procedure DecLoadCount;
    procedure SetModeloBD(const Value: TModeloBD);
    procedure InicializaObjeto;
    procedure AtualizaValorChave(pObject: TObject);
    function GetFunPropertyChild(pChildDefs: TChildDaoDefs): TFunGetPropValue;
    function FindChildDefsByPropName(const pPropName: String): TChildDaoDefs;
    function FindChildDefsByClassName(const pClassName: String): TChildDaoDefs;
//    function GetFunChildField(pChildDefs: TChildDaoDefs): TFunGetFieldValue;
    // TODO: If a missing child has childs, those childs will not be deleted. Ideally childs of missing childs should be deleted aswell
    function DeleteMissingChilds(pMasterInstance: TObject; ChildDefs: TChildDaoDefs): Integer;
    function SqlWhereChild(Instance: TObject; pChildDefs: TChildDaoDefs): String;
    function GetNewObjectFunction: TFunNewObject;
    procedure SetNewObjectFunction(const Value: TFunNewObject);
    function GetLoading: Boolean;
  protected
    function GetQueryBuilder: TQueryBuilderBase;
    function GetModeloBD: TModeloBD; virtual;
    function DaoUtils: TDaoUtils;

    procedure OnAfterLoadObject(AObject: TObject); virtual;
    function TableExists: Boolean; virtual;
  public
    property QueryBuilder: TQueryBuilderBase read GetQueryBuilder write fQueryBuilder;
    property ModeloBD: TModeloBD read fModeloBD write SetModeloBD;
    property NewObjectFunction: TFunNewObject read GetNewObjectFunction write SetNewObjectFunction;
    property Loading: Boolean read GetLoading;

    constructor Create; overload;
    constructor Create(pModeloBD: TModeloBD; pOwnsModelo: Boolean = true); overload;
    constructor Create(pNomeTabela: String; pCampoChave: string; pItemClass: TClass); overload;
    destructor Destroy; override;

    function ObjectExists(pObject: TObject): Boolean; // Check if object exists on database
    function KeyExists(ID: Integer): Boolean; virtual; // Check if object with ID exists on database

    procedure Insert(pObject: TObject; pMasterInstance: TObject = nil); virtual;
    function Update(pObject: TObject; pMasterInstance: TObject = nil): Boolean; virtual;
    function UpdateProperties(pObject: TObject; APropertyNames: String; pMasterInstance: TObject=nil): Boolean; virtual;

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

    function SelectKey(FChave: Integer): TObject; overload;
    procedure SelectKey(pObject: TObject; FChave: Integer); overload;
    function SelectOne(const pWhere: String): TObject; overload;
    procedure SelectOne(pObject: TObject; const pWhere: String); overload;

    function SelectWhere(const pWhere: String): TObjectList; overload;
    procedure SelectWhere(pList: TObjectList; const pWhere: String); overload;
    procedure SelectWhere(pObjectList: TObjectList<TObject>; const pWhere: String); overload;

    function SelectWhere<T: Class>(const pWhere: String): TObjectList<T>; overload;
    procedure SelectWhere<T: Class>(pObjectList: TObjectList<T>; const pWhere: String); overload;

    procedure CreateTableAndFields; virtual; // Check if table and mapped fields exists on database and if not create them;

    function ChildDaoByPropName(pPropertyName: String): IDaoBase;
    procedure AddChildDao(pPropertyName: String; pMasterFieldName: String; pChildFieldName: String; pDao: IDaoBase); virtual;
  // If RemoverDuplicateMappedFiels is true, then FieldMappings that have the same property name on MasterDao and ChildDao will be deleted from MasterDao
    procedure AddCompositeDao(pDao: IDaoBase);
  end;

  TDaoGeneric<T: class> = class(TDaoBase, IDaoGeneric<T>)
  private
//    fDaoBase: TDaoBase;
  public
    constructor Create; overload;
    constructor Create(pModeloBD: TModeloBD; pOwnsModelo: Boolean = true); overload;
    constructor Create(pNomeTabela: String; pCampoChave: string); overload;
    constructor Create(pNomeTabela: String; pCampoChave: string; pItemClass: TClass); overload;
    destructor Destroy; override;

    procedure SelectKey(pObject: T; FChave: Integer); reintroduce; overload; virtual;
    function SelectKey(FChave: Integer): T; reintroduce; overload; virtual;

    function KeyExists(ID: Integer): Boolean; reintroduce; virtual; // Check if object with ID exists on database

    procedure Insert(pObject: T; pMasterInstance: TObject = nil); reintroduce; virtual;
    function Update(pObject: T; pMasterInstance: TObject = nil): Boolean; reintroduce; virtual;

    function Delete(pObject: T; pMasterInstance: TObject=nil): Integer; reintroduce; overload; virtual;

    function SelectOne(const pWhere: String): T; reintroduce; overload; virtual;
    procedure SelectOne(pObject: T; const pWhere: String); reintroduce; overload; virtual;

    function SelectWhereG(const pWhere: String): TObjectList<T>; overload; virtual;
    procedure SelectWhere(pObjectList: TObjectList<T>; const pWhere: String); overload; virtual;
  end;

  // Use to save some object properties into another table. Use Master ID and Child ModeloBD
  TCompositeChildDao = class(TDaoBase)

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

  TConnectionPropertiesHelper = class helper for TSqlDBConnectionProperties
  private
    function GetSQLCreateField: TSQLDBFieldTypeDefinition;
    function GetSqlCreateFieldMax: cardinal;
  public
    function SQLFieldCreate(const aField: TSQLDBColumnCreate;
      var aAddPrimaryKey: RawUTF8): RawUTF8; virtual;
   property SqlCreateField: TSQLDBFieldTypeDefinition read GetSQLCreateField;
   property SQLCreateFieldMax: cardinal read GetSqlCreateFieldMax;
  end;

var
 // Singleton
  DaoFactory: TDaoFactory;

implementation

uses
  SysUtils, Classes, TypInfo, Controls, StrUtils, Variants, Ladder.Utils, SynTable;

function SqlDbColumnCreateFromFieldMapping(AFieldMapping: TFieldMapping; ModeloBD: TModeloBD): TSQLDBColumnCreate;
begin
  Result.DBType:= FieldTypeToSqlDBFieldType(AFieldMapping.FieldType);
  Result.Name:= AFieldMapping.FieldName;
  Result.Width:= 0;
  Result.Unique:= False;
  Result.NonNullable:= False;
  Result.PrimaryKey:= SameText(ModeloBD.NomeCampoChave, AFieldMapping.FieldName);
end;

function SQLFieldCreate(Connection: TSQLDBConnectionProperties; const AFieldMapping: TFieldMapping; ModeloBD: TModeloBD;
  var aAddPrimaryKey: RawUTF8): RawUTF8;
var
  aField: TSQLDBColumnCreate;
  fIsPrimaryKey: Boolean;
  fAutoIncrement: Boolean;
begin
  fIsPrimaryKey:= SameText(ModeloBD.NomeCampoChave, AFieldMapping.FieldName);
  fAutoIncrement:= fIsPrimaryKey and ModeloBD.ChaveIncremental;

  aField:= SqlDbColumnCreateFromFieldMapping(AFieldMapping, ModeloBD);
  if (aField.DBType=ftUTF8) and (cardinal(aField.Width-1)<Connection.SQLCreateFieldMax) then
    FormatUTF8(Connection.SQLCreateField[ftNull],[aField.Width],result) else
    result := Connection.SQLCreateField[aField.DBType];

  if fAutoIncrement then
    case Connection.DBMS of
      dMSSQL: Result:= Result+' Identity(1,1)';
    else raise Exception.Create('SQLFieldCreate: AutoIncrement field not implemented for this database.');
    end;

  if aField.NonNullable or aField.Unique or aField.PrimaryKey then
    result := result+' NOT NULL';
  if aField.Unique and not aField.PrimaryKey then
    result := result+' UNIQUE'; // see http://www.w3schools.com/sql/sql_unique.asp
  if aField.PrimaryKey then
    case Connection.DBMS of
    dSQLite, dMSSQL, dOracle, dJet, dPostgreSQL, dFirebird, dNexusDB, dInformix:
      result := result+' PRIMARY KEY';
    dDB2, dMySQL:
      aAddPrimaryKey := aField.Name;
    end;
  result := aField.Name+result;
end;

function SQLAddColumn(Connection: TSQLDBConnectionProperties; AFieldMapping: TFieldMapping; ModeloBD: TModeloBD): RawUTF8;
var AddPrimaryKey: RawUTF8;
begin
  FormatUTF8('ALTER TABLE % ADD %',[ModeloBD.NomeTabela ,SQLFieldCreate(Connection, AFieldMapping,ModeloBD,AddPrimaryKey)],result);
end;

function SQLCreate(Connection: TSQLDBConnectionProperties; ModeloBD: TModeloBD): RawUTF8;
var i: integer;
    F: RawUTF8;
    FieldID: TSQLDBColumnCreate;
    AddPrimaryKey: RawUTF8;
    aFields: TSQLDBColumnCreateDynArray;
    fFieldMapping: TFieldMapping;
begin
  result := '';

  for fFieldMapping in ModeloBD.MappedFieldList do
  begin
    if fFieldMapping.FieldName = '' then
      Continue;

    if Result<>'' then
      Result:= Result+',';
    Result:= Result+SqlFieldCreate(Connection, FFieldMapping, ModeloBD, AddPrimaryKey);
  end;
  if Result='' then
    Exit; // nothing to create

  if AddPrimaryKey<>'' then
    result := result+', PRIMARY KEY('+AddPrimaryKey+')';
  result := 'CREATE TABLE '+ModeloBD.NomeTabela+' ('+result+')';
  case Connection.DBMS of
  dDB2: result := result+' CCSID Unicode';
  end;
end;

{ TDaoChildDefinitions }

constructor TChildDaoDefs.Create(pMasterProperty: TRttiMember; pMasterFieldName,
  pChildFieldName: String; pDao: IDaoBase; pWeakReference: Boolean = False);
begin
  inherited Create;
  FMasterProperty:= pMasterProperty;
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

function TChildDaoDefs.GetChildObject(pMasterInstance: TObject): TObject;
begin
  Assert(Assigned(MasterProperty), 'TChildDaoDefs.GetChildObject: Master property needs to be Assigned');
  Result:= MasterProperty.GetValue(pMasterInstance).AsObject;
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
  if not Assigned(FMasterProperty) then
    Result:= ''
  else
    Result:= FMasterProperty.Name;
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
 Result:= TRttiInstanceType(GetPropertyRttiType(FMasterProperty).AsInstance).MetaclassType;
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

{ TCompositeChildDaoDefs }

constructor TCompositeChildDaoDefs.Create(AKeyFieldName: String; pDao: IDaoBase);
var
  RttiType: TRttiType;
  RttiProperty: TRttiMember;
begin
  RttiType := RttiContext.GetType(Self.ClassType);

  RttiProperty:= RttiType.GetField('PrivateObjectProperty');

  // Assigns a dummy property of type TObject to MasterProperty, to prevent Access Violations if any function of TChildDaoDefs use this field
  inherited Create(RttiProperty, AKeyFieldName, AKeyFieldName, pDao);
end;

function TCompositeChildDaoDefs.GetChildObject(pMasterInstance: TObject): TObject;
begin
  Result:= pMasterInstance;
end;

{ TDaoBase }

procedure TDaoBase.IncLoadCount;
begin
  Inc(FLoadCount);
end;

procedure TDaoBase.InicializaObjeto;
begin
  fOwnsModelo:= False;
  fChildDaoList:= TObjectList<TChildDaoDefs>.Create(False); // DaoChilds must be checked to see if it is not recursive before freeing

  fQueryBuilder:= DaoFactory.NewQueryBuilder(nil);
end;

constructor TDaoBase.Create;
begin
  inherited;
  FLoadCount:= 0;

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

function TDaoBase.ChildDaoByPropName(pPropertyName: String): IDaoBase;
var
  fChildDao: TChildDaoDefs;
begin
  for fChildDao in fChildDaoList do
    if SameText(fChildDao.PropertyName, pPropertyName) then
    begin
      Result:= fChildDao.Dao;
      exit;
    end;
  Result:= nil;
end;

constructor TDaoBase.Create(pNomeTabela, pCampoChave: string;
  pItemClass: TClass);
begin
  Create(TModeloBD.Create(pNomeTabela, pCampoChave, pItemClass), True);
end;

procedure TDaoBase.CreateTableAndFields;
var
  FTableExists: Boolean;
  fChildDao: TChildDaoDefs;

  procedure CheckAndCreateFields;
  var
    FDataSet: TDataSet;
    fFieldMapping: TFieldMapping;
  begin
    FDataSet:= DaoUtils.SelectAsDataset(Format('select * from %s where 1=0', [ModeloBD.NomeTabela]));
    try
      for fFieldMapping in ModeloBD.MappedFieldList do
      begin
        if fFieldMapping.FieldName='' then
          Continue;

        if FTableExists then
          if FDataSet.FindField(fFieldMapping.FieldName)=nil then
            DaoUtils.ExecuteNoResult(SQLAddColumn(DaoUtils.Connection, fFieldMapping, ModeloBD));
      end;
    finally
      FDataSet.Free;
    end;
  end;

begin
  FTableExists:= TableExists;

  if FTableExists then
    CheckAndCreateFields
  else
    DaoUtils.ExecuteNoResult(SQLCreate(DaoUtils.Connection, ModeloBD));

  for FChildDao in fChildDaoList do
    if TObject(fChildDao.Dao) <> Self then
      fChildDao.Dao.CreateTableAndFields;

end;

destructor TDaoBase.Destroy;
var
  fChildDao: TChildDaoDefs;
begin
  if fOwnsModelo then
    if assigned(fModeloBD) then
    begin
      fModeloBD.AfterLoadObjectEvent.Remove(OnAfterLoadObject); // Must remove the event
      fModeloBD.Free;
    end;

  fQueryBuilder.Free;

  for fChildDao in fChildDaoList do
//    if TObject(fChildDao.Dao) <> Self then  // do not free if child is self
      fChildDao.Free;

  fChildDaoList.Free;

  inherited;
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

function TDaoBase.SelectWhere(const pWhere: String): TObjectList;
begin
  IncLoadCount;
  try
    Result:= ModeloBD.ObjectListFromSql(QueryBuilder.SelectWhere(pWhere), Self);
  finally
    DecLoadCount;
  end;
end;

procedure TDaoBase.SelectWhere(pList: TObjectList; const pWhere: String);
begin
  IncLoadCount;
  try
    ModeloBD.PopulaObjectListFromSql(pList, QueryBuilder.SelectWhere(pWhere), Self);
  finally
    DecLoadCount;
  end;
end;

procedure TDaoBase.SelectWhere(pObjectList: TObjectList<TObject>; const pWhere: String);
begin
  SelectWhere<TObject>(pObjectList, pWhere);
end;

procedure TDaoBase.SelectWhere<T>(pObjectList: TObjectList<T>; const pWhere: String);
begin
  IncLoadCount;
  try
    ModeloBD.PopulaObjectListFromSql<T>(pObjectList, QueryBuilder.SelectWhere(pWhere), Self);
  finally
    DecLoadCount;
  end;
end;

function TDaoBase.SelectWhere<T>(const pWhere: String): TObjectList<T>;
begin
  IncLoadCount;
  try
    Result:= ModeloBD.ObjectListFromSql<T>(QueryBuilder.SelectWhere(pWhere), Self);
  finally
    DecLoadCount;
  end;
end;

function TDaoBase.SelectKey(FChave: Integer): TObject;
begin
  IncLoadCount;
  try
    Result:= ModeloBD.ObjectFromSql(QueryBuilder.SelectWhereChave(FChave), Self);
  finally
    DecLoadCount;
  end;
end;

procedure TDaoBase.SelectKey(pObject: TObject; FChave: Integer);
begin
  IncLoadCount;
  try
    ModeloBD.ObjectFromSql(pObject, QueryBuilder.SelectWhereChave(FChave), Self);
  finally
    DecLoadCount;
  end;
end;

function TDaoBase.SelectOne(const pWhere: String): TObject;
begin
  IncLoadCount;
  try
    Result:= ModeloBD.ObjectFromSql(QueryBuilder.SelectWhere(pWhere), Self);
  finally
    DecLoadCount;
  end;
end;


procedure TDaoBase.SelectOne(pObject: TObject; const pWhere: String);
begin
  IncLoadCount;
  try
    ModeloBD.ObjectFromSql(pObject, QueryBuilder.SelectWhere(pWhere), Self);
  finally
    DecLoadCount;
  end;
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

function TDaoBase.TableExists: Boolean;
begin
  Result:= DaoUtils.SelectInt(QueryBuilder.TableExists(ModeloBD.NomeTabela), 0) > 0;
end;

function TDaoBase.GetFunPropertyChild(pChildDefs: TChildDaoDefs): TFunGetPropValue;
begin
  Result:=
    function (const pPropName: String; pCurrentValue: TValue; Instance: TObject; pDBRows: ISqlDBRows; Sender: TObject): TValue
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
          pObjectList.Clear;
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
          pObjectList.Clear;
          pChildDefs.Dao.SelectWhere(pObjectList, pWhere);
          Result:= pObjectList;
        end
        else begin
          Result:= TObjectList<TObject>(CreateObjectOfClass(pChildDefs.PropertyClass));
          pChildDefs.Dao.SelectWhere(Result, pWhere);
        end;
      end;

    begin
      // The Child property should only be loaded from here if the object is being loaded
      // from the DAO. If ModeloBD.ObjectToDataSet is called directly this should not be executed.
      // Maybe an option could be added to control when to load the child objects
      if Sender <> Self then
      begin
        Result:= pCurrentValue;
        Exit;
      end;

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

function TDaoBase.GetLoading: Boolean;
begin
  Result:= FLoadCount > 0;
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

// If RemoverDuplicateMappedFiels is true, then FieldMappings that have the same property name on MasterDao and ChildDao will be deleted from MasterDao
procedure TDaoBase.AddCompositeDao(pDao: IDaoBase);
var
  fCompositeDao: TCompositeChildDaoDefs;
begin
  fCompositeDao:= TCompositeChildDaoDefs.Create(ModeloBD.NomeCampoChave, pDao);
  fCompositeDao.MasterDao:= Self;
  fChildDaoList.Add(fCompositeDao);
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

procedure TDaoBase.DecLoadCount;
begin
  if FLoadCount>0 then
    Dec(FLoadCount);
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
  Result:= 0;

  FObject:= ChildDefs.GetChildObject(pMasterInstance);

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

// TODO: If a missing child has childs, those childs will not be deleted. Ideally childs of missing childs should be deleted aswell
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
  FObject:= ChildDefs.GetChildObject(pMasterInstance);

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
    if TUpdateOption.uoDeleteMissingChilds in ModeloBD.UpdateOptions then
      DeleteMissingChilds(pObject, FChildDaoDef); // Delete the Childs that do not belong to this object anymore

    SaveChild(pObject, FChildDaoDef); // Insert or update the Childs that are assigned
  end;
end;

function TDaoBase.UpdateProperties(pObject: TObject; APropertyNames: String; pMasterInstance: TObject=nil): Boolean;
var
  fChildDaoDef: TChildDaoDefs;
  FUpdateSql: String;
begin
  Result:= False;
  FUpdateSql:= QueryBuilder.UpdateProperties(pObject, APropertyNames, pMasterInstance); // if Result is empty string there are no fields to update
  if FUpdateSql <> '' then
    Result:= DaoUtils.ExecuteNoResult(FUpdateSql) > 0;

  for fChildDaoDef in fChildDaoList do
    if fChildDaoDef is TCompositeChildDaoDefs then
      Result:= Result or fChildDaoDef.Dao.UpdateProperties(pObject, APropertyNames, pObject); // Property might be part of a composite DAO
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
  FObject:= ChildDefs.GetChildObject(pMasterInstance);

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

procedure TDaoBase.OnAfterLoadObject(AObject: TObject);
var
  fChildDaoDef: TChildDaoDefs;
begin
  for fChildDaoDef in fChildDaoList do
    if fChildDaoDef is TCompositeChildDaoDefs then
      fChildDaoDef.Dao.SelectKey(AObject, fChildDaoDef.Dao.ModeloBD.GetKeyValue(AObject));

end;

procedure TDaoBase.SetModeloBD(const Value: TModeloBD);
begin
  fModeloBD := Value;
  QueryBuilder.ModeloBD:= fModeloBD;
  ModeloBD.AfterLoadObjectEvent.Remove(OnAfterLoadObject); // Remove to prevent adding the event listener twice
  ModeloBD.AfterLoadObjectEvent.Add(OnAfterLoadObject);
end;

procedure TDaoBase.SetNewObjectFunction(const Value: TFunNewObject);
begin
  Assert(Assigned(ModeloBD), 'TDaoBase.SetNewObjectFunction: ModeloBD must be assigned.');
  ModeloBD.NewObjectFunction:= Value;
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
end;

constructor TDaoGeneric<T>.Create(pNomeTabela, pCampoChave: string);
begin
  Create(pNomeTabela, pCampoChave, T);
end;

constructor TDaoGeneric<T>.Create(pNomeTabela, pCampoChave: string; pItemClass: TClass);
begin
  inherited Create(pNomeTabela, pCampoChave, pItemClass);
end;

destructor TDaoGeneric<T>.Destroy;
begin
//  fDaoBase.Free;

  inherited;
end;

function TDaoGeneric<T>.SelectWhereG(const pWhere: String): TObjectList<T>;
begin
//  Result:= fDaoBase.GetGenericListWhere<T>(pWhere);
  Result:= inherited SelectWhere<T>(pWhere);
end;

procedure TDaoGeneric<T>.SelectWhere(pObjectList: TObjectList<T>; const pWhere: String);
begin
  inherited SelectWhere<T>(pObjectList, pWhere);
end;

procedure TDaoGeneric<T>.SelectKey(pObject: T; FChave: Integer);
begin
  inherited SelectKey((pObject as T), FChave);
end;

function TDaoGeneric<T>.SelectKey(FChave: Integer): T;
begin
//  Result:= T(fDaoBase.SelectKey(FChave));
  Result:= (inherited SelectKey(FChave) as T);
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

{ TConnectionPropertiesHelper }

function TConnectionPropertiesHelper.GetSQLCreateField: TSQLDBFieldTypeDefinition;
begin
  Result:= fSqlCreateField;
end;

function TConnectionPropertiesHelper.GetSqlCreateFieldMax: cardinal;
begin
  Result:= fSqlCreateFieldMax;
end;

function TConnectionPropertiesHelper.SQLFieldCreate(
  const aField: TSQLDBColumnCreate; var aAddPrimaryKey: RawUTF8): RawUTF8;
begin
  inherited;
end;

initialization
  DaoFactory:= TDaoFactory.Create;

finalization
  DaoFactory.Free;

end.
