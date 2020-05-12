unit Ladder.Executor.ConsultaPersonalizada;

interface

uses
  Ladder.Activity.Classes, Ladder.ServiceLocator, SysUtils, uConsultaPersonalizada, uConClasses;

type
  TExecutorConsultaPersonalizada = class(TExecutorBase)
  private
    function ConfiguraConsulta: TFrmConsultaPersonalizada;
    procedure CheckInputs;
    procedure ProcessaOutput(pConsulta: TFrmConsultaPersonalizada; pExportParameter: TParameter);
  public
    function Executar: TOutputList; override;

    class function GetExecutor: IExecutorBase;

    class function Description: String; override;
  end;

implementation

{ TExecutorConsultaPersonalizada }

uses
  Variants, SynCommons;

procedure TExecutorConsultaPersonalizada.CheckInputs;
var
  FOutput: TOutputParameter;
begin
  FOutput:= Outputs.Param('Files');
  if not Assigned(FOutput) then
  begin
    FOutput:= TOutputParameter.Create('Files', tbList, '');
    Outputs.Add(FOutput);
  end;
end;

procedure TExecutorConsultaPersonalizada.ProcessaOutput(pConsulta: TFrmConsultaPersonalizada; pExportParameter: TParameter);
var
  FVisualizacao: String;
  FTipoVisualizacao: String;
  FNameArquivo: String;
  FDados: String;
  FOutput: TOutputParameter;
  FResult: Variant;
begin
  FNameArquivo:= pExportParameter.Parameters.ParamValue('NomeArquivo', '');
  if FNameArquivo = '' then
    raise Exception.Create('TExecutorConsultaPersonalizada.ProcessaOutput: � necess�rio o par�metro "NomeArquivo"!');
  FNameArquivo:= TFrwServiceLocator.GetTempPath+FNameArquivo;

  FVisualizacao:= pExportParameter.Parameters.ParamValue('Visualizacao', '');
  if FVisualizacao <> '' then  // Carrega Visualiza��o
    pConsulta.CarregaVisualizacaoByName(FVisualizacao);

  FTipoVisualizacao:= pExportParameter.Parameters.ParamValue('TipoVisualizacao', '');
  FTipoVisualizacao:= AnsiUpperCase(Trim(FTipoVisualizacao));

  if FTipoVisualizacao = 'TABELA' then
     pConsulta.ExportaTabelaParaExcelInterno(FNameArquivo)
  else if FTipoVisualizacao = 'TABELADINAMICA' then
     pConsulta.ExportaTabelaDinamica(FNameArquivo)
  else if FTipoVisualizacao = 'GRAFICO' then
     pConsulta.ExportaGrafico(FNameArquivo)
  else
    pConsulta.ExportaTabelaParaExcelInterno(FNameArquivo);

  pExportParameter.Value:= FNameArquivo;

  FOutput:= Outputs.Param('Files');
  FResult:= FOutput.Value;
  if VarIsNull(FResult) then
    FResult:= _Arr([FNameArquivo])
  else
    TDocVariantData(FResult).AddItem(FNameArquivo);

  FOutput.Value:= FResult;
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

  NomeConsulta:= Inputs.ParamValue('NomeConsulta', '');

  TFrwServiceLocator.Synchronize(
    procedure begin
      FConsultaPersonalizada:= TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName(NomeConsulta, False);
    end
  );

  if not Assigned(FConsultaPersonalizada) then
    raise Exception.Create('TExecutorConsultaPersonalizada.ConfiguraConsulta: Consulta "'+NomeConsulta+'" n�o encontrada!);');

  SetaParametros; // Copia o valor dos parametros de input para os parametros da consulta

  Result:= FConsultaPersonalizada;
end;

class function TExecutorConsultaPersonalizada.Description: String;
begin
  Result:= 'Consulta Personalizada';
end;

function TExecutorConsultaPersonalizada.Executar: TOutputList;
var
  FExport: TParameter;
  FExportParam: TParameter;
  FDataParam: TOutputParameter;
  FConsulta: TFrmConsultaPersonalizada;
  FData: Variant;
begin
  FConsulta:= ConfiguraConsulta;
  try
    FConsulta.ExecutaConsulta;

    FDataParam:= Outputs.Param('Data');
    if Assigned(FDataParam) then
      FDataParam.Value:= FConsulta.ResultAsDocVariant;

    FExport:= Inputs.Param('Export'); // Export result to file
    if Assigned(FExport) then
      for FExportParam in FExport.Parameters do
        ProcessaOutput(FConsulta, FExportParam);

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
