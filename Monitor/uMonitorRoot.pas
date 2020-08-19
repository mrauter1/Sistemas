unit uMonitorRoot;

interface

uses
  Root, Ladder.Activity.Scheduler;

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
  FScheduler.OnLogEvent.Add(OnLogEvent);
  Scheduler.ReloadScheduledActivities;
  inherited;
end;

destructor TMonitorRoot.Destroy;
begin
  FScheduler.Stop;
  while not FScheduler.Stopped do
    Application.ProcessMessages;

  FScheduler.OnLogEvent.Remove(OnLogEvent);
  FScheduler.Free;
end;

procedure TMonitorRoot.OnLogEvent(ALogType: TLogType; AMessage: String);
begin
  if ALogType = ltError then
    WriteLog('Error.log', AMessage)
  else
    WriteLog('Monitor.log', AMessage);
end;

end.
