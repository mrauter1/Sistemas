unit uFormDetalheProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, uFormGlobal, uDmEstoqProdutos,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus;

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
    PopupMenu1: TPopupMenu;
    AbrirConfigPro: TMenuItem;
    AbrirDetalhePro: TMenuItem;
    VerSimilares1: TMenuItem;
    VerInsumos1: TMenuItem;
    procedure cxGridDBTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxColumnProbabilidadeGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure AbrirConfigProClick(Sender: TObject);
    procedure AbrirDetalheProClick(Sender: TObject);
    procedure VerSimilares1Click(Sender: TObject);
    procedure VerInsumos1Click(Sender: TObject);
  private
    function GetCodProSelecionado: String;
    { Private declarations }
  public
    procedure AbreEFocaProduto(pCodPro: String);
  end;

var
  FormDetalheProdutos: TFormDetalheProdutos;

implementation

{$R *.dfm}

uses
  uFormProInfo, uFormInsumos, uFormAdicionarSimilaridade;

procedure TFormDetalheProdutos.AbreEFocaProduto(pCodPro: String);
begin
  DmEstoqProdutos.CdsEstoqProdutos.Locate('CODPRODUTO', pCodPro, []);
  Show;
end;

procedure TFormDetalheProdutos.cxGridDBTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, DmEstoqProdutos.APRESENTACAO.AsString);
end;

procedure TFormDetalheProdutos.AbrirConfigProClick(Sender: TObject);
var
  FCodPro: String;
begin
  FCodPro:= GetCodProSelecionado;

  if FormProInfo.CdsProInfo.Locate('CODPRODUTO', FCodPro, []) then
    FormProInfo.Show;
end;

procedure TFormDetalheProdutos.AbrirDetalheProClick(Sender: TObject);
begin
  FormDetalheProdutos.AbreEFocaProduto(GetCodProSelecionado);
end;

function TFormDetalheProdutos.GetCodProSelecionado: String;
begin
  Result:= VarToStrDef(cxGridDBTableView.DataController.Values[cxGridDBTableView.DataController.FocusedRecordIndex,
                                                                cxGridDBTableViewCODPRODUTO.Index], '');
end;

procedure TFormDetalheProdutos.VerInsumos1Click(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, DmEstoqProdutos.APRESENTACAO.AsString);
end;

procedure TFormDetalheProdutos.VerSimilares1Click(Sender: TObject);
begin
  TFormAdicionarSimilaridade.AbrirSimilares(GetCodProSelecionado, DmEstoqProdutos.APRESENTACAO.AsString);
end;

procedure TFormDetalheProdutos.cxColumnProbabilidadeGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
var
  Val: Double;
begin
  if TryStrToFloat(AText, Val) then
     AText:= FormatFloat('###0.00', Val*100)+' %';
end;

end.
