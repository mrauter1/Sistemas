unit cxUtils;

interface

uses
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Variants, cxCustomPivotGrid, cxDBPivotGrid,
  SysUtils, cxPivotGridChartConnection, cxGridChartView;

function GetColumnValueByFieldName(ACxGridDBTableView: TcxGridDBTableView; AFieldName: String): Variant; // Returns null if Field is not found
function FindPivotFieldByFieldName(ADBPivotGrid: TcxDBPivotGrid; const AName: String): TcxDBPivotGridField;
function VisibleSummaryFieldCount(APivotGrid: TcxCustomPivotGrid): Integer;
function GetSeriesSourceField(AcxPivotGridChartConnection: TcxPivotGridChartConnection; ASeriesIndex: integer): TcxPivotGridField;
function GetSeriesColumnDataItem(AcxPivotGridChartConnection: TcxPivotGridChartConnection; ASeriesIndex: Integer): TcxPivotGridViewDataItem;
function FindSeriesByFullName(AChartConnection: TcxPivotGridChartConnection; AFullName: String): TCxGridChartSeries;
function GetSeriesFullName(AChartConnection: TcxPivotGridChartConnection; ASeries: TcxGridChartSeries): String;
function GetViewDataItemFullName(AItem: TcxPivotGridViewDataItem): String;

implementation

function GetColumnValueByFieldName(ACxGridDBTableView: TcxGridDBTableView; AFieldName: String): Variant;
var
  FColumn: TcxGridDBColumn;
  FRecIndex: Integer;
begin
  FColumn:= ACxGridDBTableView.GetColumnByFieldName(AFieldName);
  if not Assigned(FColumn) then
    Exit(Null);

  if ACxGridDBTableView.Controller.SelectedRecordCount = 0 then
    Exit(Null);

  FRecIndex:= ACxGridDBTableView.Controller.SelectedRecords[0].RecordIndex;

  Result:= ACxGridDBTableView.DataController.Values[FRecIndex, FColumn.Index];
end;

function FindPivotFieldByFieldName(ADBPivotGrid: TcxDBPivotGrid; const AName: String): TcxDBPivotGridField;
var
  I: Integer;
begin
  for I := 0 to ADBPivotGrid.FieldCount-1 do
  begin
    if UpperCase(TcxDBPivotGridFieldDataBinding(ADBPivotGrid.Fields[I].DataBinding).FieldName) = UpperCase(AName) then
    begin
      Result:= (ADBPivotGrid.Fields[I] as TcxDBPivotGridField);
      Exit;
    end;
  end;
  Result:= nil;
end;

function GetSeriesColumnDataItem(AcxPivotGridChartConnection: TcxPivotGridChartConnection; ASeriesIndex: Integer): TcxPivotGridViewDataItem;
var
  I, FRecIndex: Integer;
  FCol: TcxPivotGridViewDataItem;
begin
  Result:= nil;
  FRecIndex:= 0;
  for I := 0 to AcxPivotGridChartConnection.PivotGrid.ViewData.ColumnCount-1 do
  begin
    FCol:= AcxPivotGridChartConnection.PivotGrid.ViewData.Columns[I];
    if (FCol.IsGrandTotal) or (FCol.IsTotalItem) then
      Continue;

    if ASeriesIndex=FRecIndex then
    begin
      Result:= FCol;
      Exit;
    end;
    Inc(FRecIndex);
  end;

end;

function VisibleSummaryFieldCount(APivotGrid: TcxCustomPivotGrid): Integer;
var
  I: Integer;
begin
  Result:= 0;
  for I := 0 to APivotGrid.SummaryFields.Count-1 do
    if APivotGrid.SummaryFields[I].Visible then
      Inc(Result);
end;

function GetSeriesSourceField(AcxPivotGridChartConnection: TcxPivotGridChartConnection; ASeriesIndex : integer) : TcxPivotGridField;
var
  FCol: TcxPivotGridViewDataItem;
  FSeriesCnt: Integer;
  FDBPivotGrid: TcxDBPivotGrid;

  function FirstVisibleSummaryField: TcxPivotGridField;
  var
    I: Integer;
  begin
    for I := 0 to FDBPivotGrid.SummaryFields.Count-1 do
      if FDBPivotGrid.SummaryFields[I].Visible then
        Exit(FDBPivotGrid.SummaryFields[I]);

    Result:= nil;
  end;
begin
  Result:= nil;

  FDBPivotGrid:= (AcxPivotGridChartConnection.PivotGrid as TcxDBPivotGrid);

  if not Assigned(FDBPivotGrid) then
    Exit;

  if VisibleSummaryFieldCount(FDBPivotGrid)=1 then
  begin
    Result:= FirstVisibleSummaryField;
    Exit;
  end;

  FSeriesCnt:= 0;

  if FDBPivotGrid.ViewData.ColumnCount>0 then
    FCol:= FDBPivotGrid.ViewData.Columns[0]
  else
    Exit;

  while Assigned(FCol) do // Finds the Column corresponding to the Series of ASeriesIndex
  begin
    if (FCol.Visible=False) or
        (FCol.IsGrandTotal) or
        (FCol.IsTotalItem) then
      FCol:= FCol.NextVisible
    else
    begin
      if FSeriesCnt=ASeriesIndex then
      begin
        Result:= FCol.Field;
        Exit;
      end;
      FCol:= FCol.NextVisible;
      Inc(FSeriesCnt);
    end;
  end;
end;

function GetViewDataItemFullName(AItem: TcxPivotGridViewDataItem): String;

  function GetItemDisplayText(pItem: TcxPivotGridViewDataItem): String;
  begin
    Result:= AItem.GetDisplayText;
{    if not pItem.Field.Visible and (pItem.Field.Group <> nil) then
      Result := pItem.Field.Group.Caption
    else
      Result := pItem.Field.Caption;}
  end;
begin
  // TODO: Resolver bug
//  Result:= AItem.GetDisplayText;
  if AItem.Field = nil then
    Exit('');

  Result:= GetItemDisplayText(AItem);

  if Assigned(AItem.Parent) and Assigned(AItem.Parent.Field) then
  begin
//    if AItem.Parent.GetDisplayText.ToUpper = 'GRAND TOTAL' then
    if GetItemDisplayText(AItem.Parent).ToUpper = 'GRAND TOTAL' then
      Exit;

    Result:= GetViewDataItemFullName(AItem.Parent)+' - '+Result;
  end;
end;

function FindSeriesByFullName(AChartConnection: TcxPivotGridChartConnection;
  AFullName: String): TCxGridChartSeries;
var
  I: Integer;
begin
  for I := 0 to AChartConnection.GridChartView.SeriesCount-1 do
    if GetSeriesFullName(AChartConnection, AChartConnection.GridChartView.Series[I]) = AFullName then
    begin
      Result:= AChartConnection.GridChartView.Series[I];
      Exit;
    end;
  Result:= nil;
end;

function GetSeriesFullName(AChartConnection: TcxPivotGridChartConnection; ASeries: TcxGridChartSeries): String;
var
  FCol: TcxPivotGridViewDataItem;
begin
  Result:= '';
  FCol:= GetSeriesColumnDataItem(AChartConnection, ASeries.Index);
  if not Assigned(FCol) then
    Exit;

  Result:= GetViewDataItemFullName(FCol);
  if Trim(Result)='' then
    Result:= '<Sem nome>';

end;

end.
