unit uFormInsumos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, Datasnap.DBClient, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  Vcl.Menus;

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
    procedure FormCreate(Sender: TObject);
    procedure VerSimilares1Click(Sender: TObject);
    procedure VerInsumos1Click(Sender: TObject);
    procedure cxGridDBTableViewDblClick(Sender: TObject);
  private
    function GetCodProSelecionado: String;
    procedure CarregarInsumosDetalhe(pCodModelo: Integer);
    { Private declarations }
  public
    procedure CarregarInsumos(pCodModelo: Integer);
    class procedure AbrirInsumos(pCodProduto: String; pNomeProduto: String);
  end;

  function GetSqlProEquivalentes(pAlias: String = 'EQUIVALENTES'): String;

  function GetSqlEstoqueEquivalentes(pAlias: String = 'ESTOQ'): String;

implementation

uses
  uDmSqlUtils, uFormSelecionaModelos, uFormAdicionarSimilaridade;

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
    FFrm.Caption:= 'Insumos do produto '+pNomeProduto;
    FFrm.CarregarInsumos(FCodModelo);
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
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
             ' (ESTOQ.SALDOATUAL / NULLIF(ESTOQ.DEMANDADIARIA, 0)) AS DIASESTOQUE, '+
             ' ESTOQ.SALDOATUAL / (0.001 / NULLIF(P.CUBAGEM, 0)) AS ESTOQLITROS '+
             ' from INSUMOS_INSUMO I ' +
             ' INNER JOIN '+GetSqlEstoqEquivalenteDetalhe('ESTOQ')+' ON ESTOQ.CODPRO = I.CODPRODUTO '+
             ' INNER JOIN PRODUTO P ON P.CODPRODUTO = ESTOQ.CODPRODUTO ' +
             ' where i.codmodelo = '+IntToStr(pCodModelo)+
             ' and ESTOQ.SALDOATUAL > 0 '+
             ' ORDER BY ESTOQ.CODPRO, ESTOQ.SALDOATUAL DESC ';
  end;

begin
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
             ' I.QuantInsumo / (0.001 / NULLIF(P.CUBAGEM, 0)) AS LITROS, '+
             ' (0.001 / NULLIF(P.CUBAGEM, 0)) as DENSIDADECALCULADA, '+
             ' (SELECT TRIM(G.NOMESUBGRUPO) FROM GRUPOSUB G WHERE G.CODGRUPOSUB = P.CODGRUPOSUB) ||'' ''|| P.UNIDADE AS INSUMO, '+
             ' ESTOQ.DEMANDADIARIA, '+
             ' ESTOQ.SALDOATUAL, '+
             ' (ESTOQ.SALDOATUAL / NULLIF(ESTOQ.DEMANDADIARIA, 0)) AS DIASESTOQUE '+
             ' from INSUMOS_INSUMO I ' +
             ' INNER JOIN PRODUTO P ON P.CODPRODUTO = I.CODPRODUTO ' +
             ' INNER JOIN '+GetSqlEstoqueEquivalentes('ESTOQ')+' ON ESTOQ.CODPRO = P.CODPRODUTO '+
             ' where i.codmodelo = '+IntToStr(pCodModelo);
  end;
begin
  FQry:= DmSqlUtils.RetornaDataSet(GetSql(pCodModelo));
  try
    CopiaDadosDataSet(FQry, CdsInsumos);
  finally
    FQry.Free;
  end;

  CarregarInsumosDetalhe(pCodModelo);
end;

procedure TFormInsumos.cxGridDBTableViewDblClick(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, CdsInsumosAPRESENTACAO.AsString);
end;

procedure TFormInsumos.FormCreate(Sender: TObject);
begin
  if not CdsInsumos.Active then
    CdsInsumos.CreateDataSet;

  if not CdsInsumosDetalhe.Active then
    CdsInsumosDetalhe.CreateDataSet;

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

end.
