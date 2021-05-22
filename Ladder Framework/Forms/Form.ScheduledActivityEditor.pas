
unit Form.ScheduledActivityEditor;

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
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Ladder.Activity.Classes,
  Ladder.ORM.Dao, Ladder.Activity.Scheduler.Dao, Ladder.Activity.Scheduler,
  Ladder.ORM.ObjectDataSet, Ladder.Activity.Manager, Vcl.ComCtrls;

type
  TFormScheduledActivityEditor = class(TForm)
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
    TbProcessos: TFDMemTable;
    TbProcessosID: TIntegerField;
    TbProcessosIDActivity: TIntegerField;
    TbProcessosName: TMemoField;
    TbProcessosDescription: TMemoField;
    TbProcessosClassName: TMemoField;
    TbProcessosExecutorClass: TMemoField;
    TbScheduledActivity: TFDMemTable;
    TbScheduledActivityIDActivity: TIntegerField;
    TbScheduledActivityName: TMemoField;
    TbScheduledActivityDescription: TMemoField;
    TbScheduledActivityClassName: TMemoField;
    TbScheduledActivityExecutorClass: TMemoField;
    TbScheduledActivityID: TIntegerField;
    TbProcessosExecOrder: TIntegerField;
    BtnMoveUp: TBitBtn;
    BtnMoveDown: TBitBtn;
    BtnExecutar: TBitBtn;
    DBEditCronExpression: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBEditLastExecutedTime: TDBEdit;
    DBEditNextExecutionTime: TDBEdit;
    TbScheduledActivityCronExpression: TMemoField;
    TbScheduledActivityLastExecutionTime: TSQLTimeStampField;
    TbScheduledActivityNextExecutionTime: TSQLTimeStampField;
    TbScheduledActivityExecuting: TBooleanField;
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
    FScheduledActivity: TScheduledActivity;
    FScheduledActivityDao: IScheduledActivityDao<TScheduledActivity>;

    FScheduledActivityDataSet: TObjectDataSet;
    FProcessoDataSet: TObjectDataSet;
    procedure RemoverProcesso;
    procedure ConfigurarProcesso;
    function ProcessoSelecionado: TProcessoBase;
    function ProcessoDao: IDaoBase;

    function NewSchedule: TScheduledActivity;
    function Manager: TActivityManager;
    procedure ActivityBeforePost(DataSet: TDataSet);
    { Private declarations }
  public
    constructor Create(AOWner: TComponent); override;
    destructor Destroy; override;
    procedure OpenSchedule(pAtividade: TScheduledActivity);

    class procedure _OpenSchedule(pAtividade: TScheduledActivity);
    class function _NewSchedule: TScheduledActivity;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  Form.SelecionaConsulta, Ladder.ServiceLocator, Form.NovoProcesso;

{ TFormActivityEditor }

procedure TFormScheduledActivityEditor.OpenSchedule(pAtividade: TScheduledActivity);
begin
  FScheduledActivity:= pAtividade;

  FScheduledActivityDataSet.SetObject(FScheduledActivity);

  FScheduledActivity.ReorderProcesses; // If the processes have no explicit order already, give them based on their Index;
//  FProcessoDataSet.SetObjectList<TProcessoBase>(FActivity.Processos);

  ShowModal;
end;

function TFormScheduledActivityEditor.NewSchedule: TScheduledActivity;
begin
  FScheduledActivity:= TScheduledActivity.Create(TFrwServiceLocator.Factory.NewExpressionEvaluator);
  FScheduledActivityDataSet.SetObject(FScheduledActivity);
//  FProcessoDataSet.SetObjectList<TProcessoBase>(FActivity.Processos);

  ShowModal;
  if FScheduledActivity.ID = 0 then
  begin
    FScheduledActivity.Free;
    Result:= nil
  end
 else
    Result:= FScheduledActivity;
end;

class procedure TFormScheduledActivityEditor._OpenSchedule(pAtividade: TScheduledActivity);
var
  FFrm: TFormScheduledActivityEditor;
begin
  FFrm:= TFormScheduledActivityEditor.Create(Application);
  try
    FFrm.OpenSchedule(pAtividade);
  finally
    FFrm.Free;
  end;
end;

class function TFormScheduledActivityEditor._NewSchedule: TScheduledActivity;
var
  FFrm: TFormScheduledActivityEditor;
begin
  FFrm:= TFormScheduledActivityEditor.Create(Application);
  try
    Result:= FFrm.NewSchedule;
  finally
    FFrm.Free;
  end;
end;

procedure TFormScheduledActivityEditor.BtnConfiguraProcessoClick(Sender: TObject);
begin
  ConfigurarProcesso;
end;

procedure TFormScheduledActivityEditor.BtnExecutarClick(Sender: TObject);
begin
  FScheduledActivity.Executar;
end;

procedure TFormScheduledActivityEditor.BtnAddProcessoClick(Sender: TObject);
var
  FIDConsulta: Integer;
  FProcesso: TProcessoBase;
  FExecutor: String;
begin
  FExecutor:= TFormNovoProcesso.SelecionaTipoProcesso;
  if FExecutor = '' then
    Exit;

  FProcesso:= Manager.NewProcess(FExecutor, FScheduledActivity.ExpressionEvaluator);

  if Assigned(FProcesso) then
  begin
    FScheduledActivity.AddProcess(FProcesso);
    FProcessoDataSet.Synchronize;
  end;
end;

function TFormScheduledActivityEditor.ProcessoSelecionado: TProcessoBase;
begin
  Result:= FProcessoDataSet.GetCurrentModel<TProcessoBase>;
end;

function TFormScheduledActivityEditor.Manager: TActivityManager;
begin
  Result:= TFrwServiceLocator.ActivityManager;
end;

procedure TFormScheduledActivityEditor.ConfigurarProcesso;
var
  FProcesso: TProcessoBase;
begin
  if ProcessoSelecionado = nil then
    Exit;

  Manager.EditProcess(ProcessoSelecionado, FScheduledActivity.ExpressionEvaluator);

  FProcessoDataSet.Synchronize;
end;

function TFormScheduledActivityEditor.ProcessoDao: IDaoBase;
begin
  Result:= FScheduledActivityDao.ChildDaoByPropName('Processos');
end;

constructor TFormScheduledActivityEditor.Create(AOWner: TComponent);
begin
  inherited;
  FScheduledActivityDao:= TScheduledActivityDao<TScheduledActivity>.Create;
  FScheduledActivityDataSet:= TObjectDataSet.Create(Self, TScheduledActivity);
  FScheduledActivityDataSet.BeforePost:= ActivityBeforePost;

  FProcessoDataSet:= TObjectDataSet.Create(Self, ProcessoDao.ModeloBD);

  FProcessoDataSet.SetMaster(FScheduledActivityDataSet, 'Processos');

  DsAtividade.DataSet:= FScheduledActivityDataSet;
  DsProcessos.DataSet:= FProcessoDataSet;
end;

destructor TFormScheduledActivityEditor.Destroy;
begin
  DsAtividade.DataSet:= nil;
  DsProcessos.DataSet:= nil;

  inherited;
end;

procedure TFormScheduledActivityEditor.FieldGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text:= Sender.AsString;
end;

procedure TFormScheduledActivityEditor.FieldSetText(Sender: TField;
  const Text: string);
begin
  Sender.AsString:= Text;
end;

procedure TFormScheduledActivityEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True;
  if FScheduledActivityDataSet.Modified then
    if Application.MessageBox('Existem modificações não salvas, deseja sair sem salvar?', 'Atenção!',  MB_YESNO) = ID_NO then
      CanClose:= False;
end;

procedure TFormScheduledActivityEditor.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormScheduledActivityEditor.BtnMoveDownClick(Sender: TObject);
var
  FCurIndex: Integer;
begin
  if ProcessoSelecionado=nil then
    Exit;

  FCurIndex:= FScheduledActivity.Processos.IndexOf(ProcessoSelecionado);
  if (FCurIndex <= -1) or (FCurIndex >= FScheduledActivity.Processos.Count-1) then
    Exit;

  ProcessoSelecionado.ExecOrder:= FScheduledActivity.Processos[FCurIndex+1].ExecOrder;
  FScheduledActivity.ReorderProcesses(ProcessoSelecionado);
  FProcessoDataSet.Synchronize(ProcessoSelecionado);
end;

procedure TFormScheduledActivityEditor.BtnMoveUpClick(Sender: TObject);
var
  FCurIndex: Integer;
begin
  if ProcessoSelecionado=nil then
    Exit;

  FCurIndex:= FScheduledActivity.Processos.IndexOf(ProcessoSelecionado);
  if FCurIndex <= 0 then
    Exit;

  ProcessoSelecionado.ExecOrder:= FScheduledActivity.Processos[FCurIndex-1].ExecOrder;
  FScheduledActivity.ReorderProcesses(ProcessoSelecionado);
  FProcessoDataSet.Synchronize(ProcessoSelecionado);
end;

procedure TFormScheduledActivityEditor.RemoverProcesso;
begin
  if ProcessoSelecionado = nil then
    Exit;

  if Application.MessageBox('Você tem certeza que deseja excluir este proesso?', 'Atenção!',  MB_YESNO) = ID_YES  then
  begin
    if ProcessoSelecionado.ID > 0 then
      FScheduledActivityDao.DeleteChild(FScheduledActivity, ProcessoSelecionado);

    FScheduledActivity.Processos.Remove(ProcessoSelecionado);
    FScheduledActivity.ReorderProcesses;
    FProcessoDataSet.Synchronize;
  end;
end;

procedure TFormScheduledActivityEditor.ActivityBeforePost(DataSet: TDataSet);
const
  cMsg = 'Atividade precisa ter um nome válido.';
begin
  if DataSet.FieldByName('Name').AsString = '' then
  begin
    ShowMessage(cMsg);
    Abort;
  end;
end;

procedure TFormScheduledActivityEditor.BtnRemoveProcessoClick(Sender: TObject);
begin
  RemoverProcesso;
end;

procedure TFormScheduledActivityEditor.BtnSalvarClick(Sender: TObject);
begin
  if FScheduledActivityDataSet.State in ([dsEdit, dsInsert]) then
    FScheduledActivityDataSet.Post;

  FScheduledActivity.CheckValidity(FScheduledActivity.ExpressionEvaluator);

  FScheduledActivityDao.Save(FScheduledActivity);
  FScheduledActivityDataSet.Synchronize;
end;

end.
