object Pedidos: TPedidos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 205
  Width = 354
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
  object QryPedidos: TFDQuery
    Connection = DmCon.FDConSqlServer
    SQL.Strings = (
      'SELECT     PED.CodPedido,'
      '           PED.SITUACAO,'
      #9'   PED.SIT,'
      #9'   PED.DIASPARAENTREGA,'
      #9'   PED.CODCLIENTE,'
      #9'   PED.NOMECLIENTE,'
      #9'   PED.CODTRANSPORTE,'
      #9'   PED.NOMETRANSPORTE,'
      '           PED.CODPRODUTO, '
      #9'   PED.NOMEPRODUTO, '
      #9'   PED.QUANTIDADE,'
      #9'   PED.QUANTPENDENTE,'
      #9'   E.EstoqueAtual,'
      #9'   E.FALTAHOJE,'
      #9'   E.FALTATOTAL - E.FALTAHOJE AS FALTAAMANHA,'
      
        '           CONVERT(BIT, CASE WHEN E.FALTATOTAL > 0 THEN 1 ELSE 0' +
        ' END) AS EmFalta'
      ''
      'FROM PEDIDOS PED'
      
        'LEFT JOIN PrevisaoProdutoEmFalta E on E.CodProduto = Ped.CodProd' +
        'uto'
      
        'order by PED.CodTransporte, ped.CODCLIENTE, SIT, DIASPARAENTREGA' +
        ', PED.CODPRODUTO')
    Left = 160
    Top = 24
    object QryPedidosCODPEDIDO: TStringField
      DisplayLabel = 'Cod. Pedido'
      FieldName = 'CODPEDIDO'
      Size = 6
    end
    object QryPedidosDIASPARAENTREGA: TIntegerField
      DisplayLabel = 'Dias para entrega'
      FieldName = 'DIASPARAENTREGA'
    end
    object QryPedidosSITUACAO: TStringField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object QryPedidosSIT: TStringField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'SIT'
      Size = 1
    end
    object QryPedidosCODCLIENTE: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'CODCLIENTE'
      Size = 6
    end
    object QryPedidosNOMECLIENTE: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'NOMECLIENTE'
      Size = 80
    end
    object QryPedidosCODPRODUTO: TStringField
      DisplayLabel = 'Cod. Prod'
      FieldName = 'CODPRODUTO'
      Size = 6
    end
    object QryPedidosNOMEPRODUTO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'NOMEPRODUTO'
      Size = 80
    end
    object QryPedidosQUANTIDADE: TBCDField
      DisplayLabel = 'Qtd. Total'
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      DisplayFormat = '#0.00'
      Precision = 18
    end
    object QryPedidosQUANTPENDENTE: TBCDField
      DisplayLabel = 'Qnt. N'#227'o Atendida'
      FieldName = 'QUANTPENDENTE'
      Origin = 'QUANTPENDENTE'
      DisplayFormat = '#0.00'
      Precision = 18
    end
    object QryPedidosEstoqueAtual: TBCDField
      DisplayLabel = 'Estoq. Atual'
      FieldName = 'EstoqueAtual'
      Origin = 'EstoqueAtual'
      DisplayFormat = '#0.00'
      Precision = 18
    end
    object QryPedidosFALTAHOJE: TFMTBCDField
      DisplayLabel = 'Falta Hoje'
      FieldName = 'FALTAHOJE'
      Origin = 'FALTAHOJE'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 4
    end
    object QryPedidosFALTAAMANHA: TFMTBCDField
      DisplayLabel = 'Falta Amanh'#227
      FieldName = 'FALTAAMANHA'
      Origin = 'FALTAAMANHA'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 4
    end
    object QryPedidosCODTRANSPORTE: TStringField
      DisplayLabel = 'Cod. Transp'
      FieldName = 'CODTRANSPORTE'
      Size = 6
    end
    object QryPedidosNOMETRANSPORTE: TStringField
      DisplayLabel = 'Transportadora'
      DisplayWidth = 40
      FieldName = 'NOMETRANSPORTE'
      Size = 39
    end
    object QryPedidosEMFALTA: TBooleanField
      DisplayLabel = 'Em Falta'
      FieldName = 'EMFALTA'
    end
  end
  object TblPedidosCache: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 160
    Top = 144
    object TblPedidosCacheCODPEDIDO: TStringField
      DisplayLabel = 'Cod. Pedido'
      FieldName = 'CODPEDIDO'
      Size = 6
    end
    object TblPedidosCacheCODPRODUTO: TStringField
      DisplayLabel = 'Cod. Prod'
      FieldName = 'CODPRODUTO'
      Size = 6
    end
    object TblPedidosCacheEMFALTA: TBooleanField
      DisplayLabel = 'Em Falta'
      FieldName = 'EMFALTA'
    end
  end
end
