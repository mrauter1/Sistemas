unit uFormFila;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmFilaProducao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  Vcl.ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, uFormGlobal, uPedidos, cxTextEdit;

type
  TFormFilaProducao = class(TForm)
    DataSourceFila: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    Panel1: TPanel;
    BtnAtualiza: TButton;
    cxGridDBTableViewCODPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewNOMEPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewFALTA: TcxGridDBColumn;
    cxGridDBTableViewNUMPEDIDOS: TcxGridDBColumn;
    cxGridDBTableViewPRODUCAOSUGERIDA: TcxGridDBColumn;
    cxGridDBTableViewQUANTIDADE: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView1: TcxGridDBTableView;
    DataSourcePedidos: TDataSource;
    cxGridDBTableView1CODPEDIDO: TcxGridDBColumn;
    cxGridDBTableView1QUANTIDADE: TcxGridDBColumn;
    cxGridDBTableView1DIASPARAENTREGA: TcxGridDBColumn;
    cxGridDBTableView1SIT: TcxGridDBColumn;
    cxGridDBTableView1NOMECLIENTE: TcxGridDBColumn;
    cxGridDBTableView1NOMETRANSPORTE: TcxGridDBColumn;
    cxGridDBTableView1QUANTPENDENTE: TcxGridDBColumn;
    cxGridDBTableViewPROBFALTAHOJE: TcxGridDBColumn;
    cxGridDBTableViewESTOQUEATUAL: TcxGridDBColumn;
    cxGridDBTableViewESTOQMAX: TcxGridDBColumn;
    cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn;
    procedure BtnAtualizaClick(Sender: TObject);
    procedure cxGridDBTableViewPROBFALTAHOJEGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
  private
    procedure AtualizaGrid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFilaProducao: TFormFilaProducao;

implementation

{$R *.dfm}

procedure TFormFilaProducao.AtualizaGrid;
begin
  cxGridDBTableView.ClearItems;
  cxGridDBTableView.DataController.CreateAllItems;
end;

procedure TFormFilaProducao.BtnAtualizaClick(Sender: TObject);
begin
  DMFilaProducao.AtualizaFilaProducao;
end;

procedure TFormFilaProducao.cxGridDBTableViewPROBFALTAHOJEGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
var
  Val: Double;
begin
  if TryStrToFloat(AText, Val) then
     AText:= FormatFloat('###0.00', Val*100)+' %';
end;

end.
