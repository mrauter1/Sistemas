unit uFormConsistenciaOPs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Data.DB;

type
  TFormConsistenciaOPs = class(TForm)
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConsistenciaOPs: TFormConsistenciaOPs;

implementation

{$R *.dfm}

end.
