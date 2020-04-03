unit Ladder.Activity.Parser;

interface

uses
  System.SysUtils, Variants, Utils;

type
  EParseException = class(Exception)
  public
    Expression: String;
    Pos: Integer;
    constructor Create(const Msg: String; const pExpression: String; pPos: Integer);
  end;

  TFunElementEval = procedure(pElement: String; var Return: Variant) of object;
  TFunSqlEval = procedure(pSql: String; var Return: Variant) of object;

  TFunTranslateValue = function (const pValue: Variant): String of object;

  TActivityParser = class
  private
//    FLenExpression: Integer;
    FExpression: string;
    FOnElementEval: TFunElementEval;
    FOnSqlEval: TFunSqlEval;
    procedure SetExpression(const Value: String);
    function LenExpression: Integer;

    procedure ParseOtherExpression(pNewExpression: String; var Return: Variant);
    procedure GetValueAtIndex(const pList: Variant; var Index: Integer; var Return: Variant);
    function FunLiteralTranslation(const pValue: Variant): String;
  protected
    function ExtractTextDelimitedBy(var Index: Integer; const OpenDelimiter, CloseDelimiter: String): String; overload;
    function ExtractTextDelimitedBy(var Index: Integer; const OpenDelimiter, CloseDelimiter: String; pDoInterpolation: Boolean; pFunTranslateValue: TFunTranslateValue): String; overload;
    function Ignore(var Index: Integer): Boolean; // Retorna verdadeiro se chegou no fim da string
    procedure IgnoreAndErrorIfEOL(var Index: Integer; const Msg: String);
    procedure ParseString(var Index: Integer; var Return: Variant);
    procedure ParseList(var Index: Integer; var Return: Variant);
    procedure ParseNext(var Index: Integer; var Return: Variant);
    procedure ParseElement(var Index: Integer; var Return: Variant);
    procedure ParseSQL(var Index: Integer; var Return: Variant);
  public
    constructor Create;
    procedure DoParseExpression(pExpression: String; var Return: Variant);

    class procedure ParseExpression(pExpression: String; var Return: Variant; pOnElementEval: TFunElementEval);

    property Expression: String read FExpression write SetExpression;
    property OnElementEval: TFunElementEval read FOnElementEval write FOnElementEval;
    property OnSqlEval: TFunSqlEval read FOnSqlEval write FOnSqlEval;
  const
    KeyWords = [',', '[', ']', '"', '@', '$', '!'];
  end;

implementation

{ EParseException }

constructor EParseException.Create(const Msg, pExpression: String; pPos: Integer);
begin
  Expression:= pExpression;
  Pos:= pPos;
  inherited Create(Msg+'; Expression: '+pExpression+'; Pos: '+IntToStr(pPos));
end;

{ TActivityParser }

function TActivityParser.Ignore(var Index: Integer): Boolean; // Retorna verdadeiro se chegou no fim da string
begin
  Result:= False;
  while True do
    if Index > LenExpression then
      Break // Break and return True
    else if FExpression[Index]=' ' then
      Inc(Index)
    else Exit; // Exit and return False

  Result:= True;
end;

procedure TActivityParser.IgnoreAndErrorIfEOL(var Index: Integer; const Msg: String);
begin
  if Ignore(Index) then
    raise EParseException.Create(Msg, FExpression, Index);
end;

function TActivityParser.LenExpression: Integer;
begin
  Result:= Length(FExpression);
end;

procedure TActivityParser.ParseSQL(var Index: Integer; var Return: Variant);
var
  FSql: String;
  FSingleValue: Boolean;
  FDoInterpolation: Boolean;
begin
  FDoInterpolation:= FExpression[Index]='!';
  if FDoInterpolation then
    Inc(Index);

  FSql:= ExtractTextDelimitedBy(Index, '$', '$', FDoInterpolation, FunLiteralTranslation);

  if FSql = '' then
    raise EParseException.Create('TActivityParser.ParseSQL: Empty Sql Expression!', FExpression, Index);

  FSingleValue:= FSql[1] = '@';

  if FSingleValue then
    Delete(FSql, 1, 1);

  if not Assigned(FOnSqlEval) then
    raise EParseException.Create('TActivityParser.ParseSQL: pOnSqlEval must be assgined!', FExpression, Index);

  FOnSqlEval(FSql, Return);
  if FSingleValue then
    if VarArrayLength(Return)>0 then
      Return:=Return[0][0]
    else
      Return:=null;
end;

function TActivityParser.FunLiteralTranslation(const pValue: Variant): String;
var
  I: Integer;

  procedure AppendValue(var pSource: String; const pValue: Variant);
  var
    FText: String;
  begin
    if VarIsStr(pValue) then
      FText:= '"'+pValue+'"'
    else
      FText:= FunLiteralTranslation(pValue);

    if pSource='' then
      pSource:= FText
    else
      pSource:= pSource+', '+FText;
  end;

begin
  if VarIsArray(pValue) then
  begin
    Result:= '';
    for I := 0 to VarArrayLength(pValue)-1 do
      AppendValue(Result, pValue[I]);

    Result:= '['+Result+']';
  end
 else
  Result:= VarToStrDef(pValue, '');

end;

procedure TActivityParser.ParseString(var Index: Integer; var Return: Variant);
var
  FDoInterpolation: Boolean;
begin
  FDoInterpolation:= True;
  if FExpression[Index]='!' then
  begin
    FDoInterpolation:= False;
    Inc(Index);
  end;

  Return:= ExtractTextDelimitedBy(Index, '"', '"', FDoInterpolation, FunLiteralTranslation);
end;

procedure TActivityParser.SetExpression(const Value: String);
begin
  FExpression := Value;
//  FLenExpression:= Length(FExpression);
end;

procedure TActivityParser.ParseList(var Index: Integer; var Return: Variant);
const
  sListaAberta = 'ParseList: Lista não fechada, esperado "[" encontrado fim da linha.';
var
  FItem: Variant;
  pIdItem: Integer;
  FItemBefore: Boolean;

  procedure AddItem(const pItem: Variant);
  begin
    inc(pIdItem);
    VarArrayRedim(Return, pIdItem);
    Return[pIdItem]:= pItem;
    FItemBefore:= True;
  end;

begin
  IgnoreAndErrorIfEOL(Index, 'ParseList: Esperando lista, nada recebido.');

  if FExpression[Index] <> '[' then
    raise EParseException.Create('ParseList: Deve iniciar com "[".', FExpression, Index);

  Inc(Index);
  pIdItem:= -1;
  FItemBefore:= False;
  Return:= VarArrayCreate([0,-1], varVariant); // Incializa Empty Array

  while True do
  begin
    IgnoreAndErrorIfEOL(Index, sListaAberta); // Ignora caracteres em branco

    case Ord(FExpression[Index]) of
      Ord(','): begin
                  Inc(Index);
                  IgnoreAndErrorIfEOL(Index, sListaAberta); // Ignora caracteres em branco
                  ParseNext(Index, FItem);
                  AddItem(FItem);
                end;
      Ord(']'): begin Inc(Index); Break; end;
    else begin
        ParseNext(Index, FItem);
        AddItem(FItem);
      end;
//      raise EParseException.Create('ParseList: Esperado "," ou "]", recebido '+FExpression[Index]+'.', FExpression, Index);
    end;
  end;
end;

procedure TActivityParser.ParseElement(var Index: Integer; var Return: Variant);
var
  FStart: Integer;
  FElementName: String;

const
  cStopChar = [' ', ',', '[', ']', '"', '@'];
begin
  IgnoreAndErrorIfEOL(Index, 'ParseElement: Esperando elemento, nada recebido.');

  if FExpression[Index] <> '@' then
    raise EParseException.Create('ParseElement: Esperado "@" encontrado "'+FExpression[Index]+'".', FExpression, Index);

  Inc(Index);

  FStart:= Index;

  while True do
  begin
    if Index > LenExpression then
      break;

    if FExpression[Index] in cStopChar then
      break;

    if FExpression[Index] = #13 then
      break;

    inc(Index);
  end;

  if FStart >= Index then
    raise EParseException.Create('ParseElement: Nome do elemento inválido!', FExpression, FStart);

  FElementName:= Copy(FExpression, FStart, Index-FStart);

  if not Assigned(FOnElementEval) then
    raise EParseException.Create('TActivityParser.ParseElement: pFunElementEval precisa ser passado como parâmetro!', FExpression, FStart);

  FOnElementEval(FElementName, Return);
end;

procedure TActivityParser.GetValueAtIndex(const pList: Variant; var Index: Integer; var Return: Variant);
var
  FIndexName: String;
  FVarIndexName: Variant;
  FListIndex: Integer;

  function GetIndexValueFromIndexName(const pList: Variant; const pIndexName: String): Integer;
  var
    FNamedIndices: Variant;
    I: Integer;
  begin
    if VarArrayLowBound(pList, 1) > -1 then
      raise EParseException.Create('TActivityParser.GetValueAtIndex: List does not have named indices.', FExpression, Index);

    FNamedIndices:= pList[-1];
    for I := 0 to VarArrayLength(FNamedIndices)-1 do
      if UpperCase(pIndexName) = UpperCase(FNamedIndices) then
      begin
        Result:= I;
        Exit;
      end;

    raise EParseException.Create('TActivityParser.GetValueAtIndex: Index "'+pIndexName+'" not found.', FExpression, Index);
  end;

begin
  if not VarIsArray(pList) then
    raise EParseException.Create('TActivityParser.GetValueAtIndex: Value is not list.', FExpression, Index);

  FIndexName:= ExtractTextDelimitedBy(Index, '[', ']');
  if FIndexName.IsEmpty then
    raise EParseException.Create('TActivityParser.GetValueAtIndex: Index must not be empty.', FExpression, Index);

  if FIndexName[1]='"' then
  begin
    Self.ParseOtherExpression(FIndexName, FVarIndexName);
    FListIndex:= GetIndexValueFromIndexName(pList, FVarIndexName);
  end
  else
    if not TryStrToInt(FIndexName, FListIndex) then
      raise EParseException.Create('TActivityParser.GetValueAtIndex: Invalid index.', FExpression, Index);

  Return:= pList[FListIndex];
end;

procedure TActivityParser.ParseNext(var Index: Integer; var Return: variant);
begin
  if Ignore(Index) then // Ignore caracteres em branco
  begin // se chegou no fim da string retorna nulo
    Return:= null;
    Exit;
  end;

  Case Ord(FExpression[Index]) of
    Ord('@'): ParseElement(Index, Return); //Pode ser um input, Output ou Processo
    Ord('['): ParseList(Index, Return); //Lista
    Ord('"'): ParseString(Index, Return); // String
    Ord('$'): ParseSQL(Index, Return); // String
    Ord('!'): case Ord(FExpression[Index+1]) of // Symbol to String or Sql without doing interpolation
                Ord('"'): ParseString(Index, Return); // String
                Ord('$'): ParseSQL(Index, Return); // Sql
              else
                raise EParseException.Create('ParseNext: String or SQL expected after "!" symbol.', FExpression, Index);
              end;
  else
    raise EParseException.Create('ParseNext: Identificador desconhecido', FExpression, Index);
  end;

  while Index<=LenExpression do
    if FExpression[Index]='[' then
      GetValueAtIndex(Return, Index, Return)
    else
      Break;
end;

class procedure TActivityParser.ParseExpression(pExpression: String; var Return: Variant; pOnElementEval: TFunElementEval);
begin
  with TActivityParser.Create do
  try
    FOnElementEval:= pOnElementEval;
    DoParseExpression(pExpression, Return);
  finally
    Free;
  end;
end;

constructor TActivityParser.Create;
begin
  inherited Create;
end;


procedure TActivityParser.ParseOtherExpression(pNewExpression: String; var Return: Variant);
var
  FNewParser: TActivityParser;
begin
  FNewParser:= TActivityParser.Create;
  try
    FNewParser.OnElementEval:= FOnElementEval;
    FNewParser.OnSqlEval:= FOnSqlEval;
    FNewParser.DoParseExpression(pNewExpression, Return);
  finally
    FNewParser.Free;
  end;
end;

procedure TActivityParser.DoParseExpression(pExpression: String; var Return: Variant);
var
  Index: Integer;
begin
  Expression:= pExpression;
  Index:= 1;
  try
    ParseNext(Index, Return);
    if not Ignore(Index) then
      raise EParseException.Create('TActivityParser.DoParseExpression: Comando inválido! Final da expressão esperado.', FExpression, Index);
  except
    on E: EParseException do
      raise;

    on E: Exception do
      raise EParseException.Create('TActivityParser.DoParseExpression: Exception ocurred on execution: '+E.ToString, FExpression, Index);

  end;
end;

function TActivityParser.ExtractTextDelimitedBy(var Index: Integer;
  const OpenDelimiter, CloseDelimiter: String): String;
begin
  Result:= ExtractTextDelimitedBy(Index, OpenDelimiter, CloseDelimiter, False, nil);
end;

function TActivityParser.ExtractTextDelimitedBy(var Index: Integer;
  const OpenDelimiter, CloseDelimiter: String; pDoInterpolation: Boolean;
  pFunTranslateValue: TFunTranslateValue): String;

  function ReplaceInterpolation(var Index: Integer): String;
  var
    FStart: Integer;
    FSubExpression: String;
    FTranslation: String;
    FValue: variant;
  begin
    FStart:= Index;
    FSubExpression:= ExtractTextDelimitedBy(Index, '{', '}');

    Delete(FExpression, FStart, Index-FStart);
    ParseOtherExpression(FSubExpression, FValue);

    Assert(Assigned(pFunTranslateValue), 'TActivityParser.ExtractTextDelimitedBy: pFunTranslateValue must be assigned!');
    FTranslation:= pFunTranslateValue(FValue);

    Insert(FTranslation, FExpression, FStart);
    Index:= FStart+Length(FTranslation);
  end;

var
  FStart: Integer;
begin
  if (OpenDelimiter.IsEmpty) or (CloseDelimiter.IsEmpty) then
    EParseException.Create('GetStringDelimitedBy: Delimiter can''t be empty string.', FExpression, Index);

  Result:= '';
  IgnoreAndErrorIfEOL(Index, 'GetStringDelimitedBy: Expecting delimiter "'+OpenDelimiter+'", end of statement reached.');

  if Copy(FExpression, Index, Length(OpenDelimiter)) <> OpenDelimiter then
    raise EParseException.Create('GetStringDelimitedBy: must start with "'+OpenDelimiter+'".', FExpression, Index);

  Inc(Index, Length(OpenDelimiter));
  FStart:= Index;

  while (Index<=LenExpression) do
  begin
    if FExpression[Index] = CloseDelimiter[1] then
      if Copy(FExpression, Index, Length(CloseDelimiter)) = CloseDelimiter then
        break;

    if (pDoInterpolation and (FExpression[Index] = '{')) then
    begin
      ReplaceInterpolation(Index);
      continue;
    end;

    Inc(Index);
  end;

  Result:= Copy(FExpression, FStart, Index-FStart);

  if Copy(FExpression, Index, Length(CloseDelimiter)) <> CloseDelimiter then
    raise EParseException.Create('GetStringDelimitedBy: Expecting closing delimiter "'+CloseDelimiter+'". End of statement reached.', FExpression, Index);

  Inc(Index, Length(CloseDelimiter));
end;

end.
