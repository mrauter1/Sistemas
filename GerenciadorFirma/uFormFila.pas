unit uFormFila;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmFilaProducao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  Vcl.ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, uFormGlobal, uPedidos, cxTextEdit,
  Vcl.Buttons, Vcl.Menus, uDmEstoqProdutos;

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
    cxGridDBTableViewFALTACONFIRMADA: TcxGridDBColumn;
    cxGridDBTableViewNUMPEDIDOS: TcxGridDBColumn;
    cxGridDBTableViewPRODUCAOSUGERIDA: TcxGridDBColumn;
    cxGridDBTableViewFALTAHOJE: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView1: TcxGridDBTableView;
    DataSourcePedidos: TDataSource;
    cxGridDBTableView1CODPEDIDO: TcxGridDBColumn;
    cxGridDBTableView1QUANTIDADE: TcxGridDBColumn;
    cxGridDBTableView1DIASPARAENTREGA: TcxGridDBColumn;
    cxGridDBTableView1NOMECLIENTE: TcxGridDBColumn;
    cxGridDBTableView1NOMETRANSPORTE: TcxGridDBColumn;
    cxGridDBTableView1QUANTPENDENTE: TcxGridDBColumn;
    cxGridDBTableViewPROBFALTAHOJE: TcxGridDBColumn;
    cxGridDBTableViewESTOQUEATUAL: TcxGridDBColumn;
    cxGridDBTableViewEstoqMaxCalculado: TcxGridDBColumn;
    cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn;
    PopupMenuOpcoes: TPopupMenu;
    AbrirConfigPro: TMenuItem;
    AbrirDetalhePro: TMenuItem;
    BtnOpcoes: TBitBtn;
    VerSimilares1: TMenuItem;
    VerInsumos1: TMenuItem;
    cxGridDBTableViewDEMANDADIARIA: TcxGridDBColumn;
    cxGridDBTableViewDIASESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewFaltaTotal: TcxGridDBColumn;
    cxGridDBTableView1DATAENTREGA: TcxGridDBColumn;
    cxGridDBTableView1SITUACAO: TcxGridDBColumn;
    cxGridDBTableViewNOMEAPLICACAO: TcxGridDBColumn;
    cxGridDBTableViewRank: TcxGridDBColumn;
    procedure BtnAtualizaClick(Sender: TObject);
    procedure BtnOpcoesClick(Sender: TObject);
    procedure AbrirConfigProClick(Sender: TObject);
    procedure AbrirDetalheProClick(Sender: TObject);
    procedure VerSimilares1Click(Sender: TObject);
    procedure VerInsumos1Click(Sender: TObject);
    procedure cxGridDBTableViewDblClick(Sender: TObject);
    procedure cxGridDBTableViewPROBFALTAHOJEGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridDBTableView1SITUACAOGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private
    procedure AtualizaGrid;
    function GetCodProSelecionado: String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFilaProducao: TFormFilaProducao;

implementation

uses
  uFormProInfo, uFormDetalheProdutos, uFormAdicionarSimilaridade, uFormInsumos;

{$R *.dfm}

procedure TFormFilaProducao.AbrirDetalheProClick(Sender: TObject);
begin
  FormDetalheProdutos.AbreEFocaProduto(VarToStrDef(cxGridDBTableView.DataController.Values[cxGridDBTableView.DataController.FocusedRecordIndex,
                                                                cxGridDBTableViewCODPRODUTO.Index], ''));
end;

procedure TFormFilaProducao.AtualizaGrid;
begin
  cxGridDBTableView.ClearItems;
  cxGridDBTableView.DataController.CreateAllItems;
end;

procedure TFormFilaProducao.BtnAtualizaClick(Sender: TObject);
begin
  DMFilaProducao.AtualizaFilaProducao;
end;

procedure TFormFilaProducao.BtnOpcoesClick(Sender: TObject);
begin
  if BtnOpcoes.Caption = '+' then
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

procedure TFormFilaProducao.cxGridDBTableView1SITUACAOGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if AText = '0' then
    AText:= 'Pendente'
  else if AText = '1' then
    AText:= 'Reserva'
  else if AText = '2' then
    AText:= 'Separação';
end;

procedure TFormFilaProducao.cxGridDBTableViewDblClick(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, DmEstoqProdutos.QryEstoqAPRESENTACAO.AsString);
end;

procedure TFormFilaProducao.cxGridDBTableViewPROBFALTAHOJEGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  Val: Double;
begin
  if TryStrToFloat(AText, Val) then
     AText:= FormatFloat('###0.00', Val*100)+' %';
end;

procedure TFormFilaProducao.VerInsumos1Click(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, DmEstoqProdutos.QryEstoqAPRESENTACAO.AsString);
end;

procedure TFormFilaProducao.VerSimilares1Click(Sender: TObject);
begin
  TFormAdicionarSimilaridade.AbrirSimilares(GetCodProSelecionado, DmEstoqProdutos.QryEstoqAPRESENTACAO.AsString);
end;

function TFormFilaProducao.GetCodProSelecionado: String;
begin
  Result:= VarToStrDef(cxGridDBTableView.DataController.Values[cxGridDBTableView.DataController.FocusedRecordIndex,
                                                                cxGridDBTableViewCODPRODUTO.Index], '');
end;

procedure TFormFilaProducao.AbrirConfigProClick(Sender: TObject);
begin
  FormProInfo.Abrir(GetCodProSelecionado);
end;

end.
