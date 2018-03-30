inherited DadosModeloBase: TDadosModeloBase
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 172
  object CDS: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Provider'
    Left = 80
    Top = 24
  end
  object Provider: TDataSetProvider
    Left = 80
    Top = 80
  end
end
