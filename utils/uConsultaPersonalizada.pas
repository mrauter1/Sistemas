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
  FireDAC.Comp.Client, uConFirebird, System.Generics.Collections, Vcl.Imaging.pngImage;

type
  TPosicaoPanelDinamico = (cMinimizado, cMeio, cMaximizado);

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
    cxGridGrafico: TcxGrid;
    cxGridGraficoChartView: TcxGridChartView;
    cxGridGraficoLevel: TcxGridLevel;
    PanelTabelaDinamica: TPanel;
    DBPivotGrid: TcxDBPivotGrid;
    PanelControlesGrafico: TPanel;
    BtnDiminuir: TSpeedButton;
    BtnMaximizar: TSpeedButton;
    BtnMeio: TSpeedButton;
    cxSplitterResultado: TcxSplitter;
    FontSizeStyle: TcxStyle;
    PnFont: TPanel;
    Button4: TButton;
    Button3: TButton;
    Label3: TLabel;
    cbTamFonteGrafico: TComboBox;
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
    procedure Button1Click(Sender: TObject);
    procedure BtnExcelcxGridTarefaClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure cxPivotGridChartConnectionGetSeriesDisplayText(
      Sender: TcxPivotGridChartConnection; ASeries: TcxGridChartSeries;
      var ADisplayText: String);
    procedure cbxConfiguracoesClick(Sender: TObject);
    procedure cxGridGraficoChartViewCustomDrawLegendItem(Sender: TcxGridChartView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridChartLegendItemViewInfo;
      var ADone: Boolean);
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
    procedure cbTamFonteGraficoClick(Sender: TObject);
    procedure BtNegritoClick(Sender: TObject);
    procedure BtItalicoClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSalvaImgClick(Sender: TObject);
    procedure BtnCarregaFiltroClick(Sender: TObject);
    procedure cxGridGraficoChartViewActiveDiagramChanged(
      Sender: TcxGridChartView; ADiagram: TcxGridChartDiagram);

  private
    { Private declarations }
    UpdatingPage: Boolean;
    PosicaoPanelDinamico: TPosicaoPanelDinamico;
    FDm: TDmGeradorConsultas;
    FPrimeiroShow: Boolean;
    FUltimaConfig: Integer;
    procedure PageControlAtiva(Pagina:Integer);
    function PopulaParametrosDM: Boolean;
    function Func_GetColorChartView(pAViewInfoDesc: string): Variant;
    procedure AtualizaCamposGrid;
    procedure CategoriesGetValueDisplayText(Sender: TObject;
      const AValue: Variant; var ADisplayText: string);
    procedure AumentaPanelTabela;
    procedure DiminuiPanelTabela;
    procedure MaximizaPanelTabela;
    procedure AtualizaPanelTabelaDinamica;
    function PegaCorDoGrid(pSeries: TcxGridChartSeries;
      pCorBase: TColor): TColor;

    function Func_ParseStyleLegendItemForTFontStyle(pBold: integer; pItalic : integer): Variant;
    function Func_LegendaNegrito: Boolean;
    function Func_LegendaItalico: Boolean;
    function Valida_Consulta: Boolean;
    function Apenas_Parametros: Boolean;
    procedure ConfiguraTipoFormulario;
    function ExportaTabelaParaExcelInterno(pNomeArquivo: String;
      pMostraDialog: Boolean = False; pUsarFormatoNativo: Boolean = False): Boolean;
    function ExecutaConsulta: Boolean;
    function CarregaVisualizacaoAtual: Boolean;
    function CarregaVisualizacaoByName(pNome: String): Boolean;
    function ExportaTabelaDinamica(pNomeArquivo: String): Boolean;
    function ExportaGrafico(pNomeArquivo: String): Boolean;
    procedure AtualizaTitulo;
  public
    { Public declarations }
    procedure PopulaComboBoxQry(pComboBox: TComboBox; pQry: TDataSet; ValorPadrao: variant);
    procedure PopulaCheckListBoxQry(pCheckListBox: TCheckListBox; pQry: TDataSet; ValorPadrao: variant);
    procedure AbrirConsultaPersonalizada(Consulta :string);
    class function AbreConsultaPersonalizadaByName(NomeConsulta: String; pWindowState: TWindowState = wsNormal): TFrmConsultaPersonalizada; static;
    class function AbreConsultaPersonalizada(pIDConsulta: Integer): TFrmConsultaPersonalizada;
    class function ExportaTabelaParaExcel(NomeConsulta: String; pNomeArquivo: String;
                      Params: TDictionary<string, variant> = nil;
                      pTipoVisualizacao: TTipoVisualizacao = tvTabela;
                      pVisualizacao: String = ''): String;
  end;

var
  FrmConsultaPersonalizada: TFrmConsultaPersonalizada;
  Glo_Para : Integer;

  SizeLegend : Integer;
  BoldLegend : Integer;

  vArSQLCampoTab  : TStringList;
  vArSQLCampoTela : TStringList;
  vArSQLObrigator : TStringList;
  vArExcel    : TStringList;
  vArResultado: TStringList;

procedure ExportarCxGridParaImagem(cxGridView: TcxGridChartView; pFileName: String);

implementation

uses Utils, System.UITypes, jpeg;

{$R *.dfm}

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

{  B := TBitmap.CREATE;
  try
    cxGrid.PaintTo(B.Canvas, 0, 0);
    b.SaveToFile(pFileName);
    //PaintToCanvas(b.Canvas);
    FreeAndNil(b);
  finally
  end;}
end;

class function TFrmConsultaPersonalizada.AbreConsultaPersonalizada(pIDConsulta: Integer): TFrmConsultaPersonalizada;
var
  FFrmConsulta: TFrmConsultaPersonalizada;
begin
  FFrmConsulta:= TFrmConsultaPersonalizada.Create(Application);
  FFrmConsulta.AbrirConsultaPersonalizada(IntToStr(pIDConsulta));
  Result:= FFrmConsulta;
end;

class function TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName(NomeConsulta: String; pWindowState: TWindowState = wsNormal): TFrmConsultaPersonalizada;
var
  FCodRelatorio: Integer;
const
  cSql = 'SELECT ID FROM cons.Consultas WHERE Nome = %s';
begin
  Result:= nil;

  FCodRelatorio:= ConSqlServer.RetornaValor(Format(cSql, [QuotedStr(NomeConsulta)]));

  if FCodRelatorio = 0 then
  begin
    ShowMessage('Relatório '+NomeConsulta+' não encontrado!');
    Exit;
  end;

  Result:= TFrmConsultaPersonalizada.AbreConsultaPersonalizada(FCodRelatorio);
end;

procedure TFrmConsultaPersonalizada.AbrirConsultaPersonalizada(Consulta :string);
begin
{  if not FDm.UsuarioLogadoTemPermissao(StrToIntDef(Consulta,0)) then
    Close;      }

  FDm.AbrirConsulta(StrToIntDef(Consulta,0));

  ConfiguraTipoFormulario;

  Proc_Go_Para();

  AtualizaTitulo;
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
end;

procedure TFrmConsultaPersonalizada.MaximizaPanelTabela;
begin
  PanelTabelaDinamica.Height:= TsGrafico.Height-5-cxSplitterResultado.Height;
end;

procedure TFrmConsultaPersonalizada.DiminuiPanelTabela;
begin
  PanelTabelaDinamica.Height:= cxSplitterResultado.MinSize;
end;

class function TFrmConsultaPersonalizada.ExportaTabelaParaExcel(NomeConsulta,
  pNomeArquivo: String; Params: TDictionary<string, variant>; pTipoVisualizacao: TTipoVisualizacao;
  pVisualizacao: String): String;
var
  FFrmConsulta: TFrmConsultaPersonalizada;
  FKey: String;
begin
  Result:= '';

  FFrmConsulta:= TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName(NomeConsulta);
  try

    if Assigned(Params) then
      for FKey in Params.Keys do
        FFrmConsulta.FDm.SetParam(FKey, Params[FKey]);

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
      QryConsulta.Active:=False;

      if FDm.GetFonteDados = fdSqlServer then
        QryConsulta.Connection:= ConSqlServer.FDConnection
      else
        QryConsulta.Connection:= ConFirebird.FDConnection;

      QryConsulta.SQL.Text:= FDm.SqlGerado;
      QryConsulta.Active:=True;

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

      Result:= True;
    end
  except
    on E: Exception do
    begin
       PageControlAtiva(0);
       ShowMessage('Erro ao Executar a Consulta Personalizada. Erro: '+E.Message);
    end;
  end;
end;

procedure TFrmConsultaPersonalizada.IR_EXECUTANDOCONSULTAClick(Sender: TObject);
begin
    PageControlAtiva(1);
    Refresh;

    PopulaParametrosDM;
    if not ExecutaConsulta then
    begin
      PageControlAtiva(0);
      Application.MessageBox('Atenção: Não Foram Preenchidos Todos os Parâmetros Necessários para Executar o Cruzamento.','Atenção',MB_ICONERROR);
    end
end;

procedure TFrmConsultaPersonalizada.PopulaComboBoxQry(pComboBox: TComboBox; pQry: TDataSet; ValorPadrao: variant);
begin
  pComboBox.Clear;

  pQry.First;
  while not pQry.eof do
  begin
    if (pQry.Fields[0].Value <> null) and
       (pQry.Fields[1].Value <> null) then
         TValorChave.AdicionaComboBox(pComboBox,
                                      pQry.Fields[0].Value,
                                      pQry.Fields[1].Value);

    if not VarIsNull(ValorPadrao) then
      if pQry.Fields[0].Value = ValorPadrao then
        pComboBox.ItemIndex:= pComboBox.Items.Count-1;

    pQry.next;
  end;
end;                                  

procedure TFrmConsultaPersonalizada.PopulaCheckListBoxQry(pCheckListBox: TCheckListBox; pQry: TDataSet; ValorPadrao: variant);
var
  vParamPadrao: Variant;
  I: Integer;

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
begin
  pCheckListBox.Clear;

  pQry.First;
  while not pQry.eof do
  begin
    if (pQry.Fields[0].Value <> null) and
       (pQry.Fields[1].Value <> null) then
          TValorChave.AdicionaCheckListBox(pCheckListBox,
                                     pQry.Fields[0].Value,
                                     pQry.Fields[1].Value);

    if not VarIsNull(vParamPadrao) then
      if pQry.Fields[0].Value = vParamPadrao then
        pCheckListBox.ItemIndex:= pCheckListBox.Items.Count-1;

    pQry.next;
  end;

  if not VarIsNull(ValorPadrao) then
    if VarIsArray(ValorPadrao) then
    begin
      for I := VarArrayLowBound(ValorPadrao ,1)  to VarArrayHighBound(ValorPadrao ,1) do
        MarcaValor(ValorPadrao[I])
    end
   else
    begin
      MarcaValor(ValorPadrao);
    end;

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
    FQry: TDataSet;
  begin
    FQry:= ConSqlServer.CriaFDQuery(FDm.QryParametrosSql.Value, ScrollBox);
    try
//      FDm.ProcSubstVarSistema(FSql);
      FQry.Active:=True;

      pComp:= ScrollBox.FindComponent('V'+IntToStr(FDm.QryParametrosID.Value));

      if FDm.QryParametrosTipo.Value=1 then
      begin
        if not (pComp is TComboBox) then
          Exit;

        PopulaComboBoxQry(TComboBox(pComp), FQry, FDm.QryParametrosValorPadrao.Value);
      end
     else
      if FDm.QryParametrosTipo.Value=4 then
      begin
        if not (pComp is TCheckListBox) then
          Exit;

        PopulaCheckListBoxQry(TCheckListBox(pComp), FQry, FDm.GetParamValue(FDm.QryParametrosNome.Value));
      end;
    finally
      FQry.Free;
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

      if not Trim(QryParametrosSql.AsString).IsEmpty then
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
begin

  Result:= False;

  for I:= 0 to FDm.ParamCount - 1 do
  begin
//      FDm.QryPara.Locate('CopNome', FDm.GetParam(I).Nome, [loCaseInsensitive]);

    pComp:= ScrollBox.FindComponent('V'+IntToStr(FDm.GetParam(I).Codigo));

    if not Assigned(pComp) then continue;

    if (pComp is TComboBox) then
    begin
      FDm.GetParam(I).Valor:= TValorChave.ObterValor(TComboBox(pComp));
    end
   else
    if (pComp is TCheckListBox) then
    begin
      FDm.GetParam(I).Valor:= StringToVarArray(',', TValorChave.ObterValoresSelecionados(TCheckListBox(pComp)));
    end
   else
    if (pComp is TMaskEdit) then
    begin
      FDm.GetParam(I).Valor:= TMaskEdit(pComp).EditText;
    end
   else
    if (pComp is TDateTimePicker) then
    begin
      FDm.GetParam(I).Valor:= TDateTimePicker(pComp).DateTime;
    end;
  end;

  Result:= True;
end;

procedure TFrmConsultaPersonalizada.AtualizaCamposGrid;

  procedure AjustaPropriedadesPivoGrid;
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
        end;
      end;
    //  ShowMessage(TcxDBPivotGridFieldDataBinding(DBPivotGrid.Fields[i].DataBinding).FieldName);
      DBPivotGrid.Fields[i].ExpandAll;
    end;
  end;

begin
  cxGridTabelaDBTableView1.ClearItems;
  cxGridTabelaDBTableView1.DataController.CreateAllItems();

  DBPivotGrid.DeleteAllFields;
  DBPivotGrid.CreateAllFields;

  AjustaPropriedadesPivoGrid;

  DBPivotGrid.Refresh;  

  cxPivotGridChartConnection.Refresh;

 { for I:= 0 to DBPivotGrid.FieldCount-1 do
  begin
    if TcxDBPivotGridFieldDataBinding(DBPivotGrid.Fields[i].DataBinding).FieldName = 'ValorPonto' then
      DBPivotGrid.Fields[i].DisplayFormat:= '#,##0.00';
  //  ShowMessage(TcxDBPivotGridFieldDataBinding(DBPivotGrid.Fields[i].DataBinding).FieldName);
  end;             }

end;

procedure TFrmConsultaPersonalizada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  FrmConsultaPersonalizada := nil;
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
  ArqIni: TIniFile;
  FNomeIni, FDescricao: String;
begin

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
  ArqIni := TIniFile.Create(FNomeIni);

  try
    ArqIni.WriteInteger('CONFIG', 'SIZE_LEGEND_ITEM', SizeLegend);
    ArqIni.WriteBool('CONFIG', 'BOLD_LEGEND_ITEM', Func_LegendaNegrito());
    ArqIni.WriteBool('CONFIG', 'ITALIC_LEGEND_ITEM', Func_LegendaItalico());

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

    showmessage('Arquivo Exportado com Sucesso.');
    ShellExecute(Handle, 'open', pchar(SaveDialog.FileName), nil, nil, SW_SHOW);
  end;          }
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
  cbTamFonteGrafico.Text :=  IntToStr(pSize);

 if pBold then FontSizeStyle.Font.Style := [fsBold];
 if pItalic then FontSizeStyle.Font.Style := [fsItalic];

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

procedure TFrmConsultaPersonalizada.AtualizaTitulo;
begin
  cxGridGraficoChartView.Title.Text:= FDM.QryConsultasDescricao.AsString+' - '+QryVisualizacoesDescricao.AsString;
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

function TFrmConsultaPersonalizada.CarregaVisualizacaoAtual: Boolean;
var
  ArqIni: TIniFile;
  FNomeIni: String;
  i  : integer;
  Bold, Italic : Boolean;
begin
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
  cxGridGraficoChartView.RestoreFromIniFile(FNomeIni, False, False, [gsoUseSummary], 'Grafico');

  ArqIni := TIniFile.Create(FNomeIni);
  try
    SizeLegend := ArqIni.ReadInteger('CONFIG', 'SIZE_LEGEND_ITEM',10);
    Bold := ArqIni.ReadBool('CONFIG', 'BOLD_LEGEND_ITEM',false);
    Italic := ArqIni.ReadBool('CONFIG', 'ITALIC_LEGEND_ITEM',false);

  finally
    ArqIni.Free;
  end;

  DBPivotGrid.BeginUpdate;
    try
      for I := 0 to DBPivotGrid.FieldCount - 1 do
        DBPivotGrid.Fields[I].ExpandAll;
    finally
      DBPivotGrid.EndUpdate;
    end;

    Proc_Atualiza_LegenItem(SizeLegend, Bold, Italic );

    AtualizaTitulo;

    Result:= True;
//  IR_EXECUTANDOCONSULTAClick(Sender);
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


procedure TFrmConsultaPersonalizada.FormCreate(Sender: TObject);
begin
  UpdatingPage:= False;
  FPrimeiroShow:= True;

  FUltimaConfig:= 0;

  FDm:= TDmGeradorConsultas.Create(Self, ConSqlServer);

  PageControlAtiva(0);

  Glo_Para:=0;

  vArSQLCampoTab  := TStringList.Create;
  vArSQLCampoTela := TStringList.Create;
  vArSQLObrigator := TStringList.Create;
  vArExcel        := TStringList.Create;
  vArResultado    := TStringList.Create;
//  Self.BorderStyle:= bsSizeable;
end;

procedure TFrmConsultaPersonalizada.FormDestroy(Sender: TObject);
begin
  FDm.Free;
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

procedure TFrmConsultaPersonalizada.Button1Click(Sender: TObject);
var
  TIni, TFim : TDateTime;
begin
{  MemoSqlGerado.Text:= FDm.GeraSqlEvolutivo(FDm.SqlOriginal, Now-90, Now, True, 1);

  TIni:=Now();
  QryCruzamento.Active:=False;
  QryCruzamento.SQL.Clear;
  QryCruzamento.SQL.Add(MemoSqlGerado.Text);
  QryCruzamento.ExecSQL;
  QryCruzamento.Active:=True;

  AtualizaCamposGrid;

  TFim:=Now();

  QryConfiguracoes.Active := False;
  QryConfiguracoes.Parameters[0].Value:= Self.Name;
  QryConfiguracoes.Parameters[1].Value:= FDm.QryConsultaPersonalizadaConCodigo.AsString;
  QryConfiguracoes.Active := True;

  PageControlAtiva(2);
  LabelCount.Caption:='Total de Registros: '+InttoStr(QryCruzamento.RecordCount);
  LbTime.Caption:=FormatDateTime('HH:MM:SS', TFim-TIni);
                                                               }
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

function TFrmConsultaPersonalizada.ExportaTabelaParaExcelInterno(pNomeArquivo: String; pMostraDialog: Boolean = False; pUsarFormatoNativo: Boolean = False): Boolean;
begin
  Result:= False;

  if cxGridTabelaDBTableView1.DataController.FilteredRecordCount > 65000 then
  begin
    if pMostraDialog then
      ShowMessage('Não é possível exportar mais de 65000 linhas para o excel! Faça um filtro e tente novamente.');

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
        showmessage('Arquivo Exportado com Sucesso.');
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
        showmessage('Arquivo Exportado com Sucesso.');
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
        showmessage('Arquivo Exportado com Sucesso.');
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

procedure TFrmConsultaPersonalizada.CategoriesGetValueDisplayText(
  Sender: TObject; const AValue: Variant; var ADisplayText: string);
var
  FmtStr: String;
begin
//  ShowMessage(TCxGridChartSeries(Sender).ValueCaptionFormat);
//  FmtStr:= TCxGridChartSeries(Sender).ValueCaptionFormat;
                       {
    for I := 0 to AStorage.Columns.Count - 1 do
      AGridChartView.ViewData.Categories[I] := AStorage.Columns.Strings[I];
                      }
  if TCxGridChartSeries(Sender).ValueCaptionFormat <> '' then Exit;

  FmtStr:= '#,##0.00';

  if (FmtStr <> '') and (VarIsFloat(AValue)) then
    ADisplayText:= FormatFloat(FmtStr, AValue);
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

procedure TFrmConsultaPersonalizada.cxGridGraficoChartViewCustomDrawLegendItem(
  Sender: TcxGridChartView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartLegendItemViewInfo; var ADone: Boolean);
begin
  AViewInfo.Text:= StringReplace(AViewInfo.Text, 'Grand Total - ', '', [rfIgnoreCase]);
end;

function TFrmConsultaPersonalizada.PegaCorDoGrid(pSeries: TcxGridChartSeries; pCorBase: TColor): TColor;
var
  Color2: Variant;
  FCorBase: Integer;
begin
  Result:= pCorBase;
  FCorBase:= BlendColors(pCorBase, clBlack, 50);
  if Assigned(pSeries) then
  begin
    Color2 := Func_GetColorChartView(pSeries.GetDisplayText);
    if not VarIsNull(Color2) then
      Result :=  BlendColors(FCorBase, Color2, 40);
  end;
end;

procedure TFrmConsultaPersonalizada.cxChangeLegendColorCustomDrawLegendItem(
  Sender: TcxGridChartDiagram; ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartLegendItemViewInfo; var ADone: Boolean);
begin

  if Assigned(AViewInfo.Series) then
    AViewInfo.LegendKeyParams.Color := PegaCorDoGrid(AViewInfo.Series, AViewInfo.LegendKeyParams.Color);

end;

procedure TFrmConsultaPersonalizada.cxChangeSectionColorCustomDrawValue(
  Sender: TcxGridChartDiagram; ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartDiagramValueViewInfo; var ADone: Boolean);
begin
  if Assigned(AViewInfo.Series) then
  begin
    Acanvas.Brush.Color:= PegaCorDoGrid(AViewInfo.Series, ACanvas.Brush.Color);
    AViewInfo.CaptionViewInfo.Params.TextColor:= Acanvas.Brush.Color;
  end;

end;

function TFrmConsultaPersonalizada.Func_GetColorChartView(pAViewInfoDesc: string): Variant;
var
  AValueCaption : string;
  AvalueCor : integer;

begin
  Result:= null;

  FDm.QryCampos.First;
  while not FDm.QryCampos.Eof do
  begin

    AvalueCaption := fdm.QryCamposDescricao.AsString;
    AvalueCor := fdm.QryCamposCor.AsInteger;

    if AnsiContainsStr(uppercase(pAViewInfoDesc),uppercase(AValueCaption)) then
    begin
      if (fdm.QryCamposCor.IsNull = False) then
        if TColor(AValueCor) <> clNone then
          Result := AvalueCor;
    end;

    FDm.QryCampos.Next;
  end;

end;

procedure TFrmConsultaPersonalizada.cxPivotGridChartConnectionGetSeriesDisplayText(
  Sender: TcxPivotGridChartConnection; ASeries: TcxGridChartSeries;
  var ADisplayText: String);
begin
  ASeries.OnGetValueDisplayText:= CategoriesGetValueDisplayText;
  ASeries.ValueCaptionFormat:= 'R$ #,##0.00';
end;

procedure TFrmConsultaPersonalizada.cbTamFonteGraficoClick(Sender: TObject);

begin
 SizeLegend := StrToIntDef(cbTamFonteGrafico.Text,10);
 FontSizeStyle.Font.Size := SizeLegend;
end;

procedure TFrmConsultaPersonalizada.cbxConfiguracoesClick(Sender: TObject);
begin
  if FUltimaConfig <> QryVisualizacoesID.AsInteger then
    BtnCarregaFiltro.Click;
end;

end.
