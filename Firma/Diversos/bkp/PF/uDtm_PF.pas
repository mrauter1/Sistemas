unit uDtm_PF;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, FMTBcd, DBClient, Provider, Controls, IniFiles, Forms;

type
  TDtm_PF = class(TDataModule)
    Connection: TSQLConnection;
    DTS_Pro: TDataSetProvider;
    CDS_Pro: TClientDataSet;
    DS_Pro: TDataSource;
    SQL_Pro: TSQLQuery;
    Tbl_Cli: TSQLTable;
    DTS_Cli: TDataSetProvider;
    CDS_CliCODCLIENTE: TStringField;
    CDS_CliRAZAOSOCIAL: TStringField;
    CDS_CliENDERECO: TStringField;
    CDS_CliCIDADE: TStringField;
    CDS_CliESTADO: TStringField;
    CDS_CliCODIGOPOSTAL: TStringField;
    CDS_CliNUMEROCGCMF: TStringField;
    CDS_Cli: TClientDataSet;
    Tbl_Fone: TSQLTable;
    DTS_Fone: TDataSetProvider;
    CDS_Fone: TClientDataSet;
    DS_Cli: TDataSource;
    CDS_FoneCODCLIENTE: TStringField;
    CDS_FoneTELEFONE: TStringField;
    CDS_FoneCONTATO: TStringField;
    DTS_GrupoSub: TDataSetProvider;
    CDS_GrupoSub: TClientDataSet;
    Tbl_GrupoSub: TSQLTable;
    CDS_GrupoSubCODGRUPOSUB: TStringField;
    CDS_GrupoSubCODGRUPO: TStringField;
    CDS_GrupoSubCODSUBGRUPO: TStringField;
    CDS_GrupoSubNOMESUBGRUPO: TStringField;
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
    CDS_MCliCODFISCAL: TStringField;
    DTS_MFor: TDataSetProvider;
    CDS_MFor: TClientDataSet;
    SQL_MFor: TSQLQuery;
    CDS_MForCHAVENF: TStringField;
    CDS_MForDATACOMPROVANTE: TDateField;
    CDS_MForDATAENTRADA: TDateField;
    CDS_MForCODFISCAL: TStringField;
    CDS_MForCODPRODUTO: TStringField;
    CDS_MForUNIDADEESTOQUE: TIntegerField;
    CDS_MForQUANT: TFMTBCDField;
    CDS_MForNUMERO: TStringField;
    Tbl_Cli1: TSQLTable;
    DTS_Cli1: TDataSetProvider;
    CDS_Cli1: TClientDataSet;
    StringField1: TStringField;
    DS_MCli: TDataSource;
    DS_MFor: TDataSource;
    CDS_MCliCODCLIENTE: TStringField;
    CDS_MForCODFORNECEDOR: TStringField;
    Tbl_For: TSQLTable;
    DTS_For: TDataSetProvider;
    CDS_For: TClientDataSet;
    CDS_ForCODFORNECEDOR: TStringField;
    CDS_ForNUMEROCGCMF: TStringField;
    CDS_Cli1NUMEROCGCMF: TStringField;
    DTS_Transp: TDataSetProvider;
    CDS_Transp: TClientDataSet;
    SQL_Transp: TSQLQuery;
    CDS_TranspCODTRANSPORTE: TStringField;
    CDS_TranspNUMEROCGC: TStringField;
    CDS_MCliCODTRANSPORTADORA: TStringField;
    CDS_MForTRANCODTRANSPORTE: TStringField;
    DTS_Sub_Gru: TDataSetProvider;
    CDS_Sub_Gru: TClientDataSet;
    SQL_Sub_Gru: TSQLQuery;
    CDS_Sub_GruCODGRUPOSUB: TStringField;
    CDS_Sub_GruCODGRUPO: TStringField;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dtm_PF: TDtm_PF;
  Ini: TDateTime;
  Fim: TDateTime;

implementation

uses DateUtils;

{$R *.dfm}

procedure TDtm_PF.FiltraMCli(CodPro, Order: String);
begin
  CDS_MCli.Close;
  SQL_MCli.SQL.Clear;

  SQL_MCli.SQL.Add('Select MCli.*, MCliPro.*');
  SQL_MCli.SQL.Add('From MCli, MCliPro');
  SQL_MCli.SQL.Add('where MCli.DataDocumento between :DataIni and :DataFim and');
  SQL_MCli.SQL.Add('(MCli.CodComprovante =:Vendas or MCli.CodComprovante =:VendaRem and MCli.CodComprovante =:Devolucao or');
  SQL_MCli.SQL.Add('MCli.CodComprovante =:SimplesRem or MCli.CodComprovante =:Transfer or MCli.CodComprovante =:Comp or MCli.CodComprovante =:Devolucao2)');
  SQL_MCli.SQL.Add('and MCliPro.ChaveNF = MCli.ChaveNF and MCliPro.CodProduto =:CodPro and MCli.ChaveNF = MCliPro.ChaveNF');

  if Order <> '' then
  SQL_MCli.SQL.Add('Order by ' + Order);

  SQL_MCli.ParamByName('CodPro').AsString:= CodPro;
//  SQL_MCli.ParamByName('ProdInd').AsString:= '002';
  SQL_MCli.ParamByName('Vendas').AsString:= '001';
  SQL_MCli.ParamByName('VendaRem').AsString:= '002';
  SQL_MCli.ParamByName('Comp').AsString:= '003';
  SQL_MCli.ParamByName('Devolucao').AsString:= '007';
  SQL_MCli.ParamByName('SimplesRem').AsString:= '040';
  SQL_MCli.ParamByName('Transfer').AsString:= '042';
  SQL_MCli.ParamByName('Devolucao2').AsString:= '102';
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

procedure TDtm_PF.DataModuleCreate(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'Banco.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Banco.Ini');
      Connection.Params.Values['Database'] :=
          ArqIni.ReadString('Banco', 'Dir', 'C:\Sidicom.new\Dados\Banco.gdb');
      ArqIni.Free;
    end
  else
    Connection.Params.Values['Database']:= 'C:\Sidicom.new\Dados\Banco.gdb';

  Connection.Open;
  CDS_Pro.Open;
  CDS_MCli.Open;
  CDS_MFor.Open;
  CDS_Cli.Open;
  CDS_Fone.Open;
//  CDS_ProInsumo.Open;
  CDS_GrupoSub.Open;
  CDS_Cli1.Open;
  CDS_For.Open;
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
  if Grupo then SQL_Estoque.SQL.Add('Produto.CodGrupoSub =:Cod and EM.CodProduto = Produto.CodProduto')
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

function TDtm_PF.QTVenda(Grupo: Boolean; Data: TDate; CodPro: String): Double;
var
  DataFim: TDate;
  Ano, Mes, Dia: Word;
begin
  Result:= 0;
  CDS_QTCompra.Close;
  SQL_QTCompra.Sql.Clear;

  DecodeDate(Data, Ano, Mes, Dia);
  DataFim:= EndOfAMonth(Ano, Mes);

  SQL_QTCompra.SQL.Add('Select MP.ChaveNFPro, MP.CodProduto, MP.QuantAtendida, MC.ChaveNF');
  SQL_QTCompra.SQL.Add('From MCliPro MP, MCli MC, Produto Pro');
  SQL_QTCompra.SQL.Add('where MC.DataDocumento between :DataIni and :DataFim and MP.ChaveNF = MC.ChaveNF and');
  SQL_QTCompra.SQL.Add('(MC.CodComprovante =:Vendas or MC.CodComprovante =:VendaRem and MC.CodComprovante =:Devolucao or');
  SQL_QTCompra.SQL.Add('MC.CodComprovante =:SimplesRem or MC.CodComprovante =:Transfer or MC.CodComprovante =:Comp or MC.CodComprovante =:Devolucao2)');

//  SQL_QTCompra.SQL.Add('(MC.CodComprovante =:Vendas or'); //MC.CodComprovante =:Devolucao or');
//  SQL_QTCompra.SQL.Add('MC.CodComprovante =:SimplesRem or MC.CodComprovante =:Transfer or MC.CodComprovante =:Comp) and');

  SQL_QTCompra.SQL.Add('and MP.ChaveNF = MC.ChaveNF and');
  if Grupo then SQL_QTCompra.SQL.Add('Pro.CodGrupoSub =:CodPro and MP.CodProduto = Pro.CodProduto')
  else SQL_QTCompra.SQL.Add('MP.CodProduto =:CodPro');
  SQL_QTCompra.SQL.Add('Order By MP.ChaveNFPro');

  SQL_QTCompra.ParamByName('Vendas').AsString:= '001';
  SQL_QTCompra.ParamByName('VendaRem').AsString:= '002';
  SQL_QTCompra.ParamByName('Comp').AsString:= '003';
  SQL_QTCompra.ParamByName('Devolucao').AsString:= '007';
  SQL_QTCompra.ParamByName('SimplesRem').AsString:= '040';
  SQL_QTCompra.ParamByName('Transfer').AsString:= '042';
  SQL_QTCompra.ParamByName('Devolucao2').AsString:= '102';

  SQL_QTCompra.ParamByName('DataIni').AsDate:= Data;
  SQL_QTCompra.ParamByName('DataFim').AsDate:= DataFim;
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
  if Grupo then SQL_QTVenda.SQL.Add('Pro.CodGrupoSub =:CodPro and MP.CodProduto = Pro.CodProduto')
  else SQL_QTVenda.SQL.Add('MP.CodProduto =:CodPro');
  SQL_QTVenda.SQL.Add('Order By MF.ChaveNF');

  SQL_QTVenda.ParamByName('DataIni').AsDate:= Data;
  SQL_QTVenda.ParamByName('DataFim').AsDate:= DataFim;
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
  CDS_Transp.Close;
  SQL_Transp.Sql.Clear;

  SQL_Transp.SQL.Add('Select * From Transp');
  SQL_Transp.SQL.Add('where CodTransporte =:CodTransp');

  SQL_Transp.ParamByName('CodTransp').AsString:= CodTransp;

  CDS_Transp.Open;

  Result:= CDS_TranspNUMEROCGC.AsString;
end;

procedure TDtm_PF.SQL_ProBeforeOpen(DataSet: TDataSet);
begin
  SQL_Pro.Sql.Clear;

  SQL_Pro.Sql.Add('Select *');
  SQL_Pro.Sql.Add('from produto');
  SQL_Pro.Sql.Add('where (produto.CodGrupoSub =:Acetona or Produto.CodGrupoSub =:ClorMetil or');
  SQL_Pro.Sql.Add('Produto.CodGrupoSub =:MetilEtilCet or Produto.CodGrupoSub =:Tol or');
  SQL_Pro.Sql.Add('Produto.CodGrupoSub =:CicloHex or Upper(Produto.CodGrupoSub) like :Thinner or');
  SQL_Pro.Sql.Add('Produto.CodGrupoSub =:AcetEtil or Produto.CodGrupoSub =:DiacetonaAlc or');
  SQL_Pro.Sql.Add('Produto.CodGrupoSub =:AcetBut or Produto.CodGrupoSub =:MIBK or');
  SQL_Pro.Sql.Add('Produto.CodGrupoSub =:Isa4 or Produto.CodGrupoSub =:AcetAm or');
  SQL_Pro.Sql.Add('Produto.CodGrupoSub =:Butanol or Produto.CodGrupoSub =:SecButanol)');
  SQL_Pro.Sql.Add('Order By Produto.CodProduto');

  SQL_Pro.ParamByName('Acetona').AsString:=  '0010000';
  SQL_Pro.ParamByName('ClorMetil').AsString:= '0010008';
  SQL_Pro.ParamByName('MetilEtilCet').AsString:= '0010018';
  SQL_Pro.ParamByName('Tol').AsString:= '0010026';
  SQL_Pro.ParamByName('CicloHex').AsString:= '0010007';
  SQL_Pro.ParamByName('Thinner').AsString:= 'THINNER';
  SQL_Pro.ParamByName('AcetEtil').AsString:= '0010002';
  SQL_Pro.ParamByName('DiacetonaAlc').AsString:= '0010010';
  SQL_Pro.ParamByName('AcetBut').AsString:= '0010001';
  SQL_Pro.ParamByName('MIBK').AsString:= '0010019';
  SQL_Pro.ParamByName('Isa4').AsString:= '0010012';
  SQL_Pro.ParamByName('AcetAm').AsString:= '0010030';
  SQL_Pro.ParamByName('Butanol').AsString:= '0010031';
  SQL_Pro.ParamByName('SecButanol').AsString:= '0010035';
end;

end.
