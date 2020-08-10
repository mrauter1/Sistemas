unit Root;

interface

uses
  Ladder.ServiceLocator, Ladder.Activity.Classes, Ladder.Activity.Classes.Dao, Ladder.Activity.Scheduler, Ladder.Activity.Scheduler.Dao;

type
  TRootClass = class
    procedure CreateAllTables;
  end;

implementation


{ TRoot }

procedure TRootClass.CreateAllTables;
var
  FProcessoDao: IProcessoDao<TProcessoBase>;
  FActivityDao: IProcessoDao<TActivity>;
  FScheduledActivityDao: IScheduledActivityDao<TScheduledActivity>;
begin
{  FProcessoDao:= TProcessoDao<TProcessoBase>.Create;
  FProcessoDao.CreateTableAndFields;
  FActivityDao:= TActivityDao<TActivity>.Create;
  FActivityDao.CreateTableAndFields;       }
  FScheduledActivityDao:= TScheduledActivityDao<TScheduledActivity>.Create; // TScheduledActivityDao creates TProcessoBase; TActivity; and all related tables, since it inherits from TActivityDao
  FScheduledActivityDao.CreateTableAndFields;
end;

end.
