object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 196
  Width = 291
  object CdsEstoqProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 92
    Top = 48
    object StringField1: TStringField
      FieldName = 'CODPRODUTO'
      Size = 6
    end
    object CdsEstoqProdutosESTOQUEATUAL: TFloatField
      FieldName = 'ESTOQUEATUAL'
    end
    object CdsEstoqProdutosPEDIDOSCONFIRMADOS: TFloatField
      FieldName = 'PEDIDOSCONFIRMADOS'
    end
    object CdsEstoqProdutosPEDIDOSBLOQUEADOS: TFloatField
      FieldName = 'PEDIDOSBLOQUEADOS'
    end
    object CdsEstoqProdutosESPACOESTOQUE: TFloatField
      FieldName = 'ESPACOESTOQUE'
    end
    object CdsEstoqProdutosDEMANDA: TFloatField
      FieldName = 'DEMANDA'
    end
  end
end
