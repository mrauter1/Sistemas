unit uRefreshData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uDmFDConnection,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, uDmSqlUtils,
  FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.DataSet;

type
  TFrmRefreshData = class(TForm)
    Memo1: TMemo;
    QryFirebird: TFDQuery;
    FDTable1: TFDTable;
    Panel1: TPanel;
    EditNomeTabela: TEdit;
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DsFirebird: TDataSource;
    Button2: TButton;
    FDBatchMove: TFDBatchMove;
    FDTableResult: TFDTable;
    QryResultFb: TFDQuery;
    FDTableResultcodcliente: TStringField;
    FDTableResultrazaosocial: TStringField;
    FDTableResultobservacao: TWideMemoField;
    QryFirebirdCODCLIENTE: TStringField;
    QryFirebirdOBSERVACAO: TMemoField;
    QryResultFbCODCLIENTE: TStringField;
    QryResultFbOBSERVACAO: TMemoField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure ResetQueries;
    procedure ResetQuery(pDataSet: TDataSet);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRefreshData: TFrmRefreshData;

implementation

{$R *.dfm}

procedure TFrmRefreshData.Button1Click(Sender: TObject);
begin
  ResetQuery(QryResultFB);
  QryResultFb.Close;
  QryResultFb.Open(Memo1.Lines.Text);
end;

procedure TFrmRefreshData.ResetQuery(pDataSet: TDataSet);
begin
  if pDataSet.Active then
    pDataSet.Close;

  pDataSet.Fields.Clear;
  pDataSet.FieldDefs.Clear;
end;

procedure TFrmRefreshData.ResetQueries;
begin
  ResetQuery(QryFirebird);
  ResetQuery(FDTable1);

  ResetQuery(QryResultFb);
  ResetQuery(FDTableResult);
end;

procedure TFrmRefreshData.Button2Click(Sender: TObject);
var
  cfMapMemo: cfMapField;
begin
  cfMapMemo.SourceType:= ftMemo;
  cfMapMemo.DestType:= ftBlob;

  ResetQueries;
  QryFirebird.Sql.Text:= Memo1.Lines.Text;
  QryFirebird.Open;

  FDTable1.TableName:= EditNomeTabela.Text;
  TDmSqlUtils.CopyFieldDefs(FDTable1, QryFirebird, [cfMapMemo]);
  FDTable1.CreateTable(True);

  with TFDBatchMoveDataSetReader.Create(FDBatchMove) do begin
    DataSet := QryFirebird;
    Optimise := True;
  end;
  with TFDBatchMoveDataSetWriter.Create(FDBatchMove) do begin
    DataSet := FDTable1;
    Optimise := True;
  end;
  FDBatchMove.Execute;

  // show data in dbgrid
  QryResultFb.Sql.Text:= QryFirebird.SQL.Text;
  FDTableResult.TableName:= FDTable1.TableName;
  QryResultFb.Open;
  FDTableResult.Open;
end;

end.
