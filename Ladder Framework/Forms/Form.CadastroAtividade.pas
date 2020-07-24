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
  Ladder.ORM.Dao, Ladder.Activity.Classes.Dao,
  Ladder.ORM.ObjectDataSet, Ladder.Activity.Manager;

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
    cxGridParametrosLevel1: TcxGridLevel;
    GroupBox1: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    DsOutputs: TDataSource;
    TbProcessos: TFDMemTable;
    TbProcessosID: TIntegerField;
    TbProcessosIDActivity: TIntegerField;
    TbProcessosName: TMemoField;
    TbProcessosDescription: TMemoField;
    TbProcessosClassName: TMemoField;
    TbProcessosExecutorClass: TMemoField;
    TbActivity: TFDMemTable;
    TbActivityIDActivity: TIntegerField;
    TbActivityName: TMemoField;
    TbActivityDescription: TMemoField;
    TbActivityClassName: TMemoField;
    TbActivityExecutorClass: TMemoField;
    TbActivityID: TIntegerField;
    TBInputs: TFDMemTable;
    DsInputs: TDataSource;
    TBInputsID: TFDAutoIncField;
    TBInputsIDProcesso: TIntegerField;
    TBInputsName: TMemoField;
    TBInputsParameterType: TIntegerField;
    TBInputsExpression: TMemoField;
    TBInputsIDMaster: TIntegerField;
    cxGridParametrosDBTableView1ID: TcxGridDBColumn;
    cxGridParametrosDBTableView1Name: TcxGridDBColumn;
    cxGridParametrosDBTableView1Expression: TcxGridDBColumn;
    TBOutputs: TFDMemTable;
    TBOutputsID: TFDAutoIncField;
    TBOutputsIDProcesso: TIntegerField;
    TBOutputsName: TMemoField;
    TBOutputsParameterType: TIntegerField;
    TBOutputsExpression: TMemoField;
    TBOutputsIDMaster: TIntegerField;
    cxGridDBTableView1ID: TcxGridDBColumn;
    cxGridDBTableView1Name: TcxGridDBColumn;
    cxGridDBTableView1Expression: TcxGridDBColumn;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    TbProcessosExecOrder: TIntegerField;
    BtnMoveUp: TBitBtn;
    BtnMoveDown: TBitBtn;
    BtnExecutar: TBitBtn;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAddProcessoClick(Sender: TObject);
    procedure BtnRemoveProcessoClick(Sender: TObject);
    procedure BtnConfiguraProcessoClick(Sender: TObject);
    procedure FieldGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FieldSetText(Sender: TField; const Text: string);
    procedure BtnMoveUpClick(Sender: TObject);
    procedure BtnMoveDownClick(Sender: TObject);
    procedure BtnExecutarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FActivity: TActivity;
    FActivityDao: IProcessoDao<TActivity>;

    FActivityDataSet: TObjectDataSet;
    FProcessoDataSet: TObjectDataSet;
    FInputDataSet: TObjectDataSet;
    FOutputDataSet: TObjectDataSet;
    procedure RemoverProcesso;
    procedure ConfigurarProcesso;
    function ProcessoSelecionado: TProcessoBase;
    function ProcessoDao: IDaoBase;

    function NovaAtividade: TActivity;
    function Manager: TActivityManager;
    procedure ActivityBeforePost(DataSet: TDataSet);
    { Private declarations }
  public
    constructor Create(AOWner: TComponent); override;
    destructor Destroy; override;
    procedure AbrirConfig(pAtividade: TActivity);

    class procedure _AbrirConfigAviso(pAtividade: TActivity);
    class function _NovaAtividade: TActivity;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  Form.SelecionaConsulta, Ladder.ServiceLocator, Form.NovoProcesso;

{ TuFormCadastrarAvisosAutomaticos }

procedure TFormCadastroAtividade.AbrirConfig(pAtividade: TActivity);
begin
  FActivity:= pAtividade;

  FActivityDataSet.SetObject(FActivity);

  FActivity.ReorderProcesses; // If the processes have no explicit order already, give them based on their Index;
//  FProcessoDataSet.SetObjectList<TProcessoBase>(FActivity.Processos);

  ShowModal;
end;

function TFormCadastroAtividade.NovaAtividade: TActivity;
begin
  FActivity:= TActivity.Create(TFrwServiceLocator.Factory.NewExpressionEvaluator);
  FActivityDataSet.SetObject(FActivity);
//  FProcessoDataSet.SetObjectList<TProcessoBase>(FActivity.Processos);

  ShowModal;
  if FActivity.ID = 0 then
  begin
    FActivity.Free;
    Result:= nil
  end
 else
    Result:= FActivity;
end;

class procedure TFormCadastroAtividade._AbrirConfigAviso(pAtividade: TActivity);
var
  FFrm: TFormCadastroAtividade;
begin
  FFrm:= TFormCadastroAtividade.Create(Application);
  try
    FFrm.AbrirConfig(pAtividade);
  finally
    FFrm.Free;
  end;
end;

class function TFormCadastroAtividade._NovaAtividade: TActivity;
var
  FFrm: TFormCadastroAtividade;
begin
  FFrm:= TFormCadastroAtividade.Create(Application);
  try
    Result:= FFrm.NovaAtividade;
  finally
    FFrm.Free;
  end;
end;

procedure TFormCadastroAtividade.BtnConfiguraProcessoClick(Sender: TObject);
begin
  ConfigurarProcesso;
end;

procedure TFormCadastroAtividade.BtnExecutarClick(Sender: TObject);
begin
  FActivity.Executar;
end;

procedure TFormCadastroAtividade.BtnAddProcessoClick(Sender: TObject);
var
  FIDConsulta: Integer;
  FProcesso: TProcessoBase;
  FExecutor: String;
begin
  FExecutor:= TFormNovoProcesso.SelecionaTipoProcesso;
  if FExecutor = '' then
    Exit;

  FProcesso:= Manager.NewProcess(FExecutor, FActivity.ExpressionEvaluator);

  if Assigned(FProcesso) then
  begin
    FActivity.AddProcess(FProcesso);
    FProcessoDataSet.Synchronize;
  end;
end;

function TFormCadastroAtividade.ProcessoSelecionado: TProcessoBase;
begin
  Result:= FProcessoDataSet.GetCurrentModel<TProcessoBase>;
end;

function TFormCadastroAtividade.Manager: TActivityManager;
begin
  Result:= TFrwServiceLocator.Context.ActivityManager;
end;

procedure TFormCadastroAtividade.ConfigurarProcesso;
var
  FProcesso: TProcessoBase;
begin
  if ProcessoSelecionado = nil then
    Exit;

  Manager.EditProcess(ProcessoSelecionado, FActivity.ExpressionEvaluator);

  FProcessoDataSet.Synchronize;
end;

function TFormCadastroAtividade.ProcessoDao: IDaoBase;
begin
  Result:= FActivityDao.ChildDaoByPropName('Processos');
end;

constructor TFormCadastroAtividade.Create(AOWner: TComponent);
begin
  inherited;
  FActivityDao:= TActivityDao<TActivity>.Create;
  FActivityDataSet:= TObjectDataSet.Create(Self, FActivityDao.ModeloBD);
  FActivityDataSet.BeforePost:= ActivityBeforePost;

  FProcessoDataSet:= TObjectDataSet.Create(Self, ProcessoDao.ModeloBD);
  FInputDataSet:= TObjectDataSet.Create(Self, FActivityDao.InputDao.ModeloBD);
  FOutputDataSet:= TObjectDataSet.Create(Self, FActivityDao.OutputDao.ModeloBD);

  FProcessoDataSet.SetMaster(FActivityDataSet, 'Processos');
  FInputDataSet.SetMaster(FActivityDataSet, 'Inputs');
  FOutputDataSet.SetMaster(FActivityDataSet, 'Outputs');

  DsAtividade.DataSet:= FActivityDataSet;
  DsProcessos.DataSet:= FProcessoDataSet;
  DsInputs.DataSet:= FInputDataSet;
  DsOutputs.DataSet:= FOutputDataSet;

end;

destructor TFormCadastroAtividade.Destroy;
begin
  DsAtividade.DataSet:= nil;
  DsProcessos.DataSet:= nil;

  inherited;
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

procedure TFormCadastroAtividade.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True;
  if FActivityDataSet.Modified then
    if Application.MessageBox('Existem modificações não salvas, deseja sair sem salvar?', 'Atenção!',  MB_YESNO) = ID_NO then
      CanClose:= False;
end;

procedure TFormCadastroAtividade.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCadastroAtividade.BtnMoveDownClick(Sender: TObject);
var
  FCurIndex: Integer;
begin
  if ProcessoSelecionado=nil then
    Exit;

  FCurIndex:= FActivity.Processos.IndexOf(ProcessoSelecionado);
  if (FCurIndex <= -1) or (FCurIndex >= FActivity.Processos.Count-1) then
    Exit;

  ProcessoSelecionado.ExecOrder:= FActivity.Processos[FCurIndex+1].ExecOrder;
  FActivity.ReorderProcesses(ProcessoSelecionado);
  FProcessoDataSet.Synchronize(ProcessoSelecionado);
end;

procedure TFormCadastroAtividade.BtnMoveUpClick(Sender: TObject);
var
  FCurIndex: Integer;
begin
  if ProcessoSelecionado=nil then
    Exit;

  FCurIndex:= FActivity.Processos.IndexOf(ProcessoSelecionado);
  if FCurIndex <= 0 then
    Exit;

  ProcessoSelecionado.ExecOrder:= FActivity.Processos[FCurIndex-1].ExecOrder;
  FActivity.ReorderProcesses(ProcessoSelecionado);
  FProcessoDataSet.Synchronize(ProcessoSelecionado);
end;

procedure TFormCadastroAtividade.RemoverProcesso;
begin
  if ProcessoSelecionado = nil then
    Exit;

  if Application.MessageBox('Você tem certeza que deseja excluir este proesso?', 'Atenção!',  MB_YESNO) = ID_YES  then
  begin
    if ProcessoSelecionado.ID > 0 then
      FActivityDao.DeleteChild(FActivity, ProcessoSelecionado);

    FActivity.Processos.Remove(ProcessoSelecionado);
    FActivity.ReorderProcesses;
    FProcessoDataSet.Synchronize;
  end;
end;

procedure TFormCadastroAtividade.ActivityBeforePost(DataSet: TDataSet);
const
  cMsg = 'Atividade precisa ter um nome válido.';
begin
  if DataSet.FieldByName('Name').AsString = '' then
  begin
    ShowMessage(cMsg);
    Abort;
  end;
end;

procedure TFormCadastroAtividade.BtnRemoveProcessoClick(Sender: TObject);
begin
  RemoverProcesso;
end;

procedure TFormCadastroAtividade.BtnSalvarClick(Sender: TObject);
begin
  if FActivityDataSet.State in ([dsEdit, dsInsert]) then
    FActivityDataSet.Post;

  FActivity.CheckValidity(FActivity.ExpressionEvaluator);

  FActivityDao.Save(FActivity);
  FActivityDataSet.Synchronize;
end;

end.
