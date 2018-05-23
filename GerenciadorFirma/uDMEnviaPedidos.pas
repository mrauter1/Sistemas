unit uDMEnviaPedidos;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DB, Data.SqlExpr, uDmSqlUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Generics.Collections,
  Variants, FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageXML, Vcl.ExtCtrls;

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
    procedure DataModuleCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    function VerificaAlteracaoPedido: Boolean;
    function VerificaAlteracoesPedidos: Boolean;
    procedure CopiaDataSet;
    function LocateByKey(KeyField: String; KeyValue: Variant): Boolean;
    procedure EnviaEmailNovoPedido;
    function GetHtmlProdutosPed(pCodPedido: String): String;
    procedure EnviaEmailPedidoAlterado(pDict: TDictionary<string, string>);
  public
    { Public declarations }

  end;

var
  DMEnviaPedidos: TDMEnviaPedidos;

const
  cHtmlPedido = ''+
     '<html><head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"></head>' +
      '<style> '+
      'h1 { color: blue; } </style> '+
      '<h1>%numPed%</h1> '+
      '<h2>%cliente%</h2> '+
      '<h2>%transp%</h2> '+
      '<h2>%valortotal%</h2> '+
      '<table border="1"> '+
      '  <tr> '+
      '    <td colspan="2"></td> '+
      '    <td colspan="2" align="Center"><b>Atendido</b></td> '+
      '    <td colspan="2" align="Center"><b>Não Atendido</b></td> '+
      '    <td colspan="2"></td> '+
      '  </tr> '+
      '  <tr> '+
      '    <td>Produto</td> '+
      '    <td>Unidade</td> '+
      '    <td>Quant.</td> '+
      '    <td>Solto</td> '+
      '    <td>Quant.</td> '+
      '    <td>Solto</td> '+
      '    <td>Preço</td> '+
      '    <td>Total</td> '+
      '  </tr> '+
      '  %Produtos% '+
      ' </table> '+
      '</html> ';

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  uFormPrincipal;

{$R *.dfm}

{ TDMEnviaPedidos }

function TDMEnviaPedidos.GetHtmlProdutosPed(pCodPedido: String): String;
var
  fFlags: TReplaceFlags;
  sProduto: String;

const
  cHtmlProdutos = ''+
      ' <tr> '+
      '    <td>%Produto%</td> '+
      '    <td>%Unidade%</td> '+
      '    <td>%Quant%</td> '+
      '    <td>%Solto%</td> '+
      '    <td>%QuantPendente%</td> '+
      '    <td>%SoltoPendente%</td> '+
      '    <td>%Preço%</td> '+
      '    <td>%Total%</td> '+
      '  </tr> ';

begin
  Result:= '';

  fFlags:= [rfReplaceAll, rfIgnoreCase];

  while not QryProdutosPed.Eof do
  begin
    sProduto:= cHtmlProdutos;

    sProduto:= sProduto.Replace('%Produto%', Trim(QryProdutosPedPRODUTO.AsString), fFlags).
                  Replace('%Unidade%', Trim(QryProdutosPedUNIDADE.DisplayText), fFlags).
                  Replace('%Quant%', Trim(QryProdutosPedQUANTATENDIDA.DisplayText), fFlags).
                  Replace('%Solto%', Trim(QryProdutosPedSOLTOATENDIDO.DisplayText), fFlags).
                  Replace('%QuantPendente%', Trim(QryProdutosPedQUANTPENDENTE.DisplayText), fFlags).
                  Replace('%SoltoPendente%', Trim(QryProdutosPedSOLTOPENDENTE.DisplayText), fFlags).
                  Replace('%Preço%', Trim(QryProdutosPedPRECO.DisplayText), fFlags).
                  Replace('%Total%', Trim(QryProdutosPedVALTOTAL.DisplayText), fFlags);

    Result:= Result+sProduto;
    QryProdutosPed.Next;
  end;
end;

function WrapHtml(pConteudo: String): String;
begin
  Result:= '<html>'
          +'<head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"></head>' +
          +' <style> h1 { color: blue; } </style> '
          +pConteudo
          +'</html>';
end;

function RecordToHtml(pDataSet: TDataSet): String;
var
  I: Integer;
  FField: TField;
begin
  Result:= '';
  for FFIeld in pDataSet.Fields do
    if FField.Visible then
      Result:= Result+' <h2>'+FField.DisplayLabel+': '+FField.DisplayText+'</h2> ';

end;

function DataSetToHtml(pDataSet: TDataSet): String;

  function Cabecalho: String;
  var
    FField: TField;
  begin
    for FField in pDataSet.Fields do
      if FField.Visible then
        Result:= Result+' <tr>'+FField.DisplayLabel+'</tr> ';
  end;

  function Valores: String;
  var
    FField: TField;
  begin
    for FField in pDataSet.Fields do
      if FField.Visible then
        Result:= Result+' <tr>'+FField.DisplayText+'</tr> ';
  end;

begin
  Result:= Cabecalho;

  pDataSet.First;
  while not pDataSet.Eof do
  begin
    Result:= Result+Valores;
    pDataSet.Next;
  end;
end;

procedure TDMEnviaPedidos.EnviaEmailPedidoAlterado(pDict: TDictionary<string, string>);

  function GetHtmlPedidoAlterado: String;
  var
    fFlags: TReplaceFlags;

    function ObterTextoCampo(pNomeCampo: String): String;
    begin
      if pDict.ContainsKey(pNomeCampo) then
        Result:= pDict[pNomeCampo]
      else
        Result:= SqlQuery.FieldByName(pNomeCampo).DisplayLabel+': '+SqlQuery.FieldByName(pNomeCampo).DisplayText;

    end;

  begin
    fFlags:= [rfReplaceAll, rfIgnoreCase];
    Result:= cHtmlPedido;
    Result:= Result.Replace('%numPed%', 'Alterado Pedido Nro.: '+SqlQueryCODPEDIDO.AsString, fFlags).
                    Replace('%cliente%', ObterTextoCampo('NOMECLI'), fFlags).
                    Replace('%transp%', ObterTextoCampo('NOMETRANSP'), fFlags).
                    Replace('%valortotal%', ObterTextoCampo('TOTNOTA'), fFlags).
                    Replace('%produtos%', GetHtmlProdutosPed(SqlQueryCodPedido.AsString), fFlags);

  end;

begin
  FMailSender.EnviarEmail('Pedido alterado: '+SqlQueryCODPEDIDO.AsString+', '+SqlQueryNOMECLI.AsString, GetHtmlPedidoAlterado, 'marcelorauter@gmail.com', 'marcelo@rauter.com.br');
end;

procedure TDMEnviaPedidos.DataModuleCreate(Sender: TObject);
begin
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

    Result:=  WrapHtml('<h1>Novo Pedido!</h1>'+RecordToHtml(SqlQuery)+DataSetToHtml(QryProdutosPed));
  end;

begin
  FMailSender.EnviarEmail('Novo Pedido: '+SqlQueryCODPEDIDO.AsString+', '+SqlQueryNOMECLI.AsString, GetHtmlNovoPedido, 'marcelorauter@gmail.com', 'marcelo@rauter.com.br');
end;

procedure TDMEnviaPedidos.CopiaDataSet;
begin
  FDMemTable.CopyDataSet(SqlQuery, [coStructure, coRestart, coAppend]);
end;

function TDMEnviaPedidos.VerificaAlteracaoPedido: Boolean;
var
  FFieldsAlterados: TArray<String>;
  FDictCampoAlterado: TDictionary<String, String>;
  FCamposAlterados: String;
  I: Integer;

  procedure AdicionarValorAlterado(pCampo: TField; pOldValue: Variant; pNewValue: Variant);
  var
    FTexto: String;
  begin
    FTexto:= 'Campo '+pCampo.DisplayLabel+' alterado. Valor Anterior: '+VarToStrDef(pOldValue, '')+' Novo Valor: '+VarToStrDef(pNewValue, '');
    FDictCampoAlterado.AddOrSetValue(pCampo.FieldName.ToUpper, FTexto);
  end;

begin
  FDictCampoAlterado:= TDictionary<String, String>.Create;
  try
    FFieldsAlterados:= ComparaRecord(SqlQuery, FDMemTable, 'SITUACAO');

    Result:= Length(FFieldsAlterados) > 0;

    for I:= 0 to Length(FFieldsAlterados)-1 do
      AdicionarValorAlterado(SqlQuery.FieldByName(FFieldsAlterados[I]), FDMemTable.FieldByName(FFieldsAlterados[I]).DisplayText, SqlQuery.FieldByName(FFieldsAlterados[I]).DisplayText);

    if Result then
      EnviaEmailPedidoAlterado(FDictCampoAlterado);
  finally
    FDictCampoAlterado.Free;
  end;
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
  VerificaAlteracoesPedidos;
end;

function TDMEnviaPedidos.VerificaAlteracoesPedidos: Boolean;
begin
  Result:= False;

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
  FDMemTable.SaveToFile('Pedidos.xml', sfXml);
end;

end.
