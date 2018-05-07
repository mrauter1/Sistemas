unit uFormPedidos2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmEstoqProdutos, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid;

type
  TFormPedidos2 = class(TForm)
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    DataSource1: TDataSource;
    cxGridDBTableViewCODPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewNOMEPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewQUANTIDADE: TcxGridDBColumn;
    cxGridDBTableViewDIASPARAENTREGA: TcxGridDBColumn;
    cxGridDBTableViewSIT: TcxGridDBColumn;
    cxGridDBTableViewNUMPEDIDOS: TcxGridDBColumn;
    cxGridDBTableViewFALTA: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPedidos2: TFormPedidos2;

implementation

{$R *.dfm}

procedure TFormPedidos2.FormShow(Sender: TObject);
begin
  DmEstoqProdutos.AtualizaPedidos;
end;

end.
