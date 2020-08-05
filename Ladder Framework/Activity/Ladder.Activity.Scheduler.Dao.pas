unit Ladder.Activity.Scheduler.Dao;

interface

uses
  Ladder.Activity.Classes, Ladder.Activity.Classes.Dao, Ladder.ORM.Dao, Ladder.Activity.Scheduler, SynDB,
  Ladder.ServiceLocator, Ladder.ORM.ModeloBD;

type
  TScheduledActivityDao<T: TScheduledActivity> = class(TActivityDao<T>, IScheduledActivityDao<T>)
  private
    FCompositeDao: IDaoGeneric<TScheduledActivity>;
  protected
    function GetClassName(const pFieldName: String; Instance: TObject; MasterInstance: TObject=nil): Variant; override;
  public
    constructor Create;
    function NewProcess(pDBRows: ISqlDBRows): TObject; override;
  end;

implementation

{ TScheduledActivityDao }

constructor TScheduledActivityDao<T>.Create;
var
  FModeloBD: TModeloBD;
begin
  inherited Create;

  FModeloBD:= TModeloBD.Create(TScheduledActivity, False);
  FModeloBD.NomeTabela:= 'ladder.ScheduledActivity';
  FModeloBD.NomePropChave:= 'ID';
  FModeloBD.ChaveIncremental:= False;
  FModeloBD.DoMapPublishedFields(True); // Only map published field of TScheduledActivity, and not from base class
  FModeloBD.Map('ID', 'ID'); // Since ID is a member of Base Class it must be explicitly added;

  FCompositeDao:= TDaoGeneric<TScheduledActivity>.Create(FModeloBD);

  AddCompositeDao(FCompositeDao);
end;

function TScheduledActivityDao<T>.GetClassName(const pFieldName: String;
  Instance, MasterInstance: TObject): Variant;
begin
  Result:= 'TScheduledActivity';
end;

function TScheduledActivityDao<T>.NewProcess(pDBRows: ISqlDBRows): TObject;
begin
  Result:= TScheduledActivity.Create(TFrwServiceLocator.Factory.NewExpressionEvaluator(ModeloBD.DaoUtils));
end;

end.
