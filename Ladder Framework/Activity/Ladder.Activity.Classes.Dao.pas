unit Ladder.Activity.Classes.Dao;

interface

uses
  Ladder.ORM.Dao, Ladder.Activity.Classes, SynDB, Ladder.Activity.Manager, System.Rtti;

type
  TParameterDao = class(TDaoGeneric<TParameter>)
    constructor Create(pNomeTabela: String);
  end;

  TOutputParameterDao = class(TDaoGeneric<TOutputParameter>)
  private
    FInputDao: TParameterDao;
  public
    constructor Create(pNomeTabela: String);
  end;

  TProcessoDao = class(TDaoGeneric<TProcessoBase>)
  private
    FInputDao: TParameterDao;
    FOutputDao: TOutputParameterDao;
    function GetExecutorClass(const pFieldName: String; Instance: TObject): Variant; virtual;
    function GetClassName(const pFieldName: String; Instance: TObject): Variant; virtual;
  public
    constructor Create; overload;
    constructor Create(pItemClass: TClass); overload;
    function NewProcesso(pDBRows: ISqlDBRows): TObject; virtual;
    function ActivityManager: TActivityManager;
  end;

  TAtividadeDao = class(TProcessoDao)
  private
    FProcessoDao: TProcessoDao;
  public
    constructor Create;
    function NewProcesso(pDBRows: ISqlDBRows): TObject; override;
  end;

implementation

uses
  Ladder.ServiceLocator, Data.DB, Ladder.ORM.ModeloBD;

{ TParameterDao }

constructor TParameterDao.Create(pNomeTabela: String);
begin
  inherited Create(pNomeTabela, 'ID');
end;

{ TProcessoDao }

function TProcessoDao.ActivityManager: TActivityManager;
begin
  Result:= TFrwServiceLocator.Context.ActivityManager;
end;

function TProcessoDao.GetExecutorClass(const pFieldName: String; Instance: TObject): Variant;
var
  FExecutor: IExecutorBase;
begin
  FExecutor:= TProcessoBase(Instance).GetExecutor;
  if Assigned(FExecutor) then
    Result:= FExecutor.ClassType.ClassName
  else
    Result:= '';
end;

function TProcessoDao.GetClassName(const pFieldName: String; Instance: TObject): Variant;
begin
  Result:= ModeloBD.ItemClass.ClassName;
end;

constructor TProcessoDao.Create;
begin
  Create(TProcessoBase);
end;

constructor TProcessoDao.Create(pItemClass: TClass);
begin
  inherited Create('Processo', 'ID', pItemClass);
  ModeloBD.MapField('ExecutorClass', ftString, GetExecutorClass);
  ModeloBD.MapField('ClassName', ftString, GetClassName);
  FInputDao:= TParameterDao.Create('ProcessoInput');
  AddChildDao('Inputs', 'ID', 'IDProcesso', FInputDao);
  FOutputDao:= TOutputParameterDao.Create('ProcessoOutput');
  AddChildDao('Ouputs', 'ID', 'IDProce\sso', FOutputDao);
end;

function TProcessoDao.NewProcesso(pDBRows: ISqlDBRows): TObject;
var
  FExecutor: IExecutorBase;
begin
  FExecutor:= ActivityManager.GetExecutor(pDBRows.ColumnString('ExecutorClass'));
  Result:= TProcessoBase.Create(FExecutor, ModeloBD.DaoUtils);
end;

{ TOutputParameterDao }

constructor TOutputParameterDao.Create(pNomeTabela: String);
begin
  inherited Create(pNomeTabela, 'ID');
  FInputDao:= TParameterDao.Create('ProcessoOutputParameter');
  AddChildDao('Parametros', 'ID', 'IDOutput', FInputDao);
end;

{ TAtividadeDao }

constructor TAtividadeDao.Create;
begin
  inherited Create(TActivity);
  FProcessoDao:= TProcessoDao.Create;
  AddChildDao('Processos', 'ID', 'IDAtividade', FProcessoDao);
end;

function TAtividadeDao.NewProcesso(pDBRows: ISqlDBRows): TObject;
begin
  Result:= TActivity.Create(ModeloBD.DaoUtils);
end;

end.
