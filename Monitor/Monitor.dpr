program Monitor;

uses
  MidasLib,
  Vcl.Forms,
  WinApi.windows,
  SysUtils,
  IniFiles,
  uMonitorAppConfig in 'uMonitorAppConfig.pas',
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
  uAppConfig in '..\utils\uAppConfig.pas',
  uDmGravaLista in '..\utils\uDmGravaLista.pas' {DmGravaLista: TDataModule},
  Root,
  Ladder.Executor.Activity in '..\Ladder Framework\Activity\Executor\Ladder.Executor.Activity.pas',
  Ladder.Executor.ConsultaPersonalizada in '..\Ladder Framework\Activity\Executor\Ladder.Executor.ConsultaPersonalizada.pas',
  Ladder.Executor.Email in '..\Ladder Framework\Activity\Executor\Ladder.Executor.Email.pas',
  Form.ActivityEditor in '..\Ladder Framework\Forms\Form.ActivityEditor.pas' {FormActivityEditor},
  Form.ConsultaEditor in '..\Ladder Framework\Forms\Form.ConsultaEditor.pas',
  Form.ProcessActivityEditor in '..\Ladder Framework\Forms\Form.ProcessActivityEditor.pas',
  Ladder.Activity.Scheduler in '..\Ladder Framework\Activity\Ladder.Activity.Scheduler.pas',
  uMonitorRoot in 'uMonitorRoot.pas',
  Form.ProcessEditor in '..\Ladder Framework\Forms\Form.ProcessEditor.pas' {FormProcessEditor},
  Form.ProcessEditorBase in '..\Ladder Framework\Forms\Form.ProcessEditorBase.pas' {FormProcessEditorBase};

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

  MonitorAppConfig:= TMonitorAppConfig.Create;
  MonitorAppConfig.LerConfig;

  MonitorAppConfig.Inicializar;

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
