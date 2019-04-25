unit uFormAdicionarSimilaridade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient,
  uConSqlServer, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus;

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
    CdsSimilaresAPRESENTACAO: TStringField;
    CdsSimilaresAplicacao: TStringField;
    CdsSimilaresNOMESUBUNIDADE: TStringField;
    CdsSimilaresNOMEUNIDADE: TStringField;
    CdsSimilaresUNIDADEESTOQUE: TIntegerField;
    DataSource1: TDataSource;
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
    CdsSimilaresCODSIMILAR: TStringField;
    cxGridDBTableViewCODSIMILAR: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure BtnConfirmarEquivalenciasClick(Sender: TObject);
    procedure VerSimilares1Click(Sender: TObject);
    procedure VerInsumos1Click(Sender: TObject);
  private
    { Private declarations }
    FCodProduto: String;
    function ProdutosSimilares(pCodPro1, pCodPro2: String): Boolean;
    procedure AdicionaSimilares(pCodPro1, pCodPro2: String);
    procedure RemoveSimilares(pCodPro1, pCodProRemove: String);
    function GetCodProSelecionado: String;
  public
    procedure CarregarPotencialmenteSimilares(pCodProduto: String);
    class procedure AbrirSimilares(pCodProduto: String; pNomeProduto: String);
  end;

implementation

{$R *.dfm}

uses
  uFormInsumos, uDmConnection;

{ TFormAdicionarSimilaridade }

function TFormAdicionarSimilaridade.ProdutosSimilares(pCodPro1, pCodPro2: String): Boolean;
begin
  Result:= ConSqlServer.RetornaInteiro(
                  'SELECT Count(*) from Similares where Cod1 = '''+
                      pCodPro1+''' and Cod2 =  '''+pCodPro2+''' ') > 0;
end;

class procedure TFormAdicionarSimilaridade.AbrirSimilares(pCodProduto: String; pNomeProduto: String);
var
  FFrm: TFormAdicionarSimilaridade;
begin
  FFrm:= TFormAdicionarSimilaridade.Create(Application);
  try
    FFrm.Caption:= 'Configuração de produtos equivalentes ao ('+pCodProduto+') '+pNomeProduto;
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
  ConSqlServer.ExecutaComando(Format(cSql, [pCodPro1, pCodPro2]));
end;

procedure TFormAdicionarSimilaridade.RemoveSimilares(pCodPro1, pCodProRemove: String);
  function RetornaSql: String;
  begin
    Result:= ' DELETE FROM PRODUTOSIMILAR WHERE'+
             ' (CODPRODUTO = '''+pCodProRemove+''' and CODPROSIMILAR in '+
             '   (SELECT s1.Cod2 from Similares s1 where s1.Cod1 = '''+pCodPro1+''' )) '+
             ' OR '+
             ' (CODPROSIMILAR = '''+pCodProRemove+'''  and CODPRODUTO in '+
             '   (SELECT s1.Cod2 from Similares s1 where s1.Cod1 = '''+pCodPro1+''')) ';
  end;

begin
  ConSqlServer.ExecutaComando(RetornaSql);
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
                                                                cxGridDBTableViewCODSIMILAR.Index], '');
end;

procedure TFormAdicionarSimilaridade.BtnConfirmarEquivalenciasClick(
  Sender: TObject);
begin
  CdsSimilares.First;
  while not CdsSimilares.Eof do
  begin
    if CdsSimilaresEquivalente.AsBoolean then
    begin
      if not ProdutosSimilares(FCodProduto, CdsSimilaresCodSimilar.AsString) then
        AdicionaSimilares(FCodProduto, CdsSimilaresCodSimilar.AsString);

    end
   else
    begin
      if ProdutosSimilares(FCodProduto, CdsSimilaresCodSimilar.AsString) then
        RemoveSimilares(FCodProduto, CdsSimilaresCodSimilar.AsString);

    end;
    CdsSimilares.Next;
  end;

  Close;
end;

procedure TFormAdicionarSimilaridade.CarregarPotencialmenteSimilares(pCodProduto: String);
const
  cSql =
 ' select * from PotencialmenteSimilares '+
 '     WHERE CODPRODUTO = ''%s'' '+
 '  ORDER BY NOMEAPLICACAO, SIMILARES DESC ';
var
  FQry: TDataSet;
begin
  FCodProduto:= pCodProduto;
  FQry:= ConSqlServer.RetornaDataSet(Format(cSql, [pCodProduto]));
  try
    CopiaDadosDataSet(FQry, CdsSimilares);

    CdsSimilares.First;
    while not CdsSimilares.Eof do
    begin
      CdsSimilares.Edit;
      CdsSimilaresEquivalente.AsBoolean:= ProdutosSimilares(FCodProduto, CdsSimilaresCodSimilar.AsString);
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
