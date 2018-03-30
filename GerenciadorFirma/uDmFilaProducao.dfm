object DMFilaProducao: TDMFilaProducao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 191
  Width = 374
  object CdsFilaProducao: TClientDataSet
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
        Name = 'QUANTPRODUCAO'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 140
    Top = 56
    object CdsFilaProducaoCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Size = 6
    end
    object CdsFilaProducaoNOMEPRODUTO: TStringField
      FieldName = 'NOMEPRODUTO'
      Size = 100
    end
    object CdsFilaProducaoQUANTPRODUCAO: TIntegerField
      FieldName = 'QUANTPRODUCAO'
    end
  end
end
