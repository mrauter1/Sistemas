unit uFormPropriedadesGrafico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridLevel,
  cxGridBandedTableView, Vcl.StdCtrls, cxClasses, cxGridCustomView,
  cxGridDBTableView, cxGrid, Vcl.ExtCtrls, cxPivotGridChartConnection,
  cxGridChartView, cxDBPivotGrid, cxCustomPivotGrid, cxUtils;

type
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
  private
    FChartConnection: TcxPivotGridChartConnection;
    function PivotGrid: TcxDBPivotGrid;
    function ChartView: TcxGridChartView;
    procedure FillSeries;
    procedure SaveSeries;
    function FindColFieldByAreaIndex(AIndex: Integer): TcxPivotGridField;
    procedure SetChartConnection(const Value: TcxPivotGridChartConnection);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AChartConnection: TcxPivotGridChartConnection);
    property ChartConnection: TcxPivotGridChartConnection read FChartConnection write SetChartConnection;
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

function TFormPropriedadesGrafico.ChartView: TcxGridChartView;
begin
  Result:= (FChartConnection.GridChartView as TcxGridChartView);
end;

constructor TFormPropriedadesGrafico.Create(AOwner: TComponent;
  AChartConnection: TcxPivotGridChartConnection);
begin
  inherited Create(AOwner);
  FChartConnection:= AChartConnection;
  FillSeries;
end;

function TFormPropriedadesGrafico.FindColFieldByAreaIndex(AIndex: Integer): TcxPivotGridField;
var
  I: Integer;
begin
  Result:= nil;
  for I := 0 to PivotGrid.FieldCount-1 do
    if PivotGrid.Fields[I].Area=faColumn then
      if PivotGrid.Fields[I].AreaIndex=AIndex then
      begin
        Result:= PivotGrid.Fields[I];
        Exit;
      end;
end;

procedure TFormPropriedadesGrafico.FillSeries;
var
  ASeries: TcxGridChartSeries;
  I: Integer;
begin
  for I:= 0 to ChartView.SeriesCount-1 do
  begin
    ViewSeries.DataController.AppendRecord;
    ViewSeries.DataController.Values[I, cxSeriesID.Index]:= ChartView.Series[I].Index;
    ViewSeries.DataController.Values[I, cxSeriesName.Index]:= ChartView.Series[I].DisplayText;
  end;
end;

procedure TFormPropriedadesGrafico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveSeries;
  Action:= caFree;
end;

function TFormPropriedadesGrafico.PivotGrid: TcxDBPivotGrid;
begin
  Result:= (FChartConnection.PivotGrid as TcxDBPivotGrid);
end;

procedure TFormPropriedadesGrafico.SaveSeries;
var
  ASeries: TcxGridChartSeries;
  I: Integer;
begin
  for I:= 0 to ChartView.SeriesCount-1 do
    ChartView.Series[I].DisplayText:= ViewSeries.DataController.Values[I, cxSeriesName.Index];

end;

procedure TFormPropriedadesGrafico.SetChartConnection(
  const Value: TcxPivotGridChartConnection);
begin
  FChartConnection := Value;
  Update;
end;

procedure TFormPropriedadesGrafico.Update;
begin
  EditTitulo.Text:= ChartView.Title.Text;
  FillSeries;
end;

end.
