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
  Ladder.Activity.Parser in '..\Ladder.Activity.Parser.pas',
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
  Form.CadastroProcesso in '..\..\Forms\Form.CadastroProcesso.pas' {FormCadastroProcesso},
  Form.NovoProcesso in '..\..\Forms\Form.NovoProcesso.pas' {FormNovoProcesso},
  Form.SelecionaConsulta in '..\..\Forms\Form.SelecionaConsulta.pas' {FormSelecionaConsulta},
  Test.Forms in 'Test.Forms.pas',
  Form.PesquisaAviso in '..\..\Forms\Form.PesquisaAviso.pas' {FormPesquisaAviso},
  Form.CadastroProcessoConsulta in '..\..\Forms\Form.CadastroProcessoConsulta.pas' {FormCadastroProcessoConsulta},
  Ladder.ORM.DataSetBinding in '..\..\ORM\Ladder.ORM.DataSetBinding.pas',
  Ladder.ORM.ObjectDataSet in '..\..\ORM\Ladder.ORM.ObjectDataSet.pas',
  uConClasses in '..\..\..\utils\uConClasses.pas',
  Spring.Data.ObjectDataSet in '..\..\ORM\Spring.Data.ObjectDataSet.pas',
  Test.ObjectDataset in 'Test.ObjectDataset.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  DUnitTestRunner.RunRegisteredTests;
  Application.CreateForm(TConSqlServer, ConSqlServer);
  Application.Run;
end.

