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
  Vcl.StdCtrls, Vcl.ExtCtrls, uFormGlobal, uSendMail, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uFrmConsulta, Vcl.ComCtrls, dxtree,
  dxdbtree, uConSqlServer, uConsultaPersonalizada;

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
    Consultas1: TMenuItem;
    QryConsultas: TFDQuery;
    QryConsultasname: TWideStringField;
    ExecutarSql1: TMenuItem;
    CriarConsulta1: TMenuItem;
    TreeViewMenu: TdxDBTreeView;
    QryMenu: TFDQuery;
    QryMenuID: TFDAutoIncField;
    QryMenuIDPai: TIntegerField;
    QryMenuTipo: TIntegerField;
    QryMenuIDAcao: TIntegerField;
    DsMenu: TDataSource;
    PopupMenuTreeView: TPopupMenu;
    NovoGrupo1: TMenuItem;
    NovaConsulta1: TMenuItem;
    EditarConsulta1: TMenuItem;
    QryMenuDescricao: TStringField;
    AbrirConsulta1: TMenuItem;
    N1: TMenuItem;
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
    procedure FormCreate(Sender: TObject);
    procedure ExecutarSql1Click(Sender: TObject);
    procedure CriarConsulta1Click(Sender: TObject);
    procedure NovoGrupo1Click(Sender: TObject);
    procedure NovaConsulta1Click(Sender: TObject);
    procedure EditarConsulta1Click(Sender: TObject);
    procedure AbrirConsulta1Click(Sender: TObject);
    procedure TreeViewMenuDblClick(Sender: TObject);
  private
    procedure CarregaConsultas;
    procedure OnConsultaClick(Sender: TObject);
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
  uDmFilaProducao, Utils, uFormDetalheProdutos, uFormPedidos2, uFormValidaModelos, uFormExecSql,
  uFormRelatoriosPersonalizados;

procedure TFormPrincipal.AbrirConsulta1Click(Sender: TObject);
begin
  if (QryMenuIDAcao.AsInteger = 0) or (QryMenuTipo.AsInteger <> 1) then
    Exit;

  TFrmConsultaPersonalizada.AbreConsultaPersonalizada(QryMenuIDAcao.AsInteger);
end;

procedure TFormPrincipal.BtnAtualizaClick(Sender: TObject);
begin
  DMFilaProducao.AtualizaFilaProducao;
end;

procedure TFormPrincipal.Conversor1Click(Sender: TObject);
begin
  FormConversorLKG.Show;
end;

procedure TFormPrincipal.CriarConsulta1Click(Sender: TObject);
begin
  TFormRelatoriosPersonalizados.AbreConsulta(4);
//  TFormRelatoriosPersonalizados.CadastrarNovaConsulta;
end;

procedure TFormPrincipal.Densidade1Click(Sender: TObject);
begin
  FormDensidades.Show;
end;

procedure TFormPrincipal.DetalhedosProdutos1Click(Sender: TObject);
begin
  FormDetalheProdutos.AbreEFocaProduto('');
end;

procedure TFormPrincipal.EditarConsulta1Click(Sender: TObject);
var
  FIDAcao: Integer;
begin
  if QryMenuTipo.AsInteger = 1 then
    TFormRelatoriosPersonalizados.AbreConsulta(QryMenuIDAcao.AsInteger);
end;

procedure TFormPrincipal.ExecutarSql1Click(Sender: TObject);
begin
  TFormExecSql.AbreForm(Self);
end;

procedure TFormPrincipal.Fila1Click(Sender: TObject);
begin
  FormFilaProducao.Show;
end;

procedure TFormPrincipal.OnConsultaClick(Sender: TObject);
begin
  if not (Sender is TMenuItem) then
    Exit;

  TFrmConsulta.AbreConsulta((Sender as TMenuItem).Caption);
end;

procedure TFormPrincipal.CarregaConsultas;
var
  FMenuItem: TMenuItem;
begin
  QryConsultas.Close;
  QryConsultas.Open;

  Consultas1.Clear;

  QryConsultas.First;
  while not QryConsultas.Eof do
  begin
    FMenuItem:= TMenuItem.Create(Consultas1);
    FMenuItem.Caption:= QryConsultasname.AsString;
    FMenuItem.OnClick:= OnConsultaClick;
    Consultas1.Add(FMenuItem);

    QryConsultas.Next;
  end;


end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  CarregaConsultas;

  if not QryMenu.Active then
    QryMenu.Open;
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

procedure TFormPrincipal.NovaConsulta1Click(Sender: TObject);
var
  FIDConsulta: Integer;

  function ObtemNomeConsulta(pIDConsulta: Integer): String;
  begin
    Result:= ConSqlServer.RetornaValor(Format('SELECT NOME FROM cons.Consultas where ID = %d', [pIDConsulta]), '');
  end;

begin
  FIDConsulta:= TFormRelatoriosPersonalizados.CadastrarNovaConsulta;
  if FIDConsulta > 0 then
  begin
    QryMenu.Append;
    QryMenuDescricao.AsString:= ObtemNomeConsulta(FIDConsulta);
    QryMenuTipo.AsInteger:= 1;
    QryMenuIDAcao.AsInteger:= FIDConsulta;
    QryMenu.Post;
  end;
end;

procedure TFormPrincipal.NovoGrupo1Click(Sender: TObject);
var
  FNomeGrupo: String;
begin
  FNomeGrupo:= InputBox('Adicionar Grupo', 'Digite o nome do grupo', '');
  if FNomeGrupo = '' then
    Exit;

  QryMenu.Append;
  QryMenuDescricao.AsString:= FNomeGrupo;
  QryMenuTipo.AsInteger:= 0;
  QryMenu.Post;
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

procedure TFormPrincipal.TreeViewMenuDblClick(Sender: TObject);
begin
  AbrirConsulta1.Click;
end;

initialization
try
  FMailSender:= TMailSender.Create(Application, 'smtp.rauter.com.br', 587, 'marcelo@rauter.com.br', 'rtq1825', True, 'marcelo@rauter.com.br');
except
end;


end.
