unit uConsultaPersonalizada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  IniFiles, Dialogs, ComCtrls, StdCtrls, Buttons, uConSqlServer, Grids,
  DBGrids, DB, ADODB, DBCtrls, Clipbrd, ComObj, Mask, ShellApi,  CheckLst, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,cxGridExportLink,
  cxGridCardView, cxGridCustomLayoutView, cxGridChartView,
  cxCustomPivotGrid, cxDBPivotGrid, cxPivotGridChartConnection, uDmGeradorConsultas,
  ExtCtrls, cxGridDBChartView, cxExportPivotGridLink, cxSplitter,
  dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light,  StrUtils,
  Winapi.ShlObj, cxShellCommon, cxContainer, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxShellComboBox, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uConFirebird, System.Generics.Collections, Vcl.Imaging.pngImage,
  uConClasses, uDmConnection, Ladder.ServiceLocator, SynCommons, ExpressionParser, cxUtils,
  uFormPropriedadesGrafico, uConsultaChartController, Ladder.Logger;

type
  TPosicaoPanelDinamico = (cMinimizado, cMeio, cMaximizado);
  TUserMessageOptions = (umShowDialog, umLogMessages, umShowAndLogMessages);

  TFrmConsultaPersonalizada = class(TForm)
    BtnFechar: TBitBtn;
    PageControl: TPageControl;
    TabParametros: TTabSheet;
    TabSheetResultado: TTabSheet;
    DsConsulta: TDataSource;
    TabSheetAguarde: TTabSheet;
    Label1: TLabel;
    ScrollBox: TScrollBox;
    PageControlVisualizacoes: TPageControl;
    TsTabela: TTabSheet;
    cxGridTabela: TcxGrid;
    cxGridTabelaDBTableView1: TcxGridDBTableView;
    cxGridTabelaLevel1: TcxGridLevel;
    TsDinamica: TTabSheet;
    TsGrafico: TTabSheet;
    cxPivotGridChartConnection: TcxPivotGridChartConnection;
    DsVisualizacoes: TDataSource;
    IR_EXECUTANDOCONSULTA: TBitBtn;
    Panel1: TPanel;
    MemoSQL: TMemo;
    SaveDialog: TSaveDialog;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Panel2: TPanel;
    Label5: TLabel;
    BtnCarregaFiltro: TSpeedButton;
    BtnNovoFiltro: TSpeedButton;
    BtnDeleteConfiguracao: TSpeedButton;
    cbxConfiguracoes: TDBLookupComboBox;
    Panel3: TPanel;
    VOLTAR_PARAMETROS: TBitBtn;
    LabelCount: TLabel;
    LbTime: TLabel;
    BtnExcelcxGridTarefa: TBitBtn;
    cxStyleFontes: TcxStyleRepository;
    PanelTsGrafico: TPanel;
    PanelGrafico: TPanel;
    PanelTabelaDinamica: TPanel;
    DBPivotGrid: TcxDBPivotGrid;
    PanelControlesGrafico: TPanel;
    BtnDiminuir: TSpeedButton;
    BtnMaximizar: TSpeedButton;
    BtnMeio: TSpeedButton;
    cxSplitterResultado: TcxSplitter;
    FontSizeStyle: TcxStyle;
    BtnGravar: TBitBtn;
    BtnCancelar: TBitBtn;
    DBMemoDescricao: TDBMemo;
    DBText: TDBText;
    QryVisualizacoes: TFDQuery;
    QryVisualizacoesID: TFDAutoIncField;
    QryVisualizacoesConsulta: TIntegerField;
    QryVisualizacoesArquivo: TBlobField;
    QryVisualizacoesDataHora: TSQLTimeStampField;
    QryConsulta: TFDQuery;
    QryVisualizacoesDescricao: TStringField;
    TabSheetSql: TTabSheet;
    MemoSqlGerado: TMemo;
    cxStyleRepository: TcxStyleRepository;
    cxStyleLinhaPar: TcxStyle;
    cxStyleLinhaImpar: TcxStyle;
    cxStyleGroup: TcxStyle;
    cxGridTableViewStyleSheet1: TcxGridTableViewStyleSheet;
    cxStyleHeader: TcxStyle;
    cxStyleTitulo: TcxStyle;
    BtnSalvaImg: TBitBtn;
    CbxFormatoNativo: TCheckBox;
    PanelGrafInterno: TPanel;
    cxGridGrafico: TcxGrid;
    cxGridGraficoChartView: TcxGridChartView;
    cxGridGraficoLevel: TcxGridLevel;
    BtnOpcoesGrafico: TButton;
    cxStyle1: TcxStyle;
    procedure BtnFecharClick(Sender: TObject);
    procedure VOLTAR_PARAMETROSClick(Sender: TObject);
    procedure IR_EXECUTANDOCONSULTAClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnNovoFiltroClick(Sender: TObject);
    procedure BtnDeleteConfiguracaoClick(Sender: TObject);
    procedure QryConfiguracoesBeforeOpen(DataSet: TDataSet);
    procedure QryConfiguracoesBeforeDelete(DataSet: TDataSet);
    procedure QryConfiguracoesBeforePost(DataSet: TDataSet);

    procedure Proc_Gera_Para();
    procedure Proc_Go_Para();
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnExcelcxGridTarefaClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure cbxConfiguracoesClick(Sender: TObject);
    procedure cxGridChartViewCategoriesGetValueDisplayText(Sender: TObject;
      const AValue: Variant; var ADisplayText: string);
    procedure BtnMaximizarClick(Sender: TObject);
    procedure BtnDiminuirClick(Sender: TObject);
    procedure BtnMeioClick(Sender: TObject);
    procedure TsGraficoResize(Sender: TObject);
    procedure PageControlVisualizacoesChange(Sender: TObject);
    procedure Proc_Atualiza_LegenItem(pSize: Integer; pBold : Boolean; pItalic :Boolean);
    procedure cxChangeLegendColorCustomDrawLegendItem(Sender: TcxGridChartDiagram;
    ACanvas: TcxCanvas; AViewInfo: TcxGridChartLegendItemViewInfo;
    var ADone: Boolean);

    procedure cxChangeSectionColorCustomDrawValue(
      Sender: TcxGridChartDiagram; ACanvas: TcxCanvas;
      AViewInfo: TcxGridChartDiagramValueViewInfo; var ADone: Boolean);
    procedure BtNegritoClick(Sender: TObject);
    procedure BtItalicoClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSalvaImgClick(Sender: TObject);
    procedure BtnCarregaFiltroClick(Sender: TObject);
    procedure cxGridGraficoChartViewActiveDiagramChanged(
      Sender: TcxGridChartView; ADiagram: TcxGridChartDiagram);
    procedure Button1Click(Sender: TObject);
    procedure DBPivotGridLayoutChanged(Sender: TObject);
    procedure BtnOpcoesGraficoClick(Sender: TObject);
  private
    { Private declarations }
    Glo_Para : Integer;

    BoldLegend : Integer;

    vArSQLCampoTab  : TStringList;
    vArSQLCampoTela : TStringList;
    vArSQLObrigator : TStringList;
    vArExcel    : TStringList;
    vArResultado: TStringList;

    UpdatingPage: Boolean;
    PosicaoPanelDinamico: TPosicaoPanelDinamico;
    FDm: TDmGeradorConsultas;
    FPrimeiroShow: Boolean;
    FUltimaConfig: Integer;
    FResultDocVariant: TDocVariantData;
    FExpressionParser: TExpressionParser;
    FPivotLayoutChanged: Boolean;
    FChartController: TChartController;
    FUserMessageOption: TUserMessageOptions;
    procedure PageControlAtiva(Pagina:Integer);
    function PopulaParametrosDM: Boolean;
    function GetSeriesColorByField(AFieldName: string): Variant;
    procedure AtualizaCamposGrid;
    procedure CategoriesGetValueDisplayText(Sender: TObject;
      const AValue: Variant; var ADisplayText: string);
    procedure AumentaPanelTabela;
    procedure DiminuiPanelTabela;
    procedure MaximizaPanelTabela;
    procedure AtualizaPanelTabelaDinamica;

    function Func_ParseStyleLegendItemForTFontStyle(pBold: integer; pItalic : integer): Variant;
    function Func_LegendaNegrito: Boolean;
    function Func_LegendaItalico: Boolean;
    function Valida_Consulta: Boolean;
    function Apenas_Parametros: Boolean;
    procedure ConfiguraTipoFormulario;
    function CarregaVisualizacaoAtual: Boolean;
    procedure LoadParamsFromDic(Params: TDictionary<string, variant>);
//    procedure PopulaComboBoxQry(pComboBox: TComboBox; pQry: TDataSet; ValorPadrao: variant);
//    procedure PopulaCheckListBoxQry(pCheckListBox: TCheckListBox; pQry: TDataSet; ValorPadrao: variant);
    function GetParams: TParametros;
    class function Conn: TDmConnection; static;
    procedure AjustaPropriedadesPivoGrid;
    procedure AoCalcularFormula(Sender: TcxPivotGridField;
      ASummary: TcxPivotGridCrossCellSummary);
    procedure OnGetDisplayTextPivot(Sender: TcxPivotGridField;
      ACell: TcxPivotGridDataCellViewInfo; var AText: string);
    procedure GetFieldisplayText(const AName: String; AValue: Variant; var ADisplayText: String);
    procedure RebuildChartConf;
    function GetTituloOriginal: String;

    procedure SetColorFromSeries(ASeries: TcxGridChartSeries;
      var AColor: TColor);
    procedure UserMessage(AMessageType: TLogType; AMessage: String);
   public
    { Public declarations }
    function ExecutaConsulta: Boolean;
    function CarregaVisualizacaoByName(pNome: String): Boolean;

    function ExportaTabelaParaExcelInterno(pNomeArquivo: String;
      pMostraDialog: Boolean = False; pUsarFormatoNativo: Boolean = False): Boolean;
    function ExportaTabelaDinamica(pNomeArquivo: String): Boolean;
    function ExportaGrafico(pNomeArquivo: String): Boolean;
    function ResultAsDocVariant: Variant;
    function ResultRecordCount: Integer;
    procedure AbrirConsultaPersonalizada(Consulta :string; pExecutar: Boolean = True);

    property Params: TParametros read GetParams;
    property UserMessageOption: TUserMessageOptions read FUserMessageOption write FUserMessageOption;

    class function AbreConsultaPersonalizadaByName(NomeConsulta: String; pExecutar: Boolean = True; pWindowState: TWindowState = wsNormal; pUserMessageOption: TUserMessageOptions = umShowDialog): TFrmConsultaPersonalizada; static;
    class function AbreConsultaPersonalizada(pIDConsulta: Integer; pExecutar: Boolean = True; pUserMessageOption: TUserMessageOptions = umShowDialog): TFrmConsultaPersonalizada;
    class function ExportaTabelaParaExcel(NomeConsulta: String; pNomeArquivo: String;
                      Params: TDictionary<string, variant> = nil;
                      pTipoVisualizacao: TTipoVisualizacao = tvTabela;
                      pVisualizacao: String = ''; pUserMessageOption: TUserMessageOptions = umShowDialog): String;
  end;

procedure ExportarCxGridParaImagem(cxGridView: TcxGridChartView; pFileName: String);
procedure PopulaCheckListBoxQry(pCheckListBox: TCheckListBox; pSql: String; pValor: variant);
procedure PopulaComboBoxQry(pComboBox: TComboBox; pSql: String; ValorPadrao: variant);

implementation

uses Utils, System.UITypes, jpeg, Ladder.Activity.LadderVarToSql, Ladder.ORM.DaoUtils, Ladder.Parser, Ladder.Utils;

{$R *.dfm}

function GetDaoUtils: TDaoUtils;
begin
  Result:= TFrwServiceLocator.Context.DaoUtils;
end;

procedure PopulaComboBoxQry(pComboBox: TComboBox; pSql: String; ValorPadrao: variant);
var
  FDados: TDocVariantData;
  I: Integer;
begin
  pComboBox.Clear;
  if pSql='' then
    Exit;

  FDados:= TDocVariantData(GetDaoUtils.SelectAsDocVariant(pSql));

  for I:= 0 to FDados.Count-1 do
  begin
    if (FDados._[I].Values[0] <> null) and
       (FDados._[I].Values[1] <> null) then
         TValorChave.AdicionaComboBox(pComboBox,
                                      FDados._[I].Values[0],
                                      FDados._[I].Values[1]);

    if not VarIsNull(ValorPadrao) then
      if VarToStrDef(FDados._[I].Values[0],'') = VarToStrDef(ValorPadrao,'@!@') then
        pComboBox.ItemIndex:= pComboBox.Items.Count-1;
  end;
end;

procedure PopulaCheckListBoxQry(pCheckListBox: TCheckListBox; pSql: String; pValor: variant);
var
  FDados: TDocVariantData;
  vParamPadrao: Variant;
  I: Integer;
  FID, FValor: Variant;

  procedure MarcaValor(pValor: Variant);
  var
    X: Integer;
  begin
    for X := 0 to pCheckListBox.items.Count-1 do
      if TValorChave.ObterValorPorIndex(pCheckListBox.items, X) = Trim(pValor) then
      begin
        pCheckListBox.Checked[X]:= True;
        Break;
      end;
  end;

  procedure SetaValoresPadrao;
  var
    FValorCalc: Variant;
    I: Integer;
  begin
    if VarIsNull(pValor) then
      Exit;

 {   if not TActivityParser.TryParseExpression(VarToStrDef(pValor,''), FValorCalc, nil) then
      Exit;               }

    if DocVariantType.IsOfType(pValor) then
    begin
      for I := 0 to TDocVariantData(pValor).Count-1 do
        MarcaValor(TDocVariantData(pValor).Values[I]);
    end
   else
    if not VarIsNull(pValor) then
      MarcaValor(pValor);
  end;

begin
  pCheckListBox.Clear;
  if pSql='' then
    Exit;

  FDados:= TDocVariantData(GetDaoUtils.SelectAsDocVariant(pSql));

  for I := 0 to FDados.Count-1 do
  begin
    FID:= FDados._[I].Values[0];
    FValor:= FDados._[I].Values[1];
    if (FID <> null) and (FValor <> null) then
          TValorChave.AdicionaCheckListBox(pCheckListBox, FID, FValor);

    if not VarIsNull(vParamPadrao) then
      if FID = vParamPadrao then
        pCheckListBox.ItemIndex:= pCheckListBox.Items.Count-1;
  end;

  SetaValoresPadrao;
 {
    Result:= TDocVariantData(pList).Values[FListIndex];

  if not VarIsNull(ValorPadrao) then
    if VarIsArray(ValorPadrao) then
    begin
      for I := VarArrayLowBound(ValorPadrao ,1)  to VarArrayHighBound(ValorPadrao ,1) do
        MarcaValor(ValorPadrao[I])
    end
   else
    begin
      MarcaValor(ValorPadrao);
    end;}

end;

procedure ExportarCxGridParaImagem(cxGridView: TcxGridChartView; pFileName: String);
var
  BmpImg: TGraphic;
  ImageExport : TGraphic;

  function GetGraphic(pExt: String): TGraphic;
  var
    FExt: String;
  begin
    FExt:= Trim(UpperCase(pExt));
     if FExt = '.BMP' then
       Result:= TBitmap.Create
     else if FExt = '.PNG' then
       Result:= TPngImage.Create
     else if FExt = '.JPG' then
       Result:= TJpegImage.Create
     else
       raise Exception.Create('ExportarCxGridParaImagem: Extensão '+FExt+' não suportada!');
  end;

begin
   BmpImg := cxGridView.CreateImage(TBitmap);
   if not Assigned(BmpImg) then
     raise Exception.Create('ExportarCxGridParaImagem: Erro ao criar imagem!');
   try
     ImageExport:= GetGraphic(ExtractFileExt(pFileName));
     try
       ImageExport.Assign(BmpImg);
       ImageExport.SaveToFile(pFileName);
     finally
       ImageExport.Free;
     end;
   finally
     BmpImg.free;
   end;
end;

{  B := TBitmap.CREATE;
  try
    cxGrid.PaintTo(B.Canvas, 0, 0);
    b.SaveToFile(pFileName);
    //PaintToCanvas(b.Canvas);
    FreeAndNil(b);
  finally
  end;}
class function TFrmConsultaPersonalizada.AbreConsultaPersonalizada(pIDConsulta: Integer; pExecutar: Boolean = True; pUserMessageOption: TUserMessageOptions = umShowDialog): TFrmConsultaPersonalizada;
var
  FFrmConsulta: TFrmConsultaPersonalizada;
begin
  FFrmConsulta:= TFrmConsultaPersonalizada.Create(Application);
  FFrmConsulta.UserMessageOption:= pUserMessageOption;
  FFrmConsulta.AbrirConsultaPersonalizada(IntToStr(pIDConsulta), pExecutar);
  Result:= FFrmConsulta;
end;

class function TFrmConsultaPersonalizada.Conn: TDmConnection;
begin
  Result:= TFrwServiceLocator.Context.DmConnection;
end;

class function TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName(NomeConsulta: String; pExecutar: Boolean = True; pWindowState: TWindowState = wsNormal;
                    pUserMessageOption: TUserMessageOptions = umShowDialog): TFrmConsultaPersonalizada;
var
  FCodRelatorio: Integer;
const
  cSql = 'SELECT ID FROM cons.Consultas WHERE Nome = %s';
begin
  Result:= nil;

  FCodRelatorio:= Conn.RetornaValor(Format(cSql, [QuotedStr(NomeConsulta)]));

  if FCodRelatorio = 0 then
    raise Exception.Create(Format('TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName: Relatório "%s" não encontrado.', [NomeConsulta]));

  Result:= TFrmConsultaPersonalizada.AbreConsultaPersonalizada(FCodRelatorio, pExecutar, pUserMessageOption);
end;

procedure TFrmConsultaPersonalizada.AbrirConsultaPersonalizada(Consulta :string; pExecutar: Boolean = True);
begin
{  if not FDm.UsuarioLogadoTemPermissao(StrToIntDef(Consulta,0)) then
    Close;      }

  FDm.AbrirConsulta(StrToIntDef(Consulta,0));

  ConfiguraTipoFormulario;

  if pExecutar then
    Proc_Go_Para();

  cxGridGraficoChartView.Title.Text:= GetTituloOriginal;
end;

procedure TFrmConsultaPersonalizada.TsGraficoResize(Sender: TObject);
begin
  AtualizaPanelTabelaDinamica;
end;

procedure TFrmConsultaPersonalizada.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConsultaPersonalizada.BtnGravarClick(Sender: TObject);
begin
  PopulaParametrosDM;

  FDM.SalvarValoresParametros;

  Close;
end;

procedure TFrmConsultaPersonalizada.BtnMaximizarClick(Sender: TObject);
begin
  PosicaoPanelDinamico:= cMinimizado;

  AtualizaPanelTabelaDinamica;
end;

procedure TFrmConsultaPersonalizada.AtualizaPanelTabelaDinamica;
begin
  case PosicaoPanelDinamico of
    cMinimizado: DiminuiPanelTabela;
    cMeio: AumentaPanelTabela;
    cMaximizado: MaximizaPanelTabela;
  end;
  BtnOpcoesGrafico.Top:= 20;
  BtnOpcoesGrafico.Left:= 28;
  BtnOpcoesGrafico.BringToFront;
end;

procedure TFrmConsultaPersonalizada.MaximizaPanelTabela;
begin
  PanelTabelaDinamica.Height:= TsGrafico.Height-5-cxSplitterResultado.Height;
end;

procedure TFrmConsultaPersonalizada.AoCalcularFormula(Sender: TcxPivotGridField; ASummary: TcxPivotGridCrossCellSummary);
var
  AOwner: TCxPivotGridCrossCell;
  AColumn: TcxPivotGridGroupItem;
  FFormula: String;
  I: Integer;
  FTokenNames: TArray<String>;
  FTokenIndexes: TDictionary<String, Integer>;
  FTokenNull: TDictionary<String, Boolean>;
  FTokenValues: TDictionary<String, Double>;
  FToken: String;
  FValue: Variant;

  procedure InitializeTokens(AFormula: String);
  var
    I: Integer;
    FField: TcxPivotGridField;
  begin
    FTokenNames:= FExpressionParser.ExtractTokens(AFormula);
    for I := 0 to Length(FTokenNames)-1 do
    begin
      FField:= FindPivotFieldByFieldName(DBPivotGrid, FTokenNames[I]);
      if not Assigned(FField) then
        raise Exception.Create(Format('Field "%s" not found',[FTokenNames[I]]));

      FTokenIndexes.Add(FTokenNames[I], FField.Index);
      FTokenNull.Add(FTokenNames[I], True);
      FTokenValues.Add(FTokenNames[I], 0);
    end;
  end;
begin
  try
    AOwner:= ASummary.Owner;
    AColumn := ASummary.Owner.Column;

    if not FDm.QryCampos.Locate('NomeCampo', TcxDBPivotGridFieldDataBinding(Sender.DataBinding).FieldName, [loCaseInsensitive]) then
      Exit;

    FFormula:= FDm.QryCamposFormula.AsString;

    FTokenIndexes:= TDictionary<String, Integer>.Create;
    FTokenNull:= TDictionary<String, Boolean>.Create;
    FTokenValues:= TDictionary<String, Double>.Create;
    try
      InitializeTokens(FFormula);
      for I := 0 to AOwner.Records.Count - 1 do
        for FToken in FTokenIndexes.Keys do
        begin
          FValue:= AOwner.DataController.Values[AOwner.Records.Items[I], FTokenIndexes[FToken]];
          if FTokenNull[FToken] then
            FTokenNull[FToken]:= VarIsNull(FValue);

          FTokenValues[FToken]:= FTokenValues[FToken]+VarToFloatDef(FValue);
        end;

      for FToken in FTokenNull.Keys do
        if FTokenNull[FToken] then
        begin
          ASummary.Custom:= null;
          Exit;
        end;

      FExpressionParser.Dictionary:= FTokenValues;
      ASummary.Custom:= FExpressionParser.Evaluate(FFormula);
    finally
      FTokenIndexes.Free;
      FTokenNull.Free;
      FTokenValues.Free;
    end;
  except
    ASummary.Custom:= null;
  end;
end;

procedure TFrmConsultaPersonalizada.RebuildChartConf;
var
  I: Integer;
  FSeries: TcxGridChartSeries;
  FSeriesConf: TSeriesConf;
begin
  if not FPivotLayoutChanged then // Check this flag to execute once per change
    Exit;

  FChartController.RebuildSeriesConf(True);

  cxGridGrafico.Invalidate(True);

  FPivotLayoutChanged:= False;
end;

procedure TFrmConsultaPersonalizada.DBPivotGridLayoutChanged(Sender: TObject);
begin
  FPivotLayoutChanged:= True;
  ExecuteAsync(Self, RebuildChartConf);
end;

procedure TFrmConsultaPersonalizada.DiminuiPanelTabela;
begin
  PanelTabelaDinamica.Height:= cxSplitterResultado.MinSize;
end;

procedure TFrmConsultaPersonalizada.LoadParamsFromDic(Params: TDictionary<string, variant>);
var
  FKey: String;
begin
  if Assigned(Params) then
    for FKey in Params.Keys do
      FDm.SetParam(FKey, Params[FKey]);
end;

class function TFrmConsultaPersonalizada.ExportaTabelaParaExcel(NomeConsulta,
  pNomeArquivo: String; Params: TDictionary<string, variant>; pTipoVisualizacao: TTipoVisualizacao;
  pVisualizacao: String; pUserMessageOption: TUserMessageOptions): String;
var
  FFrmConsulta: TFrmConsultaPersonalizada;
  FKey: String;
begin
  Result:= '';

  FFrmConsulta:= TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName(NomeConsulta, True, wsNormal, pUserMessageOption);
  try
    FFrmConsulta.LoadParamsFromDic(Params);

    FFrmConsulta.ExecutaConsulta;

    // Carrega Visualização
    FFrmConsulta.CarregaVisualizacaoByName(pVisualizacao);

    case pTipoVisualizacao of
      tvTabela, tvTabelaDinamica: Result:= pNomeArquivo+'.xls';
      tvGrafico: Result:= pNomeArquivo+'.png';
    end;

    // Salvar em arquivo pelo tipo de relatório
    case pTipoVisualizacao of
      tvTabela: FFrmConsulta.ExportaTabelaParaExcelInterno(Result);
      tvTabelaDinamica: FFrmConsulta.ExportaTabelaDinamica(Result);
      tvGrafico: FFrmConsulta.ExportaGrafico(Result)
    end;

//    FFrmConsulta.ExportaTabelaParaExcelInterno(pNomeArquivo);
  finally
    FFrmConsulta.Free;
  end;
end;

procedure TFrmConsultaPersonalizada.AumentaPanelTabela;
begin
  PanelTabelaDinamica.Height:= TsGrafico.Height div 2;
end;

procedure TFrmConsultaPersonalizada.PageControlAtiva(Pagina:Integer);
begin
  PageControl.ActivePageIndex:=Pagina;

  PageControl.Pages[0].TabVisible:=False;
  PageControl.Pages[1].TabVisible:=False;
  PageControl.Pages[2].TabVisible:=False;

  PageControl.Pages[Pagina].TabVisible:=True;
end;

procedure TFrmConsultaPersonalizada.PageControlVisualizacoesChange(
  Sender: TObject);
begin
  if not UpdatingPage then
  begin
    UpdatingPage:= True;
    try
      if PageControlVisualizacoes.ActivePage = TsDinamica then
      begin
        PosicaoPanelDinamico:= cMaximizado;

        PanelTsGrafico.Parent:= TsDinamica;

        AtualizaPanelTabelaDinamica;
      end
     else if PageControlVisualizacoes.ActivePage = TsGrafico then
      begin
        PosicaoPanelDinamico:= cMinimizado;

        PanelTsGrafico.Parent:= TsGrafico;

        AtualizaPanelTabelaDinamica;
      end;
    finally
      UpdatingPage:= False;
    end;

  end;
end;

procedure TFrmConsultaPersonalizada.VOLTAR_PARAMETROSClick(Sender: TObject);
begin
  PageControlAtiva(0);
end;

function TFrmConsultaPersonalizada.ExecutaConsulta: Boolean;
var
  TIni, TFim : TDateTime;

  procedure CarregaVisualizacoes;
  begin
    QryVisualizacoes.Active := False;
    QryVisualizacoes.Params[0].Value:= FDm.QryConsultasID.AsString;
    QryVisualizacoes.Active := True;

    if QryVisualizacoes.Locate('ID', FDm.QryConsultasConfigPadrao.AsInteger, []) then
    begin
      BtnCarregaFiltro.Click;
      cbxConfiguracoes.KeyValue:= QryVisualizacoesID.AsInteger;
    end;
  end;
begin
  try
    MemoSQL.Lines.Text:= FDm.SqlOriginal;

    Result:= False;
    if FDm.GeraSqlConsulta<>'' then
    begin
      MemoSqlGerado.Lines.Text:= FDm.SqlGerado;
      TIni:=Now();

      cxGridTabelaDBTableView1.BeginUpdate;
      DBPivotGrid.BeginUpdate;
      try
        QryConsulta.Active:=False;

        if FDm.GetFonteDados = fdSqlServer then
          QryConsulta.Connection:= Conn.FDConnection
        else
          QryConsulta.Connection:= ConFirebird.FDConnection;

        QryConsulta.SQL.Text:= FDm.SqlGerado;

        QryConsulta.Active:=True;

        StatusBar1.SimpleText:= 'Sql execution time '+FormatDateTime('HH:MM:SS', Now-TIni);

        FDm.SetEstilosCamposQry(QryConsulta);
        AtualizaCamposGrid;

        TFim:=Now();

        CarregaVisualizacoes;

        case FDm.QryConsultasVisualizacaoPadrao.AsInteger of
          0: PageControlVisualizacoes.ActivePage:= TsTabela;
          1: PageControlVisualizacoes.ActivePage:= TsDinamica;
          2: PageControlVisualizacoes.ActivePage:= TsGrafico;
        end;

        PageControlVisualizacoesChange(Self);

        PageControlAtiva(2);

        LabelCount.Caption:='Total de Registros: '+InttoStr(QryConsulta.RecordCount);
        LbTime.Caption:=FormatDateTime('HH:MM:SS', TFim-TIni);

        FResultDocVariant.Clear;

        Result:= True;
      finally
        cxGridTabelaDBTableView1.EndUpdate;
        DBPivotGrid.EndUpdate;
      end;
    end
  except
    on E: Exception do
    begin
       PageControlAtiva(0);
       raise Exception.Create('Erro ao Executar a Consulta Personalizada. Erro: '+E.Message);
    end;
  end;
end;

procedure TFrmConsultaPersonalizada.IR_EXECUTANDOCONSULTAClick(Sender: TObject);
begin
    PageControlAtiva(1);
    Refresh;

    PopulaParametrosDM;
    StatusBar1.SimpleText:= 'Carregando...';
    if not ExecutaConsulta then
    begin
      StatusBar1.SimpleText:= '';
      PageControlAtiva(0);
      Application.MessageBox('Atenção: Não Foram Preenchidos Todos os Parâmetros Necessários para Executar o Cruzamento.','Atenção',MB_ICONERROR);
    end
end;

//+++++++++++++++++++++++++++++++
//    Gera Parâmtros
//+++++++++++++++++++++++++++++++


procedure TFrmConsultaPersonalizada.Proc_Gera_Para;
var
  Loc_TOP, I : Integer;

  procedure CriaParLabel;
  begin
    with TLabel.Create(ScrollBox) do
    begin
      Visible   := true;
      Left      := 8;
      Top       := Loc_TOP;
//      Width     := 97;
      Height    := 17;
      AutoSize  := True;
      Caption   := FDM.QryParametrosDescricao.Value;
      Name      := 'L'+IntToStr(FDm.QryParametrosID.Value);
      Parent    := ScrollBox;
      Font.Color:=ClBlue;

      Loc_TOP:=Loc_TOP+16;
    end;
  end;

  procedure CriaParComboBox;
  begin
    with TComboBox.Create(ScrollBox) do
    begin
      Visible   := true;
      Left      := 8;
      Top       := Loc_TOP;
      if FDm.QryParametrosTamanho.Value>0 then
        Width   := FDm.QryParametrosTamanho.Value
      else
        Width   := 97;
      Height    := 17;
      Style     := csOwnerDrawFixed;
      Name      := 'V'+IntToStr(FDm.QryParametrosID.Value);
      Parent    := ScrollBox;
      Caption   := '';

      Loc_TOP:=Loc_TOP+32;
    end;
  end;

  procedure CriaParChecklist;
  begin
    with TCheckListBox.Create(ScrollBox) do
    begin
      Visible   := true;
      Left      := 8;
      Top       := Loc_TOP;
      if FDm.QryParametrosTamanho.Value>0 then
        Width   := FDm.QryParametrosTamanho.Value
      else
        Width   := 457;
      Height    := 121;
      Name      := 'V'+IntToStr(FDm.QryParametrosID.Value);
      Parent    := ScrollBox;

      Loc_TOP:=Loc_TOP+136;
    end;
  end;

  procedure CriaParMaskEdit;
  begin
    with TMaskEdit.Create(ScrollBox) do
    begin
      Visible   := true;
      Left      := 8;
      Top       := Loc_TOP;
      if FDm.QryParametrosTamanho.Value>0 then
        Width   := FDm.QryParametrosTamanho.Value
      else
        Width   := 97;

      Height    := 17;

      Name      := 'V'+IntToStr(FDm.QryParametrosID.Value);
      Parent    := ScrollBox;
      Text      := '';

      Text      := VarToStrDef(fDm.GetParamValue(FDm.QryParametrosNome.AsString), '');

      Loc_TOP:=Loc_TOP+32;
    end;
  end;

  procedure CriaDateTimePicker;
  var
    vParamDef: Variant;
  begin
    with TDateTimePicker.Create(ScrollBox) do
    begin
      Visible   := true;
      Left      := 8;
      Top       := Loc_TOP;
      Width     := 97;
      Height    := 20;

      Name      := 'V'+IntToStr(FDm.QryParametrosID.Value);
      Parent    := ScrollBox;

      vParamDef:= fDm.GetParamValue(FDm.QryParametrosNome.AsString);
      if not VarIsNull(vParamDef) then
        Date := vParamDef
      else
        Date:= now;

      Loc_TOP:=Loc_TOP+32;
    end;
  end;

  procedure ParConfigComboSql;
  var
    pComp: TComponent;
  begin
    pComp:= ScrollBox.FindComponent('V'+IntToStr(FDm.QryParametrosID.Value));

    if FDm.QryParametrosTipo.Value=1 then
    begin
      if not (pComp is TComboBox) then
        Exit;

      PopulaComboBoxQry(TComboBox(pComp), FDm.QryParametrosSql.AsString, FDm.QryParametrosValorPadrao.Value);
    end
   else
    if FDm.QryParametrosTipo.Value=4 then
    begin
      if not (pComp is TCheckListBox) then
        Exit;

      PopulaCheckListBoxQry(TCheckListBox(pComp), FDm.QryParametrosSql.AsString, FDm.GetParamValue(FDm.QryParametrosNome.Value));
    end;
  end;

begin
  //Função Totalmente Refeita parra permitir infinitos filtros - Criado por Felipe  - 10/09/2015
  try
    vArSQLCampoTab.Clear;
    vArSQLCampoTela.Clear;
    vArSQLObrigator.Clear;
    vArExcel.Clear;
    vArResultado.Clear;

    for I := 0 to ScrollBox.ControlCount-1 do
    begin
      if (ScrollBox.Controls[I] is TComboBox) or (ScrollBox.Controls[I] is TCheckListBox) or
        (ScrollBox.Controls[I] is TMaskEdit) or (ScrollBox.Controls[I] is TDateTimePicker) then
      begin
         ScrollBox.Controls[I].Name := StringReplace(ScrollBox.Controls[I].Name,'V','X',[rfReplaceAll]);
         ScrollBox.Controls[I].Free;
      end;
    end;
  except
  end;

  //Cria parâmetros
  with FDm do
  try
    Loc_TOP:=40;

    QryParametros.First;

    while not QryParametros.Eof do
    begin
      vArSQLCampoTab.Add(QryParametrosNome.Value); //Nome do Campo para o SQL
      vArSQLCampoTela.Add('V'+IntToStr(QryParametrosID.Value));
//      vArSQLObrigator.Add((QryParametrosObrigatorio.Value)); //Verifica se é fixo o campo
      vArExcel.Add(QryParametrosDescricao.Value);          //Nome do Campo para o Excel

      CriaParLabel;

      if QryParametrosTipo.Value=1 then
        CriaParComboBox;

      if QryParametrosTipo.Value=4 then
        CriaParCheckList;

      if (QryParametrosTipo.Value=2) then
        CriaParMaskEdit;

      if (QryParametrosTipo.Value=3) then
        CriaDateTimePicker;

      if Trim(QryParametrosSql.AsString) <> '' then
        ParConfigComboSql;

      QryParametros.Next;
    end;

    ScrollBox.VertScrollBar.Position := 0;

    // Posiciona no Primeira Pârameto
    // FocaPrimeiroParametro;

  except
    on E: Exception do
      Application.MessageBox(PWideChar('Erro ao Criar os Parâmetros. Mensagem: '+E.Message),'Erro',MB_ICONERROR);
  end;
  Glo_Para:=0;
end;

//+++++++++++++++++++++++++++++++
//    Exportar Excel
//+++++++++++++++++++++++++++++++

//+++++++++++++++++++++++++++++++
//    Replace  (Cru. & Pro. =)
//+++++++++++++++++++++++++++++++
function TFrmConsultaPersonalizada.PopulaParametrosDM: Boolean;
var
  pComp: TComponent;
  I, Ret: Integer;
  FParametro: TParametroCon;
begin
  Result:= False;

  for FParametro in FDm.Params.Values do
  begin
//      FDm.QryPara.Locate('CopNome', FDm.GetParam(I).Nome, [loCaseInsensitive]);

    pComp:= ScrollBox.FindComponent('V'+IntToStr(FParametro.ID));

    if not Assigned(pComp) then continue;

    if (pComp is TComboBox) then
    begin
      FParametro.Valor:= TValorChave.ObterValor(TComboBox(pComp));
    end
   else
    if (pComp is TCheckListBox) then
    begin
      FParametro.Valor:= StrToLadderArray(TValorChave.ObterValoresSelecionados(TCheckListBox(pComp)), ',');
    end
   else
    if (pComp is TMaskEdit) then
    begin
      FParametro.Valor:= TMaskEdit(pComp).EditText;
    end
   else
    if (pComp is TDateTimePicker) then
    begin
      FParametro.Valor:= TDateTimePicker(pComp).DateTime;
    end;
  end;

  Result:= True;
end;

procedure TFrmConsultaPersonalizada.GetFieldisplayText(const AName: String; AValue: Variant; var ADisplayText: String);
var
  FDisplayMask: String;
  FVal: Double;
begin
  FDisplayMask:= '';
  if not FDm.FFieldDisplayText.TryGetValue(AName, FDisplayMask) then
    Exit;

  GetDisplayText(FDisplayMask, AValue, ADisplayText);
end;

procedure TFrmConsultaPersonalizada.OnGetDisplayTextPivot(Sender: TcxPivotGridField;
  ACell: TcxPivotGridDataCellViewInfo; var AText: string);
begin
  GetFieldisplayText(TcxDBPivotGridFieldDataBinding(Sender.DataBinding).FieldName, ACell.Value, AText);
end;

procedure TFrmConsultaPersonalizada.AjustaPropriedadesPivoGrid;
var
  I: Integer;
  FNomeCampo: String;
begin
  for I:= 0 to DBPivotGrid.FieldCount-1 do
  begin
    FNomeCampo:= TcxDBPivotGridFieldDataBinding(DBPivotGrid.Fields[i].DataBinding).FieldName;

    if FDm.QryCampos.Locate('NomeCampo', FNomeCampo, [loCaseInsensitive]) then
    begin
      case FDm.QryCamposAgrupamento.AsInteger of
        0: DBPivotGrid.Fields[i].SummaryType:= stSum; //Soma
        1: DBPivotGrid.Fields[i].SummaryType:= stAverage; //Média
        2: DBPivotGrid.Fields[i].SummaryType:= stCount; //Contagem
        3: DBPivotGrid.Fields[i].SummaryType:= stMax; //Max
        4: DBPivotGrid.Fields[i].SummaryType:= stMin; //Min
        5: DBPivotGrid.Fields[i].SummaryType:= stStdDev; //Desvio Padrão
        6: begin
            DBPivotGrid.Fields[i].SummaryType:= stCustom; //Fórmula customizada
            DBPivotGrid.Fields[i].OnCalculateCustomSummary:= AoCalcularFormula;
           end;
      end;
      DBPivotGrid.Fields[i].OnGetDisplayText:= OnGetDisplayTextPivot;
      DBPivotGrid.Fields[I].Visible:= FDm.QryCamposVisivel.AsBoolean;

    end;
//    DBPivotGrid.Fields[i].ExpandAll;
  end;
end;

procedure TFrmConsultaPersonalizada.AtualizaCamposGrid;
begin
  cxGridTabelaDBTableView1.ClearItems;
  cxGridTabelaDBTableView1.DataController.CreateAllItems();

  DBPivotGrid.DeleteAllFields;
  DBPivotGrid.CreateAllFields;

  AjustaPropriedadesPivoGrid;

  DBPivotGrid.ApplyBestFit;

  DBPivotGrid.Refresh;

//  cxPivotGridChartConnection.Refresh;
end;

procedure TFrmConsultaPersonalizada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

function TFrmConsultaPersonalizada.Valida_Consulta: Boolean;
begin
  Result:= True;

  if Apenas_Parametros then
  begin
    if FDm.QryParametros.RecordCount = 0 then
    begin
      Application.MessageBox('Tela de parametrização sem parâmetros! É Preciso Selecionar um Relatório Válido.','Gerenciador',MB_ICONERROR);
      Result:= False;
    end;
  end
 else if (Length(FDM.QryConsultasSql.Value)=0) then
  begin
    Application.MessageBox('Consulta sem SQL definido! É Preciso Selecionar um Relatório Válido.','Gerenciador',MB_ICONERROR);
    Result:= False;
  end;

end;

function TFrmConsultaPersonalizada.Apenas_Parametros: Boolean;
begin
  Result:= FDm.QryConsultasTipo.AsInteger = 2;
end;

procedure TFrmConsultaPersonalizada.ConfiguraTipoFormulario;
begin
  BtnGravar.Visible:= Apenas_Parametros;
  BtnCancelar.Visible:= Apenas_Parametros;

  IR_EXECUTANDOCONSULTA.Visible:= not Apenas_Parametros;
  TabSheetResultado.TabVisible:= not Apenas_Parametros;
  TabSheetAguarde.TabVisible:= not Apenas_Parametros;
end;

procedure TFrmConsultaPersonalizada.Proc_Go_Para;
begin
  if not Valida_Consulta then
    Abort;

  PageControlAtiva(0);
  Proc_Gera_Para();
  Glo_Para:=0;
  Self.Caption:= FDM.QryConsultasDescricao.Value;

  if (FDm.QryParametros.RecordCount = 0) and (IR_EXECUTANDOCONSULTA.CanFocus) then
    IR_EXECUTANDOCONSULTA.Click;

end;

procedure TFrmConsultaPersonalizada.BtnNovoFiltroClick(Sender: TObject);
var
  ArqIni: TCustomIniFile;
  FNomeIni, FDescricao: String;
  FTituloModificado: Boolean;
begin
  FTituloModificado:= (cxGridGraficoChartView.Title.Text <> GetTituloOriginal);
  FDescricao:= InputBox('Nova visão', 'Digite o nome da visão:', cbxConfiguracoes.Text);
  if FDescricao = '' then
    Exit;

  if QryVisualizacoes.Locate('Descricao', FDescricao, []) then
  begin
    if Application.MessageBox('Já existe uma configuração com este nome. Deseja Sobrescrever?', 'Atenção', MB_YESNO) = ID_NO then
      Exit;
  end;

  FNomeIni:= ExtractFilePath(Application.ExeName)+'temp\ConsultasConfig.ini';

  if not DirectoryExists(ExtractFilePath(FNomeIni)) then
    CreateDir(ExtractFilePath(FNomeIni));

  if FileExists(FNomeIni) then
    DeleteFile(FNomeIni);

//  cxGridTabelaDBTableView1.StoreToIniFile(FNomeIni, False, [gsoUseSummary], 'Tabela');
  DBPivotGrid.StoreToIniFile(FNomeIni, False);
  cxGridGraficoChartView.StoreToIniFile(FNomeIni, False, [gsoUseSummary], 'Grafico');

  //Gravar o tamanho da Legenda do gráfico
  ArqIni := TMemIniFile.Create(FNomeIni);

  try
    ArqIni.WriteInteger('CONFIG', 'SIZE_LEGEND_ITEM', FontSizeStyle.Font.Size);
    ArqIni.WriteBool('CONFIG', 'BOLD_LEGEND_ITEM', Func_LegendaNegrito());
    ArqIni.WriteBool('CONFIG', 'ITALIC_LEGEND_ITEM', Func_LegendaItalico());

    if FTituloModificado then
      ArqIni.WriteString('CONFIG', 'TITULO', AnsiString(cxGridGraficoChartView.Title.Text));

    ArqIni.WriteString('CONFIG', 'SERIES', FChartController.SerializeSeriesConf);
    ArqIni.UpdateFile;
  finally
    ArqIni.Free;
  end;

  if QryVisualizacoes.Locate('Descricao', FDescricao, []) then
  begin
    QryVisualizacoes.Edit;
  end
 else
  begin
    QryVisualizacoes.Insert;
//    QryConfiguracoesConUsuario.Value :=  FrmMenu.Loc_UsuarioCodigo;
    QryVisualizacoesDataHora.AsDateTime := now();
  end;

  QryVisualizacoesConsulta.Value   := FDm.QryConsultasID.Value;
  QryVisualizacoesDescricao.Value:= FDescricao;
  QryVisualizacoesArquivo.LoadFromFile(FNomeIni);
  QryVisualizacoes.Post;

  cbxConfiguracoes.KeyValue:= QryVisualizacoesID.AsInteger;

  if not FTituloModificado then
    cxGridGraficoChartView.Title.Text:= GetTituloOriginal;

end;

procedure TFrmConsultaPersonalizada.BtnOpcoesGraficoClick(Sender: TObject);
var
  FFrm: TFormPropriedadesGrafico;
begin
  FFrm:= TFormPropriedadesGrafico.Create(Self, FChartController, FontSizeStyle);
  FFrm.ShowModal;
  cxGridGraficoChartView.Invalidate(True);
end;

procedure TFrmConsultaPersonalizada.BtnSalvaImgClick(Sender: TObject);
begin
{  SaveDialog.DefaultExt:= '.png';
  SaveDialog.FileName:= FDm.QryConsultasDescricao.AsString+'.png';

  if SaveDialog.Execute then
  begin
    if PageControlVisualizacoes.ActivePage = TsTabela then
      ExportarCxGridParaBmp(cxGridTabelaDBTableView1, SaveDialog.FileName)
    else if PageControlVisualizacoes.ActivePage = TsDinamica then
      ExportarCxGridParaBmp(DBPivotGrid, SaveDialog.FileName)
    else if PageControlVisualizacoes.ActivePage = TsGrafico then
      ExportarCxGridParaBmp(cxGridChartView, SaveDialog.FileName);

    UserMessage(ltNotification, 'Arquivo Exportado com Sucesso.');
    ShellExecute(Handle, 'open', pchar(SaveDialog.FileName), nil, nil, SW_SHOW);
  end;          }
end;

procedure TFrmConsultaPersonalizada.Button1Click(Sender: TObject);
var
  sCols, sRows: String;
  I, F: Integer;
  FCol: TcxPivotGridViewDataItem;

  function PrintColumn(AColumn: TcxPivotGridViewDataItem): String;
  begin
    Result:= TcxDBPivotGridField(AColumn.Field).DataBinding.FieldName
              +','+IntToStr(AColumn.Level)+','
              +IntToStr(AColumn.ItemCount)+','
              +GetViewDataItemFullName(AColumn)+','+
              sLineBreak;
  end;

  function PrintRow(ARow: TcxPivotGridViewDataItem): String;
  begin
    Result:= TcxDBPivotGridField(ARow.Field).DataBinding.FieldName
              +','+IntToStr(ARow.Level)+','
              +IntToStr(ARow.ItemCount)+','
              +ARow.GroupItem.Parent.DisplayText+
              ARow.GetDisplayText+
              sLineBreak;
  end;

  function PrintGroupItem(AGroup: TcxPivotGridGroupItem): String;
    function GetFullGroupName(AGroup: TcxPivotGridGroupItem): String;
    var
      FParent: TcxPivotGridGroupItem;
    begin
      Result:= AGroup.DisplayText;

      FParent:= AGroup.Parent;
      while Assigned(FParent) do
      begin
        Result:= FParent.DisplayText+' - '+Result;
        FParent:= FParent.Parent;
      end;

    end;
  begin
    Result:= '';
    if not Assigned(AGroup.Field) then
      Exit;

    Result:= TcxDBPivotGridField(AGroup.Field).DataBinding.FieldName
              +','+IntToStr(AGroup.Level)+','
              +IntToStr(AGroup.ItemCount)+','
              +GetFullGroupName(AGroup)+
              sLineBreak;
  end;
var
  FCell: TcxPivotGridCrossCellSummary;
begin
  Exit;

  sRows:= '';
  sCols:= '';

  if DBPivotGrid.ViewData.RowCount=0 then
    Exit;

  for I := 0 to DBPivotGrid.ViewData.ColumnCount-1 do
  begin
    if (DBPivotGrid.ViewData.Columns[I].IsGrandTotal) or (DBPivotGrid.ViewData.Columns[I].IsTotalItem) then
      Continue;

    sCols:= sCols+PrintColumn(DBPivotGrid.ViewData.Columns[I]);

//    DBPivotGrid.ViewData.Cells.
//
//    FCell:= DBPivotGrid.ViewData.Cells[0,I];
//    sCols:= sCols+PrintGroupItem(FCell.Owner.Column)+';';
//    sCols:= sCols+FCell.Owner.Column.Parent.DisplayText;
//    sCols:= sCols+;
  end;

//    sRows:= sRows+ PrintRow(DBPivotGrid.ViewData.Rows[I]);

//  ShowMessage(sCols);
{  sCols:= '';
  I:= 0;

  for I := 0 to DBPivotGrid.FieldCount-1 do
    sCols:= sCols+ TcxDBPivotGridField(DBPivotGrid.Fields[I]).DataBinding.DBField.FieldName+sLinebreak;

  ShowMessage('Series: '+IntToStr(cxGridGraficoChartView.SeriesCount)+sLineBreak
             +'Columns'+IntToStr(I)+sLineBreak+sCols);}
end;

procedure TFrmConsultaPersonalizada.BtNegritoClick(Sender: TObject);
begin

  if ((fsBold in FontSizeStyle.Font.Style) and (fsItalic in FontSizeStyle.Font.Style)) then
  begin
   FontSizeStyle.Font.Style := [fsItalic];
   exit;
  end;

  if fsBold in FontSizeStyle.Font.Style  then
    begin
       FontSizeStyle.Font.Style := [];
       exit;
    end;

  if (fsItalic in FontSizeStyle.Font.Style)  then
  begin
    FontSizeStyle.Font.Style :=  [fsItalic , fsBold ];
  end
  else
    FontSizeStyle.Font.Style :=  [fsBold];

end;

procedure TFrmConsultaPersonalizada.BtItalicoClick(Sender: TObject);
begin

  if ((fsItalic in FontSizeStyle.Font.Style) and (fsBold in FontSizeStyle.Font.Style)) then
  begin
    FontSizeStyle.Font.Style := [fsBold];
    exit;
  end;

  if fsItalic in FontSizeStyle.Font.Style  then
  begin
     FontSizeStyle.Font.Style := [];
     exit;
  end;

  if (fsBold in FontSizeStyle.Font.Style)  then
  begin
    FontSizeStyle.Font.Style :=  [fsItalic , fsBold ];
  end
  else
    FontSizeStyle.Font.Style :=  [fsItalic];

end;


procedure TFrmConsultaPersonalizada.Proc_Atualiza_LegenItem(pSize: Integer; pBold : Boolean; pItalic : Boolean);
begin
  FontSizeStyle.Font.Size := pSize;

  FontSizeStyle.Font.Style:= [];

 if pBold then FontSizeStyle.Font.Style := FontSizeStyle.Font.Style+[fsBold];
 if pItalic then FontSizeStyle.Font.Style := FontSizeStyle.Font.Style+[fsItalic];
end;

//Parse do Style do CharGrid para o Arquivo INI;
function TFrmConsultaPersonalizada.Func_LegendaNegrito: Boolean;
var
 fFont : TFont;
begin
 fFont := FontSizeStyle.Font;
 Result := (fsBold in fFont.Style );
end;

function TFrmConsultaPersonalizada.Func_LegendaItalico: Boolean;
var
 fFont : TFont;
begin

 fFont := FontSizeStyle.Font;
 Result := (fsItalic in fFont.Style );
end;


function TFrmConsultaPersonalizada.Func_ParseStyleLegendItemForTFontStyle(pBold, pItalic: integer): Variant;
begin
  if pBold = 1 then
  begin
      FontSizeStyle.Font.Style := [fsBold];
  end
  else
      if pBold = 0 then
      FontSizeStyle.Font.Style := [];
end;

function TFrmConsultaPersonalizada.GetParams: TParametros;
begin
  Result:= FDm.Params;
end;

function TFrmConsultaPersonalizada.GetSeriesColorByField(
  AFieldName: string): Variant;
begin

end;

procedure TFrmConsultaPersonalizada.BtnDeleteConfiguracaoClick(
  Sender: TObject);
begin
  if QryVisualizacoesDescricao.AsString = '' then
    Exit;

  if Application.MessageBox('Deseja excluir esta Configuração?', 'Atenção', MB_YESNO) = ID_NO then
    Exit;

  QryVisualizacoes.Delete;
end;

procedure TFrmConsultaPersonalizada.BtnDiminuirClick(Sender: TObject);
begin
  PosicaoPanelDinamico:= cMaximizado;

  AtualizaPanelTabelaDinamica;
end;

procedure TFrmConsultaPersonalizada.BtnMeioClick(Sender: TObject);
begin
  PosicaoPanelDinamico:= cMeio;

  AtualizaPanelTabelaDinamica;
end;

procedure TFrmConsultaPersonalizada.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

function TFrmConsultaPersonalizada.GetTituloOriginal: String;
begin
  Result:= FDM.QryConsultasDescricao.AsString+' - '+QryVisualizacoesDescricao.AsString;
end;

procedure TFrmConsultaPersonalizada.BtnCarregaFiltroClick(Sender: TObject);
begin
  CarregaVisualizacaoAtual;
end;

function TFrmConsultaPersonalizada.CarregaVisualizacaoByName(pNome: String): Boolean;
begin
  Result:= QryVisualizacoes.Locate('Descricao', pNome, [loCaseInsensitive]);

  if Result then
    Result:= CarregaVisualizacaoAtual;
end;

procedure TFrmConsultaPersonalizada.CategoriesGetValueDisplayText(
  Sender: TObject; const AValue: Variant; var ADisplayText: string);
begin

end;

function TFrmConsultaPersonalizada.CarregaVisualizacaoAtual: Boolean;
var
  FNomeIni: String;
  i  : integer;
  Bold, Italic : Boolean;

  procedure CarregaConfGrafico(ANomeIni: String);
  var
    ArqIni: TCustomIniFile;
  begin
//    FChartController.RebuildSeriesConf(False);
    cxGridGraficoChartView.RestoreFromIniFile(FNomeIni, False, False, [gsoUseSummary], 'Grafico');
    ArqIni := TMemIniFile.Create(ANomeIni);
    try
      FontSizeStyle.Font.Size := ArqIni.ReadInteger('CONFIG', 'SIZE_LEGEND_ITEM',10);
      Bold := ArqIni.ReadBool('CONFIG', 'BOLD_LEGEND_ITEM',false);
      Italic := ArqIni.ReadBool('CONFIG', 'ITALIC_LEGEND_ITEM',false);
      cxGridGraficoChartView.Title.Text:= ArqIni.ReadString('CONFIG', 'TITULO', GetTituloOriginal);
      FChartController.UnserializeConf(ArqIni.ReadString('CONFIG', 'SERIES',''), False);
      FChartController.RebuildSeriesConf(True); // Rebuild the series that are not loaded from the Ini File
    finally
      ArqIni.Free;
    end;
    Proc_Atualiza_LegenItem(FontSizeStyle.Font.Size, Bold, Italic );
  end;

begin
  try
    cxGridGraficoChartView.BeginUpdate;  // É fazer o Begin Update no ChartView e depois no DBPivotGrid
    try
      DBPivotGrid.BeginUpdate;
      try
        Result:= False;

        AtualizaCamposGrid;

        FUltimaConfig:= QryVisualizacoesID.AsInteger;

        FNomeIni:= ExtractFilePath(Application.ExeName)+'temp\ConsultasConfig.ini';

        if not DirectoryExists(ExtractFilePath(FNomeIni)) then
          CreateDir(ExtractFilePath(FNomeIni));

        if FileExists(FNomeIni) then
          DeleteFile(FNomeIni);

        QryVisualizacoesArquivo.SaveToFile(FNomeIni);

    //  cxGridTabelaDBTableView1.RestoreFromIniFile(FNomeIni, False, False, [gsoUseSummary], 'Tabela');

        DBPivotGrid.RestoreFromIniFile(FNomeIni, False);

        AjustaPropriedadesPivoGrid;
    {      for I := 0 to DBPivotGrid.FieldCount - 1 do
            DBPivotGrid.Fields[I].ExpandAll;    }

        Result:= True;
      finally
        DBPivotGrid.EndUpdate;
      end;
      CarregaConfGrafico(FNomeIni);
    finally
      cxGridGraficoChartView.EndUpdate;
    end;
  except
    //TODO: Log error;
  end;
end;

procedure TFrmConsultaPersonalizada.QryConfiguracoesBeforeOpen(
  DataSet: TDataSet);
begin
  cbxConfiguracoes.KeyValue:= QryVisualizacoesID.AsInteger;
end;

procedure TFrmConsultaPersonalizada.QryConfiguracoesBeforeDelete(
  DataSet: TDataSet);
begin
  cbxConfiguracoes.KeyValue:= QryVisualizacoesID.AsInteger;
end;

procedure TFrmConsultaPersonalizada.QryConfiguracoesBeforePost(
  DataSet: TDataSet);
begin
  cbxConfiguracoes.KeyValue:= QryVisualizacoesID.AsInteger;
end;


function TFrmConsultaPersonalizada.ResultAsDocVariant: Variant;
begin
  FResultDocVariant:= TLadderVarToSql.DataSetToDocVariant(QryConsulta, True);

  Result:= Variant(FResultDocVariant);
end;

function TFrmConsultaPersonalizada.ResultRecordCount: Integer;
begin
  Result:= 0;
  if QryConsulta.Active then
    Result:= QryConsulta.RecordCount;
end;

procedure TFrmConsultaPersonalizada.FormCreate(Sender: TObject);
begin
  UpdatingPage:= False;
  FPrimeiroShow:= True;
  FUserMessageOption:= umShowDialog;

  FUltimaConfig:= 0;

  FDm:= TDmGeradorConsultas.Create(Self, TFrwServiceLocator.Context.DmConnection);

  QryConsulta.Connection:= Conn.FDConnection;
  QryVisualizacoes.Connection:= Conn.FDConnection;

  PageControlAtiva(0);

  Glo_Para:=0;

  vArSQLCampoTab  := TStringList.Create;
  vArSQLCampoTela := TStringList.Create;
  vArSQLObrigator := TStringList.Create;
  vArExcel        := TStringList.Create;
  vArResultado    := TStringList.Create;

  FExpressionParser:= TExpressionParser.Create;
  FExpressionParser.TokenUpperCase:= True;
//  Self.BorderStyle:= bsSizeable;

  FChartController:= TChartController.Create(Self, cxPivotGridChartConnection, FDm);
end;

procedure TFrmConsultaPersonalizada.FormDestroy(Sender: TObject);
begin
  FDm.Free;
  FExpressionParser.Free;
  vArSQLCampoTela.Free;
  vArSQLCampoTab.Free;
  vArSQLObrigator.Free;
  vArExcel.Free;
  vArResultado.Free;

  FChartController.Free;
end;

procedure TFrmConsultaPersonalizada.FormShow(Sender: TObject);

  procedure FocaPrimeiroParametro;
  var
    X: Integer;
  begin
    if FDm.QryParametros.RecordCount>0 then
      for X := 0 to ScrollBox.ControlCount-1 do
       if (ScrollBox.Controls[x] is TComboBox) or
          (ScrollBox.Controls[x] is TCheckListBox) or
          (ScrollBox.Controls[x] is TMaskEdit) then
          if TWinControl(ScrollBox.Controls[x]).CanFocus then
          begin
            TWinControl(ScrollBox.Controls[x]).SetFocus;
            break;
          end;
  end;

begin
  if FPrimeiroShow then
  begin
    FocaPrimeiroParametro;
    FPrimeiroShow:= False;
  end;
end;

function TFrmConsultaPersonalizada.ExportaTabelaDinamica(pNomeArquivo: String): Boolean;
begin
  Result:= True;
  cxExportPivotGridToExcel(pNomeArquivo, DBPivotGrid);
end;

function TFrmConsultaPersonalizada.ExportaGrafico(pNomeArquivo: String): boolean;
var
  FForm: TForm;
  FParent: TWinControl;
begin
  Result:= True;

  // Dummy form para redimensionar grid;
  FForm:= TForm.Create(Self);
  FForm.Width:= 1280;
  FForm.Height:= 720;
  FForm.WindowState:= wsMinimized;
  FForm.Show;
  try
    FParent:= cxGridGrafico.Parent;
    cxGridGrafico.Parent:= FForm;
    try
      ExportarCxGridParaImagem(cxGridGraficoChartView, pNomeArquivo);
    finally
      cxGridGrafico.Parent:= FParent;
    end;
  finally
    FForm.Free;
  end;
end;

procedure TFrmConsultaPersonalizada.UserMessage(AMessageType: TLogType; AMessage: String);
begin
  case UserMessageOption of
    umShowDialog: ShowMessage(AMessage);
    umLogMessages: TFrwServiceLocator.Logger.LogEvent(AMessageType, AMessage);
    umShowAndLogMessages: begin
      TFrwServiceLocator.Logger.LogEvent(AMessageType, AMessage);
      ShowMessage(AMessage);
    end;
  end;

end;

function TFrmConsultaPersonalizada.ExportaTabelaParaExcelInterno(pNomeArquivo: String; pMostraDialog: Boolean = False; pUsarFormatoNativo: Boolean = False): Boolean;
begin
  Result:= False;

  if cxGridTabelaDBTableView1.DataController.FilteredRecordCount > 65000 then
  begin
    if pMostraDialog then
      UserMessage(ltError, 'Não é possível exportar mais de 65000 linhas para o excel! Faça um filtro e tente novamente.');

    Exit;
  end;

  ExportGridToExcel(pNomeArquivo, cxGridTabela, True, True, pUsarFormatoNativo, 'xls');
  Result:= True;
end;

procedure TFrmConsultaPersonalizada.BtnExcelcxGridTarefaClick(
  Sender: TObject);
begin
  if PageControlVisualizacoes.ActivePage = TsTabela then
  begin
    SaveDialog.DefaultExt:= '.xls';
    SaveDialog.FileName:= FDm.QryConsultasDescricao.AsString+'.xls';
    if SaveDialog.Execute then
    begin
      if ExportaTabelaParaExcelInterno(SaveDialog.FileName, True, CbxFormatoNativo.Checked) then
      begin
        UserMessage(ltNotification, 'Arquivo Exportado com Sucesso.');
        ShellExecute(Handle, 'open', pchar(SaveDialog.FileName), nil, nil, SW_SHOW);
      end;
    end;
  end
 else
  if PageControlVisualizacoes.ActivePage = TsDinamica then
  begin
    SaveDialog.DefaultExt:= '.xls';
    SaveDialog.FileName:= FDm.QryConsultasDescricao.AsString+'.xls';
    if SaveDialog.Execute then
      begin
        ExportaTabelaDinamica(SaveDialog.FileName);
        UserMessage(ltNotification, 'Arquivo Exportado com Sucesso.');
        ShellExecute(Handle, 'open', pchar(SaveDialog.FileName), nil, nil, SW_SHOW);
      end;
  end
 else
  if PageControlVisualizacoes.ActivePage = TsGrafico then
  begin
    SaveDialog.DefaultExt:= '.png';
    SaveDialog.FileName:= FDm.QryConsultasDescricao.AsString+'.png';
    if SaveDialog.Execute then
      begin
        ExportaGrafico(SaveDialog.FileName);
        UserMessage(ltNotification, 'Arquivo Exportado com Sucesso.');
        ShellExecute(Handle, 'open', pchar(SaveDialog.FileName), nil, nil, SW_SHOW);
      end;
  end;

//  SaveDialog.FileName:= FDm.QryConsultaPersonalizadaConDesc.AsString+'.xls';    
//  Proc_cxChart_Para_Bmp();
end;

procedure TFrmConsultaPersonalizada.Timer1Timer(Sender: TObject);
begin
  try
    if Self.BorderStyle <>  bsNone then
      Self.BorderStyle:= bsSizeable;

    Timer1.Enabled:= False;
  except
  end;
end;

procedure TFrmConsultaPersonalizada.cxGridChartViewCategoriesGetValueDisplayText(
  Sender: TObject; const AValue: Variant; var ADisplayText: string);
begin
  ADisplayText:= StringReplace(ADisplayText, 'Grand Total - ', '', [rfIgnoreCase]);
end;

procedure TFrmConsultaPersonalizada.cxGridGraficoChartViewActiveDiagramChanged(
  Sender: TcxGridChartView; ADiagram: TcxGridChartDiagram);
begin
  ADiagram.Legend.Position := cppBottom;
end;

procedure TFrmConsultaPersonalizada.SetColorFromSeries(ASeries: TcxGridChartSeries; var AColor: TColor);
var
  FColor: TColor;
  FSeriesConf: TSeriesConf;
begin
  FSeriesConf:= FChartController.GetSeriesConf(ASeries);
  if not Assigned(FSeriesConf) then
    Exit;

  if FSeriesConf.Color <> clNone then
    AColor:= FSeriesConf.Color;
end;

procedure TFrmConsultaPersonalizada.cxChangeLegendColorCustomDrawLegendItem(
  Sender: TcxGridChartDiagram; ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartLegendItemViewInfo; var ADone: Boolean);
begin
  SetColorFromSeries(AViewInfo.Series, AViewInfo.LegendKeyParams.Color);
end;

procedure TFrmConsultaPersonalizada.cxChangeSectionColorCustomDrawValue(
  Sender: TcxGridChartDiagram; ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartDiagramValueViewInfo; var ADone: Boolean);
var
  FColor: TColor;
begin
  SetColorFromSeries(AViewInfo.Series, AViewInfo.CaptionViewInfo.Params.TextColor);
  FColor:= AViewInfo.CaptionViewInfo.Params.TextColor;
  SetColorFromSeries(AViewInfo.Series, FColor);
  Acanvas.Brush.Color:= FColor;
end;

procedure TFrmConsultaPersonalizada.cbxConfiguracoesClick(Sender: TObject);
begin
  if FUltimaConfig <> QryVisualizacoesID.AsInteger then
    BtnCarregaFiltro.Click;
end;


end.
