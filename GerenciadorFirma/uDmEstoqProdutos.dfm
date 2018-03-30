object DmEstoqProdutos: TDmEstoqProdutos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 182
  Width = 334
  object CdsEstoqProdutos: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'RANK'
        DataType = ftInteger
      end
      item
        Name = 'CODPRODUTO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ESTOQUEATUAL'
        DataType = ftFloat
      end
      item
        Name = 'PROBFALTAHOJE'
        DataType = ftFloat
      end
      item
        Name = 'PROBFALTA'
        DataType = ftFloat
      end
      item
        Name = 'PROBSAI2DIAS'
        DataType = ftFloat
      end
      item
        Name = 'PERCENTDIAS'
        DataType = ftFloat
      end
      item
        Name = 'MEDIASAIDA'
        DataType = ftFloat
      end
      item
        Name = 'STDDEV'
        DataType = ftFloat
      end
      item
        Name = 'ESPACOESTOQUE'
        DataType = ftFloat
      end
      item
        Name = 'ROTACAO'
        DataType = ftInteger
      end
      item
        Name = 'DEMANDA'
        DataType = ftFloat
      end
      item
        Name = 'APRESENTACAO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'DEMANDADIARIA'
        DataType = ftFloat
      end
      item
        Name = 'DEMANDAC1'
        DataType = ftFloat
      end
      item
        Name = 'DIASESTOQUE'
        DataType = ftFloat
      end
      item
        Name = 'UNIDADEESTOQUE'
        DataType = ftInteger
      end
      item
        Name = 'ESTOQMAX'
        DataType = ftFloat
      end
      item
        Name = 'PRODUCAOMINIMA'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 76
    Top = 72
    object CdsEstoqProdutosRANK: TIntegerField
      FieldName = 'RANK'
    end
    object CODPRODUTO: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'CODPRODUTO'
      Size = 6
    end
    object APRESENTACAO: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 20
      FieldName = 'APRESENTACAO'
      Size = 200
    end
    object PROBFALTAHOJE: TFloatField
      FieldName = 'PROBFALTAHOJE'
      DisplayFormat = '#0.00'
    end
    object PROBSAI2DIAS: TFloatField
      FieldName = 'PROBSAI2DIAS'
      DisplayFormat = '#0.00'
    end
    object PROBFALTA: TFloatField
      FieldName = 'PROBFALTA'
      DisplayFormat = '#0.00'
    end
    object PERCENTDIAS: TFloatField
      FieldName = 'PERCENTDIAS'
      DisplayFormat = '#0.00'
    end
    object MEDIASAIDA: TFloatField
      FieldName = 'MEDIASAIDA'
      DisplayFormat = '#0.00'
    end
    object STDDEV: TFloatField
      FieldName = 'STDDEV'
      DisplayFormat = '#0.00'
    end
    object ESTOQMAX: TFloatField
      FieldName = 'ESTOQMAX'
      DisplayFormat = '#0.00'
    end
    object ESTOQUEATUAL: TFloatField
      DisplayLabel = 'Estoque'
      FieldName = 'ESTOQUEATUAL'
      DisplayFormat = '#0.00'
    end
    object DEMANDAC1: TFloatField
      FieldName = 'DEMANDAC1'
      DisplayFormat = '#0.00'
    end
    object DEMANDA: TFloatField
      DisplayLabel = 'Demanda'
      FieldName = 'DEMANDA'
      DisplayFormat = '#0.00'
    end
    object DIASESTOQUE: TFloatField
      FieldName = 'DIASESTOQUE'
      DisplayFormat = '#0.00'
    end
    object ESPACOESTOQUE: TFloatField
      DisplayLabel = 'Espa'#231'o Estoque'
      FieldName = 'ESPACOESTOQUE'
    end
    object ROTACAO: TIntegerField
      DisplayLabel = 'Rota'#231#227'o'
      FieldName = 'ROTACAO'
    end
    object DEMANDADIARIA: TFloatField
      FieldName = 'DEMANDADIARIA'
      DisplayFormat = '#0.00'
    end
    object UNIDADEESTOQUE: TIntegerField
      FieldName = 'UNIDADEESTOQUE'
    end
    object PRODUCAOMINIMA: TIntegerField
      FieldName = 'PRODUCAOMINIMA'
    end
  end
  object CdsPedidos: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODPRODUTO'
        DataType = ftString
        Size = 20
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
        Name = 'DIASPARAENTREGA'
        DataType = ftInteger
      end
      item
        Name = 'SIT'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'NUMPEDIDOS'
        DataType = ftInteger
      end
      item
        Name = 'FALTA'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 232
    Top = 72
    object CdsPedidosCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
    end
    object CdsPedidosNOMEPRODUTO: TStringField
      FieldName = 'NOMEPRODUTO'
      Size = 100
    end
    object CdsPedidosQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object CdsPedidosDIASPARAENTREGA: TIntegerField
      FieldName = 'DIASPARAENTREGA'
    end
    object CdsPedidosSIT: TStringField
      FieldName = 'SIT'
      Size = 1
    end
    object CdsPedidosNUMPEDIDOS: TIntegerField
      FieldName = 'NUMPEDIDOS'
    end
    object CdsPedidosFALTA: TIntegerField
      FieldName = 'FALTA'
    end
  end
end
