unit uConsultaChartController;

interface

uses
  VCL.Graphics, cxGridChartView, cxCustomPivotGrid, cxPivotGridChartConnection,
  System.Generics.Collections, System.Generics.Defaults, cxUtils, cxDBPivotGrid,
  SysUtils, uDmGeradorConsultas, Variants, StrUtils, System.Classes, System.JSON;

type
  TSeriesConf = class(TObject)
    FullName: String;
    Color: TColor;
    LabelText: String;
    DisplayFormat: String;
    constructor Create; overload;
    constructor Create(AFullName: String; AColor: TColor; ALabelText: String; ADisplayFormat: String); overload;
  end;

  TSeriesConfDictionary = TObjectDictionary<String, TSeriesConf>;

  TChartController = class(TComponent)
  private
    FChartConnection: TcxPivotGridChartConnection;
    FSeriesConfDictionary: TSeriesConfDictionary;
    FDM: TDmGeradorConsultas;
    procedure UpdateSeriesFromConf(ASeries: TcxGridChartSeries; ASeriesConf: TSeriesConf);
    function GetSeriesFieldDisplayMask(ASeries: TcxGridChartSeries): String;
  public
    procedure CategoriesGetValueDisplayText(Sender: TObject; const AValue: Variant; var ADisplayText: string);
    function FindSeriesByFullName(AFullName: String): TCxGridChartSeries;
    function GetSeriesCustomColor(pSeries: TcxGridChartSeries; pCorBase: TColor): TColor;
    function NewSeriesConf(ASeries: TcxGridChartSeries): TSeriesConf;
    function GetSeriesColorByField(AFieldName: string): Variant;
    function GetSeriesDisplayFormat(ASeries: TcxGridChartSeries): String;
    procedure UpdateSeries(ASeries: TcxGridChartSeries);
    procedure RebuildSeriesConf(AKeepSettings: Boolean = True);
    procedure ClearConfiguration;

    function GetSeriesConf(ASeries: TcxGridChartSeries): TSeriesConf;

    property ChartConnection: TcxPivotGridChartConnection read FChartConnection write FChartConnection;
    property SeriesConfDictionary: TSeriesConfDictionary read FSeriesConfDictionary;

    function SerializeSeriesConf: String;
    procedure UnserializeConf(const AJSonStr: String; AKeepSettings: Boolean = False);

    constructor Create(AOwner: TComponent; AChartConnection: TCxPivotGridChartConnection; ADM: TDmGeradorConsultas);
    destructor Destroy;
  end;

implementation

uses
  Utils;

function GetDefaultValueColor(AIndex: Integer): TColor;
const
  ColorCount = 24;
  Colors: array[0..ColorCount - 1] of TColor =
    ($60C1FF, $B4835C, $7C58A5, $657C6C, $6379E6, $9AA05B, $605DCF, $6A8846,
     $61A3F5, $58999E, $5A8CFF, $AD977A, $808E54, $95C9B9, $6763A5, $AC8C4D,
     $80E4FB, $956349, $4D50C0, $67B48B, $D6A584, $73D8DD, $89674D, $9CB5A5);
begin
  Result := Colors[AIndex mod ColorCount];
end;

{ TSeriesConf }

constructor TSeriesConf.Create;
begin
  inherited;
end;

constructor TSeriesConf.Create(AFullName: String; AColor: TColor; ALabelText,
  ADisplayFormat: String);
begin
  Create;
  FullName:= AFullName;
  Color:= AColor;
  LabelText:= ALabelText;
  DisplayFormat:= ADisplayFormat;
end;

{ TChartController }

procedure TChartController.CategoriesGetValueDisplayText(
  Sender: TObject; const AValue: Variant; var ADisplayText: string);
var
  FDisplayFormat: String;
begin
  FDisplayFormat:= GetSeriesDisplayFormat(TcxGridChartSeries(Sender));
  if FDisplayFormat='' then
    Exit;

  GetDisplayText(FDisplayFormat, AValue, ADisplayText);
end;

constructor TChartController.Create(AOwner: TComponent;
  AChartConnection: TCxPivotGridChartConnection; ADM: TDmGeradorConsultas);
begin
  inherited Create(AOwner);
  FChartConnection:= AChartConnection;
  FDM:= ADM;

  FSeriesConfDictionary:= TSeriesConfDictionary.Create([doOwnsValues]);
end;

destructor TChartController.Destroy;
begin
  FSeriesConfDictionary.Free;
  inherited;
end;

function TChartController.FindSeriesByFullName(AFullName: String): TCxGridChartSeries;
var
  I: Integer;
begin
  for I := 0 to FChartConnection.GridChartView.SeriesCount-1 do
    if GetSeriesFullName(FChartConnection, FChartConnection.GridChartView.Series[I]) = AFullName then
    begin
      Result:= FChartConnection.GridChartView.Series[I];
      Exit;
    end;
  Result:= nil;
end;

function TChartController.GetSeriesDisplayFormat(ASeries: TcxGridChartSeries): String;
var
  FDisplay: String;
  I: Integer;
  FPivotGridField: TcxPivotGridField;
  FSeriesConf: TSeriesConf;
begin
  Result:= '';
  FPivotGridField:= GetSeriesSourceField(FChartConnection, ASeries.Index);

  if not Assigned(FPivotGridField) then
    Exit;

  if not (FPivotGridField is TcxDBPivotGridField) then
    Exit;

  if not FSeriesConfDictionary.TryGetValue(GetSeriesFullName(FChartConnection, ASeries), FSeriesConf) then
    Exit;

  Result:= FSeriesConf.DisplayFormat;
end;

function TChartController.GetSeriesColorByField(AFieldName: string): Variant;
var
  FFieldName : string;
  AvalueCor : integer;
begin
  Result:= null;

  FDm.QryCampos.First;
  while not FDm.QryCampos.Eof do
  begin

    FFieldName := fdm.QryCamposNomeCampo.AsString;
    AvalueCor := fdm.QryCamposCor.AsInteger;

    if AnsiContainsStr(uppercase(AFieldName),uppercase(FFieldName)) then
    begin
      if (fdm.QryCamposCor.IsNull = False) then
        if TColor(AValueCor) <> clNone then
        begin
          Result := AvalueCor;
          Exit;
        end;
    end;
    FDm.QryCampos.Next;
  end;
end;

function TChartController.GetSeriesConf(ASeries: TcxGridChartSeries): TSeriesConf;
begin
  if not Assigned(ASeries) then
    Exit(nil);

  if SeriesConfDictionary.TryGetValue(GetSeriesFullName(ChartConnection, ASeries), Result) then
    Exit
  else
    Result:= nil;
end;

function TChartController.GetSeriesCustomColor(pSeries: TcxGridChartSeries; pCorBase: TColor): TColor;
var
  Color2: Variant;
  FCorBase: Integer;
  FSourceField: TcxPivotGridField;
begin
  Result:= pCorBase;
  if Assigned(pSeries) then
  begin
    FSourceField:= GetSeriesSourceField(FChartConnection, pSeries.Index);
    if not Assigned(FSourceField) then
      Exit;

    if not (FSourceField is TcxDBPivotGridField) then
      Exit;

    FCorBase:= pCorBase;
//    FCorBase:= BlendColors(pCorBase, clBlack, 70);
    Color2 := GetSeriesColorByField(TcxDBPivotGridField(FSourceField).DataBinding.FieldName);
    if not VarIsNull(Color2) then
      Result :=  BlendColors(FCorBase, Color2, 75);
  end;
end;

function TChartController.GetSeriesFieldDisplayMask(ASeries: TcxGridChartSeries): String;
var
  FPivotGridField: TCxPivotGridField;
begin
  Result:= '';
  FPivotGridField:= GetSeriesSourceField(FChartConnection, ASeries.Index);
  if not Assigned(FPivotGridField) then
    Exit;

  if not (FPivotGridField is TcxDBPivotGridField) then
    Exit;

  FDm.FFieldDisplayText.TryGetValue(TcxDBPivotGridField(FPivotGridField).DataBinding.FieldName, Result);
end;

function TChartController.NewSeriesConf(ASeries: TcxGridChartSeries): TSeriesConf;
var
  FColor: TColor;
  FFullName: String;
  FDisplayMask: String;
begin
  FFullName:= GetSeriesFullName(FChartConnection, ASeries);

  Result:= TSeriesConf.Create(FFullName,
      GetSeriesCustomColor(ASeries, GetDefaultValueColor(ASeries.Index)),
      FFullName,
      GetSeriesFieldDisplayMask(ASeries)
  );
end;

procedure TChartController.ClearConfiguration; // Clear the stored SereisConfDictionary;
begin
  SeriesConfDictionary.Clear;
end;

procedure TChartController.RebuildSeriesConf(AKeepSettings: Boolean = True);
var
  I: Integer;
  FSeries: TcxGridChartSeries;
  FSeriesConf: TSeriesConf;

  function AddSeriesConf(ASeries: TcxGridChartSeries): TSeriesConf;
  begin
    Result:= NewSeriesConf(ASeries);
    SeriesConfDictionary.AddOrSetValue(Result.FullName, Result);
  end;
begin
  if AKeepSettings = False then
    ClearConfiguration;

  for I := 0 to FChartConnection.GridChartView.SeriesCount-1 do
  begin
    FSeries:= FChartConnection.GridChartView.Series[I];

    FSeriesConf:= GetSeriesConf(FSeries);
    if FSeriesConf = nil then
      FSeriesConf:= AddSeriesConf(FSeries);

    FSeries.OnGetValueDisplayText:= CategoriesGetValueDisplayText;
    UpdateSeriesFromConf(FSeries, FSeriesConf);
  end;
end;

function TChartController.SerializeSeriesConf: String;
var
  FJson: TJSONArray;
  FKey: String;

  function SeriesConfToJSonObject(ASeriesConf: TSeriesConf): TJSONObject;
  begin
    Result:= TJSONObject.Create;
    Result.AddPair('FullName', ASeriesConf.FullName);
    Result.AddPair('LabelText', ASeriesConf.LabelText);
    Result.AddPair('Color', IntToStr(ASeriesConf.Color));
    Result.AddPair('DisplayFormat', ASeriesConf.DisplayFormat);
  end;
begin
  FJson:= TJsonArray.Create;
  try
    for FKey in SeriesConfDictionary.Keys do
      FJson.Add(SeriesConfToJSonObject(SeriesConfDictionary[FKey]));

    Result:= FJson.ToString;
  finally
    FJson.Free;
  end;
end;

procedure TChartController.UnserializeConf(const AJSonStr: String; AKeepSettings: Boolean = False);
var
  FJSonValue: TJSonValue;
  I: Integer;

  function ValueStr(AJSonValue: TJSOnValue; ADefault: String=''): String;
  begin
    if not Assigned(AJsonValue) then
      Exit(ADefault);

    Result:= AJsonValue.Value;
  end;

  procedure AddSeriesConfFromJSon(AJSonElement: TJSonValue);
  var
    FSeriesConf: TSeriesConf;
    FSeries: TcxGridChartSeries;
  begin
    if not (AJSonElement is TJSONObject) then
      Exit;

    FSeriesConf:= TSeriesConf.Create;

    FSeriesConf.FullName:= ValueStr(TJsonObject(AJSonElement).Values['FullName'], '');
    FSeriesConf.LabelText:= ValueStr(TJsonObject(AJSonElement).Values['LabelText'], '');
    FSeriesConf.Color:= StrToIntDef(ValueStr(TJsonObject(AJSonElement).Values['Color'], ''), clNone);
    FSeriesConf.DisplayFormat:= ValueStr(TJsonObject(AJSonElement).Values['DisplayFormat'], '');

    if FSeriesConf.Color = clNone then
    begin
      FSeries:= FindSeriesByFullName(FSeriesConf.FullName);
      if Assigned(FSeries) then
        FSeriesConf.Color:= GetSeriesCustomColor(FSeries, GetDefaultValueColor(FSeries.Index))
    end;

    if SeriesConfDictionary.ContainsKey(FSeriesConf.FullName) then
      SeriesConfDictionary.Remove(FSeriesConf.FullName);

    SeriesConfDictionary.Add(FSeriesConf.FullName, FSeriesConf);
  end;
begin
  if not AKeepSettings then
    SeriesConfDictionary.Clear;

  if Trim(AJSonStr) = '' then
    Exit;

  try
    FJSonValue:= TJsonObject.ParseJSONValue(AJsonStr);
  except
    Exit;
  end;
  try
    if not (FJSonValue is TJSONArray) then
      Exit;

    for I := 0 to TJsonArray(FJSonValue).Count-1 do
      AddSeriesConfFromJSon(TJsonArray(FJsonValue).Items[I]);
  finally
    FJSonValue.Free;
  end;
end;

procedure TChartController.UpdateSeries(ASeries: TcxGridChartSeries);
var
  FSeriesConf: TSeriesConf;
begin
  if not SeriesConfDictionary.TryGetValue(GetSeriesFullName(ChartConnection, ASeries), FSeriesConf) then
    Exit;

  UpdateSeriesFromConf(ASeries, FSeriesConf);
end;

procedure TChartController.UpdateSeriesFromConf(ASeries: TcxGridChartSeries; ASeriesConf: TSeriesConf);
begin
  ASeries.DisplayText:= ASeriesConf.LabelText;
end;


end.
