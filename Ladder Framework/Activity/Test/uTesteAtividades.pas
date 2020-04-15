unit uTesteAtividades;

interface

uses
  TestFramework, Ladder.Activity.Classes, Ladder.ServiceLocator,
  Ladder.Executor.ConsultaPersonalizada, Ladder.Executor.Email,
  uConClasses;

type
  TTesteAtividades = class(TTestCase)
  private
    FAtividade: TActivity;
    function NewProcessoRelatororiosMeta: TProcessoBase;
    function NewProcessoEnviaEmailMeta: TProcessoBase;
    function NewProcesso(pExecutor: IExecutorBase): TProcessoBase;
    function NewAtividade: TActivity;
    function NewProcessoRelatororiosMetaEvolutivo: TProcessoBase;
  public
    procedure Setup; override;
    procedure TearDown; override;

  published
    procedure TestaAtividadeEmail;
  end;

implementation

uses
  SysUtils, DateUtils;

{ TTesteAtividades }

function TTesteAtividades.NewProcesso(pExecutor: IExecutorBase): TProcessoBase;
begin
  Result:= TProcessoBase.Create(pExecutor, TFrwServiceLocator.Context.Connection);
end;

function TTesteAtividades.NewAtividade: TActivity;
begin
  Result:= TActivity.Create(TFrwServiceLocator.Context.Connection);
end;

function TTesteAtividades.NewProcessoEnviaEmailMeta: TProcessoBase;
begin
  Result:= NewProcesso(TExecutorSendMail.GetExecutor);
  Result.Inputs.Add(TParameter.Create('Titulo', tbValue, '@EnviaEmailMeta.Titulo'));
  Result.Inputs.Add(TParameter.Create('Body', tbValue, '@EnviaEmailMeta.Body'));
  Result.Inputs.Add(TParameter.Create('Destinatarios', tbValue, 'marcelo@rauter.com.br'));
  Result.Inputs.Add(TParameter.Create('Anexos', tbList, '[@Consulta.Grafico, @Consulta.Tabela, @MetaEvolutivo.Grafico]'));
end;

function TTesteAtividades.NewProcessoRelatororiosMeta: TProcessoBase;
var
  FOutput: TOutputParameter;
  FInput: TParameter;
begin
  Result:= NewProcesso(TExecutorConsultaPersonalizada.GetExecutor);
  Result.Name:= 'Consulta';
  FInput:= TParameter.Create('NomeConsulta', tbValue, 'MetaVendedores');
  Result.Inputs.Add(FInput);

  FOutput:= TOutputParameter.Create('Grafico', tbValue, '');
  FOutput.Parametros.Add(TParameter.Create('Visualizacao', tbValue, 'Realizado e Meta da Venda e Margem'));
  FOutput.Parametros.Add(TParameter.Create('NomeArquivo', tbValue, 'MetaVendedores.png'));
  FOutput.Parametros.Add(TParameter.Create('TipoVisualizacao', tbValue, 'Grafico'));
  Result.Outputs.Add(FOutput);

  FOutput:= TOutputParameter.Create('Tabela', tbValue, '');
  FOutput.Parametros.Add(TParameter.Create('Visualizacao', tbValue, 'Realizado e Meta da Venda e Margem'));
  FOutput.Parametros.Add(TParameter.Create('NomeArquivo', tbValue, 'MetaVendedores.xls'));
  FOutput.Parametros.Add(TParameter.Create('TipoVisualizacao', tbValue, 'Tabela'));
  Result.Outputs.Add(FOutput);
end;

function TTesteAtividades.NewProcessoRelatororiosMetaEvolutivo: TProcessoBase;
var
  FOutput: TOutputParameter;
  FInput: TParameter;
begin
  Result:= NewProcesso(TExecutorConsultaPersonalizada.GetExecutor);
  Result.Name:= 'MetaEvolutivo';
  FInput:= TParameter.Create('NomeConsulta', tbValue, 'MetaVendaEvolutivo');
  Result.Inputs.Add(FInput);

  Result.Inputs.Add(TParameter.CreateWithValue('geDataIni', tbValue, StartOfTheMonth(Now)));
  Result.Inputs.Add(TParameter.CreateWithValue('geDataFim', tbValue, Now));

  FOutput:= TOutputParameter.Create('Grafico', tbValue, '');
  FOutput.Parametros.Add(TParameter.Create('Visualizacao', tbValue, 'Venda e Margem Geral'));
  FOutput.Parametros.Add(TParameter.Create('NomeArquivo', tbValue, 'MetaVendedoresEvolutivo.png'));
  FOutput.Parametros.Add(TParameter.Create('TipoVisualizacao', tbValue, 'Grafico'));
  Result.Outputs.Add(FOutput);
end;

procedure TTesteAtividades.Setup;
begin
  FAtividade:= NewAtividade;
  FAtividade.ID:= 1;
  FAtividade.Name:= 'EnviaEmailMeta';
  FAtividade.Description:= 'Teste envio de email';
  FAtividade.Inputs.Add(
    TParameter.Create('Titulo', tbValue, 'email de teste'));

  FAtividade.Inputs.Add(
    TParameter.Create('Body', tbValue, 'Este é um email para testar a classe atividade, será enviada uma lista com as vendas com margem baixa de ontem.'));

  FAtividade.Processos.Add(NewProcessoRelatororiosMeta);

  FAtividade.Processos.Add(NewProcessoRelatororiosMetaEvolutivo);

  FAtividade.Processos.Add(NewProcessoEnviaEmailMeta);
//  FAtividade.Executar;
end;

procedure TTesteAtividades.TearDown;
begin
//  FAtividade.Free;
end;

procedure TTesteAtividades.TestaAtividadeEmail;
begin
  FAtividade.Executar;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TTesteAtividades.Suite);

end.
