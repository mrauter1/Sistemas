unit uFormRelatoriosPersonalizados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu,
  dxSkinsCore, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls,
  cxInplaceContainer, cxTLData, cxDBTL, uConSqlServer, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls,
  dxSkinscxPCPainter, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxImageComboBox, cxTextEdit,
  cxColorComboBox, uDmGeradorConsultas;

type
  TFormRelatoriosPersonalizados = class(TForm)
    PanelConsulta: TPanel;
    PanelInfo: TPanel;
    PanelControles: TPanel;
    BtnSalvar: TButton;
    BtnDefineCampos: TButton;
    DsConsultas: TDataSource;
    PageControl: TPageControl;
    TabCadastro: TTabSheet;
    TabParametros: TTabSheet;
    TabCampos: TTabSheet;
    EdtDescricao: TDBEdit;
    LblDescricao: TLabel;
    DBMemo1: TDBMemo;
    Label3: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    Panel2: TPanel;
    EdtID: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditNome: TDBEdit;
    Panel1: TPanel;
    Label4: TLabel;
    DBMemoSql: TDBMemo;
    cxGridParamsDBTableView1: TcxGridDBTableView;
    cxGridParamsLevel1: TcxGridLevel;
    cxGridParams: TcxGrid;
    DsPara: TDataSource;
    DsCampos: TDataSource;
    cxGridParamsDBTableView1Nome: TcxGridDBColumn;
    cxGridParamsDBTableView1Descricao: TcxGridDBColumn;
    cxGridParamsDBTableView1Tipo: TcxGridDBColumn;
    cxGridParamsDBTableView1Sql: TcxGridDBColumn;
    cxGridParamsDBTableView1Ordem: TcxGridDBColumn;
    cxGridParamsDBTableView1Tamanho: TcxGridDBColumn;
    cxGridParamsDBTableView1Obrigatorio: TcxGridDBColumn;
    cxGridParamsDBTableView1ValorPadrao: TcxGridDBColumn;
    cxGridCampos: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView1NomeCampo: TcxGridDBColumn;
    cxGridDBTableView1Descricao: TcxGridDBColumn;
    cxGridDBTableView1TamanhoCampo: TcxGridDBColumn;
    cxGridDBTableView1Visivel: TcxGridDBColumn;
    cxGridDBTableView1Monetario: TcxGridDBColumn;
    cxGridDBTableView1Agrupamento: TcxGridDBColumn;
    cxGridDBTableView1Cor: TcxGridDBColumn;
    QryExec: TFDQuery;
    DsExec: TDataSource;
    cxGridConsulta: TcxGrid;
    cxGridConsultaView: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    BtnCancelar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
  private
    FDm: TDmGeradorConsultas;
    function ConsultaExiste: Boolean;
    procedure VerificaECriaCampos;
    procedure VerificaECriaParametros;
    procedure RefreshConsulta;

    procedure CarregaConsulta(pCodConsulta: Integer);
    procedure NovaConsulta;
    procedure AdicionaParametro(pNome: String; pValorPadrao: Variant;
      pTipo: TTipoParametro; pDescricao, pSql: String; pRefresh: Boolean = False);
    procedure VariantToField(pValue: Variant; pField: TField);
    procedure QryCamposAfterPost(DataSet: TDataSet);
    { Private declarations }
  public
    LiberaAoFechar: Boolean;
    class procedure AbreConsulta(pCodConsulta: Integer);
    class function CadastrarNovaConsulta: Integer;

    property DM: TDmGeradorConsultas read FDM;
  end;

var
  FormRelatoriosPersonalizados: TFormRelatoriosPersonalizados;

implementation

{$R *.dfm}

{ TFormRelatoriosPersonalizados }

class procedure TFormRelatoriosPersonalizados.AbreConsulta(pCodConsulta: Integer);
var
  vFrm: TFormRelatoriosPersonalizados;
begin
  vFrm:= TFormRelatoriosPersonalizados.Create(Application);
  vFrm.CarregaConsulta(pCodConsulta);
  vFrm.Show;
end;

class function TFormRelatoriosPersonalizados.CadastrarNovaConsulta: Integer;
var
  vFrm: TFormRelatoriosPersonalizados;
begin
  Result:= 0;
  vFrm:= TFormRelatoriosPersonalizados.Create(Application);
  try
    vFrm.LiberaAoFechar:= False;

    vFrm.NovaConsulta;
    vFrm.ShowModal;
    Result:= vFrm.DM.QryConsultasID.AsInteger;
  finally
    vFrm.Free;
  end;

end;

procedure TFormRelatoriosPersonalizados.NovaConsulta;
begin
  CarregaConsulta(0);
  FDm.QryConsultas.Insert;
  FDm.QryConsultasTipo.AsInteger:= 0;
end;

procedure TFormRelatoriosPersonalizados.PageControlChange(Sender: TObject);
begin
  if PageControl.ActivePage = TabCampos then
    RefreshConsulta;

end;


function TFormRelatoriosPersonalizados.ConsultaExiste: Boolean;
begin
  Result:= ConSqlServer.RetornaInteiro(Format('SELECT COUNT(*) FROM Cons.Consultas where ID <> %d and Nome = ''%s'' ',
                  [FDm.QryConsultasID.AsInteger, FDm.QryConsultasNome.AsString])) > 0;
end;

procedure TFormRelatoriosPersonalizados.CarregaConsulta(
  pCodConsulta: Integer);
begin
  FDm.AbrirConsulta(pCodConsulta);
end;

procedure TFormRelatoriosPersonalizados.BtnCancelarClick(Sender: TObject);
begin
  if FDm.QryConsultas.State = dsEdit then
    FDm.QryConsultas.Cancel
  else
    Close;

end;

procedure TFormRelatoriosPersonalizados.BtnSalvarClick(Sender: TObject);
begin
  if not (FDm.QryConsultas.State in ([dsEdit, dsInsert])) then
    Exit;

  if ConsultaExiste then
  begin
    ShowMessage('Uma consulta com este nome j� existe no sistema!');
    Exit;
  end;

  FDM.QryConsultas.Post;

  VerificaECriaParametros;

  VerificaECriaCampos;
end;

procedure TFormRelatoriosPersonalizados.VariantToField(pValue: Variant; pField: TField);
begin
  if VarIsNull(pValue) then
    pField.Clear
  else
    pField.Value:= pValue;
end;

procedure TFormRelatoriosPersonalizados.AdicionaParametro(pNome: String; pValorPadrao: Variant;
                  pTipo: TTipoParametro; pDescricao, pSql: String; pRefresh: Boolean = False);
begin
  if FDm.QryParametros.Locate('Nome', pNome, [loCaseInsensitive]) then
  begin
    if not pRefresh then
      Exit
    else
      Fdm.QryParametros.Edit;
  end
 else
   FDm.QryParametros.Insert;

  Fdm.QryParametrosConsulta.AsInteger:= FDm.QryConsultasID.AsInteger;
  FDm.QryParametrosNome.AsString:= pNome;
  VariantToField(pValorPadrao, FDm.QryParametrosValorPadrao);
  FDm.QryParametrosDescricao.AsString:= pDescricao;
  FDm.QryParametrosTipo.AsInteger:= Ord(pTipo);
  FDm.QryParametrosSql.AsString:= pSql;
  FDm.QryParametros.Post;
end;

procedure TFormRelatoriosPersonalizados.VerificaECriaParametros;
begin
  if FDm.QryConsultasTipo.AsInteger <> Ord(tcEvolutivo) then
    Exit;

  AdicionaParametro('geDataIni', null, ptDateTime, 'Data Inicial', '');
  AdicionaParametro('geDataFim', null, ptDateTime, 'Data Final', '');
  AdicionaParametro('geTipoPeriodo', 0, ptComboBox, 'Tipo per�odo',
      'SELECT 0 as Cod, ''Di�rio'' as Desc union SELECT 1 as Cod, ''Mensal'' as Desc ');
  AdicionaParametro('gePeriodo', 7, ptTexto, 'Per�odo', '');
end;

procedure TFormRelatoriosPersonalizados.VerificaECriaCampos;
var
  Field: TField;
begin
  RefreshConsulta;

  for Field in QryExec.Fields do
    FDm.AdicionaNovoCampo(Field, False);
end;

procedure TFormRelatoriosPersonalizados.RefreshConsulta;
begin
  QryExec.Close;
  cxGridConsultaView.BeginUpdate();
  try
    cxGridConsultaView.ClearItems;

    QryExec.Open(FDm.GeraSqlConsulta);
    FDm.SetEstilosCamposQry(QryExec);

    cxGridConsultaView.DataController.CreateAllItems;
  finally
    cxGridConsultaView.EndUpdate;
  end;
end;

procedure TFormRelatoriosPersonalizados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if LiberaAoFechar then
    Action:= caFree;
end;

procedure TFormRelatoriosPersonalizados.QryCamposAfterPost(DataSet: TDataSet);
begin
  RefreshConsulta;
end;

procedure TFormRelatoriosPersonalizados.FormCreate(Sender: TObject);
begin
  LiberaAoFechar:= True;
  FDm:= TDmGeradorConsultas.Create(Self);
  FDm.QryCampos.AfterPost:= QryCamposAfterPost;
  PageControl.ActivePage:= TabCadastro;
end;

end.
