unit UntQueryBuilder;

interface

uses
  Data.DB, System.Contnrs, System.Classes, Generics.Collections, RTTI, UntDaoUtils,
  UntMensagem, SysUtils, UntFuncoes, uFrwUtils, Math;

type
//  TMappingType = (mtInteiro, mtFloat,

  TFieldMapping = class(TObject)
   public
    PropName: String; // Nome da propriedade do objeto;
    FieldName: String; // Nome da Coluna;
    FieldType: TFieldType;
    constructor Create; overload;
    constructor Create(pPropName, pFieldName: String); overload;
//    pSerialization: TSerialization;
  end;

  TFieldMappingList = TObjectList<TFieldMapping>;

  TOpcaoMapeamento = (ApenasExplicitos);

  TOpcoesMapeamento = set of TOpcaoMapeamento;

  TSelectOption = (Top0);

  TSelectOptions = set of TSelectOption;

  TTipoMapeamento = (ObjetoParaDataSet, DatasetParaObjeto);

  TMapeamentoCallback = reference to procedure (pClass: TClass; pProp: TRttiProperty; pFieldMapping: TFieldMapping);

  TFuncNewObject = reference to function : TObject;

  TModeloBD = class(TObject)
  private
    FNomeTabela: String;
    FNomeCampoChave: String;
    FPropChave: TRttiProperty;

    FChaveIncremental: Boolean;
    FItemClass: TClass;
    FMappedFieldList: TFieldMappingList;
    RttiContext: TRttiContext;
    fOpcoesMapeamento: TOpcoesMapeamento;
    function FazMapeamentoECopiaValores(pObjeto: TObject; pDataSet: TDataSet;
      TipoMapeamento: TTipoMapeamento): Boolean;
    procedure FieldParaProp(Objeto: TObject; pField: TField;
      Prop: TRttiProperty);
    procedure PropParaField(Objeto: TObject; Prop: TRttiProperty;
      pField: TField);
    procedure InicializaObjeto;

    function GetFieldMappingByFieldName(const pNomeCampo: String): TFieldMapping;
    function GetFieldMappingByPropName(const pNomePropriedade: String): TFieldMapping;

    function GetPropNameByFieldName(const pFieldName: String): String;
    function GetFieldNameByPropName(const pPropName: String): String;

    function GetPropByName(const pNomeProp: String): TRttiProperty;
  public
    property NomeTabela: String read FNomeTabela;
    property NomeCampoChave: String read FNomeCampoChave;
    property ItemClass: TClass read FItemClass write FItemClass;
    property PropChave: TRttiProperty read FPropChave;

    property ChaveIncremental: Boolean read FChaveIncremental write FChaveIncremental;

    constructor Create; overload;
    constructor Create(pNomeTabela: String; pNomeCampoChave: string; pItemClass: TClass); overload;
    destructor Destroy; override;

    // Adiciona os mapeamentos na lista de campos mapeados
    function Map(pProp, pField: String): TModeloBD;

    function MapObjectToDataSet(pObjeto: TObject; pDataSet: TDataset): Boolean;
    function ObjectFromDataSet(pDataSet: TDataSet; pNewObjectFunction: TFuncNewObject = nil): TObject;
    function ObjectFromSql(const pSql: String): TObject;

    // Para cada linha do DataSet ser� criado um objeto do tipo ItemClass e adicionado � lista,
    // S�o copiados os valores das colunas que cont�m o mesmo nome que uma propriedade published do objeto, ou que contenham mapeamento.
    procedure PopulaObjectListFromDataSet(pObjectList: TObjectList; pDataSet: TDataSet); overload;
    procedure PopulaObjectListFromDataSet<T: class>(pObjectList: TFrwObjectList<T>; pDataSet: TDataSet; pNewObjectFunction: TFuncNewObject = nil); overload;
    procedure PopulaObjectListFromSql(pObjectList: TObjectList; const pSql: String); overload;
    procedure PopulaObjectListFromSql<T: Class>(pObjectList: TFrwObjectList<T>; const pSql: String; pNewObjectFunction: TFuncNewObject = nil); overload;

    function ObjectListFromDataSet(pDataSet: TDataSet): TObjectList; overload;
    function ObjectListFromDataSet<T: class>(pDataSet: TDataSet): TFrwObjectList<T>; overload;
    function ObjectListFromSql(const pSql: String): TObjectList; overload;
    function ObjectListFromSql<T: class>(const pSql: String): TFrwObjectList<T>; overload;

    // Faz o mapeamento do Objeto e do DataSet. Ao encontrar a propriedade do objeto correspondente a um campo no dataset dispara MapeamentoCallback.
    // Caso existam campos mapeados na lista FMappedFieldList, utiliza a correspondencia setada,
    // caso contrario faz o mapeamento por propriedades que tenham o mesmo no de um campo do dataset.
    // Se a op��o 'ApenasExplicitos' estiver setada, apenas os campos na lista FMappedFieldList ser�o mapeados;
    function FazMapeamentoDaClasse(MapeamentoCallback: TMapeamentoCallback): Boolean;

    procedure SetValorChave(pObject: TObject; fValor: Integer);
    function GetValorChave(pObject: TObject): Integer;
  end;

  TQueryBuilderBase = class(TObject)
  private
    fModeloBD: TModeloBD;
  protected
    function GetFieldName(pProp: TRttiProperty; pFieldMapping: TFieldMapping): String;
  public
    property ModeloBD: TModeloBD read fModeloBD write fModeloBD;
    function SelectWhereChave(FValor: Integer): String; virtual; abstract;
    function SelectWhere(const pWhere: String; pSelectOptions: TSelectOptions = []): String; virtual; abstract;
    function Insert(pObject: TObject): String; virtual; abstract;
    function Update(pObject: TObject): String; virtual; abstract;
    function Delete(pKeyValue: Integer): String; virtual; abstract;
    function SelectValorUltimaChave: String; virtual; abstract;
  end;

  TSqlServerQueryBuilder = class(TQueryBuilderBase)
  private
  public
    function SelectWhereChave(FValor: Integer): String; override;
    function SelectWhere(const pWhere: String; pSelectOptions: TSelectOptions = []): String; override;
    function Insert(pObject: TObject): String; override;
    function Update(pObject: TObject): String; override;
    function Delete(pValorChave: Integer): String; override;
    function SelectValorUltimaChave: String; override;
  end;

implementation

{ TFieldMapping }

uses
  TypInfo;

constructor TFieldMapping.Create;
begin
  inherited Create;
end;

constructor TFieldMapping.Create(pPropName, pFieldName: String);
begin
  Create;

  PropName:= pPropName;
  FieldName:= pFieldName;
end;

{ TModeloBD }

// Faz o mapeamento de um objeto para o registro ativo do dataset; DataSet deve estar em edi��o ou inser��o!
function TModeloBD.Map(pProp, pField: String): TModeloBD;
var
  fMappedField: TFieldMapping;
begin
  fMappedField:= TFieldMapping.Create;
  fMappedField.PropName:= pProp;
  fMappedField.FieldName:= pField;

  FMappedFieldList.Add(fMappedField);

  // Se o mapeamento for de campo chave, deve ser atualizado a propriedade chave
  if SameText(pField, NomeCampoChave) then
    FPropChave:= GetPropByName(pProp);

  Result:= Self;
end;

function TModeloBD.MapObjectToDataSet(pObjeto: TObject; pDataSet: TDataset): Boolean;
begin
  Result:= FazMapeamentoECopiaValores(pObjeto, pDataSet, DatasetParaObjeto);
end;

// Mapeia a linha corrente do DataSet para um objeto.
function TModeloBD.ObjectFromDataSet(pDataSet: TDataSet; pNewObjectFunction: TFuncNewObject): TObject;
begin
// Se dataset estiver vazio retorna nulo
  Result:= nil;
  if pDataSet.IsEmpty then
    Exit;

  if Assigned(pNewObjectFunction) then
    Result:= pNewObjectFunction
  else
    Result:= ItemClass.Create;

  FazMapeamentoECopiaValores(Result, pDataSet, ObjetoParaDataSet);
end;

procedure TModeloBD.InicializaObjeto;
begin
  FChaveIncremental:= True;
  fOpcoesMapeamento:= [];
  RttiContext:= TRttiContext.Create;
  FMappedFieldList:= TObjectList<TFieldMapping>.Create;
end;

constructor TModeloBD.Create;
begin
  inherited;

  // raise error if DaoUtils is not assigned
  TDaoUtils.CheckAssigned;

  InicializaObjeto;
end;

constructor TModeloBD.Create(pNomeTabela, pNomeCampoChave: string; pItemClass: TClass);
begin
  Create;

  FNomeTabela:= pNomeTabela;
  FNomeCampoChave:= pNomeCampoChave;
  FItemClass:= pItemClass;

  FPropChave:= GetPropByName(GetPropNameByFieldName(FNomeCampoChave));
end;

destructor TModeloBD.Destroy;
begin
  FMappedFieldList.Free;
  RttiContext.Free;

  inherited;
end;

procedure TModeloBD.FieldParaProp(Objeto: TObject; pField: TField; Prop: TRttiProperty);
var
  FValue: Integer;
begin
  if Prop.PropertyType.TypeKind = tkEnumeration then
  begin

    if pField.ClassType = TBooleanField then
      FValue:= ifThen(pField.AsBoolean, 1, 0)
    else
      FValue:= pField.AsInteger;

    Prop.SetValue(Objeto, TValue.FromOrdinal(Prop.PropertyType.Handle, FValue));
  end
  else
    Prop.SetValue(Objeto, TValue.FromVariant(pField.Value));
end;

procedure TModeloBD.PropParaField(Objeto: TObject; Prop: TRttiProperty; pField: TField);
begin
  pField.Value:= Prop.GetValue(Objeto).AsVariant;
end;

function TModeloBD.GetFieldMappingByPropName(const pNomePropriedade: String): TFieldMapping;
var
  I: Integer;
begin
  for I := 0 to FMappedFieldList.Count-1 do
  begin
    if SameText(FMappedFieldList.Items[I].PropName, pNomePropriedade) then
    begin
     Result:= FMappedFieldList.Items[I];
     Exit;
    end;
  end;

  Result:= nil;
end;

function TModeloBD.GetFieldNameByPropName(const pPropName: String): String;
var
  fFieldMapping: TFieldMapping;
begin
  fFieldMapping:= GetFieldMappingByPropName(pPropName);

  if Assigned(fFieldMapping) then
    Result:= fFieldMapping.FieldName
  else
    Result:= pPropName;
end;

function TModeloBD.GetPropNameByFieldName(const pFieldName: String): String;
var
  fFieldMapping: TFieldMapping;
begin
  fFieldMapping:= GetFieldMappingByPropName(pFieldName);

  if Assigned(fFieldMapping) then
    Result:= fFieldMapping.PropName
  else
    Result:= pFieldName;
end;

function TModeloBD.GetPropByName(const pNomeProp: String): TRttiProperty;
var
  RttiType: TRttiType;
begin
  RttiType := RttiContext.GetType(ItemClass);

  Result:= RttiType.GetProperty(pNomeProp);
end;

function TModeloBD.GetFieldMappingByFieldName(const pNomeCampo: String): TFieldMapping;
var
  I: Integer;
begin
  for I := 0 to FMappedFieldList.Count-1 do
  begin
    if SameText(FMappedFieldList.Items[I].FieldName, pNomeCampo) then
    begin
     Result:= FMappedFieldList.Items[I];
     Exit;
    end;
  end;

  Result:= nil;
end;

function TModeloBD.GetValorChave(pObject: TObject): Integer;
begin
  if Assigned(FPropChave) then
    Result:= FPropChave.GetValue(pObject).AsInteger
 else
   TMensagem.Erro('Propriedade chave do objeto n�o encontrado!', 'Erro', true);
end;

procedure TModeloBD.SetValorChave(pObject: TObject; fValor: Integer);
begin
  if Assigned(FPropChave) then
    FPropChave.SetValue(pObject, TValue.FromVariant(fValor))
 else
   TMensagem.Erro('Propriedade chave do objeto n�o encontrado!', 'Erro', true);
end;

function TModeloBD.FazMapeamentoECopiaValores(pObjeto: TObject; pDataSet: TDataSet; TipoMapeamento: TTipoMapeamento): Boolean;
var
// fCallback: TMapeamentoCallback;
  fCallback: TMapeamentoCallback;
begin
  // *INICIO* M�todo anonimo de callback
  fCallback:=
    procedure (pClass: TClass; pProp: TRttiProperty; pFieldMapping: TFieldMapping)
    var
      FNomeCampo: String;
      FField: TField;
    begin
      if Assigned(pFieldMapping) then
        FNomeCampo:= pFieldMapping.FieldName
      else
        FNomeCampo:= pProp.Name;

      FField:= pDataSet.FindField(FNomeCampo);

      if not Assigned(FField) then
      begin
        TMensagem.Erro('TModeloBD Erro: Campo n�o encotrado no dataset! '+FNomeCampo, 'Erro');
        Exit;
      end;

      case TipoMapeamento of
        ObjetoParaDataSet: FieldParaProp(pObjeto, FField, pProp);
        DataSetParaObjeto: PropParaField(pObjeto, pProp, FField);
      end;
    end;
  // *FIM* M�todo an�nimo de callback

  FazMapeamentoDaClasse(fCallback);

  Result:= True;
end;

function TModeloBD.FazMapeamentoDaClasse(MapeamentoCallback: TMapeamentoCallback): Boolean;
var
  fFieldMapping: TFieldMapping;
  RttiType: TRttiType;
  Prop: TRttiProperty;
  TemMapeamento: Boolean;
begin
  RttiType := RttiContext.GetType(ItemClass);

  for Prop in RttiType.GetProperties do
  begin
    if Prop.Visibility <> TMemberVisibility.mvPublished then
      Continue;

    TemMapeamento:= False;

    fFieldMapping:= GetFieldMappingByPropName(Prop.Name);
    if Assigned(fFieldMapping) then
    begin
      TemMapeamento:= True;
      MapeamentoCallback(ItemClass, Prop, fFieldMapping);
    end;

    if (not TemMapeamento) and (not (ApenasExplicitos in fOpcoesMapeamento)) then
    begin
      MapeamentoCallback(ItemClass, Prop, nil);
    end;

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

procedure TModeloBD.PopulaObjectListFromDataSet<T>(pObjectList: TFrwObjectList<T>; pDataSet: TDataSet; pNewObjectFunction: TFuncNewObject = nil);
begin
  pDataSet.First;
  while not pDataSet.eof do
  begin
    pObjectList.Add(ObjectFromDataSet(pDataset, pNewObjectFunction));

    pDataSet.Next;
  end;
end;

procedure TModeloBD.PopulaObjectListFromSql<T>(pObjectList: TFrwObjectList<T>; const pSql: String; pNewObjectFunction: TFuncNewObject = nil);
var
  fDataSet: TDataSet;
begin
  fDataSet:= DaoUtils.RetornaDataset(pSql, nil);
  try
    PopulaObjectListFromDataSet<T>(pObjectList, fDataSet, pNewObjectFunction);
  finally
    fDataSet.Free;
  end;
end;

procedure TModeloBD.PopulaObjectListFromSql(pObjectList: TObjectList;
  const pSql: String);
var
  fDataSet: TDataSet;
begin
  fDataSet:= DaoUtils.RetornaDataset(pSql, nil);
  try
    PopulaObjectListFromDataSet(pObjectList, fDataSet);
  finally
    fDataSet.Free;
  end;
end;

// Para cada linha do DataSet ser� criado um objeto do tipo ItemClass e adicionado � lista,
// S�o copiados os valores das colunas que cont�m o mesmo nome que uma propriedade published do objeto, ou que contenham mapeamento.
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

function TModeloBD.ObjectFromSql(const pSql: String): TObject;
var
  fDataSet: TDataSet;
begin
  fDataSet:= DaoUtils.RetornaDataset(pSql, nil);
  try
    Result:= ObjectFromDataSet(fDataSet);
  finally
    fDataSet.Free;
  end;
end;

function TModeloBD.ObjectListFromSql(const pSql: String): TObjectList;
var
  fDataSet: TDataSet;
begin
  fDataSet:= DaoUtils.RetornaDataset(pSql, nil);
  try
    Result:= ObjectListFromDataSet(fDataSet);
  finally
    fDataSet.Free;
  end;
end;

function TModeloBD.ObjectListFromSql<T>(const pSql: String): TFrwObjectList<T>;
var
  fDataSet: TDataSet;
begin
  Result:= nil;

  fDataSet:= DaoUtils.RetornaDataset(pSql, nil);
  try
    Result:= ObjectListFromDataSet<T>(fDataSet);
  finally
    fDataSet.Free;
  end;
end;

{ TQueryBuilderBase }

function TQueryBuilderBase.GetFieldName(pProp: TRttiProperty;
  pFieldMapping: TFieldMapping): String;
begin
  if Assigned(pFieldMapping) then
    Result:= pFieldMapping.FieldName
  else
    Result:= pProp.Name;
end;

{ TSqlServerQueryBuilder }

function PropToSqlValue(pProp: TRttiProperty; pObject: TObject): string;
const
  cMsgErro = 'Propriedade %s do tipo %s n�o foi poss�vel ser mapeada!';
begin
  case pProp.PropertyType.TypeKind of
    tkString,tkLString,tkAnsiChar,tkWideString,tkUnicodeString:
      Result:= QuotedStr(pProp.GetValue(pObject).ToString);
    tkFloat:
      begin
        if SameText('TDateTime',pProp.PropertyType.Name) then
          Result:= Func_DateTime_SqlServer(pProp.GetValue(pObject).AsExtended)
        else
          Result:= FloatToSqlStr(pProp.GetValue(pObject).AsExtended);
      end;
    tkInteger, tkInt64: Result:= IntToStr(pProp.GetValue(pObject).AsInteger);
    tkEnumeration: Result:= IntToStr(pProp.GetValue(pObject).AsOrdinal);

    else
      TMensagem.Erro(Format(cMsgErro,[pProp.Name, pProp.PropertyType.Name]), 'Erro!', True);
  end;

end;

function TSqlServerQueryBuilder.SelectValorUltimaChave: String;
begin
  Result:= ' SELECT SCOPE_IDENTITY() ';
end;

function TSqlServerQueryBuilder.SelectWhere(const pWhere: String; pSelectOptions: TSelectOptions = []): String;
var
  fSql: TStringBuilder;
  fPrimeiroCampo: Boolean;
  fCallBack: TMapeamentoCallback;
begin
  fCallBack:=
    procedure (pClass: TClass; pProp: TRttiProperty; pFieldMapping: TFieldMapping)
    begin
      if not fPrimeiroCampo then
        fSql.Append(' , ');

      fSql.Append('  ').AppendLine(GetFieldName(pProp, pFieldMapping));

      if fPrimeiroCampo then
        fPrimeiroCampo:= False;
    end;

  fPrimeiroCampo:= True;

  fSql:= TStringBuilder.Create;
  try
    fSql.AppendLine('SELECT ');

    if Top0 in pSelectOptions then
      fSql.AppendLine(' TOP 0 ');

    ModeloBD.FazMapeamentoDaClasse(fCallBack);

    fSql.Append('FROM ').AppendLine(ModeloBD.NomeTabela);

    if pWhere <> '' then
      fSql.AppendLine('WHERE '+pWhere);

    Result:= fSql.ToString;

  finally
    fSql.Free;
  end;
end;

function TSqlServerQueryBuilder.SelectWhereChave(FValor: Integer): String;
begin
  Result:= SelectWhere(Format('%s = %d', [ModeloBD.NomeCampoChave, FValor]));
end;

function TSqlServerQueryBuilder.Delete(pValorChave: Integer): String;
begin
  Result:= Format('DELETE FROM %s WHERE %s = %d', [ModeloBD.NomeTabela, ModeloBD.NomeCampoChave, pValorChave]);
end;

function TSqlServerQueryBuilder.Insert(pObject: TObject): String;
var
  fSql: TStringBuilder;
  fPrimeiroCampo: Boolean;
  fCallBack: TMapeamentoCallback;
  fMapeandoValores: Boolean;

  procedure MapeiaCampos;
  begin
    fPrimeiroCampo:= True;
    fMapeandoValores:= False;

    fSql.Append(' (');
    ModeloBD.FazMapeamentoDaClasse(fCallBack);
    fSql.AppendLine(')')
  end;

  procedure MapeiaValores;
  begin
    fPrimeiroCampo:= True;
    fMapeandoValores:= True;

    fSql.Append(' VALUES(');
    ModeloBD.FazMapeamentoDaClasse(fCallBack);
    fSql.Append(')');
  end;

begin
  fCallBack:=
    procedure (pClass: TClass; pProp: TRttiProperty; pFieldMapping: TFieldMapping)
    begin
      try
        if (fModeloBD.ChaveIncremental) and (pProp = fModeloBD.PropChave) then
          Exit;

        if not fPrimeiroCampo then
          fSql.Append(', ');

        if not fMapeandoValores then
          fSql.Append('  ').Append(GetFieldName(pProp, pFieldMapping))
        else
          fSql.Append('  ').Append(PropToSqlValue(pProp, pObject));

        if fPrimeiroCampo then
          fPrimeiroCampo:= False;
       except
         on E: Exception do
           raise Exception.Create('Erro ao mapear propriedade: '+pProp.Name+'. Mensagem: '+E.Message);
       end;
    end;

  fSql:= TStringBuilder.Create;
  try
    fSql.Append('INSERT INTO ').AppendLine(ModeloBD.NomeTabela);

    MapeiaCampos;
    MapeiaValores;

    Result:= fSql.ToString;

  finally
    fSql.Free;
  end;
end;

function TSqlServerQueryBuilder.Update(pObject: TObject): String;
var
  fSql: TStringBuilder;
  fPrimeiroCampo: Boolean;
  fCallBack: TMapeamentoCallback;
begin
  fCallBack:=
    procedure (pClass: TClass; pProp: TRttiProperty; pFieldMapping: TFieldMapping)
    begin
      if (fModeloBD.ChaveIncremental) and (pProp = fModeloBD.PropChave) then
        Exit;

      if not fPrimeiroCampo then
        fSql.Append(' , ');

      fSql.Append('  ').Append(GetFieldName(pProp, pFieldMapping));

      fSql.Append(' = ').AppendLine(PropToSqlValue(pProp, pObject));

      if fPrimeiroCampo then
        fPrimeiroCampo:= False;
    end;

  fSql:= TStringBuilder.Create;
  try
    fSql.Append('UPDATE ').AppendLine(ModeloBD.NomeTabela);

    fSql.Append(' SET ');

    fPrimeiroCampo:= True;
    ModeloBD.FazMapeamentoDaClasse(fCallBack);

    fSql.AppendFormat('WHERE %s = %d ', [ModeloBD.NomeCampoChave, ModeloBD.GetValorChave(pObject)]);

    Result:= fSql.ToString;

  finally
    fSql.Free;
  end;
end;

end.