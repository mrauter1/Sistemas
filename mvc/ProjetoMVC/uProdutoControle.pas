unit uProdutoControle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSidControle, DB, uProdutoModelo, uConBase, uPedidoItemModelo;

type
  TProdutoControle = class(TSidControle)
    DataSourcePedidoItem: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
  protected
    procedure DoSetModelo; override;
    procedure ConfiguraConsulta(FormConsulta: TfConBase); override;
  public
    { Public declarations }
  end;

implementation

uses
  uProdutoView;

{$R *.dfm}

procedure TProdutoControle.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ViewClass:= TProdutoView;
  ModeloClass:= TProdutoModelo;
end;


procedure TProdutoControle.DoSetModelo;
begin
  inherited;
  DataSourcePedidoItem.DataSet:= (Modelo as TProdutoModelo).Itens.CDS;
end;

procedure TProdutoControle.ConfiguraConsulta(FormConsulta: TfConBase);
begin
  FormConsulta.SetCamposFiltro('NOME;COD');
  FormConsulta.CamposResult:= 'COD';
  FormConsulta.Caption:= 'Consulta Produto';
end;

end.
