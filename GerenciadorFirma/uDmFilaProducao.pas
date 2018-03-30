unit uDmFilaProducao;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, uDmSqlUtils, uDmEstoqProdutos;

type
  TDMFilaProducao = class(TDataModule)
    CdsFilaProducao: TClientDataSet;
    CdsFilaProducaoCODPRODUTO: TStringField;
    CdsFilaProducaoQUANTPRODUCAO: TIntegerField;
    CdsFilaProducaoNOMEPRODUTO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    function ProdutoGranel(CodProduto: String): Boolean;
    procedure AdicionaNaFila(const CodProduto, NomeProduto: String; Quant: Double);
    { Private declarations }
  public
    procedure AtualizaFilaProducao;
  end;

var
  DMFilaProducao: TDMFilaProducao;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

function TDMFilaProducao.ProdutoGranel(CodProduto: String): Boolean;
begin
  Result:= (DmSqlUtils.RetornaValor('SELECT CODTAMANHO FROM PRODUTO WHERE CODPRODUTO = '''
            +CodProduto+''' ', 0) = 1);
end;

procedure TDMFilaProducao.AdicionaNaFila(const CodProduto, NomeProduto: String; Quant: Double);
begin
  if not CdsFilaProducao.Locate('CODPRODUTO', CodProduto, []) then
  begin
    CdsFilaProducao.Append;
    CdsFilaProducaoCODPRODUTO.AsString:= CodProduto;
    CdsFilaProducaoNOMEPRODUTO.AsString:= NomeProduto;
    CdsFilaProducaoQUANTPRODUCAO.AsFloat:= Quant;
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

  procedure AdicionaPedidosNaFila(ParFilter: String);
  begin
    with DmEstoqProdutos do
    begin
      FiltraPedidos(ParFilter);
      while not CdsPedidos.Eof do
      begin
        AdicionaNaFila(CdsPedidosCODPRODUTO.AsString, CdsPedidosNOMEPRODUTO.AsString, CdsPedidosQUANTIDADE.AsFloat);
        CdsPedidos.Next;
      end;
    end;
  end;

  procedure AdicionaPedidosGranelNaFila(ParFiltro: String);
  begin
    with DmEstoqProdutos do
    begin
      FiltraPedidos(ParFiltro);
      while not CdsPedidos.Eof do
      begin
        if ProdutoGranel(CdsPedidosCODPRODUTO.AsString) then
          AdicionaNaFila(CdsPedidosCODPRODUTO.AsString, CdsPedidosNOMEPRODUTO.AsString, CdsPedidosQUANTIDADE.AsFloat);

        CdsPedidos.Next;
      end;
    end;
  end;

begin
  DmEstoqProdutos.AtualizaEstoque(False);

  ApagaFilaAtual;
  DmEstoqProdutos.AtualizaPedidos;

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

  with DmEstoqProdutos do
  begin
    CdsPedidos.Filtered:= False;
    CdsEstoqProdutos.Filtered:= False;
    DmSqlUtils.OrdenaClientDataSet(CdsEstoqProdutos, 'RANK', []);
    CdsEstoqProdutos.First;
    while not CdsEstoqProdutos.Eof do
    begin
      AdicionaNaFila(CODPRODUTO.AsString, APRESENTACAO.AsString, 0);
      CdsEstoqProdutos.Next;
    end;

  end;

  CdsFilaProducao.First;
end;

procedure TDMFilaProducao.DataModuleCreate(Sender: TObject);
begin
  CdsFilaProducao.CreateDataSet;
end;

end.
