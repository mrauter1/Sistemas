unit uFormPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient,
  GerenciadorUtils, uDmEstoqProdutos;

type
  TFormPedidos = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPedidos: TFormPedidos;

implementation

{$R *.dfm}

procedure TFormPedidos.DBGrid1TitleClick(Column: TColumn);
var
  fCds: TClientDataSet;
begin
  if DBGrid1.DataSource.DataSet is TClientDataSet then
  begin
    fCds:= TClientDataSet(DBGrid1.DataSource.DataSet);

    SortClientDataSet(fCds, Column.Field.FieldName);
  end;
end;

end.
