unit Ladder.Utils;

interface

uses
  RTTI, SynCommons, SysUtils;

function LadderVarIsList(const pValue: Variant): Boolean;
function LadderVarIsIso8601(const pValue: Variant): Boolean;
function LadderVarIsDateTime(const pValue: Variant): Boolean;
function LadderVarToDateTime(const pValue: Variant): TDateTime;
function LadderDateToStr(pValue: Variant; pQuote: Boolean=False): String;
function LadderVarToStr(pValue: Variant; pDefault: String = ''): String;

function JoinList(const pValue: Variant; const pSeparator: String): String;

function VarToIntDef(pVar: Variant; pDefault: Integer = 0): Integer;
function VarToFloatDef(pVar: Variant; pDefault: Double = 0): Double;

function InheritFromGenericOfType(classType: TRttiType; const genericType: string): Boolean;

function UTF8ToAnsi(const UTF8: RawUTF8): RawByteString;
function AnsiToUTF8(const AnsiText: RawByteString): RawUTF8;

function StrToLadderArray(const AStr: String; ASeparator: String): Variant;
function VarIsLadderArray(AVar: Variant): Boolean;
function DoubleQuote(const AStr: String): String;

var
  SynAnsiConvert: TSynAnsiConvert;
  LadderFormatSettings: TFormatSettings;

implementation

uses
  Variants, Spring.Reflection, StrUtils;

function StrToLadderArray(const AStr: String; ASeparator: String): Variant;
var
  FArray: TArray<String>;
  I: Integer;
begin
  FArray:= AStr.Split([ASeparator]);
  Result:= _Arr([]);

  for I := 0 to Length(FArray)-1 do
    TDocVariantData(Result).AddItem(FArray[I]);
end;

function VarIsLadderArray(AVar: Variant): Boolean;
begin
  Result:= DocVariantType.IsOfType(AVar);
end;

function UTF8ToAnsi(const UTF8: RawUTF8): RawByteString;
begin
  Result:= SynAnsiConvert.UTF8ToAnsi(UTF8);
end;

function AnsiToUTF8(const AnsiText: RawByteString): RawUTF8;
begin
  Result:= SynAnsiConvert.AnsiToUTF8(AnsiText);
end;

function JoinList(const pValue: Variant; const pSeparator: String): String;
var
  I: Integer;

  procedure DoJoin(const pText: String);
  begin
    if Result = '' then
      Result:= pText
    else
      Result:= Result+pSeparator+pText;
  end;
begin
  Result:= '';
  if not LadderVarIsList(pValue) then
    Exit;

  for I := 0 to pValue._Count-1 do
    DoJoin(pValue._(I));

end;

function LadderVarIsList(const pValue: Variant): Boolean;
begin
  Result:= DocVariantType.IsOfType(pValue);
end;

function LadderVarIsIso8601(const pValue: Variant): Boolean;
var
  pAnsi: AnsiString;
begin
  Result:= False;
  pAnsi:= VarToStrDef(pValue, '');

  if length(pAnsi) >= 10 then
    if (pAnsi[5] = '-') and (pAnsi[8] = '-') then
      Result:= Iso8601ToDateTime(pAnsi) <> 0;
end;

function LadderVarIsDateTime(const pValue: Variant): Boolean;
begin
  Result:= False;

  if VarType(pValue) = varDate then
    Result:= True
 else
   Result:= LadderVarIsIso8601(pValue);
end;

function LadderDateToStr(pValue: Variant; pQuote: Boolean=False): String;
begin
  if pQuote then
    Result:= '"'+DateToIso8601(LadderVarToDateTime(pValue), True)+'"'
  else
    Result:= DateToIso8601(LadderVarToDateTime(pValue), True);
end;

function LadderVarToDateTime(const pValue: Variant): TDateTime;
var
  pAnsi: AnsiString;
begin
  pAnsi:= VarToStrDef(pValue, '');
  Result:= Iso8601ToDateTime(pAnsi);
  if Result = 0 then
    Result:= VarToDateTime(pValue);
end;

function VarToFloatDef(pVar: Variant; pDefault: Double = 0): Double;
begin
  if VarIsNull(pVar) then
    Result:= pDefault
  else
  try
    Result:= pVar;
  except
    Result:= pDefault;
  end;
end;

function VarToIntDef(pVar: Variant; pDefault: Integer = 0): Integer;
begin
  if VarIsNull(pVar) then
    Result:= pDefault
  else
  try
    Result:= pVar;
  except
    Result:= pDefault;
  end;
end;

function LadderVarToStr(pValue: Variant; pDefault: String = ''): String;
begin
  if LadderVarIsDateTime(pValue) then
    Result:= LadderDateToStr(pValue, True)
  else if VarIsFloat(pValue) then
    Result:= FloatToStr(pValue, LadderFormatSettings)
  else
    Result:= VarToStrDef(pValue, '');
end;

function InheritFromGenericOfType(classType: TRttiType; const genericType: string): Boolean;
var
  baseType: TRttiType;

  function GetGenericTypeDefinition(classType: TRttiType): String;
  begin
    if not classType.IsGenericType then
      Result:= ''
    else
      Result := Copy(classType.Name, 0, Pos('<', classType.Name)) + DupeString(',', High(classType.GetGenericArguments)) + '>';
  end;

begin
  if SameText(GetGenericTypeDefinition(ClassType), genericType)  then
    Result := True
  else
  begin
    baseType := classType.BaseType;
    Result := Assigned(baseType) and InheritFromGenericOfType(baseType, genericType);
  end;
end;

function DoubleQuote(const AStr: String): String;
begin
  Result:= '"'+AStr+'"';
end;

initialization
  SynAnsiConvert:= TSynAnsiConvert.Engine(0); // Windows current code page;
  LadderFormatSettings:= TFormatSettings.Create();
  LadderFormatSettings.DecimalSeparator:= '.';

end.
