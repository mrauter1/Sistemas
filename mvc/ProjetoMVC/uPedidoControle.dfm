inherited PedidoCtrl: TPedidoCtrl
  Height = 132
  Width = 251
  inherited DataSource: TDataSource
    DataSet = PedidoMD.CDS
    Left = 40
    Top = 32
  end
  object DataSourcePedidoItens: TDataSource
    DataSet = PedidoMD.CDS
    OnStateChange = DataSourceStateChange
    OnDataChange = DataSourceDataChange
    Left = 136
    Top = 32
  end
end
