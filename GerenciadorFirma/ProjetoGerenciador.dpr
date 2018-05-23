program ProjetoGerenciador;

uses
  MidasLib,
  Vcl.Forms,
  uFormPrincipal in 'uFormPrincipal.pas' {FormPrincipal},
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
  uFormConsistenciaOPs in 'uFormConsistenciaOPs.pas' {FormConsistenciaOPs},
  JSONConverter in '..\utils\JSONConverter.pas',
  uFrmShowMemo in 'uFrmShowMemo.pas' {FormShowMemo},
  uPedidos in 'Fontes\uPedidos.pas' {Pedidos: TDataModule},
  uFormGlobal in 'uFormGlobal.pas' {FormGlobal},
  uFormDetalheProdutos in 'Fontes\uFormDetalheProdutos.pas' {FormDetalheProdutos},
  Utils in '..\utils\Utils.pas',
  uFormPedidos2 in 'Fontes\uFormPedidos2.pas' {FormPedidos2},
  uFormAdicionarSimilaridade in 'Fontes\uFormAdicionarSimilaridade.pas' {FormAdicionarSimilaridade},
  uFormInsumos in 'Fontes\uFormInsumos.pas' {FormInsumos},
  uFormSelecionaModelos in 'Fontes\uFormSelecionaModelos.pas' {FormSelecionaModelo},
  uSendMail in 'Fontes\uSendMail.pas',
  uEnviaEmailPedidos in 'uEnviaEmailPedidos.pas',
  uDMEnviaPedidos in 'uDMEnviaPedidos.pas' {DMEnviaPedidos: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmSqlUtils, DmSqlUtils);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormProInfo, FormProInfo);
  Application.CreateForm(TPedidos, Pedidos);
  Application.CreateForm(TDMFilaProducao, DMFilaProducao);
  Application.CreateForm(TDmEstoqProdutos, DmEstoqProdutos);
  Application.CreateForm(TDMConsistenciaOPs, DMConsistenciaOPs);
  Application.CreateForm(TFormPedidos, FormPedidos);
  Application.CreateForm(TFormFilaProducao, FormFilaProducao);
  Application.CreateForm(TFormDensidades, FormDensidades);
  Application.CreateForm(TFormConversorLKG, FormConversorLKG);
  Application.CreateForm(TFormConsistenciaOPs, FormConsistenciaOPs);
  Application.CreateForm(TFormShowMemo, FormShowMemo);
  Application.CreateForm(TFormGlobal, FormGlobal);
  Application.CreateForm(TFormDetalheProdutos, FormDetalheProdutos);
  Application.CreateForm(TFormPedidos2, FormPedidos2);
  Application.CreateForm(TDMEnviaPedidos, DMEnviaPedidos);
  Application.Run;
end.
