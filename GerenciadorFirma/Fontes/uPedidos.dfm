object Pedidos: TPedidos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 205
  Width = 354
  object Dados: TClientDataSet
    PersistDataPacket.Data = {
      8A0100009619E0BD01000000180000000E0000000000030000008A0109434F44
      50454449444F0100490000000100055749445448020002000A000A434F445052
      4F4455544F01004900000001000557494454480200020014000B4E4F4D455052
      4F4455544F01004900000001000557494454480200020064000A5155414E5449
      4441444508000400000000000C4553544F515545415455414C08000400000000
      000F4449415350415241454E5452454741040001000000000003534954010049
      00000001000557494454480200020001000A434F44434C49454E544501004900
      00000100055749445448020002000A000B4E4F4D45434C49454E544501004900
      000001000557494454480200020050000D434F445452414E53504F5254450100
      490000000100055749445448020002000A000E4E4F4D455452414E53504F5254
      4501004900000001000557494454480200020064000D5155414E5450454E4445
      4E54450800040000000000085550444154454944040001000000000007454D46
      414C544102000300000000000000}
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
        Name = 'ESTOQUEATUAL'
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
      end
      item
        Name = 'UPDATEID'
        DataType = ftInteger
      end
      item
        Name = 'EMFALTA'
        DataType = ftBoolean
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
    object DadosESTOQUEATUAL: TFloatField
      DisplayLabel = 'Estoq. Atual'
      FieldName = 'ESTOQUEATUAL'
      DisplayFormat = '#0.00'
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
    object DadosUPDATEID: TIntegerField
      FieldName = 'UPDATEID'
      Visible = False
    end
    object DadosEMFALTA: TBooleanField
      DisplayLabel = 'Em Falta'
      FieldName = 'EMFALTA'
    end
  end
  object dxAlert: TdxAlertWindowManager
    OptionsButtons.Buttons = <>
    OptionsMessage.Caption.Font.Charset = DEFAULT_CHARSET
    OptionsMessage.Caption.Font.Color = clWindowText
    OptionsMessage.Caption.Font.Height = -13
    OptionsMessage.Caption.Font.Name = 'Tahoma'
    OptionsMessage.Caption.Font.Style = [fsBold]
    OptionsMessage.Text.Font.Charset = DEFAULT_CHARSET
    OptionsMessage.Text.Font.Color = clWindowText
    OptionsMessage.Text.Font.Height = -11
    OptionsMessage.Text.Font.Name = 'Tahoma'
    OptionsMessage.Text.Font.Style = []
    OptionsNavigationPanel.Font.Charset = DEFAULT_CHARSET
    OptionsNavigationPanel.Font.Color = clWindowText
    OptionsNavigationPanel.Font.Height = -11
    OptionsNavigationPanel.Font.Name = 'Tahoma'
    OptionsNavigationPanel.Font.Style = []
    Left = 280
    Top = 80
    PixelsPerInch = 96
  end
  object dxAlertFalta: TdxAlertWindowManager
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    OptionsBehavior.DisplayTime = 999999999
    OptionsButtons.Buttons = <>
    OptionsMessage.Caption.Font.Charset = DEFAULT_CHARSET
    OptionsMessage.Caption.Font.Color = clWindowText
    OptionsMessage.Caption.Font.Height = -13
    OptionsMessage.Caption.Font.Name = 'Tahoma'
    OptionsMessage.Caption.Font.Style = [fsBold]
    OptionsMessage.Text.Font.Charset = DEFAULT_CHARSET
    OptionsMessage.Text.Font.Color = clWindowText
    OptionsMessage.Text.Font.Height = -11
    OptionsMessage.Text.Font.Name = 'Tahoma'
    OptionsMessage.Text.Font.Style = []
    OptionsNavigationPanel.Font.Charset = DEFAULT_CHARSET
    OptionsNavigationPanel.Font.Color = clDefault
    OptionsNavigationPanel.Font.Height = -11
    OptionsNavigationPanel.Font.Name = 'Tahoma'
    OptionsNavigationPanel.Font.Style = []
    Left = 32
    Top = 80
    PixelsPerInch = 96
  end
  object Timer1: TTimer
    Interval = 120000
    OnTimer = Timer1Timer
    Left = 162
    Top = 16
  end
end
