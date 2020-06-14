unit Ladder.Activity.Classes.Dao;

interface

uses
  Ladder.ORM.Dao, Ladder.Activity.Classes, SynDB, Ladder.Activity.Manager, System.Rtti;

type
  TParameterDao<T: TParameter> = class(TDaoGeneric<T>)
    constructor Create(pNomeTabela: String; pKeyField: String; pIsMasterParameter: Boolean); // Master Parameter is a direct child of a process
  end;

  TProcessoDao<T: TProcessoBase> = class(TDaoGeneric<T>)
  private
    function GetExecutorClass(const pFieldName: String; Instance: TObject; MasterInstance: TObject=nil): Variant; virtual;
    function GetClassName(const pFieldName: String; Instance: TObject; MasterInstance: TObject=nil): Variant; virtual;
    function GetExecutor(const pPropName: String; pCurrentValue: TValue; Instance: TObject; pDBRows: ISqlDBRows; Sender: TObject): TValue;
  public
    constructor Create; overload;
    constructor Create(pItemClass: TClass); overload;
    function NewProcesso(pDBRows: ISqlDBRows): TProcessoBase; virtual;
    function ActivityManager: TActivityManager;
  end;

  TActivityDao<T: TActivity> = class(TProcessoDao<T>)
  private
    FProcessoDao: TProcessoDao<TProcessoBase>;
  public
    constructor Create;
    function NewProcesso(pDBRows: ISqlDBRows): TProcessoBase; override;
  end;

implementation

uses
  Ladder.ServiceLocator, Data.DB, Ladder.ORM.ModeloBD;

{ TParameterDao }

constructor TParameterDao<T>.Create(pNomeTabela, pKeyField: String; pIsMasterParameter: Boolean);
begin
  inherited Create(pNomeTabela, pKeyFIeld, T);
  if pIsMasterParameter then
    Self.AddChildDao('Parameters', 'ID', 'IDMaster', TParameterDao<T>.Create(pNomeTabela, pKeyField, False))
  else
    Self.AddChildDao('Parameters', 'ID', 'IDMaster', Self); // Master of the parameter is another parameter
end;

{ TProcessoDao }

function TProcessoDao<T>.ActivityManager: TActivityManager;
begin
  Result:= TFrwServiceLocator.Context.ActivityManager;
end;

function TProcessoDao<T>.GetExecutorClass(const pFieldName: String; Instance: TObject; MasterInstance: TObject=nil): Variant;
var
  FExecutor: IExecutorBase;
begin
  FExecutor:= TProcessoBase(Instance).GetExecutor;
  if Assigned(FExecutor) then
    Result:= FExecutor.ClassType.ClassName
  else
    Result:= '';
end;

function TProcessoDao<T>.GetClassName(const pFieldName: String; Instance: TObject; MasterInstance: TObject=nil): Variant;
begin
  Result:= ModeloBD.ItemClass.ClassName;
end;

function TProcessoDao<T>.GetExecutor(const pPropName: String; pCurrentValue: TValue; Instance: TObject; pDBRows: ISqlDBRows; Sender: TObject): TValue;
var
  FExecutorClass: String;
begin
  FExecutorClass:= pDBRows['ExecutorClass'];
  if FExecutorClass <> '' then
    Result:= TValue.From<IExecutorBase>(ActivityManager.GetExecutor(FExecutorClass))
  else
    Result:= TValue.From<IExecutorBase>(nil);
end;

constructor TProcessoDao<T>.Create;
begin
  Create(T);
end;

constructor TProcessoDao<T>.Create(pItemClass: TClass);
var
  FOutputDao: IDaoGeneric<TOutputParameter>;
  FInputDao: IDaoGeneric<TParameter>;
begin
  inherited Create('ladder.Processos', 'ID', pItemClass);
  ModeloBD.MapField('ExecutorClass', ftString, GetExecutorClass);
  ModeloBD.MapField('ClassName', ftString, GetClassName);
  ModeloBD.MapProperty('Executor', GetExecutor);

  FInputDao:= TParameterDao<TParameter>.Create('ladder.ProcessoInput', 'ID', True);
  AddChildDao('Inputs', 'ID', 'IDProcesso', FInputDao);

  FOutputDao:= TParameterDao<TOutputParameter>.Create('ladder.ProcessoOutput', 'ID', True);
  AddChildDao('Outputs', 'ID', 'IDProcesso', FOutputDao);
end;

function TProcessoDao<T>.NewProcesso(pDBRows: ISqlDBRows): TProcessoBase;
var
  FExecutor: IExecutorBase;
begin
  FExecutor:= ActivityManager.GetExecutor(pDBRows.ColumnString('ExecutorClass'));
  Result:= TProcessoBase.Create(FExecutor, ModeloBD.DaoUtils);
end;

{ TAtividadeDao }

constructor TActivityDao<T>.Create;
begin
  inherited Create(T);
  FProcessoDao:= TProcessoDao<TProcessoBase>.Create;
  AddChildDao('Processos', 'ID', 'IDActivity', FProcessoDao);
end;

function TActivityDao<T>.NewProcesso(pDBRows: ISqlDBRows): TProcessoBase;
begin
  Result:= TActivity.Create(ModeloBD.DaoUtils);
end;

end.
