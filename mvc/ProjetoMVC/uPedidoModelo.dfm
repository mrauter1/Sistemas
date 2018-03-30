inherited PedidoMD: TPedidoMD
  Height = 170
  Width = 193
  inherited CDS: TClientDataSet
    BeforeDelete = CDSBeforeDelete
    Left = 40
    Top = 48
    object COD: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'COD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object NOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 35
      FieldName = 'NOME'
      Size = 100
    end
    object CODCLIENTE: TIntegerField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'CODCLIENTE'
      Visible = False
    end
    object NOMECLIENTE: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 35
      FieldKind = fkCalculated
      FieldName = 'NOMECLIENTE'
      Size = 100
      Calculated = True
    end
  end
  inherited Provider: TDataSetProvider
    Left = 104
    Top = 16
  end
  inherited DataSource: TDataSource
    Left = 104
    Top = 72
  end
end
