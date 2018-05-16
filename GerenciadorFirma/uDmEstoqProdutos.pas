unit uDmEstoqProdutos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, uDmSqlUtils, uFuncProbabilidades,
  Data.SqlExpr, System.Math, uFormProInfo, uFrmShowMemo, uPedidos, Vcl.ExtCtrls;

type
  TDmEstoqProdutos = class(TDataModule)
    CdsEstoqProdutos: TClientDataSet;
    CODPRODUTO: TStringField;
    ESTOQUEATUAL: TFloatField;
    ESPACOESTOQUE: TFloatField;
    DEMANDA: TFloatField;
    ROTACAO: TIntegerField;
    APRESENTACAO: TStringField;
    DEMANDADIARIA: TFloatField;
    DEMANDAC1: TFloatField;
    DIASESTOQUE: TFloatField;
    STDDEV: TFloatField;
    UNIDADEESTOQUE: TIntegerField;
    PROBFALTA: TFloatField;
    PERCENTDIAS: TFloatField;
    PROBFALTAHOJE: TFloatField;
    ESTOQMAX: TFloatField;
    PROBSAI2DIAS: TFloatField;
    CdsPedidos: TClientDataSet;
    CdsPedidosCODPRODUTO: TStringField;
    CdsPedidosQUANTIDADE: TFloatField;
    CdsPedidosDIASPARAENTREGA: TIntegerField;
    CdsPedidosSIT: TStringField;
    CdsEstoqProdutosRANK: TIntegerField;
    CdsPedidosNUMPEDIDOS: TIntegerField;
    CdsPedidosFALTA: TIntegerField;
    CdsPedidosNOMEPRODUTO: TStringField;
    MEDIASAIDA: TFloatField;
    PRODUCAOMINIMA: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    fDataSetDiasUteis: TDataSet;
    fUltimoDiasUteis, fUltimoPeriodo: Integer;
//    procedure CarregaCdsEstoqProdutos;
    procedure CalculaProbabilidades(RefreshDemanda: Boolean);
    function GetDiasUteisPeriodo(pDataIni, pDataFim: TDate): Integer;
    procedure CalculaDemanda;
    procedure CalculaProbabFaltaEmXDias(pDias: Integer);
    function EDiaUtil(pDia: TDate): Boolean;
    procedure PopulaCdsPedidos(fDataSet: TDataSet);
    procedure RankeiaProdutos;
    procedure SetInfoDefault(const pCodProduto: String);
    function GetAplicacao(const pCodProduto: String): String;
    procedure CarregaProInfo;
  public
    procedure AtualizaEstoque(RefreshDemanda: Boolean);
    procedure AtualizaPedidos;
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

function TDmEstoqProdutos.GetAplicacao(const pCodProduto: String): String;
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

procedure TDmEstoqProdutos.SetInfoDefault(const pCodProduto: String);
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
    end;

    CdsProInfo.Post;
  end;
end;

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



procedure TDmEstoqProdutos.CalculaProbabFaltaEmXDias(pDias: Integer);
const

 cSql = 'SELECT SUM(MP.quantatendida) as quantdia, M.datacomprovante FROM MCLI M '
      +' INNER JOIN MCLIPRO MP ON M.chavenf = MP.chavenf '
      +' INNER JOIN comprvtp C ON C.chavecomprovante = M.codcomprovante||''C'' AND '
      +' C.tipomovimento = ''P'' AND C.sinalestoque = ''S'' AND C.DATACOMPRAVENDA = ''S'' '
      +' WHERE MP.codproduto = ''%s'' AND M.datacomprovante BETWEEN ''%s'' AND ''%s'' '
      +'  GROUP BY M.datacomprovante '
      +'  ORDER BY M.DATACOMPROVANTE ';
var
  fNumItens, fNumDiasUteis, I: Integer;
  fDataSet: TDataSet;
  fDataBase, fDataIni, fContDia: TDateTime;
  fSoma, fSomapDias, fMedia, fVariancia: Double;
  fSaiuItem: Boolean;
begin
  fNumItens:= 0; fSoma:= 0; fVariancia:= 0;

  fDataBase:= StrToDate('25/09/2013');
  fDataIni:= fDataBase - (Rotacao.AsInteger * 7);
  fDataSet:= DmSqlUtils.RetornaDataSet(Format(cSql, [CodProduto.AsString,
                FormatDateTime('dd.mm.yyyy', fDataIni), FormatDateTime('dd.mm.yyyy', fDataBase)]));
  try
    fNumDiasUteis:= GetDiasUteisPeriodo(fDataIni, fDataBase);
  // Calcula a média de itens vendidos por dia
  {  fDataSet.First;

    while not fDataSet.Eof do
    begin
      fSoma:= fSoma + (fDataSet.FieldByName('QuantDia').AsFloat / UNIDADEESTOQUE.AsInteger);
      inc(fNumItens);
      fDataSet.Next;
    end;         }

    fDataSet.First;
    I:= 1;
    fSaiuItem:= False;
    fContDia:= fDataIni;
    repeat
      if EDiaUtil(fContDia) then begin
        if fContDia = fDataSet.FieldByName('datacomprovante').AsDateTime then begin
          fSoma:= fSoma + (fDataSet.FieldByName('QuantDia').AsFloat / UNIDADEESTOQUE.AsInteger);
          fSaiuItem:= True;
          fDataSet.Next;
        end
        else if fDataSet.FieldByName('datacomprovante').AsDateTime < fContDia then
          raise Exception.Create('Data invalida 199 '+CodProduto.AsString+' data '+FormatDateTime('dd\mm\YYYY', fDataSet.FieldByName('datacomprovante').AsDateTime));

        if I < pDias then
           inc(i)
        else
         begin
           if fSaiuItem then begin
             inc(fNumItens);
           end;
           I:= 1;
           fSaiuItem:= False;
         end;
      end;

      fContDia:= fContDia+1;
    until ((fContDia > fDataBase) or (fDataSet.Eof));
    if fSaiuItem then
      inc(fNumItens);

    if (fNumItens = 0) then begin
      Exit;
    end;

    // Media de itens que saiem a cada pDias
    fMedia:= fSoma / fNumItens;

    PercentDias.AsFloat:= (fNumItens / (fNumDiasUteis / pDias));

  // Calcula a variancia

    fDataSet.First;
    I:= 1;
    fSomapDias:= 0;
    fContDia:= fDataIni;
    repeat
      if EDiaUtil(fContDia) then begin
        if fContDia = fDataSet.FieldByName('datacomprovante').AsDateTime then begin
          fSomapDias:= fSomapDias + (fDataSet.FieldByName('QuantDia').AsFloat / UNIDADEESTOQUE.AsInteger);
          fDataSet.Next;
        end
        else if fDataSet.FieldByName('datacomprovante').AsDateTime < fContDia then
          raise Exception.Create('Data invalida 155 '+CodProduto.AsString);

        if I < pDias then
           inc(i)
        else
         begin
           fVariancia:= fVariancia + Sqr(fSomapDias - fMedia);
           fSomapDias:= 0;
           I:= 1;
         end;
      end;

      fContDia:= fContDia+1;
    until ((fContDia > fDataBase) or (fDataSet.Eof));

  // Calcula a stdDeviation
    StdDev.AsFloat:= Sqrt(fVariancia / fNumItens);

    if StdDev.AsFloat > 0 then
      PROBSAI2DIAS.AsFloat:= NormalDistQ(fMedia, StdDev.AsFloat, EstoqueAtual.AsFloat)
    else begin
      if fMedia > EstoqueAtual.AsFloat then
        PROBSAI2DIAS.AsFloat:= 1
      else
        PROBSAI2DIAS.AsFloat:= 0;
    end;

    // Calcula a probabilidade de que o produto vá sair hoje e vai faltar
    ProbFaltaHoje.AsFloat:= PROBSAI2DIAS.AsFloat * PercentDias.AsFloat;

//     StdDev.AsFloat:= Sqrt(fVariancia / fNumItens); /// UNIDADEESTOQUE.AsInteger;
//     ZDia.AsFloat:= (1 - fMedia) / StdDev.AsFloat;
//     if StdDev.AsFloat > 0 then
//       Probabilidade.AsFloat:= NormalDistQ(fMedia, StdDev.AsFloat, 1);

  finally
    fDataSet.Free;
  end;
end;

procedure TDmEstoqProdutos.CalculaProbabilidades(RefreshDemanda: Boolean);
const

 cSql = 'SELECT SUM(MP.quantatendida) as quantdia, M.datacomprovante FROM MCLI M '
      +' INNER JOIN MCLIPRO MP ON M.chavenf = MP.chavenf '
      +' INNER JOIN comprvtp C ON C.chavecomprovante = M.codcomprovante||''C'' AND '
      +' C.tipomovimento = ''P'' AND C.sinalestoque = ''S'' AND C.DATACOMPRAVENDA = ''S'' '
      +' WHERE MP.codproduto = ''%s'' AND M.datacomprovante BETWEEN ''%s'' AND ''%s'' '
      +'  GROUP BY M.datacomprovante ';
var
  fNumItens, fNumDiaUteis: Integer;
  fDataSet: TDataSet;
  fDataBase, fDataIni: TDateTime;
  fSoma, fVariancia: Double;

begin
  FormShowMemo.SetText('Calculando probabilidade de falta para o produto '+CODPRODUTO.AsString);
  if RefreshDemanda then
  begin
    fNumItens:= 0; fSoma:= 0; fVariancia:= 0;

    fDataBase:= DataSistema;
    fDataIni:= fDataBase - (Rotacao.AsInteger * 7);
    fDataSet:= DmSqlUtils.RetornaDataSet(Format(cSql, [CodProduto.AsString,
                  FormatDateTime('dd.mm.yyyy', fDataIni), FormatDateTime('dd.mm.yyyy', fDataBase)]));
    try
      fNumDiaUteis:= GetDiasUteisPeriodo(fDataIni, fDataBase);
    // Calcula a média de itens vendidos por dia
      fDataSet.First;
      while not fDataSet.Eof do
      begin
        fSoma:= fSoma + (fDataSet.FieldByName('QuantDia').AsFloat / UNIDADEESTOQUE.AsInteger);
        inc(fNumItens);
        fDataSet.Next;
      end;

      if (fNumDiaUteis = 0) or (fNumItens = 0)  then begin
        MEDIASAIDA.AsFloat:= 0;
        PercentDias.AsFloat:= 0;
      end
     else
      begin
        MEDIASAIDA.AsFloat:= fSoma / fNumItens;
        PercentDias.AsFloat:= (fNumItens / fNumDiaUteis);
      end;

    // Calcula a variancia
      fDataSet.First;
      while not fDataSet.Eof do
      begin
        fVariancia:= fVariancia +
          Sqr((fDataSet.FieldByName('QuantDia').AsFloat / UNIDADEESTOQUE.AsInteger) - MEDIASAIDA.AsFloat);
        fDataSet.Next;
      end;
    // Calcula a stdDeviation
      if fNumItens = 0 then
        StdDev.AsFloat:= 0
      else
        StdDev.AsFloat:= Sqrt(fVariancia / fNumItens);

    finally
      fDataSet.Free;
    end;
  end;

  if StdDev.AsFloat > 0 then
    ProbFalta.AsFloat:= NormalDistQ(MEDIASAIDA.AsFloat, StdDev.AsFloat, EstoqueAtual.AsFloat)
  else begin
    if MEDIASAIDA.AsFloat > EstoqueAtual.AsFloat then
      ProbFalta.AsFloat:= 1
    else
      ProbFalta.AsFloat:= 0;
  end;

  // Calcula a probabilidade de que o produto vá sair hoje e vai faltar
  ProbFaltaHoje.AsFloat:= RoundTo(ProbFalta.AsFloat * PercentDias.AsFloat, -3);

end;

procedure TDmEstoqProdutos.CalculaDemanda;
const
  cSql = 'SELECT (SUM(MP.quantatendida) / 7) AS SOMAQUANT, M.CODCLIENTE FROM MCLI M '
          +' INNER JOIN MCLIPRO MP ON M.chavenf = MP.chavenf '
          +' INNER JOIN comprvtp C ON C.chavecomprovante = M.codcomprovante||''C'' AND '
          +' C.tipomovimento = ''P'' AND C.sinalestoque = ''S'' AND C.DATACOMPRAVENDA = ''S'' '
          +' WHERE MP.codproduto = ''%s'' AND M.datacomprovante BETWEEN ''%s'' AND ''%s'' '
          +' GROUP BY M.CODCLIENTE '
          +' ORDER BY SOMAQUANT DESC ';
  cDiasValidade = 180;
var
  fDataSet: TDataSet;
  fDemandaTotal: Double;
  fDataIni, fDataBase: TDate;
begin
  FormShowMemo.SetText('Calculando demanda do produto '+CODPRODUTO.AsString);
  fDemandaTotal:= 0;
  fDataBase:= DataSistema;
  fDataIni:= fDataBase - (Rotacao.AsInteger * 7);
  fDataSet:= DmSqlUtils.RetornaDataSet(Format(cSql, [CodProduto.AsString,
                FormatDateTime('dd.mm.yyyy', fDataIni), FormatDateTime('dd.mm.yyyy', fDataBase)]));
  try
    fDataSet.First;
    DemandaC1.AsFloat:= fDataSet.FieldByName('SOMAQUANT').AsFloat / UnidadeEstoque.AsInteger;
    while not fDataSet.Eof do begin
      fDemandaTotal:= fDemandaTotal + fDataSet.FieldByName('SOMAQUANT').AsFloat;
      fDataSet.Next;
    end;

    Demanda.AsFloat:= fDemandaTotal / UnidadeEstoque.AsInteger;
    DemandaDiaria.AsFloat:= Demanda.AsFloat / Rotacao.AsInteger;

    // Se o maior cliente parar de comprar o produto dias estoque não deve ser maior que a data de validade
    EstoqMax.AsFloat:= cDiasValidade * (DemandaDiaria.AsFloat - (DemandaC1.AsFloat / Rotacao.AsInteger ));
    if FormProInfo.CdsProInfo.Locate('CODPRODUTO', CODPRODUTO.AsString, []) then
    begin
      if (FormProInfo.CdsProInfoESPACOESTOQUE.AsInteger <> 0) and
        (FormProInfo.CdsProInfoESPACOESTOQUE.AsInteger < ESTOQMAX.AsFloat) then
      begin
        ESTOQMAX.AsFloat:= FormProInfo.CdsProInfoESPACOESTOQUE.AsInteger;
      end;
    end;
  finally
    fDataSet.Free;
  end;
end;

                                    {
procedure TDmEstoqProdutos.CarregaCdsEstoqProdutos;
const
  cSql = 'SELECT E.CODPRODUTO, P.APRESENTACAO, (E.SALDOATUAL / P.UNIDADEESTOQUE) AS ESTOQUEATUAL,'
        +' (E.DM_DEMANDAREAL / P.UNIDADEESTOQUE) AS DEMANDA,'
        +' p.unidadeestoque, '
        +' (CASE WHEN e.pedidopendente - e.saldoatual > 0 then '
        +  ' (e.pedidopendente - e.saldoatual) /  p.unidadeestoque '
        +  ' ELSE 0 END) as faltaurgente, '

        +' (CASE WHEN (E.dm_demandareal / p.unidadeestoque / E.rotacao) - E.saldoatual > 0 '
        +  ' then (E.dm_demandareal / p.unidadeestoque / E.rotacao) - E.SALDOATUAL '
        +  ' ELSE 0 END) AS FALTADIA, '
        +  ' e.dm_diasdeestoque AS DIASESTOQUE, '
        +' ROTACAO, '
        +' (e.dm_falta / p.unidadeestoque) as falta '
        + 'from estoque e  '
        + ' inner join produto p on e.codproduto = p.codproduto  '
        +' WHERE DM_DEMANDAREAL > 0 and e.codfilial = ''01'' '
        +' and p.codaplicacao in (''0000'', ''0001'', ''0002'', ''0003'', ''0004'') '
        +' and (select count(ie.codproduto) from insumos_acabado ie where ie.codproduto = p.codproduto) > 0 '
        +' order by faltaurgente desc, e.dm_diasdeestoque, FALTA DESC';
var
  fDataSet: TDataSet;
  fStdDeviation, fEstoque: Double;
begin
  fDataSet:= DmSqlUtils.RetornaDataSet(cSql);
  try
    fDataSet.First;
    while not fDataSet.Eof do
    begin
      CdsEstoqProdutos.Append;
      CodProduto.AsString:= fDataSet.FieldByName('CODPRODUTO').AsString;
      Apresentacao.AsString:= fDataSet.FieldByName('APRESENTACAO').AsString;
      EstoqueAtual.AsFloat:= fDataSet.FieldByName('ESTOQUEATUAL').AsFloat;
      DiasEstoque.AsFloat:= fDataSet.FieldByName('DIASESTOQUE').AsFloat;
//      FaltaUrgente.AsFloat:= fDataSet.FieldByName('FALTAURGENTE').AsFloat;
//      Falta.AsFloat:= fDataSet.FieldByName('FALTA').AsFloat;
//      Demanda.AsFloat:= fDataSet.FieldByName('DEMANDA').AsFloat;
      Rotacao.AsInteger:= fDataSet.FieldByName('ROTACAO').AsInteger;

      UnidadeEstoque.AsInteger:= fDataSet.FieldByName('UNIDADEESTOQUE').AsInteger;

//      PedidosPendentes.AsFloat:= GetPedidosPendentes(CodProduto.AsFloat, 2);
      EspacoEstoque.AsInteger:= 30;
      CdsEstoqProdutosRANK.AsInteger:= 0;

      CalculaDemanda;
//      DemandaC1.AsFloat:= GetDemandaC1;

      CalculaProbabilidades;
//      CalculaProbabFaltaEmXDias(1);
//      fStdDeviation:= GetStdDeviation(CodProduto.AsString, Rotacao.AsInteger) / fDataSet.FieldByName('UNIDADEESTOQUE').AsInteger;
//      StdDev.AsFloat:= fStdDeviation;
//      if EstoqueAtual.AsFloat > 1 then
//        fEstoque:= EstoqueAtual.AsFloat
//      else fEstoque := 1;

      CdsEstoqProdutos.Post;
      fDataSet.Next;
    end;

  finally
    fDataSet.Free;
  end;
end;           }

procedure TDmEstoqProdutos.PopulaCdsPedidos(fDataSet: TDataSet);
var
  I: Integer;
  fFalta, fSomaQuant: Double;
  fUltimoProduto: String;
begin
  CdsPedidos.DisableControls;
  try
    CdsPedidos.First;
    while CdsPedidos.RecordCount > 0 do
      CdsPedidos.Delete;

    fUltimoProduto:= '';
    fSomaQuant:= 0;
    fDataSet.First;
    while not fDataSet.Eof do
    begin
      CdsPedidos.Append;
      CdsPedidos.FieldByName('CODPRODUTO').AsString:= fDataSet.FieldByName('CODPRODUTO').AsString;
      CdsPedidos.FieldByName('NOMEPRODUTO').AsString:= fDataSet.FieldByName('NOMEPRODUTO').AsString;
      CdsPedidos.FieldByName('QUANTIDADE').AsFloat:= fDataSet.FieldByName('QUANTIDADE').AsFloat;
      CdsPedidos.FieldByName('DIASPARAENTREGA').AsInteger:= fDataSet.FieldByName('DIASPARAENTREGA').AsInteger;
      CdsPedidos.FieldByName('SIT').AsString:= fDataSet.FieldByName('SIT').AsString;
      CdsPedidos.FieldByName('NUMPEDIDOS').AsInteger:= fDataSet.FieldByName('NUMPEDIDOS').AsInteger;

      if fUltimoProduto <> CdsPedidos.FieldByName('CODPRODUTO').AsString then begin
        fUltimoProduto:= CdsPedidos.FieldByName('CODPRODUTO').AsString;
        fSomaQuant:= 0;
      end;
      fSomaQuant:= fSomaQuant + CdsPedidos.FieldByName('QUANTIDADE').AsFloat;

      if CdsEstoqProdutos.Locate('CODPRODUTO', CdsPedidos.FieldByName('CODPRODUTO').AsString, []) then begin
        fFalta:= fSomaQuant - ESTOQUEATUAL.AsFloat;
        if fFalta < 0 then fFalta:= 0;
        CdsPedidos.FieldByName('FALTA').AsFloat:= fFalta;
      end
     else
      begin
        CdsPedidos.FieldByName('FALTA').AsFloat:= 0;
      end;
      CdsPedidos.Post;
      fDataSet.Next;
    end;

    CdsPedidos.SaveToFile('CdsPedidos.xml');
  finally
    CdsPedidos.EnableControls;
  end;
end;

procedure TDmEstoqProdutos.AtualizaPedidos;

  function GetSqlPedidos(vDiasAFrente: Integer): String;
  begin
    Result:= 'SELECT PI.CODPRODUTO, PRO.APRESENTACAO AS NOMEPRODUTO, '
        +' SUM(PI.quantpedida / PRO.UNIDADEESTOQUE) as QUANTIDADE, '
        +' count(p.codpedido) as NUMPEDIDOS, '
        +' (case when P.DATAENTREGA > '''+FormatDateTime('dd.mm.yyyy', DataSistema)+''' '
        +'   THEN CAST(P.DATAENTREGA AS DATE) - CAST('''+FormatDateTime('dd.mm.yyyy', DataSistema)+''' AS DATE) ELSE 0 END) '
        +'   AS DIASPARAENTREGA, '
        +'  (case when P.situacao = ''2'' THEN ''C'' ELSE ''P'' END) AS SIT '
        +' FROM PEDIDO P '
        +' INNER JOIN PEDIDOIT PI ON PI.codpedido = P.codpedido '
        +' INNER JOIN PRODUTO PRO ON PRO.CODPRODUTO = PI.CODPRODUTO '
        +' where P.situacao IN (''0'', ''1'', ''2'') AND '
        +' P.dataentrega BETWEEN CAST('''+FormatDateTime('dd.mm.yyyy', DataSistema)+''' as DATE) - 30 AND '
        +' CAST('''+FormatDateTime('dd.mm.yyyy', DataSistema)+''' as DATE) + CAST( '+IntToStr(vDiasAFrente)+' AS INTEGER) '
        +' GROUP BY PI.CODPRODUTO, PRO.APRESENTACAO, DIASPARAENTREGA, SIT '
        +' order by PI.CODPRODUTO, SIT, DIASPARAENTREGA, NUMPEDIDOS DESC  ';
  end;
var
  fDataIni, fDataBase: TDate;
  fSqlQuery: TDataSet;
begin
  fSqlQuery:= DmSqlUtils.RetornaDataSet(GetSqlPedidos(1));
  try
    PopulaCdsPedidos(fSqlQuery);
  finally
    fSqlQuery.Free;
  end;
end;

procedure TDmEstoqProdutos.CarregaProInfo;
begin
  FormProInfo.CdsProInfo.First;
  while not FormProInfo.CdsProInfo.Eof do begin
    if CdsEstoqProdutos.Locate('CODPRODUTO', FormProInfo.CdsProInfoCODPRODUTO.AsString, []) then
    begin
      CdsEstoqProdutos.Edit;
      PRODUCAOMINIMA.AsInteger:= FormProInfo.CdsProInfoPRODUCAOMINIMA.AsInteger;
      ESPACOESTOQUE.AsFloat:= FormProInfo.CdsProInfoESPACOESTOQUE.AsFloat;
      CdsEstoqProdutos.Post;
    end;
    FormProInfo.CdsProInfo.Next;
  end;
end;

procedure TDmEstoqProdutos.AtualizaEstoque(RefreshDemanda: Boolean);

var
  fDataSet: TDataSet;
  fStdDeviation, fEstoque: Double;
  I: Integer;

  function AlterouDataSet: Boolean;
  var
    I: Integer;
    FField: TField;
  begin
    Result:= True;

    if ESTOQUEATUAL.Value <> fDataSet.FieldByName('ESTOQUEATUAL').Value then
      Exit;

    if EspacoEstoque.Value <> FormProInfo.CdsProInfoESPACOESTOQUE.Value then
      Exit;

    if PRODUCAOMINIMA.AsInteger <> FormProInfo.CdsProInfoPRODUCAOMINIMA.AsInteger then
      Exit;

    Result:= False;
  end;

  procedure ObterConfigProdutos;
  begin
    if not FormProInfo.CdsProInfo.Locate('CODPRODUTO', fDataSet.FieldByName('CODPRODUTO').AsString, []) then
      SetInfoDefault(fDataSet.FieldByName('CODPRODUTO').AsString);

  end;

  function AtualizarDemanda: Boolean;
  begin
    Result:= RefreshDemanda or (CdsEstoqProdutos.State = dsInsert);
  end;

const
  cSql = 'SELECT E.CODPRODUTO, P.APRESENTACAO, (E.SALDOATUAL / P.UNIDADEESTOQUE) AS ESTOQUEATUAL,'
        +' (E.DM_DEMANDAREAL / P.UNIDADEESTOQUE) AS DEMANDA,'
        +' p.unidadeestoque, '
        +' (CASE WHEN e.pedidopendente - e.saldoatual > 0 then '
        +  ' (e.pedidopendente - e.saldoatual) /  p.unidadeestoque '
        +  ' ELSE 0 END) as faltaurgente, '

        +' (CASE WHEN (E.dm_demandareal / p.unidadeestoque / E.rotacao) - E.saldoatual > 0 '
        +  ' then (E.dm_demandareal / p.unidadeestoque / E.rotacao) - E.SALDOATUAL '
        +  ' ELSE 0 END) AS FALTADIA, '
        +  ' e.dm_diasdeestoque AS DIASESTOQUE, '
        +' ROTACAO, '
        +' (e.dm_falta / p.unidadeestoque) as falta '
        + 'from estoque e  '
        + ' inner join produto p on e.codproduto = p.codproduto  '
        +' WHERE DM_DEMANDAREAL > 0 and e.codfilial = ''01'' '
        +' and p.codaplicacao in (''0000'', ''0001'', ''0002'', ''0003'', ''0004'') '
        +' and (select count(ie.codproduto) from insumos_acabado ie where ie.codproduto = p.codproduto) > 0 '
        +' order by faltaurgente desc, e.dm_diasdeestoque, FALTA DESC';

begin
  CdsEstoqProdutos.IndexName:= '';

  CdsEstoqProdutos.DisableControls;
  try

  //  CarregaProInfo;
    FormShowMemo.SetText('Buscando informações dos produtos do banco de dados...');
    fDataSet:= DmSqlUtils.RetornaDataSet(cSql);
    FormShowMemo.SetText('Copiando informações do banco de dados para a memória...');
    try
      fDataSet.First;
      while not fDataSet.Eof do
      begin
        FormShowMemo.SetText('Atualizando informações do produto '+fDataSet.FieldByName('CODPRODUTO').AsString);
        // Se não houver alterações, produto não deve ser atualizado
        if AlterouDataSet = False then
        begin
          fDataSet.Next;
          Continue;
        end;

        ObterConfigProdutos;

        // Se este produto está marcado como não faz estoque, ele deve ser ignorado
        if FormProInfo.CdsProInfoNAOFAZESTOQUE.AsBoolean then
        begin
          fDataSet.Next;
          Continue;
        end;

        if CdsEstoqProdutos.Locate('CODPRODUTO', fDataSet.FieldByName('CODPRODUTO').AsString, []) then
        begin
          // Se não alterou nenhum dado, vai para o próximo registro
          if AlterouDataSet = False then
          begin
            fDataSet.Next;
            Continue;
          end;

          CdsEstoqProdutos.Edit
        end
       else
        begin
          CdsEstoqProdutos.Append;
        end;

        CopiarRecord(fDataSet, CdsEstoqProdutos);

        EspacoEstoque.AsInteger:= FormProInfo.CdsProInfoESPACOESTOQUE.AsInteger;
        PRODUCAOMINIMA.AsInteger:= FormProInfo.CdsProInfoPRODUCAOMINIMA.AsInteger;

        CdsEstoqProdutosRANK.AsInteger:= 0;

      // Verifica se houve alguma mudança nos fields
        if AtualizarDemanda then
          CalculaDemanda;

        CalculaProbabilidades(AtualizarDemanda);
  //      CalculaProbabFaltaEmXDias(1);

        CdsEstoqProdutos.Post;
        fDataSet.Next;
      end;

    finally
      fDataSet.Free;
    end;

    FormShowMemo.SetText('Ordenando produtos por prioridade de produção');
    RankeiaProdutos;

    FormShowMemo.SetText('Salvando informação dos produtos');
    CdsEstoqProdutos.SaveToFile(cArquivoCdsEstoqProdutos);
  finally
    CdsEstoqProdutos.EnableControls;
  end;
end;

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
  while not CdsEstoqProdutos.Eof do begin
    if FormProInfo.CdsProInfo.Locate('CODPRODUTO', CODPRODUTO.AsString, []) then
    begin

      // Se com a produção minima o estoque do produto passar de estoque max. não deve ser feito mais estoque do produto.
      if (Trunc(ESTOQUEATUAL.AsFloat) + FormProInfo.CdsProInfoPRODUCAOMINIMA.AsInteger) >= ESTOQMAX.AsFloat then
      begin
        CdsEstoqProdutos.Edit;
        CdsEstoqProdutosRANK.AsInteger:= 8888;
        CdsEstoqProdutos.Post;
      end;
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

procedure TDmEstoqProdutos.DataModuleCreate(Sender: TObject);
var
  FDataArquivo: TDateTime;
begin
  if FileExists(cArquivoCdsEstoqProdutos) then
  try
    if FileAge(cArquivoCdsEstoqProdutos, FDataArquivo) then
      if Trunc(FDataArquivo) = Trunc(Now) then    
        CdsEstoqProdutos.LoadFromFile(cArquivoCdsEstoqProdutos);
  except
  end;

  DataSistema:= now;//StrToDateTime('20.09.2013');
  fDataSetDiasUteis:= nil;

  CreateDataSetIfNotActive(CdsEstoqProdutos);

  CreateDataSetIfNotActive(CdsPedidos);
//  AtualizaEstoque(True);
end;


end.
