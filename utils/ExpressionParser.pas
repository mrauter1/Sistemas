unit ExpressionParser;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Generics.Defaults;

type
  TExpressionOperator = (toPlus, toMinus, toMult, toDiv);

  EExpressionParserException = class(Exception)
  public
    Expression: String;
    Pos: Integer;
    constructor Create(const Msg: String; const pExpression: String; pPos: Integer);
  end;

  TExtractToken = reference to procedure (const Token: String);

  TExpressionParser = class
  private
    FTokenUpperCase: Boolean;
    LenExpression: Integer;
    FExpression: String;
    FFormatSettings: TFormatSettings;
    FDictionary: TDictionary<String,Double>;
    FOnExtractToken: TExtractToken;
    procedure InsertParentheses; // Must Insert Parentheses before multiplication or division to respect operator precedence
    function EvaluateNext(var Index: Integer): Double;
    function EvaluateToken(var Index: Integer): Double;
    function EvaluateInside(var Index: Integer): Double;
    function Ignore(var Index: Integer): Boolean;
    procedure IgnoreAndErrorIfEOL(var Index: Integer; const Msg: String);
    procedure DoOperation(var Index: Integer; var Result: Double);
    function ParseNumber(var Index: Integer): Double;
    procedure SetDictionary(const Value: TDictionary<String, Double>);
  public
    constructor Create; overload;
    // if AUpperCase is true, then all tokens will be changed to UpperCase (Expects Dictionary Keys to be upperCase);
    constructor Create(ADictionary: TDictionary<String, Double>; ATokenUpperCase: Boolean=False); overload;
    function Evaluate(const AExpression: string): Double;
    property Expression: String read FExpression;
    function ExtractTokens(const AExpression: String): TArray<String>;
    property Dictionary: TDictionary<String,Double> read FDictionary write SetDictionary;
    property TokenUpperCase: Boolean read FTokenUpperCase write FTokenUpperCase;
  end;

implementation

uses
  System.Character;

const
  cStopChars = [' ','+','-','/','*','(',')'];

{ EExpressionParserException }

constructor EExpressionParserException.Create(const Msg, pExpression: String;
  pPos: Integer);
begin
  Expression:= pExpression;
  Pos:= pPos;
  inherited Create(Msg+'; Expression: "'+pExpression+'"; Pos: '+IntToStr(pPos));
end;

function TExpressionParser.Ignore(var Index: Integer): Boolean; // Returns true if end of string reached.
begin
  Result:= False;
  while True do
    if Index > LenExpression then
      Break // Break and return True
    else if FExpression[Index]=' ' then //Ignore white space
      Inc(Index)
    else Exit; // Exit and return False

  Result:= True;
end;

procedure TExpressionParser.IgnoreAndErrorIfEOL(var Index: Integer; const Msg: String);
begin
  if Ignore(Index) then
    raise EExpressionParserException.Create(Msg, FExpression, Index);
end;

procedure TExpressionParser.InsertParentheses;
var
  I, FPos: Integer;

  procedure BackwardsIgnore(var AIndex: Integer; const AExpression: String);
  begin
    while FExpression[AIndex]=' ' do
      Dec(AIndex);
  end;

  function PosPreviousToken(Index: Integer): Integer;
  var
    F: Integer;
    FParenthesesCnt: Integer;
  begin
    FParenthesesCnt:= 0;
    F:= Index-1;
    BackwardsIgnore(F, FExpression);

    while FExpression[F]=')' do
    begin
      Inc(FParenthesesCnt);
      Dec(F);
      BackwardsIgnore(F, FExpression);
    end;

    while F>0 do
    begin
      if FExpression[F]='(' then
        Dec(FParenthesesCnt);
      if (FParenthesesCnt<=0) and (FExpression[F] in cStopChars) then
        Break;

      Dec(F);
    end;
    if F>1 then
      Result:= F+1
    else Result:=1;
  end;

  function PosNextToken(Index: Integer): Integer;
  begin
    Result:= Index;
    Inc(Result);
    EvaluateNext(Result);
    Result:= Result;
  end;

begin
  I:= 1;
  while I<=LenExpression do
  begin
    if FExpression[I]in (['*', '/']) then
    begin
      Insert('(', FExpression, PosPreviousToken(I));
      LenExpression:= Length(FExpression);
      Inc(I);
      Insert(')', FExpression, PosNextToken(I));
      LenExpression:= Length(FExpression);
    end;
    Inc(I);
  end;
end;

function TExpressionParser.ParseNumber(var Index: Integer): Double;
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
        raise EExpressionParserException.Create('TExpressionParser.ParseNumber: Invalid Number.', FExpression, Index);

      Inc(Index);
      FHasDecimal:= True;
      Continue;
    end
   else if (FExpression[Index] in cStopChars) then
     Break
   else
     raise EExpressionParserException.Create('TExpressionParser.ParseNumber: Invalid Number.', FExpression, Index);
  end;

  if FHasDecimal then
    Result:= StrToFloat(Copy(FExpression, FStart, Index-FStart), FFormatSettings)
  else
    Result:= StrToInt(Copy(FExpression, FStart, Index-FStart));
end;

procedure TExpressionParser.SetDictionary(const Value: TDictionary<String, Double>);
begin
  FDictionary := Value;
end;

function TExpressionParser.EvaluateToken(var Index: Integer): Double;
var
  FStart: Integer;
  FToken: String;
begin
  IgnoreAndErrorIfEOL(Index, 'EvaluateNext: Expecting variable, end of expression reached.');
  FStart:= Index;
  while (Index<=LenExpression) do
  begin
    if (FExpression[Index] in cStopChars) then
      Break
    else
      Inc(Index);
  end;

  FToken:= Copy(FExpression, FStart, Index-FStart);
  if FTokenUpperCase then
    FToken:= UpperCase(FToken);

  if Assigned(FOnExtractToken) then // if FOnExtractToken is assigned, the result does not matter, just the token name.
  begin
    FOnExtractToken(FToken);
    Result:= 1;
    Exit;
  end;

//  TDictionary<String,Integer>.Create();

  if FDictionary = nil then
    raise EExpressionParserException.Create('EvaluateToken: No token dictionary provided.', FExpression, Index);

  if not FDictionary.ContainsKey(FToken) then
    raise EExpressionParserException.Create(Format('EvaluateToken: Invalid token "%s"', [FToken]), FExpression, Index);

  Result:= FDictionary[FToken];
end;

function TExpressionParser.ExtractTokens(const AExpression: String): TArray<String>;
var
  FArray: TArray<String>;
begin
  FOnExtractToken:= procedure (const Token: String)
      function TokenExists(AToken: String): Boolean;
      var
        F: Integer;
      begin
        Result:= True;
        for F := 0 to Length(FArray)-1 do
          if FArray[F]=AToken then
            Exit;

        Result:= False;
      end;
    begin
      if TokenExists(Token) then
        Exit;

      SetLength(FArray, Length(FArray)+1);
      FArray[Length(FArray)-1]:= Token;
    end;
  try
    Evaluate(AExpression);
    Result:= FArray;
  finally
    FOnExtractToken:= nil;
  end;
end;

function TExpressionParser.EvaluateNext(var Index: Integer): Double;
begin
  IgnoreAndErrorIfEOL(Index, 'EvaluateNext: Expecting expression, no expression found.');
  if FExpression[Index] = '(' then
  begin
    Result:= EvaluateInside(Index);
  end
  else if FExpression[Index] in (['0'..'9']) then
    Result:= ParseNumber(Index) // Number
  else
    Result:= EvaluateToken(Index);
end;

function TExpressionParser.Evaluate(const AExpression: string): Double;
var
  FIndex: Integer;
begin
  FExpression:= AExpression;
  LenExpression:= Length(FExpression);

  if not Assigned(FOnExtractToken) then // when extracting tokens, must not insert parentheses
    InsertParentheses; // Must Insert Parentheses before multiplication or division to respect operator precedence

  FIndex:= 1;

  Result:= EvaluateNext(FIndex);
  Ignore(FIndex);
  while FIndex < LenExpression do
    DoOperation(FIndex, Result);

end;

function TExpressionParser.EvaluateInside(var Index: Integer): Double;
begin
  Inc(Index);
  Result:= EvaluateNext(Index);
  IgnoreAndErrorIfEOL(Index, 'EvaluateInside: Expecting ")", end of expression reached.');

  while FExpression[Index]<>')' do // Must have an operator or closing parentheses
  begin
    DoOperation(Index, Result);
    IgnoreAndErrorIfEOL(Index, 'EvaluateInside: Expecting ")", end of expression reached.');
  end;
  Inc(Index);
end;

constructor TExpressionParser.Create;
begin
  inherited;
  FFormatSettings:= TFormatSettings.Create;
  FFormatSettings.DecimalSeparator:= '.';
  FDictionary:= nil;
end;

constructor TExpressionParser.Create(ADictionary: TDictionary<String, Double>; ATokenUpperCase: Boolean=False);
begin
  Create;
  FTokenUpperCase:= ATokenUpperCase;
  FDictionary:= ADictionary;
end;

procedure TExpressionParser.DoOperation(var Index: Integer; var Result: Double);
begin
  IgnoreAndErrorIfEOL(Index, 'DoOperation: Operator not found ("+", "-", "/", "*"');
  Inc(Index);

  Case Ord(FExpression[Index-1]) of
    Ord('+'): Result:= Result+EvaluateNext(Index); //SUM
    Ord('-'): Result:= Result-EvaluateNext(Index); //MINUS
    Ord('/'): Result:= Result/EvaluateNext(Index); //DIVISION
    Ord('*'): Result:= Result*EvaluateNext(Index); //MULTIPLICATION
  end;
end;

end.
