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
  uConSqlServer in '..\..\..\utils\uConSqlServer.pas' {ConSqlServer: TDataModule},
  Test.Classes.Dao in 'Test.Classes.Dao.pas',
  Ladder.Activity.LadderVarToSql in '..\Ladder.Activity.LadderVarToSql.pas',
  Test.LadderVarToSql in 'Test.LadderVarToSql.pas',
  Ladder.SqlServerConnection in '..\..\Ladder.SqlServerConnection.pas',
  Ladder.Utils in '..\..\Ladder.Utils.pas',
  Form.CadastroAtividade in '..\..\Forms\Form.CadastroAtividade.pas' {FormCadastroAtividade},
  Form.ProcessEditor in '..\..\Forms\Form.ProcessEditor.pas' {FormProcessEditor},
  Form.NovoProcesso in '..\..\Forms\Form.NovoProcesso.pas' {FormNovoProcesso},
  Form.SelecionaConsulta in '..\..\Forms\Form.SelecionaConsulta.pas' {FormSelecionaConsulta},
  Test.Forms in 'Test.Forms.pas',
  Form.PesquisaAviso in '..\..\Forms\Form.PesquisaAviso.pas' {FormPesquisaAviso},
  Ladder.ORM.ObjectDataSet in '..\..\ORM\Ladder.ORM.ObjectDataSet.pas',
  uConClasses in '..\..\..\utils\uConClasses.pas',
  Test.ObjectDataset in 'Test.ObjectDataset.pas',
  Ladder.ORM.Dao in '..\..\ORM\Ladder.ORM.Dao.pas',
  Ladder.ORM.DaoUtils in '..\..\ORM\Ladder.ORM.DaoUtils.pas',
  Test.DaoUtils in 'Test.DaoUtils.pas',
  uConClasses.Dao in '..\..\..\utils\uConClasses.Dao.pas',
  Form.ProcessEditorBase in '..\..\Forms\Form.ProcessEditorBase.pas' {FormProcessEditorBase},
  Form.ConsultaEditor in 'Form.ConsultaEditor.pas' {FormConsultaEditor},
  Ladder.Parser in '..\..\Ladder.Parser.pas',
  Ladder.SyntaxChecker in '..\..\Ladder.SyntaxChecker.pas',
  Ladder.ExpressionEvaluator in '..\..\Ladder.ExpressionEvaluator.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  DUnitTestRunner.RunRegisteredTests;
  Application.CreateForm(TConSqlServer, ConSqlServer);
  Application.Run;
end.

