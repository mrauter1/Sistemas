unit Ladder.ORM.ModeloBD;

interface

uses
  Data.DB, System.Contnrs, System.Classes, Generics.Collections, RTTI, Ladder.ORM.DaoUtils,
  Ladder.Messages, Ladder.ORM.Classes, SysUtils, Utils, Math, Ladder.ServiceLocator, SynDB,
  Ladder.ORM.Functions;

type
  TFunGetFieldValue = reference to function (const pFieldName: String; Instance: TObject): Variant;
  TFunGetPropValue = reference to function (const pPropName: String; pCurrentValue: TValue; Instance: TObject): TValue;

  TFieldMapping = class(TObject)
  private
    FItemClass: TClass;
    FProp: TRttiProperty;
    procedure SetPropName(const Value: String);
    function GetPropName: String;
  public
    FieldName: String; // Nome da Coluna;
    FieldType: TFieldType;
    FunGetFieldValue: TFunGetFieldValue; //if this callback function is assigned the value saved to the given field will be the return value of this function
    FunGetPropValue: TFunGetPropValue; //if this callback function is assigned the prop value will be the return value of this function

    property PropName: String read GetPropName write SetPropName; // Nome da propriedade do objeto;
    property Prop: TRttiProperty read FProp;
    constructor Create(pItemClass: TClass); overload;
    constructor Create(pItemClass: TClass; pPropName, pFieldName: String); overload;
//    pSerialization: TSerialization;
  end;

  TFieldMappingList = class(TObjectList<TFieldMapping>)
  private
  public
    ItemClass: TClass;
    function PropertyToFieldType(pProp: TRttiProperty): TFieldType;
    function GetFieldMappingByFieldName(const pNomeCampo: String): TFieldMapping;
    function GetFieldMappingByPropName(const pNomePropriedade: String): TFieldMapping;
    // Adiciona os mapeamentos na lista de campos mapeados
    function Map(pProp, pField: String; pFieldType: TFieldType = ftUnknown): TFieldMappingList;
    function MapField(pField: String; pFieldType: TFieldType; pFunGetFieldValue: TFunGetFieldValue): TFieldMappingList;
    function MapProperty(pPropName: String; pFunGetPropValue: TFunGetPropValue): TFieldMappingList;

    constructor Create(pItemClass: TClass);
  end;


  TOpcaoMapeamento = (ApenasExplicitos);

  TOpcoesMapeamento = set of TOpcaoMapeamento;

  TSelectOption = (Top0);

  TSelectOptions = set of TSelectOption;

  TTipoMapeamento = (tmObjectToDataset, tmObjectFromDataSet);

  TMapeamentoCallback = reference to procedure (pClass: TClass; pFieldMapping: TFieldMapping);

  TFunNewObject = reference to function : TObject;

  TModeloBD = class(TObject)
  private
    FNomeTabela: String;
    FNomePropChave: String;
//    FPropChave: TRttiProperty;

    FChaveIncremental: Boolean;
    FItemClass: TClass;
    FMappedFieldList: TFieldMappingList;
    fOpcoesMapeamento: TOpcoesMapeamento;
    fNewObjectFunction: TFunNewObject;
    rttiCreateMethod: TRttiMethod;
    rttiType: TRttiType;

    function FazMapeamentoECopiaValores(pObjeto: TObject; pDBRows: ISqlDBRows; TipoMapeamento: TTipoMapeamento): Boolean; overload;
    function FazMapeamentoECopiaValores(pObjeto: TObject; pDataSet: TDataSet;
      TipoMapeamento: TTipoMapeamento): Boolean; overload;

    procedure SetPropValue(Instance: TObject; pField: Data.DB.TField; pFieldMapping: TFieldMapping);
    procedure SetFieldValue(Instance: TObject; pField: Data.DB.TField; pFieldMapping: TFieldMapping);

    procedure InicializaObjeto;

    function DaoUtils: TDaoUtils;

    function ObjectListFromDBRows(pRows: ISqlDBRows): TObjectList;
    procedure PopulaObjectListFromDBRows(pObjectList: TObjectList; pRows: ISqlDBRows); overload;
    procedure PopulaObjectListFromDBRows<T: Class>(pObjectList: TObjectList<T>; pRows: ISqlDBRows); overload;

    procedure ObjectFromDBRows(pObject: TObject; pDBRows: ISqlDBRows); overload;
    function ObjectFromDBRows(pDBRows: ISqlDBRows): TObject; overload;

    procedure ColumnParaProp(Instance: TObject; pFieldIndex: Integer; pRows: ISqlDBRows; pFieldMapping: TFieldMapping);
    function GetPropChave: TRttiProperty;
    function GetNomeCampoChave: string;
    function CreateObject: TObject;
    procedure SetItemClass(const Value: TClass);
  public
    property NomeTabela: String read FNomeTabela;
    property NomePropChave: String read FNomePropChave;
    property NomeCampoChave: string read GetNomeCampoChave;
    property ItemClass: TClass read FItemClass write SetItemClass;
    property NewObjectFunction: TFunNewObject read fNewObjectFunction write fNewObjectFunction;
    property PropChave: TRttiProperty read GetPropChave;
    property MappedFieldList: TFieldMappingList read FMappedFieldList;

    property ChaveIncremental: Boolean read FChaveIncremental write FChaveIncremental;

    constructor Create(pItemClass: TClass; pMapAllPublishedFields: Boolean = True); overload;
    constructor Create(pNomeTabela: String; pNomePropChave: string; pItemClass: TClass); overload;
    destructor Destroy; override;

    function Connection: TSQLDBConnectionProperties;

    procedure MapPublishedFields;

    function GetPropByName(const pNomeProp: String): TRttiProperty;

    function GetFieldValue(const pFieldName: String; Instance: TObject): Variant; overload;
    function GetFieldValue(const pFieldMapping: TFieldMapping; Instance: TObject): Variant; overload;

    function FieldMappingByFieldName(pFieldName: String): TFieldMapping;
    function FieldMappingByPropName(pPropName: String): TFieldMapping;

    function Map(pProp, pField: String; pFieldType: TFieldType = ftUnknown): TFieldMappingList;
    function MapField(pField: String; pFieldType: TFieldType; pFunGetFieldValue: TFunGetFieldValue): TFieldMappingList;
    function MapProperty(pPropName: String; pFunGetPropValue: TFunGetPropValue): TFieldMappingList;

    function MapObjectToDataSet(pObjeto: TObject; pDataSet: TDataset): Boolean;

    procedure ObjectFromDataSet(pObject: TObject; pDataSet: TDataSet); overload;
    function ObjectFromDataSet(pDataSet: TDataSet): TObject; overload;

    procedure ObjectFromSql(pObject: TObject; const pSql: String); overload;
    function ObjectFromSql(const pSql: String): TObject; overload;

    // Para cada linha do DataSet será criado um objeto do tipo ItemClass e adicionado à lista,
    // São copiados os valores das colunas que contêm o mesmo nome que uma propriedade published do objeto, ou que contenham mapeamento.
    procedure PopulaObjectListFromDataSet(pObjectList: TObjectList; pDataSet: TDataSet); overload;
    procedure PopulaObjectListFromDataSet<T: class>(pObjectList: TObjectList<T>; pDataSet: TDataSet); overload;
    procedure PopulaObjectListFromSql(pObjectList: TObjectList; const pSql: String); overload;
    procedure PopulaObjectListFromSql<T: class>(pObjectList: TObjectList<T>; const pSql: String); overload;

    function ObjectListFromDataSet(pDataSet: TDataSet): TObjectList; overload;
    function ObjectListFromDataSet<T: class>(pDataSet: TDataSet): TFrwObjectList<T>; overload;

    function ObjectListFromSql(const pSql: String): TObjectList; overload;
    function ObjectListFromSql<T: class>(const pSql: String): TFrwObjectList<T>; overload;

//    function ObjectListFromSqlMormot(const pSql: String): TObjectList;

    // Faz o mapeamento do Objeto e do DataSet. Ao encontrar a propriedade do objeto correspondente a um campo no dataset dispara MapeamentoCallback.
    // Caso existam campos mapeados na lista FMappedFieldList, utiliza a correspondencia setada,
    // caso contrario faz o mapeamento por propriedades que tenham o mesmo no de um campo do dataset.
    // Se a opção 'ApenasExplicitos' estiver setada, apenas os campos na lista FMappedFieldList serão mapeados;
    function FazMapeamentoDaClasse(MapeamentoCallback: TMapeamentoCallback; pOnlyValidFields: Boolean = False): Boolean;

    procedure SetKeyValue(pObject: TObject; fValor: Integer);
    function GetKeyValue(pObject: TObject): Integer;
  end;

// Use Rtti to execute the Create constructor of the object, if there is not Create calls TClass.Create
function CreateObjectOfClass(pClass: TClass): TObject;

implementation

uses
  TypInfo;

var
  RttiContext: TRttiContext;

function CreateObjectOfClass(pClass: TClass): TObject;
var
  rType: TRttiType;
  FMethod: TRttiMethod;
begin
  rType:= RttiContext.GetType(pClass);
  for FMethod in rType.GetMethods do
    if SameText('Create', FMethod.Name) then
      if Length(FMethod.GetParameters) = 0 then
        Break;

  if Assigned(FMethod) then // Se não existir um constructor Create na class chama o constructor de TObject
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
  Result:= FProp.Name;
end;

procedure TFieldMapping.SetPropName(const Value: String);
var
  RttiType: TRttiType;
begin
  RttiType := RttiContext.GetType(FItemClass);
  FProp:= RttiType.GetProperty(Value);
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

function TFieldMappingList.PropertyToFieldType(pProp: TRttiProperty): TFieldType;
begin
  Result:= ftUnknown;

  if SameText('TDateTime', pProp.PropertyType.Name) then
    Result:= ftDateTime
  else if SameText('TDate', pProp.PropertyType.Name) then
    Result:= ftDate;

  if Result <> ftUnknown then
    Exit;

  case pProp.PropertyType.TypeKind of
    tkString,tkLString,tkAnsiChar,tkWideString,tkUnicodeString: Result:= ftString;
    tkFloat: Result:= ftFloat;
    tkInteger, tkEnumeration: Result:= ftInteger;
    tkInt64: Result:= ftLargeint;
  end;
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

function TModeloBD.MapObjectToDataSet(pObjeto: TObject; pDataSet: TDataset): Boolean;
begin
  Result:= FazMapeamentoECopiaValores(pObjeto, pDataSet, tmObjectToDataSet);
end;

procedure TModeloBD.MapPublishedFields;
var
  RttiType: TRttiType;
  Prop: TRttiProperty;
begin
  RttiType := RttiContext.GetType(ItemClass);

  for Prop in RttiType.GetProperties do
  begin
    if Prop.Visibility <> TMemberVisibility.mvPublished then
      Continue;

    if FMappedFieldList.PropertyToFieldType(Prop) = ftUnknown then
      Continue;

    if Assigned(FMappedFieldList.GetFieldMappingByPropName(Prop.Name)) then // Field already mapped
      Continue;

    Map(Prop.Name, Prop.Name); // Default Field Name is same as Prop Name
  end;
end;

function TModeloBD.CreateObject: TObject;
begin
  if Assigned(NewObjectFunction) then
  begin
    Result:= NewObjectFunction();
    Exit;
  end;

  if Assigned(rttiCreateMethod) then // Se não existir um constructor Create na class chama o constructor de TObject
    Result:= TObject(rttiCreateMethod.Invoke(rttiType.AsInstance.MetaclassType,[]).AsObject)
  else
    Result:= ItemClass.Create;

end;

procedure TModeloBD.ObjectFromDataSet(pObject: TObject; pDataSet: TDataSet);
begin
  FazMapeamentoECopiaValores(pObject, pDataSet, tmObjectFromDataSet);
end;

// Mapeia a linha corrente do DataSet para um objeto.
function TModeloBD.ObjectFromDataSet(pDataSet: TDataSet): TObject;
begin
// Se dataset estiver vazio retorna nulo
  Result:= nil;
  if pDataSet.IsEmpty then
    Exit;

  Result:= CreateObject; //ItemClass.Create;

  ObjectFromDataSet(Result, pDataSet);
end;

procedure TModeloBD.ObjectFromDBRows(pObject: TObject; pDBRows: ISqlDBRows);
begin
  FazMapeamentoECopiaValores(pObject, pDBRows, tmObjectFromDataSet);
end;

function TModeloBD.ObjectFromDBRows(pDBRows: ISqlDBRows): TObject;
begin
  Result:=CreateObject;

  FazMapeamentoECopiaValores(Result, pDBRows, tmObjectFromDataSet);
end;

procedure TModeloBD.InicializaObjeto;
begin
  FChaveIncremental:= True;
  fOpcoesMapeamento:= [];
  FMappedFieldList:= TFieldMappingList.Create(ItemClass);
end;

constructor TModeloBD.Create(pItemClass: TClass; pMapAllPublishedFields: Boolean = True);
begin
  inherited Create;

  ItemClass:= pItemClass;

  InicializaObjeto;

  if pMapAllPublishedFields then
    MapPublishedFields;
end;

function TModeloBD.Connection: TSQLDBConnectionProperties;
begin
  Result:= TFrwServiceLocator.Context.Connection;
end;

function TModeloBD.DaoUtils: TDaoUtils;
begin
  Result:= TFrwServiceLocator.Context.DaoUtils;
end;

constructor TModeloBD.Create(pNomeTabela, pNomePropChave: string; pItemClass: TClass);
begin
  Create(pItemClass);

  FNomeTabela:= pNomeTabela;
  FNomePropChave:= pNomePropChave;

//  FPropChave:= GetPropByName(GetPropNameByFieldName(FNomePropChave));
end;

destructor TModeloBD.Destroy;
begin
  FMappedFieldList.Free;
  RttiContext.Free;

  inherited;
end;

procedure TModeloBD.ColumnParaProp(Instance: TObject; pFieldIndex: Integer; pRows: ISqlDBRows; pFieldMapping: TFieldMapping);
var
  FProp: TRttiProperty;
begin
  FProp:= pFieldMapping.Prop;
  if not Assigned(FProp) then
    Exit;

  if Assigned(pFieldMapping.FunGetPropValue) then
  begin
    FProp.SetValue(Instance, pFieldMapping.FunGetPropValue(FProp.Name, FProp.GetValue(Instance), Instance));
    Exit;
  end;

  if pFieldIndex = -1 then
    raise Exception.Create(Format('TModeloBD.ColumnParaProp: Field %s not found on Dataset for property %s', [pFieldMapping.FieldName, pFieldMapping.PropName]));

  if FProp.PropertyType.TypeKind = tkEnumeration then
    FProp.SetValue(Instance, TValue.FromOrdinal(FProp.PropertyType.Handle, pRows.ColumnInt(pFieldIndex)))
  else
    FProp.SetValue(Instance, TValue.FromVariant(pRows.ColumnVariant(pFieldIndex)));
end;

procedure TModeloBD.SetPropValue(Instance: TObject; pField: Data.DB.TField; pFieldMapping: TFieldMapping);
var
  FValue: Integer;
  FProp: TRTTIProperty;
begin
  FProp:= pFieldMapping.Prop;

  if not Assigned(FProp) then
    Exit;

  if Assigned(pFieldMapping.FunGetPropValue) then
  begin
    FProp.SetValue(Instance, pFieldMapping.FunGetPropValue(FProp.Name, FProp.GetValue(Instance), Instance));
    Exit;
  end;

  if not Assigned(pField) then
    raise Exception.Create(Format('TModeloBD.SetPropValue: Field %s not found. ', [pFieldMapping.FieldName]));

  if FProp.PropertyType.TypeKind = tkEnumeration then
  begin
    if pField.ClassType = TBooleanField then
      FValue:= ifThen(pField.AsBoolean, 1, 0)
    else
      FValue:= pField.AsInteger;

    FProp.SetValue(Instance, TValue.FromOrdinal(FProp.PropertyType.Handle, FValue));
  end
  else if FProp.PropertyType.TypeKind = tkFloat then
    FProp.SetValue(Instance, TValue.FromVariant(pField.AsFloat))
  else
    FProp.SetValue(Instance, TValue.FromVariant(pField.Value))
end;

procedure TModeloBD.SetFieldValue(Instance: TObject; pField: Data.DB.TField; pFieldMapping: TFieldMapping);
begin
  if pFieldMapping.FieldName = '' then
    Exit;

  if not Assigned(pField) then
    raise Exception.Create(Format('TModeloBD.SetFieldValue: Field %s not found. ', [pFieldMapping.FieldName]));

  if Assigned(pFieldMapping.FunGetFieldValue) then
    pField.Value:= pFieldMapping.FunGetFieldValue(pField.Name, Instance)
  else if Assigned(pFieldMapping.Prop) then
    pField.Value:= pFieldMapping.Prop.GetValue(Instance).AsVariant;
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

function TModeloBD.GetFieldValue(const pFieldName: String; Instance: TObject): Variant;
var
  FFieldMapping: TFieldMapping;
begin
  FFieldMapping:= MappedFieldList.GetFieldMappingByFieldName(pFieldName);

  Assert(Assigned(FFieldMapping), Format('TModeloBD.GetFieldValue: Field %s not found.', [pFieldName]));

  Result:= GetFieldValue(FFieldMapping, Instance);
end;

function TModeloBD.GetFieldValue(const pFieldMapping: TFieldMapping; Instance: TObject): Variant;
begin
  if Assigned(pFieldMapping.FunGetFieldValue) then
    Result:= pFieldMapping.FunGetFieldValue(pFieldMapping.FieldName, Instance)
  else
    Result:= pFieldMapping.Prop.GetValue(Instance).AsVariant;

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

function TModeloBD.GetPropByName(const pNomeProp: String): TRttiProperty;
var
  RttiType: TRttiType;
begin
  RttiType := RttiContext.GetType(ItemClass);

  Result:= RttiType.GetProperty(pNomeProp);
end;

function TModeloBD.GetPropChave: TRttiProperty;
var
  FFieldMapping: TFieldMapping;
begin
//  Result:= FPropChave;
  Result:= GetPropByName(FNomePropChave);
end;

function TModeloBD.GetKeyValue(pObject: TObject): Integer;
begin
  if Assigned(PropChave) then
    Result:= PropChave.GetValue(pObject).AsInteger
 else
   raise Exception.Create(Format('TModeloBD.GetKeyValue: Property %s not found on object of class %s!', [PropChave, ItemClass.ClassName]));
end;

procedure TModeloBD.SetKeyValue(pObject: TObject; fValor: Integer);
begin
  if Assigned(PropChave) then
    PropChave.SetValue(pObject, TValue.FromVariant(fValor))
 else
   raise Exception.Create(Format('TModeloBD.SetKeyValue: Property %s not found on object of class %s!', [PropChave, ItemClass.ClassName]));
end;

function TModeloBD.FazMapeamentoECopiaValores(pObjeto: TObject; pDBRows: ISqlDBRows; TipoMapeamento: TTipoMapeamento): Boolean;
var
  fCallback: TMapeamentoCallback;
begin
  // *INICIO* Método anonimo de callback
  fCallback:=
    procedure (pClass: TClass; pFieldMapping: TFieldMapping)
    var
      FFieldIndex: Integer;
    begin
      FFieldIndex:= pDbRows.ColumnIndex(pFieldMapping.FieldName);

      case TipoMapeamento of
        tmObjectToDataset: raise Exception.Create('TModeloBD.FazMapeamentoECopiaValores é read only!');
        tmObjectFromDataset: ColumnParaProp(pObjeto, FFieldIndex, pDBRows, pFieldMapping);
      end;
    end;
  // *FIM* Método anônimo de callback

  FazMapeamentoDaClasse(fCallback);

  Result:= True;
end;

function TModeloBD.FazMapeamentoECopiaValores(pObjeto: TObject; pDataSet: TDataSet; TipoMapeamento: TTipoMapeamento): Boolean;
var
// fCallback: TMapeamentoCallback;
  fCallback: TMapeamentoCallback;
begin
  // *INICIO* Método anonimo de callback
  fCallback:=
    procedure (pClass: TClass; pFieldMapping: TFieldMapping)
    var
      FField: Data.DB.TField;
    begin
      FField:= pDataSet.FindField(pFieldMapping.FieldName);

      case TipoMapeamento of
        tmObjectToDataSet: SetFieldValue(pObjeto, FField, pFieldMapping);
        tmObjectFromDataset: SetPropValue(pObjeto, FField, pFieldMapping);
      end;
    end;
  // *FIM* Método anônimo de callback

  FazMapeamentoDaClasse(fCallback);

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

function TModeloBD.FazMapeamentoDaClasse(MapeamentoCallback: TMapeamentoCallback; pOnlyValidFields: Boolean = False): Boolean;
var
  fFieldMapping: TFieldMapping;
begin
  for fFieldMapping in FMappedFieldList do
  begin
    if pOnlyValidFields then
      if fFieldMapping.FieldName = '' then
        Continue;

    MapeamentoCallback(ItemClass, fFieldMapping);
  end;

  Result:= True;
end;

procedure TModeloBD.PopulaObjectListFromDataSet(pObjectList: TObjectList; pDataSet: TDataSet);
begin
  pDataSet.First;
  while not pDataSet.eof do
  begin
    pObjectList.Add(ObjectFromDataSet(pDataset));

    pDataSet.Next;
  end;
end;

procedure TModeloBD.PopulaObjectListFromDataSet<T>(pObjectList: TObjectList<T>; pDataSet: TDataSet);
begin
  pDataSet.First;
  while not pDataSet.eof do
  begin
    pObjectList.Add(ObjectFromDataSet(pDataset));

    pDataSet.Next;
  end;
end;

procedure TModeloBD.PopulaObjectListFromSql<T>(pObjectList: TObjectList<T>; const pSql: String);
var
  FRows: ISqlDBRows;
begin
  FRows := Connection.Execute(pSql, []);
  try
    PopulaObjectListFromDBRows<T>(pObjectList, FRows);
  finally
    FRows:= nil;
  end;
end;

procedure TModeloBD.PopulaObjectListFromSql(pObjectList: TObjectList;
  const pSql: String);
var
  FRows: ISqlDBRows;
begin
  FRows := Connection.Execute(pSql, []);
  try
    PopulaObjectListFromDBRows(pObjectList, FRows);
  finally
    FRows:= nil;
  end;
end;

procedure TModeloBD.PopulaObjectListFromDBRows(pObjectList: TObjectList; pRows: ISqlDBRows);
begin
  while pRows.Step do
    pObjectList.Add(ObjectFromDBRows(pRows));
end;

procedure TModeloBD.PopulaObjectListFromDBRows<T>(pObjectList: TObjectList<T>;
  pRows: ISqlDBRows);
begin
  while pRows.Step do
    pObjectList.Add(ObjectFromDBRows(pRows));
end;

function TModeloBD.ObjectListFromDBRows(pRows: ISqlDBRows): TObjectList;
begin
  Result:= TObjectList.Create;

  PopulaObjectListFromDBRows(Result, pRows);
end;

// Para cada linha do DataSet será criado um objeto do tipo ItemClass e adicionado à lista,
// São copiados os valores das colunas que contêm o mesmo nome que uma propriedade published do objeto, ou que contenham mapeamento.
function TModeloBD.ObjectListFromDataSet(pDataSet: TDataSet): TObjectList;
begin
  Result:= TObjectList.Create;

  PopulaObjectListFromDataSet(Result, pDataSet);
end;

function TModeloBD.ObjectListFromDataSet<T>(pDataSet: TDataSet): TFrwObjectList<T>;
begin
  Result:= TFrwObjectList<T>.Create;

  PopulaObjectListFromDataSet<T>(Result, pDataSet);
end;

procedure TModeloBD.ObjectFromSql(pObject: TObject; const pSql: String);
var
  FRows: ISqlDBRows;
begin
  FRows := Connection.Execute(pSql, []);
  try
    if FRows.Step then
      ObjectFromDBRows(pObject, FRows);

  finally
    FRows:= nil;
  end;

end;

function TModeloBD.ObjectFromSql(const pSql: String): TObject;
var
  FRows: ISqlDBRows;
begin
  FRows := Connection.Execute(pSql, []);
  try
    if FRows.Step then
      Result:= ObjectFromDBRows(FRows)
    else
      Result:= nil;
  finally
    FRows:= nil;
  end;
end;

function TModeloBD.ObjectListFromSql(const pSql: String): TObjectList;
var
  FRows: ISqlDBRows;
begin
  FRows := Connection.Execute(pSql, []);
  try
    Result:= ObjectListFromDBRows(FRows);
  finally
    FRows:= nil;
  end;
end;

function TModeloBD.ObjectListFromSql<T>(const pSql: String): TFrwObjectList<T>;
var
  fDataSet: TDataSet;
begin
  Result:= nil;

  fDataSet:= DaoUtils.SelectAsDataSet(pSql, nil);
  try
    Result:= ObjectListFromDataSet<T>(fDataSet);
  finally
    fDataSet.Free;
  end;
end;

initialization
  RttiContext:= TRttiContext.Create;

end.
