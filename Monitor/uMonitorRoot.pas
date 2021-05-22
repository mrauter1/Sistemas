unit uMonitorRoot;

interface

uses
  Root, Ladder.Activity.Scheduler, Ladder.ServiceLocator, Ladder.Logger;

type
  TMonitorRoot = class(TRootClass)
  private
    FScheduler: TScheduler;
  public
    constructor Create;
    destructor Destroy; override;
    procedure OnLogEvent(ALogType: TLogType; AMessage: String);
    property Scheduler: TScheduler read FScheduler;
  end;

var
  FRootClass: TMonitorRoot;

implementation

uses
  Forms, Utils;

{ TMonitorRoot }

constructor TMonitorRoot.Create;
begin
  FScheduler:= TScheduler.Create(False, True);
  TFrwServiceLocator.Logger.AddListener(OnLogEvent);
  Scheduler.ReloadScheduledActivities;
  inherited;
end;

destructor TMonitorRoot.Destroy;
begin
  FScheduler.Stop;
  while not FScheduler.Stopped do
    Application.ProcessMessages;

  TFrwServiceLocator.Logger.RemoveListener(OnLogEvent);
  FScheduler.Free;
end;

procedure TMonitorRoot.OnLogEvent(ALogType: TLogType; AMessage: String);
begin
//  WriteLog('Monitor.log', AMessage);
  if ALogType = ltError then
    WriteLog('Error.log', AMessage);

end;

end.
