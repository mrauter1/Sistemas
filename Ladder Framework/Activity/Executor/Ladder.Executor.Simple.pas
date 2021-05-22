unit Ladder.Executor.Simple;

interface

uses
  Ladder.Activity.Classes, Ladder.ServiceLocator;

type
  TExecutorSimple = class(TExecutorBase)
  private
  public
    function Executar: TOutputList; override;

    class function GetExecutor: IExecutorBase;

    class function Description: String; override;
  end;


implementation

{ TExecutorSimple }

class function TExecutorSimple.Description: String;
begin
  Result:= 'Simple Executor'
end;

function TExecutorSimple.Executar: TOutputList;
begin
  Result:= Outputs; // do nothing
end;

class function TExecutorSimple.GetExecutor: IExecutorBase;
begin
  Result:= TExecutorSimple.Create;
end;

initialization
  TFrwServiceLocator.ActivityManager.RegisterExecutor(TExecutorSimple, TExecutorSimple.GetExecutor);

end.
