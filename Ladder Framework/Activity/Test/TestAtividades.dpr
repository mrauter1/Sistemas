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
  uDmConnection in '..\..\..\utils\uDmConnection.pas' {DmConnection: TDataModule},
  uConSqlServer in '..\..\..\utils\uConSqlServer.pas',
  Ladder.TestActivity in 'Ladder.TestActivity.pas',
  Ladder.Activity.Classes in '..\Ladder.Activity.Classes.pas',
  uConsultaPersonalizada in '..\..\..\utils\uConsultaPersonalizada.pas' {FrmConsultaPersonalizada};

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

