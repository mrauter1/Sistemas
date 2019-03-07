program AjustaFretes;

uses
  Vcl.Forms,
  uFrmAjustaNeg in 'uFrmAjustaNeg.pas' {FrmAjusteNeg},
  uDmConnection in '..\utils\uDmConnection.pas' {DmConnection: TDataModule},
  uConFirebird in '..\utils\uConFirebird.pas' {ConFirebird: TDataModule},
  uAppConfig in 'uAppConfig.pas',
  uFrmPesquisaTransp in 'uFrmPesquisaTransp.pas' {FrmPesquisaTransp},
  uFrmCalculadoraDeFretes in 'uFrmCalculadoraDeFretes.pas' {FrmCalculadoraDeFretes},
  uConSqlServer in '..\utils\uConSqlServer.pas' {ConSqlServer: TDataModule},
  uFrmPesquisaNeg in 'uFrmPesquisaNeg.pas' {FrmPesquisaNeg},
  Utils in '..\utils\Utils.pas',
  uConsultaPersonalizada in '..\utils\uConsultaPersonalizada.pas' {FrmConsultaPersonalizada},
  uDmGeradorConsultas in '..\utils\uDmGeradorConsultas.pas' {DmGeradorConsultas: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TConSqlServer, ConSqlServer);
  Application.CreateForm(TConFirebird, ConFirebird);
  Application.CreateForm(TFrmAjusteNeg, FrmAjusteNeg);
  Application.CreateForm(TFrmCalculadoraDeFretes, FrmCalculadoraDeFretes);
  Application.Run;
end.
