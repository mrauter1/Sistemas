unit From.CadastroProcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uConSqlServer, cxDBLookupComboBox, Ladder.ServiceLocator;

type
  TFormCadastroProcesso = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBoxInputs: TGroupBox;
    cxGridParametros: TcxGrid;
    cxGridParametrosDBTableView1: TcxGridDBTableView;
    cxGridParametrosLevel1: TcxGridLevel;
    BtnOK: TBitBtn;
    Label2: TLabel;
    DBEditIDConsulta: TDBEdit;
    DsAvisoConsulta: TDataSource;
    QryAvisoConsulta: TFDQuery;
    QryAvisoConsultaIDAviso: TIntegerField;
    QryAvisoConsultaIDConsulta: TIntegerField;
    QryAvisoConsultaTipoVisualizacao: TIntegerField;
    QryInputs: TFDQuery;
    DsInputs: TDataSource;
    QryAvisoConsultaTitulo: TStringField;
    QryInputsIDAviso: TIntegerField;
    QryInputsIDConsulta: TIntegerField;
    QryInputsIDParametro: TIntegerField;
    QryInputsValor: TMemoField;
    cxGridParametrosDBTableView1IDParametro: TcxGridDBColumn;
    cxGridParametrosDBTableView1Valor: TcxGridDBColumn;
    cxGridParametrosDBTableView1Nome: TcxGridDBColumn;
    GroupBox1: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    DBEditNomeProcesso: TDBEdit;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    Label1: TLabel;
    DBTipoProcesso: TDBComboBox;
    QryOutputs: TFDQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    MemoField1: TMemoField;
    DsOutputs: TDataSource;
    procedure BtnSelecionarRelatorioClick(Sender: TObject);
    procedure DBEditIDConsultaChange(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetNomeConsulta(pIDConsulta: Integer);
    function PostSeEmEdicao(pQry: TDataSet): Boolean;
    procedure SetDadosConsultaAtual;
    procedure SetDadosConsultaDefault;
    { Private declarations }
  public
    { Public declarations }
    procedure AbrirConfig(pIDAviso, pIDConsulta: Integer);
    class procedure AbrirConfigRelatorio(pIDAviso, pIDConsulta: Integer); static;
  end;

implementation

{$R *.dfm}

uses
  Form.SelecionaConsulta, GerenciadorUtils;

procedure TFormCadastroProcesso.AbrirConfig(pIDAviso, pIDConsulta: Integer);
begin
  QryAvisoConsulta.Close;
  QryAvisoConsulta.ParamByName('IDAviso').AsInteger:= pIDAviso;
  QryAvisoConsulta.ParamByName('IDConsulta').AsInteger:= pIDConsulta;
  QryAvisoConsulta.Open;

  QryParametros.Close;
  QryParametros.ParamByName('IDAviso').AsInteger:= pIDAviso;
  QryParametros.ParamByName('IDConsulta').AsInteger:= pIDConsulta;
  QryParametros.Open;

  if QryAvisoConsulta.IsEmpty then
  begin
    ShowMessage('Consulta cod.: '+IntToStr(pIDConsulta)+' não encontrada.');
    Exit;
  end;

  QryAvisoConsulta.Edit;

  ShowModal;
end;

class procedure TFormCadastroProcesso.AbrirConfigRelatorio(pIDAviso, pIDConsulta: Integer);
var
  FFrm: TFormAvisoConsulta;
begin
  FFrm:= TFormAvisoConsulta.Create(Application);
  try
    FFrm.AbrirConfig(pIDAviso, pIDConsulta);
  finally
    FFrm.Free;
  end;
end;

procedure TFormCadastroProcesso.BtnOKClick(Sender: TObject);
begin
  PostSeEmEdicao(QryAvisoConsulta);

  Close;
end;

procedure TFormCadastroProcesso.BtnSelecionarRelatorioClick(Sender: TObject);
var
  FIDConsulta: Integer;
begin
  FIDConsulta:= TFormSelecionaConsulta.SelecionaConsulta;
  if FIDConsulta = 0 then
    Exit;

  if not (QryAvisoConsulta.State in [dsEdit, dsInsert]) then
    QryAvisoConsulta.Edit;

  QryAvisoConsultaIDConsulta.AsInteger:= FIDConsulta;
  SetDadosConsultaDefault;
end;

procedure TFormCadastroProcesso.SetNomeConsulta(pIDConsulta: Integer);
const
  cSql = 'with Menu as '+
          '(   '+
          '  select Descricao, IDPai '+
          '  from cons.Menu '+
          '  where Tipo = 1 and IDAcao = %d '+
          '  union all '+
          '  select pai.Descricao, pai.IDPAi '+
          '  from cons.Menu pai '+
          '  inner join Menu m on m.IDPai = pai.ID '+
          ')   '+
          'select * from Menu ';
var
  FDataSet: TDataSet;
  FNome: String;
begin
  FNome:= '';
  FDataSet:= TFrwServiceLocator.Context.DmConnection.RetornaDataSet(Format(cSql, [pIDConsulta]));
  try
    FDataSet.First;
    while not FDataSet.Eof do
    begin
      if FNome = '' then
        FNome:= FDataSet.FieldByName('Descricao').AsString
      else
        FNome:= FDataSet.FieldByName('Descricao').AsString+' -> '+FNome;

      FDataSet.Next;
    end;
  finally
    FDataSet.Free;
  end;

//  LblConsulta.Caption:= FNome;
end;

procedure TFormCadastroProcesso.DBEditIDConsultaChange(Sender: TObject);
begin
  SetDadosConsultaAtual;
end;

procedure TFormCadastroProcesso.SetDadosConsultaAtual;
begin
  SetNomeConsulta(QryAvisoConsultaIDConsulta.AsInteger);
end;

function TFormCadastroProcesso.PostSeEmEdicao(pQry: TDataSet): Boolean;
begin
  Result:= pQry.State in [dsEdit, dsInsert];

  if Result then
    pQry.Post;
end;

procedure TFormCadastroProcesso.SetDadosConsultaDefault;
const
  cSql = 'SELECT * FROM cons.Consultas where ID = %d';
var
  FDataSet: TDataSet;
  FNome: String;
begin
  FNome:= '';
  FDataSet:= ConSqlServer.RetornaDataSet(Format(cSql, [QryAvisoConsultaIDConsulta.AsInteger]));
  try
    QryAvisoConsultaTitulo.AsString:= FDataSet.FieldByName('Descricao').AsString;
    QryAvisoConsultaTipoVisualizacao.AsInteger:= FDataSet.FieldByName('VisualizacaoPadrao').AsInteger;
  finally
    FDataSet.Free;
  end;
end;

procedure TFormCadastroProcesso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PostSeEmEdicao(QryParametros);
  PostSeEmEdicao(QryAvisoConsulta);
end;

procedure TFormCadastroProcesso.FormCreate(Sender: TObject);
begin
  //LblConsulta.Caption:= '';
  FazLookupCxGrid(cxGridParametrosDBTableView1Nome, 'SELECT ID, DESCRICAO FROM cons.Parametros');
end;

end.
