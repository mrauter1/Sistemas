unit Ladder.Activity.Scheduler;

interface

uses
  Ladder.Activity.Classes, Ladder.ServiceLocator, System.Generics.Collections, System.Classes, maxCron, Ladder.Activity.Classes.Dao, SyncObjs,
  Spring, Spring.Events;

type
  TLogType = (ltNotification, ltError);
  TLogEvent = procedure(ALogType: TLogType; AMessage: String) of object;

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
    FStop: Boolean;
    FStopped: Boolean;

    FListCriticalSection: TCriticalSection; // Must be used when writing from any thread or when reading is not done from the main thread

    procedure OnExecute(Sender: TObject);
    procedure ExecuteActivity(AActivity: TScheduledActivity);
    procedure DoLogEvent(ALogType: TLogType; AMessage: String);
  public
    OnLogEvent: IEvent<TLogEvent>;
    constructor Create(ALoadScheduledActivities: Boolean = True; AStopped: Boolean = False);
    destructor Destroy; override;

    procedure ReloadScheduledActivities;

    procedure Start;
    procedure Stop;

    property Stopped: Boolean read FStopped;

  published
    property ScheduledActivities: TObjectList<TScheduledActivity> read FScheduledActivities write FScheduledActivities;
  end;

implementation

uses
  SysUtils, DateUtils, Ladder.Activity.Scheduler.Dao, Utils;

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

constructor TScheduler.Create(ALoadScheduledActivities: Boolean = True; AStopped: Boolean = False);
begin
  inherited Create;
  FStop:= AStopped;
  FStopped:= AStopped;
  FDao:= TScheduledActivityDao<TScheduledActivity>.Create;

  FListCriticalSection:= TCriticalSection.Create;

  FScheduledActivities:= TScheduledActivities.Create;
  OnLogEvent:= TEvent<TLogEvent>.Create;

  FLoopingThread:= TNotifyThread.Create(OnExecute, Self);

  FLoopingThread.Start;

  if ALoadScheduledActivities then
     ReloadScheduledActivities;
end;

destructor TScheduler.Destroy;
begin
  Stop;
  while not Stopped do
    Sleep(10);

  FLoopingThread.Terminate;
  FLoopingThread.WaitFor;

  OnLogEvent:= nil;
  FScheduledActivities.Free;
  FLoopingThread.Free;
  FListCriticalSection.Free;
  inherited;
end;

procedure TScheduler.DoLogEvent(ALogType: TLogType; AMessage: String);
begin
  if OnLogEvent.CanInvoke then
    TLogEvent(OnLogEvent.Invoke)(ALogType, AMessage);
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
      try
        DoLogEvent(ltNotification, Format('Activity %s started.', [AActivity.Name]));
        AActivity.Executar(AActivity.ExpressionEvaluator);
        DoLogEvent(ltNotification, Format('Activity %s finished.', [AActivity.Name]));
      except
        on E: Exception do
          DoLogEvent(ltError, Format('Error executing activity %s: %s', [AActivity.Name, E.Message]));
      end;
    end);
  finally
    AActivity.LastExecutionTime:= Now;
    AActivity.FExecuting:= False;
    FDao.UpdateProperties(AActivity, 'LastExecutionTime, Executing');
  end;
end;

procedure TScheduler.ReloadScheduledActivities;
begin
  FListCriticalSection.Acquire;
  try
    ScheduledActivities.Clear;
    FDao.SelectWhere(ScheduledActivities, 'className = ''TScheduledActivity''');
  finally
    FListCriticalSection.Release;
  end;
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
    FListCriticalSection.Acquire;
    try
      for FScheduledActivity in ScheduledActivities do
      begin
        if not Assigned(Result) then
          Result:= FScheduledActivity
        else if FScheduledActivity.NextExecutionTime < Result.NextExecutionTime then
          Result:= FScheduledActivity;
      end;
    finally
      FListCriticalSection.Release;
    end;
  end;
begin
  try
    while not FLoopingThread.Terminated do
    begin
      try
        while FStop do
        begin
          FStopped:= True;
          Sleep(100);
        end;
        FStopped:= False;

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
       except
        on E: Exception do
          DoLogEvent(ltError, Format('Error on scheduler %s', [E.Message]));
      end;
    end;
  finally
    FStopped:= True;
  end;
end;

procedure TScheduler.Start;
begin
  FStop:= False;
end;

procedure TScheduler.Stop;
begin
  FStop:= True;
end;

end.
