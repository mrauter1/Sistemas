unit uFormInsumos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, Datasnap.DBClient, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormInsumos = class(TForm)
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    DsInsumos: TDataSource;
    CdsInsumos: TClientDataSet;
    CdsInsumosCodProduto: TStringField;
    CdsInsumosAPRESENTACAO: TStringField;
    CdsInsumosQUANTINSUMO: TFloatField;
    cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn;
    cxGridDBTableViewQUANTINSUMO: TcxGridDBColumn;
    CdsInsumosDEMANDA: TFloatField;
    CdsInsumosSALDOATUAL: TFloatField;
    CdsInsumosDIASESTOQUE: TFloatField;
    cxGridDBTableViewDIASESTOQUE: TcxGridDBColumn;
    PopupMenuOpcoes: TPopupMenu;
    VerSimilares1: TMenuItem;
    VerInsumos1: TMenuItem;
    CdsInsumosINSUMO: TStringField;
    cxGridDBTableViewINSUMO: TcxGridDBColumn;
    CdsInsumosDetalhe: TClientDataSet;
    CdsInsumosDetalheDEMANDADIARIA: TFloatField;
    CdsInsumosDetalheCODPRODUTO: TStringField;
    CdsInsumosDetalheAPRESENTACAO: TStringField;
    CdsInsumosDetalheSALDOATUAL: TFloatField;
    CdsInsumosDetalheDIASESTOQUE: TFloatField;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView2: TcxGridDBTableView;
    DSInsumosDetalhe: TDataSource;
    CdsInsumosDetalheCODPRO: TStringField;
    cxGridDBTableView2DIASESTOQUE: TcxGridDBColumn;
    CdsInsumosLITROS: TFloatField;
    cxGridDBTableViewLITROS: TcxGridDBColumn;
    CdsInsumosDENSIDADECALCULADA: TFloatField;
    cxGridDBTableViewDENSIDADECALCULADA: TcxGridDBColumn;
    Panel1: TPanel;
    GroupPeso: TGroupBox;
    GroupLitros: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LblPesoPAcabado: TLabel;
    LblPesoCalculado: TLabel;
    LblLitrosCalculado: TLabel;
    LblLitrosPAcabado: TLabel;
    CdsInsumosPESO: TFloatField;
    cxGridDBTableViewPESO: TcxGridDBColumn;
    CdsProdutoAcabado: TClientDataSet;
    CdsProdutoAcabadoCodProduto: TStringField;
    CdsProdutoAcabadoApresentacao: TStringField;
    CdsProdutoAcabadoPESO: TFloatField;
    CdsProdutoAcabadoLITROS: TFloatField;
    ConfiguraodoProduto1: TMenuItem;
    DetalhamentodoProduto1: TMenuItem;
    CdsInsumosPERCPESO: TFloatField;
    CdsInsumosPERCLITROS: TFloatField;
    cxGridDBTableViewPERCPESO: TcxGridDBColumn;
    cxGridDBTableViewPERCLITROS: TcxGridDBColumn;
    cxGridDBTableView2CODSIMILAR: TcxGridDBColumn;
    cxGridDBTableView2PROSIMILAR: TcxGridDBColumn;
    cxGridDBTableView2ESTOQUESUB: TcxGridDBColumn;
    cxGridDBTableView2DEMANDASUB: TcxGridDBColumn;
    cxGridDBTableViewESTOQUESUB: TcxGridDBColumn;
    cxGridDBTableViewCODINSUMO: TcxGridDBColumn;
    cxGridDBTableView2CODINSUMO: TcxGridDBColumn;
    cxGridDBTableViewDEMANDASUB: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure VerSimilares1Click(Sender: TObject);
    procedure VerInsumos1Click(Sender: TObject);
    procedure cxGridDBTableViewDblClick(Sender: TObject);
    procedure ConfiguraodoProduto1Click(Sender: TObject);
    procedure DetalhamentodoProduto1Click(Sender: TObject);
    procedure cxGridDBTableViewPERCLITROSGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure cxGridDBTableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems3GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure cxGridDBTableView2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cxGridDBTableViewMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FPesoCalculado: Double;
    FLitrosCalculado: Double;
    FDensidadeCalc: Double;
    FCodModelo: Integer;
    FGridPopup: TcxGridDBTableView;
    function GetCodProSelecionado: String;
    procedure CarregarInsumosDetalhe(pCodModelo: Integer);
    procedure TotalizaPesoELitrosDosInsumos;
    procedure CarregarProdutoAcabado(pCodModelo: Integer);
    function TryDiv(pDividendo, pDivisor: Double; pDefault: Double = 0): Double;
    procedure AlteraFontGroup(pGrouBox: TGroupBox; FontColor: TColor;
      Style: TFontStyles);
    function GetLitrosCalculado: Double;
    function GetLitrosAcabado: Double;
    function GetPesoCalculado: Double;
    function GetPesoAcabado: Double;
    function GetValorColunaSelecionada(pColuna: TcxGridDBColumn): String;
    function GetNomeProSelecionado: String;
    { Private declarations }
  public
    procedure CarregarInsumos(pCodModelo: Integer);
    procedure Inicializa(pCodModelo: Integer);
    class procedure AbrirInsumos(pCodProduto: String; pNomeProduto: String);

    property PesoCalculado: Double read GetPesoCalculado;
    property LitrosCalculado: Double read GetLitrosCalculado;
    property PesoAcabado: Double read GetPesoAcabado;
    property LitrosAcabado: Double read GetLitrosAcabado;

    function PesoDivergente: Boolean;
    function LitrosDivergente: Boolean;
    function ModeloDivergente: Boolean;
  end;

implementation

uses
  uConSqlServer, uFormSelecionaModelos, uFormAdicionarSimilaridade, uFormProInfo, uFormDetalheProdutos,
  uDmConnection;

{$R *.dfm}

{ TFormInsumos }
procedure TFormInsumos.Inicializa(pCodModelo: Integer);
begin
  FCodModelo:= pCodModelo;
  CarregarProdutoAcabado(pCodModelo);
  CarregarInsumos(pCodModelo);
end;

function TFormInsumos.LitrosDivergente: Boolean;
begin
  Result:= Abs(1 - TryDiv(LitrosCalculado, LitrosAcabado, 1)) > 0.015;
end;

function TFormInsumos.PesoDivergente: Boolean;
begin
  Result:= Abs(1 - TryDiv(PesoCalculado, PesoAcabado, 1)) > 0.015;
end;

function TFormInsumos.ModeloDivergente: Boolean;
begin
  Result:= LitrosDivergente or PesoDivergente;
end;

class procedure TFormInsumos.AbrirInsumos(pCodProduto: String; pNomeProduto: String);
var
  FFrm: TFormInsumos;
  FCodModelo: Integer;
begin
  FCodModelo:= TFormSelecionaModelo.SelecionaModelo(pCodProduto);
  if FCodModelo = 0 then
    Exit;

  FFrm:= TFormInsumos.Create(Application);
  try
    FFrm.Inicializa(FCodModelo);
    FFrm.Caption:= 'Insumos do produto ('+pCodProduto+') '+pNomeProduto;
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

function TFormInsumos.TryDiv(pDividendo, pDivisor: Double; pDefault: Double = 0): Double;
begin
  if pDivisor <> 0 then
    Result:= pDividendo / pDivisor
  else
    Result:= pDefault;

end;

procedure TFormInsumos.TotalizaPesoELitrosDosInsumos;
const
  cSql = 'select Peso, Litros, PesoLiquidoCalc, VolumeLiquidoCalc, Densidade, DensidadeCalc '+
        ' from PesoVolumeCalculado where CodModelo = %d ';
var
  FDataSet: TDataSet;
begin
  FPesoCalculado:= 0;
  FLitrosCalculado:= 0;
  FDensidadeCalc:= 0;

  FDataSet:= ConSqlServer.RetornaDataSet(Format(cSql, [FCodModelo]), True);
  try
    FPesoCalculado:= FDataSet.FieldByName('PesoLiquidoCalc').AsFloat;
    FLitrosCalculado:= FDataSet.FieldByName('VolumeLiquidoCalc').AsFloat;
    FDensidadeCalc:= FDataSet.FieldByName('DensidadeCalc').AsFloat;
  finally
    FDataSet.Free;
  end;

  LblPesoCalculado.Caption:= FormatFloat('#0.00', FPesoCalculado)+' KG';

  LblLitrosCalculado.Caption:= FormatFloat('#0.00', FLitrosCalculado)+' Litros';

  if LitrosDivergente then
    AlteraFontGroup(GroupLitros, clRed, [fsBold]);

  if PesoDivergente then
    AlteraFontGroup(GroupPeso, clRed, [fsBold]);

end;

procedure TFormInsumos.CarregarProdutoAcabado(pCodModelo: Integer);
const
  cSql = 'SELECT M.CODPRODUTO, P.APRESENTACAO, P.PESO, P.LITROS '
       +' FROM INSUMOS_MODELO M INNER JOIN PRODUTO P ON P.CODPRODUTO = M.CODPRODUTO '
       +' WHERE M.CODMODELO = ''%d'' ';
var
  FQry: TDataSet;
begin
  CdsProdutoAcabado.EmptyDataSet;
  FQry:= ConSqlServer.RetornaDataSet(Format(cSql, [pCodModelo]));
  try
    CopiaDadosDataSet(FQry, CdsProdutoAcabado);
  finally
    FQry.Free;
  end;
  LblPesoPAcabado.Caption:= FormatFloat('#0.00', CdsProdutoAcabadoPESO.AsFloat)+' KG';

  LblLitrosPAcabado.Caption:= FormatFloat('#0.00', CdsProdutoAcabadoLITROS.AsFloat)+' Litros';
end;

procedure TFormInsumos.ConfiguraodoProduto1Click(Sender: TObject);
begin
  FormProInfo.Abrir(GetCodProSelecionado);
end;

procedure TFormInsumos.CarregarInsumosDetalhe(pCodModelo: Integer);
var
  FQry: TDataSet;

  function GetSql(pCodModelo: Integer): String;
  begin
(*    Result:= ' select I.CodProduto, '+
             ' ESTOQ.CODPRO, '+
             ' P.APRESENTACAO, '+
             ' ESTOQ.DEMANDADIARIA, '+
             ' ESTOQ.SALDOATUAL, '+
             ' (ESTOQ.SALDOATUAL / NULLIF(ESTOQ.DEMANDADIARIA, 0)) / P.UNIDADEESTOQUE AS DIASESTOQUE, '+
             ' ESTOQ.SALDOATUAL * (P.CUBAGEM * 1000 / P.UNIDADEESTOQUE) AS ESTOQLITROS '+
             ' from INSUMOS_INSUMO I ' +
             ' INNER JOIN '+GetSqlEstoqEquivalenteDetalhe('ESTOQ')+' ON ESTOQ.CODPRO = I.CODPRODUTO '+
             ' INNER JOIN PRODUTO P ON P.CODPRODUTO = ESTOQ.CODPRODUTO ' +
             ' where i.codmodelo = '+IntToStr(pCodModelo)+
             ' and ESTOQ.SALDOATUAL > 0 '+
             ' ORDER BY ESTOQ.CODPRO, ESTOQ.SALDOATUAL DESC ';        *)
     Result:= 'select * from EstoqInsumosDetalhe where CODMODELO = '+IntToStr(pCodModelo)+' ORDER BY CodProduto, ESTOQUESUB DESC ';
  end;

begin
  CdsInsumosDetalhe.EmptyDataSet;
  FQry:= ConSqlServer.RetornaDataSet(GetSql(pCodModelo));
  try
    CopiaDadosDataSet(FQry, CdsInsumosDetalhe);
  finally
    FQry.Free;
  end;
end;

procedure TFormInsumos.CarregarInsumos(pCodModelo: Integer);
var
  FQry: TDataSet;

  function GetSql(pCodModelo: Integer): String;
  begin
    Result:= ' select * from EstoqInsumos '+
             ' where codmodelo = '+IntToStr(pCodModelo);
  end;
begin
  CdsInsumos.EmptyDataSet;
  FQry:= ConSqlServer.RetornaDataSet(GetSql(pCodModelo));
  try
    CopiaDadosDataSet(FQry, CdsInsumos);
  finally
    FQry.Free;
  end;

  TotalizaPesoELitrosDosInsumos;
  CarregarInsumosDetalhe(pCodModelo);
end;

procedure TFormInsumos.cxGridDBTableView2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    FGridPopup:= cxGridDBTableView2;

end;

procedure TFormInsumos.cxGridDBTableViewDblClick(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, CdsInsumosAPRESENTACAO.AsString);
end;

procedure TFormInsumos.cxGridDBTableViewMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    FGridPopup:= cxGridDBTableView;

end;

procedure TFormInsumos.cxGridDBTableViewPERCLITROSGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
var
  Val: Double;
begin
  if TryStrToFloat(AText, Val) then
     AText:= FormatFloat('###0.00', Val*100)+' %';
end;

procedure TFormInsumos.cxGridDBTableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems3GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
var
  Val: Double;
begin
  if TryStrToFloat(AText, Val) then
     AText:= FormatFloat('###0.00', Val*100)+' %';

end;

procedure TFormInsumos.DetalhamentodoProduto1Click(Sender: TObject);
begin
  FormDetalheProdutos.AbreEFocaProduto(GetCodProSelecionado);
end;

procedure TFormInsumos.FormCreate(Sender: TObject);
begin
  FGridPopup:= cxGridDBTableView;

  FPesoCalculado:= 0;
  FLitrosCalculado:= 0;

  if not CdsInsumos.Active then
    CdsInsumos.CreateDataSet;

  if not CdsInsumosDetalhe.Active then
    CdsInsumosDetalhe.CreateDataSet;

  if not CdsProdutoAcabado.Active then
    CdsProdutoAcabado.CreateDataSet;
end;

procedure TFormInsumos.VerInsumos1Click(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, GetNomeProSelecionado);
end;

procedure TFormInsumos.VerSimilares1Click(Sender: TObject);
begin
  TFormAdicionarSimilaridade.AbrirSimilares(GetCodProSelecionado, GetNomeProSelecionado);
end;

function TFormInsumos.GetNomeProSelecionado: String;
VAR
  FRow: TcxGridDBColumn;
begin
  if FGridPopup = cxGridDBTableView2 then
    FRow:= cxGridDBTableView2PROSIMILAR
  else
    FRow:= cxGridDBTableViewAPRESENTACAO;

  if Assigned((cxGrid.FocusedView as TcxGridDBTableView).Controller.FocusedRecord) then
    Result:= VarToStrDef((cxGrid.FocusedView as TcxGridDBTableView).Controller.FocusedRecord.Values[FRow.Index], '');
end;
function TFormInsumos.GetCodProSelecionado: String;
VAR
  FRow: TcxGridDBColumn;
begin
  if FGridPopup = cxGridDBTableView2 then
    FRow:= cxGridDBTableView2CODSIMILAR
  else
    FRow:= cxGridDBTableViewCODINSUMO;

  if Assigned((cxGrid.FocusedView as TcxGridDBTableView).Controller.FocusedRecord) then
    Result:= VarToStrDef((cxGrid.FocusedView as TcxGridDBTableView).Controller.FocusedRecord.Values[FRow.Index], '');
end;

function TFormInsumos.GetLitrosAcabado: Double;
begin
  Result:= CdsProdutoAcabadoLITROS.AsFloat;
end;

function TFormInsumos.GetLitrosCalculado: Double;
begin
  Result:= FLitrosCalculado;
end;

function TFormInsumos.GetPesoAcabado: Double;
begin
  Result:= CdsProdutoAcabadoPESO.AsFloat;
end;

function TFormInsumos.GetPesoCalculado: Double;
begin
  Result:= FPesoCalculado;
end;

function TFormInsumos.GetValorColunaSelecionada(
  pColuna: TcxGridDBColumn): String;
begin

end;

procedure TFormInsumos.AlteraFontGroup(pGrouBox: TGroupBox; FontColor: TColor; Style: TFontStyles);
const
  Color = clRed;
var
  I: Integer;
begin
  pGrouBox.Font.Color:= Color;
  for I := 0 to pGrouBox.ControlCount - 1 do
    if pGrouBox.Controls[I] is TLabel then
    begin
      TLabel(pGrouBox.Controls[I]).Font.Color:= Color;
      TLabel(pGrouBox.Controls[I]).Font.Style:= Style;
    end;

end;

end.
