unit uSidViewBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormViewBase, Mask, DBCtrls, StdCtrls, Buttons, ExtCtrls, ViewBase,
  DadosView, CadView, uMVCInterfaces, ComCtrls;

type
  TSidViewBase = class(TFormViewBase)
    PanelControles: TPanel;
    BtnSair: TBitBtn;
    BtnNovo: TButton;
    PanelClient: TPanel;
    BtnPesquisa: TSpeedButton;
    EditCod: TEdit;
    Label1: TLabel;
    StatusBar: TStatusBar;
    PageControl: TPageControl;
    TabDados: TTabSheet;
    BtnIncluir: TButton;
    BtnAlterar: TButton;
    BtnExcluir: TButton;
    BtnCancela: TButton;
    procedure ViewBeforeMudaEstado(Estado: TViewEstado);
    procedure ViewVerificaPodeDeletar(var Pode: Boolean);
    procedure ViewVerificaPodeInserir(var Pode: Boolean);
    procedure ViewVerificaPodeCancelar(var Pode: Boolean);
    procedure FormShow(Sender: TObject);
  private

  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  uInterfacesTesteMVC;

procedure TSidViewBase.FormShow(Sender: TObject);
begin
  inherited;
  PageControl.ActivePage:= TabDados;
end;

procedure TSidViewBase.ViewBeforeMudaEstado(Estado: TViewEstado);
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
end;

procedure TSidViewBase.ViewVerificaPodeCancelar(var Pode: Boolean);
begin
  if not Pode then
    Pode:= (EditCod.Text <> '');

  //Quando btnCancela estiver habilitado sair fica desabilitado,
  //se cancela desabilitado, habilita btnsair
  BtnSair.Enabled:= not Pode;
end;

procedure TSidViewBase.ViewVerificaPodeDeletar(var Pode: Boolean);
begin
  inherited;
  Pode:=  (EditCod.Text <> '') and (Excluir in View.CadControle.GetPermissoes);
end;

procedure TSidViewBase.ViewVerificaPodeInserir(var Pode: Boolean);
begin
  if Pode then
    if EditCod.Text <> '' then
      Pode:= False;
end;

end.
