object DMConsistenciaOPs: TDMConsistenciaOPs
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 225
  Width = 554
  object CdsOPs: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODORDEMPRODUCAO'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 6
      end
      item
        Name = 'CODFILIAL'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'SITUACAOOP'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DATAOP'
        DataType = ftDate
      end
      item
        Name = 'DATAPRONTO'
        DataType = ftDate
      end
      item
        Name = 'CONTROLE'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'RESPONSAVEL'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'OBSERVACAO'
        DataType = ftMemo
        Size = 1
      end
      item
        Name = 'CODCONFIG'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODMODELO'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'PrvOPs'
    StoreDefs = True
    Left = 60
    Top = 24
    object CdsOPsCODORDEMPRODUCAO: TStringField
      FieldName = 'CODORDEMPRODUCAO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CdsOPsCODFILIAL: TStringField
      FieldName = 'CODFILIAL'
      Required = True
      FixedChar = True
      Size = 2
    end
    object CdsOPsSITUACAOOP: TStringField
      FieldName = 'SITUACAOOP'
      FixedChar = True
      Size = 1
    end
    object CdsOPsDATAOP: TDateField
      FieldName = 'DATAOP'
    end
    object CdsOPsDATAPRONTO: TDateField
      FieldName = 'DATAPRONTO'
    end
    object CdsOPsCONTROLE: TStringField
      FieldName = 'CONTROLE'
      Size = 15
    end
    object CdsOPsRESPONSAVEL: TStringField
      FieldName = 'RESPONSAVEL'
      Size = 15
    end
    object CdsOPsOBSERVACAO: TMemoField
      FieldName = 'OBSERVACAO'
      BlobType = ftMemo
      Size = 1
    end
    object CdsOPsCODCONFIG: TIntegerField
      FieldName = 'CODCONFIG'
      Required = True
    end
    object CdsOPsCODMODELO: TIntegerField
      FieldName = 'CODMODELO'
      Required = True
    end
  end
  object SqlOPs: TSQLQuery
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftDateTime
        Name = 'DATAINI'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATAFIM'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT * FROM PRODUCAO'
      'WHERE DATAOP BETWEEN :DATAINI AND :DATAFIM')
    SQLConnection = DmSqlUtils.SQLConnection
    Left = 56
    Top = 136
  end
  object PrvOPs: TDataSetProvider
    DataSet = SqlOPs
    Left = 56
    Top = 80
  end
  object CdsMovAcabado: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CHAVENFPRO'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 21
      end
      item
        Name = 'CODCOMPROVANTE'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'CODPRODUTO'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 6
      end
      item
        Name = 'QUANTATENDIDA'
        DataType = ftFMTBcd
        Precision = 18
        Size = 4
      end
      item
        Name = 'CODGRUPOSUB'
        Attributes = [faFixed]
        DataType = ftString
        Size = 7
      end
      item
        Name = 'UNIDADEESTOQUE'
        DataType = ftInteger
      end
      item
        Name = 'UNIDADE'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'PESO'
        DataType = ftFMTBcd
        Precision = 18
        Size = 4
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'PrvMovAcabado'
    StoreDefs = True
    Left = 148
    Top = 24
    object CdsMovAcabadoCHAVENFPRO: TStringField
      FieldName = 'CHAVENFPRO'
      Required = True
      FixedChar = True
      Size = 21
    end
    object CdsMovAcabadoCODCOMPROVANTE: TStringField
      FieldName = 'CODCOMPROVANTE'
      FixedChar = True
      Size = 3
    end
    object CdsMovAcabadoCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CdsMovAcabadoQUANTATENDIDA: TFMTBCDField
      FieldName = 'QUANTATENDIDA'
      Precision = 18
      Size = 4
    end
    object CdsMovAcabadoCODGRUPOSUB: TStringField
      FieldName = 'CODGRUPOSUB'
      FixedChar = True
      Size = 7
    end
    object CdsMovAcabadoUNIDADEESTOQUE: TIntegerField
      FieldName = 'UNIDADEESTOQUE'
    end
    object CdsMovAcabadoUNIDADE: TStringField
      FieldName = 'UNIDADE'
      FixedChar = True
      Size = 3
    end
    object CdsMovAcabadoPESO: TFMTBCDField
      FieldName = 'PESO'
      Precision = 18
      Size = 4
    end
  end
  object SqlMovAcabado: TSQLQuery
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftString
        Name = 'CODOP'
        ParamType = ptInput
      end>
    SQL.Strings = (
      
        'SELECT MP.CHAVENFPRO, M.CODCOMPROVANTE, MP.CODPRODUTO, MP.QUANTA' +
        'TENDIDA, '
      'P.CODGRUPOSUB, P.UNIDADEESTOQUE, P.UNIDADE, P.PESO'
      'FROM MCLI M'
      'INNER JOIN MCLIPRO MP ON M.CHAVENF = MP.CHAVENF'
      'INNER JOIN PRODUTO P ON P.CODPRODUTO = MP.CODPRODUTO'
      'WHERE M.CODORDEMPRODUCAO = :CODOP AND M.CODCOMPROVANTE = '#39'101'#39)
    SQLConnection = DmSqlUtils.SQLConnection
    Left = 144
    Top = 136
  end
  object PrvMovAcabado: TDataSetProvider
    DataSet = SqlMovAcabado
    Left = 144
    Top = 80
  end
  object CdsMovInsumos: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CHAVENFPRO'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 21
      end
      item
        Name = 'CODCOMPROVANTE'
        Attributes = [faFixed]
        DataType = ftString
        Size = 3
      end
      item
        Name = 'CODPRODUTO'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 6
      end
      item
        Name = 'CODGRUPOSUB'
        Attributes = [faFixed]
        DataType = ftString
        Size = 7
      end
      item
        Name = 'PESO'
        DataType = ftFMTBcd
        Precision = 18
        Size = 8
      end
      item
        Name = 'QUANTATENDIDA'
        DataType = ftFMTBcd
        Precision = 18
        Size = 4
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'PrvMovInsumos'
    StoreDefs = True
    Left = 252
    Top = 24
    object CdsMovInsumosCHAVENFPRO: TStringField
      FieldName = 'CHAVENFPRO'
      Required = True
      FixedChar = True
      Size = 21
    end
    object CdsMovInsumosCODCOMPROVANTE: TStringField
      FieldName = 'CODCOMPROVANTE'
      FixedChar = True
      Size = 3
    end
    object CdsMovInsumosCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object CdsMovInsumosCODGRUPOSUB: TStringField
      FieldName = 'CODGRUPOSUB'
      FixedChar = True
      Size = 7
    end
    object CdsMovInsumosQUANTATENDIDA: TFMTBCDField
      FieldName = 'QUANTATENDIDA'
      Precision = 18
      Size = 4
    end
    object CdsMovInsumosPESO: TFMTBCDField
      FieldName = 'PESO'
      Precision = 18
    end
  end
  object PrvMovInsumos: TDataSetProvider
    DataSet = SqlMovInsumos
    Left = 248
    Top = 80
  end
  object SqlMovInsumos: TSQLQuery
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftString
        Name = 'CODOP'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT MP.CHAVENFPRO, M.CODCOMPROVANTE, MP.CODPRODUTO,'
      
        'P.CODGRUPOSUB, (P.PESO / P.UNIDADEESTOQUE) * MP.QUANTATENDIDA AS' +
        ' PESO'
      ', MP.QUANTATENDIDA'
      'FROM MCLI M'
      'INNER JOIN MCLIPRO MP ON M.CHAVENF = MP.CHAVENF'
      'INNER JOIN PRODUTO P ON P.CODPRODUTO = MP.CODPRODUTO'
      'WHERE M.CODORDEMPRODUCAO = :CODOP AND M.CODCOMPROVANTE = '#39'100'#39)
    SQLConnection = DmSqlUtils.SQLConnection
    Left = 248
    Top = 136
  end
  object CdsModeloInsumo: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODOP'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'QUANTINSUMO'
        DataType = ftFloat
      end
      item
        Name = 'UNIDADE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'QUANTKG'
        DataType = ftFloat
      end
      item
        Name = 'CODPRODUTO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CODGRUPOSUB'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 356
    Top = 24
    object CdsModeloInsumoCODOP: TStringField
      FieldName = 'CODOP'
    end
    object CdsModeloInsumoQUANTINSUMO: TFloatField
      FieldName = 'QUANTINSUMO'
    end
    object CdsModeloInsumoUNIDADE: TStringField
      FieldName = 'UNIDADE'
    end
    object CdsModeloInsumoQUANTKG: TFloatField
      FieldName = 'QUANTKG'
    end
    object CdsModeloInsumoCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
    end
    object CdsModeloInsumoCODGRUPOSUB: TStringField
      FieldName = 'CODGRUPOSUB'
    end
  end
end
