unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmEstoqProdutos, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.Menus, GerenciadorUtils, uFormPedidos, uFormFila,
  uFormDensidades, uFormConversorLKG, uFormProInfo;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    MainMenu: TMainMenu;
    Pedidos1: TMenuItem;
    Fila1: TMenuItem;
    Densidade1: TMenuItem;
    Conversor1: TMenuItem;
    MenuItemProInfo: TMenuItem;
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Pedidos1Click(Sender: TObject);
    procedure Fila1Click(Sender: TObject);
    procedure Densidade1Click(Sender: TObject);
    procedure Conversor1Click(Sender: TObject);
    procedure MenuItemProInfoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Conversor1Click(Sender: TObject);
begin
  FormConversorLKG.Show;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  FormProInfo.CdsProInfo.Locate('CODPRODUTO', DmEstoqProdutos.CODPRODUTO.AsString, []);
  FormProInfo.Show;
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
var
  fCds: TClientDataSet;
begin
  if DBGrid1.DataSource.DataSet is TClientDataSet then
  begin
    fCds:= TClientDataSet(DBGrid1.DataSource.DataSet);

    SortClientDataSet(fCds, Column.Field.FieldName);
  end;
end;

procedure TForm1.Densidade1Click(Sender: TObject);
begin
  FormDensidades.Show;
end;

procedure TForm1.Fila1Click(Sender: TObject);
begin
  FormFilaProducao.Show;
end;

procedure TForm1.MenuItemProInfoClick(Sender: TObject);
begin
  FormProInfo.Show;
end;

procedure TForm1.Pedidos1Click(Sender: TObject);
begin
  FormPedidos.Show;
end;

end.
