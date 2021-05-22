unit Ladder.Logger;

interface

uses
  Spring, Spring.Events, System.SyncObjs, Utils, SysUtils;

type
  TLogType = (ltNotification, ltError, ltWarning);
  TLogEvent = procedure(ALogType: TLogType; AMessage: String) of object;

  TLdLogger = class
  private
    FCriticalSection: TCriticalSection;
    OnLogEventList: IEvent<TLogEvent>;
    procedure DoWriteLog(ALogType: TLogType; AMessage: String);
    function LogTypeToStr(ALogType: TLogType): String;
  public
    LogFileName: String;
    constructor Create(AFileName: String);
    destructor Destroy; override;
    procedure LogEvent(ALogType: TLogType; AMessage: String);
    procedure AddListener(ALogEvent: TLogEvent);
    procedure RemoveListener(ALogEvent: TLogEvent);
  end;

implementation

{ TLdLogger }

constructor TLdLogger.Create(AFileName: String);
begin
  inherited Create;
  LogFileName:= AFileName;
  FCriticalSection:= TCriticalSection.Create;
  OnLogEventList:= TEvent<TLogEvent>.Create;
end;

destructor TLdLogger.Destroy;
begin
  FCriticalSection.Free;
  inherited;
end;

function TLdLogger.LogTypeToStr(ALogType: TLogType): String;
begin
  case ALogType of
    ltNotification: Result:= 'Notification';
    ltError: Result:= 'Error';
    ltWarning: Result:= 'Warning';
  else
    Result:= 'Unknown';
  end
end;

procedure TLdLogger.AddListener(ALogEvent: TLogEvent);
begin
  FCriticalSection.Acquire;
  try
    OnLogEventList.Add(ALogEvent);
  finally
    FCriticalSection.Release;
  end;
end;

procedure TLdLogger.RemoveListener(ALogEvent: TLogEvent);
begin
  FCriticalSection.Acquire;
  try
    OnLogEventList.Remove(ALogEvent);
  finally
    FCriticalSection.Release;
  end;
end;

procedure TLdLogger.DoWriteLog(ALogType: TLogType; AMessage: String);
begin
 if LogFileName <> '' then
    WriteLog(LogFileName, Format('%s: %s',[LogTypeToStr(ALogType), AMessage]));
end;

procedure TLdLogger.LogEvent(ALogType: TLogType; AMessage: String);
begin
  FCriticalSection.Acquire;
  try
    DoWriteLog(ALogType, AMessage);

    try
      if OnLogEventList.CanInvoke then
        TLogEvent(OnLogEventList.Invoke)(ALogType, AMessage);
    except
      DoWriteLog(ltError, 'Error while trying to call OnLogEvent.Invoke');
    end;
  finally
    FCriticalSection.Release;
  end;
end;

end.
