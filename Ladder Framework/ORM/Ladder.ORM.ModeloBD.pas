unit Ladder.ORM.ModeloBD;

interface

uses
  Data.DB, System.Contnrs, System.Classes, Generics.Collections, RTTI, Ladder.ORM.DaoUtils,
  Ladder.Messages, Ladder.ORM.Classes, SysUtils, Utils, Math, Ladder.ServiceLocator, SynDB,
  Ladder.ORM.SQLDBRowsDataSet, Spring.Events, Spring;

  function PropertyToFieldType(pProperty: TRttiMember): TFieldType;
  function GetPropertyRttiType(pRttiMember: TRttiMember): TRttiType;
  function GetPropertyValue(pRttiMember: TRttiMember; Instance: Pointer): TValue;
  procedure SetPropertyValue(pRttiMember: TRttiMember; Instance: Pointer; AValue: TValue);
  function PropIsWritable(pRttiMember: TRttiMember): Boolean;

type
  TFunGetFieldValue = reference to function (const pFieldName: String; Instance: TObject; MasterInstance: TObject = nil): Variant;
  TFunGetPropValue = reference to function (const pPropName: String; pCurrentValue: TValue; Instance: TObject; pDBRows: ISQLDBRows; Sender: TObject): TValue;

  TFieldMapping = class(TObject)
  private
    FItemClass: TClass;
    FProp: TRttiMember;
    procedure SetPropName(const Value: String);
    function GetPropName: String;
  public
    FieldName: String; // Nome da Coluna;
    FieldType: TFieldType;
    FunGetFieldValue: TFunGetFieldValue; //if this callback function is assigned the value saved to the given field will be the return value of this function
    FunGetPropValue: TFunGetPropValue; //if this callback function is assigned the prop value will be the return value of this function

    property PropName: String read GetPropName write SetPropName; // Nome da propriedade do objeto;
    property Prop: TRttiMember read FProp;
    constructor Create(pItemClass: TClass); overload;
    constructor Create(pItemClass: TClass; pPropName, pFieldName: String); overload;
//    pSerialization: TSerialization;
  end;

  TFieldMappingList = class(TObjectList<TFieldMapping>)
  private
  public
    ItemClass: TClass;
    function GetFieldMappingByFieldName(const pNomeCampo: String): TFieldMapping;
    function GetFieldMappingByPropName(const pNomePropriedade: String): TFieldMapping;
    // Adiciona os mapeamentos na lista de campos mapeados
    function Map(pProp, pField: String; pFieldType: TFieldType = ftUnknown): TFieldMappingList;
    function MapField(pField: String; pFieldType: TFieldType; pFunGetFieldValue: TFunGetFieldValue): TFieldMappingList;
    function MapProperty(pPropName: String; pFunGetPropValue: TFunGetPropValue): TFieldMappingList;

    constructor Create(pItemClass: TClass);
  end;

  TAutoMapOption = (amNone, amPublished, amPublicAndPublished);

//  TAutoMapOptions = set of TAutoMapOption;

  TSelectOption = (Top0);
  TSelectOptions = set of TSelectOption;

  TUpdateOption = (uoDeleteMissingChilds);
  TUpdateOptions = set of TUpdateOption;

  TTipoMapeamento = (tmObjectToDataset, tmObjectFromDataSet);

  TMapeamentoCallback = reference to procedure (pClass: TClass; pFieldMapping: TFieldMapping; Sender: TObject);

  TFunNewObject = reference to function (pDBRows: ISQLDBRows): TObject;

  TModeloBD = class(TObject)
  private
    FNomeTabela: String;
    FNomePropChave: String;

    FChaveIncremental: Boolean;
    FItemClass: TClass;
    FMappedFieldList: TFieldMappingList;
//    fOpcoesMapeamento: TOpcoesMapeamento;
    fNewObjectFunction: TFunNewObject;
    fAfterLoadObjectEvent: IEvent<TNotifyEvent>;
    //FOnAfterLoad: TNotifyEvent;
    rttiCreateMethod: TRttiMethod;
    rttiType: TRttiType;
    FFieldsInUpdateDeleteWhere: TList<String>;
    FUpdateOptions: TUpdateOptions;

    function FazMapeamentoECopiaValores(pObjeto: TObject; pDBRows: ISqlDBRows; TipoMapeamento: TTipoMapeamento; Sender: TObject): Boolean; overload;
    function FazMapeamentoECopiaValores(pObjeto: TObject; pDataSet: TDataSet;
      TipoMapeamento: TTipoMapeamento; Sender: TObject): Boolean; overload;

    procedure ObjectFromDBRows(pObject: TObject; pDBRows: ISqlDBRows; Sender: TObject = nil); overload;
    function ObjectFromDBRows(pDBRows: ISqlDBRows; Sender: TObject = nil): TObject; overload;

//    procedure SetPropValue(Instance: TObject; pFieldMapping: TFieldMapping; pDataSet: TDataSet; Sender: TObject);
    procedure ColumnToProp(Instance: TObject; pRows: ISqlDBRows; pFieldMapping: TFieldMapping; Sender: TObject = nil);

    procedure SetFieldValue(Instance: TObject; pFieldMapping: TFieldMapping; pDataSet: TDataSet);

    procedure InicializaObjeto;

    function ObjectListFromDBRows(pRows: ISqlDBRows; Sender: TObject = nil): TObjectList;
    procedure PopulaObjectListFromDBRows(pObjectList: TObjectList; pRows: ISqlDBRows; Sender: TObject = nil); overload;
    procedure PopulaObjectListFromDBRows<T: Class>(pObjectList: TObjectList<T>; pRows: ISqlDBRows; Sender: TObject = nil); overload;

    function GetPropChave: TRttiMember;
    function GetNomeCampoChave: string;
    procedure SetItemClass(const Value: TClass);
    procedure SetNomePropChave(const Value: String);
  protected
    procedure DoAfterLoadObject(Sender: TObject); virtual;
  public
    property NomeTabela: String read FNomeTabela write FNomeTabela;
    property NomePropChave: String read FNomePropChave write SetNomePropChave;
    property NomeCampoChave: string read GetNomeCampoChave;
    property ItemClass: TClass read FItemClass write SetItemClass;
    property NewObjectFunction: TFunNewObject read fNewObjectFunction write fNewObjectFunction;
    property PropChave: TRttiMember read GetPropChave;
    property MappedFieldList: TFieldMappingList read FMappedFieldList;
    property ChaveIncremental: Boolean read FChaveIncremental write FChaveIncremental;
    property FieldsInUpdateDeleteWhere: TList<String> read FFieldsInUpdateDeleteWhere;
    property UpdateOptions: TUpdateOptions read FUpdateOptions write FUpdateOptions;
    property AfterLoadObjectEvent: IEvent<TNotifyEvent> read fAfterLoadObjectEvent;
    //property OnAfterLoad: TNotifyEvent read FOnAfterLoad write FOnAfterLoad;

    constructor Create(pItemClass: TClass; pAutoMapOption: TAutoMapOption = amPublished); overload;
    constructor Create(pNomeTabela: String; pNomePropChave: string; pItemClass: TClass; pAutoMapOption: TAutoMapOption = amPublished); overload;
    destructor Destroy; override;

    function Connection: TSQLDBConnectionProperties;
    function DaoUtils: TDaoUtils;

    function GetPropByName(const pNomeProp: String): TRttiMember;

    function GetFieldValue(const pFieldName: String; Instance: TObject; MasterInstance: TObject = nil): Variant; overload;
    function GetFieldValue(const pFieldMapping: TFieldMapping; Instance: TObject; MasterInstance: TObject = nil): Variant; overload;

    function FieldMappingByFieldName(pFieldName: String): TFieldMapping;
    function FieldMappingByPropName(pPropName: String): TFieldMapping;

    function Map(pProp, pField: String; pFieldType: TFieldType = ftUnknown): TFieldMappingList;
    function MapField(pField: String; pFieldType: TFieldType; pFunGetFieldValue: TFunGetFieldValue): TFieldMappingList;
    function MapProperty(pPropName: String; pFunGetPropValue: TFunGetPropValue): TFieldMappingList;

    procedure DoMapFields(pAutoMapOption: TAutoMapOption); overload;
    procedure DoMapFields(pAutoMapOption: TAutoMapOption; pDoNotMapFieldsFromInheritedClasses: Boolean); overload;
    procedure DoMapFields(pItemClass: TClass; pAutoMapOption: TAutoMapOption; pDoNotMapFieldsFromInheritedClasses: Boolean = False); overload;

    procedure AddFieldInUpdateDeleteWhere(pFieldName: String);

    function ObjectToDataSet(pObjeto: TObject; pDataSet: TDataset): Boolean;

    procedure ObjectFromDataSet(pObject: TObject; pDataSet: TDataSet; Sender: TObject = nil); overload;
    function ObjectFromDataSet(pDataSet: TDataSet; Sender: TObject = nil): TObject; overload;

    procedure ObjectFromSql(pObject: TObject; const pSql: String; Sender: TObject = nil); overload;
    function ObjectFromSql(const pSql: String; Sender: TObject = nil): TObject; overload;

    // Para cada linha do DataSet ser� criado um objeto do tipo ItemClass e adicionado � lista,
    // S�o copiados os valores das colunas que cont�m o mesmo nome que uma propriedade published do objeto, ou que contenham mapeamento.
    procedure PopulaObjectListFromDataSet(pObjectList: TObjectList; pDataSet: TDataSet; Sender: TObject = nil); overload;
    procedure PopulaObjectListFromDataSet<T: class>(pObjectList: TObjectList<T>; pDataSet: TDataSet; Sender: TObject = nil); overload;
    procedure PopulaObjectListFromSql(pObjectList: TObjectList; const pSql: String; Sender: TObject = nil); overload;
    procedure PopulaObjectListFromSql<T: class>(pObjectList: TObjectList<T>; const pSql: String; Sender: TObject = nil); overload;

    function ObjectListFromDataSet(pDataSet: TDataSet; Sender: TObject = nil): TObjectList; overload;
    function ObjectListFromDataSet<T: class>(pDataSet: TDataSet; Sender: TObject = nil): TFrwObjectList<T>; overload;

    function ObjectListFromSql(const pSql: String; Sender: TObject = nil): TObjectList; overload;
    function ObjectListFromSql<T: class>(const pSql: String; Sender: TObject = nil): TFrwObjectList<T>; overload;

    // Faz o mapeamento do Objeto e do DataSet. Ao encontrar a propriedade do objeto correspondente a um campo no dataset dispara MapeamentoCallback.
    // Caso existam campos mapeados na lista FMappedFieldList, utiliza a correspondencia setada,
    // caso contrario faz o mapeamento por propriedades que tenham o mesmo no de um campo do dataset.
    // Se a op��o 'ApenasExplicitos' estiver setada, apenas os campos na lista FMappedFieldList ser�o mapeados;
    function FazMapeamentoDaClasse(MapeamentoCallback: TMapeamentoCallback; pOnlyValidFields: Boolean = False; Sender: TObject = nil): Boolean;

    procedure SetKeyValue(pObject: TObject; fValor: Integer);
    function GetKeyValue(pObject: TObject): Integer;

    function CreateObject(pDBRows: ISqlDBRows): TObject; overload;
    function CreateObject(pDataSet: TDataSet): TObject; overload;
  end;

var
  RttiContext: TRttiContext;

// Use Rtti to execute the Create constructor of the object, if there is not Create calls TClass.Create
// Will not work if Constructor contains indexed Enumerators as parameter, since it RTTI will show it has no parameters
function CreateObjectOfClass(pClass: TClass): TObject;

implementation

uses
  TypInfo, Ladder.Utils;

function GetPropertyRttiType(pRttiMember: TRttiMember): TRttiType;
begin
  if pRttiMember is TRttiProperty then
    Result:= TRttiProperty(pRttiMember).PropertyType
  else if pRttiMember is TRttiField then
    Result:= TRttiField(pRttiMember).FieldType
  else
    raise Exception.Create(Format('TFieldMappingList.GetMemberType: Member %s must be field or property', [pRttiMember.Name]));
end;

function PropertyToFieldType(pProperty: TRttiMember): TFieldType;
var
  pType: TRttiType;
begin
  Result:= ftUnknown;

  pType:= GetPropertyRttiType(pProperty);

  if SameText('TDateTime', pType.Name) then
    Result:= ftDateTime
  else if SameText('TDate', pType.Name) then
    Result:= ftDate;

  if Result <> ftUnknown then
    Exit;

  case pType.TypeKind of
    tkString,tkLString,tkAnsiChar,tkWideString,tkUnicodeString: Result:= ftString;
    tkFloat: Result:= ftFloat;
    tkInteger, tkEnumeration: Result:= ftInteger;
    tkInt64: Result:= ftLargeint;
  end;
end;

function GetPropertyValue(pRttiMember: TRttiMember; Instance: Pointer): TValue;
begin
  if pRttiMember is TRttiProperty then
    Result:= TRttiProperty(pRttiMember).GetValue(Instance)
  else if pRttiMember is TRttiField then
    Result:= TRttiField(pRttiMember).GetValue(Instance)
  else
    raise Exception.Create(Format('TFieldMappingList.GetMemberType: Member %s must be field or property', [pRttiMember.Name]));
end;

procedure SetPropertyValue(pRttiMember: TRttiMember; Instance: Pointer; AValue: TValue);
begin
  if pRttiMember is TRttiProperty then
    TRttiProperty(pRttiMember).SetValue(Instance, AValue)
  else if pRttiMember is TRttiField then
    TRttiField(pRttiMember).SetValue(Instance, AValue)
  else
    raise Exception.Create(Format('TFieldMappingList.GetMemberType: Member %s must be field or property', [pRttiMember.Name]));
end;

function PropIsWritable(pRttiMember: TRttiMember): Boolean;
begin
  if pRttiMember is TRttiProperty then
    Result:= TRttiProperty(pRttiMember).IsWritable
  else
    Result:= True;
end;

// Will not work if Constructor contains indexed Enumerators as parameter
function CreateObjectOfClass(pClass: TClass): TObject;
var
  rContext: TRttiContext;
  rType: TRttiType;
  FMethod: TRttiMethod;
  FMethods: TArray<TRttiMethod>;
  FParameters: TArray<TRttiParameter>;
  I: Integer;
begin
  FMethod:= nil;
  rContext:= TRttiContext.Create;
  rType:= rContext.GetType(pClass);
  FMethods:= rType.GetMethods;
  for I:= Low(FMethods) to High(FMethods) do
  begin
    if SameText('Create', FMethods[I].Name) then
    begin
      FPArameters:= FMethods[I].GetParameters;
      if Length(FParameters) = 0 then
      begin
        FMethod:= FMethods[I];
        Break;
      end;
    end;
  end;

  if Assigned(FMethod) then // Se n�o existir um constructor Create na class chama o constructor de TObject
    Result:= TObject(FMethod.Invoke(rType.AsInstance.MetaclassType,[]).AsObject)
  else
    Result:= pClass.Create;

end;


{ TFieldMapping }

constructor TFieldMapping.Create(pItemClass: TClass);
begin
  inherited Create;
  FItemClass:= pItemClass;
end;

constructor TFieldMapping.Create(pItemClass: TClass; pPropName,
  pFieldName: String);
begin
  Create(pItemClass);
  PropName:= pPropName;
  FieldName:= pFieldName;
end;

function TFieldMapping.GetPropName: String;
begin
  if Assigned(FProp) then
    Result:= FProp.Name
  else
    Result:= '';
end;

procedure TFieldMapping.SetPropName(const Value: String);
var
  RttiType: TRttiType;
begin
  RttiType := RttiContext.GetType(FItemClass);
  FProp:= RttiType.GetProperty(Value);
  if not Assigned(FProp) then
    FProp:= RttiType.GetField(Value);

  if not Assigned(FProp) then
    raise Exception.Create(Format('TFieldMapping.SetPropName: Property %s does not exist on class %s', [Value, FItemClass.ClassName]));
end;

{ TFieldMappingList }

constructor TFieldMappingList.Create(pItemClass: TClass);
begin
  inherited Create;
  ItemClass:= pItemClass;
end;

function TFieldMappingList.GetFieldMappingByFieldName(
  const pNomeCampo: String): TFieldMapping;
var
  I: Integer;
begin
  for I := 0 to Self.Count-1 do
  begin
    if SameText(Self.Items[I].FieldName, pNomeCampo) then
    begin
     Result:= Self.Items[I];
     Exit;
    end;
  end;

  Result:= nil;
end;

function TFieldMappingList.GetFieldMappingByPropName(
  const pNomePropriedade: String): TFieldMapping;
var
  I: Integer;
begin
  for I := 0 to Self.Count-1 do
  begin
    if SameText(Self.Items[I].PropName, pNomePropriedade) then
    begin
     Result:= Self.Items[I];
     Exit;
    end;
  end;

  Result:= nil;
end;

function TFieldMappingList.Map(pProp, pField: String; pFieldType: TFieldType = ftUnknown): TFieldMappingList;
var
  fMappedField: TFieldMapping;
begin
  fMappedField:= GetFieldMappingByPropName(pProp);

  if Assigned(fMappedField) then
    Remove(fMappedField);

  fMappedField:= TFieldMapping.Create(ItemClass);

  fMappedField.PropName:= pProp;
  fMappedField.FieldName:= pField;

  if pFieldType <> ftUnknown then
    fMappedField.FieldType:= pFieldType
  else
    fMappedField.FieldType:= PropertyToFieldType(fMappedField.Prop);

  Self.Add(fMappedField);

  Result:= Self;
end;

function TFieldMappingList.MapField(pField: String; pFieldType: TFieldType;
  pFunGetFieldValue: TFunGetFieldValue): TFieldMappingList;
var
  fMappedField: TFieldMapping;
begin
  fMappedField:= GetFieldMappingByFieldName(pField);

  if Assigned(fMappedField) then
    Remove(fMappedField);

  fMappedField:= TFieldMapping.Create(ItemClass);

  fMappedField.FieldName:= pField;
  fMappedField.FieldType:= pFieldType;
  FMappedField.FunGetFieldValue:= pFunGetFieldValue;

  Self.Add(fMappedField);

  Result:= Self;
end;

function TFieldMappingList.MapProperty(pPropName: String;
  pFunGetPropValue: TFunGetPropValue): TFieldMappingList;
var
  fMappedField: TFieldMapping;
begin
  fMappedField:= GetFieldMappingByPropName(pPropName);

  if Assigned(fMappedField) then
    Remove(fMappedField);

  fMappedField:= TFieldMapping.Create(ItemClass);

  fMappedField.PropName:= pPropName;
  FMappedField.FunGetPropValue:= pFunGetPropValue;

  Self.Add(fMappedField);

  Result:= Self;
end;

{ TModeloBD }

function TModeloBD.Map(pProp, pField: String; pFieldType: TFieldType = ftUnknown): TFieldMappingList;
begin
  Result:= MappedFieldList.Map(pProp, pField, pFieldType);
end;

function TModeloBD.MapField(pField: String; pFieldType: TFieldType; pFunGetFieldValue: TFunGetFieldValue): TFieldMappingList;
begin
  Result:= MappedFieldList.MapField(pField, pFieldType, pFunGetFieldValue);
end;

function TModeloBD.MapProperty(pPropName: String;
  pFunGetPropValue: TFunGetPropValue): TFieldMappingList;
begin
  Result:= MappedFieldList.MapProperty(pPropName, pFunGetPropValue);
end;

function TModeloBD.ObjectToDataSet(pObjeto: TObject; pDataSet: TDataset): Boolean;
begin
  Result:= FazMapeamentoECopiaValores(pObjeto, pDataSet, tmObjectToDataSet, nil);
end;

procedure TModeloBD.DoMapFields(pItemClass: TClass; pAutoMapOption: TAutoMapOption; pDoNotMapFieldsFromInheritedClasses: Boolean = False);
var
  RttiType: TRttiType;
  Prop: TRttiProperty;
  Field: TRttiField;
  FVisibility: set of TMemberVisibility;

  procedure MapFieldOrProperty(pFieldOrProp: TRttiMember);
  begin
    if not (pFieldOrProp.Visibility in FVisibility) then
      Exit;

    if PropertyToFieldType(pFieldOrProp) = ftUnknown then
      Exit;

    if pDoNotMapFieldsFromInheritedClasses and (pFieldOrProp.Parent.AsInstance.MetaclassType <> pItemClass) then
      Exit;

    if Assigned(FMappedFieldList.GetFieldMappingByPropName(pFieldOrProp.Name)) then // Field already mapped
      Exit;

    Map(pFieldOrProp.Name, pFieldOrProp.Name); // Default Field Name is same as Prop Name
  end;

begin
  if pAutoMapOption = amNone then
    Exit;

  if pAutoMapOption = amPublished then
    FVisibility:= [TMemberVisibility.mvPublished];

  if pAutoMapOption = amPublicAndPublished then
    FVisibility:= [TMemberVisibility.mvPublished, TMemberVisibility.mvPublic];

  RttiType := RttiContext.GetType(pItemClass);

  for Prop in RttiType.GetProperties do
    MapFieldOrProperty(Prop);

  for Field in RttiType.GetFields do
    MapFieldOrProperty(Field);

end;

function TModeloBD.CreateObject(pDBRows: ISqlDBRows): TObject;
begin
  if Assigned(NewObjectFunction) then
  begin
    Result:= NewObjectFunction(pDBRows);
    Exit;
  end;

{  if Assigned(rttiCreateMethod) then // Se n�o existir um constructor Create na class chama o constructor de TObject
   // Will throw an exception when class has a constructor with idexed enumerator as parameter
   //https://stackoverflow.com/questions/61509397/trttimethod-getparameters-does-not-work-when-method-has-an-indexed-enumerator-as?noredirect=1#comment108807843_61509397
    Result:= TObject(rttiCreateMethod.Invoke(rttiType.AsInstance.MetaclassType,[]).AsObject)
  else }
  Result:= ItemClass.Create;
end;

procedure TModeloBD.ObjectFromDataSet(pObject: TObject; pDataSet: TDataSet; Sender: TObject = nil);
begin
  FazMapeamentoECopiaValores(pObject, pDataSet, tmObjectFromDataSet, Sender);
end;

// Mapeia a linha corrente do DataSet para um objeto.
function TModeloBD.ObjectFromDataSet(pDataSet: TDataSet; Sender: TObject = nil): TObject;
begin
// Se dataset estiver vazio retorna nulo
  Result:= nil;
  if pDataSet.IsEmpty then
    Exit;

  Result:= CreateObject(pDataSet); //ItemClass.Create;

  ObjectFromDataSet(Result, pDataSet, Sender);
end;

procedure TModeloBD.ObjectFromDBRows(pObject: TObject; pDBRows: ISqlDBRows; Sender: TObject = nil);
begin
  FazMapeamentoECopiaValores(pObject, pDBRows, tmObjectFromDataSet, Sender);
end;

function TModeloBD.ObjectFromDBRows(pDBRows: ISqlDBRows; Sender: TObject = nil): TObject;
begin
  Result:=CreateObject(pDBRows);
  ObjectFromDBRows(Result, pDBRows, Sender);
end;

procedure TModeloBD.InicializaObjeto;
begin
  FChaveIncremental:= True;
//  fOpcoesMapeamento:= [];
end;

constructor TModeloBD.Create(pItemClass: TClass; pAutoMapOption: TAutoMapOption = amPublished);
begin
  inherited Create;
  FUpdateOptions:= [uoDeleteMissingChilds]; // Delete missing childs by default

  ItemClass:= pItemClass;

  FFieldsInUpdateDeleteWhere:= TList<String>.Create;
  FMappedFieldList:= TFieldMappingList.Create(ItemClass);

  fAfterLoadObjectEvent:= TEvent<TNotifyEvent>.Create;

  InicializaObjeto;

  DoMapFields(pAutoMapOption);
end;

function TModeloBD.Connection: TSQLDBConnectionProperties;
begin
  Result:= TFrwServiceLocator.Context.Connection;
end;

function TModeloBD.DaoUtils: TDaoUtils;
begin
  Result:= TFrwServiceLocator.Context.DaoUtils;
end;

constructor TModeloBD.Create(pNomeTabela, pNomePropChave: string; pItemClass: TClass; pAutoMapOption: TAutoMapOption = amPublished);
begin
  Create(pItemClass, pAutoMapOption);

  FNomeTabela:= pNomeTabela;
  NomePropChave:= pNomePropChave;

//  FPropChave:= GetPropByName(GetPropNameByFieldName(FNomePropChave));
end;

function TModeloBD.CreateObject(pDataSet: TDataSet): TObject;
begin
  Result:= CreateObject(TSqlDBRowDataSet.Create(pDataSet));
end;

destructor TModeloBD.Destroy;
begin
  FMappedFieldList.Free;
  FFieldsInUpdateDeleteWhere.Free;

  inherited;
end;

procedure TModeloBD.DoMapFields(pAutoMapOption: TAutoMapOption);
begin
  DoMapFields(ItemClass, pAutoMapOption, False);
end;

procedure TModeloBD.DoMapFields(pAutoMapOption: TAutoMapOption; pDoNotMapFieldsFromInheritedClasses: Boolean);
begin
  DoMapFields(ItemClass, pAutoMapOption, pDoNotMapFieldsFromInheritedClasses);
end;

procedure TModeloBD.AddFieldInUpdateDeleteWhere(pFieldName: String);
begin
  if FFieldsInUpdateDeleteWhere.Contains(pFieldName) then
    Exit;

  FFieldsInUpdateDeleteWhere.Add(pFieldName);
end;

procedure TModeloBD.ColumnToProp(Instance: TObject; pRows: ISqlDBRows; pFieldMapping: TFieldMapping; Sender: TObject = nil);
var
  FProp: TRttiMember;
  FFieldIndex: Integer;
  Value: TValue;
begin
  FProp:= pFieldMapping.Prop;
  if not Assigned(FProp) then
    Exit;

  if Assigned(pFieldMapping.FunGetPropValue) then
  begin
    Value:= pFieldMapping.FunGetPropValue(FProp.Name, GetPropertyValue(FProp, Instance),Instance, pRows, Sender);
    if PropIsWritable(FProp) then
      SetPropertyValue(FProp, Instance, Value);

    Exit;
  end;

  if not PropIsWritable(FProp) then
    Exit;

  FFieldIndex:= pRows.ColumnIndex(pFieldMapping.FieldName);
  if FFieldIndex = -1 then
    raise Exception.Create(Format('TModeloBD.ColumnToProp: Field %s not found on Dataset for property %s', [pFieldMapping.FieldName, pFieldMapping.PropName]));

  if GetPropertyRttiType(FProp).TypeKind = tkEnumeration then
    SetPropertyValue(FProp, Instance, TValue.FromOrdinal(GetPropertyRttiType(FProp).Handle, pRows.ColumnInt(FFieldIndex)))
  else
    SetPropertyValue(FProp, Instance, TValue.FromVariant(pRows.ColumnVariant(FFieldIndex)));
end;
{
procedure TModeloBD.SetPropValue(Instance: TObject; pFieldMapping: TFieldMapping; pDataSet: TDataSet; Sender: TObject);
var
  FValue: Integer;
  FProp: TRttiMember;
  FField: Data.DB.TField;
begin
  FProp:= pFieldMapping.Prop;

  if not Assigned(FProp) then
    Exit;

  if Assigned(pFieldMapping.FunGetPropValue) then
  begin
    SetPropertyValue(FProp, Instance, pFieldMapping.FunGetPropValue(FProp.Name,
                     GetPropertyValue(FProp, Instance), Instance, TSqlDBRowDataSet.Create(pDataSet), Sender));
    Exit;
  end;

  FField:= pDataSet.FindField(pFieldMapping.FieldName);
  if not Assigned(FField) then
    raise Exception.Create(Format('TModeloBD.SetPropValue: Field %s not found. ', [pFieldMapping.FieldName]));

  if GetPropertyRttiType(FProp).TypeKind = tkEnumeration then
  begin
    if FField.ClassType = TBooleanField then
      FValue:= ifThen(FField.AsBoolean, 1, 0)
    else
      FValue:= FField.AsInteger;

    SetPropertyValue(FProp, Instance, TValue.FromOrdinal(GetPropertyRttiType(FPRop).Handle, FValue));
  end
  else if GetPropertyRttiType(FPRop).TypeKind = tkFloat then
    SetPropertyValue(FProp, Instance, TValue.FromVariant(FField.AsFloat))
  else
    SetPropertyValue(FProp, Instance, TValue.FromVariant(FField.Value))
end;
 }
procedure TModeloBD.SetFieldValue(Instance: TObject; pFieldMapping: TFieldMapping; pDataSet: TDataSet);
var
  FField: Data.DB.TField;
begin
  if pFieldMapping.FieldName = '' then
    Exit;

  FField:= pDataSet.FindField(pFieldMapping.FieldName);
  if not Assigned(FField) then
    raise Exception.Create(Format('TModeloBD.SetFieldValue: Field %s not found. ', [pFieldMapping.FieldName]));

  if Assigned(pFieldMapping.FunGetFieldValue) then
    FField.Value:= pFieldMapping.FunGetFieldValue(FField.Name, Instance)
  else if Assigned(pFieldMapping.Prop) then
    FField.Value:= GetPropertyValue(pFieldMapping.Prop,Instance).AsVariant;
end;

procedure TModeloBD.SetItemClass(const Value: TClass);
var
  FMethod: TRttiMethod;
begin
  FItemClass := Value;
  rttiType:= RttiContext.GetType(FItemClass);

  for FMethod in rttiType.GetMethods do
    if SameText('Create', FMethod.Name) then
      if Length(FMethod.GetParameters) = 0 then
      begin
        rttiCreateMethod:= FMethod;
        Exit;
      end;
end;

function TModeloBD.GetFieldValue(const pFieldName: String; Instance: TObject; MasterInstance: TObject = nil): Variant;
var
  FFieldMapping: TFieldMapping;
begin
  FFieldMapping:= MappedFieldList.GetFieldMappingByFieldName(pFieldName);

  Assert(Assigned(FFieldMapping), Format('TModeloBD.GetFieldValue: Field %s not found.', [pFieldName]));

  Result:= GetFieldValue(FFieldMapping, Instance, MasterInstance);
end;

function TModeloBD.GetFieldValue(const pFieldMapping: TFieldMapping;
  Instance: TObject; MasterInstance: TObject = nil): Variant;
begin
  if Assigned(pFieldMapping.FunGetFieldValue) then
    Result:= pFieldMapping.FunGetFieldValue(pFieldMapping.FieldName, Instance, MasterInstance)
  else
    Result:= GetPropertyValue(pFieldMapping.Prop, Instance).AsVariant;

end;

function TModeloBD.GetNomeCampoChave: string;
var
  FFieldMapping: TFieldMapping;
begin
  FFieldMapping:= MappedFieldList.GetFieldMappingByPropName(NomePropChave);
  if Assigned(FFieldMapping) then
    Result:= FFieldMapping.FieldName
  else
    Result:= '';
end;

function TModeloBD.GetPropByName(const pNomeProp: String): TRttiMember;
var
  RttiType: TRttiType;
begin
  RttiType := RttiContext.GetType(ItemClass);

  Result:= RttiType.GetProperty(pNomeProp);
  if not Assigned(Result) then
    Result:= RttiType.GetField(pNomeProp);

end;

function TModeloBD.GetPropChave: TRttiMember;
var
  FFieldMapping: TFieldMapping;
begin
//  Result:= FPropChave;
  Result:= GetPropByName(FNomePropChave);
end;

function TModeloBD.GetKeyValue(pObject: TObject): Integer;
begin
  if Assigned(PropChave) then
    Result:= GetPropertyValue(PropChave, pObject).AsInteger
 else
   raise Exception.Create(Format('TModeloBD.GetKeyValue: Property %s not found on object of class %s!', [PropChave, ItemClass.ClassName]));
end;

procedure TModeloBD.SetKeyValue(pObject: TObject; fValor: Integer);
begin
  if Assigned(PropChave) then
    SetPropertyValue(PropChave, pObject, TValue.FromVariant(fValor))
 else
   raise Exception.Create(Format('TModeloBD.SetKeyValue: Property %s not found on object of class %s!', [PropChave, ItemClass.ClassName]));
end;

procedure TModeloBD.SetNomePropChave(const Value: String);
begin
  FNomePropChave := Value;
  AddFieldInUpdateDeleteWhere(FNomePropChave);
end;

procedure TModeloBD.DoAfterLoadObject(Sender: TObject);
begin
//  if Assigned(FOnAfterLoad) then
//    fOnAfterLoad(pObjeto);
  if AfterLoadObjectEvent.CanInvoke then
    TNotifyEvent(AfterLoadObjectEvent.Invoke)(Sender);
end;

function TModeloBD.FazMapeamentoECopiaValores(pObjeto: TObject; pDBRows: ISqlDBRows; TipoMapeamento: TTipoMapeamento; Sender: TObject): Boolean;
var
  fCallback: TMapeamentoCallback;
begin
  // *INICIO* M�todo anonimo de callback
  fCallback:=
    procedure (pClass: TClass; pFieldMapping: TFieldMapping; Sender: TObject)
    begin
      case TipoMapeamento of
        tmObjectToDataset: raise Exception.Create('TModeloBD.FazMapeamentoECopiaValores � read only!');
        tmObjectFromDataset: ColumnToProp(pObjeto, pDBRows, pFieldMapping, Sender);
      end;
    end;
  // *FIM* M�todo an�nimo de callback

  FazMapeamentoDaClasse(fCallback, False, Sender);

  DoAfterLoadObject(pObjeto);

  Result:= True;
end;

function TModeloBD.FazMapeamentoECopiaValores(pObjeto: TObject; pDataSet: TDataSet; TipoMapeamento: TTipoMapeamento; Sender: TObject): Boolean;
var
// fCallback: TMapeamentoCallback;
  fCallback: TMapeamentoCallback;
begin
  // *INICIO* M�todo anonimo de callback
  fCallback:=
    procedure (pClass: TClass; pFieldMapping: TFieldMapping; Sender: TObject)
    var
      FField: Data.DB.TField;
    begin
      FField:= pDataSet.FindField(pFieldMapping.FieldName);

      case TipoMapeamento of
        tmObjectToDataSet: SetFieldValue(pObjeto, pFieldMapping, pDataSet);
        tmObjectFromDataset: ColumnToProp(pObjeto, TSqlDBRowDataSet.Create(pDataSet), pFieldMapping, Sender);
        //tmObjectFromDataset: SetPropValue(pObjeto, pFieldMapping, pDataSet, Sender);
      end;
    end;
  // *FIM* M�todo an�nimo de callback

  FazMapeamentoDaClasse(fCallback, False, Sender);

  DoAfterLoadObject(pObjeto);

  Result:= True;
end;

function TModeloBD.FieldMappingByFieldName(pFieldName: String): TFieldMapping;
begin
  Result:= MappedFieldList.GetFieldMappingByFieldName(pFieldName);
end;

function TModeloBD.FieldMappingByPropName(pPropName: String): TFieldMapping;
begin
  Result:= MappedFieldList.GetFieldMappingByPropName(pPropName);
end;

function TModeloBD.FazMapeamentoDaClasse(MapeamentoCallback: TMapeamentoCallback; pOnlyValidFields: Boolean = False; Sender: TObject = nil): Boolean;
var
  fFieldMapping: TFieldMapping;
begin
  for fFieldMapping in FMappedFieldList do
  begin
    if pOnlyValidFields then
      if fFieldMapping.FieldName = '' then
        Continue;

    MapeamentoCallback(ItemClass, fFieldMapping, Sender);
  end;

  Result:= True;
end;

procedure TModeloBD.PopulaObjectListFromDataSet(pObjectList: TObjectList; pDataSet: TDataSet; Sender: TObject = nil);
begin
  pDataSet.First;
  while not pDataSet.eof do
  begin
    pObjectList.Add(ObjectFromDataSet(pDataset, Sender));

    pDataSet.Next;
  end;
end;

procedure TModeloBD.PopulaObjectListFromDataSet<T>(pObjectList: TObjectList<T>; pDataSet: TDataSet; Sender: TObject = nil);
begin
  pDataSet.First;
  while not pDataSet.eof do
  begin
    pObjectList.Add(ObjectFromDataSet(pDataset, Sender));

    pDataSet.Next;
  end;
end;

procedure TModeloBD.PopulaObjectListFromSql<T>(pObjectList: TObjectList<T>; const pSql: String; Sender: TObject = nil);
var
  FRows: ISqlDBRows;
begin
  FRows := Connection.Execute(pSql, []);
  try
    PopulaObjectListFromDBRows<T>(pObjectList, FRows, Sender);
  finally
    FRows:= nil;
  end;
end;

procedure TModeloBD.PopulaObjectListFromSql(pObjectList: TObjectList;
  const pSql: String; Sender: TObject = nil);
var
  FRows: ISqlDBRows;
begin
  FRows := Connection.Execute(pSql, []);
  try
    PopulaObjectListFromDBRows(pObjectList, FRows, Sender);
  finally
    FRows:= nil;
  end;
end;

procedure TModeloBD.PopulaObjectListFromDBRows(pObjectList: TObjectList; pRows: ISqlDBRows; Sender: TObject = nil);
begin
  while pRows.Step do
    pObjectList.Add(ObjectFromDBRows(pRows, Sender));
end;

procedure TModeloBD.PopulaObjectListFromDBRows<T>(pObjectList: TObjectList<T>;
  pRows: ISqlDBRows; Sender: TObject = nil);
begin
  while pRows.Step do
    pObjectList.Add(ObjectFromDBRows(pRows, Sender));
end;

function TModeloBD.ObjectListFromDBRows(pRows: ISqlDBRows; Sender: TObject = nil): TObjectList;
begin
  Result:= TObjectList.Create;

  PopulaObjectListFromDBRows(Result, pRows, Sender);
end;

// Para cada linha do DataSet ser� criado um objeto do tipo ItemClass e adicionado � lista,
// S�o copiados os valores das colunas que cont�m o mesmo nome que uma propriedade published do objeto, ou que contenham mapeamento.
function TModeloBD.ObjectListFromDataSet(pDataSet: TDataSet; Sender: TObject = nil): TObjectList;
begin
  Result:= TObjectList.Create;

  PopulaObjectListFromDataSet(Result, pDataSet, Sender);
end;

function TModeloBD.ObjectListFromDataSet<T>(pDataSet: TDataSet; Sender: TObject = nil): TFrwObjectList<T>;
begin
  Result:= TFrwObjectList<T>.Create;

  PopulaObjectListFromDataSet<T>(Result, pDataSet, Sender);
end;

procedure TModeloBD.ObjectFromSql(pObject: TObject; const pSql: String; Sender: TObject = nil);
var
  FRows: ISqlDBRows;
begin
  FRows := Connection.Execute(pSql, []);
  try
    if FRows.Step then
      ObjectFromDBRows(pObject, FRows, Sender);

  finally
    FRows:= nil;
  end;

end;

function TModeloBD.ObjectFromSql(const pSql: String; Sender: TObject = nil): TObject;
var
  FRows: ISqlDBRows;
begin
  Result:= nil;
  FRows := Connection.Execute(pSql, []);
  try
    if FRows.Step then
      Result:= ObjectFromDBRows(FRows, Sender)
    else
      Result:= nil;
  finally
    FRows:= nil;
  end;
end;

function TModeloBD.ObjectListFromSql(const pSql: String; Sender: TObject = nil): TObjectList;
var
  FRows: ISqlDBRows;
begin
  FRows := Connection.Execute(pSql, []);
  try
    Result:= ObjectListFromDBRows(FRows, Sender);
  finally
    FRows:= nil;
  end;
end;

function TModeloBD.ObjectListFromSql<T>(const pSql: String; Sender: TObject = nil): TFrwObjectList<T>;
var
  fDataSet: TDataSet;
begin
  Result:= nil;

  fDataSet:= DaoUtils.SelectAsDataSet(pSql, nil);
  try
    Result:= ObjectListFromDataSet<T>(fDataSet, Sender);
  finally
    fDataSet.Free;
  end;
end;

initialization
  RttiContext:= TRttiContext.Create;

end.
