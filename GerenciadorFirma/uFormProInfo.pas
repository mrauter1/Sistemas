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
    CdsProInfoNAOSOMANOPESOLIQ: TBooleanField;
    cxGridDBTableViewNAOSOMANOPESOLIQ: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    procedure CarregaTabelaProInfo;
    function GetAplicacao(const pCodProduto: String): String;
    { Private declarations }
  public
    procedure AddProInfoDefault(pCodProduto: String);
    function NaoSomaNoPesoLiq(pCodPro: String): Boolean;
    procedure LocateProInfo(pCodPro: String);

    procedure Abrir(pCodProduto: String);
  end;

var
  FormProInfo: TFormProInfo;

implementation

{$R *.dfm}

uses
  uDmSqlUtils;

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

function TFormProInfo.GetAplicacao(const pCodProduto: String): String;
var
  fDataSet: TDataSet;

begin
  fDataSet:= DmSqlUtils.RetornaDataSet('SELECT CODAPLICACAO FROM PRODUTO WHERE CODPRODUTO = '''+pCodProduto+''' ');
  try
    Result:= fDataSet.FieldByName('CODAPLICACAO').AsString;
  finally
    fDataSet.Free;
  end;
end;

procedure TFormProInfo.AddProInfoDefault(pCodProduto: String);
var
  pAplicacao: String;
const
  cLata18 = '0002';
  cLata5 = '0003';
  cLata900 = '0004';
  cTambor = '0000';
  cTamborete = '0001';
begin
  with FormProInfo do
  begin
    pAplicacao:= GetAplicacao(pCodProduto);

    CdsProInfo.Append;
    CdsProInfoCODPRODUTO.AsString:= pCodProduto;
    CdsProInfoNAOFAZESTOQUE.AsBoolean:= False;
    CdsProInfoNAOSOMANOPESOLIQ.AsBoolean:= False;
    if (pAplicacao = cLata18) or (pAplicacao = cLata900) then begin
      CdsProInfoESPACOESTOQUE.AsInteger:= 22;
      CdsProInfoPRODUCAOMINIMA.AsInteger:= 11;
    end
   else
    if (pAplicacao = cLata5) then begin
        CdsProInfoESPACOESTOQUE.AsInteger:= 12;
        CdsProInfoPRODUCAOMINIMA.AsInteger:= 6;
    end
   else
    if (pAplicacao = cTambor) then
    begin
      CdsProInfoESPACOESTOQUE.AsInteger:= 22;
      CdsProInfoPRODUCAOMINIMA.AsInteger:= 8;
    end
    else if (pAplicacao = cTamborete) then
    begin
      CdsProInfoESPACOESTOQUE.AsInteger:= 5;
      CdsProInfoPRODUCAOMINIMA.AsInteger:= 1;
    end
   else
    begin
      CdsProInfoESPACOESTOQUE.AsInteger:= 0;
      CdsProInfoPRODUCAOMINIMA.AsInteger:= 0;
      CdsProInfoNAOFAZESTOQUE.AsBoolean:= False;
    end;

    CdsProInfo.Post;
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

procedure TFormProInfo.Abrir(pCodProduto: String);
begin
  LocateProInfo(pCodProduto);
  Show;
end;

function TFormProInfo.NaoSomaNoPesoLiq(pCodPro: String): Boolean;
begin
  Result:= False;
  LocateProInfo(pCodPro);

  if CdsProInfoNAOSOMANOPESOLIQ.IsNull then
    Exit;

  Result:= CdsProInfoNAOSOMANOPESOLIQ.AsBoolean
end;

procedure TFormProInfo.LocateProInfo(pCodPro: String);
begin
  if not CdsProInfo.Locate('CODPRODUTO', pCodPro, []) then
    AddProInfoDefault(pCodPro);
end;

end.
