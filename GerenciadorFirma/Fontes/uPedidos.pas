unit uPedidos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  cxLookAndFeelPainters, cxGraphics, dxSkinsCore, cxClasses, dxAlertWindow,
  Vcl.ExtCtrls;

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
    dxAlert: TdxAlertWindowManager;
    DadosUPDATEID: TIntegerField;
    DadosESTOQUEATUAL: TFloatField;
    dxAlertFalta: TdxAlertWindowManager;
    DadosEMFALTA: TBooleanField;
    Timer1: TTimer;
    procedure DataModuleCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    function GetSql(pDataInicial, pDataFinal: TDateTime): String;
    function ProdutoEmFalta(pCodProduto: String): Boolean;
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
  uDmSqlUtils, Variants;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TPedidos }

procedure TPedidos.DataModuleCreate(Sender: TObject);
begin
  Randomize;
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
  Result:= DmSqlUtils.RetornaValor(fSql, 0) < 0;
end;

procedure TPedidos.LoadPedidos(pDataInicial, pDataFinal: TDateTime);
var
  fSqlQuery: TDataSet;
  fUpdateID: Integer;
begin
  fUpdateID:= Random(999999);

  if not Dados.Active then
    Dados.CreateDataSet;

{  while not Dados.IsEmpty do
    Dados.Delete;       }

  fSqlQuery:= DmSqlUtils.RetornaDataSet(GetSql(Now-30, Now));
  try
    fSqlQuery.First;
    while not fSqlQuery.Eof do
    begin
      if Dados.Locate('CODPEDIDO;CODPRODUTO', VarArrayOf([fSqlQuery.FieldByName('CODPEDIDO').AsString,
                                              fSqlQuery.FieldByName('CODPRODUTO').AsString]), []) then
      begin
        Dados.Edit;
        DadosEMFALTA.AsBoolean:= ProdutoEmFalta(fSqlQuery.FieldByName('CODPRODUTO').AsString);

      end
     else
      begin
        Dados.Insert;

        if ProdutoEmFalta(fSqlQuery.FieldByName('CODPRODUTO').AsString) then
        begin
          dxAlertFalta.Show('Produto em falta!',
                        'Produto: '+fSqlQuery.FieldByName('NOMEPRODUTO').AsString
                        + sLineBreak +
                        'Cod. Produto: '+ fSqlQuery.FieldByName('CODPRODUTO').AsString
                        + sLineBreak +
                        'Cod. Pedido: '+ fSqlQuery.FieldByName('CODPEDIDO').AsString
                        + sLineBreak +
                        'Cliente: '+ fSqlQuery.FieldByName('NOMECLIENTE').AsString
                        + sLineBreak +
                        'Nome Transporte: '+ fSqlQuery.FieldByName('NOMETRANSPORTE').AsString);
          DadosEMFALTA.AsBoolean:= True;

        end
       else
        begin
          dxAlert.Show('Entrou novo pedido',
            'Número: '+fSqlQuery.FieldByName('CODPEDIDO').AsString);
          DadosEMFALTA.AsBoolean:= False;
        end;
      end;

      DadosUPDATEID.AsInteger:= fUpdateID;

      CopiarRecord(fSqlQuery, Dados);
      Dados.Post;

      fSqlQuery.Next;
    end;

    // Deleta os pedidos que não estão mais na lista;
    Dados.First;
    while not Dados.Eof do
    begin
      if not DadosUPDATEID.AsInteger = fUpdateID then
        Dados.Delete
       else
        Dados.Next;
    end;


  finally
    fSqlQuery.Free;
  end;
end;

procedure TPedidos.Refresh;
begin
  Pedidos.LoadPedidos(Now-30, Now+1);
end;

procedure TPedidos.Timer1Timer(Sender: TObject);
begin
  Refresh;
end;

end.
