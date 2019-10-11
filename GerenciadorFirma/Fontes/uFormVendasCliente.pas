unit uFormVendasCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid;

type
  TFormVendasCliente = class(TForm)
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QryVendas: TFDQuery;
    DsVendas: TDataSource;
    QryVendasCODCLIENTE: TStringField;
    QryVendasNOMECLIENTE: TStringField;
    QryVendasDATACOMPROVANTE: TDateField;
    QryVendasTOTNOTA: TBCDField;
    QryVendasTOTITENS: TIntegerField;
    QryVendasNOMECONDICAO: TStringField;
    QryVendasNOMETRANSPORTE: TStringField;
    cxGridDBTableViewCODCLIENTE: TcxGridDBColumn;
    cxGridDBTableViewNOMECLIENTE: TcxGridDBColumn;
    cxGridDBTableViewDATACOMPROVANTE: TcxGridDBColumn;
    cxGridDBTableViewTOTNOTA: TcxGridDBColumn;
    cxGridDBTableViewTOTITENS: TcxGridDBColumn;
    cxGridDBTableViewNOMECONDICAO: TcxGridDBColumn;
    cxGridDBTableViewNOMETRANSPORTE: TcxGridDBColumn;
    QryProdutos: TFDQuery;
    DsProdutos: TDataSource;
    QryProdutosCHAVENF: TStringField;
    QryProdutosCODPRODUTO: TStringField;
    QryProdutosAPRESENTACAO: TStringField;
    QryProdutosQuantidade: TFMTBCDField;
    QryProdutosVALTOTAL: TBCDField;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView2: TcxGridDBTableView;
    QryVendasChaveNf: TStringField;
    cxGridDBTableViewChaveNf: TcxGridDBColumn;
    QryVendasNumero: TStringField;
    QryVendasCodPedido: TStringField;
    cxGridDBTableViewNumero: TcxGridDBColumn;
    cxGridDBTableViewCodPedido: TcxGridDBColumn;
    cxGridDBTableView2CHAVENF: TcxGridDBColumn;
    cxGridDBTableView2CODPRODUTO: TcxGridDBColumn;
    cxGridDBTableView2APRESENTACAO: TcxGridDBColumn;
    cxGridDBTableView2Quantidade: TcxGridDBColumn;
    cxGridDBTableView2VALTOTAL: TcxGridDBColumn;
    QryProdutosValUnitario: TFMTBCDField;
    cxGridDBTableView2ValUnitario: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormVendasCliente: TFormVendasCliente;

implementation

{$R *.dfm}

end.
