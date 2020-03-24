unit Ladder.Activity.Parser;

interface

uses
  System.SysUtils, Variants;

type
  EParseException = class(Exception)
  public
    Expression: String;
    Pos: Integer;
    constructor Create(const Msg: String; const pExpression: String; pPos: Integer);
  end;

  TFunElementEval = function(pElement: String): Variant of object;

  TActivityParser = class
  private
    FLenExpression: Integer;
    FExpression: string;
    FFunElementEval: TFunElementEval;
    procedure SetExpression(const Value: String);
  protected
    function Ignore(var Index: Integer): Boolean; // Retorna verdadeiro se chegou no fim da string
    procedure IgnoreAndErrorIfEOL(var Index: Integer; const Msg: String);
    function ParseString(var Index: Integer): String;
    function ParseList(var Index: Integer): Variant;
    function ParseNext(var Index: Integer): Variant;
    function ParseElement(var Index: Integer): variant;
    function DoParseExpression(pExpression: String): variant;
  public
    class function ParseExpression(pExpression: String; pFunElementEval: TFunElementEval): variant;

    property Expression: String read FExpression write SetExpression;
    property FunElementEval: TFunElementEval read FFunElementEval write FFunElementEval;
  const
    KeyWords = [',', '[', ']', '"', '@'];
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
    if Index > FLenExpression then
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

function TActivityParser.ParseString(var Index: Integer): String;
var
  FStart: Integer;
begin
  Result:= '';
  IgnoreAndErrorIfEOL(Index, 'ParseString: Esperando String, nada recebido.');

  if FExpression[Index] <> '"' then
    raise EParseException.Create('ParseString: Deve iniciar com ".', FExpression, Index);

  Inc(Index);
  FStart:= Index;

  while (Index<=FLenExpression) and (FExpression[Index]<>'"') do
    Inc(Index);

  Result:= Copy(FExpression, FStart, Index-FStart);

  if FExpression[Index] <> '"' then
    raise EParseException.Create('ParseString: String não fechada.', FExpression, Index);

  Inc(Index);
end;

procedure TActivityParser.SetExpression(const Value: String);
begin
  FExpression := Value;
  FLenExpression:= Length(FExpression);
end;

function TActivityParser.ParseList(var Index: Integer): variant;
const
  sListaAberta = 'ParseList: Lista não fechada, esperado "[" encontrado fim da linha.';
var
  pIdItem: Integer;
  FItem: Variant;
  FItemBefore: Boolean;

  procedure AddItem(pItem: Variant);
  begin
    inc(pIdItem);
    VarArrayRedim(Result, pIdItem);
    Result[pIdItem]:= pItem;
    FItemBefore:= True;
  end;

begin
  IgnoreAndErrorIfEOL(Index, 'ParseList: Esperando lista, nada recebido.');

  if FExpression[Index] <> '[' then
    raise EParseException.Create('ParseList: Deve iniciar com "[".', FExpression, Index);

  Inc(Index);
  pIdItem:= -1;
  FItemBefore:= False;
  Result:= VarArrayCreate([0,-1], varVariant); // Incializa Empty Array

  while True do
  begin
    IgnoreAndErrorIfEOL(Index, sListaAberta); // Ignora caracteres em branco

    case Ord(FExpression[Index]) of
      Ord(','): begin
                  Inc(Index);
                  IgnoreAndErrorIfEOL(Index, sListaAberta); // Ignora caracteres em branco
                  AddItem(ParseNext(Index));
                end;
      Ord(']'): begin Inc(Index); Exit; end;
    else
      AddItem(ParseNext(Index));
//      raise EParseException.Create('ParseList: Esperado "," ou "]", recebido '+FExpression[Index]+'.', FExpression, Index);
    end;
  end;
end;

function TActivityParser.ParseElement(var Index: Integer): variant;
var
  FStart: Integer;
  FElementName: String;
begin
  IgnoreAndErrorIfEOL(Index, 'ParseElement: Esperando elemento, nada recebido.');

  if FExpression[Index] <> '@' then
    raise EParseException.Create('ParseElement: Esperado "@" encontrado "'+FExpression[Index]+'".', FExpression, Index);

  Inc(Index);

  FStart:= Index;

  while True do
  begin
    if Index > FLenExpression then
      break;

    if FExpression[Index] in KeyWords then
      break;

    if FExpression[Index] = ' ' then
      break;

    inc(Index);
  end;

  if FStart >= Index then
    raise EParseException.Create('ParseElement: Nome do elemento inválido!', FExpression, FStart);

  FElementName:= Copy(FExpression, FStart, Index-FStart);

  if not Assigned(FFunElementEval) then
    raise EParseException.Create('TActivityParser.ParseElement: pFunElementEval precisa ser passado como parâmetro!', FExpression, FStart);

  Result:= FFunElementEval(FElementName);
end;

function TActivityParser.ParseNext(var Index: Integer): variant;
begin
  if Ignore(Index) then // Ignore caracteres em branco
  begin // se chegou no fim da string retorna nulo
    Result:= null;
    Exit;
  end;

  Case Ord(FExpression[Index]) of
    Ord('@'): Result:= ParseElement(Index); //Pode ser um input, Output ou Processo
    Ord('['): Result:= ParseList(Index); //Lista
    Ord('"'): Result:= ParseString(Index); // String
  else
    raise EParseException.Create('ParseNext: Identificador desconhecido', FExpression, Index);
  end;
end;

class function TActivityParser.ParseExpression(pExpression: String; pFunElementEval: TFunElementEval): variant;
begin
  with TActivityParser.Create do
  try
    FFunElementEval:= pFunElementEval;
    Result:= DoParseExpression(pExpression);
  finally
    Free;
  end;
end;

function TActivityParser.DoParseExpression(pExpression: String): variant;
var
  Index: Integer;
begin
  Expression:= pExpression;
  Index:= 1;
  Result:= ParseNext(Index);
  if not Ignore(Index) then
    raise EParseException.Create('TActivityParser.DoParseExpression: Comando inválido! Final da expressão esperado.', FExpression, Index);
end;

end.
