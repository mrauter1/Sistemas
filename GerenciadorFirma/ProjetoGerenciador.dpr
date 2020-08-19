program ProjetoGerenciador;

uses
  MidasLib,
  Vcl.Forms,
  uFormPrincipal in 'uFormPrincipal.pas' {FormPrincipal},
  uDmFilaProducao in 'uDmFilaProducao.pas' {DMFilaProducao: TDataModule},
  uDmEstoqProdutos in 'uDmEstoqProdutos.pas' {DmEstoqProdutos: TDataModule},
  uFuncProbabilidades in 'uFuncProbabilidades.pas',
  uFormPedidos in 'uFormPedidos.pas' {FormPedidos},
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
  uFormValidaModelos in 'uFormValidaModelos.pas' {FormValidaModelos},
  uConSqlServer in '..\utils\uConSqlServer.pas' {ConSqlServer: TDataModule},
  uDmConnection in '..\utils\uDmConnection.pas' {DmConnection: TDataModule},
  uFrmConsulta in 'Fontes\uFrmConsulta.pas' {FrmConsulta},
  uFormExecSql in 'Fontes\uFormExecSql.pas' {FormExecSql},
  uFormRelatoriosPersonalizados in 'Fontes\uFormRelatoriosPersonalizados.pas' {FormRelatoriosPersonalizados},
  uConsultaPersonalizada in '..\utils\uConsultaPersonalizada.pas' {FrmConsultaPersonalizada},
  UCopyFolder3Test in 'Fontes\UCopyFolder3Test.pas',
  uAtualiza in 'Fontes\uAtualiza.pas',
  uSendMail in '..\utils\uSendMail.pas',
  uDmGeradorConsultas in '..\utils\uDmGeradorConsultas.pas' {DmGeradorConsultas: TDataModule},
  uConFirebird in '..\utils\uConFirebird.pas' {ConFirebird: TDataModule},
  uFormSubGrupoExtras in 'Fontes\uFormSubGrupoExtras.pas' {FormSubGrupoExtras},
  uFormFeriados in 'Fontes\uFormFeriados.pas' {FormFeriados},
  uFormCiclosVenda in 'Fontes\uFormCiclosVenda.pas' {FormCiclosVenda},
  uFormMotivoParaIgnorar in 'uFormMotivoParaIgnorar.pas' {FormMotivoIgnorar},
  uFormCompras in 'Fontes\uFormCompras.pas' {FormCiclos},
  GerenciadorUtils in '..\utils\GerenciadorUtils.pas',
  uAppConfig in '..\utils\uAppConfig.pas',
  uDmGravaLista in '..\utils\uDmGravaLista.pas' {DmGravaLista: TDataModule},
  uFormLogistica in 'Fontes\uFormLogistica.pas' {FormLogistica},
  uFormEntregaPorProduto in 'Fontes\uFormEntregaPorProduto.pas' {FormEntregaPorProduto},
  Root,
  Form.ActivityEditor in '..\Ladder Framework\Forms\Form.ActivityEditor.pas' {FormActivityEditor},
  Form.ConsultaEditor in '..\Ladder Framework\Forms\Form.ConsultaEditor.pas',
  Form.ProcessActivityEditor in '..\Ladder Framework\Forms\Form.ProcessActivityEditor.pas',
  Form.SimpleProcessEditor in '..\Ladder Framework\Forms\Form.SimpleProcessEditor.pas';

{$R *.res}

var
  FRootClass: TRootClass;

begin
  with TAtualiza.Create(AppConfig.PastaUpdate) do
  try
    VerificaEAtualiza;
  finally
    Free;
  end;

  FRootClass:= TRootClass.Create;
  try
    FRootClass.CreateAllTables;
  finally
    FRootClass.Free;
  end;

  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TConSqlServer, ConSqlServer);
  Application.CreateForm(TConFirebird, ConFirebird);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDmEstoqProdutos, DmEstoqProdutos);
  Application.CreateForm(TDMFilaProducao, DMFilaProducao);
  Application.CreateForm(TPedidos, Pedidos);
  Application.CreateForm(TFormFilaProducao, FormFilaProducao);
  //  Application.CreateForm(TFormProInfo, FormProInfo);
//  Application.CreateForm(TDMConsistenciaOPs, DMConsistenciaOPs);
//  Application.CreateForm(TFormPedidos, FormPedidos);
//  Application.CreateForm(TFormDensidades, FormDensidades);
//  Application.CreateForm(TFormConversorLKG, FormConversorLKG);
//  Application.CreateForm(TFormConsistenciaOPs, FormConsistenciaOPs);
//  Application.CreateForm(TFormShowMemo, FormShowMemo);
  Application.CreateForm(TFormGlobal, FormGlobal);
//  Application.CreateForm(TFormDetalheProdutos, FormDetalheProdutos);
//  Application.CreateForm(TFormSubGrupoExtras, FormSubGrupoExtras);
//  Application.CreateForm(TFormLogistica, FormLogistica);
//  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
