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
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView1CODPEDIDO: TcxGridDBColumn;
    cxGridDBTableView1QUANTIDADE: TcxGridDBColumn;
    cxGridDBTableView1DIASPARAENTREGA: TcxGridDBColumn;
    cxGridDBTableView1SIT: TcxGridDBColumn;
    cxGridDBTableView1NOMECLIENTE: TcxGridDBColumn;
    cxGridDBTableView1NOMETRANSPORTE: TcxGridDBColumn;
    cxGridDBTableView1QUANTPENDENTE: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    DsInsumos: TDataSource;
    CdsInsumos: TClientDataSet;
    CdsInsumosCodProduto: TStringField;
    CdsInsumosAPRESENTACAO: TStringField;
    CdsInsumosQUANTINSUMO: TFloatField;
    cxGridDBTableViewCODPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn;
    cxGridDBTableViewQUANTINSUMO: TcxGridDBColumn;
    CdsInsumosDEMANDA: TFloatField;
    CdsInsumosSALDOATUAL: TFloatField;
    cxGridDBTableViewSALDOATUAL: TcxGridDBColumn;
    CdsInsumosDIASESTOQUE: TFloatField;
    cxGridDBTableViewDIASESTOQUE: TcxGridDBColumn;
    PopupMenuOpcoes: TPopupMenu;
    VerSimilares1: TMenuItem;
    VerInsumos1: TMenuItem;
    CdsInsumosINSUMO: TStringField;
    cxGridDBTableViewDEMANDADIARIA: TcxGridDBColumn;
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
    cxGridDBTableView2CODPRODUTO: TcxGridDBColumn;
    cxGridDBTableView2APRESENTACAO: TcxGridDBColumn;
    cxGridDBTableView2SALDOATUAL: TcxGridDBColumn;
    cxGridDBTableView2DEMANDADIARIA: TcxGridDBColumn;
    cxGridDBTableView2DIASESTOQUE: TcxGridDBColumn;
    cxGridDBTableView2CODPRO: TcxGridDBColumn;
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
  private
    FPesoCalculado: Double;
    FLitrosCalculado: Double;
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

  function GetSqlProEquivalentes(pAlias: String = 'EQUIVALENTES'): String;

  function GetSqlEstoqueEquivalentes(pAlias: String = 'ESTOQ'): String;

implementation

uses
  uDmSqlUtils, uFormSelecionaModelos, uFormAdicionarSimilaridade, uFormProInfo, uFormDetalheProdutos;

{$R *.dfm}

{ TFormInsumos }

function GetSqlProEquivalentes(pAlias: String = 'EQUIVALENTES'): String;
begin
  Result:=
      '(   '+sLineBreak+
      ' SELECT DISTINCT CODPRO, CODSIMILAR '+sLineBreak+
      ' FROM ( '+sLineBreak+
      '  SELECT P.CODPRODUTO AS CODPRO, P.CODPRODUTO AS CODSIMILAR FROM PRODUTO P '+sLineBreak+ // Todo produto é equivalente a ele mesmo
      '  UNION ALL '+sLineBreak+
      '  select S1.CODPRODUTO AS CODPRO, S1.CODPROSIMILAR AS CODSIMILAR '+sLineBreak+ // Se existir ligação de similaridade os produtos são equivalentes
      '  FROM PRODUTOSIMILAR S1 '+sLineBreak+
      '  UNION ALL '+sLineBreak+
      '  SELECT S2.CODPROSIMILAR AS CODPRO, S2.CODPRODUTO AS CODSIMILAR '+sLineBreak+ // Se existir ligação de similaridade os produtos são equivalentes
      '  FROM PRODUTOSIMILAR S2 '+sLineBreak+
      '  UNION ALL '+sLineBreak+
      '  SELECT S3.CODPROSIMILAR AS CODPRO, S4.CODPROSIMILAR AS CODSIMILAR '+sLineBreak+ // Todas os produtos que tiverem uma similaridade com um produto em comum são considerados equivalentes
      '  FROM PRODUTOSIMILAR S3 '+sLineBreak+
      '  INNER JOIN PRODUTOSIMILAR S4 ON S4.CODPRODUTO = S3.CODPRODUTO '+sLineBreak+
      ' )PROEQUIVALENTES '+sLineBreak+
      ')'+pAlias;
end;

function GetSqlEstoqEquivalenteDetalhe(pAlias: String = 'ESTOQ'): String;
begin
  Result:=
   '( SELECT      '+sLineBreak+
   '   PE.CODPRO, '+sLineBreak+
   '   E.CODPRODUTO, '+sLineBreak+
   '   (E.DM_DEMANDA / P.UNIDADEESTOQUE) / E.ROTACAO AS DEMANDADIARIA, '+sLineBreak+
	 '   SALDOATUAL AS SALDOATUAL '+sLineBreak+
   ' FROM ESTOQUE E '+sLineBreak+
   ' INNER JOIN PRODUTO P ON P.CODPRODUTO = E.CODPRODUTO '+sLineBreak+
	 ' INNER JOIN '+GetSqlProEquivalentes('PE')+' ON PE.CODSIMILAR = E.CODPRODUTO '+sLineBreak+
   ' WHERE E.CODFILIAL = ''01'' '+sLineBreak+
   ' )'+pAlias;
end;

function GetSqlEstoqueEquivalentes(pAlias: String = 'ESTOQ'): String;
begin
  Result:=
   '( SELECT      '+sLineBreak+
   '   PE.CODPRO, '+sLineBreak+
   '   SUM((E.DM_DEMANDA / P.UNIDADEESTOQUE) / E.ROTACAO) AS DEMANDADIARIA, '+sLineBreak+
	 '   SUM(SALDOATUAL) AS SALDOATUAL '+sLineBreak+
   ' FROM ESTOQUE E '+sLineBreak+
   ' INNER JOIN PRODUTO P ON P.CODPRODUTO = E.CODPRODUTO '+sLineBreak+
	 ' INNER JOIN '+GetSqlProEquivalentes('PE')+' ON PE.CODSIMILAR = E.CODPRODUTO '+sLineBreak+
   ' WHERE E.CODFILIAL = ''01'' '+sLineBreak+
   ' GROUP BY PE.CODPRO '+sLineBreak+
   ' )'+pAlias;
end;


procedure TFormInsumos.Inicializa(pCodModelo: Integer);
begin
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
    FFrm.Caption:= 'Insumos do produto '+pNomeProduto;
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
begin
  FPesoCalculado:= 0;
  FLitrosCalculado:= 0;

  CdsInsumos.First;
  while not CdsInsumos.Eof do
  begin
    if FormProInfo.NaoSomaNoPesoLiq(CdsInsumosCodProduto.AsString) = False then
    begin
      CdsInsumos.Edit;
      CdsInsumosPERCPESO.AsFloat:= TryDiv(CdsInsumosPESO.AsFloat, CdsProdutoAcabadoPESO.AsFloat);
      CdsInsumosPERCLITROS.AsFloat:= TryDiv(CdsInsumosLITROS.AsFloat, CdsProdutoAcabadoLitros.AsFloat);
      CdsInsumos.Post;

      FLitrosCalculado:= FLitrosCalculado+CdsInsumosLITROS.AsFloat;
      FPesoCalculado:= FPesoCalculado+CdsInsumosPeso.AsFloat;
    end;

    CdsInsumos.Next;
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
  cSql = 'SELECT P.CODPRODUTO, P.APRESENTACAO, P.PESO, (P.CUBAGEM * 1000) AS LITROS '
       +' FROM INSUMOS_ACABADO M INNER JOIN PRODUTO P ON P.CODPRODUTO = M.CODPRODUTO '
       +' WHERE M.CODMODELO = ''%d'' ';
var
  FQry: TDataSet;
begin
  CdsProdutoAcabado.EmptyDataSet;
  FQry:= DmSqlUtils.RetornaDataSet(Format(cSql, [pCodModelo]));
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
    Result:= ' select I.CodProduto, '+
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
             ' ORDER BY ESTOQ.CODPRO, ESTOQ.SALDOATUAL DESC ';
  end;

begin
  CdsInsumosDetalhe.EmptyDataSet;
  FQry:= DmSqlUtils.RetornaDataSet(GetSql(pCodModelo));
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
    Result:= ' select I.CodModelo, I.CodProduto, P.APRESENTACAO, I.QuantInsumo, '+
             ' I.QuantInsumo * (P.CUBAGEM * 1000 / P.UNIDADEESTOQUE) AS LITROS, '+
             ' I.QuantInsumo * (P.PESO / P.UNIDADEESTOQUE) AS PESO, '+
             ' (0.001 / NULLIF(P.CUBAGEM, 0)) as DENSIDADECALCULADA, '+
             ' (SELECT TRIM(G.NOMESUBGRUPO) FROM GRUPOSUB G WHERE G.CODGRUPOSUB = P.CODGRUPOSUB) ||'' ''|| P.UNIDADE AS INSUMO, '+
             ' ESTOQ.DEMANDADIARIA, '+
             ' ESTOQ.SALDOATUAL, '+
             ' (ESTOQ.SALDOATUAL / NULLIF(ESTOQ.DEMANDADIARIA, 0)) / P.UNIDADEESTOQUE AS DIASESTOQUE '+
             ' from INSUMOS_INSUMO I ' +
             ' INNER JOIN PRODUTO P ON P.CODPRODUTO = I.CODPRODUTO ' +
             ' INNER JOIN '+GetSqlEstoqueEquivalentes('ESTOQ')+' ON ESTOQ.CODPRO = P.CODPRODUTO '+
             ' where i.codmodelo = '+IntToStr(pCodModelo);
  end;
begin
  CdsInsumos.EmptyDataSet;
  FQry:= DmSqlUtils.RetornaDataSet(GetSql(pCodModelo));
  try
    CopiaDadosDataSet(FQry, CdsInsumos);
  finally
    FQry.Free;
  end;

  TotalizaPesoELitrosDosInsumos;
  CarregarInsumosDetalhe(pCodModelo);
end;

procedure TFormInsumos.cxGridDBTableViewDblClick(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, CdsInsumosAPRESENTACAO.AsString);
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
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, CdsInsumosApresentacao.AsString);
end;

procedure TFormInsumos.VerSimilares1Click(Sender: TObject);
begin
  TFormAdicionarSimilaridade.AbrirSimilares(GetCodProSelecionado, CdsInsumosApresentacao.AsString);
end;

function TFormInsumos.GetCodProSelecionado: String;
begin
  Result:= VarToStrDef(cxGridDBTableView.DataController.Values[cxGridDBTableView.DataController.FocusedRecordIndex,
                                                                cxGridDBTableViewCODPRODUTO.Index], '');
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
