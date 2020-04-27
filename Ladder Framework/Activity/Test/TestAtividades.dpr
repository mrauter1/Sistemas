program TestAtividades;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  Forms,
  uConSqlServer in '..\..\..\utils\uConSqlServer.pas',
  Test.Classes in 'Test.Classes.pas',
  Ladder.Activity.Classes in '..\Ladder.Activity.Classes.pas',
  Test.Parser in 'Test.Parser.pas',
  Ladder.Activity.Parser in '..\Ladder.Activity.Parser.pas',
  Ladder.Connection in '..\..\Ladder.Connection.pas',
  uTesteAtividades in 'uTesteAtividades.pas',
  Ladder.Activity.Manager in '..\Ladder.Activity.Manager.pas',
  Ladder.ServiceLocator in '..\..\Ladder.ServiceLocator.pas',
  Ladder.Executor.Email in '..\Executor\Ladder.Executor.Email.pas',
  Ladder.Executor.ConsultaPersonalizada in '..\Executor\Ladder.Executor.ConsultaPersonalizada.pas',
  Test.ModeloBD in 'Test.ModeloBD.pas',
  Ladder.ORM.QueryBuilder in '..\..\ORM\Ladder.ORM.QueryBuilder.pas',
  Ladder.Activity.DaoClasses in '..\Ladder.Activity.DaoClasses.pas',
  Test.Repository in 'Test.Repository.pas',
  Ladder.ORM.Repository in '..\..\ORM\Ladder.ORM.Repository.pas',
  Test.MockClasses in 'Test.MockClasses.pas',
  Ladder.ORM.ModeloBD in '..\..\ORM\Ladder.ORM.ModeloBD.pas',
  Test.Dao in 'Test.Dao.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  DUnitTestRunner.RunRegisteredTests;
  Application.Run;
end.

