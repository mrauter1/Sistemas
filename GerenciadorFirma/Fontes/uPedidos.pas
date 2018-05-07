unit uPedidos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TPedidos = class(TDataModule)
    Dados: TClientDataSet;
    DadosCODPRODUTO: TStringField;
    DadosNOMEPRODUTO: TStringField;
    DadosQUANTIDADE: TFloatField;
    DadosDIASPARAENTREGA: TIntegerField;
    DadosSIT: TStringField;
    DadosCODCLIENTE: TStringField;
    DadosNOMECLIENTE: TStringField;
    DadosCODTRANSPORTE: TStringField;
    DadosNOMETRANSPORTE: TStringField;
    DadosCODPEDIDO: TStringField;
    DadosQUANTPENDENTE: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
  private
    function GetSql(pDataInicial, pDataFinal: TDateTime): String;
    { Private declarations }
  public
    procedure LoadPedidos(pDataInicial, pDataFinal: TDateTime);
    procedure Filtra(const pFiltro: String);
    procedure Refresh;
  end;

var
  Pedidos: TPedidos;

implementation

uses
  uDmSqlUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TPedidos }

procedure TPedidos.DataModuleCreate(Sender: TObject);
begin
  Self.LoadPedidos(Now - 30, Now + 1);
end;

procedure TPedidos.Filtra(const pFiltro: String);
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
end;

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
        ' where P.situacao IN (''0'', ''1'', ''2'') AND '+
        ' P.dataentrega BETWEEN CAST('+sDataInicial+' as DATE) AND CAST('+ sDataFinal +'  AS DATE) '+
        ' order by PI.CODPRODUTO, SIT, DIASPARAENTREGA DESC  ';
end;

procedure TPedidos.LoadPedidos(pDataInicial, pDataFinal: TDateTime);
var
  fSqlQuery: TDataSet;
begin
  if not Dados.Active then
    Dados.CreateDataSet;

  while not Dados.IsEmpty do
    Dados.Delete;

  fSqlQuery:= DmSqlUtils.RetornaDataSet(GetSql(Now-30, Now));
  try
    CopiaDadosDataSet(fSqlQuery, Dados);
    Dados.Edit;
    DadosQUANTIDADE.AsFloat:= 0.46;
    Dados.Post;
  finally
    fSqlQuery.Free;
  end;
end;

procedure TPedidos.Refresh;
begin
  Pedidos.LoadPedidos(Now-30, Now+1);
end;

end.
