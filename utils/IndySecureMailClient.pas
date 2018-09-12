unit IndySecureMailClient;

interface

uses
  IdMessage, Classes, IdSMTP, StdCtrls, SysUtils, IdComponent, IdMessageBuilder;

type
  TEncryptionType = (ET_None, ET_SSL, ET_TLS);

const
  SMTP_PORT_EXPLICIT_TLS = 587;

type
  TSSLEmail = class(TObject)
  private
    IdMessage: TIdMessage;
    SMTP: TIdSMTP;
    FOnStatus: TIdStatusEvent;

    FedBody: TStrings;
    FedSMTPPort: Integer;
    FedToEmail: string;
    FedSubject: string;
    FedSMTPServer: string;
    FedCCEmail: string;
    FedPassword: string;
    FedBCCEmail: string;
    FedSenderName: string;
    FedUserName: string;
    FedPriority: TIdMessagePriority;
    FedSenderEmail: string;
    FedSSLConnection: Boolean;
    FRequireAuth: Boolean;
    FEncryption: TEncryptionType;
    FCheckReceipt: Boolean;
    FTextOnly: Boolean;
    FBodyText: String;
    FBodyHtml: String;
    FAttachmentList: TStringList;
    FHtmlAttachmentList: TStringList;

    // Getter / Setter
    procedure SetBody(const Value: TStrings);

    procedure Init;
    procedure InitMailMessage;
    procedure InitSASL;
    procedure AddSSLHandler;
    procedure SMTPStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
    procedure BuildMessage;

  public
    Memo: TMemo;

    constructor Create; overload;
    constructor Create(const ASMTPServer: string;
      const ASMTPPort: Integer;
      const AUserName, APassword: string); overload;

    destructor Destroy; override;

    procedure SendEmail;

    // Properties
    property CheckReceipt: Boolean read FCheckReceipt write FCheckReceipt;
    property Encryption: TEncryptionType read FEncryption write FEncryption;
    property edBCCEmail: string read FedBCCEmail write FedBCCEmail;
    property edBody: TStrings read FedBody write SetBody;
    property edCCEmail: string read FedCCEmail write FedCCEmail;
    property edPassword: string read FedPassword write FedPassword;
    property edPriority: TIdMessagePriority read FedPriority write FedPriority;
    property edSenderEmail: string read FedSenderEmail write FedSenderEmail;
    property edSenderName: string read FedSenderName write FedSenderName;
    property edSMTPServer: string read FedSMTPServer write FedSMTPServer;
    property edSMTPPort: Integer read FedSMTPPort write FedSMTPPort;
    property edSSLConnection: Boolean read FedSSLConnection write FedSSLConnection;
    property edToEmail: string read FedToEmail write FedToEmail;
    property edUserName: string read FedUserName write FedUserName;
    property edSubject: string read FedSubject write FedSubject;
    property OnStatus: TIdStatusEvent read FOnStatus write FOnStatus;
    property RequireAuth: Boolean read FRequireAuth write FRequireAuth;
    property TextOnly: Boolean read FTextOnly write FTextOnly;
    property BodyText: String read FBodyText write FBodyText;
    property BodyHtml: String read FBodyHtml write FBodyHtml;
    property AttachmentList: TStringList read FAttachmentList write FAttachmentList;
    property HtmlAttachmentList: TStringList read FHtmlAttachmentList write FHtmlAttachmentList;
  end;

  function HTML_To_STR(strHTML: string): string;

implementation

uses
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdBaseComponent, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdSASLLogin,
  IdSASL_CRAM_SHA1, IdSASL, IdSASLUserPass, IdSASL_CRAMBase, IdSASL_CRAM_MD5,
  IdSASLSKey, IdSASLPlain, IdSASLOTP, IdSASLExternal, IdSASLDigest,
  IdSASLAnonymous, IdUserPassProvider;

function HTML_To_STR(strHTML: string): string;
var
  P: INTEGER;
  InTag: Boolean;
  s : STRING[4];
begin
     P := 1;
     Result := '';
     InTag := False;
     repeat
           // get the next four chars
           s := COPY(strHTML, P, 4);
          // Do carriage returns
          if (CompareText('<br>', s) = 0) or (CompareText('</p>', s) = 0) then
          begin
               Result := Result + #13#10;
               INC(P, 4)
          end
          else
          begin
               // Just add text to the result
               case strHTML[P] of
                 '<': InTag := True;
                 '>': InTag := False;
                 #13, #10: Result := Result + #32;  // Add a space
               else
                 if not InTag then
                 begin
                      if NOT((strHTML[P] in [#9, #32]) and (strHTML[P+1] in [#10, #13, #32, #9, '<'])) then
                           Result := Result + strHTML[P]; // Add character to result
                 end;
               end;
          end;
          Inc(P);
     until (P > LENGTH(strHTML));
     {convert system characters}
     Result := StringReplace(Result, '&quot;', '"',  [rfReplaceAll]);
     Result := StringReplace(Result, '&nbsp;', ' ',  [rfReplaceAll]);
     Result := StringReplace(Result, '&pound;', '£',  [rfReplaceAll]);
     Result := StringReplace(Result, '&euro;', '€',  [rfReplaceAll]);
     Result := StringReplace(Result, '&#8212;', '—',  [rfReplaceAll]);
     Result := StringReplace(Result, '&apos;', '''', [rfReplaceAll]);
     Result := StringReplace(Result, '&gt;',   '>',  [rfReplaceAll]);
     Result := StringReplace(Result, '&lt;',   '<',  [rfReplaceAll]);
     Result := StringReplace(Result, '&amp;',  '&',  [rfReplaceAll]);
     {here you may add another symbols from RFC if you need}
end;

constructor TSSLEmail.Create;
begin
  FRequireAuth:= True;
  Encryption:= ET_SSL;
  FCheckReceipt:= False;
  FTextOnly:= False;
  AttachmentList:= TStringList.Create;
  HtmlAttachmentList:= TStringList.Create;
  inherited;

  Init;

  FedBody := TStringList.Create;
end;

procedure TSSLEmail.SMTPStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: String);
begin
  if Assigned(Memo) then
    Memo.Lines.Insert(0, IntToStr(Integer(AStatus))+': ' + AStatusText);
end; (* SMTP Status *)

procedure TSSLEmail.Init;
begin
  edSSLConnection := True;
  edPriority := TIdMessagePriority.mpNormal;
end;

constructor TSSLEmail.Create(const ASMTPServer: string;
  const ASMTPPort: Integer; const AUserName, APassword: string);
begin
  Create;

  edSMTPServer := ASMTPServer;
  edSMTPPort := ASMTPPort;
  edUserName := AUserName;
  edPassword := APassword;

  if (edUserName<>'') or (edPassword<>'') then
    RequireAuth:= True
 else
    RequireAuth:= False;

end;

destructor TSSLEmail.Destroy;
begin
  edBody.Free;
  AttachmentList.Free;
  HtmlAttachmentList.Free;

  inherited;
end;

// Setter / Getter -----------------------------------------------------------

procedure TSSLEmail.SetBody(const Value: TStrings);
begin
  FedBody.Assign(Value);
end;

// Send the mail -------------------------------------------------------------

procedure TSSLEmail.SendEmail;
begin
  IdMessage := TIdMessage.Create;
  try
    InitMailMessage;

    SMTP := TIdSMTP.Create;
    try
//      SMTP.MailAgent:= 'Microsoft Outlook Express 6.00.2600.0000';
      SMTP.OnStatus:= SMTPStatus;
      if edSSLConnection then
      begin
        AddSSLHandler;

        case Encryption of
          ET_None: SMTP.UseTLS := utNoTLSSupport;
          ET_SSL: SMTP.UseTLS := utUseImplicitTLS;
          ET_TLS: SMTP.UseTLS := utUseExplicitTLS;
        end;

        if edSMTPPort = SMTP_PORT_EXPLICIT_TLS then
          SMTP.UseTLS := utUseExplicitTLS;

      end;

      if RequireAuth then
      begin
        SMTP.AuthType := satSASL;
        InitSASL;
      end
      else
      begin
        SMTP.AuthType := satNone;
      end;

      SMTP.Host := edSMTPServer;
      SMTP.Port := edSMTPPort;
      SMTP.ConnectTimeout := 30000;
      SMTP.UseEHLO := True;
      SMTP.Connect;

      try
        SMTP.Send(IdMessage);
      finally
        SMTP.Disconnect;
      end;
    finally
      SMTP.Free;
    end;
  finally
    IdMessage.Free;
  end;
end;

// Prepare the mail ----------------------------------------------------------

procedure TSSLEmail.InitMailMessage;
  procedure AddExtraHeaders;
  begin
    IdMessage.ExtraHeaders.Values['X-Priority'] := '3';
    IdMessage.ExtraHeaders.Values['X-MSMail-Priority'] := 'Normal';
//    IdMessage.ExtraHeaders.Values['X-Mailer'] := 'Microsoft Outlook Express 6.00.2600.0000';
//    IdMessage.ExtraHeaders.Values['X-MimeOLE'] := 'Produced By Microsoft MimeOLE V6.00.2600.0000';
  end;
begin
  if TextOnly then
    IdMessage.ContentType := 'text/plain'
  else
    IdMessage.ContentType := 'multipart/alternative';

  IdMessage.Charset := 'UTF-8';

//  AddExtraHeaders;

  IdMessage.MessageParts.CountParts;

  IdMessage.Sender.Text := trim(edSenderEMail);
  if edSenderName <> '' then
    IdMessage.From.Name := edSenderName
  else
    IdMessage.From.Name := trim(edSenderEMail);

  IdMessage.From.Address := trim(edSenderEMail);
  IdMessage.ReplyTo.EMailAddresses := trim(edSenderEmail);
  IdMessage.Recipients.EMailAddresses := trim(edToEmail);
  IdMessage.Subject := edSubject;
  IdMessage.Priority := edPriority;
  IdMessage.CCList.EMailAddresses := trim(edCCEMail);
  IdMessage.ReceiptRecipient.Text := '';
  IdMessage.BccList.EMailAddresses := trim(edBCCEMail);

  if CheckReceipt then {We set the recipient to the From E-Mail address }
    IdMessage.ReceiptRecipient.Text := edSenderEMail
  else { indicate that there is no receipt recipiant}
    IdMessage.ReceiptRecipient.Text := '';

//  edBody.Text := EmbeddedWB.DocumentSourceText;
//  IdMessage.Body := edBody;
  if TextOnly then
    IdMessage.Body.Text:= BodyText
  else
    BuildMessage;
end;

procedure TSSLEmail.BuildMessage;
var
  MsgBuilder: TIdMessageBuilderHtml;
  Loop: Integer;
begin
   // Build the message
   MsgBuilder := TIdMessageBuilderHtml.Create;

   MsgBuilder.PlainText.Text := HTML_To_STR(BodyText);
   MsgBuilder.Html.Text := BodyHtml;

   // Add non-linked attachments
   for Loop := 0 TO AttachmentList.Count-1 DO
        MsgBuilder.Attachments.Add(AttachmentList[Loop]);

   for Loop := 0 TO HtmlAttachmentList.Count-1 DO
        MsgBuilder.HtmlFiles.Add(HtmlAttachmentList[Loop], ExtractFileName(HtmlAttachmentList[Loop]));

    MsgBuilder.FillMessage(IdMessage);
    FreeAndNil(MsgBuilder);
end;

procedure TSSLEmail.AddSSLHandler;
var
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(SMTP);
  // SSL/TLS handshake determines the highest available SSL/TLS version dynamically
  SSLHandler.SSLOptions.Method := sslvSSLv23;
  SSLHandler.SSLOptions.Mode := sslmClient;
  SSLHandler.SSLOptions.VerifyMode := [];
  SSLHandler.SSLOptions.VerifyDepth := 0;
  SMTP.IOHandler := SSLHandler;
end;

procedure TSSLEmail.InitSASL;
var
  IdUserPassProvider: TIdUserPassProvider;
  IdSASLCRAMMD5: TIdSASLCRAMMD5;
  IdSASLCRAMSHA1: TIdSASLCRAMSHA1;
  IdSASLPlain: TIdSASLPlain;
  IdSASLLogin: TIdSASLLogin;
  IdSASLSKey: TIdSASLSKey;
  IdSASLOTP: TIdSASLOTP;
  IdSASLAnonymous: TIdSASLAnonymous;
  IdSASLExternal: TIdSASLExternal;
begin
  IdUserPassProvider := TIdUserPassProvider.Create(SMTP);
  IdUserPassProvider.Username := edUserName;
  IdUserPassProvider.Password:= edPassword;

  IdSASLCRAMSHA1 := TIdSASLCRAMSHA1.Create(SMTP);
  IdSASLCRAMSHA1.UserPassProvider := IdUserPassProvider;
  IdSASLCRAMMD5 := TIdSASLCRAMMD5.Create(SMTP);
  IdSASLCRAMMD5.UserPassProvider := IdUserPassProvider;
  IdSASLSKey := TIdSASLSKey.Create(SMTP);
  IdSASLSKey.UserPassProvider := IdUserPassProvider;
  IdSASLOTP := TIdSASLOTP.Create(SMTP);
  IdSASLOTP.UserPassProvider := IdUserPassProvider;
  IdSASLAnonymous := TIdSASLAnonymous.Create(SMTP);
  IdSASLExternal := TIdSASLExternal.Create(SMTP);
  IdSASLLogin := TIdSASLLogin.Create(SMTP);
  IdSASLLogin.UserPassProvider := IdUserPassProvider;
  IdSASLPlain := TIdSASLPlain.Create(SMTP);
  IdSASLPlain.UserPassProvider := IdUserPassProvider;

  SMTP.SASLMechanisms.Add.SASL := IdSASLCRAMSHA1;
  SMTP.SASLMechanisms.Add.SASL := IdSASLCRAMMD5;
  SMTP.SASLMechanisms.Add.SASL := IdSASLSKey;
  SMTP.SASLMechanisms.Add.SASL := IdSASLOTP;
  SMTP.SASLMechanisms.Add.SASL := IdSASLAnonymous;
  SMTP.SASLMechanisms.Add.SASL := IdSASLExternal;
  SMTP.SASLMechanisms.Add.SASL := IdSASLLogin;
  SMTP.SASLMechanisms.Add.SASL := IdSASLPlain;
end;

end.
