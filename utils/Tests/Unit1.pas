unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxClasses, cxCustomData, cxStyles, cxEdit, dxSkinsCore,
  dxSkinscxPCPainter, cxFilter, cxData, cxDataStorage, cxNavigator, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxGridCustomView, cxGrid, dxmdaset, cxCustomPivotGrid,
  cxDBPivotGrid, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TForm1 = class(TForm)
    cxDBPivotGrid1: TcxDBPivotGrid;
    dxMemData1: TdxMemData;
    dxMemData1header: TIntegerField;
    dxMemData1HeaderCategory: TStringField;
    dxMemData1Date: TDateField;
    dxMemData1Value: TIntegerField;
    DataSource1: TDataSource;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxDBPivotGrid1RecId: TcxDBPivotGridField;
    cxDBPivotGrid1Values: TcxDBPivotGridField;
    cxDBPivotGrid1ValuesCategory: TcxDBPivotGridField;
    cxDBPivotGrid1Date: TcxDBPivotGridField;
    cxDBPivotGrid1Index: TcxDBPivotGridField;
    cxGrid1DBTableView1RecId: TcxGridDBColumn;
    cxGrid1DBTableView1Values: TcxGridDBColumn;
    cxGrid1DBTableView1ValuesCategory: TcxGridDBColumn;
    cxGrid1DBTableView1Date: TcxGridDBColumn;
    cxGrid1DBTableView1Index: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure cxDBPivotGrid1ValuesCalculateCustomSummary(
      Sender: TcxPivotGridField; ASummary: TcxPivotGridCrossCellSummary);
    procedure cxDBPivotGrid1RecIdCalculateCustomSummary(
      Sender: TcxPivotGridField; ASummary: TcxPivotGridCrossCellSummary);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  cxDBPivotGrid1Date.CustomTotals.Add(stCustom);
end;

function VarToDouble(const AValue: Variant): Double;
begin
  Result := 0;
  if not VarIsNull(AValue) then
    Result := AValue;
end;

procedure TForm1.cxDBPivotGrid1RecIdCalculateCustomSummary(
  Sender: TcxPivotGridField; ASummary: TcxPivotGridCrossCellSummary);
var
  AOwner: TCxPivotGridCrossCell;
  AColumn: TcxPivotGridGroupItem;
  I: Integer;
begin
  AOwner:= ASummary.Owner;
  AColumn := ASummary.Owner.Column;
  if AColumn.Level = -1 then
  begin
    ASummary.Custom := 0;
    for I := 0 to AOwner.Records.Count - 1 do
      ASummary.Custom := ASummary.Custom + VarToDouble(AOwner.DataController.Values[AOwner.Records.Items[I], cxDBPivotGrid1Values.Index]);
//    ASummary.Custom := 'Double summ is  ' + VarToStr(2 * ASummary.Custom);
  end
  else
  begin
    ASummary.Custom := 0;
    for I := 0 to AOwner.Records.Count - 1 do
      ASummary.Custom := ASummary.Custom + VarToDouble(AOwner.DataController.Values[AOwner.Records.Items[I], cxDBPivotGrid1Values.Index]);
//    ASummary.Custom := ASummary.Custom;
  end;
end;

procedure TForm1.cxDBPivotGrid1ValuesCalculateCustomSummary(
  Sender: TcxPivotGridField; ASummary: TcxPivotGridCrossCellSummary);
var
  AColumn: TcxPivotGridGroupItem;
  I: Integer;
begin
  AColumn := ASummary.Owner.Column;
  if AColumn.Level = -1 then
  begin
    ASummary.Custom := 0;
    for I := 0 to ASummary.Owner.Records.Count - 1 do
      ASummary.Custom := ASummary.Custom + VarToDouble(ASummary.Owner.DataController.Values[ASummary.Owner.Records.Items[I], cxDBPivotGrid1Values.Index]);
    ASummary.Custom := 'Double summ is  ' + VarToStr(2 * ASummary.Custom);
  end
  else
    ASummary.Custom := 'Double Column summ is  ' + VarToStr(2 * ASummary.Sum);
end;

end.
