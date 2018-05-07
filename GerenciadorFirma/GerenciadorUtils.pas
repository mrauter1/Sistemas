unit GerenciadorUtils;

interface

uses System.SysUtils, System.Variants, System.Classes, Data.DB, Datasnap.DBClient, Forms;

function SortClientDataSet(ClientDataSet: TClientDataSet;
  const FieldName: String): Boolean;

procedure WriteLog(Par_Texto: String);

implementation

uses
  Utils, uFrmShowMemo;

procedure WriteLog(Par_Texto: String);
begin
  Utils.WriteLog('Log.txt', Par_Texto);
end;

function SortClientDataSet(ClientDataSet: TClientDataSet;
  const FieldName: String): Boolean;
var
  i: Integer;
  NewIndexName: String;
  IndexOptions: TIndexOptions;
  Field: TField;
begin
  Result := False;
  Field := ClientDataSet.Fields.FindField(FieldName);
 //If invalid field name, exit.
  if Field = nil then Exit;
  //if invalid field type, exit.
  if (Field is TObjectField) or (Field is TBlobField) or
    (Field is TAggregateField) or (Field is TVariantField)
     or (Field is TBinaryField) then Exit;
  //Get IndexDefs and IndexName using RTTI
  //Ensure IndexDefs is up-to-date
  ClientDataSet.IndexDefs.Update;
  //If an ascending index is already in use,
  //switch to a descending index
  if ClientDataSet.IndexName = FieldName + '__IdxA'
  then
    begin
      NewIndexName := FieldName + '__IdxD';
      IndexOptions := [ixDescending];
    end
  else
    begin
      NewIndexName := FieldName + '__IdxA';
      IndexOptions := [];
    end;
  //Look for existing index
  for i := 0 to ClientDataSet.IndexDefs.Count - 1 do
  begin
    if ClientDataSet.IndexDefs[i].Name = NewIndexName then
      begin
        Result := True;
        Break
      end;  //if
  end; // for
  //If existing index not found, create one
  if not Result then
      begin
        ClientDataSet.AddIndex(NewIndexName,
          FieldName, IndexOptions);
        Result := True;
      end; // if not
  //Set the index
  ClientDataSet.IndexName := NewIndexName;
end;


end.
