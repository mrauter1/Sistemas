inherited CadModelo: TCadModelo
  OnDestroy = DataModuleDestroy
  inherited CDS: TClientDataSet
    AfterInsert = CDSAfterInsert
    BeforePost = CDSBeforePost
    OnCalcFields = CDSCalcFields
  end
  object DataSource: TDataSource
    DataSet = CDS
    Left = 144
    Top = 56
  end
end
