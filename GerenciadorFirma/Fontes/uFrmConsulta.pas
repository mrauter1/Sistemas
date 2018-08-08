unit uFrmConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  cxGridExportLink;

type
  TFrmConsulta = class(TForm)
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    Qry: TFDQuery;
    DataSource1: TDataSource;
    PanelTop: TPanel;
    BtnExec: TButton;
    BtnExport: TButton;
    SaveDialog: TSaveDialog;
    procedure BtnExportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure ExecutarSql(pSql: String);
    procedure CarregaConsulta(pNomeConsulta: String);

    class procedure AbreConsulta(pNomeConsulta: String);
    class procedure AbreEExecutaSql(pSql: String);
  end;

implementation

{$R *.dfm}

{ TFrmConsulta }

class procedure TFrmConsulta.AbreEExecutaSql(pSql: String);
var
  FFrm: TFrmConsulta;
begin
  FFrm:= TFrmConsulta.Create(Application);
  try
    FFrm.ExecutarSql(pSql);
    FFrm.Show;
  except
    FFrm.Free;
    raise;
  end;
end;

class procedure TFrmConsulta.AbreConsulta(pNomeConsulta: String);
var
  FFrm: TFrmConsulta;
begin
  FFrm:= TFrmConsulta.Create(Application);
  try
    FFrm.CarregaConsulta(pNomeConsulta);
    FFrm.Show;
  except
    FFrm.Free;
    raise;
  end;
end;

procedure TFrmConsulta.BtnExportClick(Sender: TObject);
begin
  SaveDialog.FileName:= 'Dados';
  if SaveDialog.Execute then
    ExportGridToExcel(SaveDialog.FileName, cxGrid);
end;

procedure TFrmConsulta.ExecutarSql(pSql: String);
begin
  Qry.Close;

  cxGridDBTableView.BeginUpdate();
  try
    cxGridDBTableView.ClearItems;

    Qry.Open(pSql);

    cxGridDBTableView.DataController.CreateAllItems;
  finally
    cxGridDBTableView.EndUpdate;
  end;
end;

procedure TFrmConsulta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFrmConsulta.CarregaConsulta(pNomeConsulta: String);
begin
  ExecutarSql('SELECT * FROM cons.'+pNomeConsulta.Replace('&', ''));
end;

end.

