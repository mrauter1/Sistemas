inherited ProdutoModelo: TProdutoModelo
  inherited CDS: TClientDataSet
    object COD: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'COD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object NOME: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 35
      FieldName = 'NOME'
      Size = 100
    end
    object VALOR: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = '###,###,##0.0000'
      Precision = 15
      Size = 4
    end
  end
  inherited Provider: TDataSetProvider
    DataSet = ConexaoDBX.SQLQuery1
  end
end
