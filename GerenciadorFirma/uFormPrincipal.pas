unit uFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmEstoqProdutos, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.Menus, GerenciadorUtils, uFormPedidos, uFormFila,
  uFormDensidades, uFormConversorLKG, uFormProInfo, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, Vcl.ExtCtrls, uFormGlobal;

type
  TFormPrincipal = class(TForm)
    MainMenu: TMainMenu;
    Pedidos1: TMenuItem;
    Fila1: TMenuItem;
    Densidade1: TMenuItem;
    Conversor1: TMenuItem;
    MenuItemProInfo: TMenuItem;
    PanelMain: TPanel;
    DetalhedosProdutos1: TMenuItem;
    Utilidades1: TMenuItem;
    Extras1: TMenuItem;
    Pedidos21: TMenuItem;
    procedure Pedidos1Click(Sender: TObject);
    procedure Fila1Click(Sender: TObject);
    procedure Densidade1Click(Sender: TObject);
    procedure Conversor1Click(Sender: TObject);
    procedure MenuItemProInfoClick(Sender: TObject);
    procedure BtnAtualizaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DetalhedosProdutos1Click(Sender: TObject);
    procedure Pedidos21Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses
  uDmFilaProducao, Utils, uFormDetalheProdutos, uFormPedidos2;

procedure TFormPrincipal.BtnAtualizaClick(Sender: TObject);
begin
  DMFilaProducao.AtualizaFilaProducao;
end;

procedure TFormPrincipal.Conversor1Click(Sender: TObject);
begin
  FormConversorLKG.Show;
end;

procedure TFormPrincipal.Densidade1Click(Sender: TObject);
begin
  FormDensidades.Show;
end;

procedure TFormPrincipal.DetalhedosProdutos1Click(Sender: TObject);
begin
  FormDetalheProdutos.Show;
end;

procedure TFormPrincipal.Fila1Click(Sender: TObject);
begin
  FormFilaProducao.Show;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  EmbedForm(PanelMain, FormPedidos);
end;

procedure TFormPrincipal.MenuItemProInfoClick(Sender: TObject);
begin
  FormProInfo.Show;
end;

procedure TFormPrincipal.Pedidos1Click(Sender: TObject);
begin
  FormPedidos.Show;
end;

procedure TFormPrincipal.Pedidos21Click(Sender: TObject);
begin
  FormPedidos2.Show;
end;

end.
