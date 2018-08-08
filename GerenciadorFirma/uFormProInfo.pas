unit uFormProInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uConSqlServer;

type
  TFormProInfo = class(TForm)
    DataSource1: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGridDBTableViewCODPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewNAOFAZESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewPRODUCAOMINIMA: TcxGridDBColumn;
    QryProInfo: TFDQuery;
    QryProInfoNAOFAZESTOQUE: TBooleanField;
    QryProInfoESPACOESTOQUE: TIntegerField;
    QryProInfoPRODUCAOMINIMA: TIntegerField;
    QryProInfoSOMANOPESOLIQ: TBooleanField;
    QryProInfoAPRESENTACAO: TStringField;
    cxGridDBTableViewSOMANOPESOLIQ: TcxGridDBColumn;
    cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn;
    QryProInfoCODPRODUTO: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
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
  uConFirebird, uDmConnection;

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
begin
  Result:= VarToStrDef(ConSqlServer.FDConnection.ExecSQLScalar(
              'SELECT CODAPLICACAO FROM PRODUTO WHERE CODPRODUTO = '''+pCodProduto+''' ')
              , '');
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

    QryProInfo.Append;
    QryProInfoCODPRODUTO.AsString:= pCodProduto;
    QryProInfoNAOFAZESTOQUE.AsBoolean:= False;
    QryProInfoSOMANOPESOLIQ.AsBoolean:= True;
    if (pAplicacao = cLata18) or (pAplicacao = cLata900) then begin
      QryProInfoESPACOESTOQUE.AsInteger:= 22;
      QryProInfoPRODUCAOMINIMA.AsInteger:= 11;
    end
   else
    if (pAplicacao = cLata5) then begin
        QryProInfoESPACOESTOQUE.AsInteger:= 12;
        QryProInfoPRODUCAOMINIMA.AsInteger:= 6;
    end
   else
    if (pAplicacao = cTambor) then
    begin
      QryProInfoESPACOESTOQUE.AsInteger:= 22;
      QryProInfoPRODUCAOMINIMA.AsInteger:= 8;
    end
    else if (pAplicacao = cTamborete) then
    begin
      QryProInfoESPACOESTOQUE.AsInteger:= 5;
      QryProInfoPRODUCAOMINIMA.AsInteger:= 1;
    end
   else
    begin
      QryProInfoESPACOESTOQUE.AsInteger:= 0;
      QryProInfoPRODUCAOMINIMA.AsInteger:= 0;
      QryProInfoNAOFAZESTOQUE.AsBoolean:= True;
    end;

    QryProInfo.Post;
  end;
end;

procedure TFormProInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin

end;

{procedure TFormProInfo.ImportaDadosXml;
begin
  CarregaTabelaProInfo;
  CopiaDadosDataSet(CdsProInfo, QryProInfo);
  QryProInfo.First;
  while not QryProInfo.Eof do
  begin
    QryProInfo.Edit;
    if CdsProInfo.Locate('CODPRODUTO', QryProInfoCodProduto.AsString, []) then
      QryProInfoSomaNoPesoLiq.AsBoolean:= (CdsProInfoNaoSomaNoPesoLiq.IsNull) or (CdsProInfoNaoSomaNoPesoLiq.AsBoolean <> False);

    QryProInfo.Post;

    QryProInfo.Next;
  end;
end;}

procedure TFormProInfo.FormCreate(Sender: TObject);
begin
  ConSqlServer.TransformaEmLookup(QryProInfoAPRESENTACAO, 'SELECT CODPRODUTO, APRESENTACAO FROM PRODUTO');

  ReopenDataSet(QryProInfo);
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

  Result:= not QryProInfoSOMANOPESOLIQ.AsBoolean;
end;

procedure TFormProInfo.LocateProInfo(pCodPro: String);
begin
  if not QryProInfo.Locate('CODPRODUTO', pCodPro, []) then
    AddProInfoDefault(pCodPro);
end;

end.
