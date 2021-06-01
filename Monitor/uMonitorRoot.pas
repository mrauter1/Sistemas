unit uMonitorRoot;

interface

uses
  Root, Ladder.Activity.Scheduler, Ladder.ServiceLocator, Ladder.Logger;

type
  TMonitorRoot = class(TRootClass)
  private

  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  Forms, Utils;

{ TMonitorRoot }

constructor TMonitorRoot.Create;
begin

  inherited;
end;

destructor TMonitorRoot.Destroy;
begin

end;


end.
