unit Ladder.Activity.Classes;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Generics.Defaults, Variants, SynCommons;

type
//  TTipoProcesso = (tpConsultaPersonalizada = 1, tpEnvioEmail = 2, tpAtividade = 3);
  // Must start at 0 to generate RTTI information, see: https://stackoverflow.com/questions/61509397/trttimethod-getparameters-does-not-work-when-method-has-an-indexed-enum-as-a-p
  TParameterType = (tbUnknown=0, tbValue=1, tbList, tbDate, tbAny);

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
    function FindElement(pElementPath: String; pCurrentContainer: IActivityElementContainer=nil): IActivityElement;
  end;

  IExpressionEvaluator = interface(IInterface)
  ['{C8A928D0-A55D-489E-95E9-402D7F692254}']
    procedure EvaluateExpression(AContainer: IActivityElementContainer; AExpression: String; var AResult: Variant);
    function CheckExpressionSyntax(AContainer: IActivityElementContainer; AExpression: String; out AErrorMessage: String): Boolean;

    procedure SetRootContainer(const AValue: IActivityElementContainer);
    function GetRootContainer: IActivityElementContainer;
    property RootContainer: IActivityElementContainer read GetRootContainer write SetRootContainer;
  end;

  EInvalidElementError = class(Exception)
    FullElementName: String;
    Msg: String;
    Element: IActivityElement;
    constructor Create(AElement: IActivityElement; AFullElementName: String; AMsg: String);
  end;

  TProcessoBase = class;
  TParameterList = class;

  TParameter = class(TSingletonImplementation, IActivityElement, IActivityValue, IActivityElementContainer)
  private
    FID: integer;
    FParameterType: TParameterType;
    FName: String;
    FExpression: String;
    FValue: variant;
    FParameters: TParameterList;
  public
    procedure AfterConstruction; override;
    function GetName: String;
    procedure SetValue(const Value: variant);
    constructor Create(pName: String; pParameterType: TParameterType; pExpression: String); overload; virtual;
    constructor Create(pName: String; pParameterType: TParameterType); overload; virtual;
    destructor Destroy; override;

    constructor CreateCopy(ASource: TParameter; pCopyID: Boolean = False); virtual;

    function GetValue: Variant;

    function FindElementByName(pElementName: String): IActivityElement;
    function FindElement(pElementPath: String; pCurrentContainer: IActivityElementContainer=nil): IActivityElement;

    function Param(const ParamName: String): TParameter;
    property Value: variant read GetValue write SetValue;
  published
    property ID: integer read FID write FID;
    property Name: String read GetName write FName;
    property ParameterType: TParameterType read FParameterType write FParameterType;
    property Expression: String read FExpression write FExpression;
    property Parameters: TParameterList read FParameters write FParameters; // Nested Parameters
  end;

  TGenericParameterList<T: TParameter> = class(TObjectList<T>)
  public
    constructor Create;
    function ParamValue(const ParamName: String): variant; overload;
    function ParamValue(const ParamName: String; pDefault: Variant): variant; overload;
    function ParamExpression(const ParamName: String): String;
    function Param(const ParamName: String): T;
//    procedure Add(pInput: TParameter); overload;
//    procedure Remove(pInput: TParameter); overload;
  end;

  TParameterList = class(TGenericParameterList<TParameter>);

{  TParserBase = class
    function EvaluateList(pString: String): array of string;
    function EvaluateValue(pString: String): string;
  end;                                                                   }

  TOutputParameter = class(TParameter, IActivityElementContainer)
  private
  protected
  public
    constructor Create(pName: String; pParameterType: TParameterType; pExpression: String); override;
  published
  end;

  TOutputList = TGenericParameterList<TOutputParameter>;

  IExecutorBase = interface
  ['{D3DB8B1D-A306-447C-A0EF-CE19B5D035A5}']
    function GetInputs: TParameterList;
    function GetOutputs: TOutputList;
    procedure SetInputs(const Value: TParameterList);
    procedure SetOutputs(const Value: TOutputList);

    function Executar(pInputs: TParameterList; pOutputs: TOutputList): TOutputList; overload;
    function Executar: TOutputList; overload;
    property Inputs: TParameterList read GetInputs write SetInputs;
    property Outputs: TOutputList read GetOutputs write SetOutputs;
    function ClassType: TClass;
  end;

  TExecutorBase = class(TInterfacedObject, IExecutorBase)
  private
    FInputs: TParameterList;
    FOutputs: TOutputList;
    function GetInputs: TParameterList;
    function GetOutputs: TOutputList;
    procedure SetInputs(const Value: TParameterList);
    procedure SetOutputs(const Value: TOutputList);
  public
    constructor Create; overload;
    constructor Create(pInputs: TParameterList; pOutputs: TOutputList); overload;
    property Inputs: TParameterList read GetInputs write SetInputs;
    property Outputs: TOutputList read GetOutputs write SetOutputs;

    function Executar(pInputs: TParameterList; pOutputs: TOutputList): TOutputList; overload;
    function Executar: TOutputList; overload; virtual;

    class function Description: String; virtual; abstract;
  end;

  TExecutorClass = class of TExecutorBase;

  // A process is a self contained execution, but it might belong to an activity
  TProcessoBase = class(TSingletonImplementation, IActivityElement, IActivityElementContainer)
  private
    FInputs: TParameterList;
    FOutputs: TOutputList;
    FID: Integer;
    FOrder: Integer;
    FName: String;
    FDescription: String;

    FExpressionEvaluator: IExpressionEvaluator;
    Executor: IExecutorBase;

    function GetExpressionEvaluator: IExpressionEvaluator; virtual;
    procedure SetExpressionEvaluator(const Value: IExpressionEvaluator);
  protected
    procedure ValuateInputs(AEvaluator: IExpressionEvaluator); virtual;
    procedure EvaluateParam(AEvaluator: IExpressionEvaluator; AParam: TParameter); virtual;

    procedure AfterConstruction; override;
  public
    constructor Create(pExecutor: IExecutorBase); overload; virtual;

    // if SelfAsRoot is true, then the RootContainer of AExpressionEvaluator will be set to self.
    constructor Create(pExecutor: IExecutorBase; AExpressionEvaluator: IExpressionEvaluator); overload; virtual;
    destructor Destroy; override;
    function GetName: String;

    function FindElementByName(pElementName: String): IActivityElement; virtual;
    function FindElement(pElementPath: String; pCurrentContainer: IActivityElementContainer=nil): IActivityElement;

    function GetExecutor: IExecutorBase;

    function Executar: TOutputList; overload; virtual;
    function Executar(AEvaluator: IExpressionEvaluator): TOutputList; overload; virtual;

    // Check if parameter name is valid and its expression can be parsed
    procedure CheckParameter(AEvaluator: IExpressionEvaluator; AMasterName: String; AParameter: TParameter);

    // Check if all the elements of the process have valid names and their expression can be parsed
    procedure CheckValidity(AEvaluator: IExpressionEvaluator; AMasterName: String = ''); virtual;

    property ExpressionEvaluator: IExpressionEvaluator read GetExpressionEvaluator write SetExpressionEvaluator;
  published
    property ID: Integer read FID write FID;
    property ExecOrder: Integer read FOrder write FOrder;
    property Name: String read GetName write FName;
    property Description: String read FDescription write FDescription;
    property Inputs: TParameterList read FInputs write FInputs;
    property Outputs: TOutputList read FOutputs write FOutputs;
  end;

  TActivity = class(TProcessoBase, IActivityElement, IActivityElementContainer)
  private
    FProcessos: TObjectList<TProcessoBase>;
    function DoOrderProcess(const Left, Right: TProcessoBase): Integer;
//    function ExpressionEvaluator(pExpression: String): array of string;
  protected
    procedure AfterConstruction; override;
  public
    constructor Create(AExpressionEvaluator: IExpressionEvaluator); virtual;
    destructor Destroy; override;

    function Executar(AEvaluator: IExpressionEvaluator): TOutputList; overload; override;
    function FindElementByName(pElementName: String): IActivityElement; override;
    procedure CheckValidity(AEvaluator: IExpressionEvaluator; AMasterName: String = ''); override;

    procedure ReorderProcesses(FNewProcess: TProcessoBase = nil);
    procedure AddProcess(AProcess: TProcessoBase); // Add the process and reorder the process list
  published
    property Processos: TObjectList<TProcessoBase> read FProcessos write FProcessos;
  end;

// Check if str is a Valid element name. Names should start with a letter or underline and have only alphanumerical or underline chars.
function IsValidName(const AName: String): Boolean;

// Finds an element or child of element. Example: pElementPath Might be 'ProcessName.ParamName'
function FindElementByPath(pElementPath: String; pRootContainer, pCurrentContainer: IActivityElementContainer): IActivityElement;

implementation

uses
  Ladder.Utils;

function IsValidName(const AName: String): Boolean;
const
  cStartChars = ['a'..'z', 'A'..'Z', '_'];
  cValidChars =  ['a'..'z', 'A'..'Z', '_', '0'..'9'];
var
  i: Integer;
begin
  Result:= False;

  if Trim(AName) = '' then
    Exit;

  for i := 1 to Length(AName) do
  begin
    if i=1 then
    begin
      if not (AName[i] in cStartChars) then
        Exit;
    end
   else
    begin
      if not (AName[i] in cValidChars) then
        Exit;
    end;
  end;

  Result:= True;
end;

// Finds an element or child of element. Example: pElementPath Might be 'ProcessName.ParamName'
function FindElementByPath(pElementPath: String; pRootContainer, pCurrentContainer: IActivityElementContainer): IActivityElement;
var
  FNames: TArray<String>;
  FElement: IActivityElement;

  function FindSingleElement(pCurrentElement: IActivityElement; pNames: TArray<String>; pIndex: Integer): IActivityElement;
  begin
    Result:= nil;

    if pIndex > High(pNames) then
    begin
      Result:= (pCurrentElement as IActivityValue);
      Exit;
    end;

    if not Supports(pCurrentElement, IActivityElementContainer) then
      Exit;
//      raise Exception.Create('TExpressionEvaluator.OnElementEval: Element '+pCurrentElement.GetName+' is not a container!');

    FElement:= (pCurrentElement as IActivityElementContainer).FindElementByName(pNames[pIndex]);

    if not Assigned(FElement) then
      Exit;
//      raise Exception.Create('TExpressionEvaluator.OnElementEval: Element '+pNames[pIndex]+' not found!');

    Result:= FindSingleElement(FElement, FNames, pIndex+1);
  end;

begin
  Result:= nil;
  FNames:= pElementPath.Split(['.']);
  if Length(FNames) <= 0 then
    Exit;

  if SameText(FNames[0], pRootContainer.GetName) then // ex.: Root.Child
    Result:= FindSingleElement(pRootContainer, FNames, 1)
  else if Assigned(pCurrentContainer.FindElementByName(FNames[0])) then  // ex: Param (in case CurrentContainer contain a child named param)
    Result:= FindSingleElement(pCurrentContainer.FindElementByName(FNames[0]), FNames, 1)
  else
    Result:= FindSingleElement(pRootContainer, FNames, 0); // Child

end;

{ TGenericParameterList }

constructor TGenericParameterList<T>.Create;
begin
//  inherited Create([doOwnsValues], TOrdinalIStringComparer.Create); // case insensitive
  inherited Create(True); // Inputs are TInterfacedObjects
end;

function TGenericParameterList<T>.Param(const ParamName: String): T;
var
  FInput: T;
begin
  for FInput in Self do
    if CompareText(ParamName, FInput.Name) = 0 then
    begin
      Result:= FInput;
      Exit;
    end;
  Result:= nil;
end;

function TGenericParameterList<T>.ParamExpression(const ParamName: String): String;
var
  FInput: TParameter;
begin
  FInput:= Param(ParamName);
  if Assigned(FInput) then
    Result:= FInput.Expression
  else
    Result:= '';
end;

function TGenericParameterList<T>.ParamValue(const ParamName: String; pDefault: Variant): variant;
var
  FInput: TParameter;
begin
  FInput:= Param(ParamName);
  if Assigned(FInput) then
    Result:= FInput.Value
  else
    Result:= pDefault;

  if VarIsNull(Result) then
    Result:= pDefault;
end;

function TGenericParameterList<T>.ParamValue(const ParamName: String): variant;
begin
  Result:= ParamValue(ParamName, null);
end;

{ TProcessoBase }

procedure TProcessoBase.AfterConstruction;
begin
  inherited;
  FInputs:= TParameterList.Create;
  FOutputs:= TOutputList.Create;
end;

procedure TProcessoBase.CheckParameter(AEvaluator: IExpressionEvaluator; AMasterName: String; AParameter: TParameter);
var
  fParameter: TParameter;
  fFullName: String;
  FErrorMsg: String;
begin
  fFullName:= AMasterName+'.'+AParameter.Name;

  if not IsValidName(AParameter.Name) then
    raise EInvalidElementError.Create(self, fFullName, Format('Name %s is invalid.', [AParameter.Name]));

  if AEvaluator.CheckExpressionSyntax(Self, AParameter.Expression, FErrorMsg) = False then
    raise EInvalidElementError.Create(self, fFullName, Format('Invalid expression %s.', [AParameter.Expression]));

  for fParameter in AParameter.Parameters do
    CheckParameter(AEvaluator, fFullName, fParameter);
end;

procedure TProcessoBase.CheckValidity(AEvaluator: IExpressionEvaluator; AMasterName: String = '');
var
  fParameter: TParameter;
  fFullName: String;
begin
  Assert(AEvaluator<>nil, 'TProcessoBase.CheckValidity: AEvaluator must be assigned!');

  if AMasterName <> '' then
    fFullName:= AMasterName+'.'+Self.Name
  else
    fFullName:= Self.Name;

  if not IsValidName(Name) then
    raise EInvalidElementError.Create(self, fFullName, Format('Name %s is invalid.', [Self.Name]));

  for fParameter in Inputs do
    CheckParameter(AEvaluator, fFullName, fParameter);

  for fParameter in Outputs do
    CheckParameter(AEvaluator, fFullName, fParameter);

end;

constructor TProcessoBase.Create(pExecutor: IExecutorBase);
begin
  Create(pExecutor, nil);
end;

constructor TProcessoBase.Create(pExecutor: IExecutorBase; AExpressionEvaluator: IExpressionEvaluator);
begin
  inherited Create;
  Executor:= pExecutor;

  FExpressionEvaluator:= AExpressionEvaluator;

  if Assigned(FExpressionEvaluator) then
    if not Assigned(FExpressionEvaluator.RootContainer) then
      FExpressionEvaluator.RootContainer:= Self; // First to assign is the root
end;

destructor TProcessoBase.Destroy;
begin
  inherited Destroy;
end;

procedure TProcessoBase.ValuateInputs(AEvaluator: IExpressionEvaluator);
var
  FParameter: TParameter;
  procedure ValuateInput(AEvaluator: IExpressionEvaluator; pInput: TParameter);
  var
    FParameter: TParameter;
  begin
    if pInput.Expression <> '' then // if Expression is blank, keep the value
      EvaluateParam(AEvaluator, pInput);

    if VarIsEmpty(pInput.Value) then
      pInput.Value:= Null;

    for FParameter in pInput.Parameters do
      ValuateInput(AEvaluator, FParameter);
  end;

begin
  for FParameter in Inputs do
    ValuateInput(AEvaluator, FParameter);

end;

procedure TProcessoBase.EvaluateParam(AEvaluator: IExpressionEvaluator; AParam: TParameter);
var
  FReturn: Variant;
begin
  Assert(Assigned(AEvaluator), 'TProcessoBase.EvaluateParam: AEvaluator must be assigned!');
  AEvaluator.EvaluateExpression(Self, AParam.Expression, FReturn);
  AParam.Value:= FReturn;
end;

function TProcessoBase.Executar: TOutputList;
begin
  Result:= Executar(FExpressionEvaluator);
end;

function TProcessoBase.Executar(AEvaluator: IExpressionEvaluator): TOutputList;
var
  FOutput: TOutputParameter;

  procedure ValuateOutput(Output: TParameter);
  var
    FParam: TParameter;
  begin
    if Output.Expression <> '' then
      EvaluateParam(AEvaluator, FOutput);

    for FParam in Output.Parameters do
      ValuateOutput(FParam);
  end;
begin
  Assert(Assigned(AEvaluator), 'TProcessoBase.Executar: AEvaluator must be assigned!');

  { First evaluate all parameters }
  ValuateInputs(AEvaluator);

  if not Assigned(Executor) then
    raise Exception.Create('TProcessoBase.Executar> Executor must be assigned!');

  Executor.Inputs:= Inputs;
  Executor.Outputs:= Outputs;
  Executor.Executar;

  for FOutput in Outputs do
    ValuateOutput(FOutput);

  Result:= Outputs;
end;

function TProcessoBase.FindElement(pElementPath: String; pCurrentContainer: IActivityElementContainer=nil): IActivityElement;
begin
  try
    if Assigned(pCurrentContainer) then
      Result:= FindElementByPath(pElementPath, Self, pCurrentContainer)
    else
      Result:= FindElementByPath(pElementPath, Self, Self);
  except
    Result:= nil;
  end;
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

procedure TProcessoBase.SetExpressionEvaluator(const Value: IExpressionEvaluator);
begin
  FExpressionEvaluator:= Value;
end;

function TProcessoBase.GetExecutor: IExecutorBase;
begin
  Result:= Executor;
end;

function TProcessoBase.GetExpressionEvaluator: IExpressionEvaluator;
begin
  Result:= FExpressionEvaluator;
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

procedure TActivity.CheckValidity(AEvaluator: IExpressionEvaluator; AMasterName: String = '');
var
  fProcesso: TProcessoBase;
  fFullName: String;
begin
  inherited;

  if AMasterName <> '' then
    fFullName:= AMasterName+'.'+Self.Name
  else
    fFullName:= Self.Name;

  for fProcesso in Processos do
    fProcesso.CheckValidity(AEvaluator, fFullName);
end;

constructor TActivity.Create(AExpressionEvaluator: IExpressionEvaluator);
begin
  inherited Create(nil, AExpressionEvaluator);
end;

destructor TActivity.Destroy;
begin
  FProcessos.Free;
  inherited Destroy;
end;

procedure TActivity.AddProcess(AProcess: TProcessoBase);
begin
  Processos.Add(AProcess);
  ReorderProcesses(AProcess);
end;

function TActivity.DoOrderProcess(const Left, Right: TProcessoBase): Integer;
begin
  Result:= Left.ExecOrder - Right.ExecOrder;
end;

procedure TActivity.ReorderProcesses(FNewProcess: TProcessoBase = nil);
var
  I: Integer;
  FUnordered: Boolean;
begin
  FUnordered:= False;
  for I := 0 to Processos.Count-1 do
  begin
    if Processos[I].ExecOrder=I+1 then
      Continue
    else
    begin
      FUnordered:= True;
      if Processos[I].ExecOrder=0 then // Send to end of list
        FProcessos[I].ExecOrder:=Processos.Count+I;
    end;
  end;

  if FUnordered then
    Processos.Sort(TComparer<TProcessoBase>.Construct(DoOrderProcess));

  if Assigned(FNewProcess) and (Processos.IndexOf(FNewProcess)>=0) then
    if FNewProcess.ExecOrder <= Processos.Count then // Ensure New Process is in the correct index
    begin
      FUnordered:= True;
      Processos.Move(Processos.IndexOf(FNewProcess), FNewProcess.ExecOrder-1);
    end;

  if FUnordered then // if process list was out of order reset order values
    for I := 0 to Processos.Count -1 do
      Processos[I].ExecOrder:= I+1;
end;

function TActivity.Executar(AEvaluator: IExpressionEvaluator): TOutputList;
var
  FProcesso: TProcessoBase;
  FOutput: TOutputParameter;
begin
  ReorderProcesses;

  { First evaluate all parameters }
  ValuateInputs(AEvaluator);

  for FProcesso in Processos do
  // Inject the Evaluator from this Activity into the process,
  // that means the root container will be this activity when resolving names from inside the Process's elements
  // This way you can access other processess Inputs and Outputs when they belong to the same activity
    FProcesso.Executar(FExpressionEvaluator);

  for FOutput in Outputs do
    if FOutput.Expression <> '' then // Only evaluate output if it has a expression
      EvaluateParam(FExpressionEvaluator, FOutput);

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

constructor TExecutorBase.Create(pInputs: TParameterList; pOutputs: TOutputList);
begin
  inherited Create;
  Inputs:= pInputs;
  Outputs:= pOutputs;
end;

function TExecutorBase.Executar(pInputs: TParameterList;
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

function TExecutorBase.GetInputs: TParameterList;
begin
  Result:= FInputs;
end;

function TExecutorBase.GetOutputs: TOutputList;
begin
  Result:= FOutputs;
end;

procedure TExecutorBase.SetInputs(const Value: TParameterList);
begin
  FInputs:= Value;
end;

procedure TExecutorBase.SetOutputs(const Value: TOutputList);
begin
  FOutputs:= Value;
end;

{ TOutputParameter }

constructor TOutputParameter.Create(pName: String; pParameterType: TParameterType; pExpression: String);
begin
  inherited Create(pName, pParameterType, pExpression);
end;

{ TParameter }

procedure TParameter.AfterConstruction;
begin
  inherited;
  FParameters:= TParameterList.Create;
end;

destructor TParameter.Destroy;
begin
  FParameters.Free;
  inherited;
end;

constructor TParameter.Create(pName: String; pParameterType: TParameterType;
  pExpression: String);
begin
  inherited Create;
  Name:= pName;
  ParameterType:= pParameterType;
  Expression:= pExpression;
  Value:= Null;
end;

constructor TParameter.Create(pName: String; pParameterType: TParameterType);
begin
  Create(pName, pParameterType, '');
end;

constructor TParameter.CreateCopy(ASource: TParameter; pCopyID: Boolean);
var
  fParameter: TParameter;
begin
  Create(ASource.Name, ASource.ParameterType, ASource.Expression);
  if pCopyID then
    Self.ID:= ASource.ID;
  for fParameter in ASource.Parameters do
    Self.Parameters.Add(TParameter.CreateCopy(fParameter, pCopyID));
end;

function TParameter.FindElement(pElementPath: String; pCurrentContainer: IActivityElementContainer): IActivityElement;
begin
  if Assigned(pCurrentContainer) then
    Result:= FindElementByPath(pElementPath, Self, pCurrentContainer)
  else
    Result:= FindElementByPath(pElementPath, Self, Self);
end;

function TParameter.FindElementByName(pElementName: String): IActivityElement;
begin
  Result:= Param(pElementName);
end;

function TParameter.GetName: String;
begin
  Result:= FName;
end;

function TParameter.GetValue: Variant;
begin
  Result:= FValue;
end;

function TParameter.Param(const ParamName: String): TParameter;
begin
  Result:= Parameters.Param(ParamName);
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
      tbDate: if not LadderVarIsDateTime(Value) then
                 raise Exception.Create('Parameter "'+Name+'" should be a DateTime!')
    end;

    if ParameterType = tbDate then
      FValue:= LadderVarToDateTime(Value)
    else
      FValue:= Value;

  except
    FValue:= null;
    raise;
  end;
end;

{ EInvalidElementError }

constructor EInvalidElementError.Create(AElement: IActivityElement; AFullElementName: String; AMsg: String);
begin
  Element:= AElement;
  FullElementName:= AFullElementName;
  Msg:= AMsg;

  inherited Create(Format('Element %s: %s', [AFullElementName, AMsg]));
end;

end.
