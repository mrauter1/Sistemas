program Monitor;

uses
  Vcl.Forms,
  windows,
  SysUtils,
  FormMonitor in 'FormMonitor.pas' {Form1},
  uDMEnviaPedidos in 'uDMEnviaPedidos.pas' {DMEnviaPedidos: TDataModule},
  udmSqlUtils in 'udmSqlUtils.pas' {DmSqlUtils: TDataModule},
  Utils in '..\utils\Utils.pas',
  uSendMail in 'Fontes\uSendMail.pas';

{$R *.res}

begin
  if CreateMutex(nil, True, 'Global\580AB022-E8EB-482D-B11E-D1AFC00332F9') = 0 then
    RaiseLastOSError;

  if GetLastError = ERROR_ALREADY_EXISTS then
    Exit;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDmSqlUtils, DmSqlUtils);
  Application.CreateForm(TDMEnviaPedidos, DMEnviaPedidos);
  Application.Run;
end.
