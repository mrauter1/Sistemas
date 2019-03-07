unit uDmEnviaRelatorios;

interface

uses
  System.SysUtils, System.Classes, uConSqlServer, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uDataSetToHtml, Datasnap.DBClient,
  System.Generics.Collections;

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
    procedure DataModuleCreate(Sender: TObject);
    procedure CdsGatilhosAfterPost(DataSet: TDataSet);
  private
    procedure EnviaMetaEvolutivo;
    procedure EnviaAumentoPreco;
    function GetEmailVendedor(pCodVendedor: String): String;
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
  protected
    function ExportaTabelaParaExcel: String; override;
  private
    class function EnviarEmail: Boolean;
  end;

var
  Con: TCon;

function DiasUteis: TDiasSemana;
function TodosOsDias: TDiasSemana;

implementation

uses
  uConFirebird, uDmGeradorConsultas, Utils, DateUtils, Dialogs;

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

procedure TCon.CdsGatilhosAfterPost(DataSet: TDataSet);
begin
  CdsGatilhos.SaveToFile('Gatilhos.xml', dfXML);
end;

procedure TCon.DataModuleCreate(Sender: TObject);
begin
//  EnviaMetaVendedor
  try
    uDataSetToHtml.WriteLog('Carregando Gatihlos.xml');
    CdsGatilhos.LoadFromFile('Gatilhos.xml');
  except
  end;
  if not CdsGatilhos.Active then
    CdsGatilhos.CreateDataSet;

  uDataSetToHtml.WriteLog('Criando Gatilhos');

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

  uDataSetToHtml.WriteLog('Gatilhos criados');
end;

procedure TCon.EnviaMargemPorVendas;
begin
  FEnviaEmailConsulta:= TEnviaEmailConsulta.Create(Self);
  try
  {  FEnviaEmailConsulta.ConsultaNome:= 'VendasMargemBaixaOntem';
    FEnviaEmailConsulta.Destinatarios:= 'marcelorauter@gmail.com';
    FEnviaEmailConsulta.EnviarTabela;                }
    FEnviaEmailConsulta.ConsultaNome:= 'MargemPorVenda';
    FEnviaEmailConsulta.Destinatarios:= 'marcelorauter@gmail.com';
    FEnviaEmailConsulta.Params.Add('Data', StrToDate('01/01/2018'));
    FEnviaEmailConsulta.Params.Add('CodComprovante', GetListaComprovantes);
    FEnviaEmailConsulta.Visualizacao:= 'Margem e Valor x Per�odo';
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
    FEnviaEmailConsulta.Destinatarios:= 'marcelorauter@gmail.com;silvia.muniz@rauter.com.br';
    FEnviaEmailConsulta.Titulo:= 'Ordens de Produ��o com Erro!';
    FEnviaEmailConsulta.Texto:= 'Ordens de produ��o com diferen�a no peso da entrada e das sa�das em anexo. ';
    FEnviaEmailConsulta.Params.Add('DataIni', StartOfTheDay(Now-1));
    FEnviaEmailConsulta.Params.Add('DataFim', EndOfTheDay(now-1));
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

    FEnviaEmailConsulta.Destinatarios:= 'marcelorauter@gmail.com; alessandra@rauter.com.br; ricardo@rauter.com.br';
    FEnviaEmailConsulta.Titulo:= 'Grafico evolutivo das vendas e metas at� '+DateToStr(Now-1)+'!';
    FEnviaEmailConsulta.Texto:= 'Segue em anexo gr�fico evolutivo com as metas de venda e margem.';

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
    FEnviaEmailConsulta.Destinatarios:= 'marcelorauter@gmail.com; alessandra@rauter.com.br; ricardo@rauter.com.br';
    FEnviaEmailConsulta.Titulo:= 'Vendas com Margem Abaixo do Limite!';
    FEnviaEmailConsulta.Texto:= 'Relat�rio com vendas abaixo do limite em anexo.';
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

procedure TCon.EnviaAumentoPreco;

  procedure EnviaAumentoPrecoVendedor(pCodVendedor, pEmail: String);
  begin
    FEnviaEmailConsulta:= TEnviaEmailConsulta.Create(Self);
    try


      FEnviaEmailConsulta.ConsultaNome:= 'SugestaoAumentoMargem';
  //    FEnviaEmailConsulta.Visualizacao:= '';

      FEnviaEmailConsulta.Params.Add('CodVendedor', pCodVendedor);
      FEnviaEmailConsulta.Params.Add('DataIni', Now-1);
      FEnviaEmailConsulta.Params.Add('DataFim', Now-1);

      FEnviaEmailConsulta.Destinatarios:= 'marcelorauter@gmail.com;'+pEmail;
      FEnviaEmailConsulta.Titulo:= 'Vendas de Ontem com Pre�o Abaixo do Ideal!';
      FEnviaEmailConsulta.Texto:= 'Segue em anexo tabela com as vendas e sugest�o de aumento.';

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
    Vendedores.Add('000001', GetEmailVendedor('000001')+'; alessandra@rauter.com.br'); //Filter Castilhos
    Vendedores.Add('000006', GetEmailVendedor('000006')+'; alessandra@rauter.com.br'); // Loja
    Vendedores.Add('000010', GetEmailVendedor('000010')); // Edison
    Vendedores.Add('000018', GetEmailVendedor('000018')); // Wagner
    Vendedores.Add('000023', GetEmailVendedor('000023')); // Fernanda
    Vendedores.Add('000026', GetEmailVendedor('000026')); // Jeanete

    for Vendedor in Vendedores.Keys do
      EnviaAumentoPrecoVendedor(Vendedor, Vendedores[Vendedor]);

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
    FEmailMeta.Destinatarios:= 'marcelorauter@gmail.com; alessandra@rauter.com.br; ricardo@rauter.com.br';

    FEmailMeta.Titulo:= 'Vendas realizadas e metas por vendedor at� o dia '+IntToStr(DayOf(now))
                                                                              +' de ' +GetMesString(now)
                                                                              +' de '+IntToStr(YearOf(Now));
    FEmailMeta.Texto:= 'Gr�fico com o comparativo das vendas realizadas e das metas esperadas at� o dia '+IntToStr(DayOf(now))
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
  EmExecucao:= True;
  try
    try
      Execucao();
    except
      on E: Exception do
        WriteLog('Erros Execu��o.log', 'Erro ao executar gatilho '+Nome+': '+E.Message);
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

end.