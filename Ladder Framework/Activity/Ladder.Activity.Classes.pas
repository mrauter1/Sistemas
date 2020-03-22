unit Ladder.Activity.Classes;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Data.DB, uConsultaPersonalizada,
  Ladder.ServiceLocator, Generics.Defaults, Variants;

type
  TTipoProcesso = (tpConsultaPersonalizada = 1, tpEnvioEmail = 2);
  TTipoOutput = (toValue=1, toList=2);
  TTipoBase = (tbString, tbLista, tbData);

  TProcessoBase = class;

  TInputBase = class(TObject)
  private
    FCodigo: integer;
    FTipoBase: TTipoBase;
    FNome: String;
    FExpression: String;
    FValor: variant;
  public
    constructor Create(pNome: String; pTipoBase: TTipoBase; pExpression: String);
    property Valor: variant read FValor write FValor;
  published
    property Codigo: integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property TipoBase: TTipoBase read FTipoBase write FTipoBase;
    property Expression: String read FExpression write FExpression;
  end;

  TGenericInputList<T: TInputBase> = class(TObjectDictionary<String, T>)
  public
    constructor Create;
    function ParamValueByName(pNome: String; pDefault: Variant): variant;
    procedure Add(pInput: TInputBase); overload;
    procedure Remove(pInput: TInputBase); overload;
  end;

  TInputList = TGenericInputList<TInputBase>;

  TValuateInputCallback = procedure (pProcesso: TProcessoBase; pInput: TInputBase) of object; // Returns a single item for value and an array for lists

{  TParserBase = class
    function EvaluateList(pString: String): array of string;
    function EvaluateValue(pString: String): string;
  end;                                                                   }

  TOutputBase = class(TPersistent)
  private
    FNome: String;
    FID: Integer;
    FRetorno: String;
    FTipo: TTipoOutput;
    FParametros: TInputList;
  public
    constructor Create;
    destructor Destroy; override;
    property Retorno: String read FRetorno write FRetorno; // Nome da tabela temporária ou nome do arquivo
  published
    property ID: Integer read FID write FID;
    property Nome: String read FNome write FNome;
    property Tipo: TTipoOutput read FTipo write FTipo;
    property Parametros: TInputList read FParametros write FParametros;
  end;

  TOutputList = TObjectList<TOutputBase>;

  TExecutorBase = class(TPersistent)
  public
    Inputs: TInputList;
    Outputs: TOutputList;
    constructor Create(pInputs: TInputList; pOutputs: TOutputList); overload;
    function Executar(pInputs: TInputList; pOutputs: TOutputList): TOutputList; overload;
    function Executar: TOutputList; overload; virtual;
  end;

  TExecutorConsultaPersonalizada = class(TExecutorBase)
  private
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
    FNome: String;
    FTipo: TTipoProcesso;
    FExecutor: TExecutorBase;
    function GetExecutor: TExecutorBase;
  public
    constructor Create;
    destructor Destroy; override;
    function Executar(ValuateInputCallback: TValuateInputCallback): TOutputList;
  published
    property ID: Integer read FID write FID;
    property Nome: String read FNome write FNome;
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
    FNome: String;
    procedure ExecutaProcesso(pProcesso: TProcessoBase);
    procedure ValuateInputCallback(pProcesso: TProcessoBase; pInput: TInputBase);
//    function ExpressionEvaluator(pExpression: String): array of string;
  public
    constructor Create;
    destructor Destroy; override;
    function Executar: TOutputList;
  published
    property ID: Integer read FID write FID;
    property Nome: String read FNome write FNome;
    property Descricao: String read FDescricao write FDescricao;
    property Inputs: TInputList read FInputs write FInputs;
    property Outputs: TOutputList read FOutputs write FOutputs;
    property Processos: TObjectList<TProcessoBase> read FProcessos write FProcessos;
  end;

implementation

{ TGenericInputList }

constructor TGenericInputList<T>.Create;
begin
  inherited Create([doOwnsValues], TOrdinalIStringComparer.Create); // case insensitive
end;

function TGenericInputList<T>.ParamValueByName(pNome: String; pDefault: Variant): variant;
var
  FInput: TInputBase;
begin
  if TryGetValue(pNome, FInput) then
    Result:= FInput.Valor
  else
    Result:= pDefault;
end;

procedure TGenericInputList<T>.Add(pInput: TInputBase);
begin
  Add(pInput.Nome, pInput);
end;

procedure TGenericInputList<T>.Remove(pInput: TInputBase);
begin
  Remove(pInput.Nome);
end;

{ TProcessoBase }

constructor TProcessoBase.Create;
begin
  inherited Create;
  FInputs:= TInputList.Create;
  FOutputs:= TOutputList.Create;
end;

destructor TProcessoBase.Destroy;
begin
  FInputs.Free;
  FOutputs.Free;
  inherited Destroy;
end;

function TProcessoBase.Executar(ValuateInputCallback: TValuateInputCallback): TOutputList;
var
  fInput: TInputBase;
  FOutput: TOutputBase;
begin
  for fInput in Inputs.Values do
    ValuateInputCallback(Self, fInput);

  for FOutput in Outputs do
    for fInput in FOutput.Parametros.Values do
      ValuateInputCallback(Self, fInput);

  FExecutor:= GetExecutor;
  try
    FExecutor.Inputs:= Inputs;
    FExecutor.Outputs:= Outputs;
    FExecutor.Executar;
  finally
    FExecutor.Free;
  end;
  Result:= Outputs;
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
  inherited Create;
  FInputs:= TInputList.Create;
  FOutputs:= TOutputList.Create;
  FProcessos:= TObjectList<TProcessoBase>.Create;
end;

destructor TAtividade.Destroy;
begin
  FInputs.Free;
  FOutputs.Free;
  FProcessos.Free;
  inherited Destroy;
end;

procedure TAtividade.ExecutaProcesso(pProcesso: TProcessoBase);
{var
  fOutput: TOutputBase;        }
begin
  pProcesso.Executar(ValuateInputCallback);
end;

function TAtividade.Executar: TOutputList;
var
  FProcesso: TProcessoBase;
begin
  for FProcesso in Processos do
    ExecutaProcesso(FProcesso);

  Result:= Outputs;
end;

procedure TAtividade.ValuateInputCallback(pProcesso: TProcessoBase; pInput: TInputBase);
const
  cKeyWords = ['@', '['];
begin
  // Se expressão não iniciar com palavra chave trata como string
  if not (pInput.Expression[1] in cKeyWords) then
  begin
    pInput.Valor:= pInput.Expression;
    Exit;
  end;
end;

{ TExecutorBase }

constructor TExecutorBase.Create(pInputs: TInputList;
  pOutputs: TOutputList);
begin
  inherited Create;
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

function TExecutorBase.Executar: TOutputList;
begin
  raise Exception.Create('TExecutorBase.Executar: Deve ser implementado na subclasse!');
  { Implementar na subclass }
end;

{ TExecutorConsultaPersonalizada }

procedure TExecutorConsultaPersonalizada.CheckInputs;
begin

end;

procedure TExecutorConsultaPersonalizada.ProcessaOutput(pConsulta: TFrmConsultaPersonalizada; pOutput: TOutputBase);
var
  FVisualizacao: String;
  FTipoVisualizacao: String;
  FNomeArquivo: String;
begin
  FNomeArquivo:= pOutput.Parametros.ParamValueByName('NomeArquivo', '');
  if FNomeArquivo = '' then
    raise Exception.Create('TExecutorConsultaPersonalizada.ProcessaOutput: É necessário o parâmetro "NomeArquivo"!');
  FNomeArquivo:= TFrwServiceLocator.GetTempPath+FNomeArquivo;

  FVisualizacao:= pOutput.Parametros.ParamValueByName('Visualizacao', '');
  if FVisualizacao <> '' then  // Carrega Visualização
    pConsulta.CarregaVisualizacaoByName(FVisualizacao);

  FTipoVisualizacao:= pOutput.Parametros.ParamValueByName('TipoVisualizacao', '');
  FTipoVisualizacao:= AnsiUpperCase(Trim(FTipoVisualizacao));

  if FTipoVisualizacao = 'TABELA' then
     pConsulta.ExportaTabelaParaExcelInterno(FNomeArquivo)
  else if FTipoVisualizacao = 'TABELADINAMICA' then
     pConsulta.ExportaTabelaDinamica(FNomeArquivo)
  else if FTipoVisualizacao = 'GRAFICO' then
     pConsulta.ExportaGrafico(FNomeArquivo)
  else
    pConsulta.ExportaTabelaParaExcelInterno(FNomeArquivo);

  pOutput.Retorno:= FNomeArquivo;
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
  Result:= Outputs;
end;

{ TOutputBase }

constructor TOutputBase.Create;
begin
  FParametros:= TInputList.Create;
end;

destructor TOutputBase.Destroy;
begin
  FParametros.Free;
end;

{ TInputBase }

constructor TInputBase.Create(pNome: String; pTipoBase: TTipoBase;
  pExpression: String);
begin
  inherited Create;
  Nome:= pNome;
  TipoBase:= pTipoBase;
  Expression:= pExpression;
end;

end.
