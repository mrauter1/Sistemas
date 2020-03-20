unit Ladder.ServiceLocator;

interface

uses
  Spring.Services, System.SysUtils, System.Classes, uDmConnection, uConSqlServer, Windows,
  Ladder.ORM.DaoUtils, Ladder.ORM.Functions, Forms, uSendMail;

type
  TFrwServiceLocator = class;

// Not thread safe, use on main thread only
  TFrwServiceFactory = class(TObject)
  public
    function NewConnection: TDmConnection; virtual;
    function NewFuncoes(Connection: TDmConnection): TFuncoes; virtual;
    function NewDaoUtils(Funcoes: TFuncoes): TDaoUtils; virtual;
    function NewServiceLocator: TServiceLocator; virtual;
  end;

  TFrwThread = class(TThread)
  private
  public
    ServiceFactory: TFrwServiceFactory;
    Connection: TDmConnection;
    Funcoes: TFuncoes;
    DaoUtils: TDaoUtils;
    ServiceLocator: TServiceLocator;
    constructor Create; overload;
    constructor Create(pServiceFactory: TFrwServiceFactory); overload;
    destructor Destroy; override;
  end;

  TFrwServiceLocator = class(TObject)
  private
    class var FExeName: String;
    class var mainThreadID: Cardinal;
    class var globalserviceFactory: TFrwServiceFactory;
    class var globalConnection: TDmConnection;
    class var globalFuncoes: TFuncoes;
    class var globalDaoUtils: TDaoUtils;
    class var globalServiceLocator: TServiceLocator;
  public
    // Call once on main thread
    class procedure Inicializar; overload;
    class procedure Inicializar(ServiceFactory: TFrwServiceFactory; Connection: TDmConnection); overload;
    // Execute method on Main Thread
    class procedure Synchronize(FMethod: TThreadProcedure);
    // Use this function to get the global Service Location or the service locator
    // linked to the current thread in a multi-threaded environment
    class function GetServiceLocator: TServiceLocator;
    class function GetServiceFactory: TFrwServiceFactory;
    class function getConnection: TDmConnection;
    class function GetFuncoes: TFuncoes;
    class function GetDaoUtils: TDaoUtils;

    class function IsMainThread: Boolean;
    class function GetTempPath: string;
  end;

implementation

{ TMyServiceLocator }

class function TFrwServiceLocator.GetConnection: TDmConnection;
begin
  if IsMainThread then
    Result:= TFrwServiceLocator.globalConnection
  else if TThread.CurrentThread is TFrwThread then
    Result:= (TThread.CurrentThread as TFrwThread).Connection
  else raise Exception.Create('TFrwServiceLocator.GetConnection: Thread must be a TFrwThread!');
end;

class function TFrwServiceLocator.GetDaoUtils: TDaoUtils;
begin
  if IsMainThread then
    Result:= TFrwServiceLocator.globalDaoUtils
  else if TThread.CurrentThread is TFrwThread then
    Result:= (TThread.CurrentThread as TFrwThread).DaoUtils
  else raise Exception.Create('TFrwServiceLocator.GetDaoUtils: Thread must be a TFrwThread!');
end;

class function TFrwServiceLocator.GetFuncoes: TFuncoes;
begin
  if IsMainThread then
    Result:= TFrwServiceLocator.globalFuncoes
  else if TThread.CurrentThread is TFrwThread then
    Result:= (TThread.CurrentThread as TFrwThread).Funcoes
  else raise Exception.Create('TFrwServiceLocator.GetFuncoes: Thread must be a TFrwThread!');
end;

class function TFrwServiceLocator.GetServiceFactory: TFrwServiceFactory;
begin
  if IsMainThread then
    Result:= TFrwServiceLocator.globalserviceFactory
  else if TThread.CurrentThread is TFrwThread then
    Result:= (TThread.CurrentThread as TFrwThread).ServiceFactory
  else raise Exception.Create('TFrwServiceLocator.GetServiceFactory: Thread must be a TFrwThread!');
end;

class function TFrwServiceLocator.GetServiceLocator: TServiceLocator;
begin
  if IsMainThread then
    Result:= TFrwServiceLocator.globalServiceLocator
  else if TThread.CurrentThread is TFrwThread then
    Result:= (TThread.CurrentThread as TFrwThread).ServiceLocator
  else raise Exception.Create('TFrwServiceLocator.GetServiceLocator: Thread must be a TFrwThread!');
end;

class function TFrwServiceLocator.GetTempPath: string;
begin
  Result:= ExtractFilePath(FExeName)+'Temp\';
end;

class procedure TFrwServiceLocator.Inicializar;
begin
  FExeName:= Application.ExeName;
  globalserviceFactory:= TFrwServiceFactory.Create;
  globalConnection:= globalServiceFactory.NewConnection;
  mainThreadID:= GetCurrentThreadID;
  TFrwServiceLocator.Inicializar(globalserviceFactory, globalConnection);
end;

class procedure TFrwServiceLocator.Inicializar(ServiceFactory: TFrwServiceFactory; Connection: TDmConnection);
begin
  globalServiceFactory:= ServiceFactory;
  globalServiceLocator:= globalserviceFactory.NewServiceLocator;
  globalConnection:= Connection;
  globalFuncoes:= globalServiceFactory.NewFuncoes(globalConnection);
  globalDaoUtils:= globalserviceFactory.NewDaoUtils(globalFuncoes);
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

function TFrwServiceFactory.NewConnection: TDmConnection;
var
  FResult: TDmConnection;
begin
  TFrwServiceLocator.Synchronize(procedure begin
                                   FResult:= TConSqlServer.Create(nil);
                                 end);
  Result:= FResult;
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

{ TFrwThread }

constructor TFrwThread.Create;
begin
  ServiceFactory:= TFrwServiceFactory.Create;
  Create(ServiceFactory);
end;

constructor TFrwThread.Create(pServiceFactory: TFrwServiceFactory);
begin
  ServiceFactory:= pServiceFactory;
  Connection:= ServiceFactory.NewConnection;
  Funcoes:= ServiceFactory.NewFuncoes(Connection);
  DaoUtils:= ServiceFactory.NewDaoUtils(Funcoes);
  ServiceLocator:= ServiceFactory.NewServiceLocator;
end;

destructor TFrwThread.Destroy;
begin
  ServiceFactory.Free;
  DaoUtils.Free;
  Funcoes.Free;
  ServiceLocator.Free;

  TFrwServiceLocator.Synchronize(procedure begin
                                              Connection.Free;
                                            end);
end;

initialization
  TFrwServiceLocator.Inicializar;

end.
