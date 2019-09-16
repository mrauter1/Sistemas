program Logistec;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  udmSqlUtils in '..\..\GerenciadorFirma\udmSqlUtils.pas' {DmSqlUtils: TDataModule},
  uRefreshData in 'uRefreshData.pas' {FrmRefreshData},
  uDmFDConnection in 'uDmFDConnection.pas' {DataModule1: TDataModule},
  uFrmJobs in 'uFrmJobs.pas' {FrmJobs};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmSqlUtils, DmSqlUtils);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrmRefreshData, FrmRefreshData);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFrmJobs, FrmJobs);
  Application.Run;
end.
