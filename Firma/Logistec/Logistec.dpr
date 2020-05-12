program Logistec;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  uRefreshData in 'uRefreshData.pas' {FrmRefreshData},
  uDmFDConnection in 'uDmFDConnection.pas' {DataModule1: TDataModule},
  uFrmJobs in 'uFrmJobs.pas' {FrmJobs},
  udmSqlUtils in 'udmSqlUtils.pas' {DmSqlUtils: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrmRefreshData, FrmRefreshData);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFrmJobs, FrmJobs);
  Application.CreateForm(TDmSqlUtils, DmSqlUtils);
  Application.Run;
end.
