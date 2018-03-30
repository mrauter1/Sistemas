unit uPedidoItemView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSidListViewBase, ViewBase, DadosView, CadView, ComCtrls, Grids,
  DBGrids, StdCtrls, Buttons, ExtCtrls, uPedidoItemControle, Mask, DBCtrls;

type
  TPedidoItemView = class(TSidListViewBase)
    Label1: TLabel;
    EditCod: TEdit;
    BtnPesquisa: TSpeedButton;
    Label2: TLabel;
    DBEdit3: TDBEdit;
    DBText1: TDBText;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    procedure BtnPesquisaClick(Sender: TObject);
    procedure EditCodExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PedidoItemView: TPedidoItemView;

implementation

uses
  uInterfacesTesteMVC;

{$R *.dfm}

procedure TPedidoItemView.BtnPesquisaClick(Sender: TObject);
begin
  inherited;
  EditCod.Text:= (View.Controle as IPedidoItemControle).ConsultaProduto;
  if EditCod.Text <> '' then
  begin
    View.AbreRegistroIndice;
    DBEdit3.SetFocus;
  end;
end;

procedure TPedidoItemView.EditCodExit(Sender: TObject);
begin
  inherited;
  if EditCod.Text = '' then
    EditCod.SetFocus;
end;

end.
