unit Form.CadastroAtividade;

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
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uConSqlServer, Ladder.Activity.Classes;

type
  TFormCadastroAviso = class(TForm)
    PanelTop: TPanel;
    PanelCentro: TPanel;
    DBEditNomeAtividade: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEditID: TDBEdit;
    GroupBoxProcessos: TGroupBox;
    PanelControles: TPanel;
    DBGridRelatorios: TDBGrid;
    Panel1: TPanel;
    BtnAddProcesso: TBitBtn;
    BtnRemoveProcesso: TBitBtn;
    BtnConfiguraProcesso: TBitBtn;
    PanelBot: TPanel;
    BtnSalvar: TBitBtn;
    BtnCancelar: TBitBtn;
    QryAtividade: TFDQuery;
    DsAtividade: TDataSource;
    QryAtividadeID: TFDAutoIncField;
    QryAtividadeNome: TStringField;
    QryAtividadeMensagem: TMemoField;
    QryAtividadeTitulo: TStringField;
    BtnFechar: TBitBtn;
    QryProcessos: TFDQuery;
    DsProcessos: TDataSource;
    QryProcessosIDAviso: TIntegerField;
    QryProcessosIDConsulta: TIntegerField;
    QryProcessosDescricao: TStringField;
    QryProcessosVisualizacao: TStringField;
    DBEditDescricao: TDBEdit;
    Label3: TLabel;
    GroupBoxInputs: TGroupBox;
    cxGridParametros: TcxGrid;
    cxGridParametrosDBTableView1: TcxGridDBTableView;
    cxGridParametrosDBTableView1IDParametro: TcxGridDBColumn;
    cxGridParametrosDBTableView1Nome: TcxGridDBColumn;
    cxGridParametrosDBTableView1Valor: TcxGridDBColumn;
    cxGridParametrosLevel1: TcxGridLevel;
    GroupBox1: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    QryInputs: TFDQuery;
    QryInputsIDAviso: TIntegerField;
    QryInputsIDConsulta: TIntegerField;
    QryInputsIDParametro: TIntegerField;
    QryInputsValor: TMemoField;
    DsInputs: TDataSource;
    DsOutputs: TDataSource;
    QryOutputs: TFDQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    MemoField1: TMemoField;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAddProcessoClick(Sender: TObject);
    procedure BtnRemoveProcessoClick(Sender: TObject);
    procedure BtnConfiguraProcessoClick(Sender: TObject);
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
  uFormAvisoConsulta, Form.SelecionaConsulta;

{ TuFormCadastrarAvisosAutomaticos }

procedure TFormCadastroAviso.AbrirConfig(pIDAviso: Integer);
begin
  QryAtividade.Close;
  QryAtividade.ParamByName('ID').AsInteger:= pIDAviso;
  QryAtividade.Open;

  if QryAtividade.IsEmpty then
  begin
    ShowMessage('Aviso cod.: '+IntToStr(pIDAviso)+' não encontrado.');
    Exit;
  end;

  QryProcessos.Close;
  QryProcessos.ParamByName('IDAviso').AsInteger:= pIDAviso;
  QryProcessos.Open;

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

procedure TFormCadastroAviso.BtnConfiguraProcessoClick(Sender: TObject);
begin
  ConfigurarConsultaAtual;
end;

procedure TFormCadastroAviso.BtnAddProcessoClick(Sender: TObject);
var
  FIDConsulta: Integer;
begin
  FIDConsulta:= TFormSelecionaConsulta.SelecionaConsulta;
  if FIDConsulta = 0 then
    Exit;

  QryProcessos.Append;
  QryProcessosIDAviso.AsInteger:= QryAtividadeID.AsInteger;
  QryProcessosIDConsulta.AsInteger:= FIDConsulta;
  QryProcessos.Post;
  ConfigurarConsultaAtual;
end;

procedure TFormCadastroAviso.ConfigurarConsultaAtual;
begin
  TFormAvisoConsulta.AbrirConfigRelatorio(QryProcessosIDAviso.AsInteger, QryProcessosIDConsulta.AsInteger);
  QryProcessos.Refresh;
end;

procedure TFormCadastroAviso.BtnCancelarClick(Sender: TObject);
begin
  QryAtividade.Cancel;
end;

procedure TFormCadastroAviso.BtnFecharClick(Sender: TObject);
begin
  if QryAtividade.Modified then
    if Application.MessageBox('Existem modificações não salvas, deseja sair sem salvar?', 'Atenção!',  MB_YESNO) = ID_Yes then
    begin
      QryAtividade.Cancel;
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
  if not QryProcessos.IsEmpty then
  begin
    if Application.MessageBox('Você tem certeza que deseja excluir este consulta?', 'Atenção!',  MB_YESNO) = ID_YES  then
    begin
      RemoveConsultaDepencias(QryProcessosIDAviso.AsInteger, QryProcessosIDConsulta.AsInteger);
      QryProcessos.Delete;
    end;
  end;
end;

procedure TFormCadastroAviso.BtnRemoveProcessoClick(Sender: TObject);
begin
  RemoverConsulta;
end;

procedure TFormCadastroAviso.BtnSalvarClick(Sender: TObject);
begin
  QryAtividade.Post;
end;

end.
