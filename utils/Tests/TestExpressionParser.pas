unit TestExpressionParser;

interface

uses
  TestFramework, ExpressionParser, System.Generics.Collections, SysUtils;

type
  TestTExpressionParser = class(TTestCase)
  strict private
    FExpressionParser: TExpressionParser;
  private
    procedure CheckEvalFloat(val: Double; AExpression: String);
    procedure CheckTokens(ATokens: TArray<String>; AExpression: String;AErrorExpected: Boolean=False);
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestParseInt;
    procedure TestParseFloat;
    procedure TestSum;
    procedure TestMinus;
    procedure TestDiv;
    procedure TestMult;
    procedure TestParentheses;
    procedure TestToken;
    procedure TestExtractTokens;
  end;

implementation

uses
  Math;

{ TestTExpressionParser }

procedure TestTExpressionParser.SetUp;
begin
  FExpressionParser:= TExpressionParser.Create;
end;

procedure TestTExpressionParser.TearDown;
begin
  FExpressionParser.Free;
  FExpressionParser:= nil;
end;

procedure TestTExpressionParser.TestDiv;
begin
  CheckEvalFloat(1.22/9.87, '1.22/ 9.87');
  CheckEvalFloat(123456789.4567/ 888754, ' 123456789.4567/ 888754 ');
  try
    CheckEvalFloat(58447.1111/0, '58447.1111/0');
    Fail('Division by zero error expected.');
  except
  end;
  CheckEvalFloat(999999999.9/0.0005, ' 999999999.9/0.0005');
  CheckEvalFloat(1+10*128/35, '1+ 10 *128 / 35');
  CheckEvalFloat(2+2/10, '2+2/10');
end;

procedure TestTExpressionParser.CheckTokens(ATokens: TArray<String>; AExpression: String; AErrorExpected: Boolean=False);
var
  FExtracted: TArray<String>;
  I: Integer;

  function TokenExists(AToken: String): Boolean;
  var
    F: Integer;
  begin
    Result:= True;
    for F := 0 to Length(FExtracted)-1 do
      if FExtracted[F]=AToken then
        Exit;

    Result:= False;
  end;
begin
  try
    FExtracted:= FExpressionParser.ExtractTokens(AExpression);
    Check(Length(ATokens)=Length(FExtracted));
    for I:= 0 to Length(ATokens)-1 do
      Check(TokenExists(UpperCase(ATokens[I])));
    if AErrorExpected then
      Fail('Expecting exception or error.');
  except
    if not AErrorExpected then
      raise;
  end;
end;

procedure TestTExpressionParser.TestExtractTokens;
var
  FDictionary: TDictionary<String, Double>;
begin
  FDictionary:= TDictionary<String, Double>.Create;
  try
    FDictionary.Add('T1', 100);
    FDictionary.Add('T2', 0.5);
    FDictionary.Add('T3', 9);

    FExpressionParser.Dictionary:= FDictionary;
    FExpressionParser.TokenUpperCase:= True;

    CheckTokens(['t1'], 't1');
    CheckTokens(['t1'], '  t1');
    CheckTokens(['t1', 't2'], '  T1*t2');
    CheckTokens(['t1', 'T2', 't3'], 't1*(t2+t3)');
    CheckTokens(['t1', 't2'], '  t1/t2*2');
    CheckTokens(['t1', 't2'], '  t1*t1/t2*t2');
    CheckTokens(['t1', 't3'], '  t1*t2', True);

    FExpressionParser.TokenUpperCase:= False;
    CheckTokens(['t1'], '  t1', True);
    CheckTokens(['t1'], '  T1', True);
    CheckTokens(['T1'], '  t1', True);
  finally
    FDictionary.Free;
  end;
end;

procedure TestTExpressionParser.TestMinus;
begin
  CheckEvalFloat(2-2, '2-2');
  CheckEvalFloat(128-35, '128 -35');
  CheckEvalFloat(987542.22-899.87, '987542.22- 899.87');
  CheckEvalFloat(123456789.4567- 888754, ' 123456789.4567- 888754 ');
  CheckEvalFloat(58447.1111-0, '58447.1111-0');
  CheckEvalFloat(999999999.9-0.0005, ' 999999999.9-0.0005');
end;

procedure TestTExpressionParser.TestMult;
begin
  CheckEvalFloat(2+2*10, '2+2*10');
  CheckEvalFloat(128*35, '128 *35');
  CheckEvalFloat(987542.22*899.87, '987542.22* 899.87');
  CheckEvalFloat(123456789.4567* 888754, ' 123456789.4567* 888754 ');
  CheckEvalFloat(58447.1111*0, '58447.1111*0');
  CheckEvalFloat(999999999.9*0.0005, ' 999999999.9*0.0005');
end;

procedure TestTExpressionParser.TestParentheses;
begin
  CheckEvalFloat(2+(2), '2+(2)');
  CheckEvalFloat(128*(35+12), '128*(35+12)');
  CheckEvalFloat(((987542.22)/2*899.87), '((987542.22)/2*899.87)');
  CheckEvalFloat(123456789.4567*(888754+(2-(1/5))/25), ' 123456789.4567*( 888754+(2-(1/5 ))/25)');
  CheckEvalFloat(((58447.1111+2) )*(0), '(((58447.1111+2)) )*(0)');
  CheckEvalFloat(9+0.9*(10/0.0005), '9+0.9*(10/0.0005)');

  try
    FExpressionParser.Evaluate('(2+1');
    Fail('Expression should be invalid');
  except
  end;

  try
    FExpressionParser.Evaluate('2+1)');
    Fail('Expression should be invalid');
  except
  end;
  try
    FExpressionParser.Evaluate('(2+1)*((2)');
    Fail('Expression should be invalid');
  except
  end;
end;

procedure TestTExpressionParser.CheckEvalFloat(val: Double; AExpression: String);
begin
  CheckEquals(Math.RoundTo(val, 6), Math.RoundTo(FExpressionParser.Evaluate(AExpression),6));
end;

procedure TestTExpressionParser.TestParseFloat;
begin
  CheckEvalFloat(3.14, '3.14');
  CheckEvalFloat(1.99998, '1.99998');
  CheckEvalFloat(987542.22, '987542.22');
  CheckEvalFloat(123456789.4567, ' 123456789.4567 ');
  CheckEvalFloat(58447.1111, '58447.1111');
  CheckEvalFloat(999999999.9, ' 999999999.9');
end;

procedure TestTExpressionParser.TestParseInt;
  procedure CheckEvalInt(val: Integer; AExpression: String);
  begin
    CheckEquals(val, FExpressionParser.Evaluate(AExpression));
  end;
begin
  CheckEvalInt(0, '0');
  CheckEvalInt(1, '1');
  CheckEvalInt(9, ' 9 ');
  CheckEvalInt(128, ' 128 ');
  CheckEvalInt(58447, '58447');
  CheckEvalInt(999999999, '999999999');
end;

procedure TestTExpressionParser.TestSum;
begin
  CheckEvalFloat(2+2+5+4, '2+2+5+4');
  CheckEvalFloat(128+35, '128 +35');
  CheckEvalFloat(987542.22+899.87, '987542.22+ 899.87');
  CheckEvalFloat(123456789.4567+ 888754, ' 123456789.4567+ 888754 ');
  CheckEvalFloat(58447.1111+0+1+2+2222.2, '58447.1111+0+1+2+2222.2');
  CheckEvalFloat(999999999.9+0.0005, ' 999999999.9+0.0005');
end;

procedure TestTExpressionParser.TestToken;
var
  FDictionary: TDictionary<String, Double>;
begin
  FDictionary:= TDictionary<String, Double>.Create;
  try
    FDictionary.Add('t1', 100);
    FDictionary.Add('t2', 0.5);
    FDictionary.Add('t3', 9);

    FExpressionParser.Dictionary:= FDictionary;

    CheckEvalFloat(100, 't1');
    CheckEvalFloat(100, '  t1');
    CheckEvalFloat(50, '  t1*t2');
    CheckEvalFloat(100*(0.5+9), '  t1*(t2+t3)');
    CheckEvalFloat(100, '  t1/t2*2');
    try
      FExpressionParser.Evaluate('t3.alo');
      Fail('Expression should be invalid');
    except
    end;
    try
      FExpressionParser.Evaluate('2+t4');
      Fail('Expression should be invalid');
    except
    end;
  finally
    FDictionary.Free;
  end;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTExpressionParser.Suite);

end.
