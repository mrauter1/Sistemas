unit uPedidoView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSidViewBase, Mask, DBCtrls, ViewBase, DadosView, CadView, StdCtrls,
  Buttons, ExtCtrls, uPedidoControle, uMVCInterfaces, uInterfacesTesteMVC,
  ComCtrls;

type
  TPedidoView = class(TSidViewBase)
    Label2: TLabel;
    DBDescricao: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    DBText1: TDBText;
    SpeedButton1: TSpeedButton;
    BtnProdutos: TButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ViewInsere;
    procedure BtnProdutosClick(Sender: TObject);
    procedure ViewBeforeMudaEstado(Estado: TViewEstado);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TPedidoView.BtnProdutosClick(Sender: TObject);
begin
  if (EditCod.Text = '') then Exit;

  (View.Controle as IPedidoCtrl).AbrePedidoItem;
end;

procedure TPedidoView.SpeedButton1Click(Sender: TObject);
begin
  if (View.Estado in ([vAtivo, vInativo])) and
    (EditCod.Text = '') then Exit;

  View.CadControle.BtnEditClick;
  (View.Controle as IPedidoCtrl).AbreCliente;
end;

procedure TPedidoView.ViewBeforeMudaEstado(Estado: TViewEstado);
begin
  inherited;
  BtnProdutos.Enabled:= (not (Estado in ([vInserindo, vEditando]))) and (EditCod.Text <> '');
end;

procedure TPedidoView.ViewInsere;
begin
  inherited;
  DBDescricao.SetFocus;
end;

end.
