unit Ladder.ORM.DataSetBinding;

interface

uses
  Data.DB, SynCommons, Ladder.ORM.ModeloBD, System.Contnrs, System.Generics.Collections, System.Classes,
  System.Types;

type
  TDataSetBinder = class(TComponent)
  private
    FDataSet: TDataset;
    FModeloBD: TModeloBD;
    function FindObjectByKey(pObjectList: TObjectList; pKey: Integer): TObject; overload;
    function FindObjectByKey<T:Class>(pObjectList: TObjectList<T>; pKey: Integer): TObject; overload;
    procedure ClearDataSet;
    procedure InsertObject(pObject: TObject);
    procedure CheckActive(pDataSet: TDataSet);
  public
    // The Dataset is the owner of this object, do not free explictly.
    constructor Create(pDataSet: TDataSet; pModeloBD: TModeloBD);

    // Push changes from DataSet to TObject or TObjectList
    procedure PushToObject(pObject: TObject); overload;
    procedure Push(pObjectList: TObjectList); overload;
    procedure Push<T:Class>(pObjectList: TObjectList<T>); overload;

    // Pull changes from TObject or TObjectList to DataSet
    procedure PullFromObject(pObject: TObject); overload;
    procedure Pull(pObjectList: TObjectList); overload;
    procedure Pull<T:Class>(pObjectList: TObjectList<T>); overload;
  end;

procedure DataSetMemoFieldsAsText(pDataSet: TDataSet);

implementation

uses
  SysUtils;

type
  TInternalDataSetEvents = class
    class procedure FieldGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    class procedure FieldSetText(Sender: TField; const Text: string);
  end;

class procedure TInternalDataSetEvents.FieldGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text:= Sender.AsString;
end;

class procedure TInternalDataSetEvents.FieldSetText(Sender: TField;
  const Text: string);
begin
  Sender.AsString:= Text;
end;

procedure DataSetMemoFieldsAsText(pDataSet: TDataSet);
var
  FField: TField;
begin
  for FField in pDataset.Fields do
    if FField.DataType = ftMemo then
    begin
      FField.OnGetText:= TInternalDataSetEvents.FieldGetText;
      FField.OnSetText:= TInternalDataSetEvents.FieldSetText;
    end;
end;


{ TDataSetBinder }

constructor TDataSetBinder.Create(pDataSet: TDataSet; pModeloBD: TModeloBD);
begin
  inherited Create(pDataSet);
  FDataSet:= pDataSet;
  FModeloBD:= pModeloBD;
end;

procedure TDataSetBinder.CheckActive(pDataSet: TDataSet);
begin
  if not pDataSet.Active then
    pDataSet.Active:= True;
end;

function TDataSetBinder.FindObjectByKey(pObjectList: TObjectList; pKey: Integer): TObject;
var
  I: Integer;
begin
  for I:= 0 to pObjectList.Count-1 do
    if fModeloBD.GetKeyValue(pObjectList[i]) = pKey then
    begin
      Result:= pObjectList[i];
      Exit;;
    end;

  Result:= nil;
end;

function TDataSetBinder.FindObjectByKey<T>(pObjectList: TObjectList<T>; pKey: Integer): TObject;
var
  fObject: TObject;
begin
  for fObject in pObjectList do
    if fModeloBD.GetKeyValue(fObject) = pKey then
    begin
      Result:= fObject;
      Break;
    end;

  Result:= nil;
end;

procedure TDataSetBinder.PushToObject(pObject: TObject);
begin
  if FDataSet.IsEmpty then
    raise Exception.Create('TDataSetBinder.Push: DataSet must have at least one record.');

  fModeloBD.ObjectFromDataSet(pObject, FDataSet);

end;

procedure TDataSetBinder.Push(pObjectList: TObjectList);
var
  fObject: TObject;
  fID: Integer;
  fDic: TDictionary<TObject, Integer>;
  I: Integer;
begin
  FDataSet.DisableControls;
  fDic:= TDictionary<TObject, Integer>.Create(FDataSet.RecordCount);
  try
    FDataSet.First;
    while not FDataSet.eof do
    begin
      fID:= FDataSet.FieldByName(fModeloBD.NomeCampoChave).AsInteger;
      fObject:= nil;
      if fID <> 0 then
        fObject:= FindObjectByKey(pObjectList, FDataSet.FieldByName(fModeloBD.NomeCampoChave).AsInteger);

      if Assigned(fObject) then
        fModeloBD.ObjectFromDataSet(fObject, FDataSet)
      else
        pObjectList.Add(fModeloBD.ObjectFromDataSet(FDataSet));

      fDic.Add(pObjectList, 0);

      FDataSet.Next;
    end;

    for I:= 0 to pObjectList.Count-1 do // Remove all objects that were not in the Dataset
      if not fDic.ContainsKey(pObjectList[I]) then
        pObjectList.Remove(pObjectList[I]);

  finally
    fDic.Free;
    FDataSet.EnableControls;
  end;
end;

procedure TDataSetBinder.Push<T>(pObjectList: TObjectList<T>);
var
  fObject: TObject;
  fID: Integer;
  fDic: TDictionary<TObject, Integer>;
begin
  FDataSet.DisableControls;
  fDic:= TDictionary<TObject, Integer>.Create(FDataSet.RecordCount);
  try
    FDataSet.First;
    while not FDataSet.eof do
    begin
      fID:= FDataSet.FieldByName(fModeloBD.NomeCampoChave).AsInteger;
      fObject:= nil;
      if fID <> 0 then
        fObject:= FindObjectByKey<T>(pObjectList, FDataSet.FieldByName(fModeloBD.NomeCampoChave).AsInteger);

      if Assigned(fObject) then
        fModeloBD.ObjectFromDataSet(fObject, FDataSet)
      else
        pObjectList.Add(fModeloBD.ObjectFromDataSet(FDataSet));

      fDic.Add(pObjectList, 0);

      FDataSet.Next;
    end;

    for fObject in pObjectList do // Remove all objects that were not in the Dataset
      if not fDic.ContainsKey(fObject) then
        pObjectList.Remove(fObject);
  finally
    fDic.Free;
    FDataSet.EnableControls;
  end;
end;

procedure TDataSetBinder.ClearDataSet;
begin
  while not FDataSet.IsEmpty do
    FDataSet.Delete;
end;

procedure TDataSetBinder.InsertObject(pObject: TObject);
begin
  FDataSet.Append;
  FModeloBD.ObjectToDataSet(pObject, FDataSet);
  FDataSet.Post;
end;

procedure TDataSetBinder.PullFromObject(pObject: TObject);
begin
  CheckActive(FDataSet);
  FDataSet.DisableControls;
  try
    ClearDataSet;

    InsertObject(pObject);
  finally
    FDataSet.EnableControls;
  end;
end;

procedure TDataSetBinder.Pull(pObjectList: TObjectList);
var
  I: Integer;
begin
  CheckActive(FDataSet);
  fDataSet.DisableControls;
  try
    ClearDataSet;
    for I:= 0 to pObjectList.Count-1 do
      InsertObject(pObjectList[I]);
  finally
    fDataSet.EnableControls;
  end;
end;

procedure TDataSetBinder.Pull<T>(pObjectList: TObjectList<T>);
var
  fObject: TObject;
begin
  CheckActive(FDataSet);
  fDataSet.DisableControls;
  try
    ClearDataSet;
    for fObject in pObjectList do
      InsertObject(fObject);
  finally
    fDataSet.EnableControls;
  end;
end;

end.
