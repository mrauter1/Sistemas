unit uFormLogistica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, Vcl.Menus, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uFormEntregaPorProduto;

type
  TFormLogistica = class(TForm)
    Panel1: TPanel;
    BtnAtualiza: TButton;
    BtnOpcoes: TBitBtn;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    PopupMenuOpcoes: TPopupMenu;
    MenuGerenciarPedidos: TMenuItem;
    DsGrupos: TDataSource;
    QryGrupos: TFDQuery;
    QryGruposNOMESUBGRUPO: TStringField;
    QryGruposTotLitros: TFMTBCDField;
    QryGruposTotQuilos: TFMTBCDField;
    QryGruposQuantPedidos: TIntegerField;
    QryGruposLitrosEstoque: TFMTBCDField;
    QryGruposCodGrupoSub: TStringField;
    cxGridDBTableViewCodGrupoSub: TcxGridDBColumn;
    cxGridDBTableViewNOMESUBGRUPO: TcxGridDBColumn;
    cxGridDBTableViewTotLitros: TcxGridDBColumn;
    cxGridDBTableViewQuantPedidos: TcxGridDBColumn;
    cxGridDBTableViewLitrosEstoque: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleLinhaPar: TcxStyle;
    cxStyleLinhaImpar: TcxStyle;
    cxStyleGroup: TcxStyle;
    cxGridTableViewStyleSheet1: TcxGridTableViewStyleSheet;
    cxStyleVermelho: TcxStyle;
    cxStyleDefault: TcxStyle;
    QryProdutos: TFDQuery;
    DsProdutos: TDataSource;
    QryProdutosCodGrupoSub: TStringField;
    QryProdutosNOMEPRODUTO: TStringField;
    QryProdutosNumPedidos: TIntegerField;
    QryProdutosSomaPedidos: TFMTBCDField;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView1CodGrupoSub: TcxGridDBColumn;
    cxGridDBTableView1NOMEPRODUTO: TcxGridDBColumn;
    cxGridDBTableView1NumPedidos: TcxGridDBColumn;
    cxGridDBTableView1SomaPedidos: TcxGridDBColumn;
    QryProdutosCODPRODUTO: TStringField;
    QryProdutosLitrosPedidos: TFMTBCDField;
    QryProdutosEstoqueProduto: TFMTBCDField;
    cxGridDBTableView1LitrosPedidos: TcxGridDBColumn;
    cxGridDBTableView1EstoqueProduto: TcxGridDBColumn;
    procedure cxGridDBTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridDBTableView1StylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure MenuGerenciarPedidosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
  FormLogistica: TFormLogistica; }

implementation

{$R *.dfm}

procedure TFormLogistica.cxGridDBTableView1StylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
//  FEstoque: Double;
  FController: TcxCustomDataController;
  FMasterController: TcxCustomDataController;
begin
  FController:= Sender.DataController;
{  FMasterController:= FController.GetMasterDataController;
  FEstoque:= FMasterController.Values[FController.GetMasterRecordIndex, cxGridDBTableViewLitrosEstoque.Index];}

  if FController.Values[ARecord.RecordIndex, cxGridDBTableView1LitrosPedidos.Index] >
     FController.Values[ARecord.RecordIndex, cxGridDBTableView1EstoqueProduto.Index]  then
    AStyle := cxStyleVermelho;
end;

procedure TFormLogistica.cxGridDBTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if Sender.DataController.Values[ARecord.RecordIndex, cxGridDBTableViewTotLitros.Index] >
     Sender.DataController.Values[ARecord.RecordIndex, cxGridDBTableViewLitrosEstoque.Index] then
    AStyle := cxStyleVermelho;

end;

procedure TFormLogistica.FormCreate(Sender: TObject);
begin
  if not QryGrupos.Active then
    QryGrupos.Active;

  if not QryProdutos.Active then
    QryProdutos.Active;

end;

procedure TFormLogistica.MenuGerenciarPedidosClick(Sender: TObject);
begin
  TFormEntregaPorProduto.AbreGrupo(QryGruposCodGrupoSub.AsString);
end;

end.
