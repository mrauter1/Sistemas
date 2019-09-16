object Dtm_DNF: TDtm_DNF
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 336
  Top = 192
  Height = 330
  Width = 418
  object Connnection: TSQLConnection
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
    Top = 16
  end
  object SQL_Filtro: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'Select M.ChaveNF, M.Numero, M.Serie, M.DataDocumento,  C.NomeCli' +
        'ente,'
      
        'M.DataComprovante, C.CodCliente, C.NumeroCGCMF, C.NumeroCPF, M.C' +
        'odPedido'
      'from MCli M, Cliente C'
      'where C.CodCliente = M.CodCliente'
      ''
      ''
      '')
    SQLConnection = Connnection
    Left = 40
    Top = 80
  end
  object Con_Filtro: TDataSource
    DataSet = CDS_Filtro
    Left = 40
    Top = 224
  end
  object DTS_Filtro: TDataSetProvider
    DataSet = SQL_Filtro
    Left = 40
    Top = 128
  end
  object CDS_Filtro: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_Filtro'
    Left = 40
    Top = 176
    object CDS_FiltroCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 15
    end
    object CDS_FiltroNUMERO: TStringField
      FieldName = 'NUMERO'
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroSERIE: TStringField
      FieldName = 'SERIE'
      FixedChar = True
      Size = 4
    end
    object CDS_FiltroDATADOCUMENTO: TDateField
      FieldName = 'DATADOCUMENTO'
    end
    object CDS_FiltroDATACOMPROVANTE: TDateField
      FieldName = 'DATACOMPROVANTE'
    end
    object CDS_FiltroCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroNUMEROCGCMF: TStringField
      FieldName = 'NUMEROCGCMF'
      FixedChar = True
      Size = 16
    end
    object CDS_FiltroNUMEROCPF: TStringField
      FieldName = 'NUMEROCPF'
      FixedChar = True
      Size = 12
    end
    object CDS_FiltroNOMECLIENTE: TStringField
      FieldName = 'NOMECLIENTE'
      Size = 40
    end
    object CDS_FiltroCODPEDIDO: TStringField
      FieldName = 'CODPEDIDO'
      FixedChar = True
      Size = 6
    end
    object CDS_FiltroSubUn: TStringField
      FieldKind = fkLookup
      FieldName = 'SubUn'
      LookupDataSet = CDS_Pedido
      LookupKeyFields = 'CODPEDIDO'
      LookupResultField = 'MOSTRASUBUN_SN'
      KeyFields = 'CODPEDIDO'
      Size = 1
      Lookup = True
    end
  end
  object Tbl_MCliPro: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Connnection
    TableName = 'MCLIPRO'
    Left = 120
    Top = 80
  end
  object DS_MCliPro: TDataSource
    DataSet = CDS_MCliPro
    Left = 120
    Top = 224
  end
  object Dts_MCliPro: TDataSetProvider
    DataSet = Tbl_MCliPro
    Left = 120
    Top = 128
  end
  object CDS_MCliPro: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CHAVENF'
    MasterFields = 'CHAVENF'
    MasterSource = Con_Filtro
    PacketRecords = 0
    Params = <>
    ProviderName = 'Dts_MCliPro'
    Left = 120
    Top = 176
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
    object CDS_MCliProUNIDADEESTOQUE: TIntegerField
      FieldName = 'UNIDADEESTOQUE'
    end
    object CDS_MCliProQUANTATENDIDA: TFMTBCDField
      FieldName = 'QUANTATENDIDA'
      Precision = 15
      Size = 8
    end
    object CDS_MCliProCODFISCALPRO: TStringField
      FieldName = 'CODFISCALPRO'
      Required = True
      FixedChar = True
      Size = 5
    end
    object CDS_MCliProPRECO: TFMTBCDField
      FieldName = 'PRECO'
      Precision = 15
      Size = 8
    end
    object CDS_MCliProALIQIPI: TFMTBCDField
      FieldName = 'ALIQIPI'
      Precision = 15
      Size = 2
    end
  end
  object Tbl_Pro: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Connnection
    TableName = 'PRODUTO'
    Left = 200
    Top = 80
  end
  object DTS_Pro: TDataSetProvider
    DataSet = Tbl_Pro
    Left = 200
    Top = 128
  end
  object CDS_Pro: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CODPRODUTO'
    MasterFields = 'CODPRODUTO'
    MasterSource = DS_MCliPro
    PacketRecords = 0
    Params = <>
    ProviderName = 'DTS_Pro'
    Left = 200
    Top = 176
    object CDS_ProCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_ProCODBARRA: TStringField
      FieldName = 'CODBARRA'
      FixedChar = True
      Size = 13
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
    object CDS_ProNOMESUBUNIDADE: TStringField
      FieldName = 'NOMESUBUNIDADE'
      FixedChar = True
      Size = 6
    end
    object CDS_ProPESO: TFMTBCDField
      FieldName = 'PESO'
      Precision = 15
      Size = 8
    end
  end
  object Tbl_Grupo: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Connnection
    TableName = 'GRUPOSUB'
    Left = 272
    Top = 80
  end
  object DTS_Grupo: TDataSetProvider
    DataSet = Tbl_Grupo
    Left = 272
    Top = 128
  end
  object CDS_Grupo: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'CODGRUPOSUB'
    MasterFields = 'CODGRUPOSUB'
    MasterSource = DS_Pro
    PacketRecords = 0
    Params = <>
    ProviderName = 'DTS_Grupo'
    Left = 272
    Top = 176
    object CDS_GrupoCODGRUPOSUB: TStringField
      FieldName = 'CODGRUPOSUB'
      Required = True
      FixedChar = True
      Size = 7
    end
    object CDS_GrupoCODGRUPO: TStringField
      FieldName = 'CODGRUPO'
      FixedChar = True
      Size = 3
    end
  end
  object DS_Pro: TDataSource
    DataSet = CDS_Pro
    Left = 200
    Top = 224
  end
  object Tbl_Pedido: TSQLTable
    MaxBlobSize = -1
    SQLConnection = Connnection
    TableName = 'PEDIDO'
    Left = 336
    Top = 80
  end
  object Dts_Pedido: TDataSetProvider
    DataSet = Tbl_Pedido
    Left = 336
    Top = 128
  end
  object CDS_Pedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Dts_Pedido'
    Left = 336
    Top = 176
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
end
