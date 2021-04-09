unit uSendMail;

interface

uses
  SysUtils, Classes, IdSMTP, IdMessage, IdEmailAddress,
  IdExplicitTLSClientServerBase, IdSSLOpenSSL,
  IdMessageBuilder, IniFiles, Forms, IdText;

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

    constructor Create(AOwner: TComponent; pSMTPServer: String; pPort: Integer;
      pUserName, pPassword: String; pRequerAutenticacao: Boolean;
      pFrom: String);

    function PrepareMessage(pAssunto, pCorpo, pPara: String; pCC: String = ''; pBCC: String = ''): TIdMessage;
    function SendMessage(pIdMessage: TIdMessage; pFreeMessage: Boolean = True): Boolean;

    function NewMessageBuilder(pCorpo: String; pAnexos: String = ''): TIdMessageBuilderHtml;
    procedure SendEmailFromMessageBuilder(pAssunto, pCorpo, pPara, pCC, pBCC: String;
                      pMessageBuilder: TIdMessageBuilderHtml; AFreeMessageBuilder: Boolean = True);

    function EnviarEmail(pAssunto, pCorpo, pPara: String; pCC: String = ''; pBCC: String = ''): Boolean;
    procedure EnviarEmailComAnexo(pAssunto, pCorpo, pPara, pCC, pBCC, pAnexos: String);
  end;

  TSendMailFactory = class
    class function NewMailSender(AOwner: TComponent; pIniFile: String;
      pSection: String): TMailSender; overload;
    class function NewMailSender(AOwner: TComponent; pSMTPServer: String;
      pPort: Integer; pUserName, pPassword: String;
      pRequerAutenticacao: Boolean; pFrom: String): TMailSender; overload;
  end;

implementation

{ TMailSender }

constructor TMailSender.Create(AOwner: TComponent; pSMTPServer: String;
  pPort: Integer; pUserName, pPassword: String; pRequerAutenticacao: Boolean;
  pFrom: String);
begin
  inherited Create(AOwner);

  FIdSmtp := TIdSmtp.Create(Self);

  { FIdSSLIOHandlerSocket:= TIdSSLIOHandlerSocketOpenSSL.Create(Self);

    FIdSSLIOHandlerSocket.SSLOptions.Method:= sslvSSLv23;
    FIdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

    // Configuração do SMTP
    FIdSmtp.IOHandler := FIdSSLIOHandlerSocket; }

  FIdSmtp.Host := pSMTPServer;
  FIdSmtp.Port := pPort;
  FIdSmtp.Username := pUserName;
  FIdSmtp.Password := pPassword;

  if pRequerAutenticacao then
    FIdSmtp.AuthType := satDefault // satSASL
  else
    FIdSmtp.AuthType := satNone;

  FIdSmtp.UseTls := utNoTLSSupport;

  FFrom := pFrom;
end;

procedure TMailSender.InitializeISO88591(var VHeaderEncoding: Char;
  var VCharSet: string);
begin
  VCharSet := 'ISO-8859-1';
end;

function TMailSender.PrepareMessage(pAssunto, pCorpo, pPara, pCC, pBCC: String): TIdMessage;
var
  FMessageBody: TIdText;
begin
  Result := TIdMessage.Create(Self);
  try
//    Result.ContentType:= 'multipart/mixed';
    Result.CharSet := 'ISO-8859-1';
    Result.OnInitializeISO := Self.InitializeISO88591;

    Result.Subject := pAssunto;

    FMessageBody := TIdText.Create(Result.MessageParts);
    FMessageBody.Body.Text := pCorpo;

    if pCorpo.ToUpper.Contains('<HTML') then
      FMessageBody.ContentType := 'text/html; charset=ISO-8859-1'
    else
      FMessageBody.ContentType := 'text/plain; charset=ISO-8859-1';

    Result.FromList.EMailAddresses := From;

    Result.Recipients.EMailAddresses := pPara;
    Result.CCList.EMailAddresses := pCC;
    Result.BccList.EMailAddresses := pBCC;
  except
    FreeAndNil(Result);
  end;
end;

function TMailSender.SendMessage(pIdMessage: TIdMessage; pFreeMessage: Boolean = True): Boolean;
begin
  try
    if not FIdSmtp.Connected then
      FIdSmtp.Connect();

    // FIdSmtp.Authenticate;

    FIdSmtp.Send(pIdMessage);
  finally
    if pFreeMessage then
      FreeAndNil(pIdMessage);
  end;

  Result := True;
end;

function TMailSender.EnviarEmail(pAssunto, pCorpo, pPara, pCC,
  pBCC: String): Boolean;
begin
  FIdMessage := PrepareMessage(pAssunto, pCorpo, pPara, pCC, pBCC);
  Result:= SendMessage(FIdMessage, True);
end;

function TMailSender.NewMessageBuilder(pCorpo: String; pAnexos: String = ''): TIdMessageBuilderHtml;
var
  FAnexo: String;
begin
  Result := TIdMessageBuilderHtml.Create;
//  FAttachment.Data.CopyFrom()

  Result.HtmlCharSet := 'utf-8';
  Result.PlainTextCharSet := 'utf-8';

  if pCorpo.ToUpper.Contains('<HTML') then
    Result.Html.Text := pCorpo
  else
    Result.PlainText.Text := pCorpo;

  // pAnexos.Split([';'])
  for FAnexo in pAnexos.Split([';']) do
    Result.Attachments.Add(FAnexo);
end;

procedure TMailSender.SendEmailFromMessageBuilder(pAssunto, pCorpo, pPara, pCC,
  pBCC: String; pMessageBuilder: TIdMessageBuilderHtml; AFreeMessageBuilder: Boolean = True);
begin
  FIdMessage := TIdMessage.Create(Self);
  try
    FIdMessage.CharSet := 'ISO-8859-1';
    FIdMessage.OnInitializeISO := Self.InitializeISO88591;

    FIdMessage.Subject := pAssunto;
    FIdMessage.Body.Text := pCorpo;

    FIdMessage.FromList.EMailAddresses := From;

    FIdMessage.Recipients.EMailAddresses := pPara;
    FIdMessage.CCList.EMailAddresses := pCC;
    FIdMessage.BccList.EMailAddresses := pBCC;
    pMessageBuilder.FillMessage(FIdMessage);

    if not FIdSmtp.Connected then
      FIdSmtp.Connect();

    // FIdSmtp.Authenticate;
    FIdSmtp.Send(FIdMessage);
  finally
    FIdMessage.Free;
    if AFreeMessageBuilder then
      pMessageBuilder.Free;
  end;
end;

procedure TMailSender.EnviarEmailComAnexo(pAssunto, pCorpo, pPara, pCC,
  pBCC: String; pAnexos: String);
var
  FMessageBuilder: TIdMessageBuilderHtml;
begin
  FMessageBuilder:= NewMessageBuilder(pCorpo, pAnexos);
  SendEmailFromMessageBuilder(pAssunto, pCorpo, pPara, pCC, pBCC, FMessageBuilder, True);
end;

{ TSendMailFactory }

class function TSendMailFactory.NewMailSender(AOwner: TComponent;
  pIniFile: String; pSection: String): TMailSender;
var
  FSmtpServer: String;
  FPort: Integer;
  FUserName: String;
  FPassword: String;
  FRequerAutenticacao: Boolean;
  FFrom: String;
  FIni: TIniFile;
begin
  FIni := TIniFile.Create(pIniFile);
  try
    FSmtpServer := FIni.ReadString(pSection, 'SmtpServer', '');
    FPort := FIni.ReadInteger(pSection, 'Port', 0);
    FUserName := FIni.ReadString(pSection, 'UserName', '');
    FPassword := FIni.ReadString(pSection, 'Password', '');
    FRequerAutenticacao := FIni.ReadBool(pSection, 'RequerAutenticacao', True);
    FFrom := FIni.ReadString(pSection, 'From', '');
  finally
    FIni.Free;
  end;
  Result := NewMailSender(AOwner, FSmtpServer, FPort, FUserName, FPassword,
    FRequerAutenticacao, FFrom);
end;

class function TSendMailFactory.NewMailSender(AOwner: TComponent;
  pSMTPServer: String; pPort: Integer; pUserName, pPassword: String;
  pRequerAutenticacao: Boolean; pFrom: String): TMailSender;
begin
  Result := TMailSender.Create(AOwner, pSMTPServer, pPort, pUserName, pPassword,
    pRequerAutenticacao, pFrom);
end;

end.
