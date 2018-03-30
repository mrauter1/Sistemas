inherited DadosControleBase: TDadosControleBase
  OldCreateOrder = True
  object DataSource: TDataSource
    AutoEdit = False
    OnStateChange = DataSourceStateChange
    OnDataChange = DataSourceDataChange
    Left = 80
    Top = 40
  end
end
