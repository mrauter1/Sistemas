unit uTestProxy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw, UntProxy,
  Vcl.ComCtrls;

type
  TFrmTestProxy = class(TForm)
    WebBrowser: TWebBrowser;
    edtUrl: TEdit;
    LabelChavedeAcesso: TLabel;
    ButtonNovaConsulta: TButton;
    EdtPrx: TEdit;
    Label1: TLabel;
    BtnSetPrx: TButton;
    ProgressBar1: TProgressBar;
    procedure ButtonNovaConsultaClick(Sender: TObject);
    procedure BtnSetPrxClick(Sender: TObject);
    procedure WebBrowserProgressChange(ASender: TObject; Progress,
      ProgressMax: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTestProxy: TFrmTestProxy;

implementation

{$R *.dfm}

procedure TFrmTestProxy.BtnSetPrxClick(Sender: TObject);
begin
  DeleteIECache;
  SetInternalProxy(EdtPrx.Text);
end;

procedure TFrmTestProxy.ButtonNovaConsultaClick(Sender: TObject);
begin
  WebBrowser.Stop;
  WebBrowser.Navigate(edtUrl.Text);
end;

procedure TFrmTestProxy.WebBrowserProgressChange(ASender: TObject; Progress,
  ProgressMax: Integer);
begin
   inherited;
   if ProgressMax = 0 then
      Exit
   else
   begin
      try
         ProgressBar1.Max := ProgressMax;
         if (Progress <> -1) and (Progress <= ProgressMax) then
            ProgressBar1.Position := Progress;
      except
         on EDivByZero do
           Exit;
      end;
   end;
end;

end.
