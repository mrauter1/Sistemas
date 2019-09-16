object Dtm_Notas: TDtm_Notas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 211
  Top = 188
  Height = 444
  Width = 755
  object SQLConnection: TSQLConnection
    ConnectionName = 'Notas'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=C:\Sidicom.new\Banco11.gdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    Connected = True
    Left = 368
    Top = 16
  end
  object DTS_MCliPro: TDataSetProvider
    DataSet = Tbl_MCliPro
    Left = 280
    Top = 144
  end
  object CDS_Cliente: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_Cliente'
    Left = 120
    Top = 200
    object CDS_ClienteCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_ClienteNOMECLIENTE: TStringField
      FieldName = 'NOMECLIENTE'
      Size = 40
    end
    object CDS_ClienteRAZAOSOCIAL: TStringField
      FieldName = 'RAZAOSOCIAL'
      Size = 80
    end
    object CDS_ClienteCODIGOPOSTAL: TStringField
      FieldName = 'CODIGOPOSTAL'
      FixedChar = True
      Size = 8
    end
    object CDS_ClienteNUMEROCGCMF: TStringField
      FieldName = 'NUMEROCGCMF'
      FixedChar = True
      Size = 16
    end
    object CDS_ClienteOBSERVACAO: TMemoField
      FieldName = 'OBSERVACAO'
      BlobType = ftMemo
      Size = 1
    end
  end
  object DTS_Cliente: TDataSetProvider
    DataSet = Tbl_Cliente
    Left = 120
    Top = 144
  end
  object Tbl_Cliente: TSQLTable
    MaxBlobSize = -1
    SQLConnection = SQLConnection
    TableName = 'CLIENTE'
    Left = 120
    Top = 88
  end
  object CDS_Transp: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_Transp'
    Left = 200
    Top = 200
    object CDS_TranspCODTRANSPORTE: TStringField
      FieldName = 'CODTRANSPORTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_TranspNOMETRANSPORTE: TStringField
      FieldName = 'NOMETRANSPORTE'
      FixedChar = True
      Size = 30
    end
    object CDS_TranspCODIGOPOSTAL: TStringField
      FieldName = 'CODIGOPOSTAL'
      FixedChar = True
      Size = 8
    end
    object CDS_TranspNUMEROCGC: TStringField
      FieldName = 'NUMEROCGC'
      FixedChar = True
      Size = 16
    end
  end
  object DTS_Transp: TDataSetProvider
    DataSet = Tbl_Transp
    Left = 200
    Top = 144
  end
  object Tbl_Transp: TSQLTable
    MaxBlobSize = -1
    SQLConnection = SQLConnection
    TableName = 'TRANSP'
    Left = 200
    Top = 88
  end
  object CDS_Produto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_Produto'
    Left = 352
    Top = 200
    object CDS_ProdutoCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_ProdutoCODBARRA: TStringField
      FieldName = 'CODBARRA'
      FixedChar = True
      Size = 13
    end
    object CDS_ProdutoCODGRUPOSUB: TStringField
      FieldName = 'CODGRUPOSUB'
      FixedChar = True
      Size = 7
    end
    object CDS_ProdutoCODFAMILIAPRECO: TStringField
      FieldName = 'CODFAMILIAPRECO'
      FixedChar = True
      Size = 4
    end
    object CDS_ProdutoNOMEGENERICO: TStringField
      FieldName = 'NOMEGENERICO'
      Size = 80
    end
    object CDS_ProdutoAPRESENTACAO: TStringField
      FieldName = 'APRESENTACAO'
      Size = 80
    end
    object CDS_ProdutoCODAPLICACAO: TStringField
      FieldName = 'CODAPLICACAO'
      FixedChar = True
      Size = 4
    end
    object CDS_ProdutoPRINCIPALFOR: TStringField
      FieldName = 'PRINCIPALFOR'
      FixedChar = True
      Size = 6
    end
    object CDS_ProdutoREFERENCIA: TStringField
      FieldName = 'REFERENCIA'
      FixedChar = True
      Size = 15
    end
    object CDS_ProdutoSITUACAOPRO: TStringField
      FieldName = 'SITUACAOPRO'
      FixedChar = True
      Size = 1
    end
    object CDS_ProdutoUNIDADE: TStringField
      FieldName = 'UNIDADE'
      FixedChar = True
      Size = 3
    end
    object CDS_ProdutoUNIDADEESTOQUE: TIntegerField
      FieldName = 'UNIDADEESTOQUE'
    end
    object CDS_ProdutoCODICMVENDA: TStringField
      FieldName = 'CODICMVENDA'
      FixedChar = True
      Size = 2
    end
    object CDS_ProdutoCODICMCOMPRA: TStringField
      FieldName = 'CODICMCOMPRA'
      FixedChar = True
      Size = 2
    end
    object CDS_ProdutoCODIPICOMPRA: TStringField
      FieldName = 'CODIPICOMPRA'
      FixedChar = True
      Size = 2
    end
    object CDS_ProdutoCODIPIVENDA: TStringField
      FieldName = 'CODIPIVENDA'
      FixedChar = True
      Size = 2
    end
    object CDS_ProdutoISS: TFMTBCDField
      FieldName = 'ISS'
      Precision = 15
      Size = 2
    end
    object CDS_ProdutoPESO: TFMTBCDField
      FieldName = 'PESO'
      Precision = 15
      Size = 8
    end
    object CDS_ProdutoCUBAGEM: TFMTBCDField
      FieldName = 'CUBAGEM'
      Precision = 15
      Size = 6
    end
    object CDS_ProdutoDATAINCLUSAO: TDateField
      FieldName = 'DATAINCLUSAO'
    end
    object CDS_ProdutoDATAALTERACAO: TDateField
      FieldName = 'DATAALTERACAO'
    end
    object CDS_ProdutoCLASSEABC: TStringField
      FieldName = 'CLASSEABC'
      FixedChar = True
      Size = 1
    end
    object CDS_ProdutoENTRADALIVRE: TStringField
      FieldName = 'ENTRADALIVRE'
      FixedChar = True
      Size = 1
    end
    object CDS_ProdutoCODNACIONALIDADE: TStringField
      FieldName = 'CODNACIONALIDADE'
      FixedChar = True
      Size = 1
    end
    object CDS_ProdutoCONTROLALOTE: TStringField
      FieldName = 'CONTROLALOTE'
      FixedChar = True
      Size = 1
    end
    object CDS_ProdutoDIASVENCELOTE: TIntegerField
      FieldName = 'DIASVENCELOTE'
    end
    object CDS_ProdutoNAOVENDEZERADO: TStringField
      FieldName = 'NAOVENDEZERADO'
      FixedChar = True
      Size = 1
    end
    object CDS_ProdutoOBSERVACAO: TMemoField
      FieldName = 'OBSERVACAO'
      BlobType = ftMemo
      Size = 1
    end
    object CDS_ProdutoCODCOR: TIntegerField
      FieldName = 'CODCOR'
    end
    object CDS_ProdutoCODTAMANHO: TIntegerField
      FieldName = 'CODTAMANHO'
    end
    object CDS_ProdutoCODICMVENDA8702: TStringField
      FieldName = 'CODICMVENDA8702'
      Required = True
      FixedChar = True
      Size = 2
    end
    object CDS_ProdutoCODMERCOSULNCM: TStringField
      FieldName = 'CODMERCOSULNCM'
      FixedChar = True
      Size = 8
    end
    object CDS_ProdutoNOMESUBUNIDADE: TStringField
      FieldName = 'NOMESUBUNIDADE'
      FixedChar = True
      Size = 6
    end
    object CDS_ProdutoSERVICOISS: TStringField
      FieldName = 'SERVICOISS'
      FixedChar = True
      Size = 1
    end
    object CDS_ProdutoSITUACAOPISCOFINS: TStringField
      FieldName = 'SITUACAOPISCOFINS'
      FixedChar = True
      Size = 1
    end
    object CDS_ProdutoPESOBRUTO: TFMTBCDField
      FieldName = 'PESOBRUTO'
      Precision = 15
      Size = 8
    end
    object CDS_ProdutoMULTIPOVENDA: TFMTBCDField
      FieldName = 'MULTIPOVENDA'
      Precision = 15
      Size = 8
    end
    object CDS_ProdutoMULTIPOLIMITE: TFMTBCDField
      FieldName = 'MULTIPOLIMITE'
      Precision = 15
      Size = 8
    end
    object CDS_ProdutoORDEMDOPRODUTO: TIntegerField
      FieldName = 'ORDEMDOPRODUTO'
    end
    object CDS_ProdutoDIASQUARENTENALOTE: TIntegerField
      FieldName = 'DIASQUARENTENALOTE'
    end
  end
  object DTS_Produto: TDataSetProvider
    DataSet = Tbl_Produto
    Left = 352
    Top = 144
  end
  object Tbl_Produto: TSQLTable
    MaxBlobSize = -1
    SQLConnection = SQLConnection
    TableName = 'PRODUTO'
    Left = 352
    Top = 88
  end
  object Con_MCliPro: TDataSource
    DataSet = CDS_MCliPro
    Left = 280
    Top = 256
  end
  object CDS_MCliPro: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CHAVENF'
    MasterFields = 'CHAVENF'
    MasterSource = Con_Filtro
    PacketRecords = 0
    Params = <>
    ProviderName = 'DTS_MCliPro'
    Left = 280
    Top = 200
    object CDS_MCliProCHAVENFPRO: TStringField
      FieldName = 'CHAVENFPRO'
      Required = True
      FixedChar = True
      Size = 21
    end
    object CDS_MCliProCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 15
    end
    object CDS_MCliProCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_MCliProENTRADASAIDA: TStringField
      FieldName = 'ENTRADASAIDA'
      FixedChar = True
      Size = 1
    end
    object CDS_MCliProSOMOUESTOQUE: TStringField
      FieldName = 'SOMOUESTOQUE'
      FixedChar = True
      Size = 1
    end
    object CDS_MCliProUNIDADEESTOQUE: TIntegerField
      FieldName = 'UNIDADEESTOQUE'
    end
    object CDS_MCliProQUANTATENDIDA: TFMTBCDField
      FieldName = 'QUANTATENDIDA'
      Precision = 15
      Size = 8
    end
    object CDS_MCliProPRECO: TFMTBCDField
      FieldName = 'PRECO'
      Precision = 15
      Size = 8
    end
    object CDS_MCliProCODLISTA: TStringField
      FieldName = 'CODLISTA'
      FixedChar = True
      Size = 4
    end
    object CDS_MCliProALIQIPI: TFMTBCDField
      FieldName = 'ALIQIPI'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProIPIPERCOUVALOR: TStringField
      FieldName = 'IPIPERCOUVALOR'
      FixedChar = True
      Size = 1
    end
    object CDS_MCliProALIQICM: TFMTBCDField
      FieldName = 'ALIQICM'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProALIQICMREDUCAO: TFMTBCDField
      FieldName = 'ALIQICMREDUCAO'
      Precision = 15
      Size = 8
    end
    object CDS_MCliProALIQISS: TFMTBCDField
      FieldName = 'ALIQISS'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProSUBSTVALPER: TStringField
      FieldName = 'SUBSTVALPER'
      FixedChar = True
      Size = 1
    end
    object CDS_MCliProSUBSTMARGEM: TFMTBCDField
      FieldName = 'SUBSTMARGEM'
      Precision = 15
      Size = 8
    end
    object CDS_MCliProSUBSTALIQ: TFMTBCDField
      FieldName = 'SUBSTALIQ'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProDESCONTO1: TFMTBCDField
      FieldName = 'DESCONTO1'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProDESCONTO2: TFMTBCDField
      FieldName = 'DESCONTO2'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProDESCONTO3: TFMTBCDField
      FieldName = 'DESCONTO3'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProDESCONTO4: TFMTBCDField
      FieldName = 'DESCONTO4'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProDESCONTOCALC: TFMTBCDField
      FieldName = 'DESCONTOCALC'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALBRUTO: TFMTBCDField
      FieldName = 'VALBRUTO'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALDESCITEM: TFMTBCDField
      FieldName = 'VALDESCITEM'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALIPI: TFMTBCDField
      FieldName = 'VALIPI'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALSUBSTITUICAO: TFMTBCDField
      FieldName = 'VALSUBSTITUICAO'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALTOTAL: TFMTBCDField
      FieldName = 'VALTOTAL'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALBASEICM: TFMTBCDField
      FieldName = 'VALBASEICM'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALBASESUBST: TFMTBCDField
      FieldName = 'VALBASESUBST'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALICM: TFMTBCDField
      FieldName = 'VALICM'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALISS: TFMTBCDField
      FieldName = 'VALISS'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProPERCCOMISSAO: TFMTBCDField
      FieldName = 'PERCCOMISSAO'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProPERCCOMISSAO2: TFMTBCDField
      FieldName = 'PERCCOMISSAO2'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProPERCCOMISSAO3: TFMTBCDField
      FieldName = 'PERCCOMISSAO3'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALCOMISSAO: TFMTBCDField
      FieldName = 'VALCOMISSAO'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALCOMISSAO2: TFMTBCDField
      FieldName = 'VALCOMISSAO2'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALCOMISSAO3: TFMTBCDField
      FieldName = 'VALCOMISSAO3'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProCODICMMOV: TStringField
      FieldName = 'CODICMMOV'
      Required = True
      FixedChar = True
      Size = 2
    end
    object CDS_MCliProVALBASEIPI: TFMTBCDField
      FieldName = 'VALBASEIPI'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProCODFISCALPRO: TStringField
      FieldName = 'CODFISCALPRO'
      Required = True
      FixedChar = True
      Size = 5
    end
    object CDS_MCliProSEQUENCIADOPRODUTO: TIntegerField
      FieldName = 'SEQUENCIADOPRODUTO'
    end
    object CDS_MCliProMOMENTOCUSTOMEDIO: TFMTBCDField
      FieldName = 'MOMENTOCUSTOMEDIO'
      Precision = 15
      Size = 8
    end
    object CDS_MCliProMOMENTOPRECOBRUTO: TFMTBCDField
      FieldName = 'MOMENTOPRECOBRUTO'
      Precision = 15
      Size = 8
    end
    object CDS_MCliProMOMENTOPRECOLIQUIDO: TFMTBCDField
      FieldName = 'MOMENTOPRECOLIQUIDO'
      Precision = 15
      Size = 8
    end
    object CDS_MCliProVALBASEPISCOFINS: TFMTBCDField
      FieldName = 'VALBASEPISCOFINS'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProALIQPIS: TFMTBCDField
      FieldName = 'ALIQPIS'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProALIQCOFINS: TFMTBCDField
      FieldName = 'ALIQCOFINS'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALPIS: TFMTBCDField
      FieldName = 'VALPIS'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProVALCOFINS: TFMTBCDField
      FieldName = 'VALCOFINS'
      Precision = 15
      Size = 2
    end
    object CDS_MCliProREFERENCIAFORN: TStringField
      FieldKind = fkLookup
      FieldName = 'REFERENCIAFORN'
      LookupDataSet = CDS_Produto
      LookupKeyFields = 'CODPRODUTO'
      LookupResultField = 'REFERENCIA'
      KeyFields = 'CODPRODUTO'
      Size = 15
      Lookup = True
    end
    object CDS_MCliProDESCRICAOPECA: TStringField
      FieldKind = fkLookup
      FieldName = 'DESCRICAOPECA'
      LookupDataSet = CDS_Produto
      LookupKeyFields = 'CODPRODUTO'
      LookupResultField = 'APRESENTACAO'
      KeyFields = 'CODPRODUTO'
      Size = 80
      Lookup = True
    end
    object CDS_MCliProUNIDADE: TStringField
      FieldKind = fkLookup
      FieldName = 'UNIDADE'
      LookupDataSet = CDS_Produto
      LookupKeyFields = 'CODPRODUTO'
      LookupResultField = 'UNIDADE'
      KeyFields = 'CODPRODUTO'
      Size = 3
      Lookup = True
    end
    object CDS_MCliProCLASSIFFISCAL: TStringField
      FieldKind = fkLookup
      FieldName = 'CLASSIFFISCAL'
      LookupDataSet = CDS_Produto
      LookupKeyFields = 'CODPRODUTO'
      LookupResultField = 'CODMERCOSULNCM'
      KeyFields = 'CODPRODUTO'
      Size = 8
      Lookup = True
    end
    object CDS_MCliProSUBUNIDADE: TStringField
      FieldKind = fkLookup
      FieldName = 'SUBUNIDADE'
      LookupDataSet = CDS_Produto
      LookupKeyFields = 'CODPRODUTO'
      LookupResultField = 'NOMESUBUNIDADE'
      KeyFields = 'CODPRODUTO'
      Size = 6
      Lookup = True
    end
  end
  object Tbl_MCliPro: TSQLTable
    MaxBlobSize = -1
    SQLConnection = SQLConnection
    TableName = 'MCLIPRO'
    Left = 280
    Top = 88
  end
  object SQL_Filtro: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select *'
      'from MCli'
      ''
      ''
      '')
    SQLConnection = SQLConnection
    Left = 280
    Top = 328
  end
  object Con_Filtro: TDataSource
    DataSet = CDS_Filtro
    Left = 368
    Top = 328
  end
  object DTS_Filtro: TDataSetProvider
    DataSet = SQL_Filtro
    Left = 192
    Top = 328
  end
  object CDS_Filtro: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_Filtro'
    Left = 120
    Top = 328
    object CDS_FiltroCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 15
    end
    object CDS_FiltroCLIENTEOUFILIAL: TStringField
      FieldName = 'CLIENTEOUFILIAL'
      FixedChar = True
      Size = 1
    end
    object CDS_FiltroCODFILIAL: TStringField
      FieldName = 'CODFILIAL'
      FixedChar = True
      Size = 2
    end
    object CDS_FiltroCODCOMPROVANTE: TStringField
      FieldName = 'CODCOMPROVANTE'
      FixedChar = True
      Size = 3
    end
    object CDS_FiltroSERIE: TStringField
      FieldName = 'SERIE'
      FixedChar = True
      Size = 4
    end
    object CDS_FiltroNUMERO: TStringField
      FieldName = 'NUMERO'
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroCODFISCAL: TStringField
      FieldName = 'CODFISCAL'
      FixedChar = True
      Size = 5
    end
    object CDS_FiltroDATADOCUMENTO: TDateField
      FieldName = 'DATADOCUMENTO'
    end
    object CDS_FiltroDATACOMPROVANTE: TDateField
      FieldName = 'DATACOMPROVANTE'
    end
    object CDS_FiltroCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroSITUACAONF: TStringField
      FieldName = 'SITUACAONF'
      FixedChar = True
      Size = 1
    end
    object CDS_FiltroCODCONDICAO: TStringField
      FieldName = 'CODCONDICAO'
      FixedChar = True
      Size = 3
    end
    object CDS_FiltroCODDPTO: TStringField
      FieldName = 'CODDPTO'
      FixedChar = True
      Size = 3
    end
    object CDS_FiltroCODPEDIDO: TStringField
      FieldName = 'CODPEDIDO'
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroNUMEROCUPOM: TStringField
      FieldName = 'NUMEROCUPOM'
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroCODVENDEDOR: TStringField
      FieldName = 'CODVENDEDOR'
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroCODVENDEDOR2: TStringField
      FieldName = 'CODVENDEDOR2'
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroCODVENDEDOR3: TStringField
      FieldName = 'CODVENDEDOR3'
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroCODCAIXA: TStringField
      FieldName = 'CODCAIXA'
      FixedChar = True
      Size = 2
    end
    object CDS_FiltroCODDIGITADOR: TStringField
      FieldName = 'CODDIGITADOR'
      FixedChar = True
      Size = 2
    end
    object CDS_FiltroCODTRANSPORTADORA: TStringField
      FieldName = 'CODTRANSPORTADORA'
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroCODCENTROCUSTO: TStringField
      FieldName = 'CODCENTROCUSTO'
      FixedChar = True
      Size = 7
    end
    object CDS_FiltroTRANFRETE: TStringField
      FieldName = 'TRANFRETE'
      FixedChar = True
      Size = 1
    end
    object CDS_FiltroCONVENIADO: TStringField
      FieldName = 'CONVENIADO'
      FixedChar = True
      Size = 15
    end
    object CDS_FiltroISENTOICM: TStringField
      FieldName = 'ISENTOICM'
      FixedChar = True
      Size = 1
    end
    object CDS_FiltroISENTOIPI: TStringField
      FieldName = 'ISENTOIPI'
      FixedChar = True
      Size = 1
    end
    object CDS_FiltroISENTOSUBST: TStringField
      FieldName = 'ISENTOSUBST'
      FixedChar = True
      Size = 1
    end
    object CDS_FiltroDBCR: TStringField
      FieldName = 'DBCR'
      FixedChar = True
      Size = 1
    end
    object CDS_FiltroTOTITENS: TIntegerField
      FieldName = 'TOTITENS'
    end
    object CDS_FiltroTOTBRUTO: TFMTBCDField
      FieldName = 'TOTBRUTO'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTDESCITEM: TFMTBCDField
      FieldName = 'TOTDESCITEM'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTIPI: TFMTBCDField
      FieldName = 'TOTIPI'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroSUBSTITUICAO: TFMTBCDField
      FieldName = 'SUBSTITUICAO'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTBASESUBST: TFMTBCDField
      FieldName = 'TOTBASESUBST'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTFRETE: TFMTBCDField
      FieldName = 'TOTFRETE'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTDESPESAS: TFMTBCDField
      FieldName = 'TOTDESPESAS'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTNOTA: TFMTBCDField
      FieldName = 'TOTNOTA'
      DisplayFormat = '#.00'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTICM: TFMTBCDField
      FieldName = 'TOTICM'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTBASEICM: TFMTBCDField
      FieldName = 'TOTBASEICM'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTISS: TFMTBCDField
      FieldName = 'TOTISS'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTCOMISSAO: TFMTBCDField
      FieldName = 'TOTCOMISSAO'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTCOMISSAO2: TFMTBCDField
      FieldName = 'TOTCOMISSAO2'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTCOMISSAO3: TFMTBCDField
      FieldName = 'TOTCOMISSAO3'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 100
    end
    object CDS_FiltroHORAMOVIMENTO: TTimeField
      FieldName = 'HORAMOVIMENTO'
    end
    object CDS_FiltroCODORDEMPRODUCAO: TStringField
      FieldName = 'CODORDEMPRODUCAO'
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroCOMP_ANOMES: TStringField
      FieldName = 'COMP_ANOMES'
      Size = 13
    end
    object CDS_FiltroCONTRIBUINTE: TStringField
      FieldName = 'CONTRIBUINTE'
      FixedChar = True
      Size = 1
    end
    object CDS_FiltroTOTVALORPAGO: TFMTBCDField
      FieldName = 'TOTVALORPAGO'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroENDERECOCONVENIO: TStringField
      FieldName = 'ENDERECOCONVENIO'
      FixedChar = True
      Size = 1
    end
    object CDS_FiltroTOTBASEIPI: TFMTBCDField
      FieldName = 'TOTBASEIPI'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroNAOSOMAESTOQUE: TStringField
      FieldName = 'NAOSOMAESTOQUE'
      FixedChar = True
      Size = 1
    end
    object CDS_FiltroTRANVOLUME: TStringField
      FieldName = 'TRANVOLUME'
      FixedChar = True
      Size = 10
    end
    object CDS_FiltroTRANQUANTIDADE: TIntegerField
      FieldName = 'TRANQUANTIDADE'
    end
    object CDS_FiltroTRANPESOBRUTO: TFMTBCDField
      FieldName = 'TRANPESOBRUTO'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTRANPESOLIQUIDO: TFMTBCDField
      FieldName = 'TRANPESOLIQUIDO'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTRANCUBAGEM: TFMTBCDField
      FieldName = 'TRANCUBAGEM'
      Precision = 15
      Size = 5
    end
    object CDS_FiltroTOTBASEPISCOFINS: TFMTBCDField
      FieldName = 'TOTBASEPISCOFINS'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTPIS: TFMTBCDField
      FieldName = 'TOTPIS'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTOTCOFINS: TFMTBCDField
      FieldName = 'TOTCOFINS'
      Precision = 15
      Size = 2
    end
    object CDS_FiltroTERCEIROPROPRIO: TStringField
      FieldName = 'TERCEIROPROPRIO'
      FixedChar = True
      Size = 1
    end
    object CDS_FiltroCGCMFDEST: TStringField
      FieldKind = fkLookup
      FieldName = 'CGCMFDEST'
      LookupDataSet = CDS_Cliente
      LookupKeyFields = 'CODCLIENTE'
      LookupResultField = 'NUMEROCGCMF'
      KeyFields = 'CODCLIENTE'
      Size = 16
      Lookup = True
    end
    object CDS_FiltroCGCTRANSP: TStringField
      FieldKind = fkLookup
      FieldName = 'CGCTRANSP'
      LookupDataSet = CDS_Transp
      LookupKeyFields = 'CODTRANSPORTE'
      LookupResultField = 'NUMEROCGC'
      KeyFields = 'CODTRANSPORTADORA'
      Size = 16
      Lookup = True
    end
    object CDS_FiltroNOMEDEST: TStringField
      FieldKind = fkLookup
      FieldName = 'NOMEDEST'
      LookupDataSet = CDS_Cliente
      LookupKeyFields = 'CODCLIENTE'
      LookupResultField = 'NOMECLIENTE'
      KeyFields = 'CODCLIENTE'
      Size = 40
      Lookup = True
    end
    object CDS_FiltroMOSTRASUBUN: TStringField
      FieldKind = fkLookup
      FieldName = 'MOSTRASUBUN'
      LookupDataSet = CDS_Pedido
      LookupKeyFields = 'CODPEDIDO'
      LookupResultField = 'MOSTRASUBUN_SN'
      KeyFields = 'CODPEDIDO'
      Size = 1
      Lookup = True
    end
  end
  object DTS_Fatura: TDataSetProvider
    DataSet = Tbl_Fatura
    Left = 424
    Top = 144
  end
  object CDS_Fatura: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CHAVENF'
    MasterFields = 'CHAVENF'
    MasterSource = Con_Filtro
    PacketRecords = 0
    Params = <>
    ProviderName = 'DTS_Fatura'
    Left = 424
    Top = 200
    object CDS_FaturaCHAVENFPRESTACAO: TStringField
      FieldName = 'CHAVENFPRESTACAO'
      Required = True
      FixedChar = True
      Size = 17
    end
    object CDS_FaturaCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 15
    end
    object CDS_FaturaMARCA: TStringField
      FieldName = 'MARCA'
      FixedChar = True
      Size = 1
    end
    object CDS_FaturaCODFILIAL: TStringField
      FieldName = 'CODFILIAL'
      FixedChar = True
      Size = 2
    end
    object CDS_FaturaNUMPRESTACAO: TStringField
      FieldName = 'NUMPRESTACAO'
      FixedChar = True
      Size = 2
    end
    object CDS_FaturaCODCOMPROVANTE: TStringField
      FieldName = 'CODCOMPROVANTE'
      FixedChar = True
      Size = 3
    end
    object CDS_FaturaSERIE: TStringField
      FieldName = 'SERIE'
      FixedChar = True
      Size = 4
    end
    object CDS_FaturaNUMERO: TStringField
      FieldName = 'NUMERO'
      FixedChar = True
      Size = 6
    end
    object CDS_FaturaCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_FaturaCODCONDICAO: TStringField
      FieldName = 'CODCONDICAO'
      FixedChar = True
      Size = 3
    end
    object CDS_FaturaDATACOMPROVANTE: TDateField
      FieldName = 'DATACOMPROVANTE'
    end
    object CDS_FaturaDATAVENCIMENTO: TDateField
      FieldName = 'DATAVENCIMENTO'
    end
    object CDS_FaturaCODPEDIDO: TStringField
      FieldName = 'CODPEDIDO'
      FixedChar = True
      Size = 6
    end
    object CDS_FaturaTOTNOTA: TFMTBCDField
      FieldName = 'TOTNOTA'
      Precision = 15
      Size = 2
    end
    object CDS_FaturaTOTPRESTACAO: TFMTBCDField
      FieldName = 'TOTPRESTACAO'
      Precision = 15
      Size = 2
    end
  end
  object Tbl_Fatura: TSQLTable
    MaxBlobSize = -1
    SQLConnection = SQLConnection
    TableName = 'MCLIRECB'
    Left = 424
    Top = 88
  end
  object Dts_Msg: TDataSetProvider
    DataSet = Tbl_Msg
    Left = 40
    Top = 144
  end
  object CDS_Msg: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CHAVENF'
    MasterFields = 'CHAVENF'
    MasterSource = Con_Filtro
    PacketRecords = 0
    Params = <>
    ProviderName = 'Dts_Msg'
    Left = 40
    Top = 200
    object CDS_MsgCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 15
    end
    object CDS_MsgOBSERVACAO1: TMemoField
      FieldName = 'OBSERVACAO1'
      BlobType = ftMemo
      Size = 1
    end
  end
  object Tbl_Msg: TSQLTable
    MaxBlobSize = -1
    SQLConnection = SQLConnection
    TableName = 'MCLIMENSAGEM'
    Left = 40
    Top = 88
  end
  object CDS_Pedido: TClientDataSet
    Aggregates = <>
    MasterSource = Con_Filtro
    PacketRecords = 0
    Params = <>
    ProviderName = 'Dts_Pedido'
    Left = 496
    Top = 200
    object CDS_PedidoCODPEDIDO: TStringField
      FieldName = 'CODPEDIDO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_PedidoMOSTRASUBUN_SN: TStringField
      FieldName = 'MOSTRASUBUN_SN'
      FixedChar = True
      Size = 1
    end
  end
  object Dts_Pedido: TDataSetProvider
    DataSet = Tbl_Pedido
    Left = 496
    Top = 144
  end
  object Tbl_Pedido: TSQLTable
    MaxBlobSize = -1
    SQLConnection = SQLConnection
    TableName = 'PEDIDO'
    Left = 496
    Top = 88
  end
  object CDS_PedidoIT: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_PedidoIT'
    Left = 568
    Top = 200
    object CDS_PedidoITCODPEDIDO: TStringField
      FieldName = 'CODPEDIDO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_PedidoITCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_PedidoITORDEMCOMPRA: TStringField
      FieldName = 'ORDEMCOMPRA'
      FixedChar = True
      Size = 10
    end
  end
  object DTS_PedidoIT: TDataSetProvider
    DataSet = SQL_PedidoIT
    Left = 568
    Top = 144
  end
  object SQL_PedidoIT: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select *'
      'from PedidoIT')
    SQLConnection = SQLConnection
    Left = 568
    Top = 88
  end
  object SQL: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnection
    Left = 656
    Top = 88
  end
end
