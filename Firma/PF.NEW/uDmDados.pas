unit uDmDados;

interface

uses
  System.SysUtils, System.Classes, uDmConnection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  IniFiles, Forms, uDtm_PF, Datasnap.DBClient;

type
  TDadosMovPro = record
    CodPF: String;
    Concentracao: Double;
    Densidade: Double;
    Quantidade: Double;
    UnidadeMedida: String;
  end;

  TDadosArmazenadora = record
    CNPJ: String;
    RazaoSocial: String;
    Endereco: String;
    CEP: String;
    Numero: String;
    Complemento: String;
    Bairro: String;
    UF: String;
    CodMunicipio: String;
  end;

  TDadosTransporte = record
    CNPJ: String;
    RazaoSocial: String;
  end;

  TDmDados = class(TDmConnection)
    Empresa: TFDQuery;
    ProdutoControlado: TFDQuery;
    Movimentacao: TFDQuery;
    UtilizadoProducao: TFDQuery;
    UtilizadoProducaoCodOrdemProducao: TStringField;
    UtilizadoProducaoCodModelo: TIntegerField;
    UtilizadoProducaoCodProduto: TStringField;
    UtilizadoProducaoQuantAtendida: TBCDField;
    UtilizadoProducaoQuantAtendidaInsumos: TFMTBCDField;
    UtilizadoProducaoNOMESUBUNIDADE: TStringField;
    UtilizadoProducaoPesoProduzido: TFMTBCDField;
    UtilizadoProducaoPesoInsumos: TFMTBCDField;
    UtilizadoProducaoLitrosProduzido: TFMTBCDField;
    UtilizadoProducaoLitrosInsumos: TFMTBCDField;
    CdsConfGrupo: TClientDataSet;
    DS_ConfGrupo: TDataSource;
    DS_ProdutoControlado: TDataSource;
    ProdutoControladoCODGRUPOSUB: TStringField;
    ProdutoControladoNOMESUBGRUPO: TStringField;
    ProdutoControladoCodMercosulNCM: TStringField;
    ProdutoControladoDensidade: TFMTBCDField;
    CdsErros: TClientDataSet;
    CdsErrosCodErro: TIntegerField;
    CdsErrosSecao: TStringField;
    CdsErrosMensagem: TStringField;
    ProdutoControladoCodGrupo: TStringField;
    EmpresaCODCLIENTE: TStringField;
    EmpresaCODVENDEDOR: TStringField;
    EmpresaCODVENDEDOR2: TStringField;
    EmpresaCODVENDEDOR3: TStringField;
    EmpresaCODREGIAO: TStringField;
    EmpresaCODSUBREGIAO: TStringField;
    EmpresaCODROTEIRO: TStringField;
    EmpresaCODROTEIROSUB: TStringField;
    EmpresaCODTIPOCLI: TStringField;
    EmpresaFILIALCLIENTE: TStringField;
    EmpresaSITUACAOCLI: TStringField;
    EmpresaCLASSECLI: TStringField;
    EmpresaNOMECLIENTE: TStringField;
    EmpresaRAZAOSOCIAL: TStringField;
    EmpresaBAIRRO: TStringField;
    EmpresaCIDADE: TStringField;
    EmpresaESTADO: TStringField;
    EmpresaCODIGOPOSTAL: TStringField;
    EmpresaNUMEROCGCMF: TStringField;
    EmpresaNUMEROINSC: TStringField;
    EmpresaNUMEROISSQN: TStringField;
    EmpresaNUMEROCPF: TStringField;
    EmpresaPESSOA: TStringField;
    EmpresaCODBANCO: TStringField;
    EmpresaPRACACIDADE: TStringField;
    EmpresaPRACAESTADO: TStringField;
    EmpresaPRACACEP: TStringField;
    EmpresaENTREGACIDADE: TStringField;
    EmpresaENTREGAESTADO: TStringField;
    EmpresaENTREGACEP: TStringField;
    EmpresaCODTRANSPORTADORA: TStringField;
    EmpresaLIMITECREDITO: TBCDField;
    EmpresaCODCONDICAO: TStringField;
    EmpresaDATAULTIMACOMPRA: TDateField;
    EmpresaDATAINCLUSAO: TDateField;
    EmpresaCODLISTAPRECO: TStringField;
    EmpresaTEMCONVENIO: TStringField;
    EmpresaOBSERVACAO: TMemoField;
    EmpresaCLISENTOICM: TStringField;
    EmpresaCLISENTOSUBST: TStringField;
    EmpresaCLISENTOIPI: TStringField;
    EmpresaCONTRIBUINTE: TStringField;
    EmpresaCONTRIBUINTEBOX: TStringField;
    EmpresaCLISENTOICM8702: TStringField;
    EmpresaOBSDANOTA: TStringField;
    EmpresaCODDOMEDICO: TStringField;
    EmpresaDIAMAISVENCIMENTO: TIntegerField;
    EmpresaCODIGOAUXILIAR: TStringField;
    EmpresaPRACABAIRRO: TStringField;
    EmpresaENTREGABAIRRO: TStringField;
    EmpresaCOBRABLOQUETO: TStringField;
    EmpresaDESCONTODECANAL: TBCDField;
    EmpresaMICROEMPRESA: TStringField;
    EmpresaSIMPLESESTADUAL: TStringField;
    EmpresaTIPOFRETECLI: TStringField;
    EmpresaNAOPROTESTAR: TStringField;
    EmpresaINCLUIDOVIAPALM: TStringField;
    EmpresaDESATIVADIASCOMPRA: TIntegerField;
    EmpresaLOGRADOURO: TStringField;
    EmpresaLOGNUMERO: TStringField;
    EmpresaLOGCOMPL: TStringField;
    EmpresaPRACALOGRADOURO: TStringField;
    EmpresaPRACALOGNUMERO: TStringField;
    EmpresaPRACALOGCOMPL: TStringField;
    EmpresaENTREGALOGRADOURO: TStringField;
    EmpresaENTREGALOGNUMERO: TStringField;
    EmpresaENTREGALOGCOMPL: TStringField;
    EmpresaENDERECO: TStringField;
    EmpresaPRACAENDERECO: TStringField;
    EmpresaENTREGAENDERECO: TStringField;
    EmpresaCODCLIENTEMATRIZ: TStringField;
    EmpresaCLISENTOPISCOFINS: TStringField;
    EmpresaCODPAIS: TStringField;
    EmpresaDATAVENCELIMITE: TDateField;
    EmpresaPEDIDOMINIMO: TBCDField;
    EmpresaCODCOMPROVANTE: TStringField;
    EmpresaDATAALTERACAO: TSQLTimeStampField;
    EmpresaCODVENDEDOR4: TStringField;
    EmpresaCODVENDEDOR5: TStringField;
    EmpresaNUMEROSUFRAMA: TStringField;
    EmpresaDESCONTAICMSPRO_SN: TStringField;
    EmpresaNIVEL_TABELA_PISCOF: TStringField;
    EmpresaINDPRES: TSmallintField;
    EmpresaIDESTRANGEIRO: TStringField;
    EmpresaCONSUMIDOR_FINAL: TIntegerField;
    EmpresaINDIEDEST: TSmallintField;
    EmpresaEXCEDEU_SUBLIMITE_SIMPLES_SN: TStringField;
    CdsConfGrupoCodGrupoSub: TStringField;
    CdsConfGrupoNomeSubGrupo: TStringField;
    CdsConfGrupoConcentracao: TFloatField;
    MovimentacaoENTRADASAIDA: TStringField;
    MovimentacaoCHAVENF: TStringField;
    MovimentacaoNumero: TStringField;
    MovimentacaoDataComprovante: TDateField;
    MovimentacaoNUMEROCGCMF: TStringField;
    MovimentacaoRAZAOSOCIAL: TStringField;
    MovimentacaoCODTRANSPORTADORA: TStringField;
    MovimentacaoNomeSubUnidade: TStringField;
    MovimentacaoCodAplicacao: TStringField;
    MovimentacaoCodGrupoSub: TStringField;
    MovimentacaoCodProduto: TStringField;
    MovimentacaoQuantatendida: TBCDField;
    MovimentacaoUNIDADEESTOQUE: TIntegerField;
    CdsConfGrupoDensidade: TFMTBCDField;
    CdsConfGrupoCodPF: TStringField;
    Armazenadora: TFDQuery;
    ArmazenadoraCodCliente: TStringField;
    ArmazenadoraRAZAOSOCIAL: TStringField;
    ArmazenadoraCNPJ: TStringField;
    ArmazenadoraEndereco: TStringField;
    ArmazenadoraNumero: TStringField;
    ArmazenadoraComplemento: TStringField;
    ArmazenadoraBairro: TStringField;
    ArmazenadoraEstado: TStringField;
    ArmazenadoraMunicipio: TStringField;
    MovimentacaoCodCliFor: TStringField;
    ArmazenadoraCodIBGE: TMemoField;
    Transporte: TFDQuery;
    TransporteNOMETRANSPORTE: TStringField;
    TransporteCNPJ: TMemoField;
    ArmazenadoraCEP: TMemoField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSqlProdutoControlado, FSqlUtilizadoProducao, FSqlMovimentacao, FSqlMovimentoCompraPro: String;
    procedure CarregaMovimentacao;
    procedure CarregaProdutoControlado;
    procedure AbrirConfGrupo;
    procedure CarregaLista(Par_Lista: TStringList; Par_Ident,
      Par_Default: String);
    procedure CarregaListaGrupos;
    procedure ErroCubagem;
    procedure ErroDensidade(Densidade: Double);
    function GetCodGrupo(pCodGrupo: String): String;
    function GetConcDefault(Cod: String): Double;
    function GetCubagem(CodPro: String): Double;
    function GetDensidade(CodGrupoSub: String): Double;
    function ListaParaSql(Campo: String; Lista: TStringList): String;
    function SubstituiPalavraChave(Sql, PalavraChave, Campo: String;
      Lista: TStringList): String;
    function TransporteProprio(CodTransportadora: String): Boolean;
    function MascaraNCM(pNCM: String): String;
  public
    ListaComprovVenda, ListaComprovCompra, ListaTransp, ListaGrupos: TStringList;
    DataIni, DataFim: TDate;
    procedure RecarregarDataSets;
    procedure AtualizaConfGrupoAtual;
    function NomeSubGrupo(pCodGrupoSub: String): String;
    procedure RevalidaConfGrupos;
    procedure CarregaListas;
    procedure SalvarCdsConfPro;
    function ObterDadosMovPro: TDadosMovPro;
    function ObterDadosArmazenadora: TDadosArmazenadora;
    function ObterDadosTransporte(pCodTransporte: String): TDadosTransporte;
    function GetConc(Cod: String): Double;
    function GetCodPF(Cod: String): String;
  end;

var
  DmDados: TDmDados;

const
  cComprovVendaPadrao = '001, 002, 003, 007, 019, 027, 035, 040, 042, 102';
  cComprovCompraPadrao = '005, 006, 010, 030, 065';
  cGruposPadrao = '0010018, 0010026, 0010002, 0010000';
  cTranspPadrao = '001612, 001640, 001650';
  cConfGrupoXml = 'ConfGrupo.xml';

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  Utils, System.Variants;

{ TDmDados }

function TDmDados.MascaraNCM(pNCM: String): String;
begin
  if pNCM.Length <> 8 then
    raise Exception.Create('TDmDados.MascaraNCM´: Tamanho do NCM inválido!');

  Result:= Copy(pNCM, 0, 4)+'.'+Copy(pNCM, 5, 2)+'.'+Copy(pNCM, 7, 2);
end;

function TDmDados.ObterDadosTransporte(pCodTransporte: String): TDadosTransporte;
begin
  Transporte.Close;
  Transporte.ParamByName('CODTRANSPORTE').AsString:= pCodTransporte;
  Transporte.Open;

  Result.CNPJ:= TransporteCNPJ.AsString;
  Result.RazaoSocial:= TransporteNOMETRANSPORTE.AsString;
end;

//function TDmDados.ObterDadosArmazenadora(pCodCliente: String): TDadosArmazenadora;
// Armazenador é a Rauter - Endereço de origem da mercadoria
function TDmDados.ObterDadosArmazenadora: TDadosArmazenadora;
begin
  Armazenadora.Close;
  Armazenadora.ParamByName('CODCLIENTE').AsString:= '010000';
  Armazenadora.Open;

  if Armazenadora.IsEmpty then
    raise Exception.Create('TDmDados.ObterDadosArmazenadora: Cliente não encontrado, código: '+Armazenadora.ParamByName('CODCLIENTE').AsString);

  Result.CNPJ:= ArmazenadoraCNPJ.AsString;
  Result.RazaoSocial:= ArmazenadoraRAZAOSOCIAL.AsString;
  Result.Endereco:= ArmazenadoraEndereco.AsString;
  Result.CEP:= ArmazenadoraCEP.AsString;
  Result.Numero:= ArmazenadoraNumero.AsString;
  Result.Complemento:= ArmazenadoraComplemento.AsString;
  Result.Bairro:= ArmazenadoraBairro.AsString;
  Result.UF:= ArmazenadoraEstado.AsString;
  Result.CodMunicipio:= ArmazenadoraCodIBGE.AsString;
end;

function TDmDados.ObterDadosMovPro: TDadosMovPro;
var
  FCodGrupoSub: String;
  FQuantidade: Double;
  FUnidadeMedida: String;
  FTipoPro: String;

  procedure RetornaQuantEUnidade(out Quant: Double; out Unidade: String);
  const
    cSql = 'DECLARE @NomeSubUnidade varchar(max) = ''%s'' '+
           'SELECT CASE WHEN dbo.SubUnidadeLitro(@NomeSubUnidade)=1 then ''L'' WHEN dbo.SubUnidadeQuilo(@NomeSubUnidade)=1 then ''K'' ELSE ''N'' END';
  var
    fUnidade: String;
    Multiplicador: Double;
  begin
    fUnidade:= RetornaValor(Format(cSql, [MovimentacaoNomeSubUnidade.AsString]), 'N');
    if fUnidade = 'N' then
    begin
      Unidade:= 'L';

      case MovimentacaoCodAplicacao.AsInteger of
         0: Multiplicador:= 200;
         1: Multiplicador:= 100;
         2: Multiplicador:= 18;
         3: Multiplicador:= 5;
         4: Multiplicador:= 4;
         6: Multiplicador:= 50;
         5: Multiplicador:= 20;
         10,1052: Multiplicador:= 1000;
         30: Multiplicador:= 60;
         47,12: Multiplicador:= 30;
         1030: begin
           Multiplicador:= Result.Densidade;
           Unidade:= 'K';
         end;
         1031,11,9: Multiplicador:= 1;
         else
         begin
           Multiplicador:= 0;
           CdsErros.Insert;
           CdsErrosCodErro.AsInteger:= 1;
           CdsErrosSecao.AsString:= 'MM';
           CdsErrosMensagem.AsString:= 'Produto cód: '+MovimentacaoCODPRODUTO.AsString+' com únidade desconhecida!';
           CdsErros.Post;
         end;
      end;
      Quant:= MovimentacaoQUANTATENDIDA.AsFloat / MovimentacaoUNIDADEESTOQUE.AsFloat * Multiplicador;
    end
   else
    begin
      Quant:= MovimentacaoQUANTATENDIDA.AsFloat;
      Unidade:= fUnidade;
    end;
  end;

begin
  FCodGrupoSub:= DmDados.MovimentacaoCodGrupoSub.AsString;

  if not ProdutoControlado.Locate('CODGRUPOSUB', FCodGrupoSub, [loCaseInsensitive]) then
    raise Exception.Create('TDmDados.ObterDadosMovPro: Grupo não encontrado: '+FCodGrupoSub);

  if ProdutoControladoCodGrupo.AsString = '001' then
    FTipoPro:= 'PR' // Produto controlado puro
  else if ProdutoControladoCodGrupo.AsString = '002' then
    FTipoPro:= 'PC'; // Produto Composto

  with Result do
  begin
    CodPF:= GetCodPF(FCodGrupoSub); {NCM}

    Concentracao:= GetConc(FCodGrupoSub);
    Densidade:= GetDensidade(FCodGrupoSub);

    RetornaQuantEUnidade(FQuantidade, FUnidadeMedida);
    Quantidade:= FQuantidade;
    UnidadeMedida:= FUnidadeMedida;
  end;
end;

procedure TDmDados.RevalidaConfGrupos;
begin
  CdsConfGrupo.First;
  while not CdsConfGrupo.Eof do
  begin
    CdsConfGrupo.Edit;
    AtualizaConfGrupoAtual;

    CdsConfGrupo.Post;

    CdsConfGrupo.Next;
  end;
end;

function TDmDados.NomeSubGrupo(pCodGrupoSub: String): String;
begin
  Result:= VarToStrDef(RetornaValor('SELECT NOMESUBGRUPO FROM GRUPOSUB WHERE CODGRUPOSUB = '+QuotedStr(pCodGrupoSub)), '');
end;

procedure TDmDados.AtualizaConfGrupoAtual;
begin
  CdsConfGrupoNomeSubGrupo.AsString:= NomeSubGrupo(CdsConfGrupoCodGrupoSub.AsString);
  if CdsConfGrupoConcentracao.IsNull then
    CdsConfGrupoConcentracao.AsFloat:= GetConcDefault(CdsConfGrupoCodGrupoSub.AsString);

  if (ProdutoControlado.Active) and (CdsConfGrupoDensidade.AsFloat = 0) then
      if ProdutoControlado.Locate('CODGRUPOSUB', CdsConfGrupoCodGrupoSub.AsString, []) then
        CdsConfGrupoDensidade.AsFloat:= ProdutoControladoDensidade.AsFloat;
end;


procedure TDmDados.AbrirConfGrupo;
var
  I: Integer;
  FListaGrupos: TStringList;
  FCds: TClientDataSet;
begin
  if not CdsConfGrupo.Active then
    CdsConfGrupo.CreateDataSet;

  if FileExists(cConfGrupoXml) then
  try
    FCds:= TClientDataSet.Create(Self);
    try
      FCds.LoadFromFile(cConfGrupoXml);
      CopyRecordsDataSet(FCds, CdsConfGrupo);
    finally
      FCds.Free;
    end;
  except
  end;

  if CdsConfGrupo.IsEmpty then
  begin // Se não tiver configuração salva, carrega grupos salvos anteriormento ou padrão
    FListaGrupos:= TStringList.Create;
    try
      CarregaLista(FListaGrupos, 'GRUPOS', cGruposPadrao);

      for I := 0 to FListaGrupos.Count-1 do
      begin
        CdsConfGrupo.Insert;
        CdsConfGrupoCodGrupoSub.AsString:= FListaGrupos[I];
        CdsConfGrupo.Post;
      end;
    finally
      FListaGrupos.Free;
    end;
  end;

  RevalidaConfGrupos;
end;

procedure TDmDados.RecarregarDataSets;
begin
  Empresa.Open;

  CarregaListas;

  CarregaProdutoControlado;

  CarregaMovimentacao;
end;

procedure TDmDados.CarregaProdutoControlado;
var
  fSql: String;
begin
  ProdutoControlado.Close;
  fSql:= FSqlProdutoControlado;
  fSql:= SubstituiPalavraChave(fSql, '/*Grupos*/', 'p.CodGrupoSub', ListaGrupos);
  ProdutoControlado.SQL.Text:= fSql;
  ProdutoControlado.Open;
end;

procedure TDmDados.CarregaMovimentacao;
var
  fSql: String;
  sData: String;
begin
  sData:= ' and M.DataComprovante between '+Func_Date_SqlServer(DataIni)+' and '+Func_Date_SqlServer(DataFim);

  Movimentacao.Close;
  fSql:= FSqlMovimentacao;
  fSql:= SubstituiPalavraChave(fSql, '/*Grupos*/', 'P.CodGrupoSub', ListaGrupos);
  fSql:= SubstituiPalavraChave(fSql, '/*ComprovantesVenda*/', 'M.CodComprovante', ListaComprovVenda);
  fSql:= SubstituiPalavraChave(fSql, '/*ComprovantesCompra*/', 'M.CodComprovante', ListaComprovCompra);
  fSql:= StringReplace(fSql, '/*Data*/', sData, [rfReplaceAll, rfIgnoreCase]);
  Movimentacao.SQL.Text:= fSql;
  Movimentacao.Open;
end;

procedure TDmDados.DataModuleCreate(Sender: TObject);
begin
  CarregaConnectionInfo('Banco.Ini', 'SQLSERVER');

  inherited;
  FSqlProdutoControlado:= ProdutoControlado.SQL.Text;
  FSqlUtilizadoProducao:= UtilizadoProducao.SQL.Text;
  FSqlMovimentacao:= Movimentacao.SQL.Text;

  ListaComprovVenda:= TStringList.Create;
  ListaComprovCompra:= TStringList.Create;
  ListaTransp:= TStringList.Create;
  ListaGrupos:= TStringList.Create;

//  WriteLog('Carregando Configuração dos Grupos');
  AbrirConfGrupo;

  RecarregarDataSets;

  RevalidaConfGrupos;
end;


procedure TDmDados.DataModuleDestroy(Sender: TObject);
begin
  ListaComprovVenda.Free;
  ListaComprovCompra.Free;
  ListaTransp.Free;
  ListaGrupos.Free;

  inherited;
end;

function TDmDados.TransporteProprio(CodTransportadora: String): Boolean;
var
  I: Integer;
begin
  for I := 0 to ListaTransp.Count - 1 do
  begin
    if CodTransportadora = Trim(ListaTransp[I]) then
    begin
      Result:= True;
      Exit;
    end;
  end;
  Result:= False;
end;

procedure TDmDados.CarregaLista(Par_Lista: TStringList; Par_Ident: String; Par_Default: String);
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'Config.Ini') then
  begin
    ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Config.Ini');
    Par_Lista.CommaText :=
        ArqIni.ReadString('Config', Par_Ident, Par_Default);
    ArqIni.Free;
  end
 else
  begin
    Par_Lista.CommaText:= Par_Default;
  end;
end;

procedure TDmDados.CarregaListaGrupos;
begin
  CdsConfGrupo.First;
  ListaGrupos.Clear;
  while not CdsConfGrupo.EOF do
  begin
    ListaGrupos.Add(CdsConfGrupoCodGrupoSub.AsString);

    CdsConfGrupo.Next;
  end;
end;

procedure TDmDados.CarregaListas;
begin
  CarregaListaGrupos;
  CarregaLista(ListaComprovVenda, 'COMPROVANTESVENDA', cComprovVendaPadrao);
  CarregaLista(ListaComprovCompra, 'COMPROVANTESCOMPRA', cComprovCompraPadrao);
  CarregaLista(ListaTransp, 'TRANSP', cTranspPadrao);
end;

function TDmDados.SubstituiPalavraChave(Sql, PalavraChave, Campo: String; Lista: TStringList): String;
begin
  Result:= StringReplace(Sql, PalavraChave, ListaParaSql(Campo, Lista), [rfReplaceAll, rfIgnoreCase]);
end;

function TDmDados.ListaParaSql(Campo: String; Lista: TStringList): String;
var
  fStr: String;
  fSql: String;
begin
  fSql:= '';

  for fStr in Lista do
    if fSql = '' then
      fSql:= QuotedStr(fStr)
    else
      fSql:= fSql+', '+ QuotedStr(fStr);

  if fSql = '' then
    fSql:= '''''';

  Result:= ' AND '+Campo+' in ('+fSql+') ';
end;

function TDmDados.GetCodPF(Cod: String): String;
begin
  Result:= '';
  if CdsConfGrupo.Locate('CODGRUPOSUB', Cod, [loCaseInsensitive]) then
    Result:= CdsConfGrupoCodPF.AsString.Trim;

  if Result = '' then
    raise Exception.Create('TDmDados.GetDadosPF: Código PF não informado para o Grupo: '+Cod);
end;

function TDmDados.GetConc(Cod: String): Double;
begin
  if CdsConfGrupo.Locate('CODGRUPOSUB', Cod, [loCaseInsensitive]) then
    if not CdsConfGrupoConcentracao.IsNull then
    begin
      Result:= CdsConfGrupoConcentracao.AsFloat;
      Exit;
    end;

  Result:= GetConcDefault(Cod);
end;


function TDmDados.GetConcDefault(Cod: String): Double;
begin
  if (Cod = '0010000') or (Cod = '0020218') then Result:= 99.5  //Acetona
  else if Cod = '0010008' then Result:= 99.5 //ClorMetil
  else if Cod = '0010018' then Result:= 99.5 //MetilEtilCet
  else if Cod = '0010026' then Result:= 99.5 //Tol
  else if Cod = '0010007' then Result:= 99//CicloHex
  else if Cod = '0010002' then Result:= 99.93 //AcetEtil
  else if Cod = '0010010' then Result:= 99.28 //DiacetonaAlc
  else if Cod = '0010001' then Result:= 99 //AcetBut
  else if Cod = '0010019' then Result:= 99.57 //MIBK
  else if Cod = '0010012' then Result:= 65 //Isa4
  else if Cod = '0010030' then Result:= 99.5 //AcetAm
  else if Cod = '0010031' then Result:= 99 //Butanol
  else if Cod = '0010035' then Result:= 99.8 //SecButanol
  else Result:= 0; //Thinner

end;

function TDmDados.GetCubagem(CodPro: String): Double;
begin
  raise Exception.Create('TDmDados.GetCubagem');
end;

function TDmDados.GetDensidade(CodGrupoSub: String): Double;
begin
  Result:= 0;

  if CdsConfGrupo.Locate('CODGRUPOSUB', CodGrupoSub, [loCaseInsensitive]) then
    Result:= CdsConfGrupoDensidade.AsFloat;

  if not ProdutoControlado.Locate('CODGRUPOSUB', CodGrupoSub, [loCaseInsensitive]) then
    raise Exception.Create('TDmDados.GetDensidade: Grupo não encontrado: '+CodGrupoSub);

  Result:= ProdutoControladoDensidade.AsFloat;
  if Result = 0 then
    raise Exception.Create('TDmDados.GetDensidade: Densidade do Grupo '+CodGrupoSub+' não informada!');
end;

procedure WriteLog(Par_Texto: String);
begin
  Utils.WriteLog('Log.txt', Par_Texto);
end;

procedure TDmDados.ErroCubagem;
begin
  raise Exception.Create('Cubagem do produto código: '+'CDS_ProCODPRODUTO.AsString'+' está cadastrada como zero. '+
   'Arrumar cubagem do produto antes de continuar!');
end;

procedure TDmDados.ErroDensidade(Densidade: Double);
begin
  raise Exception.Create('Densidade calculada para o produto código: '+'CDS_ProCODPRODUTO.AsString'+' é impossível: '+
   FloatToStr(Densidade)+'. Arrumar cubagem ou peso do produto antes de continuar!');
end;

{
function TDmDados.GetDensidade: Double;
begin
  Result:= 0;
  if CDS_ProCUBAGEM.AsFloat = 0 then
  begin
    ErroCubagem;
  end
  else begin
    Result:= CDS_ProPESO.AsFloat / (CDS_ProCUBAGEM.AsFloat * 1000);
    if (Result > 5) or (Result < 0.1) then
    begin
      ErroDensidade(Result);
    end;
  end;
end;                                    }

function TDmDados.GetCodGrupo(pCodGrupo: String): String;
begin
  if pCodGrupo = '0010000' then
    Result:= '''0010000'', ''0010000'''
  else
    Result:= ''''+pCodGrupo+'''';

end;

procedure TDmDados.SalvarCdsConfPro;
begin
  CdsConfGrupo.SaveToFile(cConfGrupoXml, dfXml);
end;

end.
