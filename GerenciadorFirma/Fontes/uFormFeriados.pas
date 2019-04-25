unit uFormFeriados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConSqlServer, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, cxCalendar, cxSplitter, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFormFeriados = class(TForm)
    GroupBox1: TGroupBox;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    QryFeriados: TFDQuery;
    DsFeriados: TDataSource;
    cxSplitter1: TcxSplitter;
    MemoDatas: TMemo;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    QryFeriadosData: TDateField;
    cxGridDBTableViewData: TcxGridDBColumn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFormFeriados.BitBtn1Click(Sender: TObject);
var
  I: Integer;
  Data: TDateTime;
begin
  for I := 0 to MemoDatas.Lines.Count-1 do
  begin
    if not TryStrToDate(MemoDatas.Lines[I], Data) then
    begin
      ShowMessage('Valor '+MemoDatas.Lines[I]+' não pode ser convertido em uma data!');
    end
   else
    begin
      if ConSqlServer.RetornaInteiro('SELECT COUNT(*) FROM FERIADOS WHERE DATA = '+
            QuotedStr(FormatDateTime('yyyy/mm/dd', Data))) = 0 then
      begin
        QryFeriados.Insert;
        QryFeriadosData.AsDateTime:= Data;
        QryFeriados.Post;
      end;
    end;
  end;
end;

procedure TFormFeriados.FormCreate(Sender: TObject);
var
  AIndex : TFDIndex;
begin
  AIndex := QryFeriados.Indexes.Add;
  AIndex.Name := 'Data';
  AIndex.Fields := 'Data';
  AIndex.Active := True;
  QryFeriados.IndexName := AIndex.Name;
end;

end.
