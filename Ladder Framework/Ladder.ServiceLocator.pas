unit Ladder.ServiceLocator;

interface

uses
  Spring.Services, Spring.Container.Common, System.SysUtils, System.Classes, Windows,
  Forms, uSendMail, uAppConfig, SynOLEDB, SynDb,
  Ladder.ORM.DaoUtils, Ladder.ORM.Functions, Ladder.Activity.Manager, uDmConnection, uConSqlServer;

type
  TFrwServiceLocator = class;

// Not thread safe, use on main thread only
  TFrwServiceFactory = class(TObject)
  private
  public
    function NewDmConnection: TDmConnection; virtual;
    function NewFuncoes(Connection: TDmConnection): TFuncoes; virtual;
    function NewDaoUtils(Funcoes: TFuncoes): TDaoUtils; virtual;
    function NewServiceLocator: TServiceLocator; virtual;
    function NewConnection: TSQLDBConnectionProperties; virtual;
    function NewActivityManager: TActivityManager; virtual;
  end;

  TFrwContext = class
  private
  public
    ServiceFactory: TFrwServiceFactory;
    DmConnection: TDmConnection;
    Funcoes: TFuncoes;
    DaoUtils: TDaoUtils;
    ServiceLocator: TServiceLocator;
    Connection: TSQLDBConnectionProperties;
    ActivityManager: TActivityManager;
    constructor Create(pServiceFactory: TFrwServiceFactory); overload;
    destructor Destroy; override;
  end;

  TFrwThread = class(TThread)
  public
    Context: TFrwContext;
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
    // Execute method on Main Thread
    class procedure Synchronize(FMethod: TThreadProcedure);
    // Use this function to get the global Service Location or the service locator
    // linked to the current thread in a multi-threaded environment

    class function IsMainThread: Boolean;
    class function GetTempPath: string;
    class property ExeName: String read FExeName;

    class property Context: TFrwContext read GetContext;
  end;

implementation

{ TMyServiceLocator }

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
                                   FResult:= TConSqlServer.Create(nil);
                                 end);
  Result:= FResult;
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
end;

function TFrwServiceFactory.NewDaoUtils(Funcoes: TFuncoes): TDaoUtils;
begin
  Result:= TDaoUtils.Create(Funcoes);
end;

function TFrwServiceFactory.NewFuncoes(Connection: TDmConnection): TFuncoes;
begin
  Result:= TFuncoes.Create(Connection);
end;

function TFrwServiceFactory.NewServiceLocator: TServiceLocator;
begin
  Result:= TServiceLocator.Create;
end;

{ TFrwContext }

constructor TFrwContext.Create(pServiceFactory: TFrwServiceFactory);
begin
  ServiceFactory:= pServiceFactory;
  DmConnection:= ServiceFactory.NewDmConnection;
  Funcoes:= ServiceFactory.NewFuncoes(DmConnection);
  DaoUtils:= ServiceFactory.NewDaoUtils(Funcoes);
  ServiceLocator:= ServiceFactory.NewServiceLocator;
  Connection:= ServiceFactory.NewConnection;
  inherited Create;
end;

destructor TFrwContext.Destroy;
begin
  ServiceFactory.Free;
  DaoUtils.Free;
  Funcoes.Free;
  ServiceLocator.Free;
  Connection.Free;

  TFrwServiceLocator.Synchronize(procedure begin
                                              DmConnection.Free;
                                            end);
end;

initialization
  TFrwServiceLocator.Inicializar(TFrwServiceFactory.Create);

end.
