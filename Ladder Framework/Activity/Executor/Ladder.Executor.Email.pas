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

uses
  Ladder.Utils;

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
  FTitulo:= DecodeLadderStr(Inputs.ParamValue('Titulo', ''));
  FBody:= DecodeLadderStr(Inputs.ParamValue('Body', ''));
  VarDestinatarios:= Inputs.ParamValue('Destinatarios', '');

  if LadderVarIsList(VarDestinatarios) then
    FDestinatarios:= JoinList(VarDestinatarios, ';')
  else
    FDestinatarios:= VarToStrDef(VarDestinatarios, '');

  VarAnexos:= Inputs.ParamValue('Anexos');
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
  TFrwServiceLocator.ActivityManager.RegisterExecutor(TExecutorSendMail, TExecutorSendMail.GetExecutor);

end.
