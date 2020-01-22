unit uFormCadastroAviso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls, Data.DB, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uConSqlServer;

type
  TFormCadastroAviso = class(TForm)
    PanelTop: TPanel;
    PanelCentro: TPanel;
    DBEditNomeAviso: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEditID: TDBEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox4: TGroupBox;
    DBEditTitulo: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    DBMemoMensagem: TDBMemo;
    PanelControles: TPanel;
    DBGridRelatorios: TDBGrid;
    Panel1: TPanel;
    BtnAddConsulta: TBitBtn;
    BtnRemoveConsulta: TBitBtn;
    BtnConfiguraConsulta: TBitBtn;
    PanelBot: TPanel;
    GroupBox3: TGroupBox;
    BtnSalvar: TBitBtn;
    BtnCancelar: TBitBtn;
    QryAviso: TFDQuery;
    DsAviso: TDataSource;
    QryAvisoID: TFDAutoIncField;
    QryAvisoNome: TStringField;
    QryAvisoMensagem: TMemoField;
    QryAvisoTitulo: TStringField;
    BtnFechar: TBitBtn;
    QryAvisoConsulta: TFDQuery;
    DsAvisoConsulta: TDataSource;
    QryAvisoConsultaIDAviso: TIntegerField;
    QryAvisoConsultaIDConsulta: TIntegerField;
    QryAvisoConsultaDescricao: TStringField;
    QryAvisoConsultaVisualizacao: TStringField;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAddConsultaClick(Sender: TObject);
    procedure BtnRemoveConsultaClick(Sender: TObject);
    procedure BtnConfiguraConsultaClick(Sender: TObject);
  private
    procedure RemoverConsulta;
    procedure ConfigurarConsultaAtual;
    { Private declarations }
  public
    class procedure AbrirConfigAviso(pIDAviso: Integer);
    procedure AbrirConfig(pIDAviso: Integer);
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  uFormAvisoConsulta, uFormSelecionaConsulta;

{ TuFormCadastrarAvisosAutomaticos }

procedure TFormCadastroAviso.AbrirConfig(pIDAviso: Integer);
begin
  QryAviso.Close;
  QryAviso.ParamByName('ID').AsInteger:= pIDAviso;
  QryAviso.Open;

  QryAvisoConsulta.Close;
  QryAvisoConsulta.ParamByName('IDAviso').AsInteger:= pIDAviso;
  QryAvisoConsulta.Open;

  if QryAviso.IsEmpty then
  begin
    ShowMessage('Aviso cod.: '+IntToStr(pIDAviso)+' não encontrado.');
    Exit;
  end;

  ShowModal;
end;

class procedure TFormCadastroAviso.AbrirConfigAviso(
  pIDAviso: Integer);
var
  FFrm: TFormCadastroAviso;
begin
  FFrm:= TFormCadastroAviso.Create(Application);
  try
    FFrm.AbrirConfig(pIDAviso);
  finally
    FFrm.Free;
  end;
end;

procedure TFormCadastroAviso.BtnConfiguraConsultaClick(Sender: TObject);
begin
  ConfigurarConsultaAtual;
end;

procedure TFormCadastroAviso.BtnAddConsultaClick(Sender: TObject);
var
  FIDConsulta: Integer;
begin
  FIDConsulta:= TFormSelecionaConsulta.SelecionaConsulta;
  if FIDConsulta = 0 then
    Exit;

  QryAvisoConsulta.Append;
  QryAvisoConsultaIDAviso.AsInteger:= QryAvisoID.AsInteger;
  QryAvisoConsultaIDConsulta.AsInteger:= FIDConsulta;
  QryAvisoConsulta.Post;
  ConfigurarConsultaAtual;
end;

procedure TFormCadastroAviso.ConfigurarConsultaAtual;
begin
  TFormAvisoConsulta.AbrirConfigRelatorio(QryAvisoConsultaIDAviso.AsInteger, QryAvisoConsultaIDConsulta.AsInteger);
  QryAvisoConsulta.Refresh;
end;

procedure TFormCadastroAviso.BtnCancelarClick(Sender: TObject);
begin
  QryAviso.Cancel;
end;

procedure TFormCadastroAviso.BtnFecharClick(Sender: TObject);
begin
  if QryAviso.Modified then
    if Application.MessageBox('Existem modificações não salvas, deseja sair sem salvar?', 'Atenção!',  MB_YESNO) = ID_Yes then
    begin
      QryAviso.Cancel;
      Close;
    end;
end;

procedure TFormCadastroAviso.RemoverConsulta;
  procedure RemoveConsultaDepencias(pIDAviso, pIDConsulta: Integer);
  var
    FSql: String;
  begin
    FSql:= 'DELETE FROM cons.AvisoConsultaParametro WHERE IDAviso = '+IntToStr(pIDAviso)
           +' and IDConsulta = '+IntToStr(pIDConsulta);
    ConSqlServer.ExecutaComando(FSql);
  end;

begin
  if not QryAvisoConsulta.IsEmpty then
  begin
    if Application.MessageBox('Você tem certeza que deseja excluir este consulta?', 'Atenção!',  MB_YESNO) = ID_YES  then
    begin
      RemoveConsultaDepencias(QryAvisoConsultaIDAviso.AsInteger, QryAvisoConsultaIDConsulta.AsInteger);
      QryAvisoConsulta.Delete;
    end;
  end;
end;

procedure TFormCadastroAviso.BtnRemoveConsultaClick(Sender: TObject);
begin
  RemoverConsulta;
end;

procedure TFormCadastroAviso.BtnSalvarClick(Sender: TObject);
begin
  QryAviso.Post;
end;

end.
