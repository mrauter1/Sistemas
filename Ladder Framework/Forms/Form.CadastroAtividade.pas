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
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uConSqlServer, Ladder.Activity.Classes,
  Ladder.ORM.Dao, Ladder.Activity.Classes.Dao, Ladder.ORM.DataSetBinding;

type
  TFormCadastroAtividade = class(TForm)
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
    DsAtividade: TDataSource;
    BtnFechar: TBitBtn;
    DsProcessos: TDataSource;
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
    TblProcessos: TFDMemTable;
    TblProcessosID: TIntegerField;
    TblProcessosIDActivity: TIntegerField;
    TblProcessosName: TMemoField;
    TblProcessosDescription: TMemoField;
    TblProcessosClassName: TMemoField;
    TblProcessosExecutorClass: TMemoField;
    TblActivity: TFDMemTable;
    TblActivityIDActivity: TIntegerField;
    TblActivityName: TMemoField;
    TblActivityDescription: TMemoField;
    TblActivityClassName: TMemoField;
    TblActivityExecutorClass: TMemoField;
    TblActivityID: TIntegerField;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAddProcessoClick(Sender: TObject);
    procedure BtnRemoveProcessoClick(Sender: TObject);
    procedure BtnConfiguraProcessoClick(Sender: TObject);
    procedure FieldGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FieldSetText(Sender: TField; const Text: string);
  private
    FActivity: TActivity;
    FActivityDao: IDaoGeneric<TActivity>;
    FActivityBinder: TDataSetBinder;
    FProcessoBinder: TDataSetBinder;
    procedure RemoverProcesso;
    procedure ConfigurarConsultaAtual;
    function GetProcessoSelecionado: TProcessoBase;
    function ProcessoDao: IDaoBase;
    { Private declarations }
  public
    constructor Create(AOWner: TComponent); override;
    class procedure AbrirConfigAviso(pIDAviso: Integer);
    procedure AbrirConfig(pIDAviso: Integer);
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  Form.CadastroProcessoConsulta, Form.SelecionaConsulta;

{ TuFormCadastrarAvisosAutomaticos }

procedure TFormCadastroAtividade.AbrirConfig(pIDAviso: Integer);
begin
  FActivity:= FActivityDao.SelectKey(pIDAviso);

  if not Assigned(FActivity) then
  begin
    ShowMessage('Aviso código '+IntToStr(pIDAviso)+' não encontrado.');
    Exit;
  end;

  FActivityBinder.PullFromObject(FActivity);
  FProcessoBinder.Pull<TProcessoBase>(FActivity.Processos);

  ShowModal;
end;

class procedure TFormCadastroAtividade.AbrirConfigAviso(
  pIDAviso: Integer);
var
  FFrm: TFormCadastroAtividade;
begin
  FFrm:= TFormCadastroAtividade.Create(Application);
  try
    FFrm.AbrirConfig(pIDAviso);
  finally
    FFrm.Free;
  end;
end;

procedure TFormCadastroAtividade.BtnConfiguraProcessoClick(Sender: TObject);
begin
  ConfigurarConsultaAtual;
end;

procedure TFormCadastroAtividade.BtnAddProcessoClick(Sender: TObject);
var
  FIDConsulta: Integer;
  FProcesso: TProcessoBase;
begin
  FProcesso:= TFormCadastroProcessoConsulta._NewProcess;

  if Assigned(FProcesso) then
  begin
    FActivity.Processos.Add(FProcesso);
    FProcessoBinder.Pull<TProcessoBase>(FActivity.Processos);
  end;
end;

function TFormCadastroAtividade.GetProcessoSelecionado: TProcessoBase;
var
  FProcesso: TProcessoBase;
begin
  Result:= nil;
  for FProcesso in FActivity.Processos do
    if FProcesso.ID = TblProcessosID.AsInteger then
    begin
      Result:= FProcesso;
      break;
    end;
end;

procedure TFormCadastroAtividade.ConfigurarConsultaAtual;
var
  FProcesso: TProcessoBase;
begin
  FProcesso:= GetProcessoSelecionado;
  if Assigned(FProcesso) then
    TFormCadastroProcessoConsulta._EditProcess(FProcesso);

  FProcessoBinder.Pull<TProcessoBase>(FActivity.Processos);
//  TFormCadastroProcesso.AbrirConfigRelatorio(QryProcessosIDAviso.AsInteger, QryProcessosIDConsulta.AsInteger);
//  QryProcessos.Refresh;
end;

function TFormCadastroAtividade.ProcessoDao: IDaoBase;
begin
  Result:= FActivityDao.ChildDaoByPropName('Processos');
end;

constructor TFormCadastroAtividade.Create(AOWner: TComponent);
begin
  inherited;
  FActivityDao:= TActivityDao<TActivity>.Create;
  FActivityBinder:= TDataSetBinder.Create(TblActivity, FActivityDao.ModeloBD);
  FProcessoBinder:= TDataSetBinder.Create(TblProcessos, ProcessoDao.ModeloBD);
  TblProcessos.Active:= True;
  DataSetMemoFieldsAsText(TblActivity);
  DataSetMemoFieldsAsText(TblProcessos);
end;

procedure TFormCadastroAtividade.FieldGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text:= Sender.AsString;
end;

procedure TFormCadastroAtividade.FieldSetText(Sender: TField;
  const Text: string);
begin
  Sender.AsString:= Text;
end;

procedure TFormCadastroAtividade.BtnFecharClick(Sender: TObject);
begin
  if TblActivity.Modified then
    if Application.MessageBox('Existem modificações não salvas, deseja sair sem salvar?', 'Atenção!',  MB_YESNO) = ID_Yes then
      Close;

end;

procedure TFormCadastroAtividade.RemoverProcesso;
var
  FProcesso: TProcessoBase;
begin
  if not TblProcessos.IsEmpty then
  begin
    if Application.MessageBox('Você tem certeza que deseja excluir este consulta?', 'Atenção!',  MB_YESNO) = ID_YES  then
    begin
      FProcesso:= GetProcessoSelecionado;

      if Assigned(FProcesso) then
      begin
        ProcessoDao.Delete(FProcesso, FActivity);
        FProcessoBinder.Pull<TProcessoBase>(FActivity.Processos);
      end;
    end;
  end;
end;

procedure TFormCadastroAtividade.BtnRemoveProcessoClick(Sender: TObject);
begin
  RemoverProcesso;
  FActivityBinder.PushToObject(FActivity);
end;

procedure TFormCadastroAtividade.BtnSalvarClick(Sender: TObject);
begin
  if TblActivity.State in ([dsEdit, dsInsert])  then
    TblActivity.Post;

  FActivityBinder.PushToObject(FActivity);
  FActivityDao.Save(FActivity);
end;

end.
