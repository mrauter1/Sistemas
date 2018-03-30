unit ViewBase_Design;

interface

uses
  Classes;

procedure Register;

implementation

uses
  ViewBase, DadosView, CadView;

procedure Register;

begin

  RegisterComponents('MVC', [TViewBase, TDadosView, TCadView]);

end;


end.

