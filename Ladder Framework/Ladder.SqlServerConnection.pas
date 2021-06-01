unit Ladder.SqlServerConnection;

interface

uses
  SynTable, SynCommons, SynDB, SynOLEDB;

type
  THackOleDBStatement = class(TOleDBStatement);

  TMyOleDBConnection = class(TOleDBConnection)
  protected
    fLastConnectionErrorTick: Int64;
    fLastSuccessTick: Int64;
    FTestingConnection: Boolean;
    function LastExecutionWasConnectionError: Boolean; virtual;
    function CheckConnectionError: Boolean; virtual;
    procedure OleDBCheck(aStmt: TSQLDBStatement; aResult: HRESULT;
       const aStatus: TCardinalDynArray=nil); override;
    function NewStatementPrepared(const aSQL: RawUTF8;
        ExpectResults, RaiseExceptionOnError, AllowReconnect: Boolean): ISQLDBStatement; override;
    public
    constructor Create(aProperties: TSQLDBConnectionProperties); override;
  end;


  TLadderSqlServerConnection = class(TOleDBMSSQL2012ConnectionProperties)
  private
  public
    function NewConnection: TSQLDBConnection; override;
  end;

implementation

uses
  Ladder.Utils, Variants, SysUtils, DateUtils;

{ TLadderSqlServerConnection }



{ TLadderSqlServerConnection }

function TLadderSqlServerConnection.NewConnection: TSQLDBConnection;
begin
  Result:= TMyOleDBConnection.Create(Self);
end;

{ TMyOleDBConnection }

constructor TMyOleDBConnection.Create(aProperties: TSQLDBConnectionProperties);
begin
  fLastConnectionErrorTick:= 0;
  fLastSuccessTick:= 0;
  FTestingConnection:= False;
  inherited;
end;

function TMyOleDBConnection.LastExecutionWasConnectionError: Boolean;
begin
  Result:= fLastConnectionErrorTick > fLastSuccessTick;
end;

function TMyOleDBConnection.NewStatementPrepared(const aSQL: RawUTF8;
  ExpectResults, RaiseExceptionOnError,
  AllowReconnect: Boolean): ISQLDBStatement;

  function IsThisConnectionOK: Boolean;
  var
    Stmt: ISQLDBStatement;
  begin
    FTestingConnection:= True;
    try
      try
        Stmt:= Self.NewStatementPrepared('SELECT 0',false,true, True); // Warning! works only for Sql Server
        Stmt.ExecutePrepared;
      except
        Result:= False;
        Exit;
      end;
    finally
      FTestingConnection:= False;
    end;
    Result:= True;
  end;

  procedure KeepTryingToReconnect;
    procedure TryToReconnect;
    begin
      try
        Self.Disconnect;
        Self.Connect;
      except
      end;
    end;
  begin
    TryToReconnect;
    while not Self.Connected do
    begin
      TryToReconnect;
      Sleep(300); // Try to reconnect every 500ms
    end;
  end;

begin
  if FTestingConnection then
  begin
    Result:= inherited;
    Exit;
  end;

  if LastExecutionWasConnectionError then
  begin
    If not IsThisConnectionOK then
      KeepTryingToReconnect;
  end;
  try
    Result:= inherited;
  except
    raise;
  end;
end;

function TMyOleDBConnection.CheckConnectionError: Boolean;
var
  FTestConnection: TOleDBConnection;
  FIsConnectionOK: Boolean;

  function GetIsConnectionOK: Boolean;
  begin
    try
      FTestConnection.Connect;
    except
      Result:= False;
      Exit;
    end;
    Result:= FTestConnection.IsConnected;
  end;
begin
  FTestConnection:= TOleDBConnection.Create(Self.OleDBProperties);
  try
    FIsConnectionOK:= GetIsConnectionOK;
    if FIsConnectionOK then
      Exit(False)
  else
    begin // Connection error
      while not GetIsConnectionOK do
        Sleep(500); // Try to reconnect every 500ms
      Exit(True); // Successfully reconnected
    end;
  finally
    FTestConnection.Free;
  end;
end;

procedure TMyOleDBConnection.OleDBCheck(aStmt: TSQLDBStatement;
  aResult: HRESULT; const aStatus: TCardinalDynArray);
begin
  try
    inherited;
  except
//    if LastErrorWasAboutConnection or (OleDBErrorMessage='') then // Can't reliably check if Error was about connection
    fLastConnectionErrorTick:= GetTickCount64;

    raise;
  end;
  fLastSuccessTick:= GetTickCount64;
end;

{procedure TMyOleDBConnection.OleDBCheck(aStmt: TSQLDBStatement;
  aResult: HRESULT; const aStatus: TCardinalDynArray);
begin
  try
    inherited;
  except
    if CheckConnectionError then // Returns true if there was connection error and connection was restablished
    begin
      THackOleDBStatement(aStmt).CloseRowSet;
      Self.Disconnect;
      Self.Connect;
      OleDBCheck(aStmt, aResult, aStatus)
    end
    else
    begin
      if LastErrorWasAboutConnection or (OleDBErrorMessage='') then
      begin
        try
          THackOleDBStatement(aStmt).CloseRowSet;
          Self.Disconnect;
          Self.Connect;
        except
        end;
      end
     else
      raise;
    end;
//    if ConnectionError then

//    raise Exception.Create('Error Message');
//    if Self.LastErrorWasAboutConnection then
//      TryReconnect;
  end;
end;
}


end.
