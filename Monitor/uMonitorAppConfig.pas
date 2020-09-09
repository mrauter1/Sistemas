unit uMonitorAppConfig;

interface

uses
  IniFiles, uAppConfig, SysUtils;

type
  TMonitorAppConfig = Class(TAppConfig)
  private
  protected
    procedure LerConfig; override;
  public
    SchedulerEnabled: Boolean;
    constructor Create;
    destructor Destroy; override;

    procedure DoReadIniFile(AIniFile: TIniFile); override;

  end;

var
  MonitorAppConfig: TMonitorAppConfig;

implementation

{ TMonitorAppConfig }

constructor TMonitorAppConfig.Create;
begin
  inherited Create;
end;

destructor TMonitorAppConfig.Destroy;
begin
  inherited;
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

initialization
begin
  FreeAndNil(AppConfig);
  MonitorAppConfig:= TMonitorAppConfig.Create;
  AppConfig:= MonitorAppConfig;
end;

end.
