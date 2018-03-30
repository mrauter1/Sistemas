inherited PedidoItemModelo: TPedidoItemModelo
  inherited CDS: TClientDataSet
    BeforeOpen = CDSBeforeOpen
    object CODPEDIDOITEM: TIntegerField
      DisplayLabel = 'Item'
      FieldName = 'CODPEDIDOITEM'
      Required = True
    end
    object CODPRODUTO: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'CODPRODUTO'
    end
    object CODPEDIDO: TIntegerField
      DisplayLabel = 'Pedido'
      FieldName = 'CODPEDIDO'
    end
    object NOMEPRODUTO: TStringField
      DisplayLabel = 'Produto'
      FieldKind = fkCalculated
      FieldName = 'NOMEPRODUTO'
      Size = 35
      Calculated = True
    end
    object QUANTIDADE: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
      OnChange = QUANTIDADEChange
      DisplayFormat = '0.00'
    end
    object TOTAL: TFMTBCDField
      DisplayLabel = 'Total'
      FieldName = 'TOTAL'
      DisplayFormat = '###,###,##0.0000'
      Precision = 15
      Size = 4
    end
    object VALOR: TFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      OnChange = VALORChange
      DisplayFormat = '###,###,##0.0000'
      Precision = 15
      Size = 4
    end
  end
  inherited Provider: TDataSetProvider
    DataSet = ConexaoDBX.SQLQuery1
  end
end
