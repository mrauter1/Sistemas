program Monitor;

uses
  MidasLib,
  Vcl.Forms,
  WinApi.windows,
  SysUtils,
  FormMonitor in 'FormMonitor.pas' {MonitorMain},
  uDMEnviaPedidos in 'uDMEnviaPedidos.pas' {DMEnviaPedidos: TDataModule},
  Utils in '..\utils\Utils.pas',
  udmSqlUtils in '..\utils\udmSqlUtils.pas' {DmSqlUtils: TDataModule},
  uSendMail in '..\utils\uSendMail.pas',
  uDataSetToHtml in 'uDataSetToHtml.pas',
  uDmGeradorConsultas in '..\utils\uDmGeradorConsultas.pas' {DmGeradorConsultas: TDataModule},
  uDmConnection in '..\utils\uDmConnection.pas' {DmConnection: TDataModule},
  uConFirebird in 'uConFirebird.pas' {ConFirebird: TDataModule},
  uConSqlServer in 'uConSqlServer.pas' {ConSqlServer: TDataModule},
  uDmEnviaRelatorios in 'uDmEnviaRelatorios.pas' {Con: TDataModule},
  uConsultaPersonalizada in '..\utils\uConsultaPersonalizada.pas' {FrmConsultaPersonalizada},
  Form.CadastroAtividade in 'Forms\Form.CadastroAtividade.pas' {FormCadastroAviso},
  Form.CadastroProcesso in 'Forms\Form.CadastroProcesso.pas' {FormCadastroProcesso},
  uFormPesquisaAviso in 'uFormPesquisaAviso.pas' {FormPesquisaAviso},
  Form.SelecionaConsulta in 'Forms\Form.SelecionaConsulta.pas' {FormSelecionaConsulta},
  uAppConfig in '..\utils\uAppConfig.pas',
  uDmGravaLista in '..\utils\uDmGravaLista.pas' {DmGravaLista: TDataModule},
  Form.NovoProcesso in 'Forms\Form.NovoProcesso.pas' {FormNovoProcesso},
  Ladder.Activity.ViewClasses in '..\Ladder Framework\Activity\Ladder.Activity.ViewClasses.pas';

{$R *.res}

begin
  WriteLog('Iniciando monitor...');
  if CreateMutex(nil, True, 'Global\580AB022-E8EB-482D-B11E-D1AFC00332F9') = 0 then
    RaiseLastOSError;

  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    WriteLog('Já existe uma instancia do monitor em andamento!');
    Exit;
  end;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  WriteLog('Criando TConSqlServer');
  Application.CreateForm(TConSqlServer, ConSqlServer);
  WriteLog('Criando TConFirebird');
  Application.CreateForm(TConFirebird, ConFirebird);
  WriteLog('Criando TMonitorMain');
  Application.CreateForm(TMonitorMain, MonitorMain);
  WriteLog('Criando TDmSqlUtils');
  Application.CreateForm(TDmSqlUtils, DmSqlUtils);
  WriteLog('Criando TCon');
  Application.CreateForm(TCon, Con);
  WriteLog('Inicializando message loop');
  Application.Run;
end.
