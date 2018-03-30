unit uClienteView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSidViewBase, Mask, DBCtrls, ViewBase, DadosView, CadView, StdCtrls,
  Buttons, ExtCtrls, uClienteControle, ComCtrls;

type
  TClienteView = class(TSidViewBase)
    Label4: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClienteView: TClienteView;

implementation

{$R *.dfm}

end.
