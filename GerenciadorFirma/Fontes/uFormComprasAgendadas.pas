unit uFormComprasAgendadas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Buttons, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  Vcl.ExtCtrls, uFormCompraProdutos, Vcl.Menus;

type
  TFormComprasAgendadas = class(TForm)
    Panel1: TPanel;
    CbxMostrarRecebidos: TCheckBox;
    Panel2: TPanel;
    cxGridCompras: TcxGrid;
    ViewCompras: TcxGridDBTableView;
    ViewComprasRecebido: TcxGridDBColumn;
    ViewComprasData: TcxGridDBColumn;
    ViewComprasCodGrupoSub: TcxGridDBColumn;
    ViewComprasQuant: TcxGridDBColumn;
    ViewComprasPreco: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    Panel3: TPanel;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    DsComprasPrevistas: TDataSource;
    btnOK: TBitBtn;
    QryComprasPrevistas: TFDQuery;
    QryComprasPrevistasCodGrupoSub: TStringField;
    QryComprasPrevistasQuant: TBCDField;
    QryComprasPrevistasPreco: TBCDField;
    QryComprasPrevistasRecebido: TBooleanField;
    cxGridDBTableView1CodGrupoSub: TcxGridDBColumn;
    cxGridDBTableView1Quant: TcxGridDBColumn;
    cxGridDBTableView1Preco: TcxGridDBColumn;
    cxGridDBTableView1Recebido: TcxGridDBColumn;
    QryComprasPrevistasID: TFDAutoIncField;
    QryComprasPrevistasDataCompra: TDateField;
    QryComprasPrevistasDataRecebimento: TDateField;
    QryComprasPrevistasObs: TMemoField;
    cxGridDBTableView1DataCompra: TcxGridDBColumn;
    cxGridDBTableView1DataRecebimento: TcxGridDBColumn;
    cxGridDBTableView1Obs: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    AlterarCompra1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure CbxMostrarRecebidosClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure AlterarCompra1Click(Sender: TObject);
  private
    MostraRecebidosAtual: Boolean;
    FSqlComprasOriginal: String;
    procedure CarregaCompras;
    function GetCodGrupoSub: String;
    { Private declarations }
  public
    { Public declarations }
    class procedure AbreComprasAgendadas;
  end;

implementation

uses
  GerenciadorUtils;

{$R *.dfm}

class procedure TFormComprasAgendadas.AbreComprasAgendadas;
var
  FFrm: TFormComprasAgendadas;
begin
  FFrm:= TFormComprasAgendadas.Create(Application);
  try
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

function TFormComprasAgendadas.GetCodGrupoSub: String;
var
  FRow: TcxGridDBColumn;
begin
  Result:= '';
  FRow:= cxGridDBTableView1CodGrupoSub;

  if Assigned(cxGridDBTableView1.Controller.FocusedRecord) then
    Result:= VarToStrDef(cxGridDBTableView1.Controller.FocusedRecord.Values[FRow.Index], '');
end;

procedure TFormComprasAgendadas.AlterarCompra1Click(Sender: TObject);
begin
  if QryComprasPrevistas.State = dsEdit then
    QryComprasPrevistas.Post;

  if GetCodGrupoSub <> '' then
    TFormCompraProduto.AbreComprasDoGrupo(GetCodGrupoSub);
end;

procedure TFormComprasAgendadas.btnOKClick(Sender: TObject);
begin
  if QryComprasPrevistas.State = dsEdit then
    QryComprasPrevistas.Post;

  TFormCompraProduto.AbreCompras;
  CarregaCompras;
end;

procedure TFormComprasAgendadas.CarregaCompras;
var
  DataSetGrupo: TDataset;

  function BoolToSql(AValue: Boolean): String;
  begin
    if AValue then
      Result:= '1'
    else
      Result:= '0';
  end;
begin
   MostraRecebidosAtual:= CbxMostrarRecebidos.Checked;

  QryComprasPrevistas.Close;
  QryComprasPrevistas.SQL.Text:= FSqlComprasOriginal;
  if not CbxMostrarRecebidos.Checked then
    QryComprasPrevistas.SQL.Text:= StringReplace(QryComprasPrevistas.SQL.Text, '/*Recebidos*/', ' and Recebido=0', [rfIgnoreCase, rfReplaceAll]);

  QryComprasPrevistas.Open;
end;

procedure TFormComprasAgendadas.CbxMostrarRecebidosClick(Sender: TObject);
begin
  if QryComprasPrevistas.State = dsEdit then
    QryComprasPrevistas.Post;

  if MostraRecebidosAtual = CbxMostrarRecebidos.Checked then
    Exit;

  CarregaCompras;
end;

procedure TFormComprasAgendadas.FormCreate(Sender: TObject);
begin
  FSqlComprasOriginal:= QryComprasPrevistas.SQL.Text;
  MostraRecebidosAtual:= CbxMostrarRecebidos.Checked;

  FazLookupCxGrid(cxGridDBTableView1CodGrupoSub, 'SELECT CODGRUPOSUB, NOMESUBGRUPO FROM GRUPOSUB');

  CarregaCompras;
end;

end.
