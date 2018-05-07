unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmEstoqProdutos, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.Menus, GerenciadorUtils, uFormPedidos, uFormFila,
  uFormDensidades, uFormConversorLKG, uFormProInfo, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    MainMenu: TMainMenu;
    Pedidos1: TMenuItem;
    Fila1: TMenuItem;
    Densidade1: TMenuItem;
    Conversor1: TMenuItem;
    MenuItemProInfo: TMenuItem;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    Panel1: TPanel;
    BtnAtualiza: TButton;
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Pedidos1Click(Sender: TObject);
    procedure Fila1Click(Sender: TObject);
    procedure Densidade1Click(Sender: TObject);
    procedure Conversor1Click(Sender: TObject);
    procedure MenuItemProInfoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BtnAtualizaClick(Sender: TObject);
    procedure cxGridDBTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    procedure AtualizaGrid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  uDmFilaProducao;

procedure TForm1.AtualizaGrid;
begin
  cxGridDBTableView.ClearItems;
  cxGridDBTableView.DataController.CreateAllItems;
end;

procedure TForm1.BtnAtualizaClick(Sender: TObject);
begin
  DMFilaProducao.AtualizaFilaProducao;
  AtualizaGrid;
end;

procedure TForm1.Conversor1Click(Sender: TObject);
begin
  FormConversorLKG.Show;
end;

procedure TForm1.cxGridDBTableViewCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var
 AItem: TcxCustomGridTableItem;
begin
  AItem := Sender.FindItemByName('CODPRODUTO');
  if Assigned(AItem) then
    with Sender.DataController do
    begin
      FormProInfo.CdsProInfo.Locate('CODPRODUTO', VarToStr(Values[ FocusedRecordIndex, AItem.Index]), []);
      FormProInfo.Show;
    end;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
{  }
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
var
  fCds: TClientDataSet;
begin
{  if DBGrid1.DataSource.DataSet is TClientDataSet then
  begin
    fCds:= TClientDataSet(DBGrid1.DataSource.DataSet);

    SortClientDataSet(fCds, Column.Field.FieldName);
  end;                           }
end;

procedure TForm1.Densidade1Click(Sender: TObject);
begin
  FormDensidades.Show;
end;

procedure TForm1.Fila1Click(Sender: TObject);
begin
  FormFilaProducao.Show;

  AtualizaGrid;
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
