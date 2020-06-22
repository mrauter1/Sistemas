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
  SysUtils, DateUtils, SynCommons, Ladder.Utils, SynDB;

{ TTesteAtividades }

function TTesteAtividades.NewProcesso(pExecutor: IExecutorBase): TProcessoBase;
begin
  Result:= TProcessoBase.Create(pExecutor);
end;

function TTesteAtividades.NewAtividade: TActivity;
begin
  Result:= TActivity.Create(TFrwServiceLocator.Context.ServiceFactory.NewExpressionEvaluator);
end;

function TTesteAtividades.NewProcessoEnviaEmailMeta: TProcessoBase;
begin
  Result:= NewProcesso(TExecutorSendMail.GetExecutor);
  Result.Inputs.Add(TParameter.Create('Titulo', tbValue, '@EnviaEmailMeta.Titulo'));
  Result.Inputs.Add(TParameter.Create('Body', tbValue, '@EnviaEmailMeta.Body'));
  Result.Inputs.Add(TParameter.Create('Destinatarios', tbValue, 'marcelo@rauter.com.br'));
  Result.Inputs.Add(TParameter.Create('Anexos', tbList, '[@Consulta.Files[0], @Consulta.Files[1], @MetaEvolutivo.Export.Grafico]'));
end;

function TTesteAtividades.NewProcessoRelatororiosMeta: TProcessoBase;
var
//  FOutput: TOutputParameter;
  FInput: TParameter;
  FExport: TParameter;
  FTipoExport: TParameter;
begin
  Result:= NewProcesso(TExecutorConsultaPersonalizada.GetExecutor);
  Result.Name:= 'Consulta';
  FInput:= TParameter.Create('NomeConsulta', tbValue, 'MetaVendedores');
  Result.Inputs.Add(FInput);

  FExport:= TParameter.Create('Export', tbValue);

  FTipoExport:= TParameter.Create('Grafico', tbValue);
  FTipoExport.Parameters.Add(TParameter.Create('Visualizacao', tbValue, 'Realizado e Meta da Venda e Margem'));
  FTipoExport.Parameters.Add(TParameter.Create('NomeArquivo', tbValue, 'MetaVendedores.png'));
  FTipoExport.Parameters.Add(TParameter.Create('TipoVisualizacao', tbValue, 'Grafico'));
  FExport.Parameters.Add(FTipoExport);

  FTipoExport:= TParameter.Create('Tabela', tbValue, '');
  FTipoExport.Parameters.Add(TParameter.Create('Visualizacao', tbValue, 'Realizado e Meta da Venda e Margem'));
  FTipoExport.Parameters.Add(TParameter.Create('NomeArquivo', tbValue, 'MetaVendedores.xls'));
  FTipoExport.Parameters.Add(TParameter.Create('TipoVisualizacao', tbValue, 'Tabela'));
  FExport.Parameters.Add(FTipoExport);

  Result.Inputs.Add(FExport);
end;

function TTesteAtividades.NewProcessoRelatororiosMetaEvolutivo: TProcessoBase;
var
//  FOutput: TOutputParameter;
  FInput: TParameter;
  FExport: TParameter;
  FTipoExport: TParameter;
begin
  Result:= NewProcesso(TExecutorConsultaPersonalizada.GetExecutor);
  Result.Name:= 'MetaEvolutivo';
  FInput:= TParameter.Create('NomeConsulta', tbValue, 'MetaVendaEvolutivo');
  Result.Inputs.Add(FInput);

  Result.Inputs.Add(TParameter.Create('geDataIni', tbValue,'"2020/04/01"'));
  Result.Inputs.Add(TParameter.Create('geDataFim', tbValue, '"2020/04/30"'));

  FExport:= TParameter.Create('Export', tbValue);
    FTipoExport:= TParameter.Create('Grafico', tbValue);
      FTipoExport.Parameters.Add(TParameter.Create('Visualizacao', tbValue, 'Venda e Margem Geral'));
      FTipoExport.Parameters.Add(TParameter.Create('NomeArquivo', tbValue, 'MetaVendedoresEvolutivo.png'));
      FTipoExport.Parameters.Add(TParameter.Create('TipoVisualizacao', tbValue, 'Grafico'));

  FExport.Parameters.Add(FTipoExport);
  Result.Inputs.Add(FExport);

  Result.Outputs.Add(TOutputParameter.Create('Data', tbAny, ''));
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
var
  FData: TDocVariantData;
begin
  FAtividade.Executar;
  Check( Pos('.png', TParameter(FAtividade.FindElement('MetaEvolutivo.Export.Grafico')).Value) > 0);
  FData:= TDocVariantData(TParameter(FAtividade.FindElement('MetaEvolutivo.Data')).Value);
  Check(FData.Count > 0);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TTesteAtividades.Suite);

end.
