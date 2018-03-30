unit uSidListViewBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormViewBase, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, ViewBase,
  DadosView, CadView, ComCtrls, uPedidoItemControle, Mask, DBCtrls, uMVCInterfaces;

type
  TSidListViewBase = class(TFormViewBase)
    PanelControles: TPanel;
    BtnSair: TBitBtn;
    PanelClient: TPanel;
    PanelDados: TPanel;
    PanelBotoes: TPanel;
    BtnIncluir: TButton;
    BtnAlterar: TButton;
    BtnExcluir: TButton;
    BtnCancela: TButton;
    Grid: TDBGrid;
    StatusBar: TStatusBar;
    procedure ViewBeforeMudaEstado(Estado: TViewEstado);
    procedure ViewVerificaPodeInserir(var Pode: Boolean);
    procedure ViewVerificaPodeDeletar(var Pode: Boolean);
    procedure ViewVerificaPodeCancelar(var Pode: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SidListViewBase: TSidListViewBase;

implementation

{$R *.dfm}

procedure TSidListViewBase.ViewBeforeMudaEstado(Estado: TViewEstado);
begin
  inherited;
  if Estado = vInserindo then
  begin
    View.BtnConfirm:= BtnIncluir;
    BtnAlterar.Enabled:= False;
  end
  else begin
    View.BtnConfirm:= BtnAlterar;
    BtnIncluir.Enabled:= False;
  end;
  Grid.Enabled:= not (Estado in ([vInserindo, vEditando]));
end;

procedure TSidListViewBase.ViewVerificaPodeCancelar(var Pode: Boolean);
begin
  inherited;
  BtnSair.Enabled:= not Pode;
end;

procedure TSidListViewBase.ViewVerificaPodeDeletar(var Pode: Boolean);
begin
  inherited;
  Pode:=  (View.IndiceAsString <> '') and (Excluir in View.CadControle.GetPermissoes);
end;

procedure TSidListViewBase.ViewVerificaPodeInserir(var Pode: Boolean);
begin
  inherited;
  if Pode then
    if View.IndiceAsString <> '' then
      Pode:= False;
end;

end.
