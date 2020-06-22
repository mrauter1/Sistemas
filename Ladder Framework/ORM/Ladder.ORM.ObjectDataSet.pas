{***************************************************************************}
{           Modified by Marcelo Rauter                                      }
{           Based on the Sring.Data.ObjectDataSet unit from                 }
{           Spring Framework for Delphi                                     }
{                                                                           }
{           Copyright (c) 2009-2018 Spring4D Team                           }
{                                                                           }
{           http://www.spring4d.org                                         }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under the Apache License, Version 2.0 (the "License");          }
{  you may not use this file except in compliance with the License.         }
{  You may obtain a copy of the License at                                  }
{                                                                           }
{      http://www.apache.org/licenses/LICENSE-2.0                           }
{                                                                           }
{  Unless required by applicable law or agreed to in writing, software      }
{  distributed under the License is distributed on an "AS IS" BASIS,        }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{  See the License for the specific language governing permissions and      }
{  limitations under the License.                                           }
{                                                                           }
{***************************************************************************}

unit Ladder.ORM.ObjectDataSet;

//{$I Spring.inc}

interface

uses
  Classes,
  System.Contnrs,
  System.Generics.Collections,
  Ladder.ORM.ModeloBD,
  DB,
  Rtti,
  Spring,
  Spring.Collections,
  Spring.Collections.Lists,
  Spring.Data.ExpressionParser,
  Spring.Data.VirtualDataSet;

type
  TDataList = class(TList<TObject>, IObjectList);

  TObjectDataSet = class(TCustomVirtualDataSet)
  private type
    TIndexFieldInfo = record
      Field: TField;
      FieldMapping: TFieldMapping;
      Descending: Boolean;
      CaseInsensitive: Boolean;
    end;
  private
    fModeloBD: TModeloBD;
    fDataList: IObjectList;

    fObjectList: TObjectList;

    fItemClass: TClass;
    fRebuildingDataList: Boolean;
    fDefaultStringFieldLength: Integer;
    fFilterIndex: Integer;
    fFilterParser: TExprParser;
    fItemTypeInfo: PTypeInfo;
    fIndexFields: TArray<TIndexFieldInfo>;
    fDisabledFields: ISet<TField>;
    fSort: string;
    fSorted: Boolean;
    fColumnAttributeClass: TAttributeClass;
    fTrackChanges: Boolean;

    fBeforeFilter: TDataSetNotifyEvent;
    fAfterFilter: TDataSetNotifyEvent;
    fBeforeSort: TDataSetNotifyEvent;
    fAfterSort: TDataSetNotifyEvent;

    fMasterDataSource: TDataSource;
    fMasterPropertyName: String;
    fGenericObjectList: System.Generics.Collections.TObjectList<TObject>;

    FOwnsObjectList: Boolean;

    function GetSort: string;
    procedure SetSort(const value: string);
    function GetFilterCount: Integer;
    procedure SetObjectList(const value: TObjectList); overload;
    procedure RebuildDataList;
    procedure DoOnDataListChange(Sender: TObject; const Item: TObject;
      Action: TCollectionChangedAction);
    procedure RaiseObjectListNotAssigned;
    procedure OnDataChange(Sender: TObject; Field: TField);
  protected
    procedure DoAfterOpen; override;
    procedure DoDeleteRecord(Index: Integer); override;
    procedure DoFilterRecord(var Accept: Boolean); override;
    procedure DoGetFieldValue(Field: TField; Index: Integer; var Value: Variant); override;
    procedure DoPostRecord(Index: Integer; Append: Boolean); override;

    function DataListCount: Integer;
    function GetRecordCount: Integer; override;
    procedure InitFilterParser;
    procedure UpdateFilter; override;
    procedure RebuildPropertiesCache; override;

    procedure DoAfterFilter; virtual;
    procedure DoAfterSort; virtual;
    procedure DoBeforeFilter; virtual;
    procedure DoBeforeSort; virtual;

    function CompareRecords(const left, right: TObject): Integer; virtual;
    function InternalGetFieldValue(field: TField; const obj: TObject): Variant; virtual;
    function ParserGetVariableValue(Sender: TObject; const VarName: string; var Value: Variant): Boolean; virtual;
    function ParserGetFunctionValue(Sender: TObject; const FuncName: string;
      const Args: Variant; var ResVal: Variant): Boolean; virtual;
    procedure InternalSetSort(const value: string; index: Integer = 0); virtual;
    procedure LoadFieldDefsFromFields(Fields: TFields; FieldDefs: TFieldDefs); virtual;
    procedure LoadFieldDefsFromItemType; virtual;

    function IsCursorOpen: Boolean; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalClose; override;
    procedure InternalCreateFields; override;
    procedure InternalOpen; override;
    procedure InternalRefresh; override;
    procedure SetFilterText(const Value: string); override;

    function GetChangedSortText(const sortText: string): string;
    function CreateIndexList(const sortText: string): TArray<TIndexFieldInfo>;
    function FieldInSortIndex(AField: TField): Boolean;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; pModeloBD: TModeloBD); overload; virtual;
    constructor Create(AOwner: TComponent; pItemClass: TClass); overload; virtual;
    destructor Destroy; override;

    /// <summary>
    ///   Makes the current dataset clone of <c>ASource</c>.
    /// </summary>
    procedure Clone(const ASource: TObjectDataSet);

    procedure Synchronize(ASelectedItem: TObject = nil);

    /// <summary>
    ///   Returns underlying model object from the current row.
    /// </summary>
    function GetCurrentModel<T: class>: T;

    /// <summary>
    ///   Returns newly created list of data containing only filtered items.
    /// </summary>
    function GetFilteredDataList<T: class>: IList<T>;

    /// <summary>
    ///   Set the index to the row matching Item, -1 if it is not found on the list
    /// </summary>
    function Select(Item: TObject): Integer; virtual;

    function AddItem(Item: TObject): Integer; virtual;
    function ExtractItem(Item: TObject): TObject; virtual;
    function RemoveItem(Item: TObject): Integer; virtual;

    procedure SetMaster(pMasterObjectDataSet: TObjectDataSet; pMasterPropertyName: String);

    procedure SetObjectList<T: class>(pObjectList: System.Generics.Collections.TObjectList<T>); overload;
    procedure SetObject(pObject: TObject); virtual;

    /// <summary>
    ///   Returns the total count of filtered records.
    /// </summary>
    property FilterCount: Integer read GetFilterCount;

    /// <summary>
    ///   Checks if dataset is sorted.
    /// </summary>
    property Sorted: Boolean read fSorted;

    /// <summary>
    ///   Sorting conditions separated by commas. Can set different sort order
    ///   for multiple fields - <c>Asc</c> stands for ascending, <c>Desc</c> -
    ///   descending.
    /// </summary>
    /// <example>
    ///   <code lang="">MyDataset.Sort := 'Name, Id Desc, Description Asc';</code>
    /// </example>
    property Sort: string read GetSort write SetSort;

    property DataList: IObjectList read fDataList;

    property ModeloBD: TModeloBD read fModeloBD;

    property ObjectList: TObjectList read fObjectList write SetObjectList;
    property GenericObjectList: System.Generics.Collections.TObjectList<TObject> read fGenericObjectList; // Use SetObjectList<>
    property OwnsObjectList: Boolean read fOwnsObjectList write fOwnsObjectList;
   published
    /// <summary>
    ///   Default length for the string type field in the dataset.
    /// </summary>
    /// <remarks>
    ///   Defaults to <c>250</c> if not set.
    /// </remarks>
    property DefaultStringFieldLength: Integer read fDefaultStringFieldLength write fDefaultStringFieldLength default 250;

    property Filter;
    property Filtered;
    property FilterOptions;

    property AfterCancel;
    property AfterClose;
    property AfterDelete;
    property AfterEdit;
    property AfterInsert;
    property AfterOpen;
    property AfterPost;
    property AfterRefresh;
    property AfterScroll;
    property BeforeCancel;
    property BeforeClose;
    property BeforeDelete;
    property BeforeEdit;
    property BeforeInsert;
    property BeforeOpen;
    property BeforePost;
    property BeforeRefresh;
    property BeforeScroll;
    property OnCalcFields;
    property OnDeleteError;
    property OnEditError;
    property OnFilterRecord;
    property OnNewRecord;
    property OnPostError;

    property BeforeFilter: TDataSetNotifyEvent read fBeforeFilter write fBeforeFilter;
    property AfterFilter: TDataSetNotifyEvent read fAfterFilter write fAfterFilter;
    property BeforeSort: TDataSetNotifyEvent read fBeforeSort write fBeforeSort;
    property AfterSort: TDataSetNotifyEvent read fAfterSort write fAfterSort;
  end;

const
  cStrSize = 2000;

implementation

uses
  FmtBcd,
  StrUtils,
  SysUtils,
  TypInfo,
  Variants,
  Spring.Data.ExpressionParser.Functions,
  Spring.Data.ValueConverters,
  Spring.Reflection,
  Ladder.Utils;

resourcestring
  SPropertyNotFound = 'Property %s not found';
  SColumnPropertiesNotSpecified = 'Type does not have column properties';

type
  EObjectDataSetException = class(Exception);

  {$WARNINGS OFF}
  TWideCharSet = set of Char;
  {$WARNINGS ON}


{$REGION 'TObjectDataSet'}

constructor TObjectDataSet.Create(AOwner: TComponent; pModeloBD: TModeloBD);
begin
  inherited Create(AOwner);

  FOwnsObjectList:= False;

  fRebuildingDataList:= False;
  fDisabledFields := TCollections.CreateSet<TField>;
  fFilterParser := TExprParser.Create;
  fFilterParser.OnGetVariable := ParserGetVariableValue;
  fFilterParser.OnExecuteFunction := ParserGetFunctionValue;
  fDefaultStringFieldLength := 250;

  FieldOptions.AutoCreateMode:= acCombineAlways;

  fModeloBD:= pModeloBD;

  fDataList := TDataList.Create;
  fDataList.OnChanged.Add(DoOnDataListChange);
  IndexList.DataList := fDataList;
  if Active then
    Refresh;
end;

constructor TObjectDataSet.Create(AOwner: TComponent; pItemClass: TClass);
begin
  Create(AOwner, TModeloBD.Create(pItemClass));
end;

destructor TObjectDataSet.Destroy;
begin
  if FOwnsObjectList and Assigned(FObjectList) then
    fObjectList.Free;

  fFilterParser.Free;
  inherited Destroy;
end;

procedure TObjectDataSet.RaiseObjectListNotAssigned;
begin
  raise Exception.Create('TObjectDataSet: ObjectList must be assigned!');
end;

function TObjectDataSet.AddItem(Item: TObject): Integer;
begin
  if Assigned(fObjectList) then
    Result:= fObjectList.Add(Item)
  else if Assigned(fGenericObjectList) then
    Result:= fGenericObjectList.Add(Item)
  else
    RaiseObjectListNotAssigned;

end;

function TObjectDataSet.RemoveItem(Item: TObject): Integer;
begin
  if Assigned(fObjectList) then
    Result:= fObjectList.Remove(Item)
  else if Assigned(fGenericObjectList) then
    Result:= fGenericObjectList.Remove(Item)
  else
    RaiseObjectListNotAssigned;
end;

function TObjectDataSet.ExtractItem(Item: TObject): TObject;
begin
  if Assigned(fObjectList) then
    Result:= fObjectList.Extract(Item)
  else if Assigned(fGenericObjectList) then
    Result:= fGenericObjectList.Extract(Item)
  else
    RaiseObjectListNotAssigned;
end;

procedure TObjectDataSet.DoOnDataListChange(Sender: TObject;
  const Item: TObject; Action: TCollectionChangedAction);
begin
  if fRebuildingDataList then
    Exit;

  if not Active then
    Exit;

  case Action of
    caAdded: AddItem(Item);
    caRemoved: RemoveItem(Item);
    caExtracted: ExtractItem(Item);
{    caReplaced: fObjectList.(Item);
    caMoved: ;
    caReseted: ;
    caChanged: ;}
  end;
{  IndexList.Rebuild;
  DisableControls;
  try
    Refresh;
  finally
    EnableControls;
  end; }
end;

procedure TObjectDataSet.Clone(const ASource: TObjectDataSet);
begin
  if Active then
    Close;

  fColumnAttributeClass := ASource.fColumnAttributeClass;
  fItemTypeInfo := ASource.fItemTypeInfo;
  fDataList := ASource.DataList;
  IndexList.DataList := ASource.IndexList.DataList;

  FilterOptions := ASource.FilterOptions;
  Filter := ASource.Filter;
  Filtered := ASource.Filtered;
  Open;
  if ASource.Sorted then
    Sort := ASource.Sort;
end;

function TObjectDataSet.CompareRecords(const left, right: TObject): Integer;
var
  i: Integer;
  fieldInfo: TIndexFieldInfo;
  leftValue, rightValue: variant;
begin
  Result := 0;

  for i := 0 to High(fIndexFields) do
  begin
    fieldInfo := fIndexFields[i];
    leftValue := fModeloBD.GetFieldValue(FieldInfo.Field.FieldName, left);
    rightValue := fModeloBD.GetFieldValue(FieldInfo.Field.FieldName, right);

    Result := TValue.From<Variant>(leftValue).CompareTo(TValue.From<Variant>(rightValue));
    if fieldInfo.Descending then
      Result := -Result;

    if Result <> 0 then
      Exit;
  end;
end;

constructor TObjectDataSet.Create(AOwner: TComponent);
begin
  raise Exception.Create('TObjectDataSet.Create: Object model must be specified. Call "Create(AOwner: TComponent; pModeloBD: TModeloBD" or "Create(AOwner: TComponent; pItemClass: TClass);"');
end;

function TObjectDataSet.CreateIndexList(const sortText: string): TArray<TIndexFieldInfo>;
var
  splittedText: TStringDynArray;
  i, n: Integer;
  fieldName: string;
  info: TIndexFieldInfo;
begin
  Result := nil;
  splittedText := SplitString(sortText, ',');
  for i := 0 to High(splittedText) do
  begin
    fieldName := Trim(splittedText[i]);
    info.Descending := EndsStr(' DESC', AnsiUpperCase(fieldName));
    if info.Descending then
      fieldName := Trim(Copy(fieldName, 1, Length(fieldName) - 5))
    else if EndsStr(' ASC', AnsiUpperCase(fieldName)) then
      fieldName := Trim(Copy(fieldName, 1, Length(fieldName) - 4));

    info.Field := FindField(fieldName);
    info.FieldMapping:= fModeloBD.FieldMappingByFieldName(fieldName);
    if Assigned(info.Field) and Assigned(info.FieldMapping) then
    begin
      info.CaseInsensitive := True;
      n := Length(Result);
      SetLength(Result, n + 1);
      Result[n] := info;
    end;
  end;
end;

function TObjectDataSet.DataListCount: Integer;
begin
  Result := 0;
  if Assigned(fDataList) then
    Result := fDataList.Count;
end;

procedure TObjectDataSet.DoAfterOpen;
begin
  if Filtered then
  begin
    UpdateFilter;
    First;
  end;
  inherited DoAfterOpen;
end;

procedure TObjectDataSet.DoDeleteRecord(Index: Integer);
begin
  IndexList.DeleteItem(Index);
end;

procedure TObjectDataSet.DoFilterRecord(var Accept: Boolean);
begin
  if (fFilterIndex >= 0) and (fFilterIndex < DataListCount) then
  begin
    if Assigned(OnFilterRecord) then
      OnFilterRecord(Self, Accept)
    else
    begin
      FilterCache.Clear;
      if fFilterParser.Eval then
        Accept := fFilterParser.Value;
    end;
  end
  else
    Accept := False;
end;

procedure TObjectDataSet.DoGetFieldValue(Field: TField; Index: Integer; var Value: Variant);
var
  obj: TObject;
begin
  obj := IndexList.Items[Index];
  Value := InternalGetFieldValue(Field, obj);
end;

procedure TObjectDataSet.DoAfterFilter;
begin
  if Assigned(fAfterFilter) then
    fAfterFilter(Self);
end;

procedure TObjectDataSet.DoAfterSort;
begin
  if Assigned(fAfterSort) then
    fAfterSort(Self);
end;

procedure TObjectDataSet.DoBeforeFilter;
begin
  if Assigned(fBeforeFilter) then
    fBeforeFilter(Self);
end;

procedure TObjectDataSet.DoBeforeSort;
begin
  if Assigned(fBeforeSort) then
    fBeforeSort(Self);
end;

procedure TObjectDataSet.DoPostRecord(Index: Integer; Append: Boolean);
var
  newItem: TObject;
  sortNeeded: Boolean;
  i: Integer;
  field: TField;
  value: TValue;
  prop: TRttiProperty;
  FFieldMapping: TFieldMapping;
begin
  if State = dsInsert then
    newItem := fModeloBD.CreateObject(Self)
  else
    newItem := IndexList.Items[Index];

  sortNeeded := False;

  for i := 0 to ModifiedFields.Count - 1 do
  begin
    field := ModifiedFields[i];

    if not sortNeeded and Sorted then
      sortNeeded := FieldInSortIndex(field);
  end;

  fModeloBD.ObjectFromDataSet(newItem, Self);

  if State = dsInsert then
    if Append then
      Index := IndexList.AddItem(newItem)
    else
      IndexList.InsertItem(newItem, Index);

  if Sorted and sortNeeded then
    InternalSetSort(Sort, Index);

  SetCurrent(Index);
end;

function TObjectDataSet.FieldInSortIndex(AField: TField): Boolean;
var
  i: Integer;
begin
  if Sorted and Assigned(fIndexFields) then
    for i := 0 to High(fIndexFields) do
      if AField = fIndexFields[i].Field then
        Exit(True);
  Result := False;
end;

function TObjectDataSet.GetChangedSortText(const sortText: string): string;
begin
  Result := sortText;

  if EndsStr(' ', Result) then
    Result := Copy(Result, 1, Length(Result) - 1)
  else
    Result := Result + ' ';
end;

function TObjectDataSet.GetCurrentModel<T>: T;
begin
//  Result := System.Default(T);
  Result:= nil;
  if Active and (Index > -1) and (Index < RecordCount) then
    Result := T(IndexList.Items[Index]);
end;

function TObjectDataSet.GetFilterCount: Integer;
begin
  Result := 0;
  if Filtered then
    Result := IndexList.Count;
end;

function TObjectDataSet.GetFilteredDataList<T>: IList<T>;
var
  i: Integer;
begin
  Result := TCollections.CreateList<T>;
  for i := 0 to IndexList.Count - 1 do
    Result.Add(IndexList.Items[i]);
end;

function TObjectDataSet.GetRecordCount: Integer;
begin
  Result := IndexList.Count;
end;

function TObjectDataSet.GetSort: string;
begin
  Result := fSort;
end;

procedure TObjectDataSet.InitFilterParser;
begin
  fFilterParser.EnableWildcardMatching := not (foNoPartialCompare in FilterOptions);
  fFilterParser.CaseInsensitive := foCaseInsensitive in FilterOptions;

  if foCaseInsensitive in FilterOptions then
    fFilterParser.Expression := AnsiUpperCase(Filter)
  else
    fFilterParser.Expression := Filter;
end;

procedure TObjectDataSet.InternalClose;
begin
  inherited InternalClose;
end;

procedure TObjectDataSet.InternalCreateFields;
begin
  IndexList.Rebuild;

//  if {$IF CompilerVersion >= 27}(FieldOptions.AutoCreateMode <> acExclusive)
//    or not (lcPersistent in Fields.LifeCycles){$ELSE}DefaultFields{$IFEND} then
  CreateFields;
end;

function TObjectDataSet.InternalGetFieldValue(field: TField; const obj: TObject): Variant;
var
  prop: TRttiProperty;
  FFieldMapping: TFieldMapping;
begin
  FFieldMapping:= fModeloBD.FieldMappingByFieldName(Field.FieldName);
  if Assigned(FFieldMapping) then
    Result:= fModeloBD.GetFieldValue(field.FieldName, Obj)
  else
    if field.FieldKind = fkData then
      if fDisabledFields.Add(field) then
      begin
        field.ReadOnly := True;
        field.Visible := False;
        raise EObjectDataSetException.CreateFmt(SPropertyNotFound, [field.FieldName]);
      end;
end;

procedure TObjectDataSet.InternalInitFieldDefs;
var
  FFields: TField;
  FHasExplicitDataField: Boolean;
begin
  FieldDefs.Clear;
  LoadFieldDefsFromFields(Fields, FieldDefs);
  FHasExplicitDataField:= False;
  for FFields in Fields do
    if FFields.FieldKind = fkData then
    begin
      FHasExplicitDataField:= True;
      Break;
    end;

  if not FHasExplicitDataField then
    LoadFieldDefsFromItemType;
end;

procedure TObjectDataSet.InternalOpen;
begin
  if IsFiltered then
    InitFilterParser;
  inherited InternalOpen;
end;

procedure TObjectDataSet.RebuildDataList;
var
  I: Integer;
begin
  fRebuildingDataList:= True;
  try
    fDataList.Clear;
    if Assigned(fObjectList) then
    begin
      for I := 0 to fObjectList.Count-1 do
        fDataList.Add(fObjectList[I]);
    end
    else if Assigned(fGenericObjectList) then
    begin
      for I := 0 to fGenericObjectList.Count-1 do
        fDataList.Add(fGenericObjectList[I]);
    end
   else
    RaiseObjectListNotAssigned;

  finally
    fRebuildingDataList:= False;
  end;
end;

procedure TObjectDataSet.RebuildPropertiesCache;
begin
  // TODO: Implement, but why?
end;

procedure TObjectDataSet.InternalRefresh;
begin
  RebuildDataList;

  inherited InternalRefresh;
  if Sorted then
    InternalSetSort(Sort);
end;

procedure TObjectDataSet.InternalSetSort(const value: string; index: Integer);
var
  pos: Integer;
  ownership: ICollectionOwnership;
  ownsObjects: Boolean;
  changed: Boolean;
begin
  if IsEmpty then
    Exit;

  DoBeforeSort;

  changed := value <> fSort;
  fIndexFields := CreateIndexList(value);
  fSorted := Length(fIndexFields) > 0;
  fSort := value;

  pos := Current;

  if fSorted then
  begin
    ownsObjects := Supports(fDataList, ICollectionOwnership, ownership)
      and ownership.OwnsObjects;
    try
      if ownsObjects then
        ownership.OwnsObjects := False;
      if changed then
        IndexList.MergeSort(CompareRecords)
      else
        IndexList.InsertionSort(index, CompareRecords);
    finally
      if ownsObjects then
        ownership.OwnsObjects := True;

      SetCurrent(pos);
    end;
  end;
  DoAfterSort;
end;

function TObjectDataSet.IsCursorOpen: Boolean;
begin
  Result := Assigned(fDataList) and inherited IsCursorOpen;
end;

procedure TObjectDataSet.LoadFieldDefsFromFields(Fields: TFields; FieldDefs: TFieldDefs);
var
  i: integer;
  field: TField;
  fieldDef: TFieldDef;
begin
  for i := 0 to Fields.Count - 1 do
  begin
    field := Fields[i];
    if FieldDefs.IndexOf(field.FieldName) = -1 then
    begin
      fieldDef := FieldDefs.AddFieldDef;
      fieldDef.Name := field.FieldName;
      fieldDef.DataType := field.DataType;
      fieldDef.Size := field.Size;
      if field.Required then
        fieldDef.Attributes := [DB.faRequired];
      if field.ReadOnly then
        fieldDef.Attributes := fieldDef.Attributes + [DB.faReadonly];
      if (field.DataType = ftBCD) and (field is TBCDField) then
        fieldDef.Precision := TBCDField(field).Precision;
      if field is TObjectField then
        LoadFieldDefsFromFields(TObjectField(field).Fields, fieldDef.ChildDefs);
    end;
  end;
end;

procedure TObjectDataSet.LoadFieldDefsFromItemType;
var
  fieldType: TFieldType;
  fieldDef: TFieldDef;
  FFieldMapping: TFieldMapping;
begin
  for FFieldMapping in fModeloBD.MappedFieldList do
  begin
    if FFieldMapping.FieldName = '' then
      Continue;

    fieldDef := FieldDefs.AddFieldDef;
    fieldDef.Name := FFieldMapping.FieldName;

    if Assigned(FFieldMapping.Prop) then
      if not FFieldMapping.Prop.IsWritable then
        fieldDef.Attributes := fieldDef.Attributes + [DB.faReadOnly];

    fieldDef.DataType := FFieldMapping.FieldType;

    if FFieldMapping.FieldType = ftString then
      fieldDef.Size:= cStrSize;

    fieldDef.Required:= False;
  end;
end;

function TObjectDataSet.ParserGetFunctionValue(Sender: TObject; const FuncName: string;
  const Args: Variant; var ResVal: Variant): Boolean;
var
  getValue: TGetValueFunc;
begin
  Result := TFilterFunctions.TryGetFunction(FuncName, getValue);
  if Result then
    ResVal := getValue(Args);
end;

function TObjectDataSet.ParserGetVariableValue(Sender: TObject;
  const VarName: string; var Value: Variant): Boolean;
var
  field: TField;
begin
  Result := FilterCache.TryGetValue(VarName, Value);
  if not Result then
  begin
    field := FindField(Varname);
    if Assigned(field) then
    begin
      Value := InternalGetFieldValue(field, IndexList.Items[Index]);
      FilterCache.Add(VarName, Value);
      Result := True;
    end;
  end;
end;

function TObjectDataSet.Select(Item: TObject): Integer;
begin
  CheckActive;
  RecNo:= fDataList.IndexOf(Item)+1;
  Result:= Index;
end;

procedure TObjectDataSet.SetFilterText(const Value: string);
begin
  if Value = Filter then
    Exit;

  if Active then
  begin
    CheckBrowseMode;
    inherited SetFilterText(Value);

    if Filtered then
    begin
      UpdateFilter;
      First;
    end
    else
    begin
      UpdateFilter;
      Resync([]);
      First;
    end;
  end
  else
    inherited SetFilterText(Value);
end;

procedure TObjectDataSet.OnDataChange(Sender: TObject; Field: TField);
var
  FProp: TRttiMember;
  FMasterInstance: TObject;
  fMasterDataSet: TObjectDataSet;
  FPropClass: TClass;
begin
  if Assigned(Field) then // Field is only assigned when it is an internal change
    Exit;

  fMasterDataSet:= TObjectDataSet(fMasterDataSource.DataSet);
  if not Assigned(fMasterDataSet) then
    Exit;

  FProp:= fMasterDataSet.ModeloBD.GetPropByName(FMasterPropertyName);
  if not Assigned(FProp) then
    Exit;

  FMasterInstance:= FMasterDataset.GetCurrentModel<TObject>;

  if not Assigned(FMasterInstance) then
  begin
    Self.Close;
    Exit;
  end;

  FPropClass:= TRttiInstanceType(GetPropertyRttiType(FProp).AsInstance).MetaclassType;
  if (FPropClass = TObjectList) or FPropClass.InheritsFrom(TObjectList) then
    ObjectList:= TObjectList(FProp.GetValue(FMasterInstance).AsObject)
  else if InheritFromGenericOfType(TType.GetType(FPropClass), 'TObjectList<>') then
    SetObjectList<TObject>(System.Generics.Collections.TObjectList<TObject>(FProp.GetValue(FMasterInstance).AsObject))
  else
    RaiseObjectListNotAssigned;

  Synchronize;
end;

procedure TObjectDataSet.SetMaster(pMasterObjectDataSet: TObjectDataSet; pMasterPropertyName: String);

  procedure CheckMasterProperty;
  var
    FProp: TRttiMember;
    FPropClass: TClass;
  begin
    FProp:= pMasterObjectDataSet.ModeloBD.GetPropByName(pMasterPropertyName);

    if not Assigned(FProp) then
      raise Exception.Create(Format('TObjectDataSet.SetMaster: Property %s.%s not found!', [pMasterObjectDataSet.ModeloBD.ItemClass.ClassName, pMasterPropertyName]));

    FPropClass:= TRttiInstanceType(GetPropertyRttiType(FProp).AsInstance).MetaclassType;
    if (FPropClass = TObjectList) or FPropClass.InheritsFrom(TObjectList) then
      Exit // or it must be a generic TObjectList<> or generic TObjectList<> descendant
    else if InheritFromGenericOfType(TType.GetType(FPropClass), 'TObjectList<>') then
      Exit
    else
      raise Exception.Create(Format('TObjectDataSet.SetMaster: Property %s.%s must be TObjectList or TObjectList<>.', [pMasterObjectDataSet.ModeloBD.Itemclass.ClassName, pMasterPropertyName]));
  end;

begin
  if Assigned(fMasterDataSource) then
     fMasterDataSource.Free;

  CheckMasterProperty;

  fMasterPropertyName:= pMasterPropertyName;

  fMasterDataSource:= TDataSource.Create(pMasterObjectDataSet);
  fMasterDataSource.DataSet:= pMasterObjectDataSet;
  fMasterDataSource.OnDataChange:= OnDataChange;
end;

procedure TObjectDataSet.SetObjectList(const value: TObjectList);
begin
  if (FOwnsObjectList) and (Value <> fObjectList) and Assigned(FObjectList) then
    FreeAndNil(fObjectList);

  if not Assigned(Value) then
    Exit;

  fGenericObjectList:= nil;
  fObjectList:= value;
  RebuildDataList;
  Open;
end;

procedure TObjectDataSet.SetObjectList<T>(pObjectList: System.Generics.Collections.TObjectList<T>);
begin
  ObjectList:= nil;
  fGenericObjectList:= System.Generics.Collections.TObjectList<TObject>(pObjectList);
  RebuildDataList;
  Open;
end;

procedure TObjectDataSet.SetObject(pObject: TObject);
begin
  FOwnsObjectList:= True;
  ObjectList:= TObjectList.Create(False);
  ObjectList.Add(pObject);
  Synchronize;
end;

procedure TObjectDataSet.SetSort(const value: string);
begin
  CheckActive;
  if State in dsEditModes then
    Post;

  UpdateCursorPos;
  InternalSetSort(value);
  Resync([]);
end;

procedure TObjectDataSet.Synchronize(ASelectedItem: TObject = nil);
var
  FCurrent: TObject;
begin
  if not Active then
    Exit;

  if Assigned(ASelectedItem) then
    FCurrent:= ASelectedItem
  else
    FCurrent:= GetCurrentModel<TObject>;

  DisableControls;
  try
    Refresh;
    if Assigned(FCurrent) then
      Select(FCurrent);

  finally
    EnableControls;
  end;
end;

procedure TObjectDataSet.UpdateFilter;
begin
  if not Active then
    Exit;

  DoBeforeFilter;

  if IsFiltered then
    InitFilterParser;

  DisableControls;
  try
    First;
    if Sorted then
      InternalSetSort(GetChangedSortText(Sort));
  finally
    EnableControls;
  end;
  UpdateCursorPos;
  Resync([]);
  First;

  DoAfterFilter;
end;


end.
