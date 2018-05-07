object DMFilaProducao: TDMFilaProducao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 191
  Width = 374
  object CdsFilaProducao: TClientDataSet
    PersistDataPacket.Data = {
      F80000009619E0BD01000000180000000A000000000003000000F8000A434F44
      50524F4455544F01004900000001000557494454480200020006000B4E4F4D45
      50524F4455544F01004900000001000557494454480200020064000A5155414E
      54494441444508000400000000000546414C544108000400000000000A4E554D
      50454449444F5304000100000000001050524F445543414F5355474552494441
      08000400000000000D50524F4246414C5441484F4A4508000400000000000C45
      53544F515545415455414C0800040000000000084553544F514D415808000400
      000000000D45535041434F4553544F51554508000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODPRODUTO'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'NOMEPRODUTO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftFloat
      end
      item
        Name = 'FALTA'
        DataType = ftFloat
      end
      item
        Name = 'NUMPEDIDOS'
        DataType = ftInteger
      end
      item
        Name = 'PRODUCAOSUGERIDA'
        DataType = ftFloat
      end
      item
        Name = 'PROBFALTAHOJE'
        DataType = ftFloat
      end
      item
        Name = 'ESTOQUEATUAL'
        DataType = ftFloat
      end
      item
        Name = 'ESTOQMAX'
        DataType = ftFloat
      end
      item
        Name = 'ESPACOESTOQUE'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 172
    Top = 72
    object CdsFilaProducaoCODPRODUTO: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'CODPRODUTO'
      Size = 6
    end
    object CdsFilaProducaoNOMEPRODUTO: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 40
      FieldName = 'NOMEPRODUTO'
      Size = 100
    end
    object CdsFilaProducaoQUANTIDADE: TFloatField
      DisplayLabel = 'Quant. Pedido'
      FieldName = 'QUANTIDADE'
      DisplayFormat = '#0.00'
    end
    object CdsFilaProducaoFALTA: TFloatField
      DisplayLabel = 'Falta'
      FieldName = 'FALTA'
      DisplayFormat = '#0.00'
    end
    object CdsFilaProducaoNUMPEDIDOS: TIntegerField
      DisplayLabel = 'Num. Pedidos'
      FieldName = 'NUMPEDIDOS'
    end
    object CdsFilaProducaoPRODUCAOSUGERIDA: TFloatField
      DisplayLabel = 'Produ'#231#227'o Sugerida'
      FieldName = 'PRODUCAOSUGERIDA'
      DisplayFormat = '#0.00'
    end
    object CdsFilaProducaoPROBFALTAHOJE: TFloatField
      DisplayLabel = 'Probabilidade Falta'
      FieldName = 'PROBFALTAHOJE'
    end
    object CdsFilaProducaoESTOQUEATUAL: TFloatField
      DisplayLabel = 'Estoque Atual'
      FieldName = 'ESTOQUEATUAL'
      DisplayFormat = '#0.00'
    end
    object CdsFilaProducaoESTOQMAX: TFloatField
      DisplayLabel = 'Estoque Max'
      FieldName = 'ESTOQMAX'
      DisplayFormat = '#0'
    end
    object CdsFilaProducaoESPACOESTOQUE: TFloatField
      DisplayLabel = 'Espa'#231'o Estoque'
      FieldName = 'ESPACOESTOQUE'
      DisplayFormat = '#0'
    end
  end
end
