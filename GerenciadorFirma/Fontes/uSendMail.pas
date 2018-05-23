unit uSendMail;

interface

uses
  SysUtils, Classes, IdSMTP, IdMessage, IdEmailAddress, IdExplicitTLSClientServerBase, IdSSLOpenSSL;

type
  TMailSender = class(TComponent)
  private
    FFrom: String;
    FIdSmtp: TIdSmtp;
    FIdMessage: TIdMessage;
    FIdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
    procedure InitializeISO88591(var VHeaderEncoding: Char;
      var VCharSet: string);
  public
    property From: String read FFrom write FFrom;
    constructor Create(AOwner: TComponent; pSMTPServer: String; pPort: Integer; pUserName, pPassword: String;
                        pRequerAutenticacao: Boolean; pFrom: String);

    function EnviarEmail(pAssunto, pCorpo, pPara: String; pCC: String = ''; pBCC: String = ''): Boolean;
  end;

implementation

{ TMailSender }

constructor TMailSender.Create(AOwner: TComponent; pSMTPServer: String; pPort: Integer; pUserName, pPassword: String;
                        pRequerAutenticacao: Boolean; pFrom: String);
begin
  inherited Create(AOwner);

  FIdSmtp:= TIdSmtp.Create(Self);

{  FIdSSLIOHandlerSocket:= TIdSSLIOHandlerSocketOpenSSL.Create(Self);

  FIdSSLIOHandlerSocket.SSLOptions.Method:= sslvSSLv23;
  FIdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

  // Configuração do SMTP
  FIdSmtp.IOHandler := FIdSSLIOHandlerSocket;}

  FIdSmtp.Host:= pSMTPServer;
  FIdSmtp.Port:= pPort;
  FIdSmtp.Username:= pUserName;
  FIdSmtp.Password:= pPassword;

  if pRequerAutenticacao then
    FIDSmtp.AuthType:= satDefault //satSASL
  else
    FIdSmtp.AuthType:= satNone;

  FIdSmtp.UseTls:= utNoTLSSupport;

  FFrom:= pFrom;
end;

procedure TMailSender.InitializeISO88591(var VHeaderEncoding: Char;
var VCharSet: string);
begin
  VCharSet := 'ISO-8859-1';
end;

function TMailSender.EnviarEmail(pAssunto, pCorpo, pPara, pCC,
  pBCC: String): Boolean;
var
  FStr: String;
begin
  FIdMessage:= TIdMessage.Create(Self);
  try
    FIdMessage.CharSet := 'ISO-8859-1';
    FIdMessage.OnInitializeISO:= Self.InitializeISO88591;

    FIdMessage.Subject:= pAssunto;
    FIdMessage.Body.Text:= pCorpo;

    FIdMessage.FromList.EMailAddresses:= From;

    FIdMessage.Recipients.EMailAddresses:= pPara;
    FIdMessage.CCList.EMailAddresses:= pCC;
    FIdMessage.BccList.EMailAddresses:= pBCC;

    if pCorpo.ToUpper.Contains('<HTML>') then
      FIdMessage.ContentType:='text/html; charset=ISO-8859-1'
    else
      FIdMessage.ContentType    := 'text/plain; charset=ISO-8859-1';

		if not FIdSmtp.Connected then
			FIdSmtp.Connect();

//    FIdSmtp.Authenticate;

    FIdSmtp.Send(fIdMessage);
  finally
    FIdMessage.Free;
  end;
end;

end.
