unit UntClasses;

interface

uses
  System.SysUtils, uConClasses, System.Classes, System.Generics.Collections, Data.DB, uConsultaPersonalizada,
  uMyServiceLocator;

type
  TTipoProcesso = (tpConsultaPersonalizada = 1);
  TTipoOutput = (toString=1, toTabela=2, toTabelaDinamica=3, toGrafico=4);

  TInputList = TParametros;

  TOutputBase = class(TPersistent)
  private
    FRetorno: String;
    FID: Integer;
    FTipo: TTipoOutput;
    FParametros: TParametros;
  public
    constructor Create;
    destructor Destroy;
  published
    property ID: Integer read FID write FID;
    property Tipo: TTipoOutput read FTipo write FTipo;
    property Retorno: String read FRetorno write FRetorno; // Nome da tabela temporária ou nome do arquivo
    property Parametros: TParametros read FParametros write FParametros;
  end;

  TOutputList = TObjectList<TOutputBase>;

  TExecutorBase = class(TPersistent)
  public
    Inputs: TInputList;
    Outputs: TOutputList;
    constructor Create; overload;
    constructor Create(pInputs: TInputList; pOutputs: TOutputList); overload;
    function Executar(pInputs: TInputList; pOutputs: TOutputList): TOutputList; overload;
    function Executar: TOutputList; overload; virtual;
  end;

  TExecutorConsultaPersonalizada = class(TExecutorBase)
  private
    constructor Create;
    destructor Destroy;
    function ConfiguraConsulta: TFrmConsultaPersonalizada;
    procedure CheckInputs;
    procedure ProcessaOutput(pConsulta: TFrmConsultaPersonalizada; pOutput: TOutputBase);
  public
    function Executar: TOutputList; override;
  end;

  TProcessoBase = class(TPersistent)
  private
    FInputs: TInputList;
    FOutputs: TOutputList;
    FID: Integer;
    FTipo: TTipoProcesso;
    FExecutor: TExecutorBase;
    function GetExecutor: TExecutorBase;
  public
    constructor Create;
    destructor Destroy;
    function Executar: TOutputList;
  published
    property ID: Integer read FID write FID;
    property Tipo: TTipoProcesso read FTipo write FTipo;
    property Inputs: TInputList read FInputs write FInputs;
    property Outputs: TOutputList read FOutputs write FOutputs;
  end;

  TAtividade = class(TPersistent)
  private
    FInputs: TInputList;
    FOutputs: TOutputList;
    FProcessos: TObjectList<TProcessoBase>;
    FDescricao: String;
    FID: Integer;
    procedure ExecutaProcesso(pProcesso: TProcessoBase);
  public
    constructor Create;
    destructor Destroy;
    function Executar: TOutputBase;
  published
    property ID: Integer read FID write FID;
    property Descricao: String read FDescricao write FDescricao;
    property Inputs: TInputList read FInputs write FInputs;
    property Outputs: TOutputList read FOutputs write FOutputs;
    property Processos: TObjectList<TProcessoBase> read FProcessos write FProcessos;
  end;

implementation

{ TProcessoBase }

constructor TProcessoBase.Create;
begin
  FInputs:= TInputList.Create;
  FOutputs:= TOutputList.Create;
end;

destructor TProcessoBase.Destroy;
begin
  FInputs.Free;
  FOutputs.Free;
end;

function TProcessoBase.Executar: TOutputList;
var
  FRetornos: TOutputList;
begin
  FExecutor:= GetExecutor;
  try
    FExecutor.Inputs:= Inputs;
    FExecutor.Outputs:= Outputs;
    Result:= FExecutor.Executar;
  finally
    FExecutor.Free;
  end;
end;

function TProcessoBase.GetExecutor: TExecutorBase;
begin
  if Tipo = tpConsultaPersonalizada then
    Result:= TExecutorConsultaPersonalizada.Create
  else
    raise Exception.Create('TProcessoBase.GetExecutor: Tipo de executor não encontrado!');

end;

{ TAtividade }

constructor TAtividade.Create;
begin
  FInputs:= TInputList.Create;
  FOutputs:= TOutputList.Create;
  FProcessos:= TObjectList<TProcessoBase>.Create;
end;

destructor TAtividade.Destroy;
begin
  FInputs.Free;
  FOutputs.Free;
  FProcessos.Free;
end;

procedure TAtividade.ExecutaProcesso(pProcesso: TProcessoBase);
var
  fOutput: TOutputBase;
begin
  for fOutput in pProcesso.Executar do
    FOutputs.Add(fOutput);
end;

function TAtividade.Executar: TOutputBase;
var
  FProcesso: TProcessoBase;
begin
  for FProcesso in Processos do
    ExecutaProcesso(FProcesso);
end;

{ TExecutorBase }

constructor TExecutorBase.Create(pInputs: TInputList;
  pOutputs: TOutputList);
begin
  Create;
  Inputs:= pInputs;
  Outputs:= pOutputs;
end;

function TExecutorBase.Executar(pInputs: TInputList;
  pOutputs: TOutputList): TOutputList;
begin
  Inputs:= pInputs;
  Outputs:= pOutputs;
  Executar;
  Result:= Outputs;
end;

constructor TExecutorBase.Create;
begin
  inherited Create;
end;

function TExecutorBase.Executar: TOutputList;
begin
  raise Exception.Create('TExecutorBase.Executar: Deve ser implementado na subclasse!');
  { Implementar na subclass }
end;

{ TExecutorConsultaPersonalizada }

constructor TExecutorConsultaPersonalizada.Create;
begin
  inherited Create;
end;

procedure TExecutorConsultaPersonalizada.CheckInputs;
begin

end;

procedure TExecutorConsultaPersonalizada.ProcessaOutput(pConsulta: TFrmConsultaPersonalizada; pOutput: TOutputBase);
var
  Visualizacao: String;
  NomeArquivo: String;
begin
  NomeArquivo:= pOutput.Parametros.ParamValueByName('NomeArquivo', '');
  if NomeArquivo = '' then
    raise Exception.Create('TExecutorConsultaPersonalizada.ProcessaOutput: É necessário o parâmetro "NomeArquivo"!');

  NomeArquivo:= TFrwServiceLocator.GetTempPath+NomeArquivo;

  Visualizacao:= pOutput.Parametros.ParamValueByName('Visualizacao', '');

  // Carrega Visualização
  if Visualizacao <> '' then
    pConsulta.CarregaVisualizacaoByName(Visualizacao);

  case pOutput.Tipo of
    toTabela: pConsulta.ExportaTabelaParaExcelInterno(NomeArquivo);
    toTabelaDinamica: pConsulta.ExportaTabelaDinamica(NomeArquivo);
    toGrafico: pConsulta.ExportaGrafico(NomeArquivo)
  end;

  pOutput.Retorno:= NomeArquivo;

end;

function TExecutorConsultaPersonalizada.ConfiguraConsulta: TFrmConsultaPersonalizada;
var
  NomeConsulta: String;
  Visualizacao: String;
  FInput: TParametroCon;
  FConsultaPersonalizada: TFrmConsultaPersonalizada;
begin
  CheckInputs;

  NomeConsulta:= Inputs.ParamValueByName('NomeConsulta', '');
//  Visualizacao:= Inputs.ParamValueByName('Visualizacao', '');

  TFrwServiceLocator.Synchronize(
    procedure begin
      FConsultaPersonalizada:= TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName(NomeConsulta);
    end
  );

  if not Assigned(FConsultaPersonalizada) then
    raise Exception.Create('TExecutorConsultaPersonalizada.ConfiguraConsulta: Consulta "'+NomeConsulta+'" não encontrada!);');

  Result:= FConsultaPersonalizada;
end;

destructor TExecutorConsultaPersonalizada.Destroy;
begin

end;

function TExecutorConsultaPersonalizada.Executar: TOutputList;
var
  FOutput: TOutputBase;
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
end;

{ TOutputBase }

constructor TOutputBase.Create;
begin
  FParametros:= TParametros.Create;
end;

destructor TOutputBase.Destroy;
begin
  FParametros.Free;
end;

end.
