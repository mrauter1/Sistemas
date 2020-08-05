unit Ladder.Activity.Scheduler;

interface

uses
  Ladder.Activity.Classes, Ladder.ServiceLocator, System.Generics.Collections, System.Classes, maxCron, Ladder.Activity.Classes.Dao;

type
  TNotifyThread = class(TFrwThread)
  public
    OnExecute: TNotifyEvent;
    Sender: TObject;
    constructor Create(AOnExecute: TNotifyEvent; ASender: TObject);
    procedure Execute; override;
  end;

  TScheduledActivity = class(TActivity)
  private
    FCronScheduler: TCronSchedulePlan;
    FCronExpression: String;
    FExecuting: Boolean;
    FLastExecutionTime: TDateTime;
    FNextExecutionTime: TDateTime;
    procedure SetCronExpression(const Value: String);
    procedure SetLastExecutionTime(const Value: TDateTime);
    function GetNextExecutionTime: TDateTime;
  public
    constructor Create(AExpressionEvaluator: IExpressionEvaluator); override;
  published
    property CronExpression: String read FCronExpression write SetCronExpression;
    property LastExecutionTime: TDateTime read FLastExecutionTime write SetLastExecutionTime;
    property NextExecutionTime: TDateTime read GetNextExecutionTime; //write FNextExecutionTime;
    property Executing: Boolean read FExecuting; //write FExecuting;
  end;

  TScheduledActivities = TObjectList<TScheduledActivity>;

  IScheduledActivityDao<T: TScheduledActivity> = interface(IProcessoDao<T>)
  end;

  TScheduler = class(TObject)
  private
    FLoopingThread: TNotifyThread;
    FScheduledActivities: TScheduledActivities;
    FDao: IScheduledActivityDao<TScheduledActivity>;
    FStopped: Boolean;
    procedure OnExecute(Sender: TObject);
    procedure ExecuteActivity(AActivity: TScheduledActivity);
  public
    constructor Create(pLoadScheduledActivities: Boolean = True);
    destructor Destroy; override;

    procedure LoadScheduledActivities;

    procedure Start;
    procedure Stop;

    property Stopped: Boolean read FStopped;

  published
    property ScheduledActivities: TObjectList<TScheduledActivity> read FScheduledActivities write FScheduledActivities;
  end;

implementation

uses
  SysUtils, DateUtils, Ladder.Activity.Scheduler.Dao;

{ TScheduledActivity }

constructor TScheduledActivity.Create(AExpressionEvaluator: IExpressionEvaluator);
begin
  inherited Create(AExpressionEvaluator);
  FCronScheduler:= TCronSchedulePlan.Create;
  FLastExecutionTime:= Now;
end;

function TScheduledActivity.GetNextExecutionTime: TDateTime;
begin
  Result:= FNextExecutionTime;
end;

procedure TScheduledActivity.SetCronExpression(const Value: String);
begin
  FCronExpression := Value;
  FCronScheduler.Parse(FCronExpression);
  FCronScheduler.FindNextScheduleDate(FLastExecutionTime, FNextExecutionTime);
end;

procedure TScheduledActivity.SetLastExecutionTime(const Value: TDateTime);
begin
  FLastExecutionTime := Value;
  FCronScheduler.FindNextScheduleDate(FLastExecutionTime, FNextExecutionTime);
end;

{ TNotifyThread }

constructor TNotifyThread.Create(AOnExecute: TNotifyEvent; ASender: TObject);
begin
  inherited Create(True);
  OnExecute:= AOnExecute;
  Sender:= ASender;
end;

procedure TNotifyThread.Execute;
begin
  if Assigned(OnExecute) then
    OnExecute(Sender);
end;

{ TScheduler }

constructor TScheduler.Create(pLoadScheduledActivities: Boolean = True);
begin
  inherited Create;
  FStopped:= False;
  FDao:= TScheduledActivityDao<TScheduledActivity>.Create;

  FScheduledActivities:= TScheduledActivities.Create;
  FLoopingThread:= TNotifyThread.Create(OnExecute, Self);

  if pLoadScheduledActivities then
     LoadScheduledActivities;

  FLoopingThread.Start;
end;

destructor TScheduler.Destroy;
begin
  FLoopingThread.Terminate;
  FLoopingThread.WaitFor;

  FScheduledActivities.Free;
  FLoopingThread.Free;
  inherited;
end;

procedure TScheduler.ExecuteActivity(AActivity: TScheduledActivity);
begin
  // Execute on main Thread
  AActivity.FExecuting:= True;
  FDao.UpdateProperties(AActivity, 'Executing');
  try
    TFrwServiceLocator.Synchronize(
    procedure
    begin
      AActivity.Executar(AActivity.ExpressionEvaluator);
    end);
  finally
    AActivity.LastExecutionTime:= Now;
    AActivity.FExecuting:= False;
    FDao.UpdateProperties(AActivity, 'LastExecutionTime, Executing');
  end;
end;

procedure TScheduler.LoadScheduledActivities;
begin
  ScheduledActivities.Clear;
  FDao.SelectWhere(ScheduledActivities, 'className = ''TScheduledActivity''');
end;

procedure TScheduler.OnExecute(Sender: TObject);
const
  cSleepTime=1000;
var
  FNextActivity: TScheduledActivity;
  FTimeToNext: Integer;

  function GetNextActivity: TScheduledActivity;
  var
    FScheduledActivity: TScheduledActivity;
  begin
    Result:= nil;

    for FScheduledActivity in ScheduledActivities do
    begin
      if not Assigned(Result) then
        Result:= FScheduledActivity
      else if FScheduledActivity.NextExecutionTime < Result.NextExecutionTime then
        Result:= FScheduledActivity;
    end;
  end;
begin
  while not FLoopingThread.Terminated do
  begin
    while FStopped do
      Sleep(100);

    FNextActivity:= GetNextActivity;
    if not Assigned(FNextActivity) then
    begin
      Sleep(cSleepTime); // Sleeps for one second if there is no ScheduledActivity
      Continue;
    end;

    if FNextActivity.NextExecutionTime <= Now then
      ExecuteActivity(FNextActivity)
    else
    begin
      FTimeToNext:= MilliSecondsBetween(FNextActivity.NextExecutionTime, Now);
      if FTimeToNext>cSleepTime then
        Sleep(cSleepTime)
      else
        Sleep(FTimeToNext);
     end;
  end;
end;

procedure TScheduler.Start;
begin
  FStopped:= False;
end;

procedure TScheduler.Stop;
begin
  FStopped:= True;
end;

end.
