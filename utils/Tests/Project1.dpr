program Project1;

uses
  DUnitTestRunner,
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ExpressionParser in 'ExpressionParser.pas',
  TestExpressionParser in 'TestExpressionParser.pas';

{$R *.res}

begin
  DUnitTestRunner.RunRegisteredTests;
//  Application.Initialize;
//  Application.CreateForm(TForm1, Form1);
//  Application.Run;
end.
