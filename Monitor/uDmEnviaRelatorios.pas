unit uDmEnviaRelatorios;

interface

uses
  System.SysUtils, System.Classes, uConSqlServer, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uDataSetToHtml, Datasnap.DBClient,
  System.Generics.Collections, WinApi.ShellAPI, Windows,
  uConClasses;

type
  TTipoGatilho = (tgIntervalo, tgHora);

  TDiaSemana = (dsDomingo=1, dsSegunda, dsTerca, dsQuarta, dsQuinta, dsSexta, dsSabado);
  TDiasSemana = set of TDiaSemana;

  TGatilho = class(TComponent)
  private
    procedure OnTimer(Sender: TObject);
    procedure CarregaDataUltimaExec;
    procedure FazExecucao;
    procedure GravaDataUltimaExec;
  public
    EmExecucao: Boolean;

    Execucao: TProc;

    Timer: TTimer;
    DataUltimaExec: TDatetime;

    Dias: TDiasSemana;
    Nome: String;

    TipoGatilho: TTipoGatilho;
    Hora: TTime;
    Intervalo: Integer; // Em segundos

    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; pNome: String; proc: TProc; pIntervalo: Integer); overload;
    constructor Create(AOwner: TComponent; pNome: String; proc: TProc; pHora: TTime; pDias: TDiasSemana); overload;
  end;

  TCon = class(TDataModule)
    TimerRelatorios: TTimer;
    QryRelatorios: TFDQuery;
    CdsGatilhos: TClientDataSet;
    CdsGatilhosNome: TStringField;
    CdsGatilhosUltimaExec: TDateTimeField;
    QrySimilares: TFDQuery;
    QrySimilaresCod1: TStringField;
    QrySimilaresCod2: TStringField;
    QryInsumosSugeridos: TFDQuery;
    QryInsumosSugeridosProInsumo: TStringField;
    QryInsumosSugeridosCodInsumo: TStringField;
    QryInsumosSugeridosInsumoSugerido: TStringField;
    QryInsumosSugeridosNomeInsumoSugerido: TStringField;
    QryInsumosSugeridosESTOQUEATUAL: TBCDField;
    procedure DataModuleCreate(Sender: TObject);
    procedure CdsGatilhosAfterPost(DataSet: TDataSet);
  private
    procedure EnviaMetaEvolutivo;
    procedure EnviaAumentoPreco;
    function GetEmailVendedor(pCodVendedor: String): String;
    procedure EnviaMetaEvolutivoVendedor(pCodVendedor, pEmail: String);
//    procedure AtualizaProdutosSimilares;
    procedure EnviaDataFaltaProduto;
    procedure FazBackup;
    procedure AtualizaListaPreco;
    procedure AtualizaModelosProducao;
    procedure EnviaMetaEquipes; // Atualiza modelos de produção por insumos equivalentes
  protected
    FEnviaEmailConsulta: TEnviaEmailConsulta;
    function GetListaComprovantes: String;
    procedure EnviaMargemPorVendas;
    procedure EnviaMetaVendas;
    procedure EnviaErrosOP;
    procedure EnviaVendasMargemBaixa;
    function TercaASabado: TDiasSemana;
    { Private declarations }
  public
    { Public declarations }
  end;

  TEnviaEmailMetaVendas = class(TEnviaEmailConsulta)
  public
    function ExportaTabelaParaExcel: String; override;
    class function EnviarEmail: Boolean;
  end;

  TEnviaModificacaoCustoMedio = class(TEnviaEmailConsulta)
  public
    function ExportaTabelaParaExcel: String; override;
    class function EnviarEmail: Boolean;
  end;


var
  Con: TCon;

function DiasUteis: TDiasSemana;
function TodosOsDias: TDiasSemana;

implementation

uses
  uConFirebird, uDmGeradorConsultas, Utils, DateUtils, Dialogs, uMonitorAppConfig, uDmGravaLista, uMonitorRoot;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function DiasUteis: TDiasSemana;
begin
  Result:= [dsSegunda, dsTerca, dsQuarta, dsQuinta, dsSexta];
end;

function TodosOsDias: TDiasSemana;
begin
  Result:= [dsDomingo, dsSegunda, dsTerca, dsQuarta, dsQuinta, dsSexta, dsSabado];
end;

function TCon.GetListaComprovantes: String;
var
  FDataSet: TDataSet;
begin
  Result:= '';
  FDataSet:= ConFirebird.RetornaDataSet('SELECT CODCOMPROVANTE FROM COMPRV WHERE NOMECOMPROVANTE LIKE ''%VEND%''');
  FDataSet.First;
  try
    while not FDataSet.Eof do
    begin
      if Result <> '' then
        Result:= Result+',';
      Result:= Result+FDataSet.FieldByName('CODCOMPROVANTE').AsString;

      FDataSet.Next;
    end;

  finally
    FDataSet.Free;
  end;
end;

function TCon.TercaASabado: TDiasSemana;
begin
  Result:= [dsTerca, dsQuarta, dsQuinta, dsSexta, dsSabado];
end;

procedure TCon.AtualizaModelosProducao;

  function GetSqlUpdate(pCodInsumo, pCodInsumoSugerido: String): String;
  begin
    Result:= ' UPDATE INSUMOS_INSUMO SET CODPRODUTO = '+pCodInsumoSugerido.QuotedString+
             ' WHERE CODPRODUTO = '+pCodInsumo.QuotedString+
             ' AND CODMODELO NOT IN (SELECT CODMODELO FROM INSUMOS_ACABADO IA '+
               ' WHERE IA.CODPRODUTO = '+pCodInsumoSugerido.QuotedString+')';
  end;

begin
  if QryInsumosSugeridos.Active then
    QryInsumosSugeridos.Close;

  QryInsumosSugeridos.Open;
  QryInsumosSugeridos.First;
  while not QryInsumosSugeridos.Eof do
  begin
    ConFirebird.ExecutaComando(GetSqlUpdate(QryInsumosSugeridosCodInsumo.AsString, QryInsumosSugeridosInsumoSugerido.AsString));
    QryInsumosSugeridos.Next;
  end;
  QryInsumosSugeridos.Close;
end;

procedure TCon.CdsGatilhosAfterPost(DataSet: TDataSet);
begin
  CdsGatilhos.SaveToFile('Gatilhos.xml', dfXML);
end;

procedure TCon.DataModuleCreate(Sender: TObject);
begin
  try
    uDataSetToHtml.WriteLog('Carregando Gatihlos.xml');
    CdsGatilhos.LoadFromFile('Gatilhos.xml');
  except
  end;

  if not MonitorAppConfig.SchedulerEnabled then
  begin
    ShowMessage('Avisos automáticos não estão sendo executados.');
    Exit;
  end;

  MonitorAppConfig.Scheduler.Start;

  if not CdsGatilhos.Active then
    CdsGatilhos.CreateDataSet;

  uDataSetToHtml.WriteLog('Criando Gatilhos');

  TGatilho.Create(Self,
          'FazBackup',
          procedure()
          begin
            FazBackup;
          end,
          StrToTime('23:10:00'), TercaASabado);

  TGatilho.Create(Self,
          'AtualizaListaPreco',
          procedure()
          begin
            AtualizaListaPreco;
          end,
          StrToTime('00:10:00'), [dsSegunda, dsTerca, dsQuarta, dsQuinta, dsSexta, dsSabado]);

  TGatilho.Create(Self,
          'AtualizaModelosProducao',
          procedure()
          begin
            AtualizaModelosProducao;
          end,
          StrToTime('04:20:00'), TercaASabado);

  uDataSetToHtml.WriteLog('Gatilhos criados');

{  TGatilho.Create(Self,
          'AtualizaProdutosSimilares',
          procedure()
          begin
            AtualizaProdutosSimilares;
          end,
          StrToTime('01:00:00'), TercaASabado);

  TGatilho.Create(Self,
          'EnviaMetaVendas',
          procedure()
          begin
            EnviaMetaVendas;
          end,
          StrToTime('04:30:00'), TercaASabado);

  TGatilho.Create(Self,
          'EnviaMetaEvolutivo',
          procedure()
          begin
            EnviaMetaEvolutivo;
          end,
          StrToTime('04:35:00'), TercaASabado);

  TGatilho.Create(Self,
          'EnviaMetaEquipes',
          procedure()
          begin
            EnviaMetaEquipes;
          end,
          StrToTime('04:40:00'), TercaASabado);

  TGatilho.Create(Self,
          'EnviaVendasMargemBaixa',
          procedure()
          begin
            EnviaVendasMargemBaixa;
          end,
          StrToTime('05:00:00'), TercaASabado);

  TGatilho.Create(Self,
          'EnviaAumentoPreco',
          procedure()
          begin
            EnviaAumentoPreco;
          end,
          StrToTime('05:15:00'), TercaASabado);

  TGatilho.Create(Self,
          'EnviaErrosOP',
          procedure()
          begin
            EnviaErrosOP;
          end,
          StrToTime('04:00:00'), TercaASabado);

  TGatilho.Create(Self,
          'EnviaDataFaltaProduto',
          procedure()
          begin
            EnviaDataFaltaProduto;
          end,
          StrToTime('04:10:00'), TercaASabado);

  TGatilho.Create(Self,
          'EnviaModificacaoCustoMedio',
          procedure()
          begin
            TEnviaModificacaoCustoMedio.EnviarEmail;
          end,
          StrToTime('04:15:00'), TercaASabado);     }
end;
                      {
procedure TCon.AtualizaProdutosSimilares;

  procedure Adiciona(pCodPro1, pCodPro2: String);
  const
    cSql = ' INSERT INTO PRODUTOSIMILAR (CODPRODUTO, CODPROSIMILAR) VALUES (''%s'', ''%s'') ';
  begin
    ConFirebird.ExecutaComando(Format(cSql, [pCodPro1, pCodPro2]));
  end;

begin
  QrySimilares.Close;
  QrySimilares.Open;

  QrySimilares.First;
  while not QrySimilares.Eof do
  begin
    Adiciona(QrySimilaresCod1.AsString, QrySimilaresCod2.AsString);
    QrySimilares.Next;
  end;
end;              }

procedure TCon.AtualizaListaPreco;
{var
  FListaPrecoPy: String;  }
begin
  TDmGravaLista.AtualizaTodasListasDePreco;
{*  FListaPrecoPy:= IncludeTrailingPathDelimiter(AppConfig.PythonFilePath)+'AtualizaPrecosLista.py';

  if FileExists(AppConfig.PythonPath) and FileExists(FListaPrecoPy) then
  begin
    ShellExecute(0, 'open', pchar(AppConfig.PythonPath), pChar(FListaPrecoPy), pChar(AppConfig.PythonFilePath), SW_SHOW);
    uDataSetToHtml.WriteLog('Script para atualizar lista de preço incializado.');
  end
 else
   uDataSetToHtml.WriteLog('Caminho do executável python ou arquivo '+FListaPrecoPy+' não encontrado!');*}
end;

procedure TCon.FazBackup;
const
  cNewBkp='E:\Dados\Logistec.Bak';
  cOldBkp='E:\Dados\Logistec.old.Bak';
begin
  if FileExists(cNewBkp) then
  begin
    if FileExists(cOldBkp) then
      System.SysUtils.DeleteFile(cOldBkp);

    RenameFile(cNewBkp, cOldBkp);
  end;

  ConSqlServer.ExecutaComando('exec FazBackup');
end;

procedure TCon.EnviaMargemPorVendas;
begin
  FEnviaEmailConsulta:= TEnviaEmailConsulta.Create(Self);
  try
  {  FEnviaEmailConsulta.ConsultaNome:= 'VendasMargemBaixaOntem';
    FEnviaEmailConsulta.Destinatarios:= 'marcelo@rauter.com.br';
    FEnviaEmailConsulta.EnviarTabela;                }
    FEnviaEmailConsulta.ConsultaNome:= 'MargemPorVenda';
    FEnviaEmailConsulta.Destinatarios:= 'marcelo@rauter.com.br';
    FEnviaEmailConsulta.Params.Add('Data', StrToDate('01/01/2018'));
    FEnviaEmailConsulta.Params.Add('CodComprovante', GetListaComprovantes);
    FEnviaEmailConsulta.Visualizacao:= 'Margem e Valor x Período';
    FEnviaEmailConsulta.TipoVisualizacao:= tvGrafico;
    FEnviaEmailConsulta.EnviarTabela;
  finally
    FEnviaEmailConsulta.Free;
  end;
end;

procedure TCon.EnviaErrosOP;
begin
  FEnviaEmailConsulta:= TEnviaEmailConsulta.Create(Self);
  try
    FEnviaEmailConsulta.ConsultaNome:= 'DiferencaOP';
    FEnviaEmailConsulta.Destinatarios:= 'marcelo@rauter.com.br;silvia.muniz@rauter.com.br';
    FEnviaEmailConsulta.Titulo:= 'Ordens de Produção com Erro!';
    FEnviaEmailConsulta.Texto:= 'Ordens de produção com diferença no peso da entrada e das saídas em anexo. ';
    FEnviaEmailConsulta.Params.Add('DataIni', StartOfTheDay(Now-1));
    FEnviaEmailConsulta.Params.Add('DataFim', EndOfTheDay(now-1));
    FEnviaEmailConsulta.TipoVisualizacao:= tvTabela;
    FEnviaEmailConsulta.EnviarTabela;
  finally
    FEnviaEmailConsulta.Free;
  end;
end;

procedure TCon.EnviaDataFaltaProduto;
begin
  FEnviaEmailConsulta:= TEnviaEmailConsulta.Create(Self);
  try
    FEnviaEmailConsulta.ConsultaNome:= 'DiaPrevistoFalta';
//    FEnviaEmailConsulta.Destinatarios:= 'marcelo@rauter.com.br;silvia.muniz@rauter.com.br';
    FEnviaEmailConsulta.Destinatarios:= 'marcelo@rauter.com.br; silvia.muniz@rauter.com.br; alessandra@rauter.com.br; ricardo@rauter.com.br;'+
                                        GetEmailVendedor('000010')+';'+
                                        GetEmailVendedor('000018')+';'+
                                        GetEmailVendedor('000023');

    FEnviaEmailConsulta.Titulo:= 'Previsão da Data em que a Matéria Prima vai faltar';
    FEnviaEmailConsulta.Texto:= 'Relatório com todas as Matérias Primas e a previsão da data em que vai haver falta. '
                                 +sLineBreak+sLineBreak
                                 +'O cálculo da data é feito levando em consideração o estoque atual, a demanda diária e a quantidade de pedidos agendados para a matéria prima e dos produtos que se utilizam dela para sua produção.'
                                 +' Nos casos em que o pedido é de produto industrializado se considera a quantidade proporcional de matéria prima utilizada na fabricação de acordo com a Ordem de Produção cadastrada no sistema.'
                                 +sLineBreak+sLineBreak
                                 +'É considerado o percentual de aproximadamente 20% de chance para a falta do produto na data calculada, ou seja, existe 80% de chance de que não ocorra falta na data ou antes dela.';
    FEnviaEmailConsulta.TipoVisualizacao:= tvTabela;
    FEnviaEmailConsulta.EnviarTabela;

  finally
    FEnviaEmailConsulta.Free;
  end;
end;


procedure TCon.EnviaMetaVendas;
begin
  TEnviaEmailMetaVendas.EnviarEmail;
end;

procedure TCon.EnviaMetaEvolutivo;
begin
  FEnviaEmailConsulta:= TEnviaEmailConsulta.Create(Self);
  try
    FEnviaEmailConsulta.ConsultaNome:= 'MetaVendaEvolutivo';
    FEnviaEmailConsulta.Visualizacao:= 'Venda e Margem Geral';

    FEnviaEmailConsulta.Params.Add('geDataIni', StartOfTheMonth(Now-1));
    FEnviaEmailConsulta.Params.Add('geDataFim', EndOfTheDay(now-1));

    FEnviaEmailConsulta.Destinatarios:= 'marcelo@rauter.com.br; alessandra@rauter.com.br; ricardo@rauter.com.br';
    FEnviaEmailConsulta.Titulo:= 'Grafico evolutivo das vendas e metas até '+DateToStr(Now-1)+'!';
    FEnviaEmailConsulta.Texto:= 'Segue em anexo gráfico evolutivo com as metas de venda e margem.';

    FEnviaEmailConsulta.TipoVisualizacao:= tvGrafico;
    FEnviaEmailConsulta.EnviarTabela;
  finally
    FEnviaEmailConsulta.Free;
  end;
end;

procedure TCon.EnviaVendasMargemBaixa;
begin
  FEnviaEmailConsulta:= TEnviaEmailConsulta.Create(Self);
  try
    FEnviaEmailConsulta.ConsultaNome:= 'VendasMargemBaixaOntem';
    FEnviaEmailConsulta.Destinatarios:= 'marcelo@rauter.com.br; alessandra@rauter.com.br; ricardo@rauter.com.br';
    FEnviaEmailConsulta.Titulo:= 'Vendas com Margem Abaixo do Limite!';
    FEnviaEmailConsulta.Texto:= 'Relatório com vendas abaixo do limite em anexo.';
    FEnviaEmailConsulta.TipoVisualizacao:= tvTabela;
    FEnviaEmailConsulta.EnviarTabela;
  finally
    FEnviaEmailConsulta.Free;
  end;
end;

function TCon.GetEmailVendedor(pCodVendedor: String): String;
begin
  Result:= ConSqlServer.RetornaValor('SELECT EMAIL FROM VENDEDOR WHERE CODVENDEDOR = '+QuotedStr(pCodVendedor)+' ', '');
end;


procedure TCon.EnviaMetaEvolutivoVendedor(pCodVendedor, pEmail: String);
begin
  FEnviaEmailConsulta:= TEnviaEmailConsulta.Create(Self);
  try
    FEnviaEmailConsulta.ConsultaNome:= 'MetaVendaEvolutivo';
    FEnviaEmailConsulta.Visualizacao:= 'Vendas e Meta no Período';

    FEnviaEmailConsulta.Params.Add('CodVendedor', pCodVendedor);

    FEnviaEmailConsulta.Params.Add('geDataIni', StartOfTheMonth(Now-1));
    FEnviaEmailConsulta.Params.Add('geDataFim', EndOfTheDay(now-1));

    FEnviaEmailConsulta.Destinatarios:= pEmail;
    FEnviaEmailConsulta.Titulo:= 'Vendas realizadas e meta esperada até o dia '+IntToStr(DayOf(now))
                                                                            +' de ' +GetMesString(now)
                                                                            +' de '+IntToStr(YearOf(Now));;
    FEnviaEmailConsulta.Texto:= 'Segue em anexo gráfico com as vendas realizadas e meta esperada até o dia '+IntToStr(DayOf(now))
                                                                            +' de ' +GetMesString(now)
                                                                            +' de '+IntToStr(YearOf(Now));;

    FEnviaEmailConsulta.TipoVisualizacao:= tvGrafico;
    FEnviaEmailConsulta.EnviarTabela;
  finally
    FEnviaEmailConsulta.Free;
  end;
end;

procedure TCon.EnviaMetaEquipes;

  procedure EnviaMetaEquipe(pCodEquipe, pEmail: String);
  begin
    FEnviaEmailConsulta:= TEnviaEmailConsulta.Create(Self);
    try
      FEnviaEmailConsulta.ConsultaNome:= 'MetaEquipe';
  //    FEnviaEmailConsulta.Visualizacao:= '';

      FEnviaEmailConsulta.Params.Add('CodEquipe', pCodEquipe);

      FEnviaEmailConsulta.Destinatarios:= pEmail;
      FEnviaEmailConsulta.Titulo:= 'Meta da Venda da Equipe!';
      FEnviaEmailConsulta.Texto:= 'Segue em anexo tabela com as metas da equipe.';

      FEnviaEmailConsulta.TipoVisualizacao:= tvTabela;
      FEnviaEmailConsulta.EnviarTabela;
    finally
      FEnviaEmailConsulta.Free;
    end;
  end;

var
  Vendedores: TDictionary<String, string>;

begin
  Vendedores:= TDictionary<String, String>.Create;
  try
    EnviaMetaEquipe('1', GetEmailVendedor('000010')); // Equipe Édison
    EnviaMetaEquipe('2', GetEmailVendedor('000018')); // Equipe Wagner

  finally
    Vendedores.Free;
  end;
end;

procedure TCon.EnviaAumentoPreco;

  procedure EnviaAumentoPrecoVendedor(pCodVendedor, pEmail: String);
  begin
    FEnviaEmailConsulta:= TEnviaEmailConsulta.Create(Self);
    try
      FEnviaEmailConsulta.ConsultaNome:= 'VendasDescontoAltoOntem';
  //    FEnviaEmailConsulta.Visualizacao:= '';

      FEnviaEmailConsulta.Params.Add('CodVendedor', pCodVendedor);
      FEnviaEmailConsulta.Params.Add('DataIni', Now-1);
      FEnviaEmailConsulta.Params.Add('DataFim', Now-1);

      FEnviaEmailConsulta.Destinatarios:= pEmail;
      FEnviaEmailConsulta.Titulo:= 'Vendas de ontem com desconto acima de 27%!';
      FEnviaEmailConsulta.Texto:= 'Segue em anexo tabela com as vendas de ontem e o desconto real para cada uma. '
                                  +sLineBreak+sLineBreak+
                                  'O desconto real é calculado com base no preço de lista mais frete mais custo financeiro.';

      FEnviaEmailConsulta.TipoVisualizacao:= tvTabela;
      FEnviaEmailConsulta.EnviarTabela;
    finally
      FEnviaEmailConsulta.Free;
    end;
  end;

var
  Vendedores: TDictionary<String, string>;
  Vendedor: String;

begin
  Vendedores:= TDictionary<String, String>.Create;
  try
    Vendedores.Add('000000', GetEmailVendedor('000000')+'; alessandra@rauter.com.br'); //Direto
    Vendedores.Add('000001', GetEmailVendedor('000001')+'; '+GetEmailVendedor('000018')+'; vendas@rauter.com.br'); //Filter Castilhos
    Vendedores.Add('000006', GetEmailVendedor('000006')+'; '+GetEmailVendedor('000018')+'; vendas@rauter.com.br'); // Loja
//    Vendedores.Add('000010', GetEmailVendedor('000010')); // Edison
    Vendedores.Add('000018', GetEmailVendedor('000018')); // Wagner
    Vendedores.Add('000023', GetEmailVendedor('000023')); // Fernanda
    Vendedores.Add('000026', GetEmailVendedor('000026')); // Jeanete
    Vendedores.Add('000043', GetEmailVendedor('000043')); // Micheline
    Vendedores.Add('000040', GetEmailVendedor('000040')); // Anderson

    for Vendedor in Vendedores.Keys do
    begin
      EnviaAumentoPrecoVendedor(Vendedor, Vendedores[Vendedor]);
      EnviaMetaEvolutivoVendedor(Vendedor, Vendedores[Vendedor]);
    end;

  finally
    Vendedores.Free;
  end;
end;

{ TEnviaEmailMetaVendas }

class function TEnviaEmailMetaVendas.EnviarEmail: Boolean;
var
  FEmailMeta: TEnviaEmailMetaVendas;
begin
  FEmailMeta:= TEnviaEmailMetaVendas.Create(nil);
  try
    FEmailMeta.Destinatarios:= 'marcelo@rauter.com.br; alessandra@rauter.com.br; ricardo@rauter.com.br';

    FEmailMeta.Titulo:= 'Vendas realizadas e metas por vendedor até o dia '+IntToStr(DayOf(now))
                                                                              +' de ' +GetMesString(now)
                                                                              +' de '+IntToStr(YearOf(Now));
    FEmailMeta.Texto:= 'Gráfico com o comparativo das vendas realizadas e das metas esperadas até o dia '+IntToStr(DayOf(now))
                                                                              +' de ' +GetMesString(now)
                                                                              +' de '+IntToStr(YearOf(Now))
                                                                              +' em anexo.';
    FEmailMeta.EnviarTabela;

    Result:= True;
  finally
    FEmailMeta.Free;
  end;
end;

function TEnviaEmailMetaVendas.ExportaTabelaParaExcel: String;
begin
  ConsultaNome:= 'MetaVendedores';
  Visualizacao:= 'Realizado e Meta da Venda e Margem';
  TipoVisualizacao:= tvGrafico;

  Result:= inherited ExportaTabelaParaExcel;

  TipoVisualizacao:= tvTabela;

  Result:= Result+';'+inherited ExportaTabelaParaExcel;
end;

{ TGatilho }

constructor TGatilho.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  EmExecucao:= False;

  Timer:= TTimer.Create(Self);
  Timer.Interval:= 1000;
  Timer.OnTimer:= OnTimer;
  Timer.Enabled:= True;
end;

constructor TGatilho.Create(AOwner: TComponent; pNome: String; proc: TProc; pIntervalo: Integer);
begin
  Create(AOwner);

  Execucao:= proc;

  Nome:= pNome;
  TipoGatilho:= tgIntervalo;
  Intervalo:= pIntervalo;
end;

constructor TGatilho.Create(AOwner: TComponent; pNome: String; proc: TProc; pHora: TTime;
  pDias: TDiasSemana);
begin
  Create(AOwner);

  Execucao:= proc;

  Nome:= pNome;
  TipoGatilho:= tgHora;
  Hora:= pHora;
  Dias:= pDias;
end;

procedure TGatilho.CarregaDataUltimaExec;
begin
  if not Con.CdsGatilhos.Locate('Nome', Nome, [loCaseInsensitive]) then
  begin
    Con.CdsGatilhos.Insert;
    Con.CdsGatilhosNome.AsString:= Nome;
    DataUltimaExec:= 0;
    Con.CdsGatilhos.Post;
  end
 else
  begin
    DataUltimaExec:= Con.CdsGatilhosUltimaExec.AsDateTime;
  end;
end;

procedure TGatilho.GravaDataUltimaExec;
begin
  if Con.CdsGatilhos.Locate('Nome', Nome, [loCaseInsensitive]) then
  begin
    Con.CdsGatilhos.Edit;
    Con.CdsGatilhosUltimaExec.AsDateTime:= Now;
    Con.CdsGatilhos.Post;
  end;
end;

procedure TGatilho.FazExecucao;
begin
  WriteLog('Monitor.log', 'Iniciando execução do gatilho '+Nome);
  EmExecucao:= True;
  try
    try
      Execucao();
    except
      on E: Exception do
        WriteLog('Erros Execução.log', 'Erro ao executar gatilho '+Nome+': '+E.Message);
    end;
    DataUltimaExec:= Now;
    GravaDataUltimaExec;
  finally
    EmExecucao:= False;
  end;
end;

procedure TGatilho.OnTimer(Sender: TObject);
begin
  CarregaDataUltimaExec;

  if EmExecucao then
    Exit;

  if TipoGatilho = tgIntervalo then
  begin
    if SecondsBetween(DataUltimaExec, Now) >= Intervalo then
    begin
      FazExecucao;
    end;
  end
 else // tgHora
  begin
    if (Trunc(DataUltimaExec) <> Trunc(Now)) and (TDiaSemana(DayOfWeek(Now)) in Dias) then
    begin
      if (Now >= Trunc(Now) + Hora) then
        FazExecucao;
    end;
  end;
end;

{ TEnviaModificacaoCustoMedio }

class function TEnviaModificacaoCustoMedio.EnviarEmail: Boolean;
var
  FEmail: TEnviaModificacaoCustoMedio;
begin
  FEmail:= TEnviaModificacaoCustoMedio.Create(nil);
  try
    FEmail.Destinatarios:= 'marcelo@rauter.com.br; ricardo@rauter.com.br; silvia.muniz@rauter.com.br';

    FEmail.Titulo:= 'Produtos com Alteração no Custo Médio e Custo Médio Dos Tanques';
    FEmail.Texto:= 'Produtos com Alteração no Custo Médio Desde o Último Dia Útil e Tabela com o Custo Médio Dos Tanques na Data de Hoje';
    FEmail.EnviarTabela;

    Result:= True;
  finally
    FEmail.Free;
  end;
end;

function TEnviaModificacaoCustoMedio.ExportaTabelaParaExcel: String;
begin
  ConsultaNome:= 'VariacaoCustoMedio';
  TipoVisualizacao:= tvTabela;

  Result:= inherited ExportaTabelaParaExcel;

  ConsultaNome:= 'CustoMedioTanques';
  TipoVisualizacao:= tvTabela;

  Result:= Result+';'+inherited ExportaTabelaParaExcel;
end;

end.
