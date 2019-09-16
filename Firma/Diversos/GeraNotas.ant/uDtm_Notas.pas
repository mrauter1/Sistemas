unit uDtm_Notas;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, SqlExpr, DB, Provider, DBClient;

type
  TDtm_Notas = class(TDataModule)
    SQLConnection: TSQLConnection;
    DTS_MCliPro: TDataSetProvider;
    CDS_Cliente: TClientDataSet;
    DTS_Cliente: TDataSetProvider;
    Tbl_Cliente: TSQLTable;
    CDS_Transp: TClientDataSet;
    DTS_Transp: TDataSetProvider;
    Tbl_Transp: TSQLTable;
    CDS_Produto: TClientDataSet;
    DTS_Produto: TDataSetProvider;
    Tbl_Produto: TSQLTable;
    Con_MCliPro: TDataSource;
    CDS_MCliPro: TClientDataSet;
    Tbl_MCliPro: TSQLTable;
    SQL_Filtro: TSQLQuery;
    Con_Filtro: TDataSource;
    DTS_Filtro: TDataSetProvider;
    CDS_Filtro: TClientDataSet;
    CDS_FiltroCHAVENF: TStringField;
    CDS_FiltroCLIENTEOUFILIAL: TStringField;
    CDS_FiltroCODFILIAL: TStringField;
    CDS_FiltroCODCOMPROVANTE: TStringField;
    CDS_FiltroSERIE: TStringField;
    CDS_FiltroNUMERO: TStringField;
    CDS_FiltroCODFISCAL: TStringField;
    CDS_FiltroDATADOCUMENTO: TDateField;
    CDS_FiltroDATACOMPROVANTE: TDateField;
    CDS_FiltroCODCLIENTE: TStringField;
    CDS_FiltroSITUACAONF: TStringField;
    CDS_FiltroCODCONDICAO: TStringField;
    CDS_FiltroCODDPTO: TStringField;
    CDS_FiltroCODPEDIDO: TStringField;
    CDS_FiltroNUMEROCUPOM: TStringField;
    CDS_FiltroCODVENDEDOR: TStringField;
    CDS_FiltroCODVENDEDOR2: TStringField;
    CDS_FiltroCODVENDEDOR3: TStringField;
    CDS_FiltroCODCAIXA: TStringField;
    CDS_FiltroCODDIGITADOR: TStringField;
    CDS_FiltroCODTRANSPORTADORA: TStringField;
    CDS_FiltroCODCENTROCUSTO: TStringField;
    CDS_FiltroTRANFRETE: TStringField;
    CDS_FiltroCONVENIADO: TStringField;
    CDS_FiltroISENTOICM: TStringField;
    CDS_FiltroISENTOIPI: TStringField;
    CDS_FiltroISENTOSUBST: TStringField;
    CDS_FiltroDBCR: TStringField;
    CDS_FiltroTOTITENS: TIntegerField;
    CDS_FiltroTOTBRUTO: TFMTBCDField;
    CDS_FiltroTOTDESCITEM: TFMTBCDField;
    CDS_FiltroTOTIPI: TFMTBCDField;
    CDS_FiltroSUBSTITUICAO: TFMTBCDField;
    CDS_FiltroTOTBASESUBST: TFMTBCDField;
    CDS_FiltroTOTFRETE: TFMTBCDField;
    CDS_FiltroTOTDESPESAS: TFMTBCDField;
    CDS_FiltroTOTNOTA: TFMTBCDField;
    CDS_FiltroTOTICM: TFMTBCDField;
    CDS_FiltroTOTBASEICM: TFMTBCDField;
    CDS_FiltroTOTISS: TFMTBCDField;
    CDS_FiltroTOTCOMISSAO: TFMTBCDField;
    CDS_FiltroTOTCOMISSAO2: TFMTBCDField;
    CDS_FiltroTOTCOMISSAO3: TFMTBCDField;
    CDS_FiltroOBSERVACAO: TStringField;
    CDS_FiltroHORAMOVIMENTO: TTimeField;
    CDS_FiltroCODORDEMPRODUCAO: TStringField;
    CDS_FiltroCOMP_ANOMES: TStringField;
    CDS_FiltroCONTRIBUINTE: TStringField;
    CDS_FiltroTOTVALORPAGO: TFMTBCDField;
    CDS_FiltroENDERECOCONVENIO: TStringField;
    CDS_FiltroTOTBASEIPI: TFMTBCDField;
    CDS_FiltroNAOSOMAESTOQUE: TStringField;
    CDS_FiltroTRANVOLUME: TStringField;
    CDS_FiltroTRANQUANTIDADE: TIntegerField;
    CDS_FiltroTRANPESOBRUTO: TFMTBCDField;
    CDS_FiltroTRANPESOLIQUIDO: TFMTBCDField;
    CDS_FiltroTRANCUBAGEM: TFMTBCDField;
    CDS_FiltroTOTBASEPISCOFINS: TFMTBCDField;
    CDS_FiltroTOTPIS: TFMTBCDField;
    CDS_FiltroTOTCOFINS: TFMTBCDField;
    CDS_FiltroTERCEIROPROPRIO: TStringField;
    CDS_ClienteCODCLIENTE: TStringField;
    CDS_ClienteNOMECLIENTE: TStringField;
    CDS_ClienteRAZAOSOCIAL: TStringField;
    CDS_ClienteCODIGOPOSTAL: TStringField;
    CDS_ClienteNUMEROCGCMF: TStringField;
    CDS_TranspCODTRANSPORTE: TStringField;
    CDS_TranspNOMETRANSPORTE: TStringField;
    CDS_TranspCODIGOPOSTAL: TStringField;
    CDS_TranspNUMEROCGC: TStringField;
    CDS_MCliProCHAVENFPRO: TStringField;
    CDS_MCliProCHAVENF: TStringField;
    CDS_MCliProCODPRODUTO: TStringField;
    CDS_MCliProENTRADASAIDA: TStringField;
    CDS_MCliProSOMOUESTOQUE: TStringField;
    CDS_MCliProUNIDADEESTOQUE: TIntegerField;
    CDS_MCliProQUANTATENDIDA: TFMTBCDField;
    CDS_MCliProPRECO: TFMTBCDField;
    CDS_MCliProCODLISTA: TStringField;
    CDS_MCliProALIQIPI: TFMTBCDField;
    CDS_MCliProIPIPERCOUVALOR: TStringField;
    CDS_MCliProALIQICM: TFMTBCDField;
    CDS_MCliProALIQICMREDUCAO: TFMTBCDField;
    CDS_MCliProALIQISS: TFMTBCDField;
    CDS_MCliProSUBSTVALPER: TStringField;
    CDS_MCliProSUBSTMARGEM: TFMTBCDField;
    CDS_MCliProSUBSTALIQ: TFMTBCDField;
    CDS_MCliProDESCONTO1: TFMTBCDField;
    CDS_MCliProDESCONTO2: TFMTBCDField;
    CDS_MCliProDESCONTO3: TFMTBCDField;
    CDS_MCliProDESCONTO4: TFMTBCDField;
    CDS_MCliProDESCONTOCALC: TFMTBCDField;
    CDS_MCliProVALBRUTO: TFMTBCDField;
    CDS_MCliProVALDESCITEM: TFMTBCDField;
    CDS_MCliProVALIPI: TFMTBCDField;
    CDS_MCliProVALSUBSTITUICAO: TFMTBCDField;
    CDS_MCliProVALTOTAL: TFMTBCDField;
    CDS_MCliProVALBASEICM: TFMTBCDField;
    CDS_MCliProVALBASESUBST: TFMTBCDField;
    CDS_MCliProVALICM: TFMTBCDField;
    CDS_MCliProVALISS: TFMTBCDField;
    CDS_MCliProPERCCOMISSAO: TFMTBCDField;
    CDS_MCliProPERCCOMISSAO2: TFMTBCDField;
    CDS_MCliProPERCCOMISSAO3: TFMTBCDField;
    CDS_MCliProVALCOMISSAO: TFMTBCDField;
    CDS_MCliProVALCOMISSAO2: TFMTBCDField;
    CDS_MCliProVALCOMISSAO3: TFMTBCDField;
    CDS_MCliProCODICMMOV: TStringField;
    CDS_MCliProVALBASEIPI: TFMTBCDField;
    CDS_MCliProCODFISCALPRO: TStringField;
    CDS_MCliProSEQUENCIADOPRODUTO: TIntegerField;
    CDS_MCliProMOMENTOCUSTOMEDIO: TFMTBCDField;
    CDS_MCliProMOMENTOPRECOBRUTO: TFMTBCDField;
    CDS_MCliProMOMENTOPRECOLIQUIDO: TFMTBCDField;
    CDS_MCliProVALBASEPISCOFINS: TFMTBCDField;
    CDS_MCliProALIQPIS: TFMTBCDField;
    CDS_MCliProALIQCOFINS: TFMTBCDField;
    CDS_MCliProVALPIS: TFMTBCDField;
    CDS_MCliProVALCOFINS: TFMTBCDField;
    CDS_ProdutoCODPRODUTO: TStringField;
    CDS_ProdutoCODBARRA: TStringField;
    CDS_ProdutoCODGRUPOSUB: TStringField;
    CDS_ProdutoCODFAMILIAPRECO: TStringField;
    CDS_ProdutoNOMEGENERICO: TStringField;
    CDS_ProdutoAPRESENTACAO: TStringField;
    CDS_ProdutoCODAPLICACAO: TStringField;
    CDS_ProdutoPRINCIPALFOR: TStringField;
    CDS_ProdutoREFERENCIA: TStringField;
    CDS_ProdutoSITUACAOPRO: TStringField;
    CDS_ProdutoUNIDADE: TStringField;
    CDS_ProdutoUNIDADEESTOQUE: TIntegerField;
    CDS_ProdutoCODICMVENDA: TStringField;
    CDS_ProdutoCODICMCOMPRA: TStringField;
    CDS_ProdutoCODIPICOMPRA: TStringField;
    CDS_ProdutoCODIPIVENDA: TStringField;
    CDS_ProdutoISS: TFMTBCDField;
    CDS_ProdutoPESO: TFMTBCDField;
    CDS_ProdutoCUBAGEM: TFMTBCDField;
    CDS_ProdutoDATAINCLUSAO: TDateField;
    CDS_ProdutoDATAALTERACAO: TDateField;
    CDS_ProdutoCLASSEABC: TStringField;
    CDS_ProdutoENTRADALIVRE: TStringField;
    CDS_ProdutoCODNACIONALIDADE: TStringField;
    CDS_ProdutoCONTROLALOTE: TStringField;
    CDS_ProdutoDIASVENCELOTE: TIntegerField;
    CDS_ProdutoNAOVENDEZERADO: TStringField;
    CDS_ProdutoOBSERVACAO: TMemoField;
    CDS_ProdutoCODCOR: TIntegerField;
    CDS_ProdutoCODTAMANHO: TIntegerField;
    CDS_ProdutoCODICMVENDA8702: TStringField;
    CDS_ProdutoCODMERCOSULNCM: TStringField;
    CDS_ProdutoNOMESUBUNIDADE: TStringField;
    CDS_ProdutoSERVICOISS: TStringField;
    CDS_ProdutoSITUACAOPISCOFINS: TStringField;
    CDS_ProdutoPESOBRUTO: TFMTBCDField;
    CDS_ProdutoMULTIPOVENDA: TFMTBCDField;
    CDS_ProdutoMULTIPOLIMITE: TFMTBCDField;
    CDS_ProdutoORDEMDOPRODUTO: TIntegerField;
    CDS_ProdutoDIASQUARENTENALOTE: TIntegerField;
    CDS_FiltroCGCMFDEST: TStringField;
    CDS_FiltroCGCTRANSP: TStringField;
    CDS_MCliProREFERENCIAFORN: TStringField;
    CDS_MCliProDESCRICAOPECA: TStringField;
    CDS_MCliProUNIDADE: TStringField;
    CDS_MCliProCLASSIFFISCAL: TStringField;
    CDS_FiltroNOMEDEST: TStringField;
    CDS_MCliProSUBUNIDADE: TStringField;
    DTS_Fatura: TDataSetProvider;
    CDS_Fatura: TClientDataSet;
    Tbl_Fatura: TSQLTable;
    CDS_FaturaCHAVENFPRESTACAO: TStringField;
    CDS_FaturaCHAVENF: TStringField;
    CDS_FaturaMARCA: TStringField;
    CDS_FaturaCODFILIAL: TStringField;
    CDS_FaturaNUMPRESTACAO: TStringField;
    CDS_FaturaCODCOMPROVANTE: TStringField;
    CDS_FaturaSERIE: TStringField;
    CDS_FaturaNUMERO: TStringField;
    CDS_FaturaCODCLIENTE: TStringField;
    CDS_FaturaCODCONDICAO: TStringField;
    CDS_FaturaDATACOMPROVANTE: TDateField;
    CDS_FaturaDATAVENCIMENTO: TDateField;
    CDS_FaturaCODPEDIDO: TStringField;
    CDS_FaturaTOTNOTA: TFMTBCDField;
    Dts_Msg: TDataSetProvider;
    CDS_Msg: TClientDataSet;
    Tbl_Msg: TSQLTable;
    CDS_MsgCHAVENF: TStringField;
    CDS_MsgOBSERVACAO1: TMemoField;
    CDS_Pedido: TClientDataSet;
    Dts_Pedido: TDataSetProvider;
    Tbl_Pedido: TSQLTable;
    CDS_PedidoCODPEDIDO: TStringField;
    CDS_PedidoMOSTRASUBUN_SN: TStringField;
    CDS_FaturaTOTPRESTACAO: TFMTBCDField;
    CDS_FiltroMOSTRASUBUN: TStringField;
    CDS_PedidoIT: TClientDataSet;
    DTS_PedidoIT: TDataSetProvider;
    SQL_PedidoIT: TSQLQuery;
    CDS_PedidoITCODPRODUTO: TStringField;
    CDS_PedidoITORDEMCOMPRA: TStringField;
    CDS_PedidoITCODPEDIDO: TStringField;
    CDS_ClienteOBSERVACAO: TMemoField;
    SQL: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure Filtra;
    procedure FiltraPedido;
    function GetITDescricao(Codigo: String): String;
    function GetCliObs(Codigo: String): String;
    function GetOrdemCompra(Codigo: String): String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dtm_Notas: TDtm_Notas;

implementation

{$R *.dfm}

uses
  uNota;

function TDtm_Notas.GetITDescricao(Codigo: String): String;
begin
  SQL.Close;
  SQL.SQL.Clear;
  SQL.SQL.Add('Select G.NomeSubGrupo from GrupoSub G, Produto P ');
  SQL.SQL.Add('where P.CodProduto = :Cod and G.CodGrupoSub = P.CodGrupoSub');
  SQL.ParamByName('Cod').AsString:= Codigo;
  SQL.Open;
  Result:= Trim(SQL.FieldByName('NomeSubGrupo').AsString);
end;

function TDtm_Notas.GetCliObs(Codigo: String): String;
begin
  SQL.Close;
  SQL.SQL.Clear;
  SQL.SQL.Add('Select Observacao from Cliente');
  SQL.SQL.Add('where CodCliente = :Cod');
  SQL.ParamByName('Cod').AsString:= Codigo;
  SQL.Open;
  Result:= Trim(SQL.FieldByName('Observacao').AsString);
end;

function TDtm_Notas.GetOrdemCompra(Codigo: String): String;
begin
  SQL.Close;
  SQL.SQL.Clear;
  SQL.SQL.Add('Select RepreNumPedido from Pedido');
  SQL.SQL.Add('where CodPedido = :Cod');
  SQL.ParamByName('Cod').AsString:= Codigo;
  SQL.Open;
  Result:= Trim(SQL.FieldByName('RepreNumPedido').AsString);
end;

procedure TDtm_Notas.DataModuleCreate(Sender: TObject);
begin
  SQLConnection.open;
  CDS_Filtro.Open;
  CDS_MCliPro.Open;
  CDS_Msg.Open;
  CDS_Cliente.Open;
  CDS_Transp.Open;
  CDS_Produto.Open;
  CDS_Fatura.Open;
end;

procedure TDTM_Notas.Filtra;
var
  Destino: String;
begin
  with fNota do
  Destino:= RadioGroup.Items.Strings[RadioGroup.ItemIndex];

//  FechaBanco;
  CDS_Filtro.Close;
//  SQL_Filtro.Close;
  SQL_Filtro.SQL.Clear;
  if Destino <> '' then
    begin
      SQL_Filtro.SQL.Add('Select *');
      SQL_Filtro.SQL.Add('from MCli A, Cliente B');
      SQL_Filtro.SQL.Add('where upper(B.NomeCliente) like Upper(:Destino)');
      SQL_Filtro.SQL.Add('and A.CodCliente = B.CodCliente');
      SQL_Filtro.SQL.Add('and (A.CodFiscal =:CFO or A.CodFiscal =:CFO1)');
      SQL_Filtro.SQL.Add('and A.DataDocumento between :Dataini and :DataFim');
      SQL_Filtro.SQL.Add('order by A.Numero');

      SQL_Filtro.ParamByName('CFO').AsString:= '51010';
      SQL_Filtro.ParamByName('CFO1').AsString:= '51180';
      SQL_Filtro.ParamByName('Destino').AsString:= '%' + Destino + '%';
      SQL_Filtro.ParamByName('DataIni').AsDate:= fNota.DataIni.DateTime;
      SQL_Filtro.ParamByName('DataFim').AsDate:= fNota.DataFim.DateTime;
    end;
//  SQL_Filtro.Open;
  CDS_Filtro.Open;
end;

procedure TDtm_Notas.FiltraPedido;
begin
  CDS_PedidoIT.Close;
  SQL_PedidoIT.SQL.Clear;

  Sql_PedidoIT.SQL.Add('Select P.CodPedido, P.CodProduto, P.OrdemCompra');
  Sql_PedidoIT.SQL.Add('from PedidoIT P');
  Sql_PedidoIT.SQL.Add('where P.CodPedido =:CodPedido and P.CodProduto =:CodPro');

  SQL_PedidoIT.ParamByName('CodPedido').AsString:= CDS_FiltroCODPEDIDO.AsString;
  SQL_PedidoIT.ParamByName('CodPro').AsString:= CDS_MCliProCODPRODUTO.AsString;
  CDS_PedidoIT.Open;
end;

end.
