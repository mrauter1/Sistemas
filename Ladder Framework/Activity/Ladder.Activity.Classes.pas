unit Ladder.Activity.Classes;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Data.DB,
  Generics.Defaults, Variants, Ladder.Activity.Parser, Ladder.ORM.DaoUtils, SynCommons,
  Forms;

// Check if str is a Valid element name. Names should start with a letter or underline and have only alphanumerical or underline chars.
function IsValidName(const AName: String): Boolean;

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

  EInvalidElementError = class(Exception)
    FullElementName: String;
    Msg: String;
    Element: IActivityElement;
    constructor Create(AElement: IActivityElement; AFullElementName: String; AMsg: String);
  end;

  TProcessoBase = class;
  TParameterList = class;

  IProcessEditor = interface(IInterface)
  ['{9366E88A-4D9F-4705-9DB8-D8138498B0D1}']
    function NewProcess: TProcessoBase;
    procedure EditProcess(pProcesso: TProcessoBase);
    function Form: TForm;
    procedure Free;
  end;

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
    constructor CreateWithValue(pName: String; pParameterType: TParameterType; pValue: Variant);
    destructor Destroy; override;

    constructor CreateCopy(ASource: TParameter; pCopyID: Boolean = False); virtual;

    function GetValue: Variant;
    function FindElementByName(pElementName: String): IActivityElement;
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

  TValuateParameterExpression = procedure (pContainer: IActivityElementContainer; pParameter: TParameter) of object; // Returns a single item for value and an array for lists

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
    // Finds an element or child of element.
    // Example: pExpression Might be 'ProcessName.ParamName' will return Param of 'ProcessName' named 'ParamName'
    function FindElement(pElementPath: String): IActivityElement; virtual;

    function GetExecutor: IExecutorBase;

    function Executar: TOutputList; overload; virtual;
    function Executar(ValuateParameterExpression: TValuateParameterExpression): TOutputList; overload; virtual;

    // Check if parameter name is valid and its expression can be parsed
    procedure CheckParameter(AMasterName: String; AParameter: TParameter);

    // Check if all the elements of the process have valid names and their expression can be parsed
    procedure CheckValidity(AMasterName: String = ''); virtual;
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
    constructor Create(pDaoUtils: TDaoUtils);
    destructor Destroy; override;
    function Executar(ValuateParameterExpression: TValuateParameterExpression): TOutputList; overload; override;
    function FindElementByName(pElementName: String): IActivityElement; override;
    procedure ReorderProcesses(FNewProcess: TProcessoBase = nil);
    procedure AddProcess(AProcess: TProcessoBase); // Add the process and reorder the process list
    procedure CheckValidity(AMasterName: String = ''); override;
  published
    property Processos: TObjectList<TProcessoBase> read FProcessos write FProcessos;
  end;

implementation

uses
  Ladder.ServiceLocator, Ladder.Utils;

{ TGenericParameterList }

function IsValidName(const AName: String): Boolean;
const
  cStartChars = ['a'..'z', 'A'..'Z', '_'];
  cValidChars =  ['0'..'9', 'a'..'z', 'A'..'Z', '_'];
var
  i: Integer;
begin
  Result:= False;
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

  FParser:= TActivityParser.Create;
  FParser.OnElementEval:= OnElementEval;
  FParser.OnSqlEval:= OnSqlEval;

  if not Assigned(FDaoUtils) then
    FDaoUtils:= TFrwServiceLocator.Context.DaoUtils;
end;

procedure TProcessoBase.CheckParameter(AMasterName: String; AParameter: TParameter);
var
  fParameter: TParameter;
  fFullName: String;
begin
  fFullName:= AMasterName+'.'+AParameter.Name;
  if not IsValidName(AParameter.Name) then
    raise EInvalidElementError.Create(self, fFullName, Format('Name %s is invalid.', [AParameter.Name]));

  for fParameter in AParameter.Parameters do
    CheckParameter(fFullName, fParameter);
end;

procedure TProcessoBase.CheckValidity(AMasterName: String = '');
var
  fParameter: TParameter;
  fFullName: String;
begin
  if AMasterName <> '' then
    fFullName:= AMasterName+'.'+Self.Name
  else
    fFullName:= Self.Name;

  if not IsValidName(Name) then
    raise EInvalidElementError.Create(self, fFullName, Format('Name %s is invalid.', [Self.Name]));

  for fParameter in Inputs do
    CheckParameter(fFullName, fParameter);

  for fParameter in Outputs do
    CheckParameter(fFullName, fParameter);

end;

constructor TProcessoBase.Create(pExecutor: IExecutorBase; pDaoUtils: TDaoUtils);
begin
  inherited Create;
  Executor:= pExecutor;

  FDaoUtils:= pDaoUtils;
end;

destructor TProcessoBase.Destroy;
begin
  FParser.Free;
  inherited Destroy;
end;

procedure TProcessoBase.ValuateInputs(ValuateParameterExpression: TValuateParameterExpression);
var
  FParameter: TParameter;
//  FOutput: TOutputParameter;
  procedure ValuateInput(pInput: TParameter);
  var
    FParameter: TParameter;
  begin
    ValuateParameterExpression(Self, pInput);
    for FParameter in pInput.Parameters do
      ValuateInput(FParameter);
  end;

begin
  for FParameter in Inputs do
    ValuateInput(FParameter);

end;

function TProcessoBase.Executar: TOutputList;
begin
  Result:= Executar(OnValuateParameterExpression);
end;

function TProcessoBase.Executar(ValuateParameterExpression: TValuateParameterExpression): TOutputList;
var
  FOutput: TOutputParameter;

  procedure ValuateOutput(Output: TParameter);
  var
    FParam: TParameter;
  begin
    if Output.Expression <> '' then
      ValuateParameterExpression(Self, FOutput);

    for FParam in Output.Parameters do
      ValuateOutput(FParam);
  end;
begin
  { First evaluate all parameters }
  ValuateInputs(ValuateParameterExpression);

  if not Assigned(Executor) then
    raise Exception.Create('TProcessoBase.Executar> Executor must be assigned!');

  Executor.Inputs:= Inputs;
  Executor.Outputs:= Outputs;
  Executor.Executar;

  for FOutput in Outputs do
    ValuateOutput(FOutput);

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

// Finds an element or child of element. Example: pExpression Might be 'ProcessName.ParamName'
function TProcessoBase.FindElement(pElementPath: String): IActivityElement;
var
  FNames: TArray<String>;
  FElement: IActivityElement;

  function FindSingleElement(pCurrentElement: IActivityElement; pNames: TArray<String>; pIndex: Integer): IActivityElement;
  begin
    if pIndex > High(pNames) then
    begin
      Result:= (pCurrentElement as IActivityValue);
      Exit;
    end;

    if not Supports(pCurrentElement, IActivityElementContainer) then
      raise Exception.Create('TProcessoBase.OnElementEval: Element '+pCurrentElement.GetName+' is not an element container!');

    FElement:= (pCurrentElement as IActivityElementContainer).FindElementByName(pNames[pIndex]);

    if not Assigned(FElement) then
      raise Exception.Create('TProcessoBase.OnElementEval: Element '+pNames[pIndex]+' not found!');

    Result:= FindSingleElement(FElement, FNames, pIndex+1);
  end;

begin
  Result:= nil;
  FNames:= pElementPath.Split(['.']);
  if Length(FNames) <= 0 then
    Exit;

  if FNames[0] = Self.Name then
    Result:= FindSingleElement(Self, FNames, 1)
  else if Assigned(FCurrentContainer.FindElementByName(FNames[0])) then
    Result:= FindSingleElement(FCurrentContainer.FindElementByName(FNames[0]), FNames, 1)
  else
    Result:= FindSingleElement(Self, FNames, 0);

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
  FElement: IActivityElement;
begin
  FElement:= FindElement(pElement);

  if not Assigned(FElement) then
    raise Exception.Create(Format('TProcessoBase.OnElementEval: Element %s not found on Activity/Process %s.', [pElement, Self.Name]));

  if not Supports(FElement, IActivityValue) then
    raise Exception.Create('TProcessoBase.OnElementEval: Element '+FElement.GetName+' is not a value!');

  Return:= (FElement as IActivityValue).GetValue;
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

procedure TActivity.CheckValidity(AMasterName: String = '');
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
    fProcesso.CheckValidity(fFullName);
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

function TActivity.Executar(ValuateParameterExpression: TValuateParameterExpression): TOutputList;
var
  FProcesso: TProcessoBase;
  FOutput: TOutputParameter;
begin
  ReorderProcesses;

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
  TParameter.Create(ASource.Name, ASource.ParameterType, ASource.Expression);
  if pCopyID then
    Self.ID:= ASource.ID;
  for fParameter in ASource.Parameters do
    Self.Parameters.Add(TParameter.CreateCopy(fParameter, pCopyID));
end;

constructor TParameter.CreateWithValue(pName: String;
  pParameterType: TParameterType; pValue: Variant);
begin
  Create(pName, pParameterType, '');
  Value:= pValue;
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

{ EInvalidElementError }

constructor EInvalidElementError.Create(AElement: IActivityElement; AFullElementName: String; AMsg: String);
begin
  Element:= AElement;
  FullElementName:= AFullElementName;
  Msg:= AMsg;

  inherited Create(Format('Element %s: %s', [AFullElementName, AMsg]));
end;

end.
