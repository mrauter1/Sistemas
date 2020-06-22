unit Ladder.Parser;

interface

uses
  System.SysUtils, Variants, Utils, SynCommons;

type
  EParseException = class(Exception)
  public
    Expression: String;
    Pos: Integer;
    constructor Create(const Msg: String; const pExpression: String; pPos: Integer);
  end;

  TFunElementEval = procedure(const pElement: String; var Return: Variant) of object;
  TFunSqlEval = procedure(const pSql: String; var Return: Variant) of object;

  TFunTranslateValue = function (const pValue: Variant): String of object;

  TActivityParser = class
  private
//    FLenExpression: Integer;
    FExpression: string;
    FOnElementEval: TFunElementEval;
    FOnSqlEval: TFunSqlEval;
    FFormatSettings: TFormatSettings;
    procedure SetExpression(const Value: String);
    function LenExpression: Integer;
    procedure ParseOtherExpression(pNewExpression: String; var Return: Variant);
    function FunLiteralTranslation(const pValue: Variant): String;
  protected
    function ExtractTextDelimitedBy(var Index: Integer; const OpenDelimiter, CloseDelimiter: String; NeedCloseDelimiter: Boolean = True): String; overload; virtual;
    function ExtractTextDelimitedBy(var Index: Integer; const OpenDelimiter, CloseDelimiter: String; pDoInterpolation: Boolean; pFunTranslateValue: TFunTranslateValue; NeedCloseDelimiter: Boolean = True): String; overload; virtual;
    function Ignore(var Index: Integer): Boolean; virtual; // Retorna verdadeiro se chegou no fim da string
    procedure IgnoreAndErrorIfEOL(var Index: Integer; const Msg: String); virtual;
    procedure ParseNumber(var Index: Integer; var Return: Variant); virtual;
    procedure ParseString(var Index: Integer; var Return: Variant); virtual;
    procedure ParseList(var Index: Integer; var Return: Variant); virtual;
    procedure ParseElement(var Index: Integer; var Return: Variant); virtual;
    procedure ParseSQL(var Index: Integer; var Return: Variant); virtual;
    procedure ParseNext(var Index: Integer; var Return: Variant); virtual;
    function GetValueAtIndex(const pList: Variant; var Index: Integer): Variant; virtual;
  public
    constructor Create;
    procedure DoParseExpression(pExpression: String; var Return: Variant);

    class procedure ParseExpression(pExpression: String; var Return: Variant; pOnElementEval: TFunElementEval);

    // Try to parse an expression. If expression can't be parsed this function returns false and variable Return evaluate to null
    // For syntax checking only use ladder.SyntaxChecker.TSyntaxChecker to not produce side-effects.
    class function TryParseExpression(pExpression: String; var Return: Variant; pOnElementEval: TFunElementEval): Boolean; overload;
    // Try to parse an expression. If expression can't be parsed this function returns false and variable Return evaluate to pDefaultValue
    class function TryParseExpression(pExpression: String; var Return: Variant; pDefaultValue: Variant; pOnElementEval: TFunElementEval): Boolean; overload;


    property Expression: String read FExpression write SetExpression;
    property OnElementEval: TFunElementEval read FOnElementEval write FOnElementEval;
    property OnSqlEval: TFunSqlEval read FOnSqlEval write FOnSqlEval;
  const
    KeyWords = [',', '[', ']', '"', '@', '$', '!'];
  end;

  // TSyntaxChecker will setup a parser that does the following:
  // Any function that can cause side effects and/or has to connect to an external resource is not executed, but interpolations will be parsed (ex.: Sql).
  // indexes of list will be treated as a list itself (will not check if value is a valid list or index exists).
  // Elements will be checked to exist, but their values will evaluate to nil
  // Returns true when expression can be parsed with no errors, false otherwise.
  TSyntaxChecker = class(TObject)
  private
    FOnElementEval: TFunElementEval;
    FOnSqlEval: TFunSqlEval;
    FParser: TActivityParser;
    type
      TSyntaxCheckerParser = class(TActivityParser)
      protected
        // Since GetValueAtIndex expect a list as pList parameter and values from external resources won't evaluate correctly to lists when checking the syntax, it must be overriden.
        // Will attempt to parse as a list instead.
        function GetValueAtIndex(const pList: Variant; var Index: Integer): Variant; override;
      end;

    procedure InternalElementEval(const pElement: String; var Return: Variant);
    procedure InternalSqlEval(const pSql: String; var Return: Variant);
  public
    // AParser will be cloned internally, none of its functions will be directly called
    constructor Create(AParser: TActivityParser); overload;
    constructor Create(AOnElementEval: TFunElementEval; AOnSqlEval: TFunSqlEval); overload;
    Destructor Destroy; override;

    function DoCheckSyntax(AExpression: String; out ErrorMessage: String): Boolean;

    // Returns true when expression there are no syntax errors, false otherwise.
    class function CheckSyntax(AParser: TActivityParser; AExpression: String; out ErrorMessage: string): Boolean;
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
  FData: TDocVariantData;
begin
  if FExpression[Index]='!' then
  begin
    FDoInterpolation:= False;
    Inc(Index);
  end
 else
   FDoInterpolation:= True;

  FSql:= ExtractTextDelimitedBy(Index, '$', '$', FDoInterpolation, FunLiteralTranslation, False);

  if Trim(FSql) = '' then
    raise EParseException.Create('ParseSQL: Empty Sql Expression.', FExpression, Index);

  FSingleValue:= FSql[1] = '@';
  if FSingleValue then
    Delete(FSql, 1, 1);

  if not Assigned(FOnSqlEval) then
    raise Exception.Create('ParseSQL: There is no Sql evaluator assigned.');

  FOnSqlEval(FSql, Return);

  if not DocVariantType.IsOfType(Return) then
    raise Exception.Create(Format('ParseSQL: Return value of OnSqlEval must be TDocVariantData. Expression: "%s". Pos: %d', [FExpression, Index]));

  FData:= TDocVariantData(Return);
  if FSingleValue then
  begin
    if FData.Count>0 then
      Return:=FData._[0]^.Values[0]
    else
      Return:=null;
  end;
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
  if DocVariantType.IsOfType(pValue) then
  begin
    Result:= '';
    for I := 0 to pValue._Count-1 do
      AppendValue(Result, pValue._(I));

    Result:= '['+Result+']';
  end
 else
  Result:= VarToStrDef(pValue, '');

end;

procedure TActivityParser.ParseNumber(var Index: Integer; var Return: Variant);
const
  cStopChars = [' '];
var
  FHasDecimal: Boolean;
  FStart: Integer;
begin
  FHasDecimal:= False;
  FStart:= Index;
  while (Index<=LenExpression) do
  begin
    if FExpression[Index] in ['0'..'9'] then
    begin
      Inc(Index);
      Continue;
    end
    else if FExpression[Index] = '.' then
    begin
      if (Index = FStart) or FHasDecimal then
        raise EParseException.Create('TActivityParser.ParseNumber: Invalid Number.', FExpression, Index);

      Inc(Index);
      FHasDecimal:= True;
      Continue;
    end
   else if (FExpression[Index] in cStopChars) or (FExpression[Index] in KeyWords) then
     Break
   else
     raise EParseException.Create('TActivityParser.ParseNumber: Invalid Number.', FExpression, Index);
  end;

  if FHasDecimal then
    Return:= StrToFloat(Copy(FExpression, FStart, Index-FStart), FFormatSettings)
  else
    Return:= StrToInt(Copy(FExpression, FStart, Index-FStart));
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

class function TActivityParser.TryParseExpression(pExpression: String;
  var Return: Variant; pDefaultValue: Variant; pOnElementEval: TFunElementEval): Boolean;
begin
  Result:= True;
  try
    TActivityParser.ParseExpression(pExpression, Return, pOnElementEval);
  except
    Return:= pDefaultValue;
    Result:= False;
  end;
end;

class function TActivityParser.TryParseExpression(pExpression: String;
  var Return: Variant; pOnElementEval: TFunElementEval): Boolean;
begin
  Result:= TActivityParser.TryParseExpression(pExpression, Return, null, pOnElementEval);
end;

procedure TActivityParser.ParseList(var Index: Integer; var Return: Variant);
const
  sListaAberta = 'ParseList: Closing bracket "]" expected end of expression found.';
var
  FItem: Variant;
begin
  IgnoreAndErrorIfEOL(Index, 'ParseList: Expecting list, end of expression found.');

  if FExpression[Index] <> '[' then
    raise EParseException.Create('ParseList: List must start with "[".', FExpression, Index);

  Inc(Index);
  Return:= _Arr([]); // Incializa Empty Array

  while True do
  begin
    IgnoreAndErrorIfEOL(Index, sListaAberta); // Ignora caracteres em branco

    case Ord(FExpression[Index]) of
      Ord(','): begin
                  Inc(Index);
                  IgnoreAndErrorIfEOL(Index, sListaAberta); // Ignora caracteres em branco
                  ParseNext(Index, FItem);
                  TDocVariantData(Return).AddItem(FItem)
                end;
      Ord(']'): begin Inc(Index); Break; end;
    else begin
        ParseNext(Index, FItem);
        TDocVariantData(Return).AddItem(FItem)
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
  IgnoreAndErrorIfEOL(Index, 'ParseElement: Element expected, end of expression found.');

  if FExpression[Index] <> '@' then
    raise EParseException.Create('ParseElement: Element must start with "@".', FExpression, Index);

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
    raise EParseException.Create('ParseElement: Invalid element.', FExpression, FStart);

  FElementName:= Copy(FExpression, FStart, Index-FStart);

  if not Assigned(FOnElementEval) then
    raise EParseException.Create('ParseElement: There is not element evaluator assigned.', FExpression, FStart);

  FOnElementEval(FElementName, Return);
end;

function TActivityParser.GetValueAtIndex(const pList: Variant; var Index: Integer): Variant;
var
  FIndexName: String;
  FVarIndexName: Variant;
  FListIndex: Integer;

  function GetValueFromIndexName(const pList: Variant; const pIndexName: String): Variant;
  var
    I: Integer;
  begin
    I:= TDocVariantData(pList).GetValueIndex(pIndexName);
    if I < 0 then
      raise EParseException.Create('TActivityParser.GetValueAtIndex: Index "'+pIndexName+'" not found.', FExpression, Index);

    Result:= TDocVariantData(pList).Values[I];
  end;

begin
  if not DocVariantType.IsOfType(pList) then
    raise EParseException.Create('TActivityParser.GetValueAtIndex: Value is not list.', FExpression, Index);

  FIndexName:= ExtractTextDelimitedBy(Index, '[', ']');
  if FIndexName.IsEmpty then
    raise EParseException.Create('TActivityParser.GetValueAtIndex: Index must not be empty.', FExpression, Index);

  if FIndexName[1]='"' then // Named Index
  begin
    Self.ParseOtherExpression(FIndexName, FVarIndexName);
    Result:= GetValueFromIndexName(pList, FVarIndexName);
  end
 else
  begin
    if not TryStrToInt(FIndexName, FListIndex) then
      raise EParseException.Create('TActivityParser.GetValueAtIndex: Invalid index.', FExpression, Index);

    Result:= TDocVariantData(pList).Values[FListIndex];
  end;
end;

procedure TActivityParser.ParseNext(var Index: Integer; var Return: variant);
begin
  if Ignore(Index) then // Ignore blank chars
  begin // if has reached end of expression returns null
    Return:= null;
    Exit;
  end;

  Case Ord(FExpression[Index]) of
    Ord('@'): ParseElement(Index, Return); //Might be an input or Output element from a Process/Activity
    Ord('['): ParseList(Index, Return); //List
    Ord('"'): ParseString(Index, Return); // String
    Ord('$'): ParseSQL(Index, Return); // String
    Ord('!'): case Ord(FExpression[Index+1]) of // Symbol to String or Sql without doing interpolation
                Ord('"'): ParseString(Index, Return); // String
                Ord('$'): ParseSQL(Index, Return); // Sql
              else
                raise EParseException.Create('ParseNext: String or SQL expected after "!" symbol.', FExpression, Index);
              end;
    else if FExpression[Index] in (['0'..'9']) then
      ParseNumber(Index, Return) // Number
    else
      raise EParseException.Create('ParseNext: Identificador desconhecido', FExpression, Index);
  end;

  while Index<=LenExpression do
    if FExpression[Index]='[' then // if there is an open bracket here, it must be an index
      Return:= GetValueAtIndex(Return, Index)
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
  FFormatSettings:= TFormatSettings.Create;
  FFormatSettings.DecimalSeparator:= '.';
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

  if Expression.IsEmpty then
  begin
    Return:= null;
    Exit;
  end;

  if ((FExpression[1] in KeyWords) or (FExpression[1] in (['0'..'9']))) = False then // If Expression does not start with a keyword or numerical, treat it as a single string
  begin
    Return:= Expression;
    Exit;
  end;

  try
    ParseNext(Index, Return);

    if not Ignore(Index) then
      raise EParseException.Create('DoParseExpression: End of expression expected, but invalid command found.', FExpression, Index);
  except
    on E: EParseException do
      raise;

    on E: Exception do
      raise EParseException.Create('TActivityParser.DoParseExpression: Exception ocurred on execution: '+E.ToString, FExpression, Index);

  end;
end;

function TActivityParser.ExtractTextDelimitedBy(var Index: Integer;
  const OpenDelimiter, CloseDelimiter: String; NeedCloseDelimiter: Boolean = True): String;
begin
  Result:= ExtractTextDelimitedBy(Index, OpenDelimiter, CloseDelimiter, False, nil, NeedCloseDelimiter);
end;

function TActivityParser.ExtractTextDelimitedBy(var Index: Integer;
  const OpenDelimiter, CloseDelimiter: String; pDoInterpolation: Boolean;
  pFunTranslateValue: TFunTranslateValue; NeedCloseDelimiter: Boolean = True): String;

  function ReplaceInterpolation(var Index: Integer): String;
  var
    FStart: Integer;
    FSubExpression: String;
    FTranslatedExpresion: String;
    FValue: variant;
  begin
    FStart:= Index;
    FSubExpression:= ExtractTextDelimitedBy(Index, '{', '}');

    Delete(FExpression, FStart, Index-FStart);
    ParseOtherExpression(FSubExpression, FValue);

    Assert(Assigned(pFunTranslateValue), 'TActivityParser.ExtractTextDelimitedBy: pFunTranslateValue must be assigned!');
    // Try to translate the value returned by the subExpression to a valid expression inside macro expression
    FTranslatedExpresion:= pFunTranslateValue(FValue);

    Insert(FTranslatedExpresion, FExpression, FStart);
    Index:= FStart+Length(FTranslatedExpresion);
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

  if (Copy(FExpression, Index, Length(CloseDelimiter)) <> CloseDelimiter) and NeedCloseDelimiter then
    raise EParseException.Create('GetStringDelimitedBy: Expecting closing delimiter "'+CloseDelimiter+'". End of statement reached.', FExpression, Index);

  if (Index<=LenExpression) then // if it has reached the End of expression there is no need to increase the index
    Inc(Index, Length(CloseDelimiter));
end;

{ TSyntaxCheckerParser }

function TSyntaxChecker.TSyntaxCheckerParser.GetValueAtIndex(const pList: Variant;
  var Index: Integer): Variant;
begin
  ParseList(Index, Result);
end;

{ TSyntaxChecker }

class function TSyntaxChecker.CheckSyntax(AParser: TActivityParser;
  AExpression: String; out ErrorMessage: string): Boolean;
var
  FSyntaxChecker: TSyntaxChecker;
begin
  FSyntaxChecker:= TSyntaxChecker.Create(AParser);
  try
    Result:= FSyntaxChecker.DoCheckSyntax(AExpression, ErrorMessage);
  finally
    FSyntaxChecker.Free;
  end;
end;

constructor TSyntaxChecker.Create(AParser: TActivityParser);
begin
  Create(AParser.OnElementEval, AParser.OnSqlEval);
end;

constructor TSyntaxChecker.Create(AOnElementEval: TFunElementEval; AOnSqlEval: TFunSqlEval);
begin
  inherited Create;
  FOnElementEval:= AOnElementEval;
  FOnSqlEval:= AOnSqlEval;

  FParser:= TSyntaxCheckerParser.Create;
  if Assigned(AOnElementEval) then
    FParser.OnElementEval:= InternalElementEval;

  if Assigned(AOnSqlEval) then
    FParser.OnSqlEval:= InternalSqlEval;
end;

procedure TSyntaxChecker.InternalElementEval(const pElement: String; var Return: Variant);
begin
  Assert(Assigned(FOnElementEval), 'TSyntaxChecker.InternalElementEval: FOnElementEval must be Assigned');
  FOnElementEval(pElement, Return);
  Return:= null;
end;

procedure TSyntaxChecker.InternalSqlEval(const pSql: String; var Return: Variant);
begin
  Assert(Assigned(FOnSqlEval), 'TSyntaxChecker.InternalSqlEval: FOnSqlEval must be Assigned');
//  FOnElementEval(pSql, Return); // Should not be executed
  Return:= _Arr([]);
end;

destructor TSyntaxChecker.Destroy;
begin
  FParser.Free;
end;

function TSyntaxChecker.DoCheckSyntax(AExpression: String; out ErrorMessage: String): Boolean;
var
  FReturn: Variant;
begin
  Result:= True;
  ErrorMessage:= '';
  try
    FParser.DoParseExpression(AExpression, FReturn);
  except
    on E: Exception do
    begin
      Result:= False;
      ErrorMessage:= E.Message
    end;
  end;
end;

end.

