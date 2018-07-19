unit uDmEstoqProdutos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, uDmSqlUtils, uFuncProbabilidades,
  Data.SqlExpr, System.Math, uFormProInfo, uFrmShowMemo, uPedidos, Vcl.ExtCtrls, uDMCon,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TDmEstoqProdutos = class(TDataModule)
    QryEstoq: TFDQuery;
    QryEstoqCODPRODUTO: TStringField;
    QryEstoqAPRESENTACAO: TStringField;
    QryEstoqESTOQUEATUAL: TBCDField;
    QryEstoqROTACAO: TIntegerField;
    QryEstoqDEMANDAC1: TFMTBCDField;
    QryEstoqMediaSaida: TFMTBCDField;
    QryEstoqStdDev: TFloatField;
    QryEstoqDemandaDiaria: TBCDField;
    QryEstoqProbFalta: TBCDField;
    QryEstoqPercentDias: TFloatField;
    QryEstoqProbFaltaHoje: TFloatField;
    QryEstoqEstoqMaxCalculado: TFMTBCDField;
    QryEstoqESPACOESTOQUE: TIntegerField;
    QryEstoqNAOFAZESTOQUE: TBooleanField;
    QryEstoqPRODUCAOMINIMA: TIntegerField;
    QryEstoqSOMANOPESOLIQ: TBooleanField;
    QryEstoqDemanda: TFMTBCDField;
    QryEstoqDIASESTOQUE: TBCDField;
    QryEstoqFaltaConfirmada: TFMTBCDField;
    QryEstoqFaltaHoje: TFMTBCDField;
    QryEstoqFaltaTotal: TFMTBCDField;
    QryEstoqNUMPEDIDOS: TIntegerField;
    QryPedPro: TFDQuery;
    QryPedProCODPRODUTO: TStringField;
    QryPedProCODPEDIDO: TStringField;
    QryPedProDATAENTREGA: TDateField;
    QryPedProSITUACAO: TStringField;
    QryPedProNOMEPRODUTO: TStringField;
    QryPedProQUANTIDADE: TBCDField;
    QryPedProQUANTPENDENTE: TBCDField;
    QryPedProDIASPARAENTREGA: TIntegerField;
    QryPedProCODCLIENTE: TStringField;
    QryPedProNOMECLIENTE: TStringField;
    QryPedProCODTRANSPORTE: TStringField;
    QryPedProNOMETRANSPORTE: TStringField;
    QryEstoqCodAplicacao: TStringField;
    QryEstoqNOMEAPLICACAO: TStringField;
    QryEstoqRank: TLargeintField;
    procedure DataModuleCreate(Sender: TObject);
  private
    fDataSetDiasUteis: TDataSet;
    fUltimoDiasUteis, fUltimoPeriodo: Integer;

    function GetDiasUteisPeriodo(pDataIni, pDataFim: TDate): Integer;
    function EDiaUtil(pDia: TDate): Boolean;
  public
    procedure AtualizaEstoqueNew;
  end;

var
  DmEstoqProdutos: TDmEstoqProdutos;
  DataSistema: TDateTime;

const
  cArquivoCdsEstoqProdutos = 'CdsEstoqProdutos.xml';

implementation

uses
  GerenciadorUtils, Utils;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDmEstoqProdutos }

function TDmEstoqProdutos.EDiaUtil(pDia: TDate): Boolean;
begin
  if not Assigned(fDataSetDiasUteis) then
    GetDiasUteisPeriodo(pDia, pDia);

  fDataSetDiasUteis.First;
  while not fDataSetDiasUteis.Eof do
  begin
    if fDataSetDiasUteis.FieldByName('DiaUtil').AsDateTime = pDia then begin
      Result:= True;
      Exit;
    end;

    fDataSetDiasUteis.Next;
  end;

  Result:= False;
end;

function TDmEstoqProdutos.GetDiasUteisPeriodo(pDataIni, pDataFim: TDate): Integer;
const
  cSql = 'select distinct(mcli.datacomprovante) as DiaUtil'
         +' from mcli '
         +' where mcli.datacomprovante between ''%s'' AND ''%s'' ';
begin
  if (pDataFim - pDataIni) = fUltimoPeriodo then
  begin
    Result:= fUltimoDiasUteis;
  end
 else
  begin
    if Assigned(fDataSetDiasUteis) then
      FreeAndNil(fDataSetDiasUteis);

    fUltimoPeriodo:= Trunc((pDataFim - pDataIni));

    fDataSetDiasUteis:= DmSqlUtils.RetornaDataSet(Format(cSql,
                [FormatDateTime('dd.mm.yyyy', pDataIni), FormatDateTime('dd.mm.yyyy', pDataFim)]));
    try
      Result:= 0;
      fDataSetDiasUteis.First;
      while not fDataSetDiasUteis.Eof do begin
        inc(Result);
        fDataSetDiasUteis.Next;
      end;

      fUltimoDiasUteis:= Result;
    finally

    end;
  end;
end;

procedure TDmEstoqProdutos.AtualizaEstoqueNew;
begin
  QryEstoq.DisableControls;
  try

    if QryEstoq.Active then
      QryEstoq.Close;

    QryEstoq.Open;

    if QryPedPro.Active then
      QryPedPro.Close;

    QryPedPro.Open;
  finally
    QryEstoq.EnableControls;
  end;
end;

    {
procedure TDmEstoqProdutos.RankeiaProdutos;
var
  FCurRank: Integer;
  FNumPedidos: Integer;

  procedure DoRank;
  begin
    CdsEstoqProdutos.Edit;
    CdsEstoqProdutosRANK.AsInteger:= FCurRank;
    CdsEstoqProdutos.Post;
    inc(FCurRank);
  end;

  procedure RankeiaPorPedidos(ParFilter: String);
  begin
    CdsPedidos.Filter:= ParFilter;
    CdsPedidos.Filtered:= True;
    DmSqlUtils.OrdenaClientDataSet(CdsPedidos, 'NUMPEDIDOS', [ixDescending]);
    CdsPedidos.First;
    while not CdsPedidos.Eof do
    begin
      if CdsEstoqProdutos.Locate('CODPRODUTO', CdsPedidos.FieldByName('CODPRODUTO').AsString, []) then begin
        DoRank;
      end;
      CdsPedidos.Next;
    end;
  end;

begin
  CdsEstoqProdutos.First;
  while not CdsEstoqProdutos.Eof do
  begin
    CdsEstoqProdutos.Edit;
    CdsEstoqProdutosRANK.AsInteger:= 0;
    CdsEstoqProdutos.Post;
    CdsEstoqProdutos.Next;
  end;

  FCurRank:= 1;

  AtualizaPedidos;

  // Primeiro: Pega os produtos em falta confirmados para hoje
  RankeiaPorPedidos('FALTA > 0 AND DIASPARAENTREGA = 0 AND SIT = ''C'' ');

  // Segundo: Pega os produto em falta pendentes para hoje
  RankeiaPorPedidos('FALTA > 0 AND DIASPARAENTREGA = 0 AND SIT = ''P'' ');

  //Terceiro: Pega pedidos confirmados em falta para amanha
  RankeiaPorPedidos('FALTA > 0 AND DIASPARAENTREGA = 1 AND SIT = ''C'' ');

  //Quarto: Verificar se tem algum produto com falta pendente amanhã
  RankeiaPorPedidos('FALTA > 0 AND DIASPARAENTREGA = 1 AND SIT = ''P'' ');

  // Produtos com estoque atual maior que estoque max devem ficar com rank 9999
  CdsEstoqProdutos.Filtered:= False;
  CdsEstoqProdutos.Filter:= '(ESTOQUEATUAL + PRODUCAOMINIMA >= ESTOQMAX) OR ESTOQMAX < 1';
  CdsEstoqProdutos.Filtered:= True;
//  DmSqlUtils.OrdenaClientDataSet(CdsEstoqProdutos, 'PROBFALTAHOJE', [ixDescending]);
  CdsEstoqProdutos.First;
  while not CdsEstoqProdutos.Eof do begin
    CdsEstoqProdutos.Edit;
    CdsEstoqProdutosRANK.AsInteger:= 9999;
    CdsEstoqProdutos.Post;
    CdsEstoqProdutos.Next;
  end;

  // Rankeia pelos produtos com maior probabilidade de falta hoje
  CdsEstoqProdutos.Filter:= 'PROBFALTAHOJE > 0 AND RANK = 0';
  CdsEstoqProdutos.Filtered:= True;
  DmSqlUtils.OrdenaClientDataSet(CdsEstoqProdutos, 'PROBFALTAHOJE', [ixDescending]);
  CdsEstoqProdutos.First;
  while not CdsEstoqProdutos.Eof do
  begin
    FormProInfo.LocateProInfo(CODPRODUTO.AsString);

    // Se com a produção minima o estoque do produto passar de estoque max. não deve ser feito mais estoque do produto.
    if (Trunc(ESTOQUEATUAL.AsFloat) + PRODUCAOMINIMA.AsInteger) >= ESTOQMAX.AsFloat then
    begin
      CdsEstoqProdutos.Edit;
      CdsEstoqProdutosRANK.AsInteger:= 8888;
      CdsEstoqProdutos.Post;
    end;

    DoRank;
  end;

  //S Rankeia pelos dias estoque
  CdsEstoqProdutos.Filter:= 'RANK = 0';
  CdsEstoqProdutos.Filtered:= True;
  DmSqlUtils.OrdenaClientDataSet(CdsEstoqProdutos, 'DIASESTOQUE', []);
  CdsEstoqProdutos.First;
  while not CdsEstoqProdutos.Eof do begin
    DoRank;
  end;

  CdsEstoqProdutos.Filtered:= False;

  DmSqlUtils.OrdenaClientDataSet(CdsEstoqProdutos, 'RANK', []);
  CdsEstoqProdutos.First;
end;
     }
procedure TDmEstoqProdutos.DataModuleCreate(Sender: TObject);
begin
  DataSistema:= now;//StrToDateTime('20.09.2013');
  fDataSetDiasUteis:= nil;
end;


end.
