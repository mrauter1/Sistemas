unit uDadosViewBase_Design2.old;

interface

uses
  DesignIntf, DesignEditors;

procedure Register;

implementation

uses
  uDadosViewBase;

procedure Register;
begin
  RegisterCustomModule(TDadosViewBase, TCustomModule); //([TDadosViewBase]);
end;

end.
