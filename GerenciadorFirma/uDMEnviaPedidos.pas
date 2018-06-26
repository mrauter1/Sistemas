unit uDMEnviaPedidos;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DB, Data.SqlExpr, uDmSqlUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Generics.Collections,
  Variants, FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageXML, Vcl.ExtCtrls,
  uSendMail, IniFiles;

type
  TDMEnviaPedidos = class(TDataModule)
    SQLQuery: TSQLQuery;
    FDMemTable: TFDMemTable;
    SQLQueryCODPEDIDO: TStringField;
    SQLQueryNOMECLI: TStringField;
    SQLQueryNOMETRANSP: TStringField;
    QryProdutosPed: TSQLQuery;
    QryProdutosPedPRODUTO: TStringField;
    QryProdutosPedUNIDADE: TStringField;
    QryProdutosPedQUANTATENDIDA: TLargeintField;
    QryProdutosPedSOLTOATENDIDO: TLargeintField;
    QryProdutosPedQUANTPENDENTE: TLargeintField;
    QryProdutosPedSOLTOPENDENTE: TLargeintField;
    QryProdutosPedPRECO: TFMTBCDField;
    QryProdutosPedVALTOTAL: TFMTBCDField;
    Timer1: TTimer;
    SQLQuerySITUACAO: TStringField;
    SQLQueryNOMECONDICAO: TStringField;
    SQLQueryTOTITENS: TIntegerField;
    SQLQuerySITBLOQUEIO: TStringField;
    SQLQueryDATAENTREGA: TDateField;
    SQLQueryCIDADE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FMailSender: TMailSender;
    FEmails: String;
    function VerificaAlteracaoPedido: Boolean;
    function VerificaAlteracoesPedidos: Boolean;
    procedure CopiaDataSet;
    function LocateByKey(KeyField: String; KeyValue: Variant): Boolean;
    procedure EnviaEmailNovoPedido;
    procedure EnviaEmailPedidoAlterado;
    procedure CarregarEmails;
  public
    { Public declarations }

  end;

function ObterCabecalhoHtml(pDataSet: TDataSet): String;
function ObterValoresRecordHtml(pDataSet: TDataSet): String;
function RecordToHtml(pDataSet: TDataSet): String;
function RecordToHtmlTable(pDataSet: TDataSet): String;
function RecordCompareToHtml(pDataSetOld: TDataSet; pDataSetNew: TDataSet): String;
function WrapHtml(pConteudo: String): String;

var
  DMEnviaPedidos: TDMEnviaPedidos;

const
  sProdutoTable = ' bgcolor=”#ffffff”; font-color:"white"; font-weight: "bold"; ';

implementation

uses
  Forms, Utils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDMEnviaPedidos }

procedure WriteLog(pTexto: String);
begin
  Utils.WriteLog('Monitor.log', pTexto);
end;

function WrapHtml(pConteudo: String): String;
begin
  Result:= '<html>'
          +'<head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"></head>'
//          +' <style> h1 { color: blue; } </style> '
          +pConteudo
          +'</html>';
end;

function RecordToHtml(pDataSet: TDataSet): String;
var
  FField: TField;
begin
  Result:= '';
  for FFIeld in pDataSet.Fields do
    if FField.Visible then
      Result:= Result+' <h2>'+FField.DisplayLabel+': '+FField.DisplayText+'</h2> ';

end;

function GetCssStyle(pStyle: String): String;
begin
  Result:= ' <style>'+pStyle+'</style>';
end;

function RecordToHtmlTable(pDataSet: TDataSet): String;
begin
  Result:= ' <table border="1"> ';
  Result:= Result+ObterCabecalhoHtml(pDataSet);
  Result:= Result+ObterValoresRecordHtml(pDataSet);
  Result:= Result+'</table>';
end;

function RecordCompareToHtml(pDataSetOld: TDataSet; pDataSetNew: TDataSet): String;
var
  FFieldNew, FFieldOld: TField;
begin
  Result:= '';
  for FFIeldNew in pDataSetNew.Fields do
  begin
    if not FFIeldNew.Visible then
      Continue;

    FFieldOld:= pDataSetOld.FindField(FFieldNew.FieldName);
    if not Assigned(FFieldOld) then
      Continue;

    if FFieldOld.Value <> FFieldNew.Value then
      Result:= Result+' <h2>'+FFieldNew.DisplayLabel+'(ALTERADO)=> Valor anterior: '+FFieldOld.DisplayText+'; Novo Valor: '+FFieldNew.DisplayText+'</h2> ';
  end;

end;

function ObterCabecalhoHtml(pDataSet: TDataSet): String;
var
  FField: TField;
begin
  Result:= '<tr>';
  for FField in pDataSet.Fields do
    if FField.Visible then
      Result:= Result+' <th>'+FField.DisplayLabel+'</th> ';
  Result:= Result+'</tr>';
end;

function FieldToTD(pField: TField): String;
var
  sAlign: String;
begin
  case pField.Alignment of
    taLeftJustify: sAlign:= '"left"';
    taRightJustify: sAlign:= '"right"';
    taCenter: sAlign:= '"center"';
  end;
  Result:= ' <td align='+sAlign+' >'+pField.DisplayText+'</td> ';
end;

function ObterValoresRecordHtml(pDataSet: TDataSet): String;
var
  FField: TField;
begin
  Result:= '<tr>';
  for FField in pDataSet.Fields do
    if FField.Visible then
      Result:= Result+FieldToTD(FField);

  Result:= Result+'</tr>';
end;

function DataSetToHtml(pDataSet: TDataSet): String;
begin
  Result:= '<table> ';
  Result:= Result+ObterCabecalhoHtml(pDataSet);

  pDataSet.First;
  while not pDataSet.Eof do
  begin
    Result:= Result+ObterValoresRecordHtml(pDataSet);
    pDataSet.Next;
  end;
  Result:= Result+'</table>';
end;

procedure TDMEnviaPedidos.EnviaEmailPedidoAlterado;

  function GetHtmlPedidoAlterado: String;
  begin
    QryProdutosPed.Close;
    QryProdutosPed.ParamByName('CODPEDIDO').AsString:= SqlQueryCODPEDIDO.AsString;
    QryProdutosPed.Open;

    Result:=  WrapHtml('<h1>Pedido Alterado</h1>'+
                        RecordCompareToHtml(FDMemTable, SQLQuery)+
                        RecordToHtmlTable(SqlQuery)+
                        '<br>'+
                        DataSetToHtml(QryProdutosPed));
  end;

begin
  WriteLog('Enviando email de pedido alterado nro.: '+SqlQueryCodPedido.AsString+', para os emails: '+FEmails);
  FMailSender.EnviarEmail('Pedido alterado: '+SqlQueryCODPEDIDO.AsString+', '+SqlQueryNOMECLI.AsString, GetHtmlPedidoAlterado,
    FEmails, 'marcelo@rauter.com.br');
end;

procedure TDMEnviaPedidos.DataModuleCreate(Sender: TObject);
begin
  CarregarEmails;

  FMailSender:= TMailSender.Create(Self, 'smtp.rauter.com.br', 587, 'marcelo@rauter.com.br', 'rtq1825', True, 'marcelo@rauter.com.br');
  try
    FDMemTable.LoadFromFile('Pedidos.xml', sfXml);
  except
  end;
  VerificaAlteracoesPedidos;
end;

procedure TDMEnviaPedidos.EnviaEmailNovoPedido;

  function GetHtmlNovoPedido: String;
  var
    fFlags: TReplaceFlags;
  begin
    fFlags:= [rfReplaceAll, rfIgnoreCase];
//    Result:= cHtmlPedido;
    QryProdutosPed.Close;
    QryProdutosPed.ParamByName('CODPEDIDO').AsString:= SqlQueryCODPEDIDO.AsString;
    QryProdutosPed.Open;

    Result:=  WrapHtml('<h1>Novo Pedido</h1>'+RecordToHtmlTable(SqlQuery)+'<br>'+DataSetToHtml(QryProdutosPed));
  end;

begin
  WriteLog('Enviando email de novo pedido nro.: '+SqlQueryCodPedido.AsString+', para os emails: '+FEmails);
  FMailSender.EnviarEmail('Novo Pedido: '+SqlQueryCODPEDIDO.AsString+', '+SqlQueryNOMECLI.AsString, GetHtmlNovoPedido,
      FEmails, 'marcelo@rauter.com.br');
end;

procedure TDMEnviaPedidos.CarregarEmails;
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'Monitor.Ini') = True then
  begin
    ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Monitor.Ini');
    try
      FEmails :=
        ArqIni.ReadString('Emails', 'NovoPedido', 'marcelo@rauter.com.br');
    finally
      ArqIni.Free;
    end;
  end;
end;

procedure TDMEnviaPedidos.CopiaDataSet;
begin
  FDMemTable.CopyDataSet(SqlQuery, [coStructure, coRestart, coAppend]);
end;

function TDMEnviaPedidos.VerificaAlteracaoPedido: Boolean;
begin


  Result:= Length(ComparaRecord(SqlQuery, FDMemTable, 'SITUACAO;PEDIDOEMUSO;NOMETRANSP')) > 0;
  if Result then  
    EnviaEmailPedidoAlterado;
end;

function TDMEnviaPedidos.LocateByKey(KeyField: String; KeyValue: Variant): Boolean;
begin
  if not FDMemTable.Active then
    Result:= False
  else
    Result:= FDMemTable.Locate(KeyField, KeyValue);
end;

procedure TDMEnviaPedidos.Timer1Timer(Sender: TObject);
begin
  CarregarEmails;
  VerificaAlteracoesPedidos;
end;

function TDMEnviaPedidos.VerificaAlteracoesPedidos: Boolean;
begin
  Result:= False;
  WriteLog('Verificando alterações nos pedidos');
  try
    SqlQuery.SQLConnection.Connected:= True;
    SqlQuery.Close;
    SqlQuery.Open;

    SqlQuery.First;
    while not SqlQuery.Eof do
    begin
      if LocateByKey('CODPEDIDO', SQLQueryCODPEDIDO.AsString) then
        Result:= VerificaAlteracaoPedido
      else
        EnviaEmailNovoPedido;

      SqlQuery.Next;
    end;

    CopiaDataSet;
  finally
    SqlQuery.SQLConnection.Connected:= False;
  end;

  FDMemTable.SaveToFile('Pedidos.xml', sfXml);
end;

end.
