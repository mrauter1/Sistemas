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
  Vcl.StdCtrls, Vcl.ExtCtrls, uFormGlobal, uSendMail;

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
    Timer1: TTimer;
    ValidaModelos1: TMenuItem;
    procedure Pedidos1Click(Sender: TObject);
    procedure Fila1Click(Sender: TObject);
    procedure Densidade1Click(Sender: TObject);
    procedure Conversor1Click(Sender: TObject);
    procedure MenuItemProInfoClick(Sender: TObject);
    procedure BtnAtualizaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DetalhedosProdutos1Click(Sender: TObject);
    procedure Pedidos21Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ValidaModelos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;
  FMailSender: TMailSender;

implementation

{$R *.dfm}

uses
  uDmFilaProducao, Utils, uFormDetalheProdutos, uFormPedidos2, uFormValidaModelos;

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
  DMFilaProducao.AtualizaFilaProducao;
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

procedure TFormPrincipal.Timer1Timer(Sender: TObject);
begin
  DMFilaProducao.AtualizaFilaProducao;
end;

procedure TFormPrincipal.ValidaModelos1Click(Sender: TObject);
var
  vFrm: TFormValidaModelos;
begin
  vFrm:= TFormValidaModelos.Create(Self);
  try
    vFrm.ShowModal;
  finally
    vFrm.Free;
  end;
end;

initialization
try
  FMailSender:= TMailSender.Create(Application, 'smtp.rauter.com.br', 587, 'marcelo@rauter.com.br', 'rtq1825', True, 'marcelo@rauter.com.br');
except
end;


end.
