object Dtm_PF: TDtm_PF
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 261
  Top = 115
  Height = 489
  Width = 687
  object Connection: TSQLConnection
    ConnectionName = 'IBConnection'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=C:\sidicom.new\banco11.gdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    Left = 24
    Top = 256
  end
  object DTS_Pro: TDataSetProvider
    DataSet = SQL_Pro
    Left = 16
    Top = 64
  end
  object CDS_Pro: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_Pro'
    Left = 16
    Top = 112
    object CDS_ProCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_ProCODGRUPOSUB: TStringField
      FieldName = 'CODGRUPOSUB'
      FixedChar = True
      Size = 7
    end
    object CDS_ProAPRESENTACAO: TStringField
      FieldName = 'APRESENTACAO'
      Size = 80
    end
    object CDS_ProUNIDADE: TStringField
      FieldName = 'UNIDADE'
      FixedChar = True
      Size = 3
    end
    object CDS_ProUNIDADEESTOQUE: TIntegerField
      FieldName = 'UNIDADEESTOQUE'
    end
    object CDS_ProPESO: TFMTBCDField
      FieldName = 'PESO'
      Precision = 15
      Size = 8
    end
    object CDS_ProCUBAGEM: TFMTBCDField
      FieldName = 'CUBAGEM'
      Precision = 15
      Size = 6
    end
  end
  object DS_Pro: TDataSource
    DataSet = CDS_Pro
    Left = 16
    Top = 160
  end
  object SQL_Pro: TSQLQuery
    BeforeOpen = SQL_ProBeforeOpen
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select *'
      'From Produto'
      ''
      '')
    SQLConnection = Connection
    Left = 16
    Top = 16
  end
  object Tbl_Cli: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Connection
    TableName = 'CLIENTE'
    Left = 120
    Top = 168
  end
  object DTS_Cli: TDataSetProvider
    DataSet = Tbl_Cli
    Left = 120
    Top = 216
  end
  object CDS_Cli: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_Cli'
    Left = 120
    Top = 264
    object CDS_CliCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_CliRAZAOSOCIAL: TStringField
      FieldName = 'RAZAOSOCIAL'
      Size = 80
    end
    object CDS_CliENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 45
    end
    object CDS_CliCIDADE: TStringField
      FieldName = 'CIDADE'
      FixedChar = True
      Size = 25
    end
    object CDS_CliESTADO: TStringField
      FieldName = 'ESTADO'
      FixedChar = True
      Size = 2
    end
    object CDS_CliCODIGOPOSTAL: TStringField
      FieldName = 'CODIGOPOSTAL'
      FixedChar = True
      Size = 8
    end
    object CDS_CliNUMEROCGCMF: TStringField
      FieldName = 'NUMEROCGCMF'
      FixedChar = True
      Size = 16
    end
  end
  object Tbl_Fone: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Connection
    TableName = 'CLIENTEFONE'
    Left = 232
    Top = 176
  end
  object DTS_Fone: TDataSetProvider
    DataSet = Tbl_Fone
    Left = 232
    Top = 224
  end
  object CDS_Fone: TClientDataSet
    Aggregates = <>
    MasterSource = DS_Cli
    PacketRecords = 0
    Params = <>
    ProviderName = 'DTS_Fone'
    Left = 232
    Top = 272
    object CDS_FoneCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_FoneTELEFONE: TStringField
      FieldName = 'TELEFONE'
      FixedChar = True
      Size = 15
    end
    object CDS_FoneCONTATO: TStringField
      FieldName = 'CONTATO'
      Size = 40
    end
  end
  object DS_Cli: TDataSource
    DataSet = CDS_Cli
    Left = 120
    Top = 312
  end
  object DTS_GrupoSub: TDataSetProvider
    DataSet = Tbl_GrupoSub
    Left = 94
    Top = 56
  end
  object CDS_GrupoSub: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CODGRUPOSUB'
    MasterFields = 'CODGRUPOSUB'
    MasterSource = DS_Pro
    PacketRecords = 0
    Params = <>
    ProviderName = 'Dts_GrupoSub'
    Left = 94
    Top = 104
    object CDS_GrupoSubCODGRUPOSUB: TStringField
      FieldName = 'CODGRUPOSUB'
      Required = True
      FixedChar = True
      Size = 7
    end
    object CDS_GrupoSubCODGRUPO: TStringField
      FieldName = 'CODGRUPO'
      FixedChar = True
      Size = 3
    end
    object CDS_GrupoSubCODSUBGRUPO: TStringField
      FieldName = 'CODSUBGRUPO'
      FixedChar = True
      Size = 4
    end
    object CDS_GrupoSubNOMESUBGRUPO: TStringField
      FieldName = 'NOMESUBGRUPO'
      FixedChar = True
      Size = 30
    end
  end
  object Tbl_GrupoSub: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Connection
    TableName = 'GRUPOSUB'
    Left = 96
    Top = 8
  end
  object CDS_Estoque: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_Estoque'
    Left = 208
    Top = 104
    object CDS_EstoqueCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_EstoqueSALDOATUAL: TFMTBCDField
      FieldName = 'SALDOATUAL'
      Precision = 15
      Size = 8
    end
    object CDS_EstoqueCODANOMES: TStringField
      FieldName = 'CODANOMES'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_EstoqueCODGRUPOSUB: TStringField
      FieldName = 'CODGRUPOSUB'
      FixedChar = True
      Size = 7
    end
    object CDS_EstoqueCUBAGEM: TFMTBCDField
      FieldName = 'CUBAGEM'
      Precision = 15
      Size = 6
    end
    object CDS_EstoqueUNIDADEESTOQUE: TIntegerField
      FieldName = 'UNIDADEESTOQUE'
    end
  end
  object DTS_Estoque: TDataSetProvider
    DataSet = SQL_Estoque
    Left = 208
    Top = 56
  end
  object SQL_Estoque: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'Select EM.CodProduto, EM.SaldoAtual, EM.Codanomes, Produto.CodGr' +
        'upoSub, Produto.Cubagem, Produto.UnidadeEstoque'
      'from EstoqMes EM, Produto'
      'where Produto.CodProduto = EM.CodProduto')
    SQLConnection = Connection
    Left = 208
    Top = 8
  end
  object SQL_QTCompra: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'Select MP.ChaveNFPro, MP.CodProduto, MP.QuantAtendida, MC.ChaveN' +
        'F'
      'From MCliPro MP, MCli MC'
      'where MP.ChaveNF = MC.ChaveNF')
    SQLConnection = Connection
    Left = 296
    Top = 16
  end
  object CDS_QTVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_QTVenda'
    Left = 424
    Top = 114
    object CDS_QTVendaCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_QTVendaQUANT: TFMTBCDField
      FieldName = 'QUANT'
      Precision = 15
      Size = 8
    end
    object CDS_QTVendaCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 21
    end
  end
  object DTS_QTVenda: TDataSetProvider
    DataSet = SQL_QTVenda
    Left = 424
    Top = 66
  end
  object SQL_QTVenda: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select MP.CodProduto, MP.Quant, MF.ChaveNF'
      'From MForPro MP, MFor MF'
      'where MP.ChaveNF = MF.ChaveNF')
    SQLConnection = Connection
    Left = 424
    Top = 16
  end
  object CDS_QTCompra: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_QTCompra'
    Left = 296
    Top = 113
    object CDS_QTCompraCHAVENFPRO: TStringField
      FieldName = 'CHAVENFPRO'
      Required = True
      FixedChar = True
      Size = 21
    end
    object CDS_QTCompraCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_QTCompraCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 15
    end
    object CDS_QTCompraQUANTATENDIDA: TFMTBCDField
      FieldName = 'QUANTATENDIDA'
      Precision = 15
      Size = 8
    end
  end
  object DTS_QTCompra: TDataSetProvider
    DataSet = SQL_QTCompra
    Left = 296
    Top = 65
  end
  object DTS_MCli: TDataSetProvider
    DataSet = SQL_MCli
    Left = 320
    Top = 216
  end
  object CDS_MCli: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_MCli'
    Left = 320
    Top = 264
    object CDS_MCliNUMERO: TStringField
      FieldName = 'NUMERO'
      FixedChar = True
      Size = 6
    end
    object CDS_MCliDATADOCUMENTO: TDateField
      FieldName = 'DATADOCUMENTO'
    end
    object CDS_MCliCHAVENFPRO: TStringField
      FieldName = 'CHAVENFPRO'
      Required = True
      FixedChar = True
      Size = 21
    end
    object CDS_MCliCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 15
    end
    object CDS_MCliCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_MCliUNIDADEESTOQUE: TIntegerField
      FieldName = 'UNIDADEESTOQUE'
    end
    object CDS_MCliQUANTATENDIDA: TFMTBCDField
      FieldName = 'QUANTATENDIDA'
      Precision = 15
      Size = 8
    end
    object CDS_MCliCODFISCAL: TStringField
      FieldName = 'CODFISCAL'
      FixedChar = True
      Size = 5
    end
    object CDS_MCliCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      FixedChar = True
      Size = 6
    end
    object CDS_MCliCODTRANSPORTADORA: TStringField
      FieldName = 'CODTRANSPORTADORA'
      FixedChar = True
      Size = 6
    end
  end
  object SQL_MCli: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select MCli.*, MCliPro.*'
      'From MCli, MCliPro'
      'where MCliPro.ChaveNF = MCli.ChaveNF'
      ''
      '')
    SQLConnection = Connection
    Left = 320
    Top = 168
  end
  object DTS_MFor: TDataSetProvider
    DataSet = SQL_MFor
    Left = 416
    Top = 216
  end
  object CDS_MFor: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_MFor'
    Left = 416
    Top = 264
    object CDS_MForCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 21
    end
    object CDS_MForDATACOMPROVANTE: TDateField
      FieldName = 'DATACOMPROVANTE'
      Required = True
    end
    object CDS_MForNUMERO: TStringField
      FieldName = 'NUMERO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_MForDATAENTRADA: TDateField
      FieldName = 'DATAENTRADA'
      Required = True
    end
    object CDS_MForCODFISCAL: TStringField
      FieldName = 'CODFISCAL'
      FixedChar = True
      Size = 5
    end
    object CDS_MForCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_MForUNIDADEESTOQUE: TIntegerField
      FieldName = 'UNIDADEESTOQUE'
    end
    object CDS_MForQUANT: TFMTBCDField
      FieldName = 'QUANT'
      Precision = 15
      Size = 8
    end
    object CDS_MForCODFORNECEDOR: TStringField
      FieldName = 'CODFORNECEDOR'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_MForTRANCODTRANSPORTE: TStringField
      FieldName = 'TRANCODTRANSPORTE'
      FixedChar = True
      Size = 6
    end
  end
  object SQL_MFor: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select MFor.*, MForPro.*'
      'From MFor, MForPro'
      'where MForPro.ChaveNF = MFor.ChaveNF'
      ''
      '')
    SQLConnection = Connection
    Left = 416
    Top = 168
  end
  object Tbl_Cli1: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Connection
    TableName = 'CLIENTE'
    Left = 504
    Top = 168
  end
  object DTS_Cli1: TDataSetProvider
    DataSet = Tbl_Cli1
    Left = 504
    Top = 216
  end
  object CDS_Cli1: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CODCLIENTE'
    MasterFields = 'CODCLIENTE'
    MasterSource = DS_MCli
    PacketRecords = 0
    Params = <>
    ProviderName = 'DTS_Cli1'
    Left = 504
    Top = 264
    object StringField1: TStringField
      FieldName = 'CODCLIENTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_Cli1NUMEROCGCMF: TStringField
      FieldName = 'NUMEROCGCMF'
      FixedChar = True
      Size = 16
    end
  end
  object DS_MCli: TDataSource
    DataSet = CDS_MCli
    Left = 320
    Top = 320
  end
  object DS_MFor: TDataSource
    DataSet = CDS_MFor
    Left = 416
    Top = 320
  end
  object Tbl_For: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Connection
    TableName = 'FORNECED'
    Left = 528
    Top = 8
  end
  object DTS_For: TDataSetProvider
    DataSet = Tbl_For
    Left = 528
    Top = 56
  end
  object CDS_For: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CODFORNECEDOR'
    MasterFields = 'CODFORNECEDOR'
    MasterSource = DS_MFor
    PacketRecords = 0
    Params = <>
    ProviderName = 'DTS_For'
    Left = 528
    Top = 104
    object CDS_ForCODFORNECEDOR: TStringField
      FieldName = 'CODFORNECEDOR'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_ForNUMEROCGCMF: TStringField
      FieldName = 'NUMEROCGCMF'
      FixedChar = True
      Size = 16
    end
  end
  object DTS_Transp: TDataSetProvider
    DataSet = SQL_Transp
    Left = 584
    Top = 216
  end
  object CDS_Transp: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_Transp'
    Left = 584
    Top = 264
    object CDS_TranspCODTRANSPORTE: TStringField
      FieldName = 'CODTRANSPORTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_TranspNUMEROCGC: TStringField
      FieldName = 'NUMEROCGC'
      FixedChar = True
      Size = 16
    end
  end
  object SQL_Transp: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select *'
      'From Transp')
    SQLConnection = Connection
    Left = 584
    Top = 168
  end
  object DTS_Sub_Gru: TDataSetProvider
    DataSet = SQL_Sub_Gru
    Left = 616
    Top = 56
  end
  object CDS_Sub_Gru: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_Sub_Gru'
    Left = 616
    Top = 104
    object CDS_Sub_GruCODGRUPOSUB: TStringField
      FieldName = 'CODGRUPOSUB'
      Required = True
      FixedChar = True
      Size = 7
    end
    object CDS_Sub_GruCODGRUPO: TStringField
      FieldName = 'CODGRUPO'
      FixedChar = True
      Size = 3
    end
  end
  object SQL_Sub_Gru: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'Select *'
      'From GrupoSub')
    SQLConnection = Connection
    Left = 616
    Top = 8
  end
end
