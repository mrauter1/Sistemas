unit uFormDetalheProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, uFormGlobal, uDmEstoqProdutos,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uConSqlServer;

type
  TFormDetalheProdutos = class(TForm)
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    AbrirConfigPro: TMenuItem;
    AbrirDetalhePro: TMenuItem;
    VerSimilares1: TMenuItem;
    VerInsumos1: TMenuItem;
    QryDetalhesPro: TFDQuery;
    QryDetalhesProCODPRODUTO: TStringField;
    QryDetalhesProAPRESENTACAO: TStringField;
    QryDetalhesProCodAplicacao: TStringField;
    QryDetalhesProNOMEAPLICACAO: TStringField;
    QryDetalhesProESTOQUEATUAL: TBCDField;
    QryDetalhesProESPACOESTOQUE: TIntegerField;
    QryDetalhesProDEMANDAC1: TFMTBCDField;
    QryDetalhesProROTACAO: TIntegerField;
    QryDetalhesProMediaSaida: TFMTBCDField;
    QryDetalhesProStdDev: TFloatField;
    QryDetalhesProFaltaConfirmada: TFMTBCDField;
    QryDetalhesProFaltaHoje: TFMTBCDField;
    QryDetalhesProFaltaTotal: TFMTBCDField;
    QryDetalhesProProbFaltaHoje: TFloatField;
    QryDetalhesProDIASESTOQUE: TBCDField;
    QryDetalhesProDemandaDiaria: TBCDField;
    QryDetalhesProDemanda: TFMTBCDField;
    QryDetalhesProNUMPEDIDOS: TIntegerField;
    QryDetalhesProPercentDias: TFloatField;
    QryDetalhesProProbFalta: TBCDField;
    QryDetalhesProEstoqMaxCalculado: TFMTBCDField;
    QryDetalhesProNAOFAZESTOQUE: TBooleanField;
    QryDetalhesProPRODUCAOMINIMA: TIntegerField;
    QryDetalhesProSOMANOPESOLIQ: TBooleanField;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridDBTableViewCODPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn;
    cxGridDBTableViewNOMEAPLICACAO: TcxGridDBColumn;
    cxGridDBTableViewESTOQUEATUAL: TcxGridDBColumn;
    cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewDEMANDAC1: TcxGridDBColumn;
    cxGridDBTableViewROTACAO: TcxGridDBColumn;
    cxGridDBTableViewMediaSaida: TcxGridDBColumn;
    cxGridDBTableViewStdDev: TcxGridDBColumn;
    cxGridDBTableViewProbFalta: TcxGridDBColumn;
    cxGridDBTableViewPercentDias: TcxGridDBColumn;
    cxGridDBTableViewProbFaltaHoje: TcxGridDBColumn;
    cxGridDBTableViewDIASESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewDemandaDiaria: TcxGridDBColumn;
    cxGridDBTableViewDemanda: TcxGridDBColumn;
    cxGridDBTableViewEstoqMaxCalculado: TcxGridDBColumn;
    cxGridDBTableViewNAOFAZESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewPRODUCAOMINIMA: TcxGridDBColumn;
    cxGridDBTableViewSOMANOPESOLIQ: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    procedure cxGridDBTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxColumnProbabilidadeGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure AbrirConfigProClick(Sender: TObject);
    procedure AbrirDetalheProClick(Sender: TObject);
    procedure VerSimilares1Click(Sender: TObject);
    procedure VerInsumos1Click(Sender: TObject);
    procedure cxGridDBTableViewPercentDiasGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private
    function GetCodProSelecionado: String;
    { Private declarations }
  public
    procedure RefreshProduto(pCodProFoco: String = '');
    procedure AbreEFocaProduto(pCodProFoco: String);
  end;

var
  FormDetalheProdutos: TFormDetalheProdutos;

implementation

{$R *.dfm}

uses
  uFormProInfo, uFormInsumos, uFormAdicionarSimilaridade;

procedure TFormDetalheProdutos.RefreshProduto(pCodProFoco: String = '');
begin
  QryDetalhesPro.Close;
  QryDetalhesPro.Open;

  QryDetalhesPro.Locate('CODPRODUTO', pCodProFoco, []);
end;

procedure TFormDetalheProdutos.AbreEFocaProduto(pCodProFoco: String);
begin
  RefreshProduto(pCodProFoco);
  Show;
end;

procedure TFormDetalheProdutos.cxGridDBTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, DmEstoqProdutos.QryEstoqAPRESENTACAO.AsString);
end;

procedure TFormDetalheProdutos.cxGridDBTableViewPercentDiasGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  Val: Double;
begin
  if TryStrToFloat(AText, Val) then
     AText:= FormatFloat('###0.00', Val*100)+' %';
end;

procedure TFormDetalheProdutos.AbrirConfigProClick(Sender: TObject);
begin
  FormProInfo.Abrir(GetCodProSelecionado);
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
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, DmEstoqProdutos.QryEstoqAPRESENTACAO.AsString);
end;

procedure TFormDetalheProdutos.VerSimilares1Click(Sender: TObject);
begin
  TFormAdicionarSimilaridade.AbrirSimilares(GetCodProSelecionado, DmEstoqProdutos.QryEstoqAPRESENTACAO.AsString);
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
