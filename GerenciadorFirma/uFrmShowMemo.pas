unit uFrmShowMemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormShowMemo = class(TForm)
    LblText: TLabel;
  private
    { Private declarations }
  public
    procedure SetText(pTexto: String; pWriteLog: Boolean = True);
  end;

var
  FormShowMemo: TFormShowMemo;

implementation

uses
  GerenciadorUtils;

{$R *.dfm}

{ TFrmShowMemo }

procedure TFormShowMemo.SetText(pTexto: String; pWriteLog: Boolean = True);
begin
  LblText.Caption:= '';
  LblText.Caption:= pTexto;

  if pWriteLog then
    WriteLog(pTexto);

  LblText.Update;
  Application.ProcessMessages;
end;

end.
