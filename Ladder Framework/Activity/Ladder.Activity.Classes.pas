unit Ladder.Activity.Classes;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Data.DB,
  Generics.Defaults, Variants, Ladder.Activity.Parser, Ladder.ORM.DaoUtils, SynCommons;

type
//  TTipoProcesso = (tpConsultaPersonalizada = 1, tpEnvioEmail = 2, tpAtividade = 3);
  // Must start at 0 to generate RTTI information, see: https://stackoverflow.com/questions/61509397/trttimethod-getparameters-does-not-work-when-method-has-an-indexed-enum-as-a-p
  TParameterType = (tbUnknown=0, tbValue=1, tbList, tbData, tbAny);

  IActivityElement = interface
  ['{505A4C16-9ED0-4D9C-8020-204B98096EC8}']
    function GetName: String;
  end;

  IActivityValue = interface(IActivityElement)
  ['{EA97344D-2BB9-4BCF-BD24-23206A9A7DEC}']
    function GetValue: Variant;
  end;

  IActivityElementContainer = interface(IActivityElement)
  ['{5B1A1673-ADA5-428F-B8A8-06772A02A449}']
    function FindElementByName(pElementName: String): IActivityElement;
  end;

  TProcessoBase = class;

  TParameter = class(TSingletonImplementation, IActivityElement, IActivityValue)
  private
    FID: integer;
    FParameterType: TParameterType;
    FName: String;
    FExpression: String;
    FValue: variant;
  public
    function GetName: String;
    procedure SetValue(const Value: variant);
    constructor Create(pName: String; pParameterType: TParameterType; pExpression: String);
    constructor CreateWithValue(pName: String; pParameterType: TParameterType; pValue: Variant);
    function GetValue: Variant;
    property Value: variant read GetValue write SetValue;
  published
    property ID: integer read FID write FID;
    property Name: String read GetName write FName;
    property ParameterType: TParameterType read FParameterType write FParameterType;
    property Expression: String read FExpression write FExpression;
  end;

  TGenericParameterList<T: TParameter> = class(TObjectList<T>)
  public
    constructor Create;
    function ParamValueByName(pName: String): variant; overload;
    function ParamValueByName(pName: String; pDefault: Variant): variant; overload;
//    procedure Add(pInput: TParameter); overload;
//    procedure Remove(pInput: TParameter); overload;
  end;

  TInputList = TGenericParameterList<TParameter>;

  TValuateParameterExpression = procedure (pContainer: IActivityElementContainer; pParameter: TParameter) of object; // Returns a single item for value and an array for lists

{  TParserBase = class
    function EvaluateList(pString: String): array of string;
    function EvaluateValue(pString: String): string;
  end;                                                                   }

  TOutputParameter = class(TParameter, IActivityElementContainer)
  private
    FParametros: TInputList;
  protected
    procedure AfterConstruction; override;
  public
    constructor Create(pName: String; pParameterType: TParameterType; pExpression: String);
    destructor Destroy; override;
    function FindElementByName(pElementName: String): IActivityElement;
  published
    property Parametros: TInputList read FParametros write FParametros;
  end;

  TOutputList = TGenericParameterList<TOutputParameter>;

  IExecutorBase = interface
  ['{D3DB8B1D-A306-447C-A0EF-CE19B5D035A5}']
    function GetInputs: TInputList;
    function GetOutputs: TOutputList;
    procedure SetInputs(const Value: TInputList);
    procedure SetOutputs(const Value: TOutputList);

    function Executar(pInputs: TInputList; pOutputs: TOutputList): TOutputList; overload;
    function Executar: TOutputList; overload;
    property Inputs: TInputList read GetInputs write SetInputs;
    property Outputs: TOutputList read GetOutputs write SetOutputs;
    function ClassType: TClass;
  end;

  TExecutorBase = class(TInterfacedObject, IExecutorBase)
  private
    FInputs: TInputList;
    FOutputs: TOutputList;
    function GetInputs: TInputList;
    function GetOutputs: TOutputList;
    procedure SetInputs(const Value: TInputList);
    procedure SetOutputs(const Value: TOutputList);
  public
    constructor Create; overload;
    constructor Create(pInputs: TInputList; pOutputs: TOutputList); overload;
    property Inputs: TInputList read GetInputs write SetInputs;
    property Outputs: TOutputList read GetOutputs write SetOutputs;

    function Executar(pInputs: TInputList; pOutputs: TOutputList): TOutputList; overload;
    function Executar: TOutputList; overload; virtual;

    class function Description: String; virtual; abstract;
  end;

  TExecutorClass = class of TExecutorBase;

  // A process is a self contained execution, but it might belong to an activity
  TProcessoBase = class(TSingletonImplementation, IActivityElement, IActivityElementContainer)
  private
    FInputs: TInputList;
    FOutputs: TOutputList;
    FID: Integer;
    FName: String;
    FDescription: String;
    FDaoUtils: TDaoUtils;
    FParser: TActivityParser;
    FCurrentContainer: IActivityElementContainer;

    Executor: IExecutorBase;
  protected
    procedure ValuateInputs(ValuateParameterExpression: TValuateParameterExpression);
    procedure OnValuateParameterExpression(pContainer: IActivityElementContainer; pParameter: TParameter);
    procedure OnElementEval(const pElement: String; var Return: Variant);
    procedure OnSqlEval(const pSql: String; var Return: Variant);

    procedure AfterConstruction; override;

    property Parser: TActivityParser read FParser;
  public
    constructor Create(pExecutor: IExecutorBase; pDaoUtils: TDaoUtils);
    destructor Destroy; override;
    function GetName: String;
    function FindElementByName(pElementName: String): IActivityElement; virtual;
    function GetExecutor: IExecutorBase;

    function Executar: TOutputList; overload; virtual;
    function Executar(ValuateParameterExpression: TValuateParameterExpression): TOutputList; overload; virtual;
  published
    property ID: Integer read FID write FID;
    property Name: String read GetName write FName;
    property Description: String read FDescription write FDescription;
    property Inputs: TInputList read FInputs write FInputs;
    property Outputs: TOutputList read FOutputs write FOutputs;
  end;

  TActivity = class(TProcessoBase, IActivityElement, IActivityElementContainer)
  private
    FProcessos: TObjectList<TProcessoBase>;
//    function ExpressionEvaluator(pExpression: String): array of string;
  protected
    procedure AfterConstruction; override;
  public
    constructor Create(pDaoUtils: TDaoUtils);
    destructor Destroy; override;
    function Executar(ValuateParameterExpression: TValuateParameterExpression): TOutputList; overload; override;
    function FindElementByName(pElementName: String): IActivityElement; override;
  published
    property Processos: TObjectList<TProcessoBase> read FProcessos write FProcessos;
  end;


function LadderVarIsList(const pValue: Variant): Boolean;
function LadderVarIsIso8601(const pValue: Variant): Boolean;
function LadderVarIsDateTime(const pValue: Variant): Boolean;
function LadderVarToDateTime(const pValue: Variant): TDateTime;
function LadderDateToStr(Date: TDateTime): String;

function JoinList(const pValue: Variant; const pSeparator: String): String;

implementation

uses
  Ladder.ServiceLocator;

function JoinList(const pValue: Variant; const pSeparator: String): String;
var
  I: Integer;

  procedure DoJoin(const pText: String);
  begin
    if Result = '' then
      Result:= pText
    else
      Result:= Result+pSeparator+pText;
  end;
begin
  Result:= '';
  if not LadderVarIsList(pValue) then
    Exit;

  for I := 0 to pValue._Count-1 do
    DoJoin(pValue._(I));

end;

function LadderVarIsList(const pValue: Variant): Boolean;
begin
  Result:= DocVariantType.IsOfType(pValue);
end;

function LadderVarIsIso8601(const pValue: Variant): Boolean;
var
  pAnsi: AnsiString;
begin
  Result:= False;
  pAnsi:= VarToStrDef(pValue, '');

  if length(pAnsi) >= 10 then
    if (pAnsi[5] = '-') and (pAnsi[8] = '-') then
      Result:= Iso8601ToDateTime(pAnsi) <> 0;
end;

function LadderVarIsDateTime(const pValue: Variant): Boolean;
begin
  Result:= False;

  if VarType(pValue) = varDate then
    Result:= True
 else
   Result:= LadderVarIsIso8601(pValue);
end;

function LadderDateToStr(Date: TDateTime): String;
begin
  Result:= DateToIso8601(Date, True);
end;

function LadderVarToDateTime(const pValue: Variant): TDateTime;
var
  pAnsi: AnsiString;
begin
  pAnsi:= VarToStrDef(pValue, '');
  Result:= Iso8601ToDateTime(pAnsi);
  if Result = 0 then
    Result:= VarToDateTime(pValue);
end;

{ TGenericParameterList }

constructor TGenericParameterList<T>.Create;
begin
//  inherited Create([doOwnsValues], TOrdinalIStringComparer.Create); // case insensitive
  inherited Create(True); // Inputs are TInterfacedObjects
end;

function TGenericParameterList<T>.ParamValueByName(pName: String; pDefault: Variant): variant;
var
  FInput: TParameter;
begin
  for FInput in Self do
    if CompareText(pName, FInput.Name) = 0 then
    begin
      Result:= FInput.Value;
      Exit;
    end;

  Result:= pDefault;
end;

function TGenericParameterList<T>.ParamValueByName(pName: String): variant;
begin
  Result:= ParamValueByName(pName, null);
end;

{ TProcessoBase }

procedure TProcessoBase.AfterConstruction;
begin
  inherited;
  FInputs:= TInputList.Create;
  FOutputs:= TOutputList.Create;

  FParser:= TActivityParser.Create;
  FParser.OnElementEval:= OnElementEval;
  FParser.OnSqlEval:= OnSqlEval;

  if not Assigned(FDaoUtils) then
    FDaoUtils:= TFrwServiceLocator.Context.DaoUtils;
end;

constructor TProcessoBase.Create(pExecutor: IExecutorBase; pDaoUtils: TDaoUtils);
begin
  inherited Create;
  Executor:= pExecutor;

  FDaoUtils:= pDaoUtils;
end;

destructor TProcessoBase.Destroy;
begin
  FInputs.Free;
  FOutputs.Free;
  FParser.Free;
  inherited Destroy;
end;

procedure TProcessoBase.ValuateInputs(ValuateParameterExpression: TValuateParameterExpression);
var
  fInput: TParameter;
  FOutput: TOutputParameter;
begin
  for fInput in Inputs do
    ValuateParameterExpression(Self, fInput);

  for FOutput in Outputs do
    for fInput in FOutput.Parametros do
      ValuateParameterExpression(fOutput, fInput);
end;

function TProcessoBase.Executar: TOutputList;
begin
  Result:= Executar(OnValuateParameterExpression);
end;

function TProcessoBase.Executar(ValuateParameterExpression: TValuateParameterExpression): TOutputList;
var
  FOutput: TOutputParameter;
begin
  { First evaluate all parameters }
  ValuateInputs(ValuateParameterExpression);

  if not Assigned(Executor) then
    raise Exception.Create('TProcessoBase.Executar> Executor must be assigned!');

  Executor.Inputs:= Inputs;
  Executor.Outputs:= Outputs;
  Executor.Executar;

  for FOutput in Outputs do
    if VarIsNull(FOutput.Value) and (FOutput.Expression <> '') then
      ValuateParameterExpression(Self, FOutput);

  Result:= Outputs;
end;

function TProcessoBase.FindElementByName(pElementName: String): IActivityElement;
var
  FInput: TParameter;
  FOutput: TOutputParameter;
begin
  for fInput in FInputs do
    if CompareText(FInput.Name, pElementName) = 0 then
    begin
      Result:= fInput;
      Exit;
    end;

  for fOutput in FOutputs do
    if CompareText(fOutput.Name, pElementName) = 0 then
    begin
      Result:= fOutput;
      Exit;
    end;

  Result:= nil;
end;

procedure TProcessoBase.OnSqlEval(const pSql: String; var Return: Variant);
begin
  Return:= FDaoUtils.SelectAsDocVariant(pSql);
end;

procedure TProcessoBase.OnValuateParameterExpression(pContainer: IActivityElementContainer; pParameter: TParameter);
const
  cKeyWords = ['@', '[', '$', '"'];
var
  FValue: Variant;
begin
  if pParameter.Expression = '' then
    Exit;

  // If expression does not start with keyword, treat as string
  if not (pParameter.Expression[1] in cKeyWords) then
  begin
    pParameter.Value:= pParameter.Expression;
    Exit;
  end;

  FCurrentContainer:= pContainer;
  FParser.DoParseExpression(pParameter.Expression, FValue);
  pParameter.Value:= FValue;
end;

procedure TProcessoBase.OnElementEval(const pElement: String; var Return: Variant);
var
  FNames: TArray<String>;
  FElement: IActivityElement;

  function FindElementValue(pCurrentElement: IActivityElement; pNames: TArray<String>; pIndex: Integer): Variant;
  begin
    if pIndex > High(pNames) then
    begin
      if not Supports(pCurrentElement, IActivityValue) then
        raise Exception.Create('TProcessoBase.OnElementEval: Element '+pCurrentElement.GetName+' is not a value!');

      Result:= (pCurrentElement as IActivityValue).GetValue;
      Exit;
    end;

    if not Supports(pCurrentElement, IActivityElementContainer) then
      raise Exception.Create('TProcessoBase.OnElementEval: Element '+pCurrentElement.GetName+' is not a container!');

    FElement:= (pCurrentElement as IActivityElementContainer).FindElementByName(pNames[pIndex]);

    if not Assigned(FElement) then
      raise Exception.Create('TProcessoBase.OnElementEval: Element '+pNames[pIndex]+' not found!');

    Result:= FindElementValue(FElement, FNames, pIndex+1);
  end;

begin
  FNames:= pElement.Split(['.']);
  if Length(FNames) <= 0 then
    Exit;

  if FNames[0] = Self.Name then
    Return:= FindElementValue(Self, FNames, 1)
  else if Assigned(FCurrentContainer.FindElementByName(FNames[0])) then
    Return:= FindElementValue(FCurrentContainer.FindElementByName(FNames[0]), FNames, 1)
  else
    Return:= FindElementValue(Self, FNames, 0);

end;

function TProcessoBase.GetExecutor: IExecutorBase;
begin
  Result:= Executor;
end;

function TProcessoBase.GetName: String;
begin
  Result:= FName;
end;

{ TActivity }

procedure TActivity.AfterConstruction;
begin
  inherited;
  FProcessos:= TObjectList<TProcessoBase>.Create(True);
end;

constructor TActivity.Create(pDaoUtils: TDaoUtils);
begin
  inherited Create(nil, pDaoUtils);
end;

destructor TActivity.Destroy;
begin
  FProcessos.Free;
  inherited Destroy;
end;

function TActivity.Executar(ValuateParameterExpression: TValuateParameterExpression): TOutputList;
var
  FProcesso: TProcessoBase;
  FOutput: TOutputParameter;
begin
  { First evaluate all parameters }
  ValuateInputs(ValuateParameterExpression);

  for FProcesso in Processos do
    FProcesso.Executar(OnValuateParameterExpression); // The process inputs must be valuated from this activity, so they can find elemets that belongs to this activity, but not outside it.

  for FOutput in Outputs do
    if VarIsNull(FOutput.Value) and (FOutput.Expression <> '') then
      ValuateParameterExpression(Self, FOutput);

  Result:= Outputs;
end;

function TActivity.FindElementByName(pElementName: String): IActivityElement;
var
  FProcesso: TProcessoBase;
begin
  Result:= inherited FindElementByName(pElementName);

  if Assigned(Result) then
    Exit;

  for FProcesso in Processos do
    if FProcesso.Name = pElementName then
    begin
      Result:= FProcesso;
      Exit;
    end;

end;

{ TExecutorBase }

constructor TExecutorBase.Create(pInputs: TInputList; pOutputs: TOutputList);
begin
  inherited Create;
  Inputs:= pInputs;
  Outputs:= pOutputs;
end;

function TExecutorBase.Executar(pInputs: TInputList;
  pOutputs: TOutputList): TOutputList;
begin
  Inputs:= pInputs;
  Outputs:= pOutputs;
  Executar;
  Result:= Outputs;
end;

constructor TExecutorBase.Create;
begin
  inherited Create;
end;

function TExecutorBase.Executar: TOutputList;
begin
  raise Exception.Create('TExecutorBase.Executar: Deve ser implementado na subclasse!');
  { Implementar na subclass }
end;

function TExecutorBase.GetInputs: TInputList;
begin
  Result:= FInputs;
end;

function TExecutorBase.GetOutputs: TOutputList;
begin
  Result:= FOutputs;
end;

procedure TExecutorBase.SetInputs(const Value: TInputList);
begin
  FInputs:= Value;
end;

procedure TExecutorBase.SetOutputs(const Value: TOutputList);
begin
  FOutputs:= Value;
end;

{ TOutputParameter }

procedure TOutputParameter.AfterConstruction;
begin
  inherited;
  FParametros:= TInputList.Create;
end;

constructor TOutputParameter.Create(pName: String; pParameterType: TParameterType; pExpression: String);
begin
  inherited Create(pName, pParameterType, pExpression);
end;

destructor TOutputParameter.Destroy;
begin
  FParametros.Free;
end;

function TOutputParameter.FindElementByName(pElementName: String): IActivityElement;
var
  FParametro: TParameter;
begin
  for FParametro in FParametros do
    if CompareText(FParametro.Name, pElementName) = 0 then
    begin
      Result:= FParametro;
      Exit;
    end;

  Result:= nil;
end;

{ TParameter }

constructor TParameter.Create(pName: String; pParameterType: TParameterType;
  pExpression: String);
begin
  inherited Create;
  Name:= pName;
  ParameterType:= pParameterType;
  Expression:= pExpression;
  Value:= Null;
end;

constructor TParameter.CreateWithValue(pName: String;
  pParameterType: TParameterType; pValue: Variant);
begin
  Create(pName, pParameterType, '');
  Value:= pValue;
end;

function TParameter.GetName: String;
begin
  Result:= FName;
end;

function TParameter.GetValue: Variant;
begin
  Result:= FValue;
end;

procedure TParameter.SetValue(const Value: variant);

  function VarIsNullOrUnassigned(const Value: Variant): Boolean;
  begin
    Result:= VarIsEmpty(Value) or VarIsNull(Value);
  end;

begin
  if VarIsNullOrUnassigned(Value) then
  begin
    FValue:= Null;
    Exit;
  end;

  try
    case ParameterType of
      tbValue: if DocVariantType.IsOfType(Value) then
                 raise Exception.Create('Parameter "'+Name+'" should be a Value! List received');
      tbList: if not DocVariantType.IsOfType(Value) then
                 raise Exception.Create('Parameter "'+Name+'" should be a List!');
      tbData: if not LadderVarIsDateTime(Value) then
                 raise Exception.Create('Parameter "'+Name+'" should be a DateTime!')
    end;

    if ParameterType = tbData then
      FValue:= LadderVarToDateTime(Value)
    else
      FValue:= Value;

  except
    FValue:= null;
    raise;
  end;
end;

end.
