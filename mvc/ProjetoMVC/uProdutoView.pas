unit uProdutoView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSidViewBase, ViewBase, DadosView, CadView, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, uProdutoControle, Mask, DBCtrls, uMVCInterfaces, Grids,
  DBGrids;

type
  TProdutoView = class(TSidViewBase)
    Label4: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label2: TLabel;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    procedure ViewBeforeMudaEstado(Estado: TViewEstado);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TProdutoView.ViewBeforeMudaEstado(Estado: TViewEstado);
begin
  inherited;
  TabSheet2.TabVisible:= Estado = vAtivo;
end;

end.
