unit Ladder.Activity.Manager;

interface

uses
  Ladder.Activity.Classes, System.Generics.Collections, System.Generics.Defaults, SysUtils, System.Classes, Forms;

type
  IProcessEditor = interface(IInterface)
  ['{9366E88A-4D9F-4705-9DB8-D8138498B0D1}']
    function NewProcess: TProcessoBase;
    procedure EditProcess(pProcesso: TProcessoBase);
    function Form: TForm;
    procedure Free;
  end;

  TOnGetExecutor = function: IExecutorBase of object;
  TOnGetProcessEditor = function(AOwner: TComponent): IProcessEditor of object;

  TExecutorDictionary = TDictionary<string, TOnGetExecutor>;
  TProcessEditorDictionary = TDictionary<string, TOnGetProcessEditor>;

  TActivityManager = class
  private
    FExecutorDictionary: TExecutorDictionary;
    FProcessEditorDictionary: TProcessEditorDictionary;
  public
    property ExecutorDictionary: TExecutorDictionary read FExecutorDictionary; //write FExecutorDictionary;

    procedure RegisterExecutor(ExecutorClass: TExecutorClass; pGetExecutor: TOnGetExecutor);
    procedure UnregisterExecutor(ExecutorClassName: string);

    procedure RegisterProcessEditor(ExecutorClass: TExecutorClass; pGetProcessEditor: TOnGetProcessEditor);
    procedure UnregisterProcessEditor(ExecutorClassName: string);

    function GetExecutor(ExecutorClass: TExecutorClass): IExecutorBase; overload;
    function GetExecutor(pClassName: String): IExecutorBase; overload;

    function GetProcessEditor(ExecutorClass: TExecutorClass; AOwner: TComponent = nil): IProcessEditor; overload;
    function GetProcessEditor(pClassName: String; AOwner: TComponent = nil): IProcessEditor; overload;

    procedure EditProcess(pProcesso: TProcessoBase);
    function NewProcess(ExecutorClass: String): TProcessoBase;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TActivityManager }

constructor TActivityManager.Create;
begin
  inherited Create;
  FExecutorDictionary:= TExecutorDictionary.Create;
  FProcessEditorDictionary:= TProcessEditorDictionary.Create;
end;

destructor TActivityManager.Destroy;
begin
  FExecutorDictionary.Free;
  inherited Destroy;
end;

procedure TActivityManager.EditProcess(pProcesso: TProcessoBase);
var
  FEditor: IProcessEditor;
begin
  if pProcesso.GetExecutor = nil then
    raise Exception.Create(Format('TActivityManager.EditProcess: Processo "%s" does not have an executor.', [pProcesso.Name]));

  FEditor:= GetProcessEditor(pProcesso.GetExecutor.ClassType.ClassName, nil);
  try
    FEditor.EditProcess(pProcesso);
    FEditor.Form.ShowModal;
  finally
//    FEditor.Free;
  end;
end;

function TActivityManager.GetExecutor(ExecutorClass: TExecutorClass): IExecutorBase;
begin
  Result:= GetExecutor(ExecutorClass.ClassName);
end;

function TActivityManager.GetExecutor(pClassName: String): IExecutorBase;
var
  FOnGetExecutor: TOnGetExecutor;
begin
  if not FExecutorDictionary.TryGetValue(pClassName, FOnGetExecutor) then
    raise Exception.Create('TActivityManager.GetExecutor: Executor "'+pClassName+'" not registered.');

  Result:= FOnGetExecutor();
end;

function TActivityManager.GetProcessEditor(ExecutorClass: TExecutorClass; AOwner: TComponent = nil): IProcessEditor;
begin
  Result:= GetProcessEditor(ExecutorClass.ClassName, AOwner);
end;

function TActivityManager.GetProcessEditor(pClassName: String; AOwner: TComponent = nil): IProcessEditor;
var
  FOnGetProcessEditor: TOnGetProcessEditor;
begin
  if not FProcessEditorDictionary.TryGetValue(pClassName, FOnGetProcessEditor) then
    raise Exception.Create('TActivityManager.GetProcessEditor: Editor "'+pClassName+'" not registered.');

  Result:= FOnGetProcessEditor(AOwner);
end;

function TActivityManager.NewProcess(ExecutorClass: String): TProcessoBase;
var
  FEditor: IProcessEditor;
begin
  FEditor:= GetProcessEditor(ExecutorClass, nil);
  try
    Result:= FEditor.NewProcess();
    FEditor.Form.ShowModal;
  finally
//    FEditor.Free;
  end;
end;

procedure TActivityManager.RegisterExecutor(ExecutorClass: TExecutorClass;
  pGetExecutor: TOnGetExecutor);
begin
  if FExecutorDictionary.ContainsKey(ExecutorClass.ClassName) then
    UnregisterExecutor(ExecutorClass.ClassName);
//    raise Exception.Create('TActivityManager.RegisterExecutorClass: Executor "'+ExecutorClass.ClassName+'" already registered!');

  FExecutorDictionary.Add(ExecutorClass.ClassName, pGetExecutor);
end;

procedure TActivityManager.UnregisterExecutor(ExecutorClassName: string);
begin
  FExecutorDictionary.Remove(ExecutorClassName);
end;

procedure TActivityManager.RegisterProcessEditor(ExecutorClass: TExecutorClass; pGetProcessEditor: TOnGetProcessEditor);
begin
  if FProcessEditorDictionary.ContainsKey(ExecutorClass.ClassName) then
    UnregisterProcessEditor(ExecutorClass.ClassName);

  FProcessEditorDictionary.Add(ExecutorClass.ClassName, pGetProcessEditor);
end;

procedure TActivityManager.UnregisterProcessEditor(ExecutorClassName: string);
begin
  FProcessEditorDictionary.Remove(ExecutorClassName);
end;

end.
