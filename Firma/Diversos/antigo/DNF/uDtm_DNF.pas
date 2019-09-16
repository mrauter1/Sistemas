unit uDtm_DNF;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, DBClient, Provider, DB, SqlExpr, IniFiles, Forms;

type
  TDtm_DNF = class(TDataModule)
    Connnection: TSQLConnection;
    SQL_Filtro: TSQLQuery;
    Con_Filtro: TDataSource;
    DTS_Filtro: TDataSetProvider;
    CDS_Filtro: TClientDataSet;
    CDS_FiltroCHAVENF: TStringField;
    CDS_FiltroNUMERO: TStringField;
    CDS_FiltroSERIE: TStringField;
    CDS_FiltroDATADOCUMENTO: TDateField;
    CDS_FiltroDATACOMPROVANTE: TDateField;
    CDS_FiltroCODCLIENTE: TStringField;
    CDS_FiltroNUMEROCGCMF: TStringField;
    CDS_FiltroNUMEROCPF: TStringField;
    CDS_FiltroNOMECLIENTE: TStringField;
    Tbl_MCliPro: TSQLTable;
    DS_MCliPro: TDataSource;
    Dts_MCliPro: TDataSetProvider;
    CDS_MCliPro: TClientDataSet;
    CDS_MCliProCHAVENFPRO: TStringField;
    CDS_MCliProCHAVENF: TStringField;
    CDS_MCliProCODPRODUTO: TStringField;
    CDS_MCliProUNIDADEESTOQUE: TIntegerField;
    CDS_MCliProQUANTATENDIDA: TFMTBCDField;
    Tbl_Pro: TSQLTable;
    DTS_Pro: TDataSetProvider;
    CDS_Pro: TClientDataSet;
    CDS_ProCODPRODUTO: TStringField;
    CDS_ProCODBARRA: TStringField;
    CDS_ProCODGRUPOSUB: TStringField;
    CDS_ProAPRESENTACAO: TStringField;
    CDS_ProUNIDADE: TStringField;
    CDS_ProUNIDADEESTOQUE: TIntegerField;
    Tbl_Grupo: TSQLTable;
    DTS_Grupo: TDataSetProvider;
    CDS_Grupo: TClientDataSet;
    DS_Pro: TDataSource;
    CDS_GrupoCODGRUPOSUB: TStringField;
    CDS_GrupoCODGRUPO: TStringField;
    CDS_MCliProCODFISCALPRO: TStringField;
    Tbl_Pedido: TSQLTable;
    Dts_Pedido: TDataSetProvider;
    CDS_Pedido: TClientDataSet;
    CDS_PedidoCODPEDIDO: TStringField;
    CDS_PedidoMOSTRASUBUN_SN: TStringField;
    CDS_FiltroCODPEDIDO: TStringField;
    CDS_FiltroSubUn: TStringField;
    CDS_ProNOMESUBUNIDADE: TStringField;
    CDS_MCliProPRECO: TFMTBCDField;
    CDS_ProPESO: TFMTBCDField;
    CDS_MCliProALIQIPI: TFMTBCDField;
    procedure Filtra(OrderBy: String = '');
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dtm_DNF: TDtm_DNF;
  Ini, Fim: TDateTime;

implementation

{$R *.dfm}

procedure TDtm_DNF.Filtra(OrderBy: String = '');
begin
  CDS_Filtro.Close;
  SQL_Filtro.SQL.Clear;
  SQL_Filtro.SQL.Add('Select Distinct(M.ChaveNF), M.Numero, M.Serie, M.DataDocumento, C.NomeCliente,');
  SQL_Filtro.SQL.Add('M.DataComprovante, C.CodCliente, C.NumeroCGCMF, C.NumeroCPF, M.CodPedido, pedido.MOSTRASUBUN_SN as SubUn');
  SQL_Filtro.SQL.Add('from MCli M, MCliPro MP, Produto Pro, GrupoSub G, Cliente C, Comprv');
  SQL_Filtro.SQL.Add('left join pedido on pedido.CodPedido = M.CodPedido ');
  SQL_Filtro.SQL.Add('where G.CodGrupo =:ProdInd and (Comprv.CodComprovante =:Vendas or Comprv.CodComprovante =:Transf');
  SQL_Filtro.SQL.Add('or Comprv.CodComprovante =:VendaManual or Comprv.CodComprovante =:SimpRem or');
  SQL_Filtro.SQL.Add('Comprv.CodComprovante =:Amostra or Comprv.CodComprovante =:Comp or Comprv.CodComprovante =:Comp2) and');
  SQL_Filtro.SQL.Add('M.CodComprovante = Comprv.CodComprovante and Pro.CodGrupoSub = G.CodGrupoSub and MP.CodProduto = Pro.CodProduto');
  SQL_Filtro.SQL.Add('and M.ChaveNF = MP.ChaveNF');
  SQL_Filtro.SQL.Add('and M.DataDocumento between :Dataini and :DataFim and C.CodCliente = M.CodCliente');
  if OrderBy <> '' then
  SQL_Filtro.SQL.Add('order by ' +  OrderBy);

  SQL_Filtro.ParamByName('Vendas').AsString:= '001';
  SQL_Filtro.ParamByName('Comp2').AsString:= '002';
  SQL_Filtro.ParamByName('Comp').AsString:= '003';
  SQL_Filtro.ParamByName('VendaManual').AsString:= '005';
  SQL_Filtro.ParamByName('SimpRem').AsString:= '040';
  SQL_Filtro.ParamByName('Transf').AsString:= '042';
  SQL_Filtro.ParamByName('Amostra').AsString:= '045';
  SQL_Filtro.ParamByName('ProdInd').AsString:= '002';
  SQL_Filtro.ParamByName('DataIni').AsDate:= Ini;
  SQL_Filtro.ParamByName('DataFim').AsDate:= Fim;
  CDS_Filtro.Open;
end;

procedure TDtm_DNF.DataModuleCreate(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'Banco.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Banco.Ini');
      Connnection.Params.Values['Database'] :=
          ArqIni.ReadString('Banco', 'Dir', 'C:\Sidicom.new\Dados\Banco.gdb');
      ArqIni.Free;
    end
  else
    Connnection.Params.Values['Database']:= 'C:\Sidicom.new\Dados\Banco.gdb';

  Connnection.Open;
  CDS_Filtro.Open;
  CDS_MCliPro.Open;
  CDS_Pro.Open;
  CDS_Grupo.Open;
  CDS_Pedido.Open;
end;

end.
