unit uFormDetalheProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, uFormGlobal, uDmEstoqProdutos,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormDetalheProdutos = class(TForm)
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    DataSource1: TDataSource;
    cxGridDBTableViewRANK: TcxGridDBColumn;
    cxGridDBTableViewCODPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn;
    cxGridDBTableViewPROBFALTAHOJE: TcxGridDBColumn;
    cxGridDBTableViewPROBSAI2DIAS: TcxGridDBColumn;
    cxGridDBTableViewPROBFALTA: TcxGridDBColumn;
    cxGridDBTableViewPERCENTDIAS: TcxGridDBColumn;
    cxGridDBTableViewMEDIASAIDA: TcxGridDBColumn;
    cxGridDBTableViewSTDDEV: TcxGridDBColumn;
    cxGridDBTableViewESTOQUEATUAL: TcxGridDBColumn;
    cxGridDBTableViewESTOQMAX: TcxGridDBColumn;
    cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewPRODUCAOMINIMA: TcxGridDBColumn;
    cxGridDBTableViewDEMANDAC1: TcxGridDBColumn;
    cxGridDBTableViewDEMANDADIARIA: TcxGridDBColumn;
    cxGridDBTableViewDEMANDA: TcxGridDBColumn;
    cxGridDBTableViewDIASESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewROTACAO: TcxGridDBColumn;
    cxGridDBTableViewUNIDADEESTOQUE: TcxGridDBColumn;
    procedure cxGridDBTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDetalheProdutos: TFormDetalheProdutos;

implementation

{$R *.dfm}

uses
  uFormProInfo;

procedure TFormDetalheProdutos.cxGridDBTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
 AItem: TcxCustomGridTableItem;
begin
  AItem := Sender.FindItemByName('CODPRODUTO');
  if Assigned(AItem) then
    with Sender.DataController do
    begin
      FormProInfo.CdsProInfo.Locate('CODPRODUTO', VarToStr(Values[ FocusedRecordIndex, AItem.Index]), []);
      FormProInfo.Show;
    end;
end;

end.
