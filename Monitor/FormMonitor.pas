unit FormMonitor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, Vcl.ExtCtrls, Vcl.Menus;

type
  TMonitorMain = class(TForm)
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    PopupMenu1: TPopupMenu;
    Fechar1: TMenuItem;
    AvisosAutomaticos1: TMenuItem;
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure Fechar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure AvisosAutomaticos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MonitorMain: TMonitorMain;

implementation

{$R *.dfm}

uses
  Utils, uFormPesquisaAviso;

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

procedure TMonitorMain.AvisosAutomaticos1Click(Sender: TObject);
begin
  TFormPesquisaAviso.AbrirPesquisa;
end;

procedure TMonitorMain.Fechar1Click(Sender: TObject);
begin
  Self.Close;
  Application.Terminate;
end;

procedure TMonitorMain.FormCreate(Sender: TObject);
begin
  Application.ShowMainForm := false;
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

end.
