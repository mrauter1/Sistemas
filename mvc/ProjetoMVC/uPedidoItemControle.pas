unit uPedidoItemControle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadControle, DB, uPedidoItemModelo, uSidListControle, uInterfacesTesteMVC, uProdutoModelo, uMVCInterfaces;

type
  TPedidoItemControle = class(TSidListControle, IPedidoItemControle)
    procedure DataModuleCreate(Sender: TObject);
  private
    function GetPedidoItemModelo: TPedidoItemModelo;
  protected
    property PedidoItemModelo: TPedidoItemModelo read GetPedidoItemModelo;
    procedure DoSetModelo; override;
    procedure DoBeforeInsere(var CancelaAcao: Boolean); override;
  public
    function ConsultaProduto: String;
  end;

implementation

{$R *.dfm}

uses
  uPedidoItemView, uProdutoControle;

procedure TPedidoItemControle.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ModeloClass:= TPedidoItemModelo;
  ViewClass:= TPedidoItemView;
end;

procedure TPedidoItemControle.DoSetModelo;
begin
  inherited;

end;

function TPedidoItemControle.GetPedidoItemModelo: TPedidoItemModelo;
begin
  Result:= (DadosModelo as TPedidoItemModelo);
end;

procedure TPedidoItemControle.DoBeforeInsere(var CancelaAcao: Boolean);
begin
  if not PedidoItemModelo.Produto.ExisteProduto(ParametroAtual) then
  begin
    CancelaAcao:= True;
    raise EInformaErro.Create('Produto não existe ou está bloqueado!');
  end;
end;

function TPedidoItemControle.ConsultaProduto: String;
var
  CodConsulta: Variant;
//  Temp: String;
begin
  CodConsulta:= TProdutoControle.CriaConsulta(CadModelo.Conexao);;
  Result:= VarToStrDef(CodConsulta, '');
end;



end.
