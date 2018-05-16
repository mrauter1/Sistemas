object DMFilaProducao: TDMFilaProducao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 191
  Width = 374
  object CdsFilaProducao: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
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
    object CdsFilaProducaoDEMANDADIARIA: TFloatField
      DisplayLabel = 'Demanda Diaria'
      FieldName = 'DEMANDADIARIA'
      DisplayFormat = '#0.00'
    end
    object CdsFilaProducaoDIASESTOQUE: TFloatField
      DisplayLabel = 'Dias Estoque'
      FieldName = 'DIASESTOQUE'
      DisplayFormat = '#0.00'
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
