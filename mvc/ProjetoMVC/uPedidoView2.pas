unit uPedidoView2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormViewBase, Mask, DBCtrls, StdCtrls, Buttons, ExtCtrls, ViewBase,
  DadosView, CadView, uPedidoControle, uMVCInterfaces;

type
  TPedidoView2 = class(TFormViewBase)
    PanelControles: TPanel;
    BtnSair: TBitBtn;
    BtnNovo: TButton;
    PanelClient: TPanel;
    PanelDados: TPanel;
    BtnPesquisa: TSpeedButton;
    EditCod: TEdit;
    Label1: TLabel;
    DBDescricao: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    DBText1: TDBText;
    SpeedButton1: TSpeedButton;
    BtnIncluir: TButton;
    BtnAlterar: TButton;
    BtnExcluir: TButton;
    BtnCancela: TButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ViewBeforeMudaEstado(Estado: TViewEstado);
    procedure ViewVerificaPodeDeletar(var Pode: Boolean);
    procedure ViewVerificaPodeInserir(var Pode: Boolean);
    procedure ViewVerificaPodeCancelar(var Pode: Boolean);
  private

  public
    { Public declarations }
  end;

var
  PedidoView2: TPedidoView2;

implementation

{$R *.dfm}

uses
  uInterfacesTesteMVC;

procedure TPedidoView2.SpeedButton1Click(Sender: TObject);
begin
  if (View.Estado in ([vAtivo, vInativo])) and
    ((VarToStr(View.ValorIndiceDef('')) = '')) then Exit;
  
  View.CadControle.BtnEditClick;
  (View.Controle as IPedidoCtrl).AbreCliente;
end;

procedure TPedidoView2.ViewBeforeMudaEstado(Estado: TViewEstado);
begin
  if Estado = vInserindo then
  begin
    View.BtnConfirm:= BtnIncluir;
    BtnAlterar.Enabled:= False;
  end
  else begin
    View.BtnConfirm:= BtnAlterar;
    BtnIncluir.Enabled:= False;
  end;
end;

procedure TPedidoView2.ViewVerificaPodeCancelar(var Pode: Boolean);
begin
  if not Pode then
    Pode:= (VarToStr(View.ValorIndiceDef('')) <> '');
end;

procedure TPedidoView2.ViewVerificaPodeDeletar(var Pode: Boolean);
begin
  inherited;
  Pode:=  (VarToStr(View.ValorIndiceDef('')) <> '') and (Excluir in View.CadControle.GetPermissoes);
end;

procedure TPedidoView2.ViewVerificaPodeInserir(var Pode: Boolean);
begin
  if Pode then
    if EditCod.Text <> '' then
      Pode:= False;
end;

end.
