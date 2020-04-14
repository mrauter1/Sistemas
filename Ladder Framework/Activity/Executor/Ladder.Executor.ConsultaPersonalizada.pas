unit Ladder.Executor.ConsultaPersonalizada;

interface

uses
  Ladder.Activity.Classes, Ladder.ServiceLocator, SysUtils, uConsultaPersonalizada;

type
  TExecutorConsultaPersonalizada = class(TExecutorBase)
  private
    function ConfiguraConsulta: TFrmConsultaPersonalizada;
    procedure CheckInputs;
    procedure ProcessaOutput(pConsulta: TFrmConsultaPersonalizada; pOutput: TOutputParameter);
  public
    function Executar: TOutputList; override;

    class function GetExecutor: IExecutorBase;
  end;

implementation

{ TExecutorConsultaPersonalizada }

procedure TExecutorConsultaPersonalizada.CheckInputs;
begin

end;

procedure TExecutorConsultaPersonalizada.ProcessaOutput(pConsulta: TFrmConsultaPersonalizada; pOutput: TOutputParameter);
var
  FVisualizacao: String;
  FTipoVisualizacao: String;
  FNameArquivo: String;
begin
  FNameArquivo:= pOutput.Parametros.ParamValueByName('NomeArquivo', '');
  if FNameArquivo = '' then
    raise Exception.Create('TExecutorConsultaPersonalizada.ProcessaOutput: É necessário o parâmetro "NomeArquivo"!');
  FNameArquivo:= TFrwServiceLocator.GetTempPath+FNameArquivo;

  FVisualizacao:= pOutput.Parametros.ParamValueByName('Visualizacao', '');
  if FVisualizacao <> '' then  // Carrega Visualização
    pConsulta.CarregaVisualizacaoByName(FVisualizacao);

  FTipoVisualizacao:= pOutput.Parametros.ParamValueByName('TipoVisualizacao', '');
  FTipoVisualizacao:= AnsiUpperCase(Trim(FTipoVisualizacao));

  if FTipoVisualizacao = 'TABELA' then
     pConsulta.ExportaTabelaParaExcelInterno(FNameArquivo)
  else if FTipoVisualizacao = 'TABELADINAMICA' then
     pConsulta.ExportaTabelaDinamica(FNameArquivo)
  else if FTipoVisualizacao = 'GRAFICO' then
     pConsulta.ExportaGrafico(FNameArquivo)
  else
    pConsulta.ExportaTabelaParaExcelInterno(FNameArquivo);

  pOutput.Value:= FNameArquivo;
end;

function TExecutorConsultaPersonalizada.ConfiguraConsulta: TFrmConsultaPersonalizada;
var
  NomeConsulta: String;
  FConsultaPersonalizada: TFrmConsultaPersonalizada;
begin
  CheckInputs;

  NomeConsulta:= Inputs.ParamValueByName('NomeConsulta', '');

  TFrwServiceLocator.Synchronize(
    procedure begin
      FConsultaPersonalizada:= TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName(NomeConsulta);
    end
  );

  if not Assigned(FConsultaPersonalizada) then
    raise Exception.Create('TExecutorConsultaPersonalizada.ConfiguraConsulta: Consulta "'+NomeConsulta+'" não encontrada!);');

  Result:= FConsultaPersonalizada;
end;

function TExecutorConsultaPersonalizada.Executar: TOutputList;
var
  FOutput: TOutputParameter;
  FConsulta: TFrmConsultaPersonalizada;
begin
  FConsulta:= ConfiguraConsulta;
  try
    FConsulta.ExecutaConsulta;
    for FOutput in Outputs do
      ProcessaOutput(FConsulta, FOutput);
  finally
    TFrwServiceLocator.Synchronize(
      procedure begin
        FConsulta.Free;
      end
    );
  end;
  Result:= Outputs;
end;


class function TExecutorConsultaPersonalizada.GetExecutor: IExecutorBase;
begin
  Result:= TExecutorConsultaPersonalizada.Create;
end;

end.
