unit Test.Parser;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, Variants, System.SysUtils, Utils, Ladder.Activity.Parser, StrUtils, uConSqlServer;

type
  THackActivityParser = class(TActivityParser); // Hack para acessar m�todos protegidos

  TestTActivityParser = class(TTestCase)
  strict private
    FActivityParser: THackActivityParser;
    FConSqlServer: TConSqlServer;
  private
    procedure FunElementEval(pElement: String; var Return: Variant);
    procedure FunSqlEval(pSql: String; var Return: Variant);
    function ParseNewString(pExpression: String): variant;
    procedure DoTest(pTest: array of string); // First Item is Expression, Second item is Expected Result
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExtractTextDelimitedBy;
    procedure TestParseString;
    procedure TestStringInterpolations;
    procedure TestParseList;
    procedure TestListIndex;
    procedure TestParseNext;
    procedure TestIgnoreAndErrorIfEOL;
    procedure TestParseElement;
    procedure TestParseSql;
    procedure TestDoParseExpression;
    procedure TestParseExpression;

    // Coupled tests
    procedure TestBigSql;
  end;

implementation

function TestTActivityParser.ParseNewString(pExpression: String): variant;
var
  Index: Integer;
begin
  Index:= 1;
  FActivityParser.Expression:= pExpression;
  FActivityParser.ParseString(Index, Result);
end;

procedure TestTActivityParser.DoTest(pTest: array of string);
// First Item is Expression, Second item is Expected Result
var
  FRet: Variant;
begin
  FActivityParser.DoParseExpression(pTest[0], FRet);
  CheckEquals(pTest[1], FRet);
end;

// Return name of element for testing purposes
procedure TestTActivityParser.FunElementEval(pElement: String; var Return: Variant);
begin
  Return:= pElement;
end;

procedure TestTActivityParser.FunSqlEval(pSql: String; var Return: Variant);
begin
  FConSqlServer.DataSetToVarArray(pSql, Return);
end;

procedure TestTActivityParser.SetUp;
begin
  FActivityParser := THackActivityParser.Create;
  FActivityParser.OnElementEval:= FunElementEval;
  FActivityParser.OnSqlEval:= FunSqlEval;

  FConSqlServer:= TConSqlServer.Create(nil);
end;

procedure TestTActivityParser.TestExtractTextDelimitedBy;
var
  ReturnValue: string;
  Index: Integer;
const
  sOpenEnded = '$(corona ';
  sNormal = '(*tete ( ) te( te)*)';
  sNormalResult='tete ( ) te( te)';
  sNaoAberto = 'Heineken wol)$';

  function ExtractNewText(pExpression: String; const OpenDelimiter, CloseDelimiter: String): String;
  begin
    Index:= 1;
    FActivityParser.Expression:= pExpression;
    Result:= FActivityParser.ExtractTextDelimitedBy(Index, OpenDelimiter, CloseDelimiter);
  end;

  procedure TestAllWithDelimiters(OpenDelimiter, CloseDelimiter: String);
  const
    s1 = ' blabla bla  123 { s ';
    s123 = '"123" '+sLineBreak+', 456';
    sEmpty = '';
  var
    ReturnValue: String;

    function WrapText(Text: String): String;
    begin
      Result:= OpenDelimiter+Text+CloseDelimiter;
    end;

  begin
    Index:= 1;
    FActivityParser.Expression:= WrapText(sEmpty);
    FActivityParser.ExtractTextDelimitedBy(Index, OpenDelimiter, CloseDelimiter);
    CheckEquals('', ReturnValue);
    Check(Index=OpenDelimiter.Length+CloseDelimiter.Length+1, 'Index should be '+IntToStr(OpenDelimiter.Length+CloseDelimiter.Length+1));

    ReturnValue:= ExtractNewText(WrapText(s1), OpenDelimiter, CloseDelimiter);
    CheckEquals(s1, VarToStr(ReturnValue));

    ReturnValue := ExtractNewText(WrapText(s123), OpenDelimiter, CloseDelimiter);
    CheckEquals(s123, ReturnValue);
  end;
begin
  ReturnValue:= ExtractNewText(sNormal, '(*', '*)');
  CheckEquals(sNormalResult, ReturnValue);

  try
    ExtractNewText('$(', ')$', sOpenEnded);
    Fail('Erro de string aberta esperado. '+sOpenEnded);
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;

  try
    ExtractNewText(sNaoAberto, '$(', '$)');
    Fail('Erro de string n�o aberta esperado. '+sNaoAberto);
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;

  TestAllWithDelimiters('{', '}');
  TestAllWithDelimiters('#@', '#@');
  TestAllWithDelimiters('(*', '*)');
end;

procedure TestTActivityParser.TearDown;
begin
  FActivityParser.Free;
  FActivityParser := nil;

  FConSqlServer.Free;
end;

procedure TestTActivityParser.TestParseSql;
const
  s0 = '$@ SELECT 0$'; //$@ operator makes SQL expression evaluate to a single value
  sString = '$@ SELECT ''ABCDE''$';
  sDate = '$@ SELECT GETDATE()$';
  sList = '$ SELECT 1 AS NUM UNION SELECT 2 UNION SELECT 3  $';
  sTable = '$ SELECT 1 AS NUM, ''TESTE1'' as NOME UNION SELECT 2, ''TESTE2'' UNION SELECT 3, ''TESTE3''  $';

  function ParseNewSql(pSql: String): variant;
  var
    Index: Integer;
  begin
    Index:= 1;
    FActivityParser.Expression:= pSql;
    FActivityParser.ParseSQL(Index, Result);
  end;

var
  ReturnValue: Variant;

begin
  CheckEquals(0, VarToIntDef(ParseNewSql(s0),1));
  CheckEquals('ABCDE',VarToStr(ParseNewSql(sString)));
  CheckEquals(Trunc(Now()), Trunc(VarToDateTime(ParseNewSql(sDate))));

  ReturnValue:= ParseNewSql(sList);
  CheckEquals(4, VarArrayLength(ReturnValue)); // Field names are stored in index -1;
  CheckEquals('NUM', ReturnValue[-1][0]);
  CheckEquals(1, ReturnValue[0][0]);
  CheckEquals(2, ReturnValue[1][0]);
  CheckEquals(3, ReturnValue[2][0]);

  ReturnValue:= ParseNewSql(sTable);
  CheckEquals('NUM', ReturnValue[-1][0]);
  CheckEquals('NOME', ReturnValue[-1][1]);
  CheckEquals(1, ReturnValue[0][0]);
  CheckEquals('TESTE1', ReturnValue[0][1]);
  CheckEquals('TESTE3', ReturnValue[2][1]);
end;

procedure TestTActivityParser.TestParseString;
var
  ReturnValue: variant;
  Index: Integer;
const
  sEmpty = '""';
  s1 = '" blabla bla () {"123"} "';
  s1Interpolated = ' blabla bla () 123 ';
  sNot1Interpolated = ' blabla bla () {';
//  s1Result = '" blabla bla () 123 "123" "';
  sOpenEnded = '"corona ';
  sNaoAberto = 'Heineken';
  s123 = '"123"';
begin
  Index:= 1;
  FActivityParser.Expression:= sEmpty;
  FActivityParser.ParseString(Index, ReturnValue);
  CheckEquals('', VarToStr(ReturnValue));
  Check(Index=3, 'Index should be 3.');

  ReturnValue:= ParseNewString(s1); // Doing interpolation
  CheckEquals(s1Interpolated, VarToStr(ReturnValue));

  ReturnValue:= ParseNewString('!'+s1); // Without doing inteprolation
  CheckEquals(sNot1Interpolated, VarToStr(ReturnValue));

  try
    ParseNewString(sOpenEnded);
    Fail('Erro de string aberta esperado. '+sOpenEnded);
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;

  try
    ParseNewString(sNaoAberto);
    Fail('Erro de string n�o aberta esperado. '+sNaoAberto);
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;

  ReturnValue := ParseNewString(s123);
  CheckEquals(StrToInt(ReplaceText(s123, '"', '')), VarToIntDef(ReturnValue));

  // TODO: Validate method results
end;

procedure TestTActivityParser.TestStringInterpolations;
const
  t1:  TArray<String> = ['"test {"right"}"', 'test right'];
  tList: TArray<String> = ['"t{["e","s","t"]}"', 't["e", "s", "t"]'];
  tSql: TArray<String> = ['"t{$@SELECT ''est''$}"', 'test'];
begin
  DoTest(t1);
  DoTest(tList);
  DoTest(tSql);
end;

procedure TestTActivityParser.TestListIndex;
const
  sTest1: TArray<String> = ['["a", "b", "c"][0]', 'a'];
  sTest2: TArray<String> = ['["a", "b", "c"][1]', 'b'];
  sTest3: TArray<String> = ['["a", "b", "c"][2]', 'c'];
  sTest4: TArray<String> = ['["a", ["b", "c"], "d"][1][1]', 'c'];
  sTest5: TArray<String> = ['$SELECT ''T'' UNION SELECT ''E''$[1][0]', 'E'];
  sTest6: TArray<String> = ['$SELECT 1 as idx, ''T'' as nome UNION SELECT 2, ''E''$[1]["idx"]', '2'];
  sTest7: TArray<String> = ['$SELECT 1 as idx, ''T'' as nome UNION SELECT 2, ''E''$[1]["NOME"]', 'E'];
begin
  DoTest(sTest1);
  DoTest(sTest2);
  DoTest(sTest3);
  DoTest(sTest4);
  DoTest(sTest5);
  DoTest(sTest6);
  DoTest(sTest7);
end;

procedure TestTActivityParser.TestParseList;
var
  ReturnValue: Variant;
  Index: Integer;
  FCopyRef: PVariant;
  FCopyVal: Variant;
const
  sEmptyList = '[]';
  sNumberList = '[123]';
  sStringList = '["bla"]';
  sMultiList = '["co", "ro", "na"]';
  sInvalid = ',]';
  sNoClose = '["alo", "ha" ';

  function ParseNewList(pExpression: String): variant;
  begin
    Index:= 1;
    FActivityParser.Expression:= pExpression;
    FActivityParser.ParseList(Index, Result);
  end;
begin
  Index:= 1;
  FActivityParser.Expression:= sEmptyList;
  FActivityParser.ParseList(Index, ReturnValue);
  Check(VarArrayLength(ReturnValue) = 0, 'List should be empty');
  Check(Index=3, 'Index should be 3');

  ReturnValue:= ParseNewList(sStringList);
  Check(VarArrayLength(ReturnValue)=1, 'List should have one item.');
  CheckEquals('bla', ReturnValue[0]);

  ReturnValue:= ParseNewList(sMultiList);
  Check(VarArrayLength(ReturnValue)=3, 'List should have three items.');
  CheckEquals('co', ReturnValue[0]);
  CheckEquals('ro', ReturnValue[1]);
  CheckEquals('na', ReturnValue[2]);

  FCopyVal:= ReturnValue;
  FCopyVal[0]:= 'Changed';
  CheckEquals('co', ReturnValue[0]);

  FCopyRef:= @ReturnValue;
  FCopyRef^[0]:= 'Changed';
  CheckEquals('Changed', ReturnValue[0]);

  try
    ParseNewList(sNumberList);
    Fail('Esperado erro de identificador desconhecido!');
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;

  try
    ParseNewList(sInvalid);
    Fail('Esperado erro de lista inv�lida!');
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;

  try
    ParseNewList(sNoClose);
    Fail('Esperado erro de lista sem fechamento!');
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;
end;

procedure TestTActivityParser.TestParseNext;
var
  Index: Integer;
  ReturnValue: Variant;
const
  sMultiList = '["co", "ro", "na"]';
  sString = '"string"';
  sNull = '  ';
  sInvalid = '123';

  function NewParseNext(pExpression: String): Variant;
  begin
    Index:= 1;
    FActivityParser.Expression:= pExpression;
    FActivityParser.ParseNext(Index, Result);
  end;
begin
  // TODO: Setup method call parameters
  ReturnValue:= NewParseNext(sMultiList);
  Check(VarIsArray(ReturnValue), 'Return should be VarArray');
  Check(VarArrayLength(ReturnValue)=3, 'Return should be a VarArray with 3 items.');

  ReturnValue:= NewParseNext(sString);
  Check(VarIsStr(ReturnValue), 'Return should be String');
  CheckEquals(VarToStr(ReturnValue), 'string');

  ReturnValue:= NewParseNext(sNull);
  Check(ReturnValue = null, 'Return should be null');

  try
    NewParseNext(sInvalid);
    Fail('Esperado erro de identificador inv�lido!');
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;
end;

procedure TestTActivityParser.TestIgnoreAndErrorIfEOL;
var
  Index: Integer;
  FVar: Variant;
const
  sTexto = '"co" "ro" ';
  sEOL = '     ';
  sEmpty = '';
begin
  Index:= 1;
  FActivityParser.Expression:= sTexto;
  FActivityParser.IgnoreAndErrorIfEOL(Index, 'Erro');
  CheckEquals(Index, 1, 'Index expected to be 1');
  FActivityParser.ParseNext(Index, FVar);
  FActivityParser.IgnoreAndErrorIfEOL(Index, 'Erro');
  CheckEquals(Index, 6, 'Index expected to be 6');
  FActivityParser.ParseNext(Index, FVar);

  try
    FActivityParser.IgnoreAndErrorIfEOL(Index, 'Erro');
    Fail('Esperando erro de EOL');
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;

  try
    Index:= 1;
    FActivityParser.Expression:= sEOL;
    FActivityParser.IgnoreAndErrorIfEOL(Index, 'Erro');
    Fail('Esperando erro de EOL');
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;

  try
    Index:= 1;
    FActivityParser.Expression:= sEmpty;
    FActivityParser.IgnoreAndErrorIfEOL(Index, 'Erro');
    Fail('Esperando erro de EOL');
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;
end;

procedure TestTActivityParser.TestParseElement;
var
  ReturnValue: Variant;
  Index: Integer;
const
  sResElemento = 'Ela.Teste';
  sElement = '@Ela';
  sElement5 = '@Ela.Teste';
  sElement2 = '@Ela.Teste "ignorar"';
  sElement3 = '@Ela.Teste,"ignorar"';
  sElement4 = '@Ela.Teste[,"ignorar"';
  sInvalido = '"Ela"';

  function ParseNewElement(pExpression: String): Variant;
  begin
    Index:= 1;
    FActivityParser.Expression:= pExpression;
    FActivityParser.ParseElement(Index, Result);
  end;

begin
  ReturnValue:= ParseNewElement(sElement);
  CheckEquals('Ela', ReturnValue);

  ReturnValue:= ParseNewElement(sElement5);
  CheckEquals(sResElemento, ReturnValue);

  ReturnValue:= ParseNewElement(sElement2);
  CheckEquals(sResElemento, ReturnValue);

  ReturnValue:= ParseNewElement(sElement3);
  CheckEquals(sResElemento, ReturnValue);

  ReturnValue:= ParseNewElement(sElement4);
  CheckEquals(sResElemento, ReturnValue);

  try
    ParseNewElement(sInvalido);
    Fail('Expecting Exception: Invalid element.');
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;
end;

procedure TestTActivityParser.TestDoParseExpression;
var
  ReturnValue: Variant;
const
  sMultiList = '["co", "ro", "na"]';
  sString = '"string"';
  sNull = '  ';
  sInvalid = '123';
begin
  // TODO: Setup method call parameters
  FActivityParser.DoParseExpression(sMultiList, ReturnValue);
  Check(VarIsArray(ReturnValue), 'Return should be VarArray');
  Check(VarArrayLength(ReturnValue)=3, 'Return should be a VarArray with 3 items.');

  FActivityParser.DoParseExpression(sString, ReturnValue);
  Check(VarIsStr(ReturnValue), 'Return should be String');
  CheckEquals(VarToStr(ReturnValue), 'string');

  FActivityParser.DoParseExpression(sNull, ReturnValue);
  Check(ReturnValue = null, 'Return should be null');

  try
    FActivityParser.DoParseExpression(sInvalid, ReturnValue);
    Fail('Esperado erro de identificador inv�lido!');
  except on E: Exception do
    if E.ClassType <> EParseException then
      raise;
  end;
end;

procedure TestTActivityParser.TestParseExpression;
var
  ReturnValue: variant;
begin
  TActivityParser.ParseExpression('[]', ReturnValue, nil); // Same as DoParseExpression, but wrapped as a class function
  Check(VarIsArray(ReturnValue), 'Return should be VarArray');
end;


procedure TestTActivityParser.TestBigSql;
var
  FRes: Variant;
begin
  FActivityParser.DoParseExpression('$SELECT * FROM MFOR$', FRes);
  FRes:= null;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTActivityParser.Suite);
end.

