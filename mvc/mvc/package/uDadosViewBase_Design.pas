unit uDadosViewBase_Design;

interface

uses
  DesignIntf, DesignEditors, Classes;

procedure Register;

implementation

uses
  DadosView, ViewBase;

procedure Register;
begin
  RegisterNoIcon([TViewBase, TDadosView]);
  RegisterCustomModule(TViewBase, TCustomModule);
  RegisterCustomModule(TDadosView, TCustomModule); //([TDadosViewBase]);
end;


end.
 