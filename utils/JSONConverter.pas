unit JSONConverter;

interface

uses
  System.SysUtils,
  dwsJSON,
  Data.SqlTimSt,
  Data.FmtBcd,
  DB,
  DBClient,
  DataSetJSONConverter4D.Util;

type

  EDataSetJSONConverterException = class(Exception);

  TDataSetJSONConverter = class
  strict private
    class function AsJSONArray(const pDataSet: TDataSet): TdwsJSONArray;
    class function AsJSONObject(const pDataSet: TDataSet): TdwsJSONObject;
  public
    class procedure UnMarshalToJSON(const pDataSet: TDataSet; out pJSON: TdwsJsonArray); overload; static;
    class procedure UnMarshalToJSON(const pDataSet: TDataSet; out pJSON: TdwsJSONObject); overload; static;
  end;

  TJsonDataSetConverter = class
  strict private
    class procedure ToDataSet(const pJSON: tdwsJsonArray; pDataSet: TDataSet); overload;
    class procedure ToDataSet(const pJSON: tdwsJsonObject; pDataSet: TDataSet); overload;
    class function CreateDataSet(const pJSON: TdwsJsonArray): TClientDataSet; overload;
    class function CreateDataSet(const pJSON: TdwsJsonObject): TClientDataSet; overload;
  public
    class function ToNewDataSet(const pJSON: TdwsJsonArray): TClientDataSet; overload;
    class function ToNewDataSet(const pJSON: TdwsJsonObject): TClientDataSet; overload;
    class procedure UnMarshalToDataSet(const pJSON: tdwsJsonObject; pDataSet: TDataSet); overload; static;
    class procedure UnMarshalToDataSet(const pJSON: tdwsJsonArray; pDataSet: TDataSet); overload; static;
  end;

implementation

{ TDataSetConverter }

class function TDataSetJSONConverter.AsJSONArray(const pDataSet: TDataSet): TdwsJsonArray;
var
  vBookMark: TBookmark;
begin
  Result := nil;
  if not pDataSet.IsEmpty then
  begin
    try
      Result := TdwsJsonArray.Create;

      vBookMark := pDataSet.Bookmark;

      pDataSet.First;
      while not pDataSet.Eof do
      begin
        Result.Add(AsJSONObject(pDataSet));
        pDataSet.Next;
      end;

    finally
      if pDataSet.BookmarkValid(vBookMark) then
        pDataSet.GotoBookmark(vBookMark);

      pDataSet.FreeBookmark(vBookMark);
    end;
  end;
end;

class function TDataSetJSONConverter.AsJSONObject(const pDataSet: TDataSet): tdwsJsonObject;
var
  vI: Integer;
  vKey: string;
  vTs: TSQLTimeStamp;
  vNestedDataSet: TDataSet;
  vTypeDataSetField: TDataSetFieldType;
  vJsonValue: TdwsJSONImmediate;
begin
  Result := nil;
  if not pDataSet.IsEmpty then
  begin
    Result := TdwsJsonObject.Create;
    for vI := 0 to Pred(pDataSet.FieldCount) do
    begin
      vKey := pDataSet.Fields[vI].FieldName;

      if (pDataSet.Fields[vI].DataType = TFieldType.ftDataSet) then
      begin
        vTypeDataSetField := TDataSetJSONConverterUtil.GetDataSetFieldType(TDataSetField(pDataSet.Fields[vI]));

        vNestedDataSet := TDataSetField(pDataSet.Fields[vI]).NestedDataSet;

        case vTypeDataSetField of
          dsfJSONObject:
            Result.Add(vKey, AsJSONObject(vNestedDataSet));
          dsfJSONArray:
            Result.Add(vKey, AsJSONArray(vNestedDataSet));
        end;
        continue;
      end;

      vJsonValue:= TdwsJSONImmediate.Create;
      vJsonValue.AsString:= ''; //default value

      case pDataSet.Fields[vI].DataType of
        TFieldType.ftInteger, TFieldType.ftLargeint, TFieldType.ftSmallint, TFieldType.ftShortint:
          vJsonValue.AsInteger:= pDataSet.Fields[vI].AsInteger;
        TFieldType.ftSingle, TFieldType.ftFloat:
          vJsonValue.AsNumber:= pDataSet.Fields[vI].AsFloat;
        ftString, ftWideString, ftMemo:
          vJsonValue.AsString:= pDataSet.Fields[vI].AsWideString;
        TFieldType.ftDate:
          begin
            if not pDataSet.Fields[vI].IsNull then
            begin
              vJsonValue.AsString:= TDataSetJsonConverterUtil.ISODateToString(pDataSet.Fields[vI].AsDateTime);
            end
            else
              vJsonValue.AsString:= '';
          end;
        TFieldType.ftDateTime:
          begin
            if not pDataSet.Fields[vI].IsNull then
            begin
              vJsonValue.AsString:= TDataSetJSONConverterUtil.ISODateTimeToString(pDataSet.Fields[vI].AsDateTime);
            end
            else
              vJsonValue.AsString:= '';
          end;
        TFieldType.ftTimeStamp, TFieldType.ftTime:
          begin
            if not pDataSet.Fields[vI].IsNull then
            begin
              vTs := pDataSet.Fields[vI].AsSQLTimeStamp;
              vJsonValue.AsString:= SQLTimeStampToStr('hh:nn:ss', vTs);
            end
            else
              vJsonValue.AsString:= '';
          end;
        TFieldType.ftCurrency:
          begin
            if not pDataSet.Fields[vI].IsNull then
            begin
              vJsonValue.AsNumber:= pDataSet.Fields[vI].AsCurrency;
            end
            else
              vJsonValue.AsString:= '';
          end;
        TFieldType.ftFMTBcd:
          begin
            if not pDataSet.Fields[vI].IsNull then
            begin
              vJsonValue.AsNumber:= BcdToDouble(pDataSet.Fields[vI].AsBcd);
            end
            else
              vJsonValue.AsString:= '';
          end;
       else begin
        vJsonValue.Free;
        raise EDataSetJSONConverterException.Create('Cannot find type for field ' + vKey);
       end;
      end;
      Result.Add(vKey, vJsonValue);
    end;
  end;
end;

class procedure TDataSetJSONConverter.UnMarshalToJSON(const pDataSet: TDataSet; out pJSON: tdwsJsonArray);
begin
  pJSON := AsJSONArray(pDataSet);
end;

class procedure TDataSetJSONConverter.UnMarshalToJSON(const pDataSet: TDataSet; out pJSON: tdwsJsonObject);
begin
  pJSON := AsJSONObject(pDataSet);
end;

{ TJSONConverter }

class procedure TJSONDataSetConverter.ToDataSet(const pJSON: tdwsJsonArray; pDataSet: TDataSet);
var
  vJv: tdwsJsonValue;
begin
  if (pJSON <> nil) and (pDataSet <> nil) then
  begin
    for vJv in pJSON do
      if (vJv is tdwsJsonArray) then
        ToDataSet(vJv as tdwsJsonArray, pDataSet)
      else
        ToDataSet(vJv as tdwsJsonObject, pDataSet)
  end;
end;

class procedure TJSONDataSetConverter.ToDataSet(const pJSON: TdwsJsonObject; pDataSet: TDataSet);
var
  vField: TField;
  vJv: tdwsJsonValue;
  vTypeDataSet: TDataSetFieldType;
  vNestedDataSet: TDataSet;
begin
  if (pJSON <> nil) and (pDataSet <> nil) then
  begin
    vJv := nil;

    pDataSet.Append;

    for vField in pDataSet.Fields do
    begin
      if Assigned(pJSON.items[vField.FieldName]) then
        vJv := pJSON.Items[vField.FieldName]
      else
        Continue;

      case vField.DataType of
        TFieldType.ftInteger, TFieldType.ftLargeint, TFieldType.ftSmallint, TFieldType.ftShortint:
          begin
            vField.AsInteger := vJv.AsInteger;
          end;
        TFieldType.ftSingle, TFieldType.ftFloat, TFieldType.ftCurrency, TFieldType.ftFMTBcd:
          begin
            vField.AsFloat := vJv.AsNumber;
          end;
        ftString, ftWideString, ftMemo:
          begin
            vField.AsString := vJv.AsString;
          end;
        TFieldType.ftDate:
          begin
            if vJv.AsString = '' then
              vField.Clear
            else
              vField.AsDateTime := TDataSetJSONConverterUtil.ISOStrToDate(vJv.AsString);
          end;
        TFieldType.ftDateTime:
          begin
            if vJv.AsString = '' then
              vField.Clear
            else
              vField.AsDateTime := TDataSetJSONConverterUtil.ISOStrToDateTime(vJv.AsString);
          end;
        TFieldType.ftTimeStamp, TFieldType.ftTime:
          begin
            if vJv.AsString = '' then
              vField.Clear
            else
              vField.AsDateTime := TDataSetJSONConverterUtil.ISOStrToTime(vJv.AsString);
          end;
        TFieldType.ftDataSet:
          begin
            vTypeDataSet := TDataSetJSONConverterUtil.GetDataSetFieldType(TDataSetField(vField));

            vNestedDataSet := TDataSetField(vField).NestedDataSet;

            case vTypeDataSet of
              dsfJSONObject:
                ToDataSet(vJv as tdwsJsonObject, vNestedDataSet);
              dsfJSONArray:
                ToDataSet(vJv as tdwsJsonArray, vNestedDataSet);
            end;
          end
      else
        raise EDataSetJSONConverterException.Create('Cannot find type for field ' + vField.FieldName);
      end;
    end;

    pDataSet.Post;
  end;
end;

class function TJSONDataSetConverter.CreateDataSet(const pJSON: tdwsJsonArray): TClientDataSet;
var
  vJv: tdwsJsonValue;
begin
  if (pJSON <> nil) then
  begin
    for vJv in pJSON do
      if (vJv is tdwsJsonObject) then begin
        Result:= CreateDataSet(vJv as tdwsJsonObject);
        exit;
      end;
  end;
end;

class function TJSonDataSetConverter.CreateDataSet(const pJSON: TdwsJSonObject): TClientDataSet;
var
  I: Integer;
  fType: TFieldType;
begin
  Result:= TClientDataSet.Create(nil);
  try
    for I := 0 to pJSON.ElementCount - 1 do
    begin
      if not Assigned(Result.FindField(pJSon.Names[i])) then
      begin
        case pJSon.Elements[i].ValueType of
          jvtObject: fType:= ftDataSet; // exception.create('neste dataset not implemented!');// neste dataset
          jvtArray: fType:= ftDataSet; //raise exception.create('neste dataset not implemented!');//nested dataset
          jvtString: fType:= ftString;
          jvtNumber: fType:= ftFloat;
          jvtBoolean: fType:= ftBoolean;
          jvtUndefined: fType:= ftUnknown;
          jvtNull: fType:= ftUnknown
        else
          fType:= ftUnknown;

        end;
        if fType = ftString then
          Result.FieldDefs.Add(pJSon.Names[i], fType, 255)
        else
          Result.FieldDefs.Add(pJSon.Names[i], fType);

      end;

    end;
    Result.CreateDataSet;


  except
    Result.Free;
  end;
end;

class function TJSonDataSetConverter.ToNewDataSet(const pJSON: TdwsJSonObject): TClientDataSet;
begin
  Result:= TJSonDataSetConverter.CreateDataSet(pJson);
  TJSonDataSetConverter.UnMarshalToDataSet(pJSon, Result);
end;

class function TJSonDataSetConverter.ToNewDataSet(const pJSON: tdwsJsonArray): TClientDataSet;
begin
  Result:= TJSonDataSetConverter.CreateDataSet(pJson);
  TJSonDataSetConverter.UnMarshalToDataSet(pJSon, Result);
end;

class procedure TJSONDataSetConverter.UnMarshalToDataSet(const pJSON: tdwsJsonObject; pDataSet: TDataSet);
begin
  ToDataSet(pJSON, pDataSet);
end;

class procedure TJSONDataSetConverter.UnMarshalToDataSet(const pJSON: tdwsJsonArray; pDataSet: TDataSet);
begin
  ToDataSet(pJSON, pDataSet);
end;

end.
