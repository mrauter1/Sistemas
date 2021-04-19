unit uFormPropriedadesGrafico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridLevel,
  cxGridBandedTableView, Vcl.StdCtrls, cxClasses, cxGridCustomView,
  cxGridDBTableView, cxGrid, Vcl.ExtCtrls, cxPivotGridChartConnection,
  cxGridChartView, cxDBPivotGrid, cxCustomPivotGrid, cxUtils, dxColorEdit,
  System.Generics.Collections, cxTextEdit, uConsultaChartController;

type
  TSeriesChangedEvent = Procedure(AChartConnection: TcxPivotGridChartConnection;
    ASeries: TcxGridChartSeries) of object;
  TChartChangedEvent = procedure(AChartConnection: TcxPivotGridChartConnection)
    of object;

  TFormPropriedadesGrafico = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1: TcxGrid;
    Panel3: TPanel;
    EditTitulo: TEdit;
    Label1: TLabel;
    BtnOK: TButton;
    cxGrid1BandedTableView1: TcxGridBandedTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1TableView1: TcxGridTableView;
    ViewSeries: TcxGridTableView;
    cxSeriesID: TcxGridColumn;
    cxSeriesName: TcxGridColumn;
    cxSeriesColor: TcxGridColumn;
    GroupBoxFonte: TGroupBox;
    cbTamFonteGrafico: TComboBox;
    Label3: TLabel;
    BtnItalico: TButton;
    BtnNegrito: TButton;
    cxSeriesFullName: TcxGridColumn;
    cxSeriesDisplayFormat: TcxGridColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnNegritoClick(Sender: TObject);
    procedure BtnItalicoClick(Sender: TObject);
    procedure cbTamFonteGraficoClick(Sender: TObject);
    procedure cbTamFonteGraficoExit(Sender: TObject);
    procedure cbTamFonteGraficoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxSeriesColorPropertiesEditValueChanged(Sender: TObject);
    procedure cxSeriesNamePropertiesEditValueChanged(Sender: TObject);
    procedure EditTituloKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditTituloExit(Sender: TObject);
    procedure cxSeriesDisplayFormatPropertiesEditValueChanged(Sender: TObject);
  private
    FChartController: TChartController;
    FSeriesChangedEvent: TSeriesChangedEvent;
    FChartChangedEvent: TChartChangedEvent;
    FFontSizeStyle: TcxStyle;
    function PivotGrid: TcxDBPivotGrid;
    function ChartView: TcxGridChartView;
    function SeriesConfDictionary: TSeriesConfDictionary;
    procedure FillSeries;
    procedure SaveSeries;
    function FindColFieldByAreaIndex(AIndex: Integer): TcxPivotGridField;
    function FindSeriesByIndex(AIndex: Integer): TcxGridChartSeries;
    procedure Proc_Atualiza_FontStyle(pSize: Integer; pBold, pItalic: Boolean);
    procedure UpdateCurrentSeries;
    procedure UpdateTitulo;
    function GetChartConnection: TcxPivotGridChartConnection;
    procedure SetChartController(const Value: TChartController);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AChartController: TChartController; AFontSizeStyle: TcxStyle);
    property ChartController: TChartController read FChartController write SetChartController;
    property ChartConnection: TcxPivotGridChartConnection read GetChartConnection;
    property SeriesChangedEvent: TSeriesChangedEvent read FSeriesChangedEvent write FSeriesChangedEvent;
    property ChartChangedEvent: TChartChangedEvent read FChartChangedEvent write FChartChangedEvent;
    procedure Update;
  end;

var
  FormPropriedadesGrafico: TFormPropriedadesGrafico;

implementation

{$R *.dfm}
{ TFormPropriedadesGrafico }

procedure TFormPropriedadesGrafico.BtnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TFormPropriedadesGrafico.cbTamFonteGraficoClick(Sender: TObject);
begin
  FFontSizeStyle.Font.Size := StrToIntDef(cbTamFonteGrafico.Text,10);

  ChartView.Invalidate(True);
end;

procedure TFormPropriedadesGrafico.cbTamFonteGraficoExit(Sender: TObject);
begin
  cbTamFonteGraficoClick(Sender);
end;

procedure TFormPropriedadesGrafico.cbTamFonteGraficoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    cbTamFonteGraficoClick(Sender);
end;

procedure TFormPropriedadesGrafico.BtnItalicoClick(Sender: TObject);
begin
  if (fsItalic in FFontSizeStyle.Font.Style) then
    FFontSizeStyle.Font.Style:= FFontSizeStyle.Font.Style-[fsItalic]
  else
    FFontSizeStyle.Font.Style:= FFontSizeStyle.Font.Style+[fsItalic];

  ChartView.Invalidate(True);
end;

procedure TFormPropriedadesGrafico.BtnNegritoClick(Sender: TObject);
begin
  if (fsBold in FFontSizeStyle.Font.Style) then
    FFontSizeStyle.Font.Style:= FFontSizeStyle.Font.Style-[fsBold]
  else
    FFontSizeStyle.Font.Style:= FFontSizeStyle.Font.Style+[fsBold];

  ChartView.Invalidate(True);
end;

function TFormPropriedadesGrafico.ChartView: TcxGridChartView;
begin
  Result := (ChartConnection.GridChartView as TcxGridChartView);
end;

constructor TFormPropriedadesGrafico.Create(AOwner: TComponent;
  AChartController: TChartController; AFontSizeStyle: TcxStyle);
begin
  inherited Create(AOwner);
  FChartController:= AChartController;
  FFontSizeStyle:= AFontSizeStyle;
  Update;
end;

procedure TFormPropriedadesGrafico.cxSeriesColorPropertiesEditValueChanged(
  Sender: TObject);
var
  FEdit: TcxCustomEdit;
begin
  FEdit:= Sender as TcxCustomEdit;
  FEdit.PostEditValue;
  UpdateCurrentSeries;
end;

procedure TFormPropriedadesGrafico.cxSeriesDisplayFormatPropertiesEditValueChanged(
  Sender: TObject);
var
  FEdit: TcxCustomEdit;
begin
  FEdit:= Sender as TcxCustomEdit;
  FEdit.PostEditValue;
  UpdateCurrentSeries;
end;

procedure TFormPropriedadesGrafico.cxSeriesNamePropertiesEditValueChanged(
  Sender: TObject);
var
  FEdit: TcxCustomEdit;
begin
  FEdit:= Sender as TcxCustomEdit;
  FEdit.PostEditValue;
  UpdateCurrentSeries;
end;

procedure TFormPropriedadesGrafico.UpdateTitulo;
begin
  if EditTitulo.Text <> '' then
    ChartView.Title.Text := EditTitulo.Text;

  ChartView.Invalidate(True);
end;

procedure TFormPropriedadesGrafico.EditTituloExit(Sender: TObject);
begin
  UpdateTitulo;
end;

procedure TFormPropriedadesGrafico.EditTituloKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Return then
    UpdateTitulo;
end;

function TFormPropriedadesGrafico.FindColFieldByAreaIndex(AIndex: Integer)
  : TcxPivotGridField;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to PivotGrid.FieldCount - 1 do
    if PivotGrid.Fields[I].Area = faColumn then
      if PivotGrid.Fields[I].AreaIndex = AIndex then
      begin
        Result := PivotGrid.Fields[I];
        Exit;
      end;
end;

procedure TFormPropriedadesGrafico.FillSeries;
var
  ASeries: TcxGridChartSeries;
  FSeriesConf: TSeriesConf;
  FColor: TColor;
  I: Integer;
begin
  for I := 0 to ChartView.SeriesCount - 1 do
  begin
    if not SeriesConfDictionary.TryGetValue(GetSeriesFullName(ChartConnection, ChartView.Series[I]), FSeriesConf) then
      Continue;
    ViewSeries.DataController.AppendRecord;
    ViewSeries.DataController.Values[I, cxSeriesID.Index] := ChartView.Series[I].Index;
    ViewSeries.DataController.Values[I, cxSeriesFullName.Index]:= FSeriesConf.FullName;
    ViewSeries.DataController.Values[I, cxSeriesName.Index]:= FSeriesConf.LabelText;
    ViewSeries.DataController.Values[I, cxSeriesDisplayFormat.Index]:= FSeriesConf.DisplayFormat;
    ViewSeries.DataController.Values[I, cxSeriesColor.Index] := FSeriesConf.Color;
{    if FSeriesColor.TryGetValue(GetSeriesFullName(FChartConnection, ChartView.Series[I]), FColor) then
      ViewSeries.DataController.Values[I, cxSeriesColor.Index] := FColor
    else
      ViewSeries.DataController.Values[I, cxSeriesColor.Index] := null;           }
  end;
end;

procedure TFormPropriedadesGrafico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

function TFormPropriedadesGrafico.GetChartConnection: TcxPivotGridChartConnection;
begin
  Result:= FChartController.ChartConnection;
end;

function TFormPropriedadesGrafico.PivotGrid: TcxDBPivotGrid;
begin
  Result := (ChartConnection.PivotGrid as TcxDBPivotGrid);
end;

function TFormPropriedadesGrafico.FindSeriesByIndex(AIndex: Integer): TcxGridChartSeries;
var
  I: Integer;
begin
  for I := 0 to ChartView.SeriesCount-1 do
    if ChartView.Series[I].Index = AIndex then
    begin
      Result:= ChartView.Series[I];
      Exit;
    end;
  Result:= nil;
end;

procedure TFormPropriedadesGrafico.UpdateCurrentSeries;
var
  FRecID: Integer;
  FSeriesID: Integer;
  FSeriesFullName: String;
  FSeries: TcxGridChartSeries;
  FSeriesConf: TSeriesConf;
begin
  FRecID:= ViewSeries.Controller.FocusedRecordIndex;
  FSeriesFullName:= ViewSeries.DataController.Values[FRecID, cxSeriesFullName.Index];
  if not ChartController.SeriesConfDictionary.TryGetValue(FSeriesFullName, FSeriesConf) then
    Exit;

  FSeriesConf.LabelText:= ViewSeries.DataController.Values[FRecID, cxSeriesName.Index];
  FSeriesConf.Color:= ViewSeries.DataController.Values[FRecID, cxSeriesColor.Index];
  FSeriesConf.DisplayFormat:= ViewSeries.DataController.Values[FRecID, cxSeriesDisplayFormat.Index];

  FSeries:= FindSeriesByFullName(ChartConnection, FSeriesConf.FullName);
  if not Assigned(FSeries) then
    Exit;

  FChartController.UpdateSeries(FSeries);

  if Assigned(FSeriesChangedEvent) then
    FSeriesChangedEvent(ChartConnection, FSeries);

  ChartView.Invalidate(True);
end;

procedure TFormPropriedadesGrafico.SaveSeries;
var
  ASeries: TcxGridChartSeries;
  FColor: TColor;
  I: Integer;
begin
{  for I := 0 to ChartView.SeriesCount - 1 do
  begin
    UpdateSeries(ChartView.Series[I]);

  end;                   }
end;

function TFormPropriedadesGrafico.SeriesConfDictionary: TSeriesConfDictionary;
begin
  Result:= FChartController.SeriesConfDictionary;
end;

procedure TFormPropriedadesGrafico.SetChartController(
  const Value: TChartController);
begin
  FChartController := Value;
  Update;
end;

procedure TFormPropriedadesGrafico.Proc_Atualiza_FontStyle(pSize: Integer; pBold : Boolean; pItalic : Boolean);
begin
  FFontSizeStyle.Font.Size := pSize;
  cbTamFonteGrafico.Text :=  IntToStr(pSize);

  FFontSizeStyle.Font.Style:= [];

 if pBold then FFontSizeStyle.Font.Style := FFontSizeStyle.Font.Style+[fsBold];
 if pItalic then FFontSizeStyle.Font.Style := FFontSizeStyle.Font.Style+[fsItalic];
end;


procedure TFormPropriedadesGrafico.Update;
begin
  EditTitulo.Text := ChartView.Title.Text;
  cbTamFonteGrafico.Text:= IntToStr(FFontSizeStyle.Font.Size);

  FillSeries;
end;

end.
