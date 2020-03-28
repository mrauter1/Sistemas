unit uPedidos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  cxLookAndFeelPainters, cxGraphics, dxSkinsCore, cxClasses, dxAlertWindow,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uConSqlServer, uAppConfig;

type
  TPedidos = class(TDataModule)
    dxAlert: TdxAlertWindowManager;
    dxAlertFalta: TdxAlertWindowManager;
    QryPedidos: TFDQuery;
    QryPedidosCODPEDIDO: TStringField;
    QryPedidosCODPRODUTO: TStringField;
    QryPedidosNOMEPRODUTO: TStringField;
    QryPedidosDIASPARAENTREGA: TIntegerField;
    QryPedidosSIT: TStringField;
    QryPedidosCODCLIENTE: TStringField;
    QryPedidosNOMECLIENTE: TStringField;
    QryPedidosCODTRANSPORTE: TStringField;
    QryPedidosNOMETRANSPORTE: TStringField;
    QryPedidosEMFALTA: TBooleanField;
    QryPedidosFALTAAMANHA: TFMTBCDField;
    QryPedidosQUANTIDADE: TBCDField;
    QryPedidosFALTAHOJE: TFMTBCDField;
    QryPedidosEstoqueAtual: TBCDField;
    QryPedidosQUANTPENDENTE: TBCDField;
    QryPedidosSITUACAO: TStringField;
    TblPedidosCache: TFDMemTable;
    TblPedidosCacheCODPEDIDO: TStringField;
    TblPedidosCacheCODPRODUTO: TStringField;
    TblPedidosCacheEMFALTA: TBooleanField;
    QryPedidosDataEntrega: TDateField;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure VerificaNovosPedidos;
    procedure ShowAlertPedidoEmFalta;
    function GetTextoPedidoAlert: String;
    procedure ShowAlertNovoPedido;
    function GetStringDia: String;
//    function GetSql(pDataInicial, pDataFinal: TDateTime): String;
//    function ProdutoEmFalta(pCodProduto: String): Boolean;

    { Private declarations }
  public
//    procedure LoadPedidos(pDataInicial, pDataFinal: TDateTime);
//    procedure Filtra(const pFiltro: String);
    procedure LoadPedidosNew;
    procedure Refresh;
  end;

var
  Pedidos: TPedidos;

implementation

uses
  uConFirebird, Variants;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TPedidos }

procedure TPedidos.DataModuleCreate(Sender: TObject);
begin
//  Self.LoadPedidos(Now - 30, Now + 1);
  TblPedidosCache.CreateDataSet;

  Self.LoadPedidosNew;
end;

{procedure TPedidos.Filtra(const pFiltro: String);
begin
  if pFiltro = '' then
  begin
    Dados.Filter:= '';
    Dados.Filtered:= False;
  end
 else
  begin
    Dados.Filter:= pFiltro;
    Dados.Filtered:= True;
    Dados.First;
  end;
end;}
     {
function TPedidos.GetSql(pDataInicial, pDataFinal: TDateTime): String;
// Busca os pedidos pendentes no período
var
  sDataInicial, sDataFinal: string;
begin
  sDataInicial:= ''''+FormatDateTime('dd.mm.yyyy', pDataInicial)+'''';
  sDataFinal:= ''''+FormatDateTime('dd.mm.yyyy', pDataFinal)+'''';

  Result:= 'SELECT PI.CODPRODUTO, '+
                ' P.CODPEDIDO, '+
                ' PRO.APRESENTACAO AS NOMEPRODUTO, '+
                ' PI.quantpedida / PRO.UNIDADEESTOQUE as QUANTIDADE, '+
                ' PI.QUANTPENDENTE, '+
                ' (E.SALDOATUAL / PRO.UNIDADEESTOQUE) AS ESTOQUEATUAL, '+
                ' (case when P.DATAENTREGA > CAST(''NOW'' AS DATE)'+
                '   THEN CAST(P.DATAENTREGA AS DATE) - CAST(''NOW'' AS DATE) ELSE 0 END) AS DIASPARAENTREGA, '+
                ' (case when P.situacao = ''2'' THEN ''C'' ELSE ''P'' END) AS SIT, '+
                ' C.CODCLIENTE, '+
                ' C.RAZAOSOCIAL AS NOMECLIENTE, '+
                ' T.CODTRANSPORTE,' +
                ' T.CODTRANSPORTE||'' - ''||+T.NOMETRANSPORTE AS NOMETRANSPORTE '+
        ' FROM PEDIDO P '+
        ' INNER JOIN PEDIDOIT PI ON PI.codpedido = P.codpedido '+
        ' INNER JOIN PRODUTO PRO ON PRO.CODPRODUTO = PI.CODPRODUTO '+
        ' INNER JOIN CLIENTE C ON C.CODCLIENTE = P.CODCLIENTE '+
        ' INNER JOIN TRANSP T ON P.CODTRANSPORTE = T.CODTRANSPORTE '+
        ' INNER JOIN estoque E ON E.CODPRODUTO = PRO.CODPRODUTO AND E.CODFILIAL = ''01'' '+
        ' where P.situacao IN (''0'', ''1'', ''2'') AND '+
        ' P.dataentrega BETWEEN CAST('+sDataInicial+' as DATE) AND CAST('+ sDataFinal +'  AS DATE) '+
        ' order by PI.CODPRODUTO, SIT, DIASPARAENTREGA DESC  ';
end;

function TPedidos.ProdutoEmFalta(pCodProduto: String): Boolean;
var
  sDataInicial, sDataFinal: string;
  FSql: String;
begin
  sDataInicial:= ''''+FormatDateTime('dd.mm.yyyy', Now-30)+'''';
  sDataFinal:= ''''+FormatDateTime('dd.mm.yyyy', Now+1)+'''';
  fSql:=
       ' SELECT SUM(E.SALDOATUAL) - SUM(PI.quantpedida) AS SALDOMENOSPEDIDOS ' +
       ' FROM PEDIDOIT PI' +
       ' INNER JOIN PEDIDO P ON P.CODPEDIDO = PI.CODPEDIDO '+
       ' INNER JOIN PRODUTO PRO ON PRO.CODPRODUTO = '''+pCodProduto+''' AND PRO.CODPRODUTO = PI.CODPRODUTO '+
       ' INNER JOIN estoque E ON E.CODPRODUTO = PRO.CODPRODUTO AND E.CODFILIAL = ''01'' '+
       ' where P.situacao IN (''0'', ''1'', ''2'') AND '+
       ' P.dataentrega BETWEEN CAST('+sDataInicial+' as DATE) AND CAST('+ sDataFinal +'  AS DATE) ';
  Result:= ConFirebird.RetornaValor(fSql, 0) < 0;
end;}

function TPedidos.GetTextoPedidoAlert: String;
begin
  Result:=  'Pedido: '+ QryPedidos.FieldByName('CODPEDIDO').AsString
            + ' - ' + QryPedidos.FieldByName('NOMECLIENTE').AsString
            + sLineBreak
            +'Produto: '+QryPedidos.FieldByName('CODPRODUTO').AsString
            +' - '+QryPedidos.FieldByName('NOMEPRODUTO').AsString
            + sLineBreak
            +'Quantidade: '+QryPedidosQUANTIDADE.DisplayText
            + sLineBreak
            +'Estoque atual: '+QryPedidosEstoqueAtual.DisplayText
            +sLineBreak
            +'Transportadora: '+ QryPedidos.FieldByName('NOMETRANSPORTE').AsString;

end;

function TPedidos.GetStringDia: String;
begin
  if QryPedidosDIASPARAENTREGA.AsInteger <= 0 then
    Result:= 'hoje!'
  else if QryPedidosDIASPARAENTREGA.AsInteger = 1 then
    Result:= 'Amanhã'
  else
    Result:= FormatDateTime('dd/mm', QryPedidosDataEntrega.AsDateTime);
end;

procedure TPedidos.ShowAlertPedidoEmFalta;
begin
  dxAlertFalta.Show('Falta '+GetStringDia+'!',
                GetTextoPedidoAlert);
end;

procedure TPedidos.ShowAlertNovoPedido;
begin
  dxAlert.Show('Novo Ped. '+GetStringDia,
                GetTextoPedidoAlert);
end;

procedure TPedidos.VerificaNovosPedidos;
begin
  if not (puGerenteProducao in AppConfig.GruposUsuario) then
    Exit;

  QryPedidos.DisableControls;
  try
    QryPedidos.First;

    while not QryPedidos.Eof do
    begin
      if TblPedidosCache.Locate('CODPEDIDO;CODPRODUTO',
                                VarArrayOf([QryPedidosCODPEDIDO.AsString,QryPedidosCODPRODUTO.AsString]),
                                []) then
      begin
        if (QryPedidosEMFALTA.AsBoolean) and (TblPedidosCacheEMFALTA.AsBoolean = False) then
           ShowAlertPedidoEmFalta;

      end
     else
      begin
        if (QryPedidosEMFALTA.AsBoolean) then
          ShowAlertPedidoEmFalta
        else
          ShowAlertNovoPedido;
      end;

      QryPedidos.Next;
    end;

    TblPedidosCache.EmptyDataSet;
    TblPedidosCache.CopyDataSet(QryPedidos, [coRestart, coAppend]);
  finally
    QryPedidos.EnableControls;
  end;
end;

procedure TPedidos.LoadPedidosNew;
begin
  QryPedidos.DisableControls;
  try
    if QryPedidos.Active then
      QryPedidos.Close;

    QryPedidos.Open;

    VerificaNovosPedidos;
  finally
    QryPedidos.EnableControls;
  end;
end;

procedure TPedidos.Refresh;
begin
//  LoadPedidos(Now-30, Now+1);
  Self.LoadPedidosNew;
end;

end.
