unit Form.PesquisaAviso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, uConSqlServer, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Ladder.ORM.Dao, Ladder.Activity.Classes.Dao, Ladder.Activity.Classes;

type
  TFormPesquisaAviso = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnSelecionar: TButton;
    BtnFechar: TButton;
    BtnRemoverAviso: TButton;
    BtnNovoAviso: TButton;
    cxGridAvisosDBTableView1: TcxGridDBTableView;
    cxGridAvisosLevel1: TcxGridLevel;
    cxGridAvisos: TcxGrid;
    QryAvisos: TFDQuery;
    QryAvisosID: TFDAutoIncField;
    DsAvisos: TDataSource;
    cxGridAvisosDBTableView1ID: TcxGridDBColumn;
    QryAvisosIDActivity: TIntegerField;
    QryAvisosName: TMemoField;
    QryAvisosDescription: TMemoField;
    QryAvisosClassName: TMemoField;
    QryAvisosExecutorClass: TMemoField;
    cxGridAvisosDBTableView1IDActivity: TcxGridDBColumn;
    cxGridAvisosDBTableView1Name: TcxGridDBColumn;
    cxGridAvisosDBTableView1Description: TcxGridDBColumn;
    procedure BtnRemoverAvisoClick(Sender: TObject);
    procedure BtnNovoAvisoClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
  private
    FActivityDao: IDaoGeneric<TActivity>;
    procedure RemoveAviso;
    procedure AbrirConfigAviso;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    class procedure AbrirPesquisa;
  end;

var
  FormPesquisaAviso: TFormPesquisaAviso;

implementation

{$R *.dfm}

uses
  Form.CadastroAtividade;

procedure TFormPesquisaAviso.AbrirConfigAviso;
begin
  TFormCadastroAtividade.AbrirConfigAviso(QryAvisosID.AsInteger);
  QryAvisos.Refresh;
end;

class procedure TFormPesquisaAviso.AbrirPesquisa;
var
  FFrm: TFormPesquisaAviso;
begin
  FFrm:= TFormPesquisaAviso.Create(Application);
  try
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

procedure TFormPesquisaAviso.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormPesquisaAviso.BtnNovoAvisoClick(Sender: TObject);
var
  fInput: String;
begin
  fInput:= InputBox('Avisos', 'Digite o nome do novo aviso:', '');
  if fInput = '' then Exit;

  QryAvisos.Append;
  QryAvisosName.AsString:= fInput;
  QryAvisos.Post;
  AbrirConfigAviso;
end;

procedure TFormPesquisaAviso.BtnRemoverAvisoClick(Sender: TObject);
begin
  RemoveAviso;
end;

procedure TFormPesquisaAviso.BtnSelecionarClick(Sender: TObject);
begin
  AbrirConfigAviso;
end;

constructor TFormPesquisaAviso.Create(AOwner: TComponent);
begin
  inherited;
  FActivityDao:= TActivityDao<TActivity>.Create;
end;

procedure TFormPesquisaAviso.FormCreate(Sender: TObject);
begin
  QryAvisos.Open;
end;

procedure TFormPesquisaAviso.RemoveAviso;

  procedure RemoveAvisoDepencias(pIDAviso: Integer);
  var
    FSql: String;
    FActivity: TActivity;
  begin
    FActivity:= FActivityDao.SelectKey(pIDAviso);
    FActivityDao.Delete(FActivity);
{    FSql:= 'DELETE FROM cons.AvisoRelatorio WHERE IDAviso = '+IntToStr(+pIDAviso)+'; '+
           'DELETE FROM cons.AvisoRelatorioParametro WHERE IDAviso = '+IntToStr(pIDAviso);
    ConSqlServer.ExecutaComando(FSql);}
  end;

begin
  if not QryAvisos.IsEmpty then
  begin
    if Application.MessageBox('Você tem certeza que deseja excluir este aviso?', 'Atenção!',  MB_YESNO) = ID_YES  then
    begin
      RemoveAvisoDepencias(QryAvisosID.AsInteger);
      QryAvisos.Refresh;
    end;
  end;
end;

end.
