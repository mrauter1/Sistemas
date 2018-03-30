unit Unit1;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  ExtCtrls,
  Sockets, Spin;
type
  TForm1 = class(TForm)
    mLista: TMemo;
    btTesta: TButton;
    edServer: TEdit;
    Label1: TLabel;
    lbStatus: TLabel;
    btChega: TButton;
    Timer1: TTimer;
    btTimer: TButton;
    edPortaIni: TEdit;
    edPortaFin: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbSincron: TCheckBox;
    cbRefresh: TCheckBox;
    edPMT: TSpinEdit;
    cbProcess: TCheckBox;
    cbRepaint: TCheckBox;
    EdtProxy: TEdit;
    Label5: TLabel;
    BtnSetProxy: TButton;
    Button1: TButton;
    procedure btTestaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btChegaClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btTimerClick(Sender: TObject);
    procedure cbRefreshClick(Sender: TObject);
    procedure BtnSetProxyClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FAbort: Boolean;     //para saber se vamos parar no meio do loop
    FPortaTimer: Integer; //o contador interno do timer
    procedure Testar(porta: Integer);
  public
    function PORTA_INI : integer;
    function PORTA_FIN : integer;
    function PROCESS_MESSAGES_TIMEOUT : integer;
  end;
var
  Form1: TForm1;

implementation

uses uThreads, UntProxy, uTestProxy;

{$R *.dfm}

procedure TForm1.BtnSetProxyClick(Sender: TObject);
begin
  SetInternalProxy(EdtProxy.Text);
end;

procedure TForm1.btTestaClick(Sender: TObject);
var port: Integer;
begin
  FAbort := False;
  FPortaTimer := PORTA_INI;
  for port := PORTA_INI to PORTA_FIN do
  begin
    if FAbort then
    begin
      Break; //close;
    end;
    try
      Testar(port);
    except
    end;
    if cbRefresh.Checked then
      if( port mod PROCESS_MESSAGES_TIMEOUT) = 0 then
      begin
        if cbProcess.Checked then
          Application.ProcessMessages;
        if cbRepaint.Checked then
          Repaint;
      end;
  end;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.DoubleBuffered := True;   //para evitar o flicker da tela
  FAbort := False; // inicializa como falso para começar a processar
  FPortaTimer := PORTA_INI;  //Inteiro que define a porta atual do controle por timer
end;
procedure TForm1.btChegaClick(Sender: TObject);
begin
  FAbort := True;
end;
procedure TForm1.Testar(porta: Integer);
begin
  lbStatus.Caption := 'testando ' + IntToStr(porta);

  TPortScanner.Create(
    edServer.Text,
    IntToStr(porta),
    mLista,
    cbSincron.Checked,
    EdtProxy.text);
end;
procedure TForm1.Timer1Timer(Sender: TObject);
begin
    if FAbort then
    begin
      Timer1.Enabled := False; //close;
    end;

//    testar(FPortaTimer);
  lbStatus.Caption := 'testando ' + IntToStr(FPortaTimer);

  TestConnection(edServer.Text, IntToStr(FPortaTimer), mLista);

  Inc(FPortaTimer);

  if FPortaTimer >= PORTA_FIN   then
    Timer1.Enabled := False;

    if cbRefresh.Checked then
//      if( port mod PROCESS_MESSAGES_TIMEOUT) = 0 then
      begin
        if cbProcess.Checked then
          Application.ProcessMessages;
        if cbRepaint.Checked then
          Repaint;
      end;
end;
procedure TForm1.btTimerClick(Sender: TObject);
begin
  FAbort := False;
  FPortaTimer := PORTA_INI;
  Timer1.Enabled := True;
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
  FrmTestProxy:= TFrmTestProxy.Create(Self);
  FrmTestProxy.Show;
end;

function TForm1.PORTA_FIN: integer;
begin
  Result := StrToInt(edPortaFin.Text);
end;
function TForm1.PORTA_INI: integer;
begin
  Result := StrToInt(edPortaIni.Text);
end;
function TForm1.PROCESS_MESSAGES_TIMEOUT: integer;
begin
  Result := StrToInt(edPMT.Text);
end;
procedure TForm1.cbRefreshClick(Sender: TObject);
begin
  if not cbRefresh.Checked then
  begin
    cbProcess.Checked := False;
    cbRepaint.Checked := False;
    cbProcess.Enabled := False;
    cbRepaint.Enabled := False;
  end
  else
  begin
    cbProcess.Enabled := True;
    cbRepaint.Enabled := True;
  end;
end;
end.