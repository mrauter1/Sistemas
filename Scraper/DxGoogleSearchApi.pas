{Google Search API£º
http://code.google.com/intl/en-us/apis/ajaxsearch/documentation/reference.html#_class_GSearch
author£ºdxsoft 2010-4-1
}
unit DxGoogleSearchApi;

interface
  uses Classes,SysUtils,msxml,uLkJSON,Variants;

{$IF RTLVersion > 14.00}
    {$IF RTLVersion > 19.00}
    {$DEFINE USE_D2009}
    {$IFEND}
{$IFEND}
type
//searchtype        Web  local  video blogs  news   books  pic  patent
  TDxSearchType = (Sh_Web,Sh_Local,Sh_Video,Sh_Blog,Sh_News,Sh_Book,Sh_Image,Sh_patent);

  //search result record
  TDxSearchRecord = class
  private
    RetList: TStringList;
    function GetFieldCount: Integer;
    function GetFields(index: Integer): string;
    function GetValues(index: Integer): string;
  public
    constructor Create;
    procedure FromJsonObj(JsonObj: TlkJSONobject);
    destructor Destroy;override;
    property FieldCount: Integer read GetFieldCount;
    property Fields[index: Integer]: string read GetFields;
    property Values[index: Integer]: string read GetValues;
    function FieldByName(FieldName: string): string; 
  end;

  TDxSearchRecords = class
  private
    List: TList;
    FSearchType: TDxSearchType;
    function GetCount: Integer;
    function GetRecords(index: Integer): TDxSearchRecord;
  public
    procedure Clear;
    constructor Create;
    property SearchType: TDxSearchType read FSearchType;
    destructor Destroy;override;
    property Count: Integer read GetCount;
    property Records[index: Integer]: TDxSearchRecord read GetRecords;
  end;

  //search API
  TDxGoogleSearch = class
  private
    FSearchType: TDxSearchType;
    FBigSearchSize: Boolean;
    FSearchStart: Integer;
    FVersion: string;
    HttpReq: IXMLHttpRequest;
    FRecords: TDxSearchRecords;
    Pages: array of Integer;
    FCurSearchInfo: string;
    ClearOld: Boolean;
    FCurPageIndex: Integer;
    function GetPageCount: Integer;
  public
    constructor Create;
    destructor Destroy;override;
    procedure Search(SearchInfo: string);
    property CurPageIndex: Integer read FCurPageIndex;
    function NextSearch: Boolean;//search next page
    property PageCount: Integer read GetPageCount;
    property Records: TDxSearchRecords read FRecords;
    property BigSearchSize: Boolean read FBigSearchSize write FBigSearchSize default true;//rsz param
    property SearchStart: Integer read FSearchStart write FSearchStart default 0;//search start pos£¬start param
    property Version: string read FVersion write FVersion;
    property SearchType: TDxSearchType read FSearchType write FSearchType default Sh_Web;//search type
  end;
implementation

type
  TBytes = array of Byte;

function BytesOf(const Val: AnsiString): TBytes;
var
  Len: Integer;
begin
  Len := Length(Val);
  SetLength(Result, Len);
  Move(Val[1], Result[0], Len);
end;

function ToUTF8Encode(str: string): string;
var
  b: Byte;
begin
  for b in BytesOf(UTF8Encode(str)) do
    Result := Format('%s%s%.2x', [Result, '%', b]);
end;


{ TDxGoogleSearch }

constructor TDxGoogleSearch.Create;
begin
  {$ifdef USE_D2009}
  HttpReq := CoXMLHTTP.Create;
  {$ELSE}
  HttpReq := CoXMLHTTPRequest.Create;
  {$ENDIF}
  ClearOld := True;
  FRecords := TDxSearchRecords.Create;
  FVersion := '1.0';
  FSearchType := Sh_Web;
  FBigSearchSize := True;
  FSearchStart := 0;
end;

destructor TDxGoogleSearch.Destroy;
begin
  HttpReq := nil;
  SetLength(Pages,0);
  FRecords.Free;
  inherited;
end;

function TDxGoogleSearch.GetPageCount: Integer;
begin
  Result := High(Pages) + 1;
end;

function TDxGoogleSearch.NextSearch: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to High(Pages) do
  begin
    if Pages[i] = FSearchStart then
    begin
      if i + 1 <= High(Pages) then
      begin
        FSearchStart := Pages[i + 1];
        Result := True;
      end;
      Break;
    end;
  end;
  if Result then
    Search(FCurSearchInfo);
end;

procedure TDxGoogleSearch.Search(SearchInfo: string);
const
  BaseUrl = 'http://ajax.googleapis.com/ajax/services/search/';
var
  Url: string;
  Json: TlkJsonObject;
  ChildJson,tmpJson: TlkJSONbase;
  SRecord: TDxSearchRecord;
  procedure OnSearch;
  var
    i: Integer;
  begin
      Url := Url + '&start='+inttostr(FSearchStart);
      HttpReq.open('Get', Url, False, EmptyParam, EmptyParam);
      HttpReq.send(EmptyParam);//start search
      Url := HttpReq.responseText;
      Json := Tlkjson.ParseText(url) as TlkJSONobject;
      ChildJson := Json.Field['responseData'];
      if ChildJson.SelfType = jsObject then
      begin
        ChildJson := ChildJson.Field['results'];
        if ChildJson.SelfType = jsList then
        begin
          for i := 0 to ChildJson.Count - 1 do
          begin
            tmpJson := ChildJson.Child[i];
            SRecord := TDxSearchRecord.Create;
            SRecord.FromJsonObj(tmpJson as TlkJSONobject);
            FRecords.List.Add(SRecord);
          end;
        end;
        if ClearOld or (Length(Pages) = 0) then
        begin
          //view page,get page
          ChildJson := Json.Field['responseData'].Field['cursor'].Field['pages'];
          if ChildJson.SelfType = jsList then
          begin
            SetLength(Pages,ChildJson.Count);
            for i := 0 to ChildJson.Count - 1 do
            begin
              tmpJson := ChildJson.Child[i];
              Pages[i] := StrToInt(VarToStr(tmpJson.Field['start'].Value));
            end;
          end;
          ChildJson := Json.Field['responseData'].Field['cursor'];
          FCurPageIndex := strtoint(vartostr(ChildJson.Field['currentPageIndex'].Value));
        end
        else
        begin
          ChildJson := Json.Field['responseData'].Field['cursor'];
          FCurPageIndex := strtoint(vartostr(ChildJson.Field['currentPageIndex'].Value));
        end;                      
      end;
      Json.Free;           
  end;
begin
  FCurSearchInfo := SearchInfo;
  case FSearchType of
  Sh_Web: Url := BaseUrl + 'web?v='+FVersion+'&q=';
  Sh_Local: Url := BaseUrl + 'local?v='+FVersion+'&q=';
  Sh_Video: Url := BaseUrl + 'video?v='+FVersion+'&q=';
  Sh_Blog: Url := BaseUrl + 'blogs?v='+FVersion+'&q=';
  Sh_News: Url := BaseUrl + 'news?v='+FVersion+'&q=';
  Sh_Book: Url := BaseUrl + 'books?v='+FVersion+'&q=';
  Sh_Image: Url := BaseUrl + 'images?v='+FVersion+'&q=';
  Sh_patent: Url := BaseUrl + 'patent?v='+FVersion+'&q=';
  else Url := '';
  end;
  if Url <> '' then
  begin
    FRecords.FSearchType := FSearchType;
    if ClearOld then
      FRecords.Clear;
    Url := Url + ToUTF8Encode(SearchInfo);
    if FBigSearchSize then
      Url := Url + '&rsz=large'
    else Url := Url + '&rsz=small';    
    if FSearchStart < 0 then
    begin
      //return all search results
      ClearOld := False;
      FSearchStart := 0;
      OnSearch;
      while NextSearch do;//search next     
    end
    else
    begin
      OnSearch;
    end;
  end;
end;

{ TDxSearchRecord }

constructor TDxSearchRecord.Create;
begin
  RetList := TStringList.Create;
end;

destructor TDxSearchRecord.Destroy;
begin
  RetList.Free;
  inherited;
end;

function TDxSearchRecord.FieldByName(FieldName: string): string;
var
  index: Integer;
begin
  index := RetList.IndexOfName(FieldName);
  if (index > -1) and (index < FieldCount) then
    Result := RetList.ValueFromIndex[index]
  else Result := '';
end;

procedure TDxSearchRecord.FromJsonObj(JsonObj: TlkJsonObject);
var
  i: Integer;
  str: String;
begin
  RetList.Clear;
  for i := 0 to JsonObj.Count - 1 do
  begin
    str := JsonObj.NameOf[i];
    str := str + '=' + VarToStr(JsonObj.FieldByIndex[i].Value);
    RetList.Add(str);
  end;
end;

function TDxSearchRecord.GetFieldCount: Integer;
begin
  Result := RetList.Count;
end;

function TDxSearchRecord.GetFields(index: Integer): string;
begin
  if (index > -1) and (index < FieldCount) then
    Result := RetList.Names[index]
  else Result := '';
end;

function TDxSearchRecord.GetValues(index: Integer): string;
begin
  if (index > -1) and (index < FieldCount) then
    Result := RetList.ValueFromIndex[index]
  else Result := '';
end;

{ TDxSearchRecords }

procedure TDxSearchRecords.Clear;
begin
  while List.Count > 0 do
  begin
    TDxSearchRecord(List[List.Count - 1]).Free;
    List.Delete(List.Count - 1);
  end;
end;

constructor TDxSearchRecords.Create;
begin
  List := TList.Create;
  FSearchType := Sh_Web;
end;

destructor TDxSearchRecords.Destroy;
begin
  clear;
  List.Free;
  inherited;
end;

function TDxSearchRecords.GetCount: Integer;
begin
  Result := List.Count;
end;

function TDxSearchRecords.GetRecords(index: Integer): TDxSearchRecord;
begin
  if (index > -1) and (index < Count) then
    Result := List[index]
  else Result := nil;
end;

end.
