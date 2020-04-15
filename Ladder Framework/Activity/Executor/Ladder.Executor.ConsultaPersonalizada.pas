unit Ladder.Executor.ConsultaPersonalizada;

interface

uses
  Ladder.Activity.Classes, Ladder.ServiceLocator, SysUtils, uConsultaPersonalizada, uConClasses;

type
  TExecutorConsultaPersonalizada = class(TExecutorBase)
  private
    function ConfiguraConsulta: TFrmConsultaPersonalizada;
    procedure CheckInputs;
    procedure ProcessaOutput(pConsulta: TFrmConsultaPersonalizada; pOutput: TOutputParameter);
  public
    function Executar: TOutputList; override;

    class function GetExecutor: IExecutorBase;

    class function Description: String; override;
  end;

implementation

{ TExecutorConsultaPersonalizada }

uses
  Variants;

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

  procedure SetaParametros;
  var
    FParam: TParameter;
  begin
    for FParam in Inputs do
    begin
      if not VarIsNull(FParam.Value) then
        if FConsultaPersonalizada.Params.ContainsKey(FParam.Name) then
          FConsultaPersonalizada.Params[FParam.Name].Valor:= FParam.Value;
    end;
  end;
begin
  CheckInputs;

  NomeConsulta:= Inputs.ParamValueByName('NomeConsulta', '');

  TFrwServiceLocator.Synchronize(
    procedure begin
      FConsultaPersonalizada:= TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName(NomeConsulta, False);
    end
  );

  if not Assigned(FConsultaPersonalizada) then
    raise Exception.Create('TExecutorConsultaPersonalizada.ConfiguraConsulta: Consulta "'+NomeConsulta+'" não encontrada!);');

  SetaParametros; // Copia o valor dos parametros de input para os parametros da consulta

  Result:= FConsultaPersonalizada;
end;

class function TExecutorConsultaPersonalizada.Description: String;
begin
  Result:= 'Consulta Personalizada';
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

initialization
  TFrwServiceLocator.Context.ActivityManager.RegisterExecutor(TExecutorConsultaPersonalizada, TExecutorConsultaPersonalizada.GetExecutor);

end.
