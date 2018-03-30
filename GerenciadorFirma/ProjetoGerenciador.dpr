program ProjetoGerenciador;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  uDmFilaProducao in 'uDmFilaProducao.pas' {DMFilaProducao: TDataModule},
  uDmEstoqProdutos in 'uDmEstoqProdutos.pas' {DmEstoqProdutos: TDataModule},
  udmSqlUtils in 'udmSqlUtils.pas' {DmSqlUtils: TDataModule},
  uFuncProbabilidades in 'uFuncProbabilidades.pas',
  uFormPedidos in 'uFormPedidos.pas' {FormPedidos},
  GerenciadorUtils in 'GerenciadorUtils.pas',
  uFormFila in 'uFormFila.pas' {FormFilaProducao},
  uFormDensidades in 'uFormDensidades.pas' {FormDensidades},
  uFormConversorLKG in 'uFormConversorLKG.pas' {FormConversorLKG},
  uFormProInfo in 'uFormProInfo.pas' {FormProInfo},
  uDmConsistenciaOPs in 'uDmConsistenciaOPs.pas' {DMConsistenciaOPs: TDataModule},
  uFormConsistenciaOPs in 'uFormConsistenciaOPs.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmSqlUtils, DmSqlUtils);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormPedidos, FormPedidos);
  Application.CreateForm(TFormFilaProducao, FormFilaProducao);
  Application.CreateForm(TFormDensidades, FormDensidades);
  Application.CreateForm(TFormConversorLKG, FormConversorLKG);
  Application.CreateForm(TFormProInfo, FormProInfo);
  Application.CreateForm(TDMFilaProducao, DMFilaProducao);
  Application.CreateForm(TDmEstoqProdutos, DmEstoqProdutos);
  Application.CreateForm(TDMConsistenciaOPs, DMConsistenciaOPs);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
