unit uDtm_PF;

interface

uses
  SysUtils, Classes,  DB, SqlExpr, FMTBcd, DBClient, Provider, Controls, IniFiles, Forms,
  Data.DBXInterBase, Data.DBXFirebird, Dialogs;

type
  TDtm_PF = class(TDataModule)
    Connection: TSQLConnection;
    DTS_Pro: TDataSetProvider;
    CDS_Pro: TClientDataSet;
    DS_Pro: TDataSource;
    SQL_Pro: TSQLQuery;
    DTS_Cli: TDataSetProvider;
    CDS_CliCODCLIENTE: TStringField;
    CDS_CliRAZAOSOCIAL: TStringField;
    CDS_CliENDERECO: TStringField;
    CDS_CliCIDADE: TStringField;
    CDS_CliESTADO: TStringField;
    CDS_CliCODIGOPOSTAL: TStringField;
    CDS_CliNUMEROCGCMF: TStringField;
    CDS_Cli: TClientDataSet;
    DS_Cli: TDataSource;
    CDS_Estoque: TClientDataSet;
    CDS_EstoqueCODPRODUTO: TStringField;
    CDS_EstoqueSALDOATUAL: TFMTBCDField;
    CDS_EstoqueCODANOMES: TStringField;
    CDS_EstoqueCODGRUPOSUB: TStringField;
    CDS_EstoqueCUBAGEM: TFMTBCDField;
    CDS_EstoqueUNIDADEESTOQUE: TIntegerField;
    DTS_Estoque: TDataSetProvider;
    SQL_Estoque: TSQLQuery;
    SQL_QTCompra: TSQLQuery;
    CDS_QTVenda: TClientDataSet;
    DTS_QTVenda: TDataSetProvider;
    SQL_QTVenda: TSQLQuery;
    CDS_QTVendaCODPRODUTO: TStringField;
    CDS_QTVendaQUANT: TFMTBCDField;
    CDS_QTVendaCHAVENF: TStringField;
    CDS_QTCompra: TClientDataSet;
    CDS_QTCompraCHAVENFPRO: TStringField;
    CDS_QTCompraCODPRODUTO: TStringField;
    CDS_QTCompraCHAVENF: TStringField;
    CDS_QTCompraQUANTATENDIDA: TFMTBCDField;
    DTS_QTCompra: TDataSetProvider;
    CDS_ProCODPRODUTO: TStringField;
    CDS_ProCODGRUPOSUB: TStringField;
    CDS_ProAPRESENTACAO: TStringField;
    CDS_ProUNIDADE: TStringField;
    CDS_ProUNIDADEESTOQUE: TIntegerField;
    CDS_ProPESO: TFMTBCDField;
    CDS_ProCUBAGEM: TFMTBCDField;
    DTS_MCli: TDataSetProvider;
    CDS_MCli: TClientDataSet;
    SQL_MCli: TSQLQuery;
    CDS_MCliNUMERO: TStringField;
    CDS_MCliDATADOCUMENTO: TDateField;
    CDS_MCliCHAVENFPRO: TStringField;
    CDS_MCliCHAVENF: TStringField;
    CDS_MCliCODPRODUTO: TStringField;
    CDS_MCliUNIDADEESTOQUE: TIntegerField;
    CDS_MCliQUANTATENDIDA: TFMTBCDField;
    DTS_MFor: TDataSetProvider;
    CDS_MFor: TClientDataSet;
    SQL_MFor: TSQLQuery;
    CDS_MForCHAVENF: TStringField;
    CDS_MForDATACOMPROVANTE: TDateField;
    CDS_MForDATAENTRADA: TDateField;
    CDS_MForCODPRODUTO: TStringField;
    CDS_MForUNIDADEESTOQUE: TIntegerField;
    CDS_MForQUANT: TFMTBCDField;
    CDS_MForNUMERO: TStringField;
    DS_MCli: TDataSource;
    DS_MFor: TDataSource;
    CDS_MCliCODCLIENTE: TStringField;
    CDS_MForCODFORNECEDOR: TStringField;
    CDS_MCliCODTRANSPORTADORA: TStringField;
    CDS_MForTRANCODTRANSPORTE: TStringField;
    DTS_Sub_Gru: TDataSetProvider;
    CDS_Sub_Gru: TClientDataSet;
    SQL_Sub_Gru: TSQLQuery;
    CDS_Sub_GruCODGRUPOSUB: TStringField;
    CDS_Sub_GruCODGRUPO: TStringField;
    Tbl_Cli: TSQLQuery;
    Aux: TSQLQuery;
    CDS_ProCODMERCOSULNCM: TStringField;
    CDS_MForCODFISCALPRO: TStringField;
    CDS_MCliCODFISCALPRO: TStringField;
    CdsConfGrupo: TClientDataSet;
    CdsConfGrupoCodGrupoSub: TStringField;
    CdsConfGrupoNomeGrupoSub: TStringField;
    CdsConfGrupoConcentracao: TFloatField;
    DS_ConfGrupo: TDataSource;
    procedure FiltraMCli(CodPro, Order: String);
    procedure FiltraMFor(CodPro, Order: String);
    procedure DataModuleCreate(Sender: TObject);
    procedure FiltraEst(Grupo: Boolean; AnoMes: TDate; Cod: String);
    procedure Filtra_Sub_Gru(CodGrupo: String);
    function CodTransp(CodTransp: String): String;
    function QTCompra(Grupo: Boolean; Data: TDate; CodPro: String): Double;
    function QTVenda(Grupo: Boolean; Data: TDate; CodPro: String): Double;
//    function QTProF(Data: TDate): Double;
    procedure SQL_ProBeforeOpen(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FListaComprov, FListaTransp: TStringList;
    procedure ErroCubagem;
    procedure ErroDensidade(Densidade: Double);
    procedure CarregaLista(Par_Lista: TStringList; Par_Ident: String; Par_Default: String);
    procedure AbrirConfGrupo;
    procedure RevalidaConfGrupos;

    function GetConcDefault(Cod: String): Double;
    function GetCodGrupo(pCodGrupo: String): String;
  public
    NotasTranspProprio: TStringList;
    procedure CarregaComprovantes;
    procedure CarregaGrupos;
    procedure CarregaTransp;
    procedure RecarregaDataSets;
    function GetDensidade: Double;
    function GetCubagem(CodPro: String): Double;
    procedure GetUnidadeEQuant(CodPro: String; var Quant: Double; var Unidade: String);
    function MCLIQuantLitros: Double;
    function MFORQuantLitros: Double;
    function NumeroCGCMFCli(CodCliente: String): String;
    function UFCli(CodCliente: String): String;
    function NumeroCGCMFFor(CodFornecedor: String): String;
    function NomeGrupoSub(CodGrupoSub: String): String;
    function Telefone(CodCliente: String): String;
    function TransporteProprio(CodTransportadora: String): Boolean;
    procedure FiltraNota(const ChaveNFPro: String);
    procedure AtualizaConfGrupoAtual;
    procedure SalvarCdsConfPro;

    function GetConc(Cod: String): Double;

    function RetornaValorDef(Par_Sql: String; Par_Default: Variant): Variant;
  end;

const
  cComprovPadrao = '001, 002, 003, 007, 019, 027, 035, 040, 042, 102';
  cGruposPadrao = '0010000, 0020218, 0010008, 0010018, 0010026, 0010007, 0010002, 0010010, 0010001, 0010019, 0010012, 0010030, 0010031, 0010035';
  cTranspPadrao = '001612, 001640, 001650';

  cConfGrupoXml = 'ConfGrupo.xml';

var
  Dtm_PF: TDtm_PF;
  Ini: TDateTime;
  Fim: TDateTime;

implementation

uses DateUtils, Utils;

{$R *.dfm}

function TDtm_PF.GetConc(Cod: String): Double;
begin
  if CdsConfGrupo.Locate('CODGRUPOSUB', Cod, [loCaseInsensitive]) then
    if not CdsConfGrupoConcentracao.IsNull then
    begin
      Result:= CdsConfGrupoConcentracao.AsFloat;
      Exit;
    end;

  Result:= GetConcDefault(Cod);
end;

function TDtm_PF.GetConcDefault(Cod: String): Double;
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

procedure WriteLog(Par_Texto: String);
begin
  Utils.WriteLog('Log.txt', Par_Texto);
end;

procedure TDtm_PF.ErroCubagem;
begin
  raise Exception.Create('Cubagem do produto c�digo: '+CDS_ProCODPRODUTO.AsString+' est� cadastrada como zero. '+
   'Arrumar cubagem do produto antes de continuar!');
end;

procedure TDtm_PF.ErroDensidade(Densidade: Double);
begin
  raise Exception.Create('Densidade calculada para o produto c�digo: '+CDS_ProCODPRODUTO.AsString+' � imposs�vel: '+
   FloatToStr(Densidade)+'. Arrumar cubagem ou peso do produto antes de continuar!');
end;

function TDtm_PF.GetDensidade: Double;
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
end;

procedure TDtm_PF.GetUnidadeEQuant(CodPro: String; var Quant: Double; var Unidade: String);

  function UnidadeIsLitro: Boolean;
  begin
    if (UpperCase(Trim(Aux.FieldByName('NOMESUBUNIDADE').AsString)) <> 'L') and
    (UpperCase(Trim(Aux.FieldByName('NOMESUBUNIDADE').AsString)) <> 'LT') and
    (UpperCase(Trim(Aux.FieldByName('NOMESUBUNIDADE').AsString)) <> 'LITROS') and
    (UpperCase(Trim(Aux.FieldByName('NOMESUBUNIDADE').AsString)) <> 'LITRO') then
       Result:= false
     else
       Result:= true;
  end;

  function UnidadeIsKilo: Boolean;
  begin
    if (UpperCase(Trim(Aux.FieldByName('NOMESUBUNIDADE').AsString)) <> 'KG') and
    (UpperCase(Trim(Aux.FieldByName('NOMESUBUNIDADE').AsString)) <> 'KILOS') and
    (UpperCase(Trim(Aux.FieldByName('NOMESUBUNIDADE').AsString)) <> 'KILO') and
    (UpperCase(Trim(Aux.FieldByName('NOMESUBUNIDADE').AsString)) <> 'KILOGRAMA') and
    (UpperCase(Trim(Aux.FieldByName('NOMESUBUNIDADE').AsString)) <> 'KILOGRAMAS')
    then
       Result:= false
     else
       Result:= true;
  end;

begin
  Aux.Close;

  Aux.Sql.Clear;

  Aux.Sql.Add('Select NOMESUBUNIDADE, UNIDADEESTOQUE from PRODUTO');
  Aux.Sql.Add('where CodProduto =:Cod');

  Aux.parambyname('Cod').AsString := CodPro;

  Aux.Open;

  if UnidadeIsLitro then
  begin
    Unidade:= 'litro';
  end
 else if UnidadeIsKilo then
  begin
    Unidade:= 'Kg';
  end
 else
  begin
    ShowMessage('Unidade Inv�lida: '+Aux.FieldByName('NOMESUBUNIDADE').AsString
     +', Cod: '+CodPro);
  end;
end;

function TDtm_PF.GetCubagem(CodPro: String): Double;
begin
  Aux.Close;

  Aux.Sql.Clear;

  Aux.Sql.Add('Select Cubagem from PRODUTO');
  Aux.Sql.Add('where CodProduto =:Cod');

  Aux.parambyname('Cod').AsString := CodPro;

  Aux.Open;
  Result:= Aux.FieldByName('Cubagem').AsFloat;
end;

function TDtm_PF.MCliQuantLitros: Double;
begin
  Result:= (CDS_MCliQUANTATENDIDA.AsFloat/CDS_MCLIUNIDADEESTOQUE.AsFloat) * GetCubagem(CDS_MCliCodProduto.AsString) * 1000;
end;

function TDtm_PF.MForQuantLitros: Double;
begin
  Result:= (CDS_MForQUANT.AsFloat/CDS_MForUNIDADEESTOQUE.AsFloat) * GetCubagem(CDS_MFORCodProduto.AsString) * 1000;
end;

function TDtm_PF.Telefone(CodCliente: String): String;
begin
  Aux.Close;

  Aux.Sql.Clear;

  Aux.Sql.Add('Select Telefone from CLIENTEFONE');
  Aux.Sql.Add('where CodCliente =:Cod');

  Aux.parambyname('Cod').AsString := CodCliente;

  Aux.Open;

  Result:= StringReplace(Aux.FieldByName('Telefone').AsString, ' ', '', [rfReplaceAll]);
end;

function TDtm_PF.TransporteProprio(CodTransportadora: String): Boolean;
var
  I: Integer;
begin
  for I := 0 to FListaTransp.Count - 1 do
  begin
    if CodTransportadora = Trim(FListaTransp[I]) then
    begin
      Result:= True;
      Exit;
    end;
  end;
  Result:= False;
end;

function TDtm_PF.UFCli(CodCliente: String): String;
begin
  Aux.Close;

  Aux.Sql.Clear;

  Aux.Sql.Add('Select ESTADO from CLIENTE');
  Aux.Sql.Add('where CodCliente =:Cod');

  Aux.parambyname('Cod').AsString := CodCliente;

  Aux.Open;

  Result:= Aux.FieldByName('ESTADO').AsString;
end;

function TDtm_PF.NomeGrupoSub(CodGrupoSub: String): String;
begin
  Aux.Close;

  Aux.Sql.Clear;

  Aux.Sql.Add('Select NomeSubGrupo from GRUPOSUB');
  Aux.Sql.Add('where CodGrupoSub =:Cod');

  Aux.parambyname('Cod').AsString := CodGrupoSub;

  Aux.Open;

  Result:= Aux.FieldByName('NomeSubGrupo').AsString;

end;

function TDtm_PF.NumeroCGCMFCli(CodCliente: String): String;
begin
  Aux.Close;

  Aux.Sql.Clear;

  Aux.Sql.Add('Select NUMEROCGCMF from Cliente');
  Aux.Sql.Add('where CodCliente =:Cod');

  Aux.parambyname('Cod').AsString := CodCliente;

  Aux.Open;

  Result:= Aux.FieldByName('NUMEROCGCMF').AsString;
end;

function TDtm_PF.NumeroCGCMFFor(CodFornecedor: String): String;
begin
  Aux.Close;

  Aux.Sql.Clear;

  Aux.Sql.Add('Select NUMEROCGCMF from Forneced');
  Aux.Sql.Add('where CodFornecedor =:Cod');

  Aux.parambyname('Cod').AsString := CodFornecedor;

  Aux.Open;

  Result:= Aux.FieldByName('NUMEROCGCMF').AsString;
end;

procedure TDtm_PF.FiltraNota(const ChaveNFPro: String);
begin
  CDS_MCli.Close;
  SQL_MCli.SQL.Clear;

  SQL_MCli.SQL.Add('Select MCli.*, MCLIPRO.*');
  SQL_MCli.SQL.Add('From MCli');
  SQL_Mcli.SQL.Add('inner join MCLIPRO ON MCLIPRO.CHAVENF = MCLI.CHAVENF');
  SQL_MCli.SQL.Add('where MCliPro.CHAVENFPRO = :CHAVENFPRO');
  SQL_MCli.ParamByName('CHAVENFPRO').AsString:= ChaveNFPro;

  CDS_MCli.Open;
end;

procedure TDtm_PF.FiltraMCli(CodPro, Order: String);

  function PegaComprovantes: String;
  var
    I: Integer;
  begin
    Result:= '';
    for I := 0 to FListaComprov.Count - 1 do
    begin
      if Result <> '' then
        Result:= Result + ' or ';
      Result:= Result + ' MCli.CodComprovante = '''+flistacomprov[I]+''' ';

    end;

  end;

begin
  CDS_MCli.Close;
  SQL_MCli.SQL.Clear;

  SQL_MCli.SQL.Add('Select MCli.*, MCliPro.*');
  SQL_MCli.SQL.Add('From MCli, MCliPro');
  SQL_MCli.SQL.Add('where MCli.DataDocumento between :DataIni and :DataFim and');
  SQL_MCli.SQL.Add('('+PegaComprovantes+')');
  SQL_MCli.SQL.Add('and MCliPro.ChaveNF = MCli.ChaveNF and MCliPro.CodProduto =:CodPro and MCli.ChaveNF = MCliPro.ChaveNF');

  if Order <> '' then
  SQL_MCli.SQL.Add('Order by ' + Order);

  //TODO: Faltam os comprovantes 19, 27 e 35...
  SQL_MCli.ParamByName('CodPro').AsString:= CodPro;
//  SQL_MCli.ParamByName('ProdInd').AsString:= '002';
{  SQL_MCli.ParamByName('Vendas').AsString:= '001';
  SQL_MCli.ParamByName('VendaRem').AsString:= '002';
  SQL_MCli.ParamByName('Comp').AsString:= '003';
  SQL_MCli.ParamByName('Devolucao').AsString:= '007';
  SQL_MCli.ParamByName('SimplesRem').AsString:= '040';
  SQL_MCli.ParamByName('Transfer').AsString:= '042';
  SQL_MCli.ParamByName('Devolucao2').AsString:= '102'; }
  SQL_MCli.ParamByName('DataIni').AsDate:= Ini;
  SQL_MCli.ParamByName('DataFim').AsDate:= Fim;

  CDS_MCli.Open;
end;

procedure TDtm_PF.FiltraMFor(CodPro, Order: String);
begin
  CDS_MFor.Close;
  SQL_MFor.SQL.Clear;

  SQL_MFor.SQL.Add('Select MFor.*, MForPro.*');
  SQL_MFor.SQL.Add('From MFor, MForPro');
  SQL_MFor.SQL.Add('where MFor.DataComprovante between :DataIni and :DataFim'); //and');
//  SQL_MFor.SQL.Add('(MFor.CodComprovante =:005 or MFor.CodComprovante =:010 and MFor.CodComprovante =:011 or');
//  SQL_MFor.SQL.Add('MFor.CodComprovante =:012 or MFor.CodComprovante =:013 or MFor.CodComprovante =:018 or MFor.CodComprovante =:040)');
  SQL_MFor.SQL.Add('and MForPro.ChaveNF = MFor.ChaveNF and MForPro.CodProduto =:CodPro and MFor.ChaveNF = MForPro.ChaveNF');

  SQL_MFor.ParamByName('CodPro').AsString:= CodPro;

{  SQL_MFor.ParamByName('005').AsString:= '005';
  SQL_MFor.ParamByName('010').AsString:= '010';
  SQL_MFor.ParamByName('011').AsString:= '011';
  SQL_MFor.ParamByName('012').AsString:= '012';
  SQL_MFor.ParamByName('013').AsString:= '013';
  SQL_MFor.ParamByName('018').AsString:= '018';
  SQL_MFor.ParamByName('040').AsString:= '040'; }

  SQL_MFor.ParamByName('DataIni').AsDate:= Ini;
  SQL_MFor.ParamByName('DataFim').AsDate:= Fim;

  if Order <> '' then
  SQL_MFor.SQL.Add('Order by ' + Order);

  CDS_MFor.Open;
end;

procedure TDtm_PF.CarregaComprovantes;
begin
  CarregaLista(FListaComprov, 'COMPROVANTES', cComprovPadrao);
end;

procedure TDtm_PF.CarregaGrupos;
begin
  CdsConfGrupo.LoadFromFile(cConfGrupoXml);
end;

procedure TDtm_PF.CarregaTransp;
begin
  CarregaLista(FListaTransp, 'TRANSP', cTranspPadrao);
end;

procedure TDtm_PF.CarregaLista(Par_Lista: TStringList; Par_Ident: String; Par_Default: String);
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'Banco.Ini') then
  begin
    ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Banco.Ini');
    Par_Lista.CommaText :=
        ArqIni.ReadString('Banco', Par_Ident, Par_Default);
    ArqIni.Free;
  end
 else
  begin
    Par_Lista.CommaText:= Par_Default;
  end;

end;

procedure TDtm_PF.AbrirConfGrupo;
var
  FListaGrupos: TStringList;
  I: Integer;
begin
  CdsConfGrupo.CreateDataSet;
  if FileExists(cConfGrupoXml) then
  try
    CdsConfGrupo.LoadFromFile(cConfGrupoXml);
  except
  end;


  if CdsConfGrupo.IsEmpty then
  begin // Se n�o tiver configura��o salva, carrega grupos salvos anteriormento ou padr�o
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

    end;
  end;

  RevalidaConfGrupos;
end;

procedure TDtm_PF.AtualizaConfGrupoAtual;
begin
  CdsConfGrupoNomeGrupoSub.AsString:= NomeGrupoSub(CdsConfGrupoCodGrupoSub.AsString);
  if CdsConfGrupoConcentracao.IsNull then
    CdsConfGrupoConcentracao.AsFloat:= GetConcDefault(CdsConfGrupoCodGrupoSub.AsString);
end;

procedure TDtm_PF.RevalidaConfGrupos;
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

procedure TDtm_PF.DataModuleCreate(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  WriteLog('Criando DataModule');
  NotasTranspProprio:= TStringList.Create;
  FListaComprov:= TStringList.Create;
  FListaComprov.CommaText:= cComprovPadrao;
  FListaTransp:= TStringList.Create;
  FListaTransp.CommaText:= cTranspPadrao;

  if FileExists(ExtractFilePath(Application.ExeName) + 'Banco.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Banco.Ini');
      Connection.Params.Values['Database'] :=
          ArqIni.ReadString('Banco', 'Dir', 'C:\Sidicom.new\Dados\Banco.gdb');
      ArqIni.Free;
    end
  else
    Connection.Params.Values['Database']:= 'C:\Sidicom.new\Dados\Banco.gdb';

  WriteLog('Carregando Listas');
  AbrirConfGrupo;

  CarregaComprovantes;
  CarregaTransp;

  WriteLog('Abrindo conex�o');
  Connection.Open;
  WriteLog('Abrindo CDS PRO');
  CDS_Pro.Open;
  WriteLog('Abrindo CDS CLI');
  CDS_Cli.Open;
  WriteLog('Finalizado carregamento');
end;

procedure TDtm_PF.DataModuleDestroy(Sender: TObject);
begin
  NotasTranspProprio.Free;
  FListaComprov.Free;
  FListaTransp.Free;
end;

procedure TDtm_PF.RecarregaDataSets;
begin
  CarregaComprovantes;
  CarregaTransp;

  Cds_Cli.Close;
  Cds_Pro.Close;
  Cds_Pro.Open;
  Cds_Cli.Open;
end;

function TDtm_PF.RetornaValorDef(Par_Sql: String;
  Par_Default: Variant): Variant;
var
  FQry: TSqlQuery;
begin

  FQry:= TSqlQuery.Create(nil);
  try
    FQry.SQLConnection:= Connection;
    FQry.SQL.Text:= Par_Sql;
    try
      FQry.Open;
      if FQry.IsEmpty then
        Result:= Par_Default
      else if FQry.Fields[0].IsNull then
        Result:= Par_Default
      else
        Result:= FQry.Fields[0].Value;

    except
      Result:= Par_Default;
    end;

  finally
    FQry.Free;
  end;
end;

procedure TDtm_PF.FiltraEst(Grupo: Boolean; AnoMes: TDate; Cod: String);
//var
//  Data: TDate;
//  Dia, Mes, Ano: Word;
begin
  CDS_Estoque.Close;
  SQL_Estoque.Sql.Clear;

  SQL_Estoque.SQL.Add('select EM.CodProduto, EM.SaldoAtual, EM.Codanomes, Produto.CodGrupoSub, Produto.Cubagem, Produto.UnidadeEstoque');
  SQL_Estoque.SQL.Add('from EstoqMes EM, Produto');
  SQL_Estoque.SQL.Add('where Em.CodFilial =:Filial and');
  SQL_Estoque.SQL.Add('Em.CodAnoMes =:Mes2 and Produto.CodProduto = EM.CodProduto and');
  if Grupo then SQL_Estoque.SQL.Add('Produto.CodGrupoSub in ('+GetCodGrupo(Cod)+') and EM.CodProduto = Produto.CodProduto')
  else SQL_Estoque.SQL.Add('EM.CodProduto =:Cod and Produto.CodProduto = EM.CodProduto');
  SQL_Estoque.SQL.Add('Order by EM.CodAnoMes, Produto.CodGrupoSub');

  SQL_Estoque.ParamByName('Filial').AsString:= '01';
{  DecodeDate(AnoMes, Ano, Mes, Dia);
  if Mes = 1 then
  begin
    Mes:= 12;
    Dec(Ano);
  end
else Dec(Mes);   }

//  Data:= EncodeDate(Ano, Mes, Dia);
//  SQl_Estoque.ParamByName('Mes1').AsString:= FormatDateTime('yyyymm', Data);
  SQL_Estoque.ParamByName('Mes2').AsString:= FormatDateTime('yyyymm', AnoMes);
  if not Grupo then
    SQL_Estoque.ParamByName('Cod').AsString:= Cod;

  CDS_Estoque.Open;
end;

procedure TDtm_PF.Filtra_Sub_Gru(CodGrupo: String);
begin
  CDS_Sub_Gru.Close;
  SQL_Sub_Gru.Sql.Clear;

  SQL_Sub_Gru.SQL.Add('Select * from GrupoSub');
  SQL_Sub_Gru.SQL.Add('where GrupoSub.CodGrupo =:CodGrupo');

  SQL_Sub_Gru.ParamByName('CodGrupo').AsString:= CodGrupo;

  CDS_Sub_Gru.Open;
end;

function TDtm_PF.GetCodGrupo(pCodGrupo: String): String;
begin
  if pCodGrupo = '0010000' then
    Result:= '''0010000'', ''0010000'''
  else
    Result:= ''''+pCodGrupo+'''';

end;

function TDtm_PF.QTVenda(Grupo: Boolean; Data: TDate; CodPro: String): Double;
var
  DataFim: TDate;
  Ano, Mes, Dia: Word;

  function PegaComprovantes: String;
  var
    I: Integer;
  begin
    Result:= '';
    for I := 0 to FListaComprov.Count - 1 do
    begin
      if Result <> '' then
        Result:= Result + ' or ';
      Result:= Result + ' MC.CodComprovante = '''+flistacomprov[I]+''' ';

    end;

  end;

begin
  Result:= 0;
  CDS_QTCompra.Close;
  SQL_QTCompra.Sql.Clear;

  DecodeDate(Data, Ano, Mes, Dia);
  DataFim:= EndOfAMonth(Ano, Mes);

  SQL_QTCompra.SQL.Add('Select MP.ChaveNFPro, MP.CodProduto, MP.QuantAtendida, MC.ChaveNF');
  SQL_QTCompra.SQL.Add('From MCliPro MP, MCli MC, Produto Pro');
  SQL_QTCompra.SQL.Add('where MC.DataDocumento between :DataIni and :DataFim and MP.ChaveNF = MC.ChaveNF and');
  SQL_QTCompra.SQL.Add('('+PegaComprovantes+')');

//  SQL_QTCompra.SQL.Add('(MC.CodComprovante =:Vendas or'); //MC.CodComprovante =:Devolucao or');
//  SQL_QTCompra.SQL.Add('MC.CodComprovante =:SimplesRem or MC.CodComprovante =:Transfer or MC.CodComprovante =:Comp) and');

  SQL_QTCompra.SQL.Add('and MP.ChaveNF = MC.ChaveNF and');
  if Grupo then SQL_QTCompra.SQL.Add('Pro.CodGrupoSub in ('+GetCodGrupo(CodPro)+') and MP.CodProduto = Pro.CodProduto')
  else SQL_QTCompra.SQL.Add('MP.CodProduto =:CodPro');
  SQL_QTCompra.SQL.Add('Order By MP.ChaveNFPro');

  //TODO: Faltam os comprovantes 19, 27 e 35...
                                                     {
  SQL_QTCompra.ParamByName('Vendas').AsString:= '001';
  SQL_QTCompra.ParamByName('VendaRem').AsString:= '002';
  SQL_QTCompra.ParamByName('Devolucao').AsString:= '007';
  SQL_QTCompra.ParamByName('SimplesRem').AsString:= '040';
  SQL_QTCompra.ParamByName('Transfer').AsString:= '042';
  SQL_QTCompra.ParamByName('Devolucao2').AsString:= '102'; }

  SQL_QTCompra.ParamByName('DataIni').AsDate:= Data;
  SQL_QTCompra.ParamByName('DataFim').AsDate:= DataFim;
  if not Grupo then
    SQL_QtCompra.ParamByName('CodPro').AsString:= CodPro;

  CDS_QTCompra.Open;
  CDS_QTCompra.First;

  while not CDS_QTCompra.Eof do
  begin
    Result:= Result + CDS_QTCompraQUANTATENDIDA.AsFloat;
    CDS_QTCompra.Next;
  end;
end;

function TDtm_PF.QTCompra(Grupo: Boolean; Data: TDate; CodPro: String): Double;
var
  DataFim: TDate;
  Ano, Mes, Dia: Word;
begin
  Result:= 0;
  CDS_QTVenda.Close;
  SQL_QTVenda.Sql.Clear;

  DecodeDate(Data, Ano, Mes, Dia);
  DataFim:= EndOfAMonth(Ano, Mes);

  SQL_QTVenda.SQL.Add('Select MP.CodProduto, MP.Quant, MF.ChaveNF');
  SQL_QTVenda.SQL.Add('From MForPro MP, MFor MF, Produto Pro');
  SQL_QTVenda.SQL.Add('where MF.DataEntrada between :DataIni and :DataFim and MP.ChaveNF = MF.ChaveNF and');
  if Grupo then SQL_QTVenda.SQL.Add('Pro.CodGrupoSub in ('+GetCodGrupo(CodPro)+') and MP.CodProduto = Pro.CodProduto')
  else SQL_QTVenda.SQL.Add('MP.CodProduto =:CodPro');
  SQL_QTVenda.SQL.Add('Order By MF.ChaveNF');

  SQL_QTVenda.ParamByName('DataIni').AsDate:= Data;
  SQL_QTVenda.ParamByName('DataFim').AsDate:= DataFim;
  if not Grupo then
    SQL_QtVenda.ParamByName('CodPro').AsString:= CodPro;

  CDS_QTVenda.Open;
  CDS_QTVenda.First;

  while not CDS_QTVenda.Eof do
  begin
    Result:= Result + CDS_QTVendaQUANT.AsFloat;
    CDS_QTVenda.Next;
  end;
end;

{function TDtm_PF.QTProF(Data: TDate): Double;
var
  DataFim: TDate;
  Ano, Mes, Dia: Word;
begin
  Result:= 0;
  CDS_QTProF.Close;
  SQL_QTProF.Sql.Clear;

  DecodeDate(Data, Ano, Mes, Dia);
  DataFim:= EndOfAMonth(Ano, Mes);

  SQL_QTProF.SQL.Add('Select MP.CodProduto, MP.QuantAtendida, MP.ChaveNF');
  SQL_QTProF.SQL.Add('From MCliPro MP, MFor MF, Produto Pro');
  SQL_QTProF.SQL.Add('where MF.DataEntrada between :DataIni and :DataFim and MP.ChaveNF = MF.ChaveNF and');
  SQL_QTProF.SQL.Add('Pro.CodGrupoSub =:CodPro and MP.CodProduto = Pro.CodProduto')
//  else SQL_QTVenda.SQL.Add('MP.CodProduto =:CodPro');
  SQL_QTProF.SQL.Add('Order By MF.ChaveNF');

  SQL_QTProF.ParamByName('DataIni').AsDate:= Data;
  SQL_QTProF.ParamByName('DataFim').AsDate:= DataFim;
  SQL_QtProF.ParamByName('CodPro').AsString:= CodPro;

  CDS_QTProF.Open;
  CDS_QTProF.First;

  while not CDS_QTProF.Eof do
  begin
    Result:= Result + CDS_QTProFQUANTATENDIDA.AsFloat;
    CDS_QTProF.Next;
  end;
end;   }

function TDtm_PF.CodTransp(CodTransp: String): String;
begin
  Aux.Close;

  Aux.Sql.Clear;

  Aux.Sql.Add('Select NUMEROCGC from Transp');
  Aux.Sql.Add('where CodTransporte =:Cod');

  Aux.parambyname('Cod').AsString := CodTransp;

  Aux.Open;

  Result:= Aux.FieldByName('NUMEROCGC').AsString;
end;

procedure TDtm_PF.SalvarCdsConfPro;
begin
  CdsConfGrupo.SaveToFile(cConfGrupoXml, dfXml);
end;

procedure TDtm_PF.SQL_ProBeforeOpen(DataSet: TDataSet);

  function PegaGrupos: String;
  var
    I: Integer;
  begin
    Result:= '';
    CdsConfGrupo.First;
    while not CdsConfGrupo.Eof do
    begin
      if Result <> '' then
        Result:= Result + ' or ';
      Result:= Result + ' Produto.CodGrupoSub = '''+CdsConfGrupoCodGrupoSub.AsString+''' ';

      CdsConfGrupo.Next;
    end;

  end;

begin
  SQL_Pro.Sql.Clear;

  SQL_Pro.Sql.Add('Select CodProduto,'+
                  'case when CodGrupoSub = ''0020218'' then ''0010000'' else CodGrupoSub end as CodGrupoSub,'+
                  'Apresentacao, Unidade, UnidadeEstoque, Peso, Cubagem, CodMercosulNCM');
  SQL_Pro.Sql.Add('from produto');

  Sql_Pro.SQL.Add('where (Upper(Produto.CodGrupoSub) like :Thinner or '+ PegaGrupos +') ');
  SQL_Pro.Sql.Add('Order By Produto.CodGrupoSub, Produto.CodProduto');

  SQL_Pro.ParamByName('Thinner').AsString:= 'THINNER';
end;

end.
