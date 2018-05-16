unit uFormAdicionarSimilaridade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient,
  uDmSqlUtils, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus;

type
  TFormAdicionarSimilaridade = class(TForm)
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
    CdsSimilares: TClientDataSet;
    CdsSimilaresCodProduto: TStringField;
    CdsSimilaresAPRESENTACAO: TStringField;
    CdsSimilaresAplicacao: TStringField;
    CdsSimilaresNOMESUBUNIDADE: TStringField;
    CdsSimilaresNOMEUNIDADE: TStringField;
    CdsSimilaresUNIDADEESTOQUE: TIntegerField;
    DataSource1: TDataSource;
    cxGridDBTableViewCODPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn;
    cxGridDBTableViewNOMEAPLICACAO: TcxGridDBColumn;
    cxGridDBTableViewUNIDADE: TcxGridDBColumn;
    cxGridDBTableViewUNIDADEESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewNOMESUBUNIDADE: TcxGridDBColumn;
    CdsSimilaresEquivalente: TBooleanField;
    cxGridDBTableViewEquivalente: TcxGridDBColumn;
    Panel1: TPanel;
    BtnConfirmarEquivalencias: TBitBtn;
    PopupMenuOpcoes: TPopupMenu;
    VerSimilares1: TMenuItem;
    VerInsumos1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure BtnConfirmarEquivalenciasClick(Sender: TObject);
    procedure VerSimilares1Click(Sender: TObject);
    procedure VerInsumos1Click(Sender: TObject);
  private
    { Private declarations }
    FCodProduto: String;
    function ProdutosSimilares(pCodPro1, pCodPro2: String): Boolean;
    function GetSqlEquivalentes(pCodProduto: String): String;
    procedure AdicionaSimilares(pCodPro1, pCodPro2: String);
    procedure RemoveSimilares(pCodPro1, pCodPro2: String);
    function GetCodProSelecionado: String;
  public
    procedure CarregarPotencialmenteSimilares(pCodProduto: String);
    class procedure AbrirSimilares(pCodProduto: String; pNomeProduto: String);
  end;

implementation

{$R *.dfm}

uses
  uFormInsumos;

{ TFormAdicionarSimilaridade }

function TFormAdicionarSimilaridade.GetSqlEquivalentes(pCodProduto: String): String;
begin
  Result:= ' SELECT X.COD, P.UNIDADE, P.UNIDADEESTOQUE, P.NOMESUBUNIDADE, A.NOMEAPLICACAO ' +
           '  FROM ( ' +
           '    select CODPROSIMILAR AS COD ' +
           '    FROM PRODUTOSIMILAR S1 ' +
           '    WHERE S1.CODPRODUTO = '''+pCodProduto+''' ' +
           '    UNION ALL ' +
           '    SELECT CODPRODUTO AS COD ' +
           '    FROM PRODUTOSIMILAR S2 ' +
           '    WHERE S2.CODPROSIMILAR = '''+pCodProduto+''' '+
           '  )X ' +
           '  INNER JOIN PRODUTO P ON P.CODPRODUTO = X.COD ' +
           '  LEFT JOIN APLICA A ON A.CODAPLICACAO = P.CODAPLICACAO ';

end;

function TFormAdicionarSimilaridade.ProdutosSimilares(pCodPro1, pCodPro2: String): Boolean;
var
  FSql: String;
  FQry: TDataSet;
begin
  FSql:= GetSqlEquivalentes(pCodPro1)+' WHERE X.COD = '''+pCodPro2+''' ';
  FQry:= DmSqlUtils.RetornaDataSet(FSql);
  try
    Result:= FQry.FieldByName('COD').IsNull = False;
  finally
    FQry.Free;
  end;
end;

class procedure TFormAdicionarSimilaridade.AbrirSimilares(pCodProduto: String; pNomeProduto: String);
var
  FFrm: TFormAdicionarSimilaridade;
begin
  FFrm:= TFormAdicionarSimilaridade.Create(Application);
  try
    FFrm.Caption:= 'Configuração de produtos equivalentes ao '+pNomeProduto;
    FFrm.CarregarPotencialmenteSimilares(pCodProduto);
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

procedure TFormAdicionarSimilaridade.AdicionaSimilares(pCodPro1, pCodPro2: String);
const
  cSql = ' INSERT INTO PRODUTOSIMILAR (CODPRODUTO, CODPROSIMILAR) VALUES (''%s'', ''%s'') ';
begin
  DmSqlUtils.ExecutaComando(Format(cSql, [pCodPro1, pCodPro2]));
end;

procedure TFormAdicionarSimilaridade.RemoveSimilares(pCodPro1, pCodPro2: String);
  function RetornaSql: String;
  begin
    Result:= ' DELETE FROM PRODUTOSIMILAR '+
             ' WHERE ((CODPRODUTO = '''+pCodPro1+''') AND (CODPROSIMILAR = '''+pCodPro2+''' )) '+
             ' OR ((CODPRODUTO = '''+pCodPro2+''' ) AND (CODPROSIMILAR = '''+pCodPro1+''' ))    ';
  end;

begin
  DmSqlUtils.ExecutaComando(Format(RetornaSql, [pCodPro1, pCodPro2]));
end;

procedure TFormAdicionarSimilaridade.VerInsumos1Click(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, CdsSimilaresAPRESENTACAO.AsString);
end;

procedure TFormAdicionarSimilaridade.VerSimilares1Click(Sender: TObject);
begin
  TFormAdicionarSimilaridade.AbrirSimilares(GetCodProSelecionado, CdsSimilaresAPRESENTACAO.AsString);
end;

function TFormAdicionarSimilaridade.GetCodProSelecionado: String;
begin
  Result:= VarToStrDef(cxGridDBTableView.DataController.Values[cxGridDBTableView.DataController.FocusedRecordIndex,
                                                                cxGridDBTableViewCODPRODUTO.Index], '');
end;

procedure TFormAdicionarSimilaridade.BtnConfirmarEquivalenciasClick(
  Sender: TObject);
begin
  CdsSimilares.First;
  while not CdsSimilares.Eof do
  begin
    if CdsSimilaresEquivalente.AsBoolean then
    begin
      if not ProdutosSimilares(FCodProduto, CdsSimilaresCodProduto.AsString) then
        AdicionaSimilares(FCodProduto, CdsSimilaresCodProduto.AsString);

    end
   else
    begin
      if ProdutosSimilares(FCodProduto, CdsSimilaresCodProduto.AsString) then
        RemoveSimilares(FCodProduto, CdsSimilaresCodProduto.AsString);

    end;
    CdsSimilares.Next;
  end;

  Close;
end;

procedure TFormAdicionarSimilaridade.CarregarPotencialmenteSimilares(pCodProduto: String);
const
  cSql =
 ' SELECT P2.CODPRODUTO, P2.APRESENTACAO, P2.UNIDADE, P2.UNIDADEESTOQUE, P2.NOMESUBUNIDADE, '+
 '	(SELECT NOMEAPLICACAO FROM APLICA A WHERE A.CODAPLICACAO = P2.CODAPLICACAO) AS NOMEAPLICACAO '+
 '  FROM PRODUTO P '+
 '  inner join PRODUTO P2 on P2.codproduto <> P.CODPRODUTO '+
 '	and p2.UNIDADE = P.UNIDADE '+
 '   AND P2.UNIDADEESTOQUE = P.UNIDADEESTOQUE '+
 '   AND P2.CODGRUPOSUB = P.CODGRUPOSUB '+
 '     WHERE P.CODPRODUTO = ''%s'' '  ;
var
  FQry: TDataSet;
begin
  FCodProduto:= pCodProduto;
  FQry:= DmSqlUtils.RetornaDataSet(Format(cSql, [pCodProduto]));
  try
    CopiaDadosDataSet(FQry, CdsSimilares);

    CdsSimilares.First;
    while not CdsSimilares.Eof do
    begin
      CdsSimilares.Edit;
      CdsSimilaresEquivalente.AsBoolean:= ProdutosSimilares(FCodProduto, CdsSimilaresCodProduto.AsString);
      CdsSimilares.Post;

      CdsSimilares.Next;
    end;
  finally
    FQry.Free;
  end;

end;

procedure TFormAdicionarSimilaridade.FormCreate(Sender: TObject);
begin
  if not CdsSimilares.Active then
    CdsSimilares.CreateDataSet;
end;

end.
