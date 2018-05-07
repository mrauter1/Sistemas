unit uFormPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  GerenciadorUtils, uDmEstoqProdutos, uPedidos, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uFormGlobal;

type
  TFormPedidos = class(TForm)
    DataSource1: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGridDBTableViewCODPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewNOMEPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewQUANTIDADE: TcxGridDBColumn;
    cxGridDBTableViewDIASPARAENTREGA: TcxGridDBColumn;
    cxGridDBTableViewSIT: TcxGridDBColumn;
    cxGridDBTableViewCODCLIENTE: TcxGridDBColumn;
    cxGridDBTableViewNOMECLIENTE: TcxGridDBColumn;
    cxGridDBTableViewNOMETRANSPORTE: TcxGridDBColumn;
    cxGridDBTableViewCODPEDIDO: TcxGridDBColumn;
    cxGridDBTableViewQUANTPENDENTE: TcxGridDBColumn;
    PopupMenuOpcoes: TPopupMenu;
    Expandir1: TMenuItem;
    Contrair1: TMenuItem;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleVermelho: TcxStyle;
    Panel1: TPanel;
    BtnAtualiza: TButton;
    BtnOpcoes: TBitBtn;
    procedure BtnOpcoesClick(Sender: TObject);
    procedure cxGridDBTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure BtnAtualizaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FExpanded: Boolean;
  public
    { Public declarations }
  end;

var
  FormPedidos: TFormPedidos;

implementation

{$R *.dfm}

procedure TFormPedidos.BtnAtualizaClick(Sender: TObject);
begin
  Pedidos.Refresh;
  cxGridDBTableView.DataController.Groups.FullExpand;
end;

procedure TFormPedidos.BtnOpcoesClick(Sender: TObject);
begin
  FExpanded:= not FExpanded;

  if FExpanded then
  begin
    cxGridDBTableView.DataController.Groups.FullExpand;
    BtnOpcoes.Caption:= '-';
  end
 else
  begin
    cxGridDBTableView.DataController.Groups.FullCollapse;
    BtnOpcoes.Caption:= '+';
  end;

end;

procedure TFormPedidos.cxGridDBTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  FColumn: TcxGridDBColumn;
begin
  FColumn:= cxGridDBTableViewQUANTPENDENTE;

  if Sender.DataController.Values[ARecord.RecordIndex, FColumn.Index] > 0 then
    AStyle := cxStyleVermelho;
end;

procedure TFormPedidos.FormCreate(Sender: TObject);
begin
  FExpanded:= True;
  cxGridDBTableView.DataController.Groups.FullExpand;
end;

end.
