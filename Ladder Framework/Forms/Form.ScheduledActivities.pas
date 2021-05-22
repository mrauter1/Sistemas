unit Form.ScheduledActivities;

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
  cxGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Ladder.ORM.Dao, Ladder.Activity.Scheduler.Dao, Ladder.Activity.Scheduler,
  Ladder.ORM.ObjectDataSet;

type
  TFormScheduledActivities = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnSelecionar: TButton;
    BtnFechar: TButton;
    BtnRemoverAviso: TButton;
    BtnNovoAviso: TButton;
    cxGridAvisosDBTableView1: TcxGridDBTableView;
    cxGridAvisosLevel1: TcxGridLevel;
    cxGridAvisos: TcxGrid;
    DsSchedules: TDataSource;
    cxGridAvisosDBTableView1ID: TcxGridDBColumn;
    cxGridAvisosDBTableView1IDActivity: TcxGridDBColumn;
    cxGridAvisosDBTableView1Name: TcxGridDBColumn;
    cxGridAvisosDBTableView1Description: TcxGridDBColumn;
    TbSchedules: TFDMemTable;
    TbSchedulesID: TIntegerField;
    TbSchedulesIDActivity: TIntegerField;
    TbSchedulesName: TMemoField;
    TbSchedulesDescription: TMemoField;
    TbSchedulesClassName: TMemoField;
    TbSchedulesExecutorClass: TMemoField;
    TbSchedulesCronExpression: TMemoField;
    TbSchedulesLastExecutionTime: TDateTimeField;
    TbSchedulesNextExecutionTime: TDateTimeField;
    cxGridAvisosDBTableView1CronExpression: TcxGridDBColumn;
    cxGridAvisosDBTableView1LastExecutionTime: TcxGridDBColumn;
    cxGridAvisosDBTableView1NextExecutionTime: TcxGridDBColumn;
    procedure BtnRemoverAvisoClick(Sender: TObject);
    procedure BtnNovoAvisoClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
  private
    FActivityDao: IDaoGeneric<TScheduledActivity>;
    FActivityDataSet: TObjectDataSet;
    procedure RemoveSchedule;
    procedure OpenSchedule;
    procedure NewSchedule;
    function SelectedActivity: TScheduledActivity;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    class procedure OpenScheduledActivities;
    class function SelectActivity: Integer;
  end;

var
  FormScheduledActivities: TFormScheduledActivities;

implementation

{$R *.dfm}

uses
  Form.ScheduledActivityEditor;

function TFormScheduledActivities.SelectedActivity: TScheduledActivity;
begin
  Result:= FActivityDataSet.GetCurrentModel<TScheduledActivity>;
end;

procedure TFormScheduledActivities.OpenSchedule;
begin
  if (SelectedActivity = nil) then
    Exit;

  TFormScheduledActivityEditor._OpenSchedule(SelectedActivity);
  FActivityDataSet.Synchronize;
end;

class procedure TFormScheduledActivities.OpenScheduledActivities;
var
  FFrm: TFormScheduledActivities;
begin
  FFrm:= TFormScheduledActivities.Create(Application);
  try
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

class function TFormScheduledActivities.SelectActivity: Integer;
var
  FFrm: TFormScheduledActivities;
begin
  FFrm:= TFormScheduledActivities.Create(Application);
  try
    FFrm.ShowModal;
    if FFrm.SelectedActivity <> nil then
      Result:= FFrm.SelectedActivity.ID
    else
      Result:= 0;

  finally
    FFrm.Free;
  end;

end;

procedure TFormScheduledActivities.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormScheduledActivities.BtnNovoAvisoClick(Sender: TObject);
var
  fInput: String;
begin
{  fInput:= InputBox('Avisos', 'Digite o nome do novo aviso:', '');
  if fInput = '' then Exit;    }

  NewSchedule;
end;

procedure TFormScheduledActivities.BtnRemoverAvisoClick(Sender: TObject);
begin
  RemoveSchedule;
end;

procedure TFormScheduledActivities.BtnSelecionarClick(Sender: TObject);
begin
  OpenSchedule;
end;

constructor TFormScheduledActivities.Create(AOwner: TComponent);
begin
  inherited;
  FActivityDao:= TScheduledActivityDao<TScheduledActivity>.Create;

  FActivityDataSet:= TObjectDataSet.Create(Self, TScheduledActivity);
  FActivityDataSet.OwnsObjectList:= True;
  FActivityDataSet.ObjectList:= FActivityDao.SelectWhere('className = ''TScheduledActivity''');

  DsSchedules.DataSet:= FActivityDataSet;
end;

procedure TFormScheduledActivities.NewSchedule;
var
  FAtividade: TScheduledActivity;
begin
  FAtividade:= TFormScheduledActivityEditor._NewSchedule;
  if not Assigned(FAtividade) then
    Exit;

  FActivityDataSet.AddItem(FAtividade);
  FActivityDataSet.Synchronize;
end;

procedure TFormScheduledActivities.RemoveSchedule;

  procedure RemoveAvisoDepencias(pAtividade: TScheduledActivity);
  var
    FSql: String;
  begin
    if pAtividade.ID > 0 then
      FActivityDao.Delete(pAtividade);

    FActivityDataSet.RemoveItem(pAtividade);
  end;

begin
  if not FActivityDataSet.IsEmpty then
    if Application.MessageBox('Você tem certeza que deseja excluir este aviso?', 'Atenção!',  MB_YESNO) = ID_YES  then
      RemoveAvisoDepencias(FActivityDataSet.GetCurrentModel<TScheduledActivity>);

end;

end.
