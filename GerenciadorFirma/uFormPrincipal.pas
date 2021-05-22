unit uFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
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
  dxdbtree, uConSqlServer, uConsultaPersonalizada, cxSplitter, ChromeTabs,
  ChromeTabsClasses, ChromeTabsTypes, uGerenciadorConfig, uDmGeradorConsultas, uFormLogistica,
  Form.ScheduledActivities, Form.PesquisaAviso;

type
  TTabPanel = class(TPanel)
  private
  public
    Form: TForm;
    Tab: TChromeTab;
    OwnsForm: Boolean;
    FFormCarregando: Boolean;
    FFormFechando: Boolean;
    FTabFechando: Boolean;
    FID: Integer;

    constructor Create(AParent: TWinControl; pTab: TChromeTab; pForm: TForm; pOwnsForm: Boolean = True); overload;
    destructor Destroy; override;
    procedure FreeAndDetachForm;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RemoveTab;
  end;

type
  TFormPrincipal = class(TForm)
    MainMenu: TMainMenu;
    Pedidos1: TMenuItem;
    Fila1: TMenuItem;
    Densidade1: TMenuItem;
    Conversor1: TMenuItem;
    MenuItemProInfo: TMenuItem;
    PanelTabs: TPanel;
    DetalhedosProdutos1: TMenuItem;
    Utilidades1: TMenuItem;
    Extras1: TMenuItem;
    ValidaModelos1: TMenuItem;
    QryConsultas: TFDQuery;
    QryConsultasname: TWideStringField;
    ExecutarSql1: TMenuItem;
    CriarConsulta1: TMenuItem;
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
    Excluir1: TMenuItem;
    ChromeTabs1: TChromeTabs;
    TreeViewMenu: TdxDBTreeView;
    PanelMain: TPanel;
    cxSplitter1: TcxSplitter;
    DadosGruposdeProdutos1: TMenuItem;
    Feriados1: TMenuItem;
    MenuCicloVendas: TMenuItem;
    AtualizaTodasasListasdePreo1: TMenuItem;
    ControleLogistica1: TMenuItem;
    Atividades1: TMenuItem;
    CadastrodeAtividades1: TMenuItem;
    Agendamentos1: TMenuItem;
    EmailEmbalagens1: TMenuItem;
    Sistema1: TMenuItem;
    Usuriosepermisses1: TMenuItem;
    Configuraes1: TMenuItem;
    QryPermissaoMenu: TFDQuery;
    QryPermissaoMenuuserid: TIntegerField;
    QryPermissaoMenuMenuName: TStringField;
    QryPermissaoMenuPermitido: TBooleanField;
    QryUser: TFDQuery;
    QryUseruserid: TFDAutoIncField;
    QryUserNome: TStringField;
    QryUserSenha: TStringField;
    QryUseradmin: TBooleanField;
    MenuLogin: TMenuItem;
    trocardeusurio1: TMenuItem;
    Sair1: TMenuItem;
    QryUserDefaultMenu: TMemoField;
    Fretes1: TMenuItem;
    ConfiguraCidadesdaNegociaodeFretes1: TMenuItem;
    CalculadoradeFretes1: TMenuItem;
    ConfernciadosFretesdosMovimentos1: TMenuItem;
    N2: TMenuItem;
    AtualizarDadosNegociaes1: TMenuItem;
    QryUserProducao: TBooleanField;
    QryUserDesenvolvedor: TBooleanField;
    StatusBar1: TStatusBar;
    Compras1: TMenuItem;
    ComprasporGrupo1: TMenuItem;
    ComprasAgendadas1: TMenuItem;
    procedure Pedidos1Click(Sender: TObject);
    procedure Fila1Click(Sender: TObject);
    procedure Densidade1Click(Sender: TObject);
    procedure Conversor1Click(Sender: TObject);
    procedure MenuItemProInfoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DetalhedosProdutos1Click(Sender: TObject);
    procedure ValidaModelos1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExecutarSql1Click(Sender: TObject);
    procedure CriarConsulta1Click(Sender: TObject);
    procedure NovoGrupo1Click(Sender: TObject);
    procedure NovaConsulta1Click(Sender: TObject);
    procedure EditarConsulta1Click(Sender: TObject);
    procedure AbrirConsulta1Click(Sender: TObject);
    procedure TreeViewMenuDblClick(Sender: TObject);
    procedure PopupMenuTreeViewPopup(Sender: TObject);
    procedure TreeViewMenuChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewMenuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Excluir1Click(Sender: TObject);
    procedure ChromeTabs1TabDragDrop(Sender: TObject; X, Y: Integer;
      DragTabObject: IDragTabObject; Cancelled: Boolean;
      var TabDropOptions: TTabDropOptions);
    procedure ChromeTabs1NeedDragImageControl(Sender: TObject; ATab: TChromeTab;
      var DragControl: TWinControl);
    procedure ChromeTabs1ActiveTabChanged(Sender: TObject; ATab: TChromeTab);
    procedure ChromeTabs1ButtonAddClick(Sender: TObject; var Handled: Boolean);
    procedure ChromeTabs1ButtonCloseTabClick(Sender: TObject; ATab: TChromeTab;
      var Close: Boolean);
    procedure ChromeTabs1TabDragStart(Sender: TObject; ATab: TChromeTab;
      var Allow: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ChromeTabs1StateChange(Sender: TObject; PreviousState,
      CurrentState: TChromeTabStates);
    procedure DadosGruposdeProdutos1Click(Sender: TObject);
    procedure Feriados1Click(Sender: TObject);
    procedure MenuCicloVendasClick(Sender: TObject);
    procedure AtualizaTodasasListasdePreo1Click(Sender: TObject);
    procedure ControleLogistica1Click(Sender: TObject);
    procedure CadastrodeAtividades1Click(Sender: TObject);
    procedure Agendamentos1Click(Sender: TObject);
    procedure EmailEmbalagens1Click(Sender: TObject);
    procedure Usuriosepermisses1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure trocardeusurio1Click(Sender: TObject);
    procedure ConfiguraCidadesdaNegociaodeFretes1Click(Sender: TObject);
    procedure CalculadoradeFretes1Click(Sender: TObject);
    procedure ConfernciadosFretesdosMovimentos1Click(Sender: TObject);
    procedure ClculodosFretesdosMovimentos1Click(Sender: TObject);
    procedure AtualizarDadosNegociaes1Click(Sender: TObject);
    procedure ComprasporGrupo1Click(Sender: TObject);
    procedure ComprasAgendadas1Click(Sender: TObject);
    procedure TreeViewMenuDragDropTreeNode(Destination, Source: TTreeNode;
      var Accept: Boolean);
  private
    FDmGeradorConsultas: TDmGeradorConsultas;
    FIDNodeSelecionado: Integer;
    FCreatingWithTab: Boolean;
    procedure CarregaConsultas;
    procedure OnConsultaClick(Sender: TObject);
    function ObterKeyValueSelecionado(pTreeView: TdxDBTreeView): Variant;
    function SelecionaNodeNoMouse: Boolean;
    procedure AtualizaTabAtiva(pTab: TChromeTab);
    function BuscaTabPorForm(pForm: TForm): TChromeTab;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MoverTab(DragTabObject: IDragTabObject);
    procedure EmbedFormEmTab(pForm: TForm; pTab: TChromeTab; pTabOwnsForm: Boolean = True);
    procedure RemoveTabPanelInterno(pTabPanel: TTabPanel);
    procedure RemoveTab(pTab: TChromeTab);
    function ObtemDescricaoConsulta(pIDConsulta: Integer): String;
    procedure AoEditarConsulta(Sender: TObject);
    procedure CarregaMenusPermissoes(AUserID: Integer);
    function IsAdmin: Boolean;
    procedure CloseAllTabs;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; ACreatingWithTab: Boolean); overload;
    constructor CreateWithTab(pTab: TChromeTab);
    procedure AbrirFormEmNovaAba(pForm: TForm; pTabOwnsForm: Boolean = True);
  end;

var
  FormPrincipal: TFormPrincipal;
  FMailSender: TMailSender;

implementation

{$R *.dfm}

uses
  Utils, uFormDetalheProdutos, uFormValidaModelos, uFormExecSql,
  uFormRelatoriosPersonalizados, uFormSubGrupoExtras, uFormFeriados, uPython, uFormCiclosVenda,
  uDmGravaLista, uFormEmailEmbalagens, uFormPermissoes, uFormLogin, uFrmAjustaNeg,
  uFrmCalculadoraDeFretes, uFormCompraProdutos, uFormComprasAgendadas;

function TFormPrincipal.IsAdmin: Boolean;
begin
  Result:= QryUseradmin.AsBoolean;
end;

procedure TFormPrincipal.CarregaMenusPermissoes(AUserID: Integer);
var
  I: Integer;
  FMenuDefault: TMenuItem;

  function FindMenu(AMenuBase: TMenuItem; AMenuName: String): TMenuItem;
  var
    I: Integer;
  begin
    Result:= nil;
    if UpperCase(AMenuBase.Name) = UpperCase(AMenuName) then
    begin
      Result:= AMenuBase;
      Exit;
    end;
    for I := 0 to AMenuBase.Count-1 do
    begin
      Result:= FindMenu(AMenuBase.Items[I], AMenuName);
      if Assigned(Result) then
        Exit;
    end;

  end;

  procedure SetMenuVisible(AMenuItem: TMenuItem; AIsAdmin: Boolean);
  var
    I: Integer;
  begin
    if (AIsAdmin) then
      AMenuItem.Visible:= True
    else if QryPermissaoMenu.Locate('MenuName', AMenuItem.Name, []) then
      AMenuItem.Visible:= QryPermissaoMenuPermitido.AsBoolean
    else
       AMenuItem.Visible:= False;

    if AMenuItem.Visible then
      for I := 0 to AMenuItem.Count-1 do
        SetMenuVisible(AMenuItem.Items[I], AIsAdmin);
  end;
begin
  if not FCreatingWithTab then
    CloseAllTabs;

  GerenciadorConfig.GruposUsuario:= [];
  QryUser.Close;
  QryUser.ParamByName('userID').AsInteger:= AUserID;
  QryUser.Open;

  if QryUserProducao.AsBoolean then
    GerenciadorConfig.GruposUsuario:= [puGerenteProducao];

  if QryUserDesenvolvedor.AsBoolean then
    GerenciadorConfig.GruposUsuario:= [puDesenvolvedor];

  QryPermissaoMenu.Close;
  QryPermissaoMenu.ParamByName('userID').AsInteger:= AUserID;
  QryPermissaoMenu.Open;

  QryMenu.Close;
  QryMenu.ParamByName('userID').AsInteger:= AUserID;
  QryMenu.Open;

  for I := 0 to Menu.Items.Count-1 do
    SetMenuVisible(Menu.Items[I], IsAdmin);

  SetMenuVisible(MenuLogin, True); // Menu login é sempre visível

  for I := 0 to Menu.Items.Count-1 do
  begin
    FMenuDefault:= FindMenu(Menu.Items[I], QryUserDefaultMenu.AsString);
    if Assigned(FMenuDefault) then
      Break;
  end;

  if Assigned(FMenuDefault) and (not FCreatingWithTab) then
    FMenuDefault.Click;

  StatusBar1.SimpleText:= 'Usuário: '+QryUserNome.AsString;
end;

procedure TFormPrincipal.RemoveTab(pTab: TChromeTab);
begin
  pTab.Free;
  if (ChromeTabs1.ActiveTab = nil) then
    if ChromeTabs1.Tabs.Count > 0 then
      AtualizaTabAtiva(ChromeTabs1.Tabs[ChromeTabs1.Tabs.Count-1]);

end;

procedure TFormPrincipal.AbrirConsulta1Click(Sender: TObject);
var
  vForm: TFrmConsultaPersonalizada;
begin
  if (QryMenuIDAcao.AsInteger = 0) or (QryMenuTipo.AsInteger <> 1) then
    Exit;

  vForm:= TFrmConsultaPersonalizada.AbreConsultaPersonalizada(QryMenuIDAcao.AsInteger);

  if Assigned(vForm) then
    AbrirFormEmNovaAba(vForm);
end;

procedure TFormPrincipal.ComprasAgendadas1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TformComprasAgendadas.Create(Self), True);
end;

procedure TFormPrincipal.ComprasporGrupo1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormCompraProduto.Create(Self), True);
end;

procedure TFormPrincipal.ConfernciadosFretesdosMovimentos1Click(
  Sender: TObject);
var
  FForm: TFrmConsultaPersonalizada;
begin
  FForm:= TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName('FreteConf');
  if Assigned(FForm) then
    AbrirFormEmNovaAba(FForm);
end;

procedure TFormPrincipal.ConfiguraCidadesdaNegociaodeFretes1Click(
  Sender: TObject);
begin
  AbrirFormEmNovaAba(TFrmAjusteNeg.Create(Self), True);
end;

procedure TFormPrincipal.ControleLogistica1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormLogistica.Create(Self), True);
end;

procedure TFormPrincipal.Conversor1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormConversorLKG.Create(Self), True);
end;

constructor TFormPrincipal.CreateWithTab(pTab: TChromeTab);
var
  FFrm: TForm;
  FOwnsForm: Boolean;
begin
  Create(Application, True);

  if not Assigned(pTab.Data) then
    Exit;

  FFrm:= TTabPanel(pTab.Data).Form;
  FOwnsForm:= TTabPanel(pTab.Data).OwnsForm;
  TTabPanel(pTab.Data).FreeAndDetachForm;

  AbrirFormEmNovaAba(FFrm, FOwnsForm);
end;

procedure TFormPrincipal.CriarConsulta1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormRelatoriosPersonalizados.AbreConsulta(4));
//  TFormRelatoriosPersonalizados.CadastrarNovaConsulta;
end;

procedure TFormPrincipal.DadosGruposdeProdutos1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormSubGrupoExtras.Create(Self), True);
end;

procedure TFormPrincipal.Densidade1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormDensidades.Create(Self), True);
end;

procedure TFormPrincipal.DetalhedosProdutos1Click(Sender: TObject);
var
  FormDetalheProdutos: TFormDetalheProdutos;
begin
  FormDetalheProdutos:= TFormDetalheProdutos.Create(Self);
  try
    FormDetalheProdutos.RefreshProduto;
    AbrirFormEmNovaAba(FormDetalheProdutos, True);
  except
    FormDetalheProdutos.Free;
    raise;
  end;
end;

procedure TFormPrincipal.ExecutarSql1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormExecSql.Create(Self), True);
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  Atividades1.Visible:= (puDesenvolvedor in GerenciadorConfig.GruposUsuario);

{  if Application.MainForm = Self then
    AbrirFormEmNovaAba(TFormPedidos.Create(Self), True);   }
end;

procedure TFormPrincipal.MenuCicloVendasClick(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormCiclosVenda.Create(Self), True);
end;

procedure TFormPrincipal.MenuItemProInfoClick(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormProInfo.Create(Self), True);
//  FormProInfo.Show;
end;

procedure TFormPrincipal.Feriados1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormFeriados.Create(Self), True);
end;

procedure TFormPrincipal.Fila1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormFilaProducao.Create(Self), True);
//  FormFilaProducao.Show;
end;

procedure TFormPrincipal.Pedidos1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormPedidos.Create(Self), true);
//  FormPedidos.Show;
end;

procedure TFormPrincipal.OnConsultaClick(Sender: TObject);
begin
  if not (Sender is TMenuItem) then
    Exit;

  TFrmConsulta.AbreConsulta((Sender as TMenuItem).Caption);
end;

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.MainForm <> Self then
    Action:= caFree;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
{  with TPythonExec.Create do
  try
    Executar;
  finally
    Free;
  end;                  }

  FDmGeradorConsultas:= TDmGeradorConsultas.Create(Self, ConSqlServer);

  FIDNodeSelecionado:= 0;

  if Application.MainForm = Self then
    CarregaConsultas;

  CarregaMenusPermissoes(GerenciadorConfig.UserID);
end;

function TFormPrincipal.ObterKeyValueSelecionado(pTreeView: TdxDBTreeView): Variant;
var
  FNode: TTreeNode;
  FPos: TPoint;
begin
  if not Assigned(pTreeView.PopupMenu) then
    FPos:= pTreeView.ScreenToClient(Mouse.CursorPos)
  else
    FPos:= pTreeView.ScreenToClient(pTreeView.PopupMenu.PopupPoint);

  FNode:= TreeViewMenu.GetNodeAt(FPos.X, FPos.Y);

  if not Assigned(FNode) then
    Result:= null
  else if not (FNode is TdxDBTreeNode) then
    Result:= null
  else
    Result:= TdxDBTreeNode(FNode).KeyFieldValue;
end;

function TFormPrincipal.ObtemDescricaoConsulta(pIDConsulta: Integer): String;
begin
  Result:= ConSqlServer.RetornaValor(Format('SELECT DESCRICAO FROM cons.Consultas where ID = %d', [pIDConsulta]), '');
end;

procedure TFormPrincipal.NovaConsulta1Click(Sender: TObject);
var
  FIDPai: Integer;
  FIDConsulta: Integer;
begin
  if not (puDesenvolvedor in GerenciadorConfig.GruposUsuario) then
    Exit;

  ObterKeyValueSelecionado(TreeViewMenu);

  FIDPai:= VarToIntDef(ObterKeyValueSelecionado(TreeViewMenu), 0);
  FIDConsulta:= TFormRelatoriosPersonalizados.CadastrarNovaConsulta;
  if FIDConsulta > 0 then
  begin
    QryMenu.Append;
    QryMenuDescricao.AsString:= ObtemDescricaoConsulta(FIDConsulta);
    QryMenuTipo.AsInteger:= 1;
    QryMenuIDAcao.AsInteger:= FIDConsulta;
    if FIDPai > 0 then
      QryMenuIDPai.AsInteger:= FIDPai;

    QryMenu.Post;
  end;
end;

procedure TFormPrincipal.NovoGrupo1Click(Sender: TObject);
var
  FNomeGrupo: String;
  FIDPai: Integer;
begin
  if not (puDesenvolvedor in GerenciadorConfig.GruposUsuario) then
    Exit;

  FIDPai:= FIDNodeSelecionado;// VarToIntDef(ObterKeyValueSelecionado(TreeViewMenu), 0);

  FNomeGrupo:= InputBox('Adicionar Grupo', 'Digite o nome do grupo', '');
  if FNomeGrupo = '' then
    Exit;

  QryMenu.Append;
  QryMenuDescricao.AsString:= FNomeGrupo;
  QryMenuTipo.AsInteger:= 0;
  if FIDPai > 0 then
    QryMenuIDPai.AsInteger:= FIDPai;
  QryMenu.Post;
end;

procedure TFormPrincipal.AoEditarConsulta(Sender: TObject);
var
  FrmConsulta: TFormRelatoriosPersonalizados;
  FIDConsulta: Integer;
  FDescricao: String;
begin
  if not (Sender is TFormRelatoriosPersonalizados) then
    Exit;

  FrmConsulta:= (Sender as TFormRelatoriosPersonalizados);

  FIDConsulta:= FrmConsulta.EdtID.Field.Value;

  FDescricao:= FrmConsulta.EdtDescricao.Field.Value;

  if not QryMenu.Locate('IDAcao', FIDConsulta, []) then
    Exit;

  if FDescricao <> QryMenuDescricao.AsString then
  begin
    QryMenu.Edit;
    QryMenuDescricao.AsString:= FDescricao;
    QryMenu.Post;
  end;
end;

procedure TFormPrincipal.EditarConsulta1Click(Sender: TObject);
begin
  if not (puDesenvolvedor in GerenciadorConfig.GruposUsuario) then
    Exit;

  if QryMenuTipo.AsInteger <> 1 then
    Exit;

  TFormRelatoriosPersonalizados.AbreConsulta(QryMenuIDAcao.AsInteger, AoEditarConsulta);
end;

procedure TFormPrincipal.Excluir1Click(Sender: TObject);
var
  FIDConsulta: Integer;
begin
  if not (puDesenvolvedor in GerenciadorConfig.GruposUsuario) then
    Exit;

  if Application.MessageBox('Tem certeza que deseja deletar?', 'Atenção', MB_YESNO) = ID_YES then
  begin
    FIDConsulta:= QryMenuIDAcao.AsInteger;

    if (FIDConsulta > 0) and (QryMenuTipo.AsInteger = 1) then
      FDmGeradorConsultas.DeletaConsulta(FIDConsulta);

    QryMenu.Delete;
  end;
end;

procedure TFormPrincipal.PopupMenuTreeViewPopup(Sender: TObject);
var
  FConsultaSelecionada: Boolean;
  FGrupoSelecionado: Boolean;
begin
  if SelecionaNodeNoMouse then
  begin
    FConsultaSelecionada:= QryMenuTipo.AsInteger = 1;
    FGrupoSelecionado:= QryMenuTipo.AsInteger = 0;
  end
 else
  begin
    FConsultaSelecionada:= False;
    FGrupoSelecionado:= False;
  end;

  AbrirConsulta1.Visible:= FConsultaSelecionada;
  N1.Visible:= FConsultaSelecionada;
  EditarConsulta1.Visible:= FConsultaSelecionada;
  Excluir1.Visible:= FConsultaSelecionada or FGrupoSelecionado;
end;

procedure TFormPrincipal.ValidaModelos1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormValidaModelos.Create(Self), True);
end;

procedure TFormPrincipal.TreeViewMenuChange(Sender: TObject; Node: TTreeNode);
begin
  FIDNodeSelecionado:= QryMenuID.AsInteger;
end;

procedure TFormPrincipal.TreeViewMenuDblClick(Sender: TObject);
begin
  AbrirConsulta1.Click;
end;

procedure TFormPrincipal.TreeViewMenuDragDropTreeNode(Destination,
  Source: TTreeNode; var Accept: Boolean);
begin
  Accept:= True;
end;

procedure TFormPrincipal.TreeViewMenuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Key of
   VK_Delete:
     Excluir1.Click;

   VK_RETURN:
     AbrirConsulta1.Click;
 end;
end;

procedure TFormPrincipal.trocardeusurio1Click(Sender: TObject);
var
  FNewID: Integer;
begin
  FNewID:= TFormLogin.NovoLogin;
  if FNewID = 0 then
    Exit;

  CarregaMenusPermissoes(FNewID);
end;

procedure TFormPrincipal.Usuriosepermisses1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormPermissoes.Create(Self, MainMenu), True);
end;

procedure TFormPrincipal.Sair1Click(Sender: TObject);
begin
  if Application.MessageBox('Confirma fechamento do Gerenciador?', 'Atenção', MB_YESNO) = ID_YES then
    Close;

end;

function TFormPrincipal.SelecionaNodeNoMouse: Boolean;
var
  FNode: TTreeNode;
  FPos: TPoint;
begin
  Result:= False;

  FPos:= TreeViewMenu.ScreenToClient(Mouse.CursorPos);

  FNode:= TreeViewMenu.GetNodeAt(FPos.X, FPos.Y);

  if Assigned(FNode) then
    FNode.Selected:= True;

  if (FNode is TdxDBTreeNode) then
    if Assigned(TreeViewMenu.DataSource) then
      Result:= TreeViewMenu.DataSource.DataSet.Locate(TreeViewMenu.KeyField, TdxDBTreeNode(FNode).KeyFieldValue, []);

  if Result then
    FIDNodeSelecionado:= QryMenuID.AsInteger
  else
    FIDNodeSelecionado:= 0;
end;

procedure TFormPrincipal.CadastrodeAtividades1Click(Sender: TObject);
begin
  TFormPesquisaAviso.AbrirPesquisa;
end;

procedure TFormPrincipal.CalculadoradeFretes1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFrmCalculadoraDeFretes.Create(Self), True);
end;

procedure TFormPrincipal.CarregaConsultas;
begin
{var
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
  end;}
end;

procedure TFormPrincipal.ChromeTabs1ActiveTabChanged(Sender: TObject;
  ATab: TChromeTab);
begin
  AtualizaTabAtiva(ATab);
end;

procedure TFormPrincipal.ChromeTabs1ButtonAddClick(Sender: TObject;
  var Handled: Boolean);
begin
  Handled:= True;
end;

procedure TFormPrincipal.ClculodosFretesdosMovimentos1Click(Sender: TObject);
var
  FForm: TFrmConsultaPersonalizada;
begin
  FForm:= TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName('ConferenciaFreteMovs');
  if Assigned(FForm) then
    AbrirFormEmNovaAba(FForm);
end;

procedure TFormPrincipal.CloseAllTabs;
var
  I: Integer;
  FTab: TChromeTab;
begin
  for I:= 0 to ChromeTabs1.Tabs.Count-1 do
  begin
    FTab:= ChromeTabs1.Tabs[I];
    RemoveTab(FTab);
  end;
end;

procedure TFormPrincipal.ChromeTabs1ButtonCloseTabClick(Sender: TObject;
  ATab: TChromeTab; var Close: Boolean);
begin
  If Assigned(ATab.Data) then
  begin
    TTabPanel(ATab.Data).Free;
    ATab.Data:= nil;
  end;
end;

function TFormPrincipal.BuscaTabPorForm(pForm: TForm): TChromeTab;
var
  I: Integer;
begin
  for I := 0 to ChromeTabs1.Tabs.Count-1 do
  begin
    if Assigned(ChromeTabs1.Tabs[I].Data) then
      if TTabPanel(ChromeTabs1.Tabs[I].Data).Form = pForm then
      begin
        Result:= ChromeTabs1.Tabs[I];
        Exit;
      end;

  end;
  Result:= nil;
end;

function ObterFormParent(pControl: TWinControl): TForm;
var
  FControl: TWinControl;
begin
  Result:= nil;

  FControl:= pControl.Parent;

  while FControl <> nil do
  begin
    if FControl.Parent is TForm then
      Result:= TForm(FControl.Parent);

    FControl:= FControl.Parent;
  end;
end;

procedure TFormPrincipal.EmailEmbalagens1Click(Sender: TObject);
begin
  AbrirFormEmNovaAba(TFormGravaEmbalagens.Create(Self), True);
end;

procedure TFormPrincipal.EmbedFormEmTab(pForm: TForm; pTab: TChromeTab; pTabOwnsForm: Boolean = True);
var
  FPanel: TTabPanel;
begin
  FPanel:= TTabPanel.Create(PanelMain, pTab, pForm, pTabOwnsForm);
  try
    EmbedForm(FPanel, pForm);

    pTab.Caption:= pForm.Caption;
    pTab.Data:= FPanel;

    pTab.Active:= True;
    AtualizaTabAtiva(pTab);
  except
    FPanel.Free;
//    FTab.Free;
    raise;
  end;

end;

procedure TFormPrincipal.RemoveTabPanelInterno(pTabPanel: TTabPanel);
begin
  pTabPanel.FreeAndDetachForm;
end;

procedure TFormPrincipal.AbrirFormEmNovaAba(pForm: TForm; pTabOwnsForm: Boolean = True);
var
  FTab: TChromeTab;
begin
  if not Assigned(pForm) then
    Exit;

  if pForm.Parent is TTabPanel then
    TTabPanel(pForm.Parent).FreeAndDetachForm;

  FTab:= ChromeTabs1.Tabs.Add;
  try
    EmbedFormEmTab(pForm, FTab, pTabOwnsForm);
  except
    FTab.Free;
    raise;
  end;
end;

procedure TFormPrincipal.Agendamentos1Click(Sender: TObject);
begin
  TFormScheduledActivities.OpenScheduledActivities;
end;

procedure TFormPrincipal.AtualizaTabAtiva(pTab: TChromeTab);
var
  FFormExiste: Boolean;
  I: Integer;
  FPanelTab: TPanel;
begin
  if not Assigned(pTab.Data) then
    Exit;

  if not pTab.Active then
    pTab.Active:= True;

  FPanelTab:= TPanel(pTab.Data);

  FFormExiste:= False;
  for I:= 0 to PanelMain.ControlCount-1 do
    if PanelMain.Controls[I] is TPanel then
      if TPanel(PanelMain.Controls[I]) = FPanelTab then
        FFormExiste:= True
      else
        TPanel(PanelMain.Controls[I]).Visible:= False;

  if FFormExiste then
    FPanelTab.Visible:= True;

end;

procedure TFormPrincipal.AtualizarDadosNegociaes1Click(Sender: TObject);
begin
  ConSqlServer.ExecutaComando('exec AtzNegociacao');
end;

procedure TFormPrincipal.AtualizaTodasasListasdePreo1Click(Sender: TObject);
begin
  if MessageDlg('Iniciar leitura da lista de preços remota?', mtConfirmation, [mbYes, mbNO], 0) = mrYes then
    TDmGravaLista.AtualizaTodasListasDePreco;
end;

procedure TFormPrincipal.ChromeTabs1NeedDragImageControl(Sender: TObject;
  ATab: TChromeTab; var DragControl: TWinControl);
begin
  DragControl := PanelMain;
end;

procedure TFormPrincipal.ChromeTabs1StateChange(Sender: TObject; PreviousState,
  CurrentState: TChromeTabStates);
begin
  if stsEndTabDeleted in CurrentState then
    if (ChromeTabs1.Tabs.Count=0) and (Application.MainForm <> Self) then
      Close;
end;

procedure TFormPrincipal.ChromeTabs1TabDragDrop(Sender: TObject; X, Y: Integer;
  DragTabObject: IDragTabObject; Cancelled: Boolean;
  var TabDropOptions: TTabDropOptions);
var
  WinX, WinY: Integer;
  NewForm: TFormPrincipal;
begin
  // Make sure that the drag drop hasn't been cancelled and that
  // we are not dropping on a TChromeTab control
  if (not Cancelled) and
     (DragTabObject.SourceControl <> DragTabObject.DockControl) then
  begin
    if (DragTabObject.DockControl = nil) then
    begin
      // Find the drop position
      WinX := Mouse.CursorPos.X - DragTabObject.DragCursorOffset.X - ((Width - ClientWidth) div 2);
      WinY := Mouse.CursorPos.Y - DragTabObject.DragCursorOffset.Y - (Height - ClientHeight) + ((Width - ClientWidth) div 2);

      if ChromeTabs1.Tabs.Count <= 1 then
      begin
        Self.Left:= WinX;
        Self.Top:= WinY;

        TabDropOptions:= [tdMoveTab];
      end
     else
      begin
        // Create a new form
        FCreatingWithTab:= True;
        try
          NewForm := TFormPrincipal.CreateWithTab(DragTabObject.DragTab);

          // Set the new form position
          NewForm.Position := poDesigned;
          NewForm.Left := WinX;
          NewForm.Top := WinY;

          // Show the form
          NewForm.Show;

          // Remove the original tab
          // TabDropOptions := [tdDeleteDraggedTab];
          TabDropOptions := [];
        finally
          FCreatingWithTab:= False;
        end;
      end;
    end
   else
    begin
      // ChromeTab em outro form!
      TabDropOptions:= [tdDeleteDraggedTab];
      MoverTab(DragTabObject);
    end;
  end
end;

procedure TFormPrincipal.MoverTab(DragTabObject: IDragTabObject);
var
  FTab: TChromeTab;
  FTabPanel: TTabPanel;
  FFormIn, FFormTab: TForm;
  FOwnsForm: Boolean;
begin
  FTab:= DragTabObject.DragTab;

  if not Assigned(FTab.Data) then
    Exit;

  if not (TObject(FTab.Data) is TTabPanel) then
    Exit;

  FTabPanel:= TTabPanel(FTab.Data);

  FFormIn:= ObterFormParent(DragTabObject.DockControl.GetControl);

  FFormTab:= FTabPanel.Form;
  FOwnsForm:= FTabPanel.OwnsForm;

  // Seta a tab para nil para que o TTabPanel não libere a tab;
  FTabPanel.Tab:= nil;
  FTabPanel.FreeAndDetachForm;

  if FFormIn is TFormPrincipal then
    TFormPrincipal(FFormIn).EmbedFormEmTab(FFormTab, DragTabObject.DockControl.InsertDroppedTab, FOwnsForm);

end;

constructor TFormPrincipal.Create(AOwner: TComponent);
begin
  Create(AOwner, False);
end;

constructor TFormPrincipal.Create(AOwner: TComponent;
  ACreatingWithTab: Boolean);
begin
  FCreatingWithTab:= ACreatingWithTab;
  inherited Create(AOwner);
end;

procedure TFormPrincipal.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if Application.MainForm <> Self then
    Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TFormPrincipal.ChromeTabs1TabDragStart(Sender: TObject;
  ATab: TChromeTab; var Allow: Boolean);
begin

end;

{ TTabPanel }

constructor TTabPanel.Create(AParent: TWinControl; pTab: TChromeTab; pForm: TForm; pOwnsForm: Boolean = True);
begin
  inherited Create(AParent);
  FID:= Random(1000);
  FTabFechando:= False;
  FFormFechando:= False;
  FFormCarregando:= True;
  try
    Caption:= '';
    Align:= alClient;
    Visible:= False;
    Parent:= AParent;
    OwnsForm:= pOwnsForm;

    Tab:= pTab;
    Form:= pForm;

{    if OwnsForm then
      InsertComponent(pForm) // Changes the owner of the form to the tab;
    else                   }
     pForm.FreeNotification(Self);
  finally
    FFormCarregando:= False;
  end;
end;

destructor TTabPanel.Destroy;
begin
  FTabFechando:= True;
  Form.RemoveFreeNotification(Self);
  if Form.Parent = Self then
  begin
    Form.Parent:= nil;
    Form.Visible:= False;
  end;

  if OwnsForm then
  begin
    if not (csDestroying in Form.ComponentState) then
      Form.Free;
{    if (csDestroying in Form.ComponentState) then
      Application.InsertComponent(Form) // Este TTabPanel não pode ser o owner do Form ou ele vai ser destruído duas vezes causando AV
    else
      Form.Free;}
  end;

  inherited;
end;

procedure TTabPanel.FreeAndDetachForm;
begin
  Form.RemoveFreeNotification(Self);
  Form.Parent:= nil;
  OwnsForm:= False;
  RemoveTab;

  // Remove este TTAbPanel como owner do Form;
  if Form.Owner = Self then
    Application.InsertComponent(Form);

  Destroy;
end;

procedure TTabPanel.RemoveTab;
var
  FFrm: TForm;
begin
  if not Assigned(Tab) then
    Exit;

  FFrm:= ObterFormParent(Self);
  if FFrm is TFormPrincipal then
  begin
    TFormPrincipal(FFrm).RemoveTab(Tab);
  end;
end;

procedure TTabPanel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (AComponent = Form) and (FFormCarregando=False) then
  begin
    if FFormFechando then Exit;

    FFormFechando:= True;

    if Application.Terminated then
      Exit;

    if not FTabFechando then
    begin
      RemoveTab;
      Free;
    end;
  end;
end;

initialization
try
  FMailSender:= TMailSender.Create(Application, 'smtp.rauter.com.br', 587, 'marcelo@rauter.com.br', 'rtq1825', True, 'marcelo@rauter.com.br');
except
end;


end.
