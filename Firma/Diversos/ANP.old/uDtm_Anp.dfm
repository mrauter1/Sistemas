object Dtm_Anp: TDtm_Anp
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 224
  Top = 140
  Height = 389
  Width = 450
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
    Connected = True
    Left = 24
    Top = 16
  end
  object SQL_MovCli: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'select MC.ChaveNF, MC.DataDocumento, MC.Numero, MC.Serie,  MC.Co' +
        'dCliente, '
      'MC.CodComprovante, MCPro.CodProduto, MCPro.QuantAtendida'
      'from MCli MC, MCliPro MCPro'
      'where MCPro.ChaveNF = MC.ChaveNF'
      'order by MC.DataDocumento')
    SQLConnection = Connnection
    Left = 96
    Top = 48
  end
  object DS_MovCli: TDataSource
    DataSet = Cds_MovCli
    Left = 96
    Top = 192
  end
  object Dts_MovCli: TDataSetProvider
    DataSet = SQL_MovCli
    Left = 96
    Top = 96
  end
  object Cds_MovCli: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Dts_MovCli'
    Left = 96
    Top = 144
    object Cds_MovCliCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 15
    end
    object Cds_MovCliNUMERO: TStringField
      FieldName = 'NUMERO'
      FixedChar = True
      Size = 6
    end
    object Cds_MovCliSERIE: TStringField
      FieldName = 'SERIE'
      FixedChar = True
      Size = 4
    end
    object Cds_MovCliCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      FixedChar = True
      Size = 6
    end
    object Cds_MovCliCODCOMPROVANTE: TStringField
      FieldName = 'CODCOMPROVANTE'
      FixedChar = True
      Size = 3
    end
    object Cds_MovCliDATADOCUMENTO: TDateField
      FieldName = 'DATADOCUMENTO'
    end
    object Cds_MovCliCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object Cds_MovCliQUANTATENDIDA: TFMTBCDField
      FieldName = 'QUANTATENDIDA'
      Precision = 15
    end
  end
  object SQL_MovFor: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select MF.ChaveNF, MF.DataEntrada, MF.Numero, MF.Serie,'
      'MF.CodFornecedor, MFPro.CodProduto, MFPro.Quant'
      'from MFor MF, MForPro MFPro'
      'where MFPro.ChaveNF = MF.ChaveNF'
      'order by MF.DataEntrada'
      '')
    SQLConnection = Connnection
    Left = 208
    Top = 48
  end
  object DS_MovFor: TDataSource
    DataSet = CDS_MovFor
    Left = 208
    Top = 192
  end
  object Dts_MovFor: TDataSetProvider
    DataSet = SQL_MovFor
    Left = 208
    Top = 96
  end
  object CDS_MovFor: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Dts_MovFor'
    Left = 208
    Top = 144
    object CDS_MovForCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 21
    end
    object CDS_MovForNUMERO: TStringField
      FieldName = 'NUMERO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_MovForSERIE: TStringField
      FieldName = 'SERIE'
      Required = True
      FixedChar = True
      Size = 4
    end
    object CDS_MovForCODFORNECEDOR: TStringField
      FieldName = 'CODFORNECEDOR'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_MovForDATAENTRADA: TDateField
      FieldName = 'DATAENTRADA'
      Required = True
    end
    object CDS_MovForCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CDS_MovForQUANT: TFMTBCDField
      FieldName = 'QUANT'
      Precision = 15
      Size = 8
    end
  end
  object SQL: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Connnection
    Left = 288
    Top = 48
  end
  object Aux: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Connnection
    Left = 344
    Top = 48
  end
  object Mov: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Connnection
    Left = 288
    Top = 104
  end
end
