unit uForm1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDataModule1, DB, Grids, DBGrids, ExtCtrls, DBCtrls;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DsOrcamento: TDataSource;
    DBNavigator1: TDBNavigator;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
