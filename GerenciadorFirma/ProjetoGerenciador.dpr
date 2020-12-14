program ProjetoGerenciador;

uses
  MidasLib,
  Vcl.Forms,
  uFormPrincipal in 'uFormPrincipal.pas' {FormPrincipal},
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
  Form.SimpleProcessEditor in '..\Ladder Framework\Forms\Form.SimpleProcessEditor.pas',
  uFormEmailEmbalagens in 'uFormEmailEmbalagens.pas' {FormGravaEmbalagens},
  uFormEmbalagensAVencer in 'Fontes\uFormEmbalagensAVencer.pas' {FormEmbalagensAVencer},
  uFormSelecionaEmailCliente in 'Fontes\uFormSelecionaEmailCliente.pas' {FormSelecionaEmailCliente},
  uFormConfigurarEmailEmbalagens in 'Fontes\uFormConfigurarEmailEmbalagens.pas' {FormConfigurarEmailEmbalagens},
  uFormConfiguraTextoEmailEmbalagem in 'Fontes\uFormConfiguraTextoEmailEmbalagem.pas' {FormConfiguraTextoEmailEmbalagem},
  uFormAdicionarImagemEmailEmbalagem in 'Fontes\uFormAdicionarImagemEmailEmbalagem.pas' {FormAdicionarImagemEmailEmbalagem},
  uFormPermissoes in 'Fontes\uFormPermissoes.pas' {FormPermissoes},
  uFormLogin in 'Fontes\uFormLogin.pas' {FormLogin},
  uFormInputSenha in 'Fontes\uFormInputSenha.pas' {FormInputSenha},
  uFrmAjustaNeg in 'Fontes\Fretes\uFrmAjustaNeg.pas' {FrmAjusteNeg},
  uFrmCalculadoraDeFretes in 'Fontes\Fretes\uFrmCalculadoraDeFretes.pas' {FrmCalculadoraDeFretes},
  uFrmPesquisaNeg in 'Fontes\Fretes\uFrmPesquisaNeg.pas' {FrmPesquisaNeg},
  uFrmPesquisaTransp in 'Fontes\Fretes\uFrmPesquisaTransp.pas' {FrmPesquisaTransp},
  uUpdater in 'Fontes\uUpdater.pas',
  cxUtils in '..\utils\cxUtils.pas',
  uFormAjustaInconsistencias in 'Fontes\uFormAjustaInconsistencias.pas' {FormAjustaInconsistencias},
  uFormEmbalagensClientes in 'Fontes\uFormEmbalagensClientes.pas' {FormEmbalagensClientes};

{$R *.res}

var
  FRootClass: TRootClass;

begin
  with TUpdater.Create(AppConfig.PastaUpdate) do
  try
    CheckAndUpdate;
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
  AppConfig.UserID:= TFormLogin.Login;
  if AppConfig.UserID = 0 then
    Exit;
  Application.CreateForm(TConFirebird, ConFirebird);
  Application.CreateForm(TPedidos, Pedidos);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDmEstoqProdutos, DmEstoqProdutos);
  Application.CreateForm(TFormGlobal, FormGlobal);

  Application.Run;
end.
