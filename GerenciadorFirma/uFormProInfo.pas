unit uFormProInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid;

type
  TFormProInfo = class(TForm)
    DataSource1: TDataSource;
    CdsProInfo: TClientDataSet;
    CdsProInfoCODPRODUTO: TStringField;
    CdsProInfoNAOFAZESTOQUE: TBooleanField;
    CdsProInfoESPACOESTOQUE: TIntegerField;
    CdsProInfoPRODUCAOMINIMA: TIntegerField;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGridDBTableViewCODPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewNAOFAZESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewPRODUCAOMINIMA: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    procedure CarregaTabelaProInfo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProInfo: TFormProInfo;

implementation

{$R *.dfm}

procedure CopiaFields(pSource, pDest: TClientDataSet);
var
  I: Integer;
  vField: TField;
begin
  for I := 0 to pSource.Fields.Count - 1 do
  begin
    vField:= pDest.FindField(pSource.Fields[I].FieldName);
    if vField <> nil then
    begin

      vField.Value:= pSource.Fields[I].Value;
    end;
  end;

end;

procedure CarregaArquivo(pCds: tClientDataset; const NomeArquivo: String);
var
  vCds: TClientDataSet;
begin
  // Carrega o arquivo em um Cds sem FieldDefs para evitar erros quando os Fields são alterados

  vCds:= tClientDataSet.Create(pCds);
  try
    vCds.LoadFromFile(NomeArquivo);
    vCds.First;
    while not vCds.Eof do
    begin
      pCds.Append;
      CopiaFields(vCds, pCds);
      pCds.Post;
      vCds.Next;
    end;
  finally
    vCds.Free;
  end;
end;

procedure TFormProInfo.CarregaTabelaProInfo;
begin
  if not CdsProInfo.Active then begin

    CdsProInfo.CreateDataSet;
    if FileExists(ExtractFilePath(Application.ExeName)+'ProInfo.xml') then
      CarregaArquivo(CdsProInfo, ExtractFilePath(Application.ExeName)+'ProInfo.xml');
  end;
end;

procedure TFormProInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CdsProInfo.MergeChangeLog;
  CdsProInfo.SaveToFile(ExtractFilePath(Application.ExeName)+'ProInfo.xml', dfXml);
end;

procedure TFormProInfo.FormCreate(Sender: TObject);
begin
  CarregaTabelaProInfo;
end;

end.
