object DmGeradorConsultas: TDmGeradorConsultas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 497
  Width = 549
  object DsPara: TDataSource
    AutoEdit = False
    DataSet = QryParametros
    Left = 182
    Top = 119
  end
  object DsConsultas: TDataSource
    AutoEdit = False
    DataSet = QryConsultas
    Left = 180
    Top = 207
  end
  object DsCampos: TDataSource
    Left = 183
    Top = 18
  end
  object QryCampos: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT * FROM'
      'cons.Campos'
      'WHERE Consulta =:codConsulta')
    Left = 312
    Top = 16
    ParamData = <
      item
        Name = 'CODCONSULTA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QryCamposID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryCamposConsulta: TIntegerField
      FieldName = 'Consulta'
      Origin = 'Consulta'
    end
    object QryCamposNomeCampo: TStringField
      FieldName = 'NomeCampo'
      Origin = 'NomeCampo'
      Size = 255
    end
    object QryCamposDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 255
    end
    object QryCamposTamanhoCampo: TIntegerField
      FieldName = 'TamanhoCampo'
      Origin = 'TamanhoCampo'
    end
    object QryCamposVisivel: TBooleanField
      FieldName = 'Visivel'
      Origin = 'Visivel'
    end
    object QryCamposMonetario: TBooleanField
      FieldName = 'Monetario'
      Origin = 'Monetario'
    end
    object QryCamposAgrupamento: TIntegerField
      FieldName = 'Agrupamento'
      Origin = 'Agrupamento'
    end
    object QryCamposCor: TIntegerField
      FieldName = 'Cor'
      Origin = 'Cor'
    end
  end
  object QryParametros: TFDQuery
    AfterInsert = QryParametrosAfterInsert
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT * FROM'
      'cons.Parametros'
      'WHERE Consulta =:codConsulta')
    Left = 312
    Top = 120
    ParamData = <
      item
        Name = 'CODCONSULTA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QryParametrosID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object QryParametrosConsulta: TIntegerField
      FieldName = 'Consulta'
      Origin = 'Consulta'
      Visible = False
    end
    object QryParametrosNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 255
    end
    object QryParametrosDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 255
    end
    object QryParametrosTipo: TIntegerField
      FieldName = 'Tipo'
      Origin = 'Tipo'
    end
    object QryParametrosSql: TMemoField
      FieldName = 'Sql'
      Origin = 'Sql'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryParametrosOrdem: TIntegerField
      FieldName = 'Ordem'
      Origin = 'Ordem'
    end
    object QryParametrosTamanho: TIntegerField
      FieldName = 'Tamanho'
      Origin = 'Tamanho'
    end
    object QryParametrosObrigatorio: TBooleanField
      DisplayLabel = 'Obrigat'#243'rio'
      FieldName = 'Obrigatorio'
      Origin = 'Obrigatorio'
    end
    object QryParametrosValorPadrao: TMemoField
      DisplayLabel = 'Valor Padr'#227'o'
      FieldName = 'ValorPadrao'
      Origin = 'ValorPadrao'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object QryConsultas: TFDQuery
    Active = True
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT * FROM'
      'cons.Consultas'
      'WHERE ID =:codConsulta')
    Left = 312
    Top = 208
    ParamData = <
      item
        Name = 'CODCONSULTA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QryConsultasID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryConsultasNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 255
    end
    object QryConsultasDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 512
    end
    object QryConsultasSql: TMemoField
      FieldName = 'Sql'
      Origin = 'Sql'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryConsultasInfoExtendida: TMemoField
      FieldName = 'InfoExtendida'
      Origin = 'InfoExtendida'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryConsultasTipo: TIntegerField
      FieldName = 'Tipo'
      Origin = 'Tipo'
    end
    object QryConsultasConfigPadrao: TIntegerField
      FieldName = 'ConfigPadrao'
      Origin = 'ConfigPadrao'
    end
    object QryConsultasVisualizacaoPadrao: TIntegerField
      FieldName = 'VisualizacaoPadrao'
      Origin = 'VisualizacaoPadrao'
    end
    object QryConsultasIDPai: TIntegerField
      FieldName = 'IDPai'
      Origin = 'IDPai'
    end
    object QryConsultasFonteDados: TIntegerField
      FieldName = 'FonteDados'
      Origin = 'FonteDados'
    end
  end
end
