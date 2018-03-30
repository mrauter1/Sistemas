inherited ProdutoControle: TProdutoControle
  Width = 277
  inherited DataSource: TDataSource
    DataSet = ProdutoModelo.CDS
    Left = 64
  end
  object DataSourcePedidoItem: TDataSource
    AutoEdit = False
    DataSet = PedidoItemModelo.CDS
    OnStateChange = DataSourceStateChange
    OnDataChange = DataSourceDataChange
    Left = 168
    Top = 40
  end
end
