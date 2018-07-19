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
    cxGridDBTableViewSITUACAO: TcxGridDBColumn;
    cxGridDBTableViewCODCLIENTE: TcxGridDBColumn;
    cxGridDBTableViewNOMECLIENTE: TcxGridDBColumn;
    cxGridDBTableViewNOMETRANSPORTE: TcxGridDBColumn;
    cxGridDBTableViewCODPEDIDO: TcxGridDBColumn;
    cxGridDBTableViewQUANTPENDENTE: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleVermelho: TcxStyle;
    Panel1: TPanel;
    BtnAtualiza: TButton;
    BtnOpcoes: TBitBtn;
    cxGridDBTableViewESTOQUEATUAL: TcxGridDBColumn;
    cxGridDBTableViewEMFALTA: TcxGridDBColumn;
    cxStyleAmarelo: TcxStyle;
    PopupMenu1: TPopupMenu;
    AbrirConfigPro: TMenuItem;
    AbrirDetalhePro: TMenuItem;
    VerSimilares1: TMenuItem;
    VerInsumos1: TMenuItem;
    cxGridDBTableViewFALTAHOJE: TcxGridDBColumn;
    cxGridDBTableViewFALTAAMANHA: TcxGridDBColumn;
    Timer1: TTimer;
    procedure BtnOpcoesClick(Sender: TObject);
    procedure cxGridDBTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure BtnAtualizaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AbrirConfigProClick(Sender: TObject);
    procedure AbrirDetalheProClick(Sender: TObject);
    procedure VerSimilares1Click(Sender: TObject);
    procedure VerInsumos1Click(Sender: TObject);
    procedure cxGridDBTableViewSITUACAOGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure Timer1Timer(Sender: TObject);
    procedure cxGridDBTableViewDIASPARAENTREGAGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
  private
    { Private declarations }
    FExpanded: Boolean;
    function GetCodProSelecionado: String;
  public
    { Public declarations }
  end;

var
  FormPedidos: TFormPedidos;

implementation

{$R *.dfm}

uses uFormProInfo, uFormDetalheProdutos, uFormSelecionaModelos, uFormAdicionarSimilaridade, uFormInsumos;

function TFormPedidos.GetCodProSelecionado: String;
begin
  Result:= VarToStrDef(cxGridDBTableView.DataController.Values[cxGridDBTableView.DataController.FocusedRecordIndex,
                                                                cxGridDBTableViewCODPRODUTO.Index], '');
end;

procedure TFormPedidos.Timer1Timer(Sender: TObject);
begin
  BtnAtualiza.Click;
end;

procedure TFormPedidos.VerInsumos1Click(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, Pedidos.QryPedidosNOMEPRODUTO.AsString);
end;

procedure TFormPedidos.VerSimilares1Click(Sender: TObject);
begin
  TFormAdicionarSimilaridade.AbrirSimilares(GetCodProSelecionado, Pedidos.QryPedidosNOMEPRODUTO.AsString);
end;

procedure TFormPedidos.AbrirConfigProClick(Sender: TObject);
var
  FCodPro: String;
begin
  FCodPro:= GetCodProSelecionado;

  FormProInfo.Abrir(FCodPro);
end;

procedure TFormPedidos.AbrirDetalheProClick(Sender: TObject);
begin
  FormDetalheProdutos.AbreEFocaProduto(VarToStrDef(cxGridDBTableView.DataController.Values[cxGridDBTableView.DataController.FocusedRecordIndex,
                                                                cxGridDBTableViewCODPRODUTO.Index], ''));
end;

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

procedure TFormPedidos.cxGridDBTableViewDIASPARAENTREGAGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  if AText = '0' then
    AText:= '  Hoje'
  else if AText = '1' then
    AText:= ' Amanhã'
  else
    AText:= AText+' dia(s)';

end;

procedure TFormPedidos.cxGridDBTableViewSITUACAOGetDisplayText(
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

procedure TFormPedidos.cxGridDBTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if Sender.DataController.Values[ARecord.RecordIndex, cxGridDBTableViewQUANTPENDENTE.Index] > 0 then
    AStyle := cxStyleVermelho
  else if Sender.DataController.Values[ARecord.RecordIndex, cxGridDBTableViewEMFALTA.Index] = True then
    AStyle := cxStyleAmarelo;

end;

procedure TFormPedidos.FormCreate(Sender: TObject);
begin
  FExpanded:= True;
  cxGridDBTableView.DataController.Groups.FullExpand;
end;

end.
