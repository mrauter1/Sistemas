unit uPedidoControle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDadosControleBase, uModeloBase, DB, uPedidoModelo, DBClient, uMVCInterfaces,
  uInterfacesTesteMVC, uSidControle, uClienteModelo, uConexaoBase,
  uFormCadViewBase, uConBase, uCadControle, uFormRelBase;

type
  TPedidoCtrl = class(TSidControle, IPedidoCtrl)
    DataSourcePedidoItens: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
  protected
//    ClienteControle: TCadControle;
    procedure ConfiguraCliente(Controle: TCadControle);
    procedure ConfiguraPedidoItem(Controle: TCadControle);
    procedure DoSetModelo; override;
    procedure ConfiguraConsulta(FormConsulta: TfConBase); override;
  public
    function AbreCliente: Integer;
    function AbrePedidoItem: Integer;
  end;

implementation

uses
  uCadPedido, uPedidoView, uPedidoItemControle, uClienteControle;

{$R *.dfm}

procedure TPedidoCtrl.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ViewClass:= TPedidoView;
  ModeloClass:= TPedidoMD;
  RelatorioClass:= TFormRelBase;
end;

procedure TPedidoCtrl.DoSetModelo;
begin
  inherited;
  DataSourcePedidoItens.DataSet:= (Modelo as TPedidoMD).Itens.CDS;
end;

procedure TPedidoCtrl.ConfiguraConsulta(FormConsulta: TfConBase);
begin
  FormConsulta.SetCamposFiltro('NOME;COD');
  FormConsulta.CamposResult:= 'COD';
  FormConsulta.Caption:= 'Consulta Pedido';
end;

procedure TPedidoCtrl.ConfiguraCliente(Controle: TCadControle);
begin
  Controle.Modelo:= (Modelo as TPedidoMD).Cliente;
  Controle.Permissoes:= ([Editar, Consultar]);
  Controle.SetPodeNavegar(False);
end;

procedure TPedidoCtrl.ConfiguraPedidoItem(Controle: TCadControle);
begin
  Controle.Modelo:= (Modelo as TPedidoMD).Itens;
end;

function TPedidoCtrl.AbreCliente: Integer;
var
  CodConsulta: Variant;
  Temp: String;
begin
  Result:= 1;
  if not (Datasource.DataSet.State in ([dsEdit, dsInsert])) then
  begin
    TClienteControle.CriaView(CadModelo.Conexao, ConfiguraCliente);
  end
 else
  begin
    CodConsulta:= TClienteControle.CriaConsulta(CadModelo.Conexao);;
    temp:= VarToStrDef(CodConsulta, '');
    if temp <> '' then
    begin
      (CadModelo as TPedidoMD).CODCLIENTE.AsString:= temp;
    end;
  end;
end;

function TPedidoCtrl.AbrePedidoItem: Integer;
begin
  Result:= 1;
  TPedidoItemControle.CriaView(CadModelo.Conexao, ConfiguraPedidoItem);
end;

end.
