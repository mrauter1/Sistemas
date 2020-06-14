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
  Ladder.ORM.Dao, Ladder.Activity.Classes.Dao, Ladder.Activity.Classes,
  Ladder.ORM.ObjectDataSet;

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
    DsAvisos: TDataSource;
    cxGridAvisosDBTableView1ID: TcxGridDBColumn;
    cxGridAvisosDBTableView1IDActivity: TcxGridDBColumn;
    cxGridAvisosDBTableView1Name: TcxGridDBColumn;
    cxGridAvisosDBTableView1Description: TcxGridDBColumn;
    TbAvisos: TFDMemTable;
    TbAvisosID: TIntegerField;
    TbAvisosIDActivity: TIntegerField;
    TbAvisosName: TMemoField;
    TbAvisosDescription: TMemoField;
    TbAvisosClassName: TMemoField;
    TbAvisosExecutorClass: TMemoField;
    procedure BtnRemoverAvisoClick(Sender: TObject);
    procedure BtnNovoAvisoClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
  private
    FActivityDao: IDaoGeneric<TActivity>;
    FActivityDataSet: TObjectDataSet;
    procedure RemoveAviso;
    procedure AbrirConfigAviso;
    procedure NovoAviso;
    function AtividadeSelecionada: TActivity;
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

function TFormPesquisaAviso.AtividadeSelecionada: TActivity;
begin
  Result:= FActivityDataSet.GetCurrentModel<TActivity>;
end;

procedure TFormPesquisaAviso.AbrirConfigAviso;
begin
  if (AtividadeSelecionada = nil) then
    Exit;

  TFormCadastroAtividade._AbrirConfigAviso(AtividadeSelecionada);
  FActivityDataSet.Synchronize;
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
{  fInput:= InputBox('Avisos', 'Digite o nome do novo aviso:', '');
  if fInput = '' then Exit;    }

  NovoAviso;
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

  FActivityDataSet:= TObjectDataSet.Create(Self, FActivityDao.ModeloBD);
  FActivityDataSet.OwnsObjectList:= True;
  FActivityDataSet.ObjectList:= FActivityDao.SelectWhere('className = ''TActivity''');

  DsAvisos.DataSet:= FActivityDataSet;
end;

procedure TFormPesquisaAviso.NovoAviso;
var
  FAtividade: TActivity;
begin
  FAtividade:= TFormCadastroAtividade._NovaAtividade;
  if not Assigned(FAtividade) then
    Exit;

  FActivityDataSet.AddItem(FAtividade);
  FActivityDataSet.Synchronize;
end;

procedure TFormPesquisaAviso.RemoveAviso;

  procedure RemoveAvisoDepencias(pAtividade: TActivity);
  var
    FSql: String;
  begin
    if pAtividade.ID > 0 then
      FActivityDao.Delete(pAtividade);

    FActivityDataSet.RemoveItem(pAtividade);
    FActivityDataSet.Synchronize;
  end;

begin
  if not FActivityDataSet.IsEmpty then
    if Application.MessageBox('Você tem certeza que deseja excluir este aviso?', 'Atenção!',  MB_YESNO) = ID_YES  then
      RemoveAvisoDepencias(FActivityDataSet.GetCurrentModel<TActivity>);

end;

end.
