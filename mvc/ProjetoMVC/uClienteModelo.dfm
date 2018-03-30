inherited ClienteModelo: TClienteModelo
  inherited CDS: TClientDataSet
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
    object CIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Size = 100
    end
  end
end
