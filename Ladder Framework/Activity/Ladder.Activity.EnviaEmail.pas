unit Ladder.Activity.EnviaEmail;

interface

uses
  Ladder.Activity.Classes, System.SysUtils, System.Classes, uSendMail;

type
  TExecutorEnviaEmail = class(TExecutorBase)
  private
    FDestinatarios: String;
    FTitulo: String;
    FTexto: String;
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

  FTitulo:= Inputs.ParamValueByName('Titulo', '');
  FTexto:= Inputs.ParamValueByName('Texto', '');
  FAnexos:= Inputs.ParamValueByName('Anexos', '');
end;

function TExecutorEnviaEmail.Executar: TOutputList;
begin

end;

end.
