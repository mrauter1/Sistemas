unit uFormInputSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TFormInputSenha = class(TForm)
    Label1: TLabel;
    EditSenha: TEdit;
    btnOK: TBitBtn;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FOK: Boolean;
  public
    { Public declarations }
    class function RetornaMD5Senha: String;
  end;

var
  FormInputSenha: TFormInputSenha;

implementation

{$R *.dfm}

uses
  uFormLogin;

procedure TFormInputSenha.btnOKClick(Sender: TObject);
begin
  if Length(EditSenha.Text) < 6 then
  begin
    ShowMessage('A senha deve ter no minímo 6 carácteres.');
    EditSenha.SetFocus;
    Exit;
  end;

  FOK:= True;
  Close;
end;

procedure TFormInputSenha.FormCreate(Sender: TObject);
begin
  FOK:= False;
end;

class function TFormInputSenha.RetornaMD5Senha: String;
var
  FFrm: TFormInputSenha;
begin
  FFrm:= TFormInputSenha.Create(Application);
  try
    Result:= '';
    FFrm.ShowModal;
    if FFrm.FOK then
      Result:= TFormLogin.getMd5HashString(FFrm.EditSenha.Text);
  finally
    FFrm.Free;
  end;
end;

end.
