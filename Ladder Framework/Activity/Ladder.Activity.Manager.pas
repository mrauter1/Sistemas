unit Ladder.Activity.Manager;

interface

uses
  Ladder.Activity.Classes, System.Generics.Collections, System.Generics.Defaults, SysUtils;

type
  TOnGetExecutor = function: IExecutorBase of object;

  TExecutorDictionary = TDictionary<string, TOnGetExecutor>;

  TActivityManager = class
  private
    FExecutorDictionary: TExecutorDictionary;
  public
    property ExecutorDictionary: TExecutorDictionary read FExecutorDictionary; //write FExecutorDictionary;
    procedure RegisterExecutor(ExecutorClass: TExecutorClass; pGetExecutor: TOnGetExecutor);
    procedure UnregisterExecutor(ExecutorClass: TExecutorClass);

    function GetExecutor(ExecutorClass: TExecutorClass): IExecutorBase; overload;
    function GetExecutor(pClassName: String): IExecutorBase; overload;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TActivityManager }

constructor TActivityManager.Create;
begin
  inherited Create;
  FExecutorDictionary:= TExecutorDictionary.Create;
end;

destructor TActivityManager.Destroy;
begin
  FExecutorDictionary.Free;
  inherited Destroy;
end;

function TActivityManager.GetExecutor(pClassName: String): IExecutorBase;
var
  FOnGetExecutor: TOnGetExecutor;
begin
  if not FExecutorDictionary.TryGetValue(pClassName, FOnGetExecutor) then
    raise Exception.Create('TActivityManager.GetExecutor: Executor "'+pClassName+'" não registrado!');

  Result:= FOnGetExecutor();
end;

function TActivityManager.GetExecutor(ExecutorClass: TExecutorClass): IExecutorBase;
begin
  Result:= GetExecutor(ExecutorClass.ClassName);
end;

procedure TActivityManager.RegisterExecutor(ExecutorClass: TExecutorClass;
  pGetExecutor: TOnGetExecutor);
begin
  if FExecutorDictionary.ContainsKey(ExecutorClass.ClassName) then
    raise Exception.Create('TActivityManager.RegisterExecutorClass: Executor "'+ExecutorClass.ClassName+'" já registrado!');

  FExecutorDictionary.Add(ExecutorClass.ClassName, pGetExecutor);
end;

procedure TActivityManager.UnregisterExecutor(ExecutorClass: TExecutorClass);
begin
  FExecutorDictionary.Remove(ExecutorClass.ClassName);
end;

end.
