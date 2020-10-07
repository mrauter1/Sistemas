unit uFormLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons,
  IdGlobal, IdHash, IdHashMessageDigest, uConSqlServer, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    btnOK: TBitBtn;
    EditUser: TEdit;
    CbxLoginAutomatico: TCheckBox;
    EditSenha: TEdit;
    BtnCancelar: TBitBtn;
    procedure btnOKClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function RetornaIDUser(AUserName: String; ASenha: String): Integer;
    class function DecryptStringAES(AString: RawByteString; AKey: String)
      : RawByteString; static;
    class function EncryptStringAES(AString: RawByteString; AKey: RawByteString)
      : RawByteString; static;
    { Private declarations }
  public
    { Public declarations }
    UserID: Integer;
    class function GetKey: String;
    class function getMd5HashString(value: string): string; static;
    class function EncryptDecryptString(value: String): String;

    class function Login: Integer;
    // Retorna o ID do usuário, 0 = inválido, Se login automatico estiver salvo entra com este salvo
    class function NovoLogin: Integer;
    // Retorna o id do usuário, 0 = inválido
  end;

implementation

{$R *.dfm}

uses
  SynCrypto, uAppConfig;

class function TFormLogin.EncryptStringAES(AString: RawByteString; AKey: RawByteString)
  : RawByteString;
begin
  Result := TAESCFB.SimpleEncrypt(AString, AKey, true, true);
end;

procedure TFormLogin.FormCreate(Sender: TObject);
begin
  UserID:= 0;
end;

class function TFormLogin.GetKey: String;
begin
  Result:= AppConfig.GetAppDataFolder;
end;

class function TFormLogin.Login: Integer;
var
  FFrm: TFormLogin;
begin
  FFrm := TFormLogin.Create(nil);
  try
    AppConfig.LerConfig;
    if AppConfig.UserName <> '' then
    begin
      Result:= FFrm.RetornaIDUser(String(AppConfig.UserName),
            String(DecryptStringAES(AppConfig.EncryptedPassword, GetKey)));
      if Result > 0 then
        Exit;
    end;

    FFrm.ShowModal;
    Result:= FFrm.UserID;
  finally
    FFrm.Free;
  end;
end;

class function TFormLogin.NovoLogin: Integer;
var
  FFrm: TFormLogin;
begin
  FFrm := TFormLogin.Create(nil);
  try
    FFrm.ShowModal;
    Result:= FFrm.UserID;
  finally
    FFrm.Free;
  end;
end;

function TFormLogin.RetornaIDUser(AUserName, ASenha: String): Integer;
const
  cSql = 'SELECT UserID FROM PERM.USUARIO WHERE Nome = ''%s'' and Senha = ''%s'' ';
begin
  Result := ConSqlServer.RetornaInteiro(Format(cSql,
              [AUserName, getMd5HashString(ASenha)]), 0);

  if Result = 0 then
    Exit;
end;

procedure TFormLogin.BtnCancelarClick(Sender: TObject);
begin
  UserID := 0;
  Close;
end;

procedure TFormLogin.btnOKClick(Sender: TObject);
begin
  USerID:= RetornaIDUser(EditUser.Text, EditSenha.Text);
  if UserID = 0 then
  begin
    ShowMessage('Usuário ou senha inválido!');
    Exit;
  end;

  if CbxLoginAutomatico.Checked then
    AppConfig.SalvarUsuarioESenha(EditUser.Text,
      EncryptStringAES(EditSenha.Text, GetKey));

  Close;
end;

class function TFormLogin.DecryptStringAES(AString: RawByteString;
  AKey: String): RawByteString;
begin
  Result := TAESCFB.SimpleEncrypt(AString, AKey, false, true);
end;

class function TFormLogin.EncryptDecryptString(value: String): String;
var
  CharIndex: Integer;
begin
  Result := value;
  for CharIndex := 1 to Length(value) do
    Result[CharIndex] := chr(not(ord(value[CharIndex])));
end;

class function TFormLogin.getMd5HashString(value: string): string;
var
  hashMessageDigest5: TIdHashMessageDigest5;
begin
  hashMessageDigest5 := nil;
  try
    hashMessageDigest5 := TIdHashMessageDigest5.Create;
    Result := IdGlobal.IndyLowerCase
      (hashMessageDigest5.HashStringAsHex(value));
  finally
    hashMessageDigest5.Free;
  end;
end;

end.
