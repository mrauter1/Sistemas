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
      DisplayLabel = 'Rank'
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
      DisplayLabel = 'Prob. Falta Hoje'
      FieldName = 'PROBFALTAHOJE'
      DisplayFormat = '#0.00'
    end
    object PROBSAI2DIAS: TFloatField
      DisplayLabel = 'Prob. Sai 2 Dias'
      FieldName = 'PROBSAI2DIAS'
      Visible = False
      DisplayFormat = '#0.00'
    end
    object PROBFALTA: TFloatField
      DisplayLabel = 'Prob. Falta'
      FieldName = 'PROBFALTA'
      DisplayFormat = '#0.00'
    end
    object PERCENTDIAS: TFloatField
      DisplayLabel = '% Dias com Sa'#237'da'
      FieldName = 'PERCENTDIAS'
      DisplayFormat = '#0.00'
    end
    object MEDIASAIDA: TFloatField
      DisplayLabel = 'M'#233'dia Sa'#237'da'
      FieldName = 'MEDIASAIDA'
      DisplayFormat = '#0.00'
    end
    object STDDEV: TFloatField
      DisplayLabel = 'Desvio Padr'#227'o'
      FieldName = 'STDDEV'
      Visible = False
      DisplayFormat = '#0.00'
    end
    object ESTOQUEATUAL: TFloatField
      DisplayLabel = 'Estoque'
      FieldName = 'ESTOQUEATUAL'
      DisplayFormat = '#0.00'
    end
    object ESTOQMAX: TFloatField
      DisplayLabel = 'Estoq. Max C'#225'lculado'
      FieldName = 'ESTOQMAX'
      DisplayFormat = '#0.00'
    end
    object ESPACOESTOQUE: TFloatField
      DisplayLabel = 'Espa'#231'o Estoque'
      FieldName = 'ESPACOESTOQUE'
    end
    object PRODUCAOMINIMA: TIntegerField
      DisplayLabel = 'Produ'#231#227'o Minima'
      FieldName = 'PRODUCAOMINIMA'
    end
    object DEMANDAC1: TFloatField
      DisplayLabel = 'Demanda Cliente1'
      FieldName = 'DEMANDAC1'
      DisplayFormat = '#0.00'
    end
    object DEMANDADIARIA: TFloatField
      DisplayLabel = 'Demanda Di'#225'ria'
      FieldName = 'DEMANDADIARIA'
      DisplayFormat = '#0.00'
    end
    object DEMANDA: TFloatField
      DisplayLabel = 'Demanda'
      FieldName = 'DEMANDA'
      DisplayFormat = '#0.00'
    end
    object DIASESTOQUE: TFloatField
      DisplayLabel = 'Dias Estoque'
      FieldName = 'DIASESTOQUE'
      DisplayFormat = '#0.00'
    end
    object ROTACAO: TIntegerField
      DisplayLabel = 'Rota'#231#227'o'
      FieldName = 'ROTACAO'
    end
    object UNIDADEESTOQUE: TIntegerField
      DisplayLabel = 'Unidade Estoque'
      FieldName = 'UNIDADEESTOQUE'
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
