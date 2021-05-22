unit uFormPermissoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, uConSqlServer,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxCheckBox,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, Vcl.Mask, Vcl.Menus;

type
  TFormPermissoes = class(TForm)
    Panel1: TPanel;
    BtnOK: TBitBtn;
    PanelLeft: TPanel;
    QryUsuarios: TFDQuery;
    DsUsuarios: TDataSource;
    QryUsuariosuserid: TFDAutoIncField;
    QryUsuariosNome: TStringField;
    QryUsuariosSenha: TStringField;
    QryUsuariosadmin: TBooleanField;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    PageControlPermissoes: TPageControl;
    TabSheetConsultas: TTabSheet;
    BtnAtualizarMenus: TBitBtn;
    DsPermissaoConsultas: TDataSource;
    TablePermissaoConsulta: TFDMemTable;
    QryConsulta: TFDQuery;
    QryConsultaID: TFDAutoIncField;
    QryConsultaDescricao: TStringField;
    QryConsultaIDPai: TIntegerField;
    QryConsultaTipo: TIntegerField;
    QryConsultaIDAcao: TIntegerField;
    DsConsulta: TDataSource;
    TablePermissaoConsultaDescricao: TStringField;
    QryConsultanivel: TIntegerField;
    QryConsultaPermitido: TBooleanField;
    cxGridUsuarios: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView4: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    cxGridDBTableView1userid: TcxGridDBColumn;
    cxGridDBTableView1Nome: TcxGridDBColumn;
    cxGridDBTableView1admin: TcxGridDBColumn;
    DBEditID: TDBEdit;
    TablePermissaoConsultaID: TIntegerField;
    cxGridPermissaoConsulta: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridDBTableView3: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView2Descricao: TcxGridDBColumn;
    TablePermissaoConsultaIDPai: TIntegerField;
    TablePermissaoConsultaPermitido: TBooleanField;
    cxGridDBTableView2Permitido: TcxGridDBColumn;
    cxGridDBTableView2IDPai: TcxGridDBColumn;
    TabMenus: TTabSheet;
    TablePermissaoMenus: TFDMemTable;
    DsPermissaoMenus: TDataSource;
    TablePermissaoMenusNomePai: TStringField;
    TablePermissaoMenusDescricao: TStringField;
    cxGrid1: TcxGrid;
    cxGridDBTableViewMenus: TcxGridDBTableView;
    cxGridDBTableView6: TcxGridDBTableView;
    cxGridLevel3: TcxGridLevel;
    cxGridDBTableViewMenusDescricao: TcxGridDBColumn;
    cxGridDBTableViewMenusPermitido: TcxGridDBColumn;
    TablePermissaoMenusMenuName: TStringField;
    cxGridDBTableViewMenusNomePai: TcxGridDBColumn;
    cxGridDBTableViewMenusMenuName: TcxGridDBColumn;
    TablePermissaoMenusPermitido: TBooleanField;
    QryMenus: TFDQuery;
    DsMenus: TDataSource;
    QryMenususerid: TIntegerField;
    QryMenusMenuName: TStringField;
    QryMenusPermitido: TBooleanField;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    BtnAlterarSenha: TButton;
    TablePermissaoMenusDefaultMenu: TBooleanField;
    QryUsuariosDefaultMenu: TMemoField;
    cxGridDBTableViewMenusDefaultMenu: TcxGridDBColumn;
    QryUsuariosProducao: TBooleanField;
    QryUsuariosDesenvolvedor: TBooleanField;
    cxGridDBTableView1Desenvolvedor: TcxGridDBColumn;
    cxGridDBTableView1Producao: TcxGridDBColumn;
    procedure QryUsuariosAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure QryUsuariosBeforePost(DataSet: TDataSet);
    procedure DBEditIDChange(Sender: TObject);
    procedure cxGridDBTableView2PermitidoPropertiesChange(Sender: TObject);
    procedure cxGridDBTableView5PermitidoPropertiesChange(Sender: TObject);
    procedure BtnAlterarSenhaClick(Sender: TObject);
    procedure TablePermissaoMenusCalcFields(DataSet: TDataSet);
    procedure cxGridDBTableViewMenusCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridDBTableViewMenusDefaultMenuPropertiesChange(
      Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FMainMenu: TMainMenu;
    procedure CarregaPermissoesConsulta(AUserID: Integer);
    procedure SetPermissaoConsulta(AIDConsulta: Integer; Permitido: Boolean; pEditField: Boolean);
    procedure CarregaPermissoesMenu(AUserID: Integer);
    procedure SetPermissaoMenu(ANomeMenu: String; Permitido,
      pEditField: Boolean);
    function AlteraSenha: Boolean;
    { Private declarations }
  public
    constructor Create(AOWner: TComponent; AMainMenu: TMainMenu);

  end;

implementation

{$R *.dfm}

uses
  uFormInputSenha;

function RepeatString(AStr: String; ATimes: Integer): String;
var
  I: Integer;
begin
  Result:= '';
  for I := 0 to ATimes-1 do
    Result:= Result+AStr;

end;

procedure TFormPermissoes.BtnAlterarSenhaClick(Sender: TObject);
begin
  if QryUsuarios.State = dsInsert then
    Exit;
  if QryUsuarios.State <> dsEdit then
    QryUsuarios.Edit;

  AlteraSenha;
  QryUsuarios.Post;

end;

procedure TFormPermissoes.BtnOKClick(Sender: TObject);
begin
  Close;
  //  SalvaPermissoesConsulta;
end;

procedure TFormPermissoes.CarregaPermissoesConsulta(AUserID: Integer);
begin
  QryConsulta.Close;
  QryConsulta.ParamByName('USERID').AsInteger:= AUserID;
  QryConsulta.Open;

  TablePermissaoConsulta.EmptyDataSet;
  TablePermissaoConsulta.DisableControls;
  try
    QryConsulta.First;
    while not QryConsulta.Eof do
    begin
      TablePermissaoConsulta.Append;
      TablePermissaoConsultaID.AsInteger:= QryConsultaID.AsInteger;
      TablePermissaoConsultaDescricao.AsString:= RepeatString(' -- ', QryConsultanivel.AsInteger)+ QryConsultaDescricao.AsString;
      TablePermissaoConsultaPermitido.AsBoolean:= QryConsultaPermitido.AsBoolean;
      TablePermissaoConsultaIDPai.AsInteger:= QryConsultaIDPai.AsInteger;
      TablePermissaoConsulta.Post;
      QryConsulta.Next;
    end;
    TablePermissaoConsulta.First;
  finally
    TablePermissaoConsulta.EnableControls;
  end;
end;

procedure TFormPermissoes.CarregaPermissoesMenu(AUserID: Integer);
var
  I: Integer;

  procedure AddMenuItem(AMenuItem: TMenuItem; AParentMenu: TMenuItem; Nivel: Integer);
  var
    I: Integer;
  begin
    TablePermissaoMenus.Append;
    TablePermissaoMenusMenuName.AsString:= AMenuItem.Name;
    TablePermissaoMenusDescricao.AsString:= RepeatString(' -- ', Nivel)+StringReplace(AMenuItem.Caption, '&', '', [rfReplaceAll]);
    if not Assigned(AParentMenu) then
      TablePermissaoMenusNomePai.AsString:= ''
    else
      TablePermissaoMenusNomePai.AsString:= AParentMenu.Name;

    if QryMenus.Locate('MenuName', AMenuItem.Name, [loCaseInsensitive]) then
      TablePermissaoMenusPermitido.AsBoolean:= QryMenusPermitido.AsBoolean
    else
      TablePermissaoMenusPermitido.AsBoolean:= False;

    TablePermissaoMenus.Post;

    for I := 0 to AMenuItem.Count-1 do
      AddMenuItem(AMenuItem.Items[I], AMenuItem, Nivel+1);

  end;

begin
  Assert(Assigned(FMainMenu), 'TFormPermissoes.CarregaPermissoesMenu: FMenu must be assigned.');

  QryMenus.Close;
  QryMenus.ParamByName('userID').AsInteger:= QryUsuariosuserid.AsInteger;
  QryMenus.Open;

  TablePermissaoMenus.DisableControls;
  try
    TablePermissaoMenus.EmptyDataSet;
    for I := 0 to FMainMenu.Items.Count-1 do
      AddMenuItem(FMainMenu.Items[I], nil, 0);

    TablePermissaoMenus.First;
  finally
    TablePermissaoMenus.EnableControls;
  end;

end;

constructor TFormPermissoes.Create(AOWner: TComponent; AMainMenu: TMainMenu);
begin
  FMainMenu:= AMainMenu;
  inherited Create(AOwner);
end;

procedure TFormPermissoes.cxGridDBTableView2PermitidoPropertiesChange(
  Sender: TObject);
var
  FID: Integer;
begin
  if not (TablePermissaoConsulta.State = dsEdit) then
    Exit;

  TablePermissaoConsulta.DisableControls;
  try
    FID:= TablePermissaoConsultaID.AsInteger;
    SetPermissaoConsulta(FID, TCxCheckBox(Sender).EditingValue, True);
    TablePermissaoConsulta.Locate('ID', FID, []);
  finally
    TablePermissaoConsulta.EnableControls;
  end;
end;

procedure TFormPermissoes.cxGridDBTableView5PermitidoPropertiesChange(
  Sender: TObject);
var
  FNome: String;
begin
  if not (TablePermissaoMenus.State = dsEdit) then
    Exit;

  TablePermissaoMenus.DisableControls;
  try
    FNome:= TablePermissaoMenusMenuName.AsString;
    SetPermissaoMenu(FNome, TCxCheckBox(Sender).EditingValue, True);
    TablePermissaoMenus.Locate('MenuName', FNome, []);
  finally
    TablePermissaoMenus.EnableControls;
  end;
end;

procedure TFormPermissoes.cxGridDBTableViewMenusCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin   {
var
  FMenuNameCol, FCurCol: TCxGridDBColumn;
  FMenuName: String;
  FDefault: Boolean;
begin
  FMenuNameCol:= TcxGridDBTableView(Sender).GetColumnByFieldName('MenuName');
  FCurCol:= TcxGridDBColumn(ACellViewInfo.Item);
  if (Assigned(FMenuNameCol)) and (Assigned(FCurCol))= False  then
    Exit;

  FMenuName:= ACellViewInfo.GridRecord.Values[FMenuNameCol.Index];
  if UpperCase(FCurCol.DataBinding.Field.FieldName) = 'DefaultMenu' then
  begin
    FDefault:= ACellViewInfo.GridRecord.Values[TcxGridDBTableView(Sender).GetColumnByFieldName('DefaultMenu').Index];
    QryUsuarios.Edit;
    QryUsuariosDefaultMenu.AsString:= FMenuName;
    QryUsuarios.Post;
  end;    }
end;

procedure TFormPermissoes.cxGridDBTableViewMenusDefaultMenuPropertiesChange(
  Sender: TObject);
var
  FNome: String;
begin
  if TablePermissaoMenus.State <> dsEdit then
    Exit;

  QryUsuarios.Edit;
  if TCxCheckBox(Sender).EditingValue then
    QryUsuariosDefaultMenu.AsString:= TablePermissaoMenusMenuName.AsString
  else
    QryUsuariosDefaultMenu.AsString:= '';

  QryUsuarios.Post;
  TablePermissaoMenus.Post;
end;

procedure TFormPermissoes.DBEditIDChange(Sender: TObject);
begin
  CarregaPermissoesConsulta(QryUsuariosuserid.AsInteger);
  CarregaPermissoesMenu(QryUsuariosuserid.AsInteger);
end;

function BoolToInt(pBool: Boolean): Integer;
begin
  if pBool then
    Result:= 1
  else
    Result:= 0;
end;

procedure TFormPermissoes.SetPermissaoMenu(ANomeMenu: String; Permitido: Boolean; pEditField: Boolean);
var
  FCurID: Integer;
  FPermite: Boolean;
const
  cSql = 'exec perm.SetMenu %d,''%s'',%d';
begin
  if not TablePermissaoMenus.Locate('MenuName', ANomeMenu, []) then
    Exit;

  if pEditField then
  begin
    TablePermissaoMenus.Edit;
    TablePermissaoMenusPermitido.AsBoolean:= Permitido;
    TablePermissaoMenus.Post;
  end;

  ConSqlServer.ExecutaComando(Format(cSql, [QryUsuariosUserID.AsInteger, ANomeMenu, BoolToInt(Permitido)]));

  TablePermissaoMenus.Next;
  while (TablePermissaoMenusNomePai.AsString = ANomeMenu) and (not TablePermissaoMenus.Eof) do
  begin
    if TablePermissaoMenusMenuName.AsString<> ANomeMenu then
      SetPermissaoMenu(TablePermissaoMenusMenuName.AsString, Permitido, True);

    TablePermissaoMenus.Next;
  end;
  if not TablePermissaoMenus.Eof then
    TablePermissaoMenus.Prior;
end;

procedure TFormPermissoes.TablePermissaoMenusCalcFields(DataSet: TDataSet);
begin
  TablePermissaoMenusDefaultMenu.AsBoolean:= (TablePermissaoMenusMenuName.AsString = QryUsuariosDefaultMenu.AsString);
end;

procedure TFormPermissoes.SetPermissaoConsulta(AIDConsulta: Integer; Permitido: Boolean; pEditField: Boolean);
var
  FCurID: Integer;
  FPermite: Boolean;
const
  cSql = 'exec perm.SetConsulta %d,%d,%d';
begin
  if not TablePermissaoConsulta.Locate('ID', AIDConsulta, []) then
    Exit;

  if pEditField then
  begin
    TablePermissaoConsulta.Edit;
    TablePermissaoConsultaPermitido.AsBoolean:= Permitido;
    TablePermissaoConsulta.Post;
  end;

  ConSqlServer.ExecutaComando(Format(cSql, [QryUsuariosUserID.AsInteger, AIDConsulta, BoolToInt(Permitido)]));

  TablePermissaoConsulta.Next;
  while (TablePermissaoConsultaIDPai.AsInteger = AIDConsulta) and (not TablePermissaoConsulta.Eof) do
  begin
    if TablePermissaoConsultaID.AsInteger<> AIDConsulta then
      SetPermissaoConsulta(TablePermissaoConsultaID.AsInteger, Permitido, True);

    TablePermissaoConsulta.Next;
  end;
  if not TablePermissaoConsulta.Eof then
    TablePermissaoConsulta.Prior;
end;

procedure TFormPermissoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFormPermissoes.FormCreate(Sender: TObject);
begin
  TablePermissaoConsulta.CreateDataSet;
  TablePermissaoMenus.CreateDataSet;
  QryUsuarios.Open;
  PageControlPermissoes.ActivePage:= TabSheetConsultas;
end;

procedure TFormPermissoes.QryUsuariosAfterInsert(DataSet: TDataSet);
begin
  QryUsuariosadmin.AsBoolean:= False;
end;

function TFormPermissoes.AlteraSenha: Boolean;
var
  FMD5NovaSenha: String;
begin
 FMD5NovaSenha:= TFormInputSenha.RetornaMD5Senha;

 Result:= FMD5NovaSenha <> '';

 if Result then
   QryUsuariosSenha.AsString:= FMD5NovaSenha;
end;

procedure TFormPermissoes.QryUsuariosBeforePost(DataSet: TDataSet);
begin
  if QryUsuariosNome.AsString = '' then
  begin
    ShowMessage('Usuário inválido.');
    Abort;
  end;
  if Trim(QryUsuariosSenha.AsString) = '' then
    if not AlteraSenha then
    begin
      ShowMessage('Senha inválida!');
      Abort;
    end;
{  if QryUsuarios.State = dsEdit then
    if QryUsuariosNome.OldValue <> QryUsuariosNome.NewValue then
      if Application.MessageBox('Nome do usuário foi modificado! O usuário em questão pode perder o acesso. Continuar com esta modificação?', 'Atenção', MB_YESNO) = ID_NO then
        Abort;      }

end;

end.
