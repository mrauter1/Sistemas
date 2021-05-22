unit Ladder.Activity.Scheduler;

interface

uses
  Ladder.Activity.Classes, Ladder.ServiceLocator, System.Generics.Collections, System.Classes, maxCron, Ladder.Activity.Classes.Dao, SyncObjs,
  Spring, Spring.Events, Ladder.Logger;

type
  TScheduledActivityStatus = (saWaiting=0, saExecuting=1, saError=2);

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
//    FExecuting: Boolean;
    FLastExecutionTime: TDateTime;
    FNextExecutionTime: TDateTime;
    FStartedExecutionTime: TDateTime;
    FStatus: TScheduledActivityStatus;
    FErrorCount: Integer;
    procedure SetCronExpression(const Value: String);
    procedure SetLastExecutionTime(const Value: TDateTime);
    function GetNextExecutionTime: TDateTime;
    function GetExecuting: Boolean;
    procedure GetStatus(const Value: TScheduledActivityStatus);
  public
    constructor Create(AExpressionEvaluator: IExpressionEvaluator); override;
  published
    property CronExpression: String read FCronExpression write SetCronExpression;
    property StartedExecutionTime: TDateTime read FStartedExecutionTime write FStartedExecutionTime;
    property LastExecutionTime: TDateTime read FLastExecutionTime write SetLastExecutionTime;
    property NextExecutionTime: TDateTime read GetNextExecutionTime; //write FNextExecutionTime;
    property Executing: Boolean read GetExecuting; //write FExecuting;
    property Status: TScheduledActivityStatus read FStatus write GetStatus;
    property ErrorCount: Integer read FErrorCount write FErrorCount;
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
  Status:= saWaiting;
  FErrorCount:= 0;
end;

function TScheduledActivity.GetExecuting: Boolean;
begin
  Result:= (Status = saExecuting);
end;

function TScheduledActivity.GetNextExecutionTime: TDateTime;
begin
  if Status=saError then
  begin
    Result:= IncSecond(StartedExecutionTime,10*ErrorCount); // Para cada erro aumenta em 10 segundos o tempo desde a última tentativa;
    Exit;
  end;
  Result:= FNextExecutionTime;
end;

procedure TScheduledActivity.GetStatus(const Value: TScheduledActivityStatus);
begin
  FStatus := Value;
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
  inherited Create(True, TFrwServiceLocator.Factory.ConnectionParams);
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

  FScheduledActivities.Free;
  FLoopingThread.Free;
  FListCriticalSection.Free;
  inherited;
end;

procedure TScheduler.DoLogEvent(ALogType: TLogType; AMessage: String);
begin
  TFrwServiceLocator.Logger.LogEvent(ALogType, AMessage);
end;

procedure TScheduler.ExecuteActivity(AActivity: TScheduledActivity);
begin
  // Execute on main Thread
  AActivity.Status:= saExecuting;
  AActivity.StartedExecutionTime:= Now;
  try
//    FDao.Update(AActivity, 'Executing');
    FDao.UpdateNoChild(AActivity);
    TFrwServiceLocator.Synchronize(
    procedure
    begin
      try
        DoLogEvent(ltNotification, Format('Activity %s started.', [AActivity.Name]));
        AActivity.Executar(AActivity.ExpressionEvaluator);
        AActivity.ErrorCount:= 0;
        AActivity.Status:= saWaiting;
        DoLogEvent(ltNotification, Format('Activity %s finished.', [AActivity.Name]));
      except
        on E: Exception do
        begin
          AActivity.Status:= saError;
          AActivity.ErrorCount:= AActivity.ErrorCount+1;
          DoLogEvent(ltError, Format('Error executing activity %s: %s', [AActivity.Name, E.Message]));
        end;
      end;
    end);
  finally
    AActivity.LastExecutionTime:= Now;
    FDao.UpdateNoChild(AActivity);
//    FDao.UpdateProperties(AActivity, 'LastExecutionTime, Executing');
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
          if FLoopingThread.Terminated then
            Exit;
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
