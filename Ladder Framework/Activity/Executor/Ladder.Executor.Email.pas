unit Ladder.Executor.Email;

interface

uses
  Ladder.Activity.Classes, Ladder.ServiceLocator, SysUtils, uConsultaPersonalizada, uSendMail;

type
  TExecutorSendMail = class(TExecutorBase)
  private
    FMailSender: TMailSender;
    procedure CheckInputs;
    procedure ProcessaOutput(pConsulta: TFrmConsultaPersonalizada; pOutput: TOutputParameter);
  public
    constructor Create;

    function Executar: TOutputList; override;

    class function GetExecutor: IExecutorBase;
  end;

implementation

{ TExecutorConsultaPersonalizada }

procedure TExecutorSendMail.CheckInputs;
begin

end;

procedure TExecutorSendMail.ProcessaOutput(pConsulta: TFrmConsultaPersonalizada; pOutput: TOutputParameter);
var
  FVisualizacao: String;
  FTipoVisualizacao: String;
  FNameArquivo: String;
begin

end;

constructor TExecutorSendMail.Create;
begin
    FMailSender:= TSendMailFactory.NewMailSender(nil, ExtractFilePath(Application.ExeName)+'Config.ini', 'EMAIL');
end;

function TExecutorSendMail.Executar: TOutputList;
begin
  FMailSender.EnviarEmail(Titulo, FHtml,
      Destinatarios, cc);
end;


class function TExecutorSendMail.GetExecutor: IExecutorBase;
begin
  Result:= TExecutorSendMail.Create;
end;

end.
