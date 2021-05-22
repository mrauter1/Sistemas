unit Ladder.Executor.Activity;

interface

uses
  Ladder.Activity.Classes, Ladder.Activity.Classes.Dao, Ladder.ServiceLocator, Ladder.ORM.Dao, SysUtils;

type
  TExecutorActivity = class(TExecutorBase)
  private
    FActivity: TActivity;
    FActivityDao: IDaoGeneric<TActivity>;
    procedure CheckInputs;
    procedure SetInputs;
    procedure SetOutputs;
  public
    constructor Create;
    destructor Destroy; override;

    function Executar: TOutputList; override;

    class function GetExecutor: IExecutorBase;

    class function Description: String; override;
  end;

implementation

uses
  Variants;

{ TExecutorActivity }

procedure TExecutorActivity.CheckInputs;
begin

end;

constructor TExecutorActivity.Create;
begin
  inherited;
  FActivityDao:= TActivityDao<TActivity>.Create;
end;

class function TExecutorActivity.Description: String;
begin

end;

destructor TExecutorActivity.Destroy;
begin
  inherited;
end;

procedure TExecutorActivity.SetOutputs;
var
  FActivityOutput, FOutput: TOutputParameter;
begin
  for FActivityOutput in FActivity.Outputs do
  begin
    FOutput:= Outputs.Param(FActivityOutput.Name);
    if not Assigned(FOutput) then
      FOutput.Create(FActivityOutput.Name, FActivityOutput.ParameterType, FActivityOutput.Expression);

    FOutput.Value:= FActivityOutput.Value;
  end;
end;

procedure TExecutorActivity.SetInputs;
var
  FInputsParam: TParameter;
  FParam: TParameter;
  FActivityInput: TParameter;
begin
  FInputsParam:= Inputs.Param('Inputs');
  if not Assigned(FInputsParam) then
    Exit;

  for FParam in FInputsParam.Parameters do
  begin
    if not VarIsNull(FParam.Value) then
    begin
      FActivityInput:= FActivity.Inputs.Param(FParam.Name);
      if Assigned(FActivityInput) then
      begin
        FActivityInput.Expression:= ''; // If expression is set it is going to be evaluated
        FActivityInput.Value:= FParam.Value;
      end;
    end;
  end;
end;

function TExecutorActivity.Executar: TOutputList;
var
  IDActivity: Integer;
begin
  IDActivity:= Inputs.ParamValue('IDActivity', 0);
  if IDActivity = 0 then
    raise Exception.Create('TExecutorActivity.Executar: Param "IDActivity" must be set!');

  FActivity:= FActivityDao.SelectKey(IDActivity);
  if not Assigned(FActivity) then
    raise Exception.Create(Format('TExecutorActivity.Executar: Activity of ID "%d" not found.', [IDActivity]));

  SetInputs;

  FActivity.Executar;

  SetOutputs;
  Result:= Outputs;
end;

class function TExecutorActivity.GetExecutor: IExecutorBase;
begin
  Result:= TExecutorActivity.Create;
end;

initialization
  TFrwServiceLocator.ActivityManager.RegisterExecutor(TExecutorActivity, TExecutorActivity.GetExecutor);

end.
