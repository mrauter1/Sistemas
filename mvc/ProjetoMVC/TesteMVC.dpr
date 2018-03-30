program TesteMVC;

uses
  Forms,
  uControleBase in '..\MVC\uControleBase.pas' {ControleBase: TDataModule},
  uDadosControleBase in '..\MVC\uDadosControleBase.pas' {DadosControleBase: TDataModule},
  uModeloBase in '..\MVC\uModeloBase.pas' {ModeloBase: TDataModule},
  uDadosModeloBase in '..\MVC\uDadosModeloBase.pas' {DadosModeloBase: TDataModule},
  uMVCInterfaces in '..\MVC\uMVCInterfaces.pas',
  uPedidoModelo in 'uPedidoModelo.pas' {PedidoMD: TDataModule},
  uPedidoControle in 'uPedidoControle.pas' {PedidoCtrl: TDataModule},
  UMain in 'UMain.pas' {fMain},
  uConexaoBase in '..\MVC\uConexaoBase.pas' {ConexaoBase: TDataModule},
  uConexaoDBX in '..\MVC\uConexaoDBX.pas' {ConexaoDBX: TDataModule},
  uCadModelo in '..\mvc\uCadModelo.pas' {CadModelo: TDataModule},
  uCadPedido in 'uCadPedido.pas' {CadPedido},
  uInterfacesTesteMVC in 'uInterfacesTesteMVC.pas',
  uFuncoesSQL in '..\mvc\uFuncoesSQL.pas',
  uCadControle in '..\mvc\uCadControle.pas' {CadControle: TDataModule},
  uClienteModelo in 'uClienteModelo.pas' {ClienteModelo: TDataModule},
  uClienteControle in 'uClienteControle.pas' {ClienteControle: TDataModule},
  uClienteView in 'uClienteView.pas' {ClienteView},
  uConexaoIBO in '..\mvc\uConexaoIBO.pas' {ConexaoIBO: TDataModule},
  MVCUtils in '..\mvc\MVCUtils.pas',
  CadView in '..\mvc\CadView.pas',
  ViewBase in '..\mvc\ViewBase.pas',
  DadosView in '..\mvc\DadosView.pas',
  uFormViewBase in '..\mvc\uFormViewBase.pas' {FormViewBase},
  uFormCadViewBase in '..\mvc\uFormCadViewBase.pas' {FormCadViewBase},
  uConBase in '..\mvc\uConBase.pas',
  uSidViewBase in 'uSidViewBase.pas' {SidViewBase},
  uSidControle in 'uSidControle.pas' {SidControle: TDataModule},
  uPedidoView in 'uPedidoView.pas' {PedidoView},
  uSidListViewBase in 'uSidListViewBase.pas' {SidListViewBase},
  uPedidoItemView in 'uPedidoItemView.pas' {PedidoItemView},
  uPedidoItemControle in 'uPedidoItemControle.pas' {PedidoItemControle: TDataModule},
  uPedidoItemModelo in 'uPedidoItemModelo.pas' {PedidoItemModelo: TDataModule},
  uSidListControle in 'uSidListControle.pas' {SidListControle: TDataModule},
  uProdutoModelo in 'uProdutoModelo.pas' {ProdutoModelo: TDataModule},
  uProdutoControle in 'uProdutoControle.pas' {ProdutoControle: TDataModule},
  uProdutoView in 'uProdutoView.pas' {ProdutoView},
  uFormRelBase in 'uFormRelBase.pas' {FormRelBase};

{$R *.res}

begin
  Application.Initialize;

//  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TConexaoDBX, ConexaoDBX);
  Application.CreateForm(TConexaoIBO, ConexaoIBO);
  Application.CreateForm(TSidListControle, SidListControle);
  Application.CreateForm(TProdutoModelo, ProdutoModelo);
  Application.CreateForm(TFormRelBase, FormRelBase);
  //  Application.CreateForm(TConexaoIBO, ConexaoIBO);
  Application.Run;
end.
