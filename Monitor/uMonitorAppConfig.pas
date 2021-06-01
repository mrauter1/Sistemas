unit uMonitorAppConfig;

interface

uses
  IniFiles, uAppConfig, SysUtils, Ladder.ServiceLocator, Ladder.Activity.Scheduler, Ladder.Logger, Root,
  Forms;

type
  TMonitorAppConfig = Class(TAppConfig)
  private
    FScheduler: TScheduler;
  protected
    procedure LerConfig; override;
  public
    SchedulerEnabled: Boolean;
    constructor Create;
    destructor Destroy; override;

    procedure Inicializar;

    procedure OnLogEvent(ALogType: TLogType; AMessage: String);
    property Scheduler: TScheduler read FScheduler;

    procedure DoReadIniFile(AIniFile: TIniFile); override;
  end;

var
  MonitorAppConfig: TMonitorAppConfig;

implementation

uses
  uMonitorRoot, Utils;

{ TMonitorAppConfig }

constructor TMonitorAppConfig.Create;
begin
  inherited Create;
  AppConfig:= Self;

  TFrwServiceLocator.Logger.AddListener(OnLogEvent);
end;

destructor TMonitorAppConfig.Destroy;
begin
  FScheduler.Stop;
  while not FScheduler.Stopped do
    Application.ProcessMessages;

  TFrwServiceLocator.Logger.RemoveListener(OnLogEvent);
  FScheduler.Free;
  inherited;
end;

procedure TMonitorAppConfig.OnLogEvent(ALogType: TLogType; AMessage: String);
begin
//  WriteLog('Monitor.log', AMessage);
  if ALogType = ltError then
    WriteLog('Error.log', AMessage);

end;

procedure TMonitorAppConfig.DoReadIniFile(AIniFile: TIniFile);
begin
  inherited;
  SchedulerEnabled:= AIniFile.ReadBool('MONITOR', 'SchedulerEnabled', False);
end;

procedure TMonitorAppConfig.LerConfig;
begin
  inherited;

end;

procedure TMonitorAppConfig.Inicializar;
var
  FRootClass: TRootClass;
begin
  inherited;
  TFrwServiceLocator.Inicializar(TFrwServiceFactory.Create(ConSqlServer));

  FRootClass:= TMonitorRoot.Create;
  try
    FRootClass.CreateAllTables;
  finally
    FRootClass.Free;
  end;

  FScheduler:= TScheduler.Create(False, True);
  Scheduler.ReloadScheduledActivities;
end;


end.
