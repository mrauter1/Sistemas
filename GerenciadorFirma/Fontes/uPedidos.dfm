object Pedidos: TPedidos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 205
  Width = 354
  object Dados: TClientDataSet
    PersistDataPacket.Data = {
      540100009619E0BD01000000180000000B000000000003000000540109434F44
      50454449444F0100490000000100055749445448020002000A000A434F445052
      4F4455544F01004900000001000557494454480200020014000B4E4F4D455052
      4F4455544F01004900000001000557494454480200020064000A5155414E5449
      4441444508000400000000000F4449415350415241454E545245474104000100
      000000000353495401004900000001000557494454480200020001000A434F44
      434C49454E54450100490000000100055749445448020002000A000B4E4F4D45
      434C49454E544501004900000001000557494454480200020050000D434F4454
      52414E53504F5254450100490000000100055749445448020002000A000E4E4F
      4D455452414E53504F5254450100490000000100055749445448020002006400
      0D5155414E5450454E44454E544508000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODPEDIDO'
        DataType = ftString
        Size = 10
      end
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
        Name = 'CODCLIENTE'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'NOMECLIENTE'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'CODTRANSPORTE'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'NOMETRANSPORTE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'QUANTPENDENTE'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 168
    Top = 80
    object DadosCODPEDIDO: TStringField
      DisplayLabel = 'Cod. Pedido'
      FieldName = 'CODPEDIDO'
      Size = 10
    end
    object DadosCODPRODUTO: TStringField
      DisplayLabel = 'Cod. Prod'
      FieldName = 'CODPRODUTO'
    end
    object DadosNOMEPRODUTO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'NOMEPRODUTO'
      Size = 100
    end
    object DadosQUANTIDADE: TFloatField
      DisplayLabel = 'Qtd.'
      FieldName = 'QUANTIDADE'
    end
    object DadosDIASPARAENTREGA: TIntegerField
      DisplayLabel = 'Dias para entrega'
      FieldName = 'DIASPARAENTREGA'
    end
    object DadosSIT: TStringField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'SIT'
      Size = 1
    end
    object DadosCODCLIENTE: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'CODCLIENTE'
      Size = 10
    end
    object DadosNOMECLIENTE: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'NOMECLIENTE'
      Size = 80
    end
    object DadosCODTRANSPORTE: TStringField
      DisplayLabel = 'Cod. Transp'
      FieldName = 'CODTRANSPORTE'
      Size = 10
    end
    object DadosNOMETRANSPORTE: TStringField
      DisplayLabel = 'Transportadora'
      DisplayWidth = 40
      FieldName = 'NOMETRANSPORTE'
      Size = 100
    end
    object DadosQUANTPENDENTE: TFloatField
      DisplayLabel = 'N'#227'o Atendido'
      FieldName = 'QUANTPENDENTE'
    end
  end
end
