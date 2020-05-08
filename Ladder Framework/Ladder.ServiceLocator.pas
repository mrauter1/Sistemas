unit Ladder.ServiceLocator;

interface

uses
  Spring.Services, Spring.Container.Common, System.SysUtils, System.Classes, Windows,
  Forms, uSendMail, uAppConfig, SynOLEDB, SynDb,
  Ladder.ORM.DaoUtils, Ladder.ORM.Functions, Ladder.Activity.Manager, uDmConnection, uConSqlServer,
  SynTable, SynCommons;

type
  TMySqlServerConnectionProperties = class(TOleDBMSSQL2012ConnectionProperties)
  public
    procedure InsertDocVariantData(TableName: String; pDocVariant: TDocVariantData);
  end;

  TFrwServiceLocator = class;

// Not thread safe, use on main thread only
  TFrwServiceFactory = class(TObject)
  private
  public
    function NewDmConnection: TDmConnection; virtual;
    function NewFuncoes(Connection: TDmConnection): TFuncoes; virtual;
    function NewDaoUtils(Connection: TSQLDBConnectionProperties): TDaoUtils; virtual;
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

uses
  SynDBFireDAC, Mormot, variants, Ladder.Activity.Classes, DateUtils;

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
                                   FResult:= TConSqlServer.Create(nil, AppConfig.ConSqlServer);
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

//  Result:= TOleDBMSSQL2012ConnectionProperties.Create(FServerStr, AppConfig.ConSqlServer.Database,
//                                                      'user', '28021990');

  Result:= TMySqlServerConnectionProperties.Create(FServerStr, AppConfig.ConSqlServer.Database,
                                                      'user', '28021990');

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

function TFrwServiceFactory.NewFuncoes(Connection: TDmConnection): TFuncoes;
begin
  Result:= TFuncoes.Create;
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
  Funcoes.Free;
  ServiceLocator.Free;
  Connection.Free;

  TFrwServiceLocator.Synchronize(procedure begin
                                              DmConnection.Free;
                                            end);
end;

{ TMySqlServerConnectionProperties }

procedure TMySqlServerConnectionProperties.InsertDocVariantData(
  TableName: String; pDocVariant: TDocVariantData);
var
  FieldNames: TRawUTF8DynArray;
  FieldTypes: TSQLDBFieldTypeArray;
  FieldValues: TRawUTF8DynArrayDynArray;
  FFieldCount: Integer;
  FFirstRow: PDocVariantData;

  procedure QuotePreviousValues(Col, CurrentRow: Integer);
  var
    Row: Integer;
  begin
    for Row := 0 to CurrentRow-1 do
    begin
      if FieldValues[Col, Row] <> 'null' then
        FieldValues[Col, Row]:= QuotedStr(FieldValues[Col, Row]);
    end;


  end;

  procedure SetType(Col, Row: Integer; pValue: PVAriant);
  var
    FFieldType: TSQLDBFieldType;
  begin
    if FieldTypes[Col] = ftUTF8 then Exit; // If it is a string it does not need to be changed

    FFieldType:= VariantVTypeToSQLDBFieldType(VarType(pValue^));

    if FFieldType <= ftNull then  // if current col FieldType is ftnull or ftUnknown does not need to change
      Exit;

    if FieldTypes[Col] <= ftNull then
    begin
      if (FFieldType = ftUTF8) and (LadderVarIsIso8601(pValue^)) then
        FieldTypes[Col]:= ftDate
      else
        FieldTypes[Col]:= FFieldType;

      Exit;
    end;

    if FFieldType = FieldTypes[Col] then
      Exit
    else if Ord(FFieldType) > Ord(FieldTypes[Col]) then
      FieldTypes[Col]:= FFieldType
    else // Ord(FFieldType) < Ord(FieldTypes[Col]
      if FieldTypes[Col] = ftDate then // if current column fieldtype is int, double or currency and prior fieldtype was date, must change to string
        FieldTypes[Col]:= ftUTF8;

    if FieldTypes[Col] = ftUtf8 then
      QuotePreviousValues(Col, Row);
  end;

  procedure SetFieldValue(Row, Col: Integer);
  var
    basicType: Integer;
    FVar: PVariant;
  begin
      FVar:= @pDocVariant._[Row].Values[Col];
      SetType(Col, Row, FVar);
      case FieldTypes[Col] of
        ftUnknown, ftNull: FieldValues[Col, Row] := 'null';
        ftUTF8: FieldValues[Col, Row]:= QuotedStr(VarToStr(FVar^));
      else
        FieldValues[Col, Row]:= VarToStr(FVar^);
      end;
  end;

var
  Col, Row: Integer;
  sStart, sFim: TDateTime;

const
  cBatchSize = 750; // Optimum performance
begin
  if pDocVariant.Count=0 then
    Exit;

  FFirstRow:= @TDocVariantData(pDocVariant.Values[0]);
  FFieldCount:= Length(FFirstRow^.Values);

  Assert(FFieldCount <= Length(FieldTypes),
    Format('TMySqlServerConnectionProperties.InsertDocVariantData: Maximum field count is %d.', [Length(FIeldTypes)]));

  SetLength(FieldNames,FFieldCount);
  for Col := 0 to FFieldCount-1 do
  begin
    FieldTypes[Col]:= ftNull;
    FieldNames[Col]:= FFirstRow^.Names[Col];
  end;

  SetLength(FieldValues, FFieldCount);
  for Col := 0 to FFieldCount-1 do
  begin
    SetLength(FieldValues[Col], pDocVariant.Count);
    for Row := 0 to pDocVariant.Count-1 do
      SetFieldValue(Row, Col);
  end;

  sStart:= now;
  MultipleValuesInsert(Self, '##MFORTESTE', FieldNames, FieldTypes, pDocVariant.Count, FieldValues);
  sFim:= now;
  Assert(False, IntToStr(MilliSecondsBetween(sStart, sFim)));
end;

initialization
  TFrwServiceLocator.Inicializar(TFrwServiceFactory.Create);

end.
