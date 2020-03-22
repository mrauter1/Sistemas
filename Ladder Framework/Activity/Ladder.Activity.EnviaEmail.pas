unit Ladder.Activity.EnviaEmail;

interface

uses
  Ladder.Activity.Classes, Ladder.ServiceLocator, System.SysUtils, System.Classes, uSendMail;

type
  TExecutorEnviaEmail = class(TExecutorBase)
  private
    FDestinatarios: String;
    FAssunto: String;
    FCorpo: String;
    FAnexos: String;
    procedure ProcessaInputs;
  public
    function Executar: TOutputList; override;
  end;

implementation

{ TExecutorEnviaEmail }

procedure TExecutorEnviaEmail.ProcessaInputs;
begin
  FDestinatarios:= Inputs.ParamValueByName('Destinatarios', '');
  if FDestinatarios = '' then
    raise Exception.Create('TExecutorConsultaPersonalizada.ProcessaInputs: É necessário o parâmetro "Destinatarios"!');

  FAssunto:= Inputs.ParamValueByName('Assunto', '');
  FCorpo:= Inputs.ParamValueByName('Corpo', '');
  FAnexos:= Inputs.ParamValueByName('Anexos', '');
end;

function TExecutorEnviaEmail.Executar: TOutputList;
var
  FMailSender: TMailSender;
begin
  TFrwServiceLocator.Synchronize(
    procedure begin
      FMailSender:= TSendMailFactory.NewMailSender(nil, ExtractFilePath(TFrwServiceLocator.ExeName)+'Config.ini', 'EMAIL');
    end
  );
  try
    if FAnexos = '' then
      FMailSender.EnviarEmail(FAssunto, FCorpo, FDestinatarios, '', '')
    else
      FMailSender.EnviarEmailComAnexo(FAssunto, FCorpo, FDestinatarios, '', '', FAnexos);
  finally
    FMailSender.Free;
  end;
end;

end.
