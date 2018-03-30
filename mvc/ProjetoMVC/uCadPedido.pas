unit uCadPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPedidoControle, uFormCadViewBase, StdCtrls, ExtCtrls, Mask, DBCtrls,
  uInterfacesTesteMVC, uMVCInterfaces, Buttons, ViewBase, DadosView, CadView;

type
  TCadPedido = class(TFormCadViewBase)
    panel2: TPanel;
    Label1: TLabel;
    DBEditNome: TDBEdit;
    Label2: TLabel;
    DBEditCliente: TDBEdit;
    Label3: TLabel;
    EditCod: TEdit;
    DBText1: TDBText;
    AbreClienteBtn: TSpeedButton;
    BtnConsulta: TSpeedButton;
    procedure AbreClienteBtnClick(Sender: TObject);
    procedure ViewBeforeMudaEstado(Estado: TViewEstado);
  private

  protected

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TCadPedido.AbreClienteBtnClick(Sender: TObject);
begin
  (View.Controle as IPedidoCtrl).AbreCliente;
end;

procedure TCadPedido.ViewBeforeMudaEstado(Estado: TViewEstado);
begin
  inherited;
  if Estado in ([vInserindo, vEditando]) then
  begin
    View.BtnConfirm:= BtnAdd;
    View.BtnAdd:= nil;
    BtnAdd.Caption:= 'Confirmar';
  end
  else begin
    View.BtnAdd:= BtnAdd;
    View.BtnConfirm:= nil;
    BtnAdd.Caption:= 'Adicionar';
  end;
  AbreClienteBtn.Enabled:= Estado in ([vInserindo, vEditando]);
end;

end.
