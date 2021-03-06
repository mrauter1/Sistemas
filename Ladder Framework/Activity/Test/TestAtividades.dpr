program TestAtividades;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}
{$DEFINE MAX_SQLFIELDS_256}
{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  Forms,
  Windows,
  Test.Classes in 'Test.Classes.pas',
  Ladder.Activity.Classes in '..\Ladder.Activity.Classes.pas',
  Test.Parser in 'Test.Parser.pas',
  uTesteAtividades in 'uTesteAtividades.pas',
  Ladder.Activity.Manager in '..\Ladder.Activity.Manager.pas',
  Ladder.ServiceLocator in '..\..\Ladder.ServiceLocator.pas',
  Ladder.Executor.Email in '..\Executor\Ladder.Executor.Email.pas',
  Ladder.Executor.ConsultaPersonalizada in '..\Executor\Ladder.Executor.ConsultaPersonalizada.pas',
  Test.ModeloBD in 'Test.ModeloBD.pas',
  Ladder.ORM.QueryBuilder in '..\..\ORM\Ladder.ORM.QueryBuilder.pas',
  Test.Repository in 'Test.Repository.pas',
  Ladder.ORM.Repository in '..\..\ORM\Ladder.ORM.Repository.pas',
  Test.MockClasses in 'Test.MockClasses.pas',
  Ladder.ORM.ModeloBD in '..\..\ORM\Ladder.ORM.ModeloBD.pas',
  Test.Dao in 'Test.Dao.pas',
  Ladder.Activity.Classes.Dao in '..\Ladder.Activity.Classes.Dao.pas',
  Ladder.ORM.SQLDBRowsDataSet in '..\..\ORM\Ladder.ORM.SQLDBRowsDataSet.pas',
  uDmConnection in '..\..\..\utils\uDmConnection.pas' {DmConnection: TDataModule},
  uDmGeradorConsultas in '..\..\..\utils\uDmGeradorConsultas.pas' {DmGeradorConsultas: TDataModule},
  Test.Classes.Dao in 'Test.Classes.Dao.pas',
  Ladder.Activity.LadderVarToSql in '..\Ladder.Activity.LadderVarToSql.pas',
  Test.LadderVarToSql in 'Test.LadderVarToSql.pas',
  Ladder.SqlServerConnection in '..\..\Ladder.SqlServerConnection.pas',
  Ladder.Utils in '..\..\Ladder.Utils.pas',
  Form.ScheduledActivityEditor in '..\..\Forms\Form.ScheduledActivityEditor.pas' {FormScheduledActivityEditor},
  Form.ProcessEditor in '..\..\Forms\Form.ProcessEditor.pas' {FormProcessEditor},
  Form.NovoProcesso in '..\..\Forms\Form.NovoProcesso.pas' {FormNovoProcesso},
  Form.SelecionaConsulta in '..\..\Forms\Form.SelecionaConsulta.pas' {FormSelecionaConsulta},
  Test.Forms in 'Test.Forms.pas',
  Form.ScheduledActivities in '..\..\Forms\Form.ScheduledActivities.pas' {FormScheduledActivities},
  Ladder.ORM.ObjectDataSet in '..\..\ORM\Ladder.ORM.ObjectDataSet.pas',
  uConClasses in '..\..\..\utils\uConClasses.pas',
  Test.ObjectDataset in 'Test.ObjectDataset.pas',
  Ladder.ORM.Dao in '..\..\ORM\Ladder.ORM.Dao.pas',
  Ladder.ORM.DaoUtils in '..\..\ORM\Ladder.ORM.DaoUtils.pas',
  Test.DaoUtils in 'Test.DaoUtils.pas',
  uConClasses.Dao in '..\..\..\utils\uConClasses.Dao.pas',
  Form.ProcessEditorBase in '..\..\Forms\Form.ProcessEditorBase.pas' {FormProcessEditorBase},
  Form.ConsultaEditor in '..\..\Forms\Form.ConsultaEditor.pas' {FormConsultaEditor},
  Ladder.Parser in '..\..\Ladder.Parser.pas',
  Ladder.SyntaxChecker in '..\..\Ladder.SyntaxChecker.pas',
  Ladder.ExpressionEvaluator in '..\..\Ladder.ExpressionEvaluator.pas',
  Ladder.Activity.Scheduler in '..\Ladder.Activity.Scheduler.pas',
  maxCron in '..\..\Library\maxCron\maxCron.pas',
  Test.Scheduler in 'Test.Scheduler.pas',
  Ladder.Executor.Activity in '..\Executor\Ladder.Executor.Activity.pas',
  Form.ProcessActivityEditor in '..\..\Forms\Form.ProcessActivityEditor.pas' {FormProcessActivityEditor},
  Form.ActivityEditor in '..\..\Forms\Form.ActivityEditor.pas' {FormActivityEditor},
  Ladder.Activity.Scheduler.Dao in '..\Ladder.Activity.Scheduler.Dao.pas',
  Form.PesquisaAviso in '..\..\Forms\Form.PesquisaAviso.pas' {FormPesquisaAviso},
  Root in '..\..\Root.pas',
  Ladder.Types in '..\..\Ladder.Types.pas',
  Ladder.Logger in '..\..\Ladder.Logger.pas',
  Test.Ladder in '..\..\Test.Ladder.pas';

{$R *.RES}

var
  FRootClass: TRootClass;
  FConnectionParams: TConnectionParams;

begin
  FConnectionParams.DriverID:= 'MSSQL';
  FConnectionParams.Server:= '127.0.0.1';
  FConnectionParams.Protocol:= 'TCPIP';
  FConnectionParams.Port:= 1433;
  FConnectionParams.Database:= 'LOGISTEC';
  FConnectionParams.User:= 'Gerenciador';
  FConnectionParams.Password:= 'ProjetoGerenciador!@0';

  ReportMemoryLeaksOnShutdown := True;
  TFrwServiceLocator.Inicializar(TFrwServiceFactory.Create(FConnectionParams));
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  FRootClass:= TRootClass.Create;
  try
    FRootClass.CreateAllTables;
  finally
    FRootClass.Free;
  end;
  CreateTestTables;

  DUnitTestRunner.RunRegisteredTests;
  Application.Run;
end.

