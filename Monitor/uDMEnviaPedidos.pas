unit uDMEnviaPedidos;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DB, Data.SqlExpr, uDmSqlUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Generics.Collections,
  Variants, FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageXML, Vcl.ExtCtrls,
  uSendMail, IniFiles, uDataSetToHtml, uConFirebird, uConSqlServer,
  FireDAC.Stan.Async, FireDAC.DApt;

type
  TDMEnviaPedidos = class(TDataModule)
    FDMemTable: TFDMemTable;
    Timer1: TTimer;
    QryPedidos: TFDQuery;
    QryPedidoIT: TFDQuery;
    QryPedidosCODPEDIDO: TStringField;
    QryPedidosNOMECLI: TStringField;
    QryPedidosDATAENTREGA: TDateField;
    QryPedidosNOMETRANSP: TStringField;
    QryPedidosCIDADE: TStringField;
    QryPedidosSITUACAO: TStringField;
    QryPedidosSITBLOQUEIO: TStringField;
    QryPedidosNOMECONDICAO: TStringField;
    QryPedidosTOTITENS: TIntegerField;
    QryPedidoITPRODUTO: TStringField;
    QryPedidoITUNIDADE: TStringField;
    QryPedidoITQUANTATENDIDA: TLargeintField;
    QryPedidoITSOLTOATENDIDO: TLargeintField;
    QryPedidoITQUANTPENDENTE: TLargeintField;
    QryPedidoITSOLTOPENDENTE: TLargeintField;
    QryPedidoITPRECO: TFMTBCDField;
    QryPedidoITVALTOTAL: TBCDField;
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

procedure TDMEnviaPedidos.EnviaEmailPedidoAlterado;

  function GetHtmlPedidoAlterado: String;
  begin
    QryPedidoIT.Close;
    QryPedidoIT.ParamByName('CODPEDIDO').AsString:= QryPedidosCODPEDIDO.AsString;
    QryPedidoIT.Open;

    Result:=  WrapHtml('<h1>Pedido Alterado</h1>'+
                        RecordCompareToHtml(FDMemTable, QryPedidos)+
                        RecordToHtmlTable(QryPedidos)+
                        '<br>'+
                        DataSetToHtml(QryPedidoIT));
  end;

begin
  WriteLog('Enviando email de pedido alterado nro.: '+QryPedidosCODPEDIDO.AsString+', para os emails: '+FEmails);
  FMailSender.EnviarEmail('Pedido alterado: '+QryPedidosCODPEDIDO.AsString+', '+QryPedidosNOMECLI.AsString, GetHtmlPedidoAlterado,
    FEmails, 'marcelo@rauter.com.br');
end;

procedure TDMEnviaPedidos.DataModuleCreate(Sender: TObject);
begin
  CarregarEmails;

  FMailSender:= TSendMailFactory.NewMailSender(nil, 'Config.ini', 'EMAIL');
  try
    FDMemTable.LoadFromFile('Pedidos.xml', sfXml);
  except
  end;
//  VerificaAlteracoesPedidos;
end;

procedure TDMEnviaPedidos.EnviaEmailNovoPedido;

  function GetHtmlNovoPedido: String;
  var
    fFlags: TReplaceFlags;
  begin
    fFlags:= [rfReplaceAll, rfIgnoreCase];
//    Result:= cHtmlPedido;
    QryPedidoIT.Close;
    QryPedidoIT.ParamByName('CODPEDIDO').AsString:= QryPedidosCODPEDIDO.AsString;
    QryPedidoIT.Open;

    Result:=  WrapHtml('<h1>Novo Pedido</h1>'+RecordToHtmlTable(QryPedidos)+'<br>'+DataSetToHtml(QryPedidoIT));
  end;

begin
  WriteLog('Enviando email de novo pedido nro.: '+QryPedidosCODPEDIDO.AsString+', para os emails: '+FEmails);
  FMailSender.EnviarEmail('Novo Pedido: '+QryPedidosCODPEDIDO.AsString+', '+QryPedidosNOMECLI.AsString, GetHtmlNovoPedido,
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
  FDMemTable.CopyDataSet(QryPedidos, [coStructure, coRestart, coAppend]);
end;

function TDMEnviaPedidos.VerificaAlteracaoPedido: Boolean;
begin
  Result:= Length(ComparaRecord(QryPedidos, FDMemTable, 'SITUACAO;PEDIDOEMUSO;NOMETRANSP')) > 0;
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
    QryPedidos.Connection.Connected:= True;
    QryPedidos.Close;
    QryPedidos.Open;

    QryPedidos.First;
    while not QryPedidos.Eof do
    begin
      if LocateByKey('CODPEDIDO', QryPedidosCODPEDIDO.AsString) then
        Result:= VerificaAlteracaoPedido
      else
        EnviaEmailNovoPedido;

      QryPedidos.Next;
    end;

    CopiaDataSet;
  finally
    QryPedidos.Connection.Connected:= False;
  end;

  FDMemTable.SaveToFile('Pedidos.xml', sfXml);
end;

end.
