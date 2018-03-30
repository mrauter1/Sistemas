unit uPedidoItemModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadModelo, DB, Provider, DBClient, uConexaoDBX, uProdutoModelo;

type
  TPedidoItemModelo = class(TCadModelo)
    CODPEDIDOITEM: TIntegerField;
    CODPEDIDO: TIntegerField;
    NOMEPRODUTO: TStringField;
    QUANTIDADE: TFloatField;
    CODPRODUTO: TIntegerField;
    TOTAL: TFMTBCDField;
    VALOR: TFMTBCDField;
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSAfterInsert(DataSet: TDataSet);
    procedure CDSCalcFields(DataSet: TDataSet);
    procedure QUANTIDADEChange(Sender: TField);
    procedure VALORChange(Sender: TField);
    procedure CDSBeforeOpen(DataSet: TDataSet);
  private
    procedure CalculaTotal;
    procedure CarregaProduto(Modelo: TCadModelo);
  public
    Produto: TProdutoModelo;
    procedure InicializaProdutos;
  end;

implementation

{$R *.dfm}

uses
  uPedidoModelo;

procedure TPedidoItemModelo.CarregaProduto(Modelo: TCadModelo);
begin
  if CDS.state in ([dsEdit, dsInsert]) then
    VALOR.AsFloat:= Produto.VALOR.AsFloat;
end;

procedure TPedidoItemModelo.CDSAfterInsert(DataSet: TDataSet);
begin
  inherited;
  CODPEDIDO.AsVariant:= (Mestre as TPedidoMD).COD.AsVariant;
  CODPEDIDOITEM.AsInteger:= CDS.RecordCount+1;
end;

procedure TPedidoItemModelo.CDSBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if not Assigned(Produto) then
    InicializaProdutos;    
end;

procedure TPedidoItemModelo.CDSCalcFields(DataSet: TDataSet);
begin
  inherited;
  NomeProduto.AsString:= Produto.NOME.AsString;
end;

procedure TPedidoItemModelo.VALORChange(Sender: TField);
begin
  CalculaTotal;
end;

procedure TPedidoItemModelo.DataModuleCreate(Sender: TObject);
begin
  inherited;
  NomeTabela:= 'PEDIDOITEM';
  Indice:= 'CODPRODUTO';
end;

procedure TPedidoItemModelo.InicializaProdutos;
var
  fLink: TMasterDetailLink;
begin
  Produto:= TProdutoModelo.Create(Self);
  fLink:= RelacionaModelos(CODPRODUTO, PRODUTO.COD, Produto, true);
  fLink.OnCarregaDetalhe:= CarregaProduto;
end;

procedure TPedidoItemModelo.QUANTIDADEChange(Sender: TField);
begin
  CalculaTotal;
end;

procedure TPedidoitemModelo.CalculaTotal;
begin
  if CDS.State in ([dsEdit, dsInsert]) then
    Total.AsFloat:= Quantidade.AsFloat * Valor.AsFloat;
end;

end.
