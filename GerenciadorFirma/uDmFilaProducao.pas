unit uDmFilaProducao;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, uDmSqlUtils, uDmEstoqProdutos, uFrmShowMemo,
  uPedidos;

type
  TDMFilaProducao = class(TDataModule)
    CdsFilaProducao: TClientDataSet;
    CdsFilaProducaoCODPRODUTO: TStringField;
    CdsFilaProducaoNOMEPRODUTO: TStringField;
    CdsFilaProducaoNUMPEDIDOS: TIntegerField;
    CdsFilaProducaoPRODUCAOSUGERIDA: TFloatField;
    CdsFilaProducaoFALTA: TFloatField;
    CdsFilaProducaoQUANTIDADE: TFloatField;
    CdsFilaProducaoESTOQUEATUAL: TFloatField;
    CdsFilaProducaoESTOQMAX: TFloatField;
    CdsFilaProducaoPROBFALTAHOJE: TFloatField;
    CdsFilaProducaoESPACOESTOQUE: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
//    procedure CdsFilaProducaoPROBFALTAHOJEGetText(Sender: TField;
//      var Text: string; DisplayText: Boolean);
  private  
    function ProdutoGranel(CodProduto: String): Boolean;
    procedure AdicionaNaFila(const CodProduto, NomeProduto: String; Falta: Double; Quant: Double; ProducaoSugerida: Double;
                             NumPedidos: Integer);
    { Private declarations }
  public   
    procedure AtualizaFilaProducao;
  end;

var
  DMFilaProducao: TDMFilaProducao;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  Utils, uFormFila;

function TDMFilaProducao.ProdutoGranel(CodProduto: String): Boolean;
begin
  Result:= (DmSqlUtils.RetornaValor('SELECT CODTAMANHO FROM PRODUTO WHERE CODPRODUTO = '''
            +CodProduto+''' ', 0) = 1);
end;

procedure TDMFilaProducao.AdicionaNaFila(const CodProduto, NomeProduto: String; Falta: Double; Quant: Double; ProducaoSugerida: Double; NumPedidos: Integer);
begin
  if not CdsFilaProducao.Locate('CODPRODUTO', CodProduto, []) then
  begin
    CdsFilaProducao.Append;
    CdsFilaProducaoCODPRODUTO.AsString:= CodProduto;
    CdsFilaProducaoNOMEPRODUTO.AsString:= NomeProduto;
    CdsFilaProducaoFALTA.AsFloat:= Falta;
    CdsFilaProducaoQUANTIDADE.AsFloat:= Quant;
    CdsFilaProducaoNUMPEDIDOS.AsInteger:= NumPedidos;
    CdsFilaProducaoPRODUCAOSUGERIDA.AsFloat:= ProducaoSugerida;

    with DmEstoqProdutos do
    begin
      if CdsEstoqProdutos.Locate('CODPRODUTO', CodProduto.AsString, []) then
      begin
        CdsFilaProducaoPROBFALTAHOJE.AsFloat:= PROBFALTAHOJE.AsFloat * 100;
        CdsFilaProducaoESTOQUEATUAL.AsFloat:= ESTOQUEATUAL.AsFloat;
        CdsFilaProducaoESTOQMAX.AsFloat:= ESTOQMAX.AsFloat;
        CdsFilaProducaoPROBFALTAHOJE.AsFloat:= PROBFALTAHOJE.AsFloat;
      end;
    end;

    CdsFilaProducao.Post;
  end;
end;
                                             
procedure TDMFilaProducao.AtualizaFilaProducao;

  procedure ApagaFilaAtual;
  begin
    while not CdsFilaProducao.IsEmpty do
      CdsFilaProducao.Delete;

  end;

  procedure FiltraPedidos(ParFilter: String);
  begin
    with DmEstoqProdutos do
    begin
      CdsPedidos.Filter:= ParFilter;
      CdsPedidos.Filtered:= True;
      DmSqlUtils.OrdenaClientDataSet(CdsPedidos, 'NUMPEDIDOS', [ixDescending]);
      CdsPedidos.First;
    end;
  end;

  procedure AdicionaPedidoNaFila;
  begin
    with DmEstoqProdutos do
      AdicionaNaFila(CdsPedidosCODPRODUTO.AsString, CdsPedidosNOMEPRODUTO.AsString, CdsPedidosFALTA.AsFloat, CdsPedidosQUANTIDADE.AsFloat, 0, CdsPedidosNUMPEDIDOS.AsInteger);
  end;

  procedure AdicionaPedidosNaFila(ParFilter: String);
  begin
    FiltraPedidos(ParFilter);
    while not DmEstoqProdutos.CdsPedidos.Eof do
    begin
      AdicionaPedidoNaFila;
      DmEstoqProdutos.CdsPedidos.Next;
    end;
  end;

  procedure AdicionaPedidosGranelNaFila(ParFiltro: String);
  begin
    FiltraPedidos(ParFiltro);
    while not DmEstoqProdutos.CdsPedidos.Eof do
    begin
      if ProdutoGranel(DmEstoqProdutos.CdsPedidosCODPRODUTO.AsString) then
        AdicionaPedidoNaFila;

      DmEstoqProdutos.CdsPedidos.Next;
    end;
  end;

  procedure AdicionaProdutoEBuscaInfo(pCodProduto: String; pApresentacao: String);
  var
    FFalta, FQuant: Double;
    FNum: Integer;
  begin
    FiltraPedidos('CODPRODUTO = '+pCodProduto);
    FFalta:= 0;
    FNum:= 0;
    FQuant:= 0;

    while not DmEstoqProdutos.CdsPedidos.Eof do
    begin
      FFalta:= FFalta+DmEstoqProdutos.CdsPedidosFALTA.AsFloat;
      FNum:= FNum+DmEstoqProdutos.CdsPedidosNUMPEDIDOS.AsInteger;
      FQuant:= FQuant+DmEstoqProdutos.CdsPedidosQUANTIDADE.AsFloat;
      DmEstoqProdutos.CdsPedidos.Next;
    end;

    AdicionaNaFila(pCodProduto, pApresentacao, FFalta, FQuant, 0, FNum);
  end;

begin
  CdsFilaProducao.DisableControls;

  if Assigned(FormFilaProducao) then
    FormShowMemo.Parent:= FormFilaProducao;

  FormShowMemo.Show;
  try
    FormShowMemo.SetText('Iniciando atualização das informações dos produtos...');

    Pedidos.LoadPedidos(Now - 30, Now + 1);
    
    DmEstoqProdutos.AtualizaEstoque(False);

    FormShowMemo.SetText('Apagando Fila de produção atual...');
    ApagaFilaAtual;
    FormShowMemo.SetText('Atualizando pedidos...');

    FormShowMemo.SetText('Adicionando itens em falta na fila de produção...');

    //Primeiro pega todos os pedidos em granel confirmados para hoje
    AdicionaPedidosGranelNaFila('DIASPARAENTREGA = 0 AND SIT = ''C'' ');

    // Segundo: Pega os produtos em falta confirmados para hoje
    AdicionaPedidosNaFila('FALTA > 0 AND DIASPARAENTREGA = 0 AND SIT = ''C'' ');

    //TERCEIRO: PEGA OS PEDIDOS GRANEL PENDENTES PARA HOJE
    AdicionaPedidosGranelNaFila('DIASPARAENTREGA = 0 AND SIT = ''P'' ');

    // QUARTO: Pega os produto em falta pendentes para hoje
    AdicionaPedidosNaFila('FALTA > 0 AND DIASPARAENTREGA = 0 AND SIT = ''P'' ');

    //QUINTO: pega pedidos em granel confirmados para amanha
    AdicionaPedidosGranelNaFila('DIASPARAENTREGA = 1 AND SIT = ''C'' ');

    //SEXTO: Pega pedidos confirmados em falta para amanha
    AdicionaPedidosNaFila('FALTA > 0 AND DIASPARAENTREGA = 1 AND SIT = ''C'' ');

    //SÉTIMO: Pega os pedidos em granel pendentes em para amanha:
    AdicionaPedidosGranelNaFila('DIASPARAENTREGA = 1 AND SIT = ''P'' ');

    //OITAVO: Verificar se tem algum produto com falta pendente amanhã
    AdicionaPedidosNaFila('FALTA > 0 AND DIASPARAENTREGA = 1 AND SIT = ''P'' ');

    FormShowMemo.SetText('Adicionando itens que não estão em falta na fila de produção...');
    with DmEstoqProdutos do
    begin
      CdsPedidos.Filtered:= False;
      CdsEstoqProdutos.Filtered:= False;
      DmSqlUtils.OrdenaClientDataSet(CdsEstoqProdutos, 'RANK', []);
      CdsEstoqProdutos.First;
      while not CdsEstoqProdutos.Eof do
      begin
        AdicionaProdutoEBuscaInfo(CODPRODUTO.AsString, APRESENTACAO.AsString);

        CdsEstoqProdutos.Next;
      end;

    end;

    CdsFilaProducao.First;

    FormShowMemo.SetText('Finalizada atualização dos itens!');

    FiltraPedidos('');
  finally
    FormShowMemo.Hide;
    CdsFilaProducao.EnableControls;
  end;  
end;

{procedure TDMFilaProducao.CdsFilaProducaoPROBFALTAHOJEGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
var
  Val: Double;
begin
  if TryStrToFloat(Text,Val) then
    Text:= FormatFloat('#,## %',(Val * 100));
end;                                              }

procedure TDMFilaProducao.DataModuleCreate(Sender: TObject);
begin  
  CreateDataSetIfNotActive(CdsFilaProducao);
end;

end.
