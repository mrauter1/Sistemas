unit Ladder.Executor.Email;

interface

uses
  Ladder.Activity.Classes, Ladder.ServiceLocator, SysUtils, uConsultaPersonalizada, uSendMail, Variants;

type
  TExecutorSendMail = class(TExecutorBase)
  private
    FMailSender: TMailSender;
    procedure CheckInputs;
  public
    constructor Create;

    function Executar: TOutputList; override;

    class function GetExecutor: IExecutorBase;

    class function Description: String; override;
  end;

implementation

{ TExecutorConsultaPersonalizada }

procedure TExecutorSendMail.CheckInputs;
begin

end;

constructor TExecutorSendMail.Create;
begin
  FMailSender:= TSendMailFactory.NewMailSender(nil, ExtractFilePath(TFrwServiceLocator.ExeName)+'Config.ini', 'EMAIL');
end;

class function TExecutorSendMail.Description: String;
begin
  Result:= 'Envio de Email';
end;

function TExecutorSendMail.Executar: TOutputList;
var
  FTitulo: String;
  FBody: String;
  VarDestinatarios: Variant;
  FDestinatarios: String;
  VarAnexos: Variant;
  FAnexos: Variant;
begin
  FTitulo:= Inputs.ParamValueByName('Titulo', '');
  FBody:= Inputs.ParamValueByName('Body', '');
  VarDestinatarios:= Inputs.ParamValueByName('Destinatarios', '');

  if LadderVarIsList(VarDestinatarios) then
    FDestinatarios:= JoinList(VarDestinatarios, ';')
  else
    FDestinatarios:= VarToStrDef(VarDestinatarios, '');

  VarAnexos:= Inputs.ParamValueByName('Anexos');
  if LadderVarIsList(VarAnexos) then
    FAnexos:= JoinList(VarAnexos, ';')
  else
    FAnexos:= VarToStrDef(VarAnexos, '');

  FMailSender.EnviarEmailComAnexo(FTitulo, FBody, FDestinatarios, '', '', FAnexos);
end;


class function TExecutorSendMail.GetExecutor: IExecutorBase;
begin
  Result:= TExecutorSendMail.Create;
end;

initialization
  TFrwServiceLocator.Context.ActivityManager.RegisterExecutor(TExecutorSendMail, TExecutorSendMail.GetExecutor);

end.
