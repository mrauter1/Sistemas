unit Test.ObjectDataSet;

interface

uses
  Classes,
  TestFramework,
  TestEntities,
  Spring.Collections,
  System.Contnrs,
  System.Generics.Collections,
  Ladder.ORM.ObjectDataSet,
  Spring.TestUtils;

type
  TObjectDataSetTest = class(TTestCase)
  private
    FDataset: TObjectDataSet;
    FRemovedItemAge: Integer;
    function CreateGenericCustomersList(ASize: Integer): TObjectList<TCustomer>;
  protected
    function CreateCustomersList(ASize: Integer = 10; ACreateMock: Boolean = False): TObjectList; virtual;
    function CreateCustomersOrdersList(ASize: Integer = 10): TObjectList; virtual;
//    function CreateCustomersStreamList(const stream: TMemoryStream): IObjectList;
    procedure DoListChanged(Sender: TObject; const Item: TObject; Action: TCollectionChangedAction); virtual;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  protected // temporarily disabled
    procedure Append_Filtered;
    procedure Bookmark_Filtered;
    procedure Bookmark_Filtered_2;
    procedure Bookmark_Filtered_Fail;
    procedure Delete_Filtered;
    procedure Filter;
    procedure Filter_Custom_Functions;
    procedure Filter_DateTime;
    procedure Filter_Null;
    procedure Filter_Without_Brackets;
    procedure Sort;

    procedure StreamRead;
//    procedure Edit_SpringNullable;
    procedure ClearField_Nullable;
  published
    procedure AddRecord;
    procedure AddRecordGeneric;
    procedure AppendGenericList;
    procedure Append;
    procedure Bookmark_Simple;
    procedure Bookmark_Sorted;
    procedure ClearField_SimpleType;
    procedure Delete;
    procedure Delete_Sorted;
    procedure Delete_Last;
    procedure Delete_Notification;
    procedure Edit;
    procedure Edit_Nullable;
    procedure Eof_AfterLast;
    procedure Eof_AfterNext;
    {$IFDEF PERFORMANCE_TESTS}
    procedure Filter_Performance_Test;
    procedure InsertionSort_Speed;
    {$ENDIF}
    procedure GetCurrentModel_Filtered;
    procedure GetCurrentModel_Simple;
    procedure GetCurrentModel_Sorted;
    procedure GetCurrentModel_RandomAccess;
    procedure Insert_Simple;
    procedure Iterating;
    procedure Iterating_Empty;
    procedure Locate;
    procedure MergeSort_Try;
    procedure Open;
    procedure Open_Orders;
    procedure QuickSortTest;
    procedure SimpleSort;
    procedure Sort_Regression;

    procedure SimpleDefinedFields;
    procedure LookUpField;
    procedure MasterDetail;
    procedure WhenIsTrackingChanges_DeletedItemFromList_IsSynced;
    procedure WhenIsNotTrackingChanges_DeletedItemFromList_IsNotSynced;
    {$IFDEF GUI_TESTS}
    procedure TestGUI;
    {$ENDIF}
  end;

implementation

uses
  DateUtils,
  DB,
  Diagnostics,
  Generics.Defaults,
  SysUtils,
{$IFDEF GUI_TESTS}
  ViewTestObjectDataSet,
{$ENDIF}
  Spring,
  Spring.Persistence.Mapping.Attributes;

type
  [Entity]
  TMockCustomer = class(TCustomer)
  private
    FMockId: Integer;
  public
    constructor Create(mockId: Integer);
    [Column]
    property MockID: Integer read FMockId write FMockId;
  end;

  TSpringNullableTest = class
  private
    FName: Spring.Nullable<string>;
    FAge: Spring.Nullable<Integer>;
  public
    [Column]
    property Name: Spring.Nullable<string> read FName write FName;
    [Column]
    property Age: Spring.Nullable<Integer> read FAge write FAge;
  end;

{ TObjectDataSetTest }

procedure TObjectDataSetTest.AddRecord;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);

  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  FDataset.AppendRecord(['Insert', 59]);
  CheckEquals(11, FDataset.RecordCount);
  CheckEquals(11, LCustomers.Count);
  FDataset.Last;
  CheckEquals('Insert', FDataset.Fields[0].AsString);
  CheckEquals(59, FDataset.Fields[1].AsInteger);
  CheckEquals('Insert', TCustomer(LCustomers.Last).Name);
  CheckEquals(59, TCustomer(LCustomers.Last).Age);
end;

procedure TObjectDataSetTest.Append_Filtered;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Filter := 'Age = 1';
  FDataset.Filtered := True;

  CheckEquals(1, FDataset.RecordCount, 'RecordCount');
  FDataset.Append;
  FDataset.FieldByName('AGE').AsInteger := 1;
  FDataset.FieldByName('Name').AsString := 'Foo';
  FDataset.Post;
  CheckEquals(2, FDataset.RecordCount, 'RecordCount');

  FDataset.Append;
  FDataset.FieldByName('AGE').AsInteger := 2;
  FDataset.FieldByName('Name').AsString := 'Bar';
  FDataset.Post;
  CheckEquals(2, FDataset.RecordCount, 'RecordCount');
end;

procedure TObjectDataSetTest.Bookmark_Filtered;
var
  LCustomers: TObjectList;
  LBookmark: TBookmark;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Filter := '(AGE <= 3)';
  FDataset.Filtered := True;
  CheckEquals(3, FDataset.RecordCount, 'RecordCount');
  FDataset.Last;
  CheckEquals(3, FDataset.FieldByName('AGE').AsInteger);
  LBookmark := FDataset.Bookmark;

  FDataset.Filter := '(AGE >= 3)';
  FDataset.Last;
  CheckEquals(10, FDataset.FieldByName('AGE').AsInteger);
  CheckTrue(FDataset.BookmarkValid(LBookmark));
  FDataset.Bookmark := LBookmark;
  CheckEquals(3, FDataset.FieldByName('AGE').AsInteger);
end;

procedure TObjectDataSetTest.Bookmark_Filtered_2;
var
  LCustomers: TObjectList;
  LBookmark: TBookmark;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Filter := '(AGE <= 3)';
  FDataset.Filtered := True;
  CheckEquals(3, FDataset.RecordCount, 'RecordCount');
  FDataset.Last;
  CheckEquals(3, FDataset.FieldByName('AGE').AsInteger);
  LBookmark := FDataset.Bookmark;

  FDataset.Filter := '';
  CheckEquals(10, FDataset.RecordCount, 'RecordCount');
  FDataset.Bookmark := LBookmark;
  CheckEquals(3, FDataset.FieldByName('AGE').AsInteger);

  FDataset.Filter := '(AGE > 3)';
  CheckEquals(7, FDataset.RecordCount, 'RecordCount');
  FDataset.Filter := '';
  CheckEquals(10, FDataset.RecordCount, 'RecordCount');
  FDataset.First;
  FDataset.Bookmark := LBookmark;
  CheckEquals(3, FDataset.FieldByName('AGE').AsInteger);
end;

procedure TObjectDataSetTest.Bookmark_Filtered_Fail;
var
  LCustomers: TObjectList;
  LBookmark: TBookmark;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  LBookmark := FDataset.Bookmark;

  FDataset.Filter := '(AGE = 3)';
  FDataset.Filtered := True;
  CheckEquals(1, FDataset.RecordCount, 'RecordCount');
  CheckEquals(3, FDataset.FieldByName('AGE').AsInteger);
  CheckFalse(FDataset.BookmarkValid(LBookmark));
end;

procedure TObjectDataSetTest.Bookmark_Simple;
var
  LCustomers: TObjectList;
  LBookmark: TBookmark;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  FDataset.Last;
  FDataset.Prior;
  CheckEquals(9, FDataset.RecNo, 'RecNo');
  CheckEquals(9, FDataset.FieldByName('AGE').AsInteger);
  LBookmark := FDataset.Bookmark;
  FDataset.First;

  CheckTrue(FDataset.BookmarkValid(LBookmark));
  FDataset.Bookmark := LBookmark;
  CheckEquals(9, FDataset.RecNo, 'RecNo');
  CheckEquals(9, FDataset.FieldByName('AGE').AsInteger);
end;

procedure TObjectDataSetTest.Bookmark_Sorted;
var
  LCustomers: TObjectList;
  LBookmark: TBookmark;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Last;
  FDataset.Prior;
  CheckEquals(9, FDataset.RecNo, 'RecNo');
  CheckEquals(9, FDataset.FieldByName('AGE').AsInteger);
  LBookmark := FDataset.Bookmark;

  FDataset.Sort := 'Age Desc';
  FDataSet.Synchronize;
  FDataset.First;
  CheckEquals(10, FDataset.FieldByName('Age').AsInteger);

  CheckTrue(FDataset.BookmarkValid(LBookmark));
  FDataset.Bookmark := LBookmark;
  CheckEquals(9, FDataset.FieldByName('AGE').AsInteger);
end;

procedure TObjectDataSetTest.ClearField_Nullable;
begin
{var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  TCustomer(TCustomer(LCustomers.First)).MiddleName := 'Foo';
  CheckTrue(TCustomer(TCustomer(LCustomers.First)).MiddleName.HasValue);

  FDataset.Edit;
  FDataset.FieldByName('MiddleName').Clear;
  FDataset.Post;
  CheckFalse(TCustomer(LCustomers.First).MiddleName.HasValue);}
end;

procedure TObjectDataSetTest.ClearField_SimpleType;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  TCustomer(LCustomers.First).Age := 1;
  //clear simple type
  CheckEquals(1, TCustomer(LCustomers.First).Age);
  FDataset.Edit;
  FDataset.FieldByName('Age').Clear;
  FDataset.Post;
  CheckEquals(0, TCustomer(LCustomers.First).Age);
  //clear nullable type
end;

function TObjectDataSetTest.CreateGenericCustomersList(ASize: Integer): TObjectList<TCustomer>;
var
  LCustomer: TCustomer;
  i: Integer;
begin
  Result := TObjectList<TCustomer>.Create(True);
  for i := 1 to ASize do
  begin
    // Mock of the customer class is needed to write down ID fields. Valid values
    // are needed for some tests (e.g. Lookup).
    LCustomer := TCustomer.Create;
    LCustomer.Name := 'FirstName';
    LCustomer.Age := i;
    LCustomer.EMail := 'aaa@aaa.com';
    LCustomer.Height := 100.5;
    Result.Add(LCustomer);
  end;
end;

function TObjectDataSetTest.CreateCustomersList(ASize: Integer; ACreateMock: Boolean): TObjectList;
var
  LCustomer: TCustomer;
  i: Integer;
begin
  Result := TObjectList.Create(True);
  for i := 1 to ASize do
  begin
    // Mock of the customer class is needed to write down ID fields. Valid values
    // are needed for some tests (e.g. Lookup).
    if ACreateMock then
      LCustomer := TMockCustomer.Create(i)
    else
      LCustomer := TCustomer.Create;
    LCustomer.Name := 'FirstName';
    LCustomer.Age := i;
    LCustomer.EMail := 'aaa@aaa.com';
    LCustomer.Height := 100.5;
    Result.Add(LCustomer);
  end;
end;

function TObjectDataSetTest.CreateCustomersOrdersList(ASize: Integer): TObjectList;
var
  LOrder: TCustomer_Orders;
  i: Integer;
begin
  Result := TObjectList.Create(True);
  for i := 1 to ASize do
  begin
    LOrder := TCustomer_Orders.Create;
    LOrder.Order_Status_Code := 150;
    LOrder.Date_Order_Placed := Today;
    LOrder.Customer_ID := i;

    Result.Add(LOrder);
  end;
end;

{function TObjectDataSetTest.CreateCustomersStreamList(
  const stream: TMemoryStream): IObjectList;
var
  customer: TCustomerWithStream;
  customers: IList<TCustomerWithStream>;
begin
  customers := TCollections.CreateObjectList<TCustomerWithStream>(True);
  customer := TCustomerWithStream.Create;
  customers.Add(customer);
  customer.Name := 'FirstName';
  customer.Age := 42;
  customer.EMail := 'aaa@aaa.com';
  customer.Height := 100.5;
  customer.StreamLazy := TMemoryStream(stream);
  Result := customers as IObjectList;
end;                                     }

procedure TObjectDataSetTest.Delete;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  CheckEquals(10, FDataset.RecordCount);
  TCustomer(LCustomers.Last).Name := 'Foo';
  FDataset.Last;
  FDataset.Prior;
  FDataset.Delete;
  CheckEquals(9, LCustomers.Count);
  CheckEquals(9, FDataset.RecordCount);
  FDataset.Last;
 // CheckEquals('Foo', TCustomer(LCustomers.Last).Name);
  CheckEquals('Foo', FDataset.FieldByName('Name').AsString);

  FDataset.Delete;
  CheckEquals(8, LCustomers.Count);
  CheckEquals(8, FDataset.RecordCount);
end;


procedure TObjectDataSetTest.Delete_Filtered;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Filtered := True;
  FDataset.Filter := 'Age < 3';
  FDataset.Open;

  CheckEquals(2, FDataset.RecordCount, 'RecordCount');
  FDataset.Delete;
  CheckEquals(1, FDataset.RecordCount, 'RecordCount');
  FDataset.Delete;
  CheckEquals(0, FDataset.RecordCount, 'RecordCount');
  CheckEquals(8, LCustomers.Count, 'Count');
end;

procedure TObjectDataSetTest.Delete_Last;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Last;

  FDataset.Delete;
  CheckEquals(9, FDataset.RecordCount, 'RecordCount');
  CheckEquals(9, FDataset.RecNo, 'RecNo');
  CheckEquals(9, FDataset.FieldByName('Age').AsInteger);
  CheckEquals('FirstName', FDataset.FieldByName('Name').AsString);

  FDataset.Delete;
  CheckEquals(8, FDataset.RecordCount, 'RecordCount');
  CheckEquals(8, FDataset.RecNo, 'RecNo');
  CheckEquals(8, FDataset.FieldByName('Age').AsInteger);
end;

procedure TObjectDataSetTest.Delete_Notification;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataSet.DataList.OnChanged.Add(DoListChanged);
  FDataset.Open;
  FRemovedItemAge := -1;
  FDataset.Last;
  FDataset.Delete;
  FDataSet.DataList.OnChanged.Clear;
  CheckEquals(10, FRemovedItemAge);
end;

procedure TObjectDataSetTest.Delete_Sorted;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Sort := 'AGE DESC';
  FDataSet.Synchronize;
  FDataset.RecNo := 5;
  FDataset.Insert;
  FDataset.FieldByName('age').AsInteger := 0;
  FDataset.Post;
  FDataset.Last;
  CheckEquals(0, FDataset.FieldByName('age').AsInteger);
  FDataset.Delete;
  CheckEquals(10, FDataset.RecordCount, 'RecordCount');
end;

procedure TObjectDataSetTest.DoListChanged(Sender: TObject; const Item: TObject;
  Action: TCollectionChangedAction);
begin
  case Action of
    caAdded: ;
    caRemoved: FRemovedItemAge := TCustomer(item).Age;
    caReplaced: ;
    caMoved: ;
    caReseted: ;
  end;
end;

procedure TObjectDataSetTest.Edit;
var
  LCustomers: TObjectList;
  LDate: TDateTime;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  CheckEquals(10, FDataset.RecordCount, 'RecordCount');
  FDataset.First;
  FDataset.Edit;
  FDataset.FieldByName('Age').AsInteger := 999;
  FDataset.FieldByName('MiddleName').AsString := 'Middle';
  LDate := Today;
  FDataset.FieldByName('LastEdited').AsDateTime := LDate;
  FDataset.Post;
  CheckEquals(1, FDataset.RecNo, 'RecNo');
  CheckEquals(999, FDataset.FieldByName('Age').AsInteger);
  CheckEquals(999, TCustomer(LCustomers[0]).Age);
  CheckEquals('Middle', TCustomer(LCustomers[0]).MiddleName);
  CheckEquals(LDate, TCustomer(LCustomers[0]).LastEdited);
end;

procedure TObjectDataSetTest.Edit_Nullable;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  FDataset.RecNo := 4;
  FDataset.Edit;
  FDataset.FieldByName('MiddleName').AsString := 'Foo';
  FDataset.Post;
  CheckEquals('Foo', FDataset.FieldByName('MiddleName').AsString);
end;
{
procedure TObjectDataSetTest.Edit_SpringNullable;
var
  LCustomers: IList<TSpringNullableTest>;
begin
  LCustomers := TCollections.CreateObjectList<TSpringNullableTest>(True);
  LCustomers.Add(TSpringNullableTest.Create);
  LCustomers.Add(TSpringNullableTest.Create);
  LCustomers.Add(TSpringNullableTest.Create);

  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  FDataset.RecNo := 2;
  FDataset.Edit;
  FDataset.FieldByName('Name').AsString := 'Foo';
  FDataset.FieldByName('Age').AsInteger := 10;
  FDataset.Post;
  CheckEquals('Foo', FDataset.FieldByName('Name').AsString);
  CheckEquals(10, FDataset.FieldByName('Age').AsInteger);
end;
}
procedure TObjectDataSetTest.Eof_AfterLast;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  CheckFalse(FDataset.Eof);
  CheckTrue(FDataset.Bof);
  FDataset.Last;
  CheckTrue(FDataset.Eof);
  CheckFalse(FDataset.Bof);

end;

procedure TObjectDataSetTest.Eof_AfterNext;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Last;
  FDataset.Prior;
  CheckFalse(FDataset.Eof);
  FDataset.Next;
  CheckFalse(FDataset.Eof);
  FDataset.Next;
  CheckTrue(FDataset.Eof);
end;

procedure TObjectDataSetTest.AppendGenericList;
var
  LCustomers: TObjectList<TCustomer>;
begin
  LCustomers := CreateGenericCustomersList(10);
  FDataset.SetObjectList<TCustomer>(LCustomers);
  FDataset.Open;
  CheckEquals(10, FDataset.RecordCount);

  FDataset.Append;
  FDataset.FieldByName('Name').AsString := 'Foo';
  FDataset.FieldByName('Age').AsInteger := 999;
  FDataset.FieldByName('MiddleName').AsString := 'Middle';
  FDataset.Post;

  CheckEquals(11, LCustomers.Count);
  CheckEquals(11, FDataset.RecordCount);
  CheckEquals(11, FDataset.RecNo);
  CheckEquals(999, FDataset.FieldByName('Age').AsInteger);
  CheckEquals('Middle', FDataset.FieldByName('MiddleName').AsString);
  CheckEquals('Foo', FDataset.FieldByName('Name').AsString);

  CheckEquals(999, TCustomer(LCustomers.Last).Age);
  CheckEquals('Middle', TCustomer(LCustomers.Last).MiddleName);
  CheckEquals('Foo', TCustomer(LCustomers.Last).Name);

  FDataset.Append;
  FDataset.FieldByName('Name').AsString := 'Bar';
  FDataset.FieldByName('Age').AsInteger := 111;
  FDataset.FieldByName('MiddleName').AsString := 'Marley';
  FDataset.Post;
  CheckEquals(12, LCustomers.Count);
  CheckEquals(12, FDataset.RecordCount);
  CheckEquals(12, FDataset.RecNo);
  CheckEquals(111, FDataset.FieldByName('Age').AsInteger);
  CheckEquals('Marley', FDataset.FieldByName('MiddleName').AsString);
  CheckEquals('Bar', FDataset.FieldByName('Name').AsString);
end;

procedure TObjectDataSetTest.AddRecordGeneric;
var
  LCustomers: TObjectList<TCustomer>;
begin
  LCustomers := CreateGenericCustomersList(10);

  FDataset.SetObjectList<TCustomer>(LCustomers);
  FDataset.Open;

  FDataset.AppendRecord(['Insert', 59]);
  CheckEquals(11, FDataset.RecordCount);
  CheckEquals(11, LCustomers.Count);
  FDataset.Last;
  CheckEquals('Insert', FDataset.Fields[0].AsString);
  CheckEquals(59, FDataset.Fields[1].AsInteger);
  CheckEquals('Insert', TCustomer(LCustomers.Last).Name);
  CheckEquals(59, TCustomer(LCustomers.Last).Age);

end;

procedure TObjectDataSetTest.Append;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  CheckEquals(10, FDataset.RecordCount);

  FDataset.Append;
  FDataset.FieldByName('Name').AsString := 'Foo';
  FDataset.FieldByName('Age').AsInteger := 999;
  FDataset.FieldByName('MiddleName').AsString := 'Middle';
  FDataset.Post;

  CheckEquals(11, LCustomers.Count);
  CheckEquals(11, FDataset.RecordCount);
  CheckEquals(11, FDataset.RecNo);
  CheckEquals(999, FDataset.FieldByName('Age').AsInteger);
  CheckEquals('Middle', FDataset.FieldByName('MiddleName').AsString);
  CheckEquals('Foo', FDataset.FieldByName('Name').AsString);

  CheckEquals(999, TCustomer(LCustomers.Last).Age);
  CheckEquals('Middle', TCustomer(LCustomers.Last).MiddleName);
  CheckEquals('Foo', TCustomer(LCustomers.Last).Name);

  FDataset.Append;
  FDataset.FieldByName('Name').AsString := 'Bar';
  FDataset.FieldByName('Age').AsInteger := 111;
  FDataset.FieldByName('MiddleName').AsString := 'Marley';
  FDataset.Post;
  CheckEquals(12, LCustomers.Count);
  CheckEquals(12, FDataset.RecordCount);
  CheckEquals(12, FDataset.RecNo);
  CheckEquals(111, FDataset.FieldByName('Age').AsInteger);
  CheckEquals('Marley', FDataset.FieldByName('MiddleName').AsString);
  CheckEquals('Bar', FDataset.FieldByName('Name').AsString);
end;

{$IFDEF PERFORMANCE_TESTS}
procedure TObjectDataSetTest.InsertionSort_Speed;
var
  LCustomers: TObjectList;
  swMerge, swInsertion: TStopwatch;
begin
  LCustomers := CreateCustomersList(10000);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  //now merge sort will be used
  swMerge := TStopwatch.StartNew;
  FDataset.Sort := 'Age Desc';
  swMerge.Stop;
  FDataset.RecNo := 99995;
  swInsertion := TStopwatch.StartNew;
  FDataset.Edit;
  FDataset.FieldByName('Age').AsInteger := 99996;
  swInsertion := TStopwatch.StartNew;
  FDataset.Post;
  swInsertion.Stop;
  Status(Format('Merge Sort in %d ms. Insertion sort in %d ms.',
    [swMerge.ElapsedMilliseconds, swInsertion.ElapsedMilliseconds]));
  CheckTrue(swMerge.ElapsedMilliseconds > swInsertion.ElapsedMilliseconds);
end;
{$ENDIF}

procedure TObjectDataSetTest.Insert_Simple;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(5);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Insert;
  FDataset.FieldByName('Age').AsInteger := 6;
  FDataset.FieldByName('Name').AsString := 'Foo';
  FDataset.Post;
  CheckEquals(6, FDataset.RecordCount);
  CheckEquals(1, FDataset.RecNo);
  CheckEquals(6, FDataset.FieldByName('Age').AsInteger);
  CheckEquals('Foo', FDataset.FieldByName('Name').AsString);
end;

procedure TObjectDataSetTest.Iterating;
var
  LCustomers: TObjectList;
  i: Integer;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  i := 0;

  while not FDataset.Eof do
  begin
    Inc(i);
    CheckEquals(i, FDataset.FieldByName('Age').AsInteger);
    FDataset.Next;
  end;

  CheckEquals(10, i);
end;

procedure TObjectDataSetTest.Iterating_Empty;
var
  LCustomers: TObjectList;
  i: Integer;
begin
  LCustomers := CreateCustomersList(0);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  i := 0;
  while not FDataset.Eof do
  begin
    FDataset.Next;
    Inc(i);
  end;
  CheckEquals(0, i);
end;

procedure TObjectDataSetTest.Locate;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  CheckTrue( FDataset.Locate('Age', 5, []) );
  CheckEquals(5, FDataset.RecNo);
  CheckEquals(5, FDataset.FieldByName('Age').AsInteger);
  CheckEquals(5, TCustomer(LCustomers[FDataset.Index]).Age);

  CheckFalse( FDataset.Locate('Age', 50, []) );
end;

procedure TObjectDataSetTest.LookUpField;
var
  LCustomers: TObjectList;
  LIntField: TIntegerField;
  LStrField: TDateTimeField;
  LOrders: TObjectList;
  FOrdersDataSet: TObjectDataSet;
  I: Integer;
begin
  LCustomers := CreateCustomersList(10, True);
  for I := 0 to LCustomers.Count-1 do
    TCustomer(LCustomers[I]).FID:= I+1;

  LOrders := CreateCustomersOrdersList(10);
  for I := 0 to LOrders.Count-1 do
    TCustomer_Orders(LOrders[I]).Date_Order_Placed:= Now + Random(10);

  FOrdersDataSet := TObjectDataSet.Create(nil, TCustomer_Orders);
  try
    FOrdersDataSet.ObjectList := LOrders;

    LStrField := TDateTimeField.Create(FDataSet);
    LStrField.FieldName := 'Order_Date';
    LStrField.FieldKind := fkLookup;
    LStrField.LookupDataSet := FOrdersDataSet;
    LStrField.LookupKeyFields := 'Customer_ID';
    LStrField.LookupResultField := 'Date_Order_Placed';
    LStrField.KeyFields := 'ID';
    LStrField.Lookup := True;
    LStrField.DataSet := FDataset;

    FDataset.ObjectList := LCustomers;
    FOrdersDataSet.Open;
    FDataset.Open;

    I:= 0;
    FDataSet.First;
    while not FDataSet.Eof do
    begin
      CheckEquals(FDataSet.FieldByName('Order_Date').AsDateTime, TCustomer_Orders(LOrders[I]).Date_Order_Placed);
      Inc(I);
      FDataSet.Next;
    end;
  finally
    FOrdersDataSet.Free;
  end;

end;

procedure TObjectDataSetTest.SimpleDefinedFields;
var
  LCustomers: TObjectList;
  LStrField: TStringField;
begin
  LCustomers := CreateCustomersList(10);
  LStrField := TWideStringField.Create(FDataSet);
  LStrField.FieldName := 'Name';
  LStrField.DataSet := FDataset;

  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  CheckEquals(TCustomer(LCustomers[0]).Name, LStrField.AsString);
end;

procedure TObjectDataSetTest.MasterDetail;
var
  LCustomers: TObjectList;
  LOrders: TObjectList;
  FOrdersDataSet: TObjectDataSet;
  I, F: Integer;
  FDataSource: TDataSource;
begin
  LCustomers := CreateCustomersList(10, False);
  for I := 0 to LCustomers.Count-1 do
  begin
//    TCustomer(LCustomers[I]).FID:= I+1;
    LOrders := CreateCustomersOrdersList(Random(10));
    for F := 0 to LOrders.Count-1 do
    begin
      TCustomer(LCustomers[I]).OrdersObjList.Add(LOrders[F]);
      TCustomer_Orders(LOrders[F]).Date_Order_Placed:= Now + Random(10);
    end;
  end;

  FOrdersDataSet := TObjectDataSet.Create(nil, TCustomer_Orders);
  try
    FOrdersDataSet.ObjectList := LOrders;

    FDataset.ObjectList := LCustomers;

    FOrdersDataSet.SetMaster(FDataSet, 'OrdersObjList');

    FOrdersDataSet.Open;
    FDataset.Open;

    I:= 0;
    FDataSet.First;
    while not FDataSet.Eof do
    begin
      CheckEquals(FOrdersDataSet.RecordCount, TCustomer(LCustomers[I]).OrdersObjList.Count);

      F:= 0;
      FOrdersDataSet.First;
      while not FOrdersDataSet.Eof do
      begin
        CheckEquals(FOrdersDataSet.FieldByName('Date_Order_Placed').AsDateTime, TCustomer_Orders(TCustomer(LCustomers[I]).OrdersObjList[F]).Date_Order_Placed);
        inc(F);
        FOrdersDataSet.Next;
      end;

      Inc(I);
      FDataSet.Next;
    end;
  finally
    FOrdersDataSet.Free;
  end;
end;

procedure TObjectDataSetTest.MergeSort_Try;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;

 // FDataset.MergeSort(0, LCustomers.Count - 1, FDataset.CompareRecords, );

  Pass;
end;

procedure TObjectDataSetTest.Open;
var
  LCustomers: TObjectList;
  LNewCustomer: TCustomer;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;

  FDataset.Open;
  CheckEquals(10, FDataset.RecordCount, 'RecordCount');
  CheckFalse(FDataset.IsEmpty);
  CheckTrue(FDataset.Active);
  CheckEquals(1, FDataset.FieldByName('Age').AsInteger);
  CheckEquals('FirstName', FDataset.FieldByName('Name').AsString);
  CheckEquals(100.5, FDataset.FieldByName('Height').AsFloat, 0.001);
  CheckEquals('aaa@aaa.com', FDataset.FieldByName('EMail').AsString);
  CheckTrue(FDataset.FieldByName('MiddleName').AsString = '');

  FDataset.Next;
  CheckEquals(2, FDataset.FieldByName('Age').AsInteger);

  LNewCustomer := TCustomer.Create;
  LNewCustomer.Name := 'New';
  LNewCustomer.MiddleName := 'Customer';
  LNewCustomer.Age := 58;
//  FDataset.IndexList.AddModel(LNewCustomer);
  LCustomers.Add(LNewCustomer);
  FDataset.Synchronize;

  CheckEquals(11, FDataset.RecordCount, 'RecordCount');
  FDataset.Last;
  CheckEquals(58, FDataset.FieldByName('Age').AsInteger);
  CheckEquals('New', FDataset.FieldByName('Name').AsString);
  CheckEquals('Customer', FDataset.FieldByName('MiddleName').AsString);
end;

procedure TObjectDataSetTest.Open_Orders;
var
  LOrders: TObjectList;
begin
  LOrders := CreateCustomersOrdersList(10);
  FDataset.ObjectList := LOrders;
  FDataset.Open;
  CheckEquals(10, FDataset.RecordCount, 'RecordCount');
  CheckFalse(FDataset.IsEmpty);
  CheckTrue(FDataset.Active);

  CheckEquals(1, TCustomer_Orders(LOrders.First).Customer_ID);
  CheckEquals(Today, TCustomer_Orders(LOrders.First).Date_Order_Placed);
  CheckEquals(150, TCustomer_Orders(LOrders.First).Order_Status_Code);
  CheckFalse(TCustomer_Orders(LOrders.First).Total_Order_Price <> 0);
end;

procedure TObjectDataSetTest.QuickSortTest;
var
  LArray: TArray<Integer>;
begin
  LArray := TArray<Integer>.Create(2, 2, 10, 9, 8, 7, 6, 5, 4, 3);
  TArray.Sort<Integer>(LArray, TComparer<Integer>.Construct(
    function(const Left, Right: Integer): Integer
    begin
      Result := Right - Left;
    end));
  Pass;
end;

procedure TObjectDataSetTest.SetUp;
begin
  inherited;
  FDataset := TObjectDataSet.Create(nil, TCustomer);
  FDataSet.ModeloBD.Map('FID', 'ID', ftInteger);
end;

procedure TObjectDataSetTest.SimpleSort;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(3);
  TCustomer(LCustomers.First).Name := 'Bob';
  TCustomer(LCustomers.First).MiddleName := 'Middle';

  TCustomer(LCustomers.Last).Name := 'Michael';
  TCustomer(LCustomers.Last).MiddleName := 'Jordan';

  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  FDataset.Filtered := False;     //2,0,1

  FDataset.Sort := 'Age Desc, MIDDLENAME, Name';
  CheckEquals(3, FDataset.RecordCount, 'RecordCount');
  CheckEquals(1, FDataset.RecNo, 'RecNo');
  CheckEquals('Michael', FDataset.FieldByName('Name').AsString);
  CheckEquals('Jordan', FDataset.FieldByName('MiddleName').AsString);

  FDataset.Next;
  CheckEquals(2, FDataset.RecNo, 'RecNo');
  CheckEquals('FirstName', FDataset.FieldByName('Name').AsString);
  CheckTrue(FDataset.FieldByName('MiddleName').AsString = '');

  FDataset.Sort := 'Age Asc, MIDDLENAME, Name';
  CheckEquals(2, FDataset.RecNo, 'RecNo');
  CheckEquals('FirstName', FDataset.FieldByName('Name').AsString);
  CheckTrue(FDataset.FieldByName('MiddleName').AsString = '');
  FDataset.First;
  CheckEquals('Bob', FDataset.FieldByName('Name').AsString);
  CheckEquals('Middle', FDataset.FieldByName('MiddleName').AsString);
end;

procedure TObjectDataSetTest.Sort;
var
  LCustomers: TObjectList;
  i: Integer;
  LMsg: string;
begin
  LCustomers := CreateCustomersList(10);

  TCustomer(LCustomers.First).Age := 2;
  TCustomer(LCustomers.First).Name := 'Bob';
  TCustomer(LCustomers.First).MiddleName := 'Middle';

  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  FDataset.Filtered := True;
  FDataset.Filter := 'Age > 2';

  CheckEquals(1, FDataset.RecNo, 'RecNo');
  FDataset.Last;
  CheckEquals(8, FDataset.RecNo, 'RecNo');

  FDataset.Sort := 'Age Desc, Name, MIDDLENAME';
  FDataset.First;
  CheckEquals(1, FDataset.RecNo, 'RecNo');
  CheckEquals(10, FDataset.FieldByName('Age').AsInteger);
  CheckEquals('FirstName', TCustomer(LCustomers.Last).Name);
  CheckEquals(8, FDataset.RecordCount, 'RecordCount');


  LMsg := '';
  Status(Format('Filter: %s. Sort: %s', [FDataset.Filter, FDataset.Sort]));
  for i := 0 to LCustomers.Count - 1 do
    Status(LMsg + Format('%d %s %d', [i, TCustomer(TCustomer(LCustomers[i])).Name, TCustomer(LCustomers[i]).Age]));

  FDataset.Filtered := False;

  LMsg := '';
  Status(Format('Filtered false. Sort: %s', [FDataset.Sort]));
  for i := 0 to LCustomers.Count - 1 do
    Status(LMsg + Format('%d %s %d', [i, TCustomer(LCustomers[i]).Name, TCustomer(LCustomers[i]).Age]));

  CheckEquals(10, FDataset.RecordCount, 'RecordCount');
  FDataset.Sort := 'Age Desc, MiddleName, Name';

  LMsg := '';
  Status(Format('Filter: %s. Sort: %s', [FDataset.Filter, FDataset.Sort]));
  for i := 0 to LCustomers.Count - 1 do
    Status(LMsg + Format('%d %s %d %s', [i, TCustomer(LCustomers[i]).Name, TCustomer(LCustomers[i]).Age, TCustomer(LCustomers[i]).MiddleName]));

  FDataset.Last;
  CheckEquals(10, FDataset.RecNo, 'RecNo');
  FDataset.Prior;
  CheckEquals(9, FDataset.RecNo, 'RecNo');
  CheckEquals('Bob', FDataset.FieldByName('Name').AsString);
  CheckEquals('Middle', FDataset.FieldByName('MiddleName').AsString);

  //CheckEquals('Bob', LCustomers[8].Name);
  //CheckEquals('Middle', LCustomers[8].MiddleName);

  FDataset.Append;
  FDataset.FieldByName('name').AsString := 'aaa';
  FDataset.FieldByName('Age').AsInteger := 15;
  FDataset.Post;

  FDataset.Sort := 'name asc';

  LMsg := '';
  Status(Format('Filter: %s. Sort: %s', [FDataset.Filter, FDataset.Sort]));
  for i := 0 to LCustomers.Count - 1 do
    Status(LMsg + Format('%d %s %d %s', [i, TCustomer(LCustomers[i]).Name, TCustomer(LCustomers[i]).Age, TCustomer(LCustomers[i]).MiddleName]));

  CheckEquals(11, FDataset.RecNo, 'RecNo');
  FDataset.First;
  CheckEquals('aaa', FDataset.FieldByName('Name').AsString);
  FDataset.Next;
  CheckEquals('Bob', FDataset.FieldByName('Name').AsString);
end;

procedure TObjectDataSetTest.Sort_Regression;
var
  LCustomers: TObjectList;
  LCust: TCustomer;
begin
  LCustomers := TObjectList.Create(True);
  {
    0 Bob 2
    1 FirstName 2
    2 FirstName 10
    3 FirstName 9
    4 FirstName 8
    5 FirstName 7
    6 FirstName 6
    7 FirstName 5
    8 FirstName 4
    9 FirstName 3
  }
  //0
  LCust := TCustomer.Create;
  LCust.Name := 'Bob';
  LCust.Age := 2;
  LCustomers.Add(LCust);
  //1
  LCust := TCustomer.Create;
  LCust.Name := 'FirstName';
  LCust.Age := 2;
  LCustomers.Add(LCust);
  //2
  LCust := TCustomer.Create;
  LCust.Name := 'FirstName';
  LCust.Age := 10;
  LCustomers.Add(LCust);
  //3
  LCust := TCustomer.Create;
  LCust.Name := 'FirstName';
  LCust.Age := 9;
  LCustomers.Add(LCust);
  //4
  LCust := TCustomer.Create;
  LCust.Name := 'FirstName';
  LCust.Age := 8;
  LCustomers.Add(LCust);
  //5
  LCust := TCustomer.Create;
  LCust.Name := 'FirstName';
  LCust.Age := 7;
  LCustomers.Add(LCust);
  //6
  LCust := TCustomer.Create;
  LCust.Name := 'FirstName';
  LCust.Age := 6;
  LCustomers.Add(LCust);
  //7
  LCust := TCustomer.Create;
  LCust.Name := 'FirstName';
  LCust.Age := 5;
  LCustomers.Add(LCust);
  //8
  LCust := TCustomer.Create;
  LCust.Name := 'FirstName';
  LCust.Age := 4;
  LCustomers.Add(LCust);
  //9
  LCust := TCustomer.Create;
  LCust.Name := 'FirstName';
  LCust.Age := 3;
  LCustomers.Add(LCust);

  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  FDataset.Sort := 'Age Desc';

  CheckEquals(3, TCustomer(LCustomers.Last).Age);
  CheckEquals(4, TCustomer(LCustomers[8]).Age);

  FDataset.Last;
  CheckEquals(10, FDataset.RecNo, 'RecNo');
  CheckEquals(2, FDataset.FieldByName('Age').AsInteger);
  FDataset.Prior;
  CheckEquals(9, FDataset.RecNo, 'RecNo');
  CheckEquals(2, FDataset.FieldByName('Age').AsInteger);

 // CheckEquals('Bob', FDataset.FieldByName('Name').AsString);
end;

procedure TObjectDataSetTest.StreamRead;
begin
{var
  actual, bytes: TBytes;
  field: TField;
  stream: Shared<TBytesStream>;
begin
  bytes := TBytes.Create(1, 2, 3);
  stream := TBytesStream.Create(bytes);
  FDataset.ObjectList := CreateCustomersStreamList(stream);
  FDataset.Open;

  field := FDataset.FieldByName('CUSTSTREAM');

  CheckIs(field, TBlobField);
  CheckEquals(Length(bytes), TBlobField(field).BlobSize);
  actual := TBlobField(field).AsBytes;
  CheckEquals(Length(bytes), Length(actual));
  CheckEquals(bytes[0], actual[0]);
  CheckEquals(bytes[1], actual[1]);
  CheckEquals(bytes[2], actual[2]);     }
end;

procedure TObjectDataSetTest.TearDown;
begin
  inherited;
  FDataset.Free;
end;

procedure TObjectDataSetTest.Filter;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.Filtered := True;
  FDataset.FilterOptions := [foCaseInsensitive];
  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  FDataset.Filter := '(Age = 2)';
  CheckEquals(2, FDataset.FieldByName('Age').AsInteger);
  CheckEquals(1, FDataset.RecordCount, 'RecordCount');

  FDataset.Filter := '(Age > 2)';
  CheckEquals(8, FDataset.RecordCount, 'RecordCount');
end;

procedure TObjectDataSetTest.Filter_Custom_Functions;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  TCustomer(LCustomers.First).MiddleName := 'Foo';
  TCustomer(LCustomers.Last).MiddleName := 'Bar';
  FDataset.Filtered := True;
  FDataset.FilterOptions := [foCaseInsensitive];
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Filter := '(IsNull(MiddleName, ''1'') = ''1'')';
  CheckEquals(8, FDataset.RecordCount, 'RecordCount');
  FDataset.Filter := '(LastEdited = Today())';

  FDataset.Filter := '(Name = substr(Name,1,50))';
  CheckEquals(10, FDataset.RecordCount, 'RecordCount');
  FDataset.Filter := '(Length(Name) = 9)';
  CheckEquals(10, FDataset.RecordCount, 'RecordCount');
  FDataset.Filter := '(Length(Name) = 10)';
  CheckEquals(0, FDataset.RecordCount, 'RecordCount');
end;

procedure TObjectDataSetTest.Filter_DateTime;
var
  LCustomers: TObjectList;
  LDate: TDate;
begin
  LCustomers := CreateCustomersList(10);
  LDate := EncodeDate(2013,1,1);
  TCustomer(LCustomers.Last).LastEdited := LDate;

  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Filter := Format('(LastEdited = %s)', [QuotedStr(DateToStr(LDate))]);
  FDataset.Filtered := True;
  CheckEquals(1, FDataset.RecordCount, 'RecordCount');
end;

procedure TObjectDataSetTest.Filter_Null;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(5);
  TCustomer(LCustomers.Last).MiddleName := 'Foo';
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Filter := '(MiddleName <> Null)';
  FDataset.Filtered := True;
  CheckEquals(1, FDataset.RecordCount, 'RecordCount');
  FDataset.Filter := '(MiddleName = Null)';
  CheckEquals(4, FDataset.RecordCount, 'RecordCount');
end;

{$IFDEF PERFORMANCE_TESTS}
procedure TObjectDataSetTest.Filter_Performance_Test;
var
  LCustomers: TObjectList;
  sw: TStopwatch;
begin
  LCustomers := CreateCustomersList(50000);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Filter := '((AGE = 2)) OR ((AGE = 3)) OR ((AGE = 4)) OR ((AGE = 1)) OR ((AGE = 100)) OR ((AGE = 1000)) OR ((AGE = 999)) OR '+
  ' ((NAME = ''Some Long Name Name sdsdsd sdsd aaaaaaaaaaaaaaaaaaaaaaaaaa     WWEEW    sdddddddddddddddddd sd sd  sds d sd sds d sdds sd wewewew vew ewe we we we we we we''))';
  sw := TStopwatch.StartNew;
  FDataset.Filtered := True;
  sw.Stop;
  CheckEquals(7, FDataset.RecordCount, 'RecordCount');
  Status(Format('%d records in %d ms', [LCustomers.Count, sw.ElapsedMilliseconds]));
end;
{$ENDIF}

procedure TObjectDataSetTest.Filter_Without_Brackets;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(10);
  TCustomer(LCustomers.First).Age := 11;
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Filter := '(AGE = 1) OR (AGE = 2)';
  FDataset.Filtered := True;
 // CheckEquals(1, FDataset.FieldByName('AGE').AsInteger);
  CheckEquals(1, FDataset.RecordCount, 'RecordCount');
end;

procedure TObjectDataSetTest.GetCurrentModel_Filtered;
var
  LCustomers: TObjectList;
  LCurrentCustomer: TCustomer;
  i: Integer;
begin
  LCustomers := CreateCustomersList(5);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Filter := '(Age < 2)';
  FDataset.Filtered := True;
  i := 1;
  while not FDataset.Eof do
  begin
    LCurrentCustomer := FDataset.GetCurrentModel<TCustomer>;
    CheckEquals(i, LCurrentCustomer.Age);

    FDataset.Next;
    Inc(i);
  end;
end;

procedure TObjectDataSetTest.GetCurrentModel_RandomAccess;
var
  LCustomers: TObjectList;
  LCurrentCustomer: TCustomer;
  LBookmark: TBookmark;
begin
  LCustomers := CreateCustomersList(10);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Last;

  LCurrentCustomer := FDataset.GetCurrentModel<TCustomer>;
  CheckEquals(10, LCurrentCustomer.Age);

  FDataset.RecNo := 5;
  CheckEquals(5, FDataset.GetCurrentModel<TCustomer>.Age);

  FDataset.Prior;
  CheckEquals(4, FDataset.GetCurrentModel<TCustomer>.Age);
  LBookmark := FDataset.Bookmark;
  FDataset.First;
  FDataset.Bookmark := LBookmark;
  CheckEquals(4, FDataset.GetCurrentModel<TCustomer>.Age);
end;

procedure TObjectDataSetTest.GetCurrentModel_Simple;
var
  LCustomers: TObjectList;
  LCurrentCustomer: TCustomer;
  i: Integer;
begin
  LCustomers := CreateCustomersList(5);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.First;
  i := 1;
  while not FDataset.Eof do
  begin
    LCurrentCustomer := FDataset.GetCurrentModel<TCustomer>;
    CheckEquals(i, LCurrentCustomer.Age);

    FDataset.Next;
    Inc(i);
  end;
end;

procedure TObjectDataSetTest.GetCurrentModel_Sorted;
var
  LCustomers: TObjectList;
  LCurrentCustomer: TCustomer;
  i: Integer;
begin
  LCustomers := CreateCustomersList(5);
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  FDataset.Sort := 'AGE DESC';
  FDataSet.Synchronize;
  i := 5;
  while not FDataset.Eof do
  begin
    LCurrentCustomer := FDataset.GetCurrentModel<TCustomer>;
    CheckEquals(i, LCurrentCustomer.Age);

    FDataset.Next;
    Dec(i);
  end;
end;

procedure TObjectDataSetTest.WhenIsNotTrackingChanges_DeletedItemFromList_IsNotSynced;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(5);

  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  CheckEquals(5, FDataset.RecordCount, 'RecordCount');
  LCustomers.Remove(TCustomer(LCustomers.Last));
  CheckEquals(5, FDataset.RecordCount, 'RecordCount');
end;

procedure TObjectDataSetTest.WhenIsTrackingChanges_DeletedItemFromList_IsSynced;
var
  LCustomers: TObjectList;
begin
  LCustomers := CreateCustomersList(5);

  FDataset.ObjectList := LCustomers;
  FDataset.Open;

  CheckEquals(5, FDataset.RecordCount, 'RecordCount');
  LCustomers.Remove(TCustomer(LCustomers.Last));
  FDataset.Synchronize;
  CheckEquals(4, FDataset.RecordCount, 'RecordCount');
end;

{$IFDEF GUI_TESTS}
procedure TObjectDataSetTest.TestGUI;
var
  LCustomers: TObjectList;
  LView: TfrmObjectDataSetTest;
  sw: TStopwatch;
  LClonedDataset: TObjectDataSet;
begin
  LCustomers := CreateCustomersList(1000);
  TCustomer(LCustomers.First).Age := 2;
  TCustomer(LCustomers.First).Name := 'Bob';
  FDataset.ObjectList := LCustomers;
  FDataset.Open;
  LView := TfrmObjectDataSetTest.Create(nil);
  LClonedDataset := TObjectDataSet.Create(nil);
  try
    LView.Dataset := FDataset;
    LView.dsList.DataSet := FDataset;

    sw := TStopwatch.StartNew;
  //  FDataset.Sort := 'Age Desc, NAME';
    FDataset.Filtered := True;
    sw.Stop;
    Status(Format('Elapsed time: %d ms', [sw.ElapsedMilliseconds]));

    LClonedDataset.Clone(FDataset);
    LView.dsClone.DataSet := LClonedDataset;

    LView.ShowModal;
  finally
    LView.Free;
    LClonedDataset.Free;
  end;
  FCheckCalled := True;
end;
{$ENDIF}

{ TMockCustomer }

constructor TMockCustomer.Create(mockId: Integer);
begin
  FMockId := mockId;
end;

initialization
  RegisterTest('Spring.Data.ObjectDataSet', TObjectDataSetTest.Suite);

end.
