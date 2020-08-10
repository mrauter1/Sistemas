unit Ladder.ServiceLocator;

interface

uses
  Spring.Services, Spring.Container.Common, System.SysUtils, System.Classes, Windows,
  Forms, uSendMail, uAppConfig, SynOLEDB, SynDb, Ladder.ORM.DaoUtils, Ladder.Activity.Manager, uDmConnection, uConSqlServer,
  Ladder.SqlServerConnection, Ladder.ExpressionEvaluator;

type
  TFrwServiceLocator = class;

// Not thread safe, use on main thread only
  TFrwServiceFactory = class(TObject)
  private
  public
    function NewDmConnection: TDmConnection; virtual;
//    function NewFuncoes(Connection: TDmConnection): TFuncoes; virtual;
    function NewDaoUtils(Connection: TSQLDBConnectionProperties): TDaoUtils; virtual;
    function NewServiceLocator: TServiceLocator; virtual;
    function NewConnection: TSQLDBConnectionProperties; virtual;
    function NewActivityManager: TActivityManager; virtual;
    function NewExpressionEvaluator(pDaoUtils: TDaoUtils = nil): TExpressionEvaluator; virtual;
  end;

  TFrwContext = class
  private
  public
    ServiceFactory: TFrwServiceFactory;
    DmConnection: TDmConnection;
//    Funcoes: TFuncoes;
    DaoUtils: TDaoUtils;
    ServiceLocator: TServiceLocator;
    Connection: TSQLDBConnectionProperties;
    ActivityManager: TActivityManager;
    constructor Create(pServiceFactory: TFrwServiceFactory); overload;
    destructor Destroy; override;
  end;

  TFrwThread = class(TThread)
  private
    FContext: TFrwContext;
  public
    constructor Create; overload;
    constructor Create(CreateSuspended: Boolean); overload;
    property Context: TFrwContext read FContext;
  end;

  TFrwServiceLocator = class(TObject)
  private
    class var FExeName: String;
    class var mainThreadID: Cardinal;
    class var GlobalContext: TFrwContext;

    class function GetContext: TFrwContext; static;
  public
    // Call once on main thread
    class procedure Inicializar(ServiceFactory: TFrwServiceFactory);

    class procedure Finalizar;

    // Execute method on Main Thread
    class procedure Synchronize(FMethod: TThreadProcedure);

    class function IsMainThread: Boolean;
    class function GetTempPath: string;

    class function Factory: TFrwServiceFactory;

    class property ExeName: String read FExeName;

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
  FExeName:= Application.ExeName;
  mainThreadID:= GetCurrentThreadID;
  GlobalContext:= TFrwContext.Create(ServiceFactory);
end;

class procedure TFrwServiceLocator.Finalizar;
begin
  GlobalContext.Free;
end;

class function TFrwServiceLocator.IsMainThread: Boolean;
begin
  Result:= GetCurrentThreadId = MainThreadID;
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
  TFrwServiceLocator.Synchronize(procedure begin
                                   FResult:= TConSqlServer.Create(nil, AppConfig.ConSqlServer);
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

function TFrwServiceFactory.NewActivityManager: TActivityManager;
begin
  Result:= TActivityManager.Create;
end;

function TFrwServiceFactory.NewConnection: TSQLDBConnectionProperties;
var
  FServerStr: String;
begin
  FServerStr:= AppConfig.ConSqlServer.Server;
  if AppConfig.ConSqlServer.Port <> 0 then
    FServerStr:= FServerStr+','+IntToStr(AppConfig.ConSqlServer.Port);

  Result:= TOleDBMSSQL2012ConnectionProperties.Create(FServerStr, AppConfig.ConSqlServer.Database,
                                                      'user', '28021990');
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

function TFrwServiceFactory.NewServiceLocator: TServiceLocator;
begin
  Result:= TServiceLocator.Create;
end;

{ TFrwContext }

constructor TFrwContext.Create(pServiceFactory: TFrwServiceFactory);
begin
  ServiceFactory:= pServiceFactory;
  DmConnection:= ServiceFactory.NewDmConnection;
//  Funcoes:= ServiceFactory.NewFuncoes(DmConnection);
  ServiceLocator:= ServiceFactory.NewServiceLocator;

  Connection:= ServiceFactory.NewConnection;
  DaoUtils:= ServiceFactory.NewDaoUtils(Connection);

  ActivityManager:= ServiceFactory.NewActivityManager;
  inherited Create;
end;

destructor TFrwContext.Destroy;
begin
  ServiceFactory.Free;
  DaoUtils.Free;
//  Funcoes.Free;
  ServiceLocator.Free;
  Connection.Free;

  TFrwServiceLocator.Synchronize(procedure begin
                                              DmConnection.Free;
                                            end);
end;

{ TFrwThread }

constructor TFrwThread.Create;
begin
  Create(False);
end;

constructor TFrwThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FContext:=TFrwContext.Create(TFrwServiceFactory.Create);
end;

initialization
  TFrwServiceLocator.Inicializar(TFrwServiceFactory.Create);

finalization
  TFrwServiceLocator.Finalizar;

end.
