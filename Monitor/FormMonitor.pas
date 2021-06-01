unit FormMonitor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, Vcl.ExtCtrls, Vcl.Menus, uMonitorAppConfig;

type
  TMonitorMain = class(TForm)
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    PopupMenu1: TPopupMenu;
    Fechar1: TMenuItem;
    Agendamentos1: TMenuItem;
    Avisos1: TMenuItem;
    N1: TMenuItem;
    RefreshAgendamentos1: TMenuItem;
    MenuIniciar: TMenuItem;
    Timer1: TTimer;
    AtualizaListadePreos1: TMenuItem;
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure Fechar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure Agendamentos1Click(Sender: TObject);
    procedure Avisos1Click(Sender: TObject);
    procedure RefreshAgendamentos1Click(Sender: TObject);
    procedure MenuIniciarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure AtualizaListadePreos1Click(Sender: TObject);
  private
    procedure SetMenuIniciarCaption;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MonitorMain: TMonitorMain;

implementation

{$R *.dfm}

uses
  Utils, Form.ScheduledActivities, Form.PesquisaAviso, uMonitorRoot, uDmGravaLista;

procedure TMonitorMain.Agendamentos1Click(Sender: TObject);
begin
  TFormScheduledActivities.OpenScheduledActivities;
end;

procedure TMonitorMain.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
  WriteLog('Erros.log', E.Message);
end;

procedure TMonitorMain.ApplicationEvents1Minimize(Sender: TObject);
begin
  { Hide the window and set its state variable to wsMinimized. }
  Hide();
  WindowState := wsMinimized;

  { Show the animated tray icon and also a hint balloon. }
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

procedure TMonitorMain.AtualizaListadePreos1Click(Sender: TObject);
begin
  TDmGravaLista.AtualizaTodasListasDePreco;
end;

procedure TMonitorMain.Avisos1Click(Sender: TObject);
begin
  TFormPesquisaAviso.AbrirPesquisa;
end;

procedure TMonitorMain.Fechar1Click(Sender: TObject);
begin
  Self.Close;
  Application.Terminate;
end;

procedure TMonitorMain.SetMenuIniciarCaption;
begin
  if MonitorAppConfig.Scheduler.Stopped then
    MenuIniciar.Caption:= 'Iniciar agendador'
  else
    MenuIniciar.Caption:= 'Parar agendador'
end;

procedure TMonitorMain.Timer1Timer(Sender: TObject);
begin
  if MenuIniciar.Enabled then
    SetMenuIniciarCaption;
end;

procedure TMonitorMain.FormCreate(Sender: TObject);
begin
  SetMenuIniciarCaption;
  Application.ShowMainForm := false;
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

procedure TMonitorMain.MenuIniciarClick(Sender: TObject);
begin
  try
    MenuIniciar.Enabled:= False;
    if MonitorAppConfig.Scheduler.Stopped then
    begin
      MonitorAppConfig.Scheduler.Start;
      MenuIniciar.Caption:= 'Iniciando...';
        while MonitorAppConfig.Scheduler.Stopped do
          Application.ProcessMessages;
    end
   else
    begin
      MonitorAppConfig.Scheduler.Stop;
      MenuIniciar.Caption:= 'Pausando...';
        while not MonitorAppConfig.Scheduler.Stopped do
          Application.ProcessMessages;
    end;
  finally
    MenuIniciar.Enabled:= True;
    SetMenuIniciarCaption;
  end;
end;

procedure TMonitorMain.RefreshAgendamentos1Click(Sender: TObject);
begin
  MonitorAppConfig.Scheduler.ReloadScheduledActivities;
end;

end.
