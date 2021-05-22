unit Ladder.ServiceLocator;

interface

uses
  Spring.Services, Spring.Container.Common, System.SysUtils, System.Classes, Windows,
  Forms, uSendMail, SynOLEDB, SynDb, Ladder.Types, Ladder.ORM.DaoUtils,
  Ladder.Activity.Manager, uDmConnection,
  Ladder.SqlServerConnection, Ladder.ExpressionEvaluator, System.SyncObjs,
  Spring, Spring.Events, Ladder.Logger;

type
  TFrwServiceLocator = class;

// Not thread safe, use on main thread only
  TFrwServiceFactory = class(TObject)
  private
  public
    ConnectionParams: TConnectionParams;
    constructor Create; overload;
    constructor Create(AConnectionParams: TConnectionParams); overload;
    function NewSerivceFactory: TFrwServiceFactory; virtual;
    function NewDmConnection: TDmConnection; virtual;
//    function NewFuncoes(Connection: TDmConnection): TFuncoes; virtual;
    function NewDaoUtils(Connection: TSQLDBConnectionProperties): TDaoUtils; virtual;
    function NewServiceLocator: TServiceLocator; virtual;
    function NewConnection: TSQLDBConnectionProperties; virtual;
    function NewExpressionEvaluator(pDaoUtils: TDaoUtils = nil): TExpressionEvaluator; virtual;
  end;

  TFrwContext = class // The context owns everything! Will free every stance when Freed, including the ServiceFactory!
  private
    FServiceFactory: TFrwServiceFactory;
    FDmConnection: TDmConnection;
//    Funcoes: TFuncoes;
    FDaoUtils: TDaoUtils;
    FServiceLocator: TServiceLocator;
    FConnection: TSQLDBConnectionProperties;
    function GetConnection: TSQLDBConnectionProperties;
    function GetDaoUtils: TDaoUtils;
    function GetDmConnection: TDmConnection;
    function GetServiceFactory: TFrwServiceFactory;
    function GetServiceLocator: TServiceLocator;
    procedure SetServiceFactory(const Value: TFrwServiceFactory);
  public
    property ServiceFactory: TFrwServiceFactory read GetServiceFactory write SetServiceFactory;
    property DmConnection: TDmConnection read GetDmConnection;
    property DaoUtils: TDaoUtils read GetDaoUtils;
    property ServiceLocator: TServiceLocator read GetServiceLocator;
    property Connection: TSQLDBConnectionProperties read GetConnection;

    constructor Create; overload;
    constructor Create(pServiceFactory: TFrwServiceFactory); overload;
    destructor Destroy; override;
  end;

  TFrwThread = class(TThread)
  private
    FContext: TFrwContext;
  public
    constructor Create; overload;
    constructor Create(CreateSuspended: Boolean; AConnectionParams: TConnectionParams); overload;
    destructor Destroy;
    property Context: TFrwContext read FContext;
  end;

  TFrwServiceLocator = class(TObject)
  private
    class var FExeName: String;
    class var mainThreadID: Cardinal;
    class var GlobalContext: TFrwContext;
    class var FActivityManager: TActivityManager;
    class var FLogger: TLdLogger;

    class function GetContext: TFrwContext; static;
    class function GetActivityManager: TActivityManager; static;
  public
    // Call once on main thread
    class procedure Start;

    class procedure Finish;

    class procedure Inicializar(ServiceFactory: TFrwServiceFactory);

    // Execute method on Main Thread
    class procedure Synchronize(FMethod: TThreadProcedure);

    class function IsMainThread: Boolean;
    class function GetTempPath: string;

    class function Factory: TFrwServiceFactory;

    class property ExeName: String read FExeName;

    class property ActivityManager: TActivityManager read GetActivityManager;

    class property Logger: TLdLogger read FLogger;

    // Context will return the context that is tied to the Current Thread
    class property Context: TFrwContext read GetContext;
  end;

implementation

{ TMyServiceLocator }

uses
  Ladder.ConnectionPropertiesHelper;

class function TFrwServiceLocator.Factory: TFrwServiceFactory;
begin
  Result:= Context.ServiceFactory;
end;

class function TFrwServiceLocator.GetActivityManager: TActivityManager;
begin
  Result:= FActivityManager;
end;

class function TFrwServiceLocator.GetContext: TFrwContext;
begin
  if IsMainThread then
    Result:= GlobalContext
  else if TThread.CurrentThread is TFrwThread then
    Result:= (TThread.CurrentThread as TFrwThread).Context
  else raise Exception.Create('TFrwServiceLocator.GetContext: Thread must be a TFrwThread!');
end;

class function TFrwServiceLocator.GetTempPath: string;
begin
  Result:= ExtractFilePath(FExeName)+'Temp\';
end;

class procedure TFrwServiceLocator.Inicializar(ServiceFactory: TFrwServiceFactory);
begin
  GetContext.ServiceFactory:= ServiceFactory;
end;

class procedure TFrwServiceLocator.Finish;
begin
  GlobalContext.Free;
  FLogger.Free;
  FActivityManager.Free;
end;

class function TFrwServiceLocator.IsMainThread: Boolean;
begin
  Result:= GetCurrentThreadId = MainThreadID;
end;

class procedure TFrwServiceLocator.Start;
begin
  FExeName:= Application.ExeName;
  mainThreadID:= GetCurrentThreadID;
  FLogger:= TLdLogger.Create(ChangeFileExt(FExeName, '.log'));
  GlobalContext:= TFrwContext.Create;
  FActivityManager:= TActivityManager.Create;
end;

class procedure TFrwServiceLocator.Synchronize(FMethod: TThreadProcedure);
begin
  if IsMainThread then
    FMethod()
  else TThread.Synchronize(TThread.Current, FMethod);
end;

{ TFrwServiceFactory }

function TFrwServiceFactory.NewDmConnection: TDmConnection;
var
  FResult: TDmConnection;
begin
  if ConnectionParams.Server = '' then
    raise Exception.Create('TFrwServiceFactory.NewConnection: ConnectionParams not set!');

  TFrwServiceLocator.Synchronize(procedure begin
                                   FResult:= TDmConnection.Create(nil, ConnectionParams);
                                 end);
  Result:= FResult;
end;

function TFrwServiceFactory.NewExpressionEvaluator(pDaoUtils: TDaoUtils): TExpressionEvaluator;
begin
  if Assigned(pDaoUtils) then
    Result:= TExpressionEvaluator.Create(pDaoUtils)
  else
    Result:= TExpressionEvaluator.Create(TFrwServiceLocator.GetContext.DaoUtils);
end;

constructor TFrwServiceFactory.Create(AConnectionParams: TConnectionParams);
begin
  inherited Create;

  ConnectionParams:= AConnectionParams;
end;

constructor TFrwServiceFactory.Create;
begin
  inherited Create;

  ConnectionParams:= Default(TConnectionParams);
end;

function TFrwServiceFactory.NewConnection: TSQLDBConnectionProperties;
var
  FServerStr: String;
begin
  if ConnectionParams.Server = '' then
    raise Exception.Create('TFrwServiceFactory.NewConnection: ConnectionParams not set!');

  FServerStr:= ConnectionParams.Server;
  if ConnectionParams.Port <> 0 then
    FServerStr:= FServerStr+','+IntToStr(ConnectionParams.Port);

  Result:= TOleDBMSSQL2012ConnectionProperties.Create(FServerStr, ConnectionParams.Database,
                                                      ConnectionParams.User, ConnectionParams.Password);
  Result.ResetFieldDefinitions;
{
  FServerStr:= 'MSSQL?Server='+AppConfig.ConSqlServer.Server;
  if AppConfig.ConSqlServer.Port <> 0 then
    FServerStr:= FServerStr+';'+IntToStr(AppConfig.ConSqlServer.Port);

  Result:= TSQLDBFireDACConnectionProperties.Create(FServerStr, AppConfig.ConSqlServer.Database,
                                                      'user', '28021990'); }
end;

function TFrwServiceFactory.NewDaoUtils(Connection: TSQLDBConnectionProperties): TDaoUtils;
begin
  Result:= TDaoUtils.Create(Connection);
end;
{
function TFrwServiceFactory.NewFuncoes(Connection: TDmConnection): TFuncoes;
begin
  Result:= TFuncoes.Create;
end;}

function TFrwServiceFactory.NewSerivceFactory: TFrwServiceFactory;
begin
  Result:= TFrwServiceFactory.Create(ConnectionParams);
end;

function TFrwServiceFactory.NewServiceLocator: TServiceLocator;
begin
  Result:= TServiceLocator.Create;
end;

{ TFrwContext }

constructor TFrwContext.Create(pServiceFactory: TFrwServiceFactory);
begin
  Create;
  ServiceFactory:= pServiceFactory;
//  DmConnection:= ServiceFactory.NewDmConnection;
////  Funcoes:= ServiceFactory.NewFuncoes(DmConnection);
//  ServiceLocator:= ServiceFactory.NewServiceLocator;
//
//  Connection:= ServiceFactory.NewConnection;
//  DaoUtils:= ServiceFactory.NewDaoUtils(Connection);
//
//  ActivityManager:= ServiceFactory.NewActivityManager;
end;

procedure FreeIfAssigned(var Obj);
begin
  if Assigned(TObject(Obj)) then
    FreeAndNil(Obj);
end;

constructor TFrwContext.Create;
begin
  inherited Create;
end;

destructor TFrwContext.Destroy;
begin
  FreeIfAssigned(FServiceFactory);
  FreeIfAssigned(FDaoUtils);
  FreeIfAssigned(FServiceLocator);
  FreeIfAssigned(FConnection);

  TFrwServiceLocator.Synchronize(procedure begin
                                              FreeIfAssigned(FDmConnection);
                                            end);
end;

function TFrwContext.GetConnection: TSQLDBConnectionProperties;
begin
  if not Assigned(FConnection) then
    FConnection:= ServiceFactory.NewConnection;

  Result:= FConnection;
end;

function TFrwContext.GetDaoUtils: TDaoUtils;
begin
  if not Assigned(FDaoUtils) then
    FDaoUtils:= ServiceFactory.NewDaoUtils(Connection);

  Result:= FDaoUtils;
end;

function TFrwContext.GetDmConnection: TDmConnection;
begin
  if not Assigned(FDmConnection) then
    FDmConnection:= ServiceFactory.NewDmConnection;

  Result:= FDmConnection;
end;

function TFrwContext.GetServiceFactory: TFrwServiceFactory;
begin
  if not Assigned(FServiceFactory) then
    raise Exception.Create('TFrwContext.GetServiceFactory: ServiceFactory is not assigned!');

  Result:= FServiceFactory;
end;

function TFrwContext.GetServiceLocator: TServiceLocator;
begin
  if not Assigned(FServiceLocator) then
    FServiceLocator:= ServiceFactory.NewServiceLocator;

  Result:= FServiceLocator;
end;

procedure TFrwContext.SetServiceFactory(const Value: TFrwServiceFactory);
begin
  FreeIfAssigned(FServiceFactory);

  FServiceFactory:= Value;
end;

{ TFrwThread }

constructor TFrwThread.Create;
begin
  Create(False);
end;

constructor TFrwThread.Create(CreateSuspended: Boolean; AConnectionParams: TConnectionParams);
begin
  inherited Create(CreateSuspended);
  FContext:=TFrwContext.Create(TFrwServiceFactory.Create(AConnectionParams));
end;

destructor TFrwThread.Destroy;
begin
  inherited;
end;

initialization
  TFrwServiceLocator.Start;

finalization
  TFrwServiceLocator.Finish;

end.
