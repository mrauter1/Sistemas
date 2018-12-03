unit uSendMail;

interface

uses
  SysUtils, Classes, IdSMTP, IdMessage, IdEmailAddress, IdExplicitTLSClientServerBase, IdSSLOpenSSL,
  IdMessageBuilder;

type
  TMailSender = class(TComponent)
  private
    FFrom: String;
    FIdSmtp: TIdSmtp;
    FIdMessage: TIdMessage;
    procedure InitializeISO88591(var VHeaderEncoding: Char;
      var VCharSet: string);
  public
    property From: String read FFrom write FFrom;
    constructor Create(AOwner: TComponent; pSMTPServer: String; pPort: Integer; pUserName, pPassword: String;
                        pRequerAutenticacao: Boolean; pFrom: String);

    function EnviarEmail(pAssunto, pCorpo, pPara: String; pCC: String = ''; pBCC: String = ''): Boolean;
    procedure EnviarEmailComAnexo(pAssunto, pCorpo, pPara, pCC, pBCC, pAnexos: String);
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

  // Configura��o do SMTP
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

  Result:= True;
end;

procedure TMailSender.EnviarEmailComAnexo(pAssunto, pCorpo, pPara, pCC,
  pBCC: String; pAnexos: String);

  procedure FillMessage;
  var
    MB: TIdMessageBuilderHtml;
    FAnexo: String;
  begin
    MB := TIdMessageBuilderHtml.Create;
    try
      MB.HtmlCharSet := 'utf-8';
      MB.PlainTextCharSet := 'utf-8';

      if pCorpo.ToUpper.Contains('<HTML>') then
        MB.Html.Text := pCorpo
      else
        MB.PlainText.Text := pCorpo;

//      pAnexos.Split([';'])
      for FAnexo in pAnexos.Split([';']) do
        MB.Attachments.Add(FAnexo);

      MB.FillMessage(FIdMessage);
    finally
      MB.Free;
    end;
  end;

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

    FillMessage;

		if not FIdSmtp.Connected then
			FIdSmtp.Connect();

//    FIdSmtp.Authenticate;

    FIdSmtp.Send(fIdMessage);
  finally
    FIdMessage.Free;
  end;
end;

end.