unit uFormValidaModelos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, Datasnap.DBClient, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, uFormInsumos,
  Vcl.Menus;

type
  TFormValidaModelos = class(TForm)
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    CdsModelosComDivergencia: TClientDataSet;
    DSModelosComDivergencia: TDataSource;
    CdsModelosComDivergenciaCodModelo: TIntegerField;
    CdsModelosComDivergenciaCodProduto: TStringField;
    CdsModelosComDivergenciaApresentacao: TStringField;
    CdsModelosComDivergenciaPesoCalculado: TFloatField;
    CdsModelosComDivergenciaPesoAcabado: TFloatField;
    CdsModelosComDivergenciaLitroCalculado: TFloatField;
    CdsModelosComDivergenciaLitroAcabado: TFloatField;
    cxGridDBTableViewCodModelo: TcxGridDBColumn;
    cxGridDBTableViewCodProduto: TcxGridDBColumn;
    cxGridDBTableViewApresentacao: TcxGridDBColumn;
    cxGridDBTableViewPesoAcabado: TcxGridDBColumn;
    cxGridDBTableViewPesoCalculado: TcxGridDBColumn;
    cxGridDBTableViewLitroAcabado: TcxGridDBColumn;
    cxGridDBTableViewLitroCalculado: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    AbrirConfigPro: TMenuItem;
    AbrirDetalhePro: TMenuItem;
    VerSimilares1: TMenuItem;
    VerInsumos1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AbrirConfigProClick(Sender: TObject);
    procedure AbrirDetalheProClick(Sender: TObject);
    procedure VerInsumos1Click(Sender: TObject);
    procedure VerSimilares1Click(Sender: TObject);
  private
    FFrmInsumos: TFormInsumos;
    procedure VerificaDivergencias;
    function GetCodProSelecionado: String;

    { Private declarations }
  public
    procedure Inicializa;
  end;

var
  FormValidaModelos: TFormValidaModelos;

implementation

{$R *.dfm}

uses
  uDmSqlUtils, uFormProInfo, uFormDetalheProdutos, uFormAdicionarSimilaridade;

procedure TFormValidaModelos.VerificaDivergencias;
const
  cSql = 'select IA.CODMODELO, P.CODPRODUTO, P.APRESENTACAO, P.PESO AS PESOACABADO, P.CUBAGEM * 1000 AS LITROSACABADO '+
         ' from INSUMOS_MODELO IM ' +
         ' INNER JOIN INSUMOS_ACABADO IA ON IM.CODMODELO = IA.CODMODELO '+
         ' INNER JOIN PRODUTO P ON P.CODPRODUTO = IA.CODPRODUTO '+
         ' WHERE MODELOATIVO_SN <> ''N'' AND (SELECT COUNT(II.CODPRODUTO) FROM INSUMOS_INSUMO II WHERE II.CODMODELO = IM.CODMODELO) > 0 ';
begin
  DmSqlUtils.PopulaClientDataSet(CdsModelosComDivergencia, cSql);

  CdsModelosComDivergencia.First;
  while not CdsModelosComDivergencia.Eof do
  begin
    FFrmInsumos.Inicializa(CdsModelosComDivergenciaCodModelo.AsInteger);
    if not FFrmInsumos.ModeloDivergente then
    begin
      CdsModelosComDivergencia.Delete;
    end
   else
    begin
      CdsModelosComDivergencia.Edit;
      CdsModelosComDivergenciaPesoAcabado.AsFloat:= FFrmInsumos.PesoAcabado;
      CdsModelosComDivergenciaPesoCalculado.AsFloat:= FFrmInsumos.PesoCalculado;
      CdsModelosComDivergenciaLitroAcabado.AsFloat:= FFrmInsumos.LitrosAcabado;
      CdsModelosComDivergenciaLitroCalculado.AsFloat:= FFrmInsumos.LitrosCalculado;
      CdsModelosComDivergencia.Post;

      CdsModelosComDivergencia.Next;
    end;
  end;
end;

procedure TFormValidaModelos.AbrirConfigProClick(Sender: TObject);
begin
  FormProInfo.Abrir(GetCodProSelecionado);
end;

procedure TFormValidaModelos.AbrirDetalheProClick(Sender: TObject);
begin
  FormDetalheProdutos.AbreEFocaProduto(GetCodProSelecionado);
end;

procedure TFormValidaModelos.VerInsumos1Click(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, CdsModelosComDivergenciaApresentacao.AsString);
end;

procedure TFormValidaModelos.VerSimilares1Click(Sender: TObject);
begin
  TFormAdicionarSimilaridade.AbrirSimilares(GetCodProSelecionado, CdsModelosComDivergenciaApresentacao.AsString);
end;

function TFormValidaModelos.GetCodProSelecionado: String;
begin
  Result:= VarToStrDef(cxGridDBTableView.DataController.Values[cxGridDBTableView.DataController.FocusedRecordIndex,
                                                                cxGridDBTableViewCODPRODUTO.Index], '');
end;

procedure TFormValidaModelos.FormCreate(Sender: TObject);
begin
  FFrmInsumos:= TFormInsumos.Create(Self);
end;

procedure TFormValidaModelos.FormShow(Sender: TObject);
begin
  Inicializa;
end;

procedure TFormValidaModelos.Inicializa;
begin
  if not CdsModelosComDivergencia.Active then
    CdsModelosComDivergencia.CreateDataSet;

  VerificaDivergencias;
end;

end.
