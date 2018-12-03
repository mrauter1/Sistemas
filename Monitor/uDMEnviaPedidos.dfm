object DMEnviaPedidos: TDMEnviaPedidos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 234
  Width = 378
  object FDMemTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 288
    Top = 88
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 120000
    OnTimer = Timer1Timer
    Left = 96
    Top = 48
  end
  object QryPedidos: TFDQuery
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      'SELECT P.CODPEDIDO,'
      '       CASE'
      '        WHEN P.SITUACAO = '#39'0'#39' THEN '#39'PENDENTE'#39
      '        WHEN P.SITUACAO = '#39'1'#39' THEN '#39'RESERVA'#39
      '        WHEN P.SITUACAO = '#39'2'#39' THEN '#39'SEPARA'#199#195'O'#39
      '        WHEN P.SITUACAO = '#39'3'#39' THEN '#39'EMITIDO'#39
      '        WHEN P.SITUACAO = '#39'4'#39' THEN '#39'CANCELADO'#39
      '       END AS SITUACAO,'
      ''
      '      CASE WHEN P.PEDIDOBLOQUEADO = '#39'S'#39' THEN '#39'PEDIDO BLOQUEADO'#39
      
        '           WHEN P.PEDIDOBLOQUEADO = '#39'D'#39' THEN '#39'PEDIDO DESBLOQUEAD' +
        'O'#39
      '           ELSE '#39'SEM BLOQUEIO'#39
      '      END AS SITBLOQUEIO,'
      ''
      '      P.DATAENTREGA,'
      '      C.CIDADE,'
      ''
      
        '     (SELECT FIRST 1 CONDPGTO.CODCONDICAO ||'#39' - '#39'|| CONDPGTO.NOM' +
        'ECONDICAO FROM CONDPGTO'
      
        '       INNER JOIN PEDIDO_CONDPGTO PC ON (P.CODPEDIDO = PC.CODPED' +
        'IDO)'
      '       WHERE PC.CODCONDICAO=CONDPGTO.CODCONDICAO)'
      '       AS NOMECONDICAO,'
      ''
      '       P.CODCLIENTE || '#39' - '#39' || C.RAZAOSOCIAL AS NOMECLI,'
      
        '       T.CODTRANSPORTE || '#39' - '#39' || T.NOMETRANSPORTE AS NOMETRANS' +
        'P,'
      '       P.TOTITENS'
      'FROM PEDIDO P'
      'INNER JOIN CLIENTE C ON C.CODCLIENTE = P.CODCLIENTE'
      'LEFT JOIN TRANSP T ON T.CODTRANSPORTE = P.CODTRANSPORTE'
      'WHERE P.situacao IN ('#39'0'#39', '#39'1'#39', '#39'2'#39') AND'
      '      P.TOTITENS > 0 AND'
      '      P.dataentrega BETWEEN CAST('#39'Now'#39' as date) - 30'
      '                       and CAST('#39'Now'#39' as date) +'
      
        '                         ( CASE WHEN Extract(Weekday from cast('#39 +
        'NOW'#39' AS DATE)) = 5 THEN 3'
      
        '                           WHEN Extract(Weekday from cast('#39'NOW'#39' ' +
        'AS DATE)) = 6 THEN 2'
      '                           ELSE 1 END )')
    Left = 184
    Top = 88
    object QryPedidosCODPEDIDO: TStringField
      DisplayLabel = 'Nro. Pedido:'
      FieldName = 'CODPEDIDO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryPedidosNOMECLI: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'NOMECLI'
      Size = 89
    end
    object QryPedidosDATAENTREGA: TDateField
      DisplayLabel = 'Data Entrega'
      FieldName = 'DATAENTREGA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object QryPedidosNOMETRANSP: TStringField
      DisplayLabel = 'Transportadora'
      FieldName = 'NOMETRANSP'
      Size = 39
    end
    object QryPedidosCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      FixedChar = True
      Size = 35
    end
    object QryPedidosSITUACAO: TStringField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'SITUACAO'
      FixedChar = True
      Size = 9
    end
    object QryPedidosSITBLOQUEIO: TStringField
      DisplayLabel = 'Situa'#231#227'o Bloqueio'
      FieldName = 'SITBLOQUEIO'
      Required = True
      FixedChar = True
      Size = 19
    end
    object QryPedidosNOMECONDICAO: TStringField
      DisplayLabel = 'Cond. Pgto'
      FieldName = 'NOMECONDICAO'
      Size = 36
    end
    object QryPedidosTOTITENS: TIntegerField
      DisplayLabel = 'Total de Itens'
      FieldName = 'TOTITENS'
    end
  end
  object QryPedidoIT: TFDQuery
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      'SELECT PI.CODPRODUTO || '#39' - '#39' || P.APRESENTACAO AS PRODUTO,'
      
        '             P.UNIDADE || '#39' '#39'|| CAST(P.UNIDADEESTOQUE AS INT) ||' +
        ' '#39' '#39' || P.NOMESUBUNIDADE AS UNIDADE'
      
        '             , TRUNC(PI.QUANTATENDIDA / P.UNIDADEESTOQUE) AS QUA' +
        'NTATENDIDA'
      
        '             , MOD(PI.QUANTATENDIDA, P.UNIDADEESTOQUE) AS SOLTOA' +
        'TENDIDO'
      
        '             , TRUNC(PI.QUANTPENDENTE / P.UNIDADEESTOQUE) AS QUA' +
        'NTPENDENTE            '
      
        '             , MOD(PI.QUANTPENDENTE, P.UNIDADEESTOQUE) AS SOLTOP' +
        'ENDENTE '
      
        '            , (PI.PRECO - (PI.PRECO * PI.DESCONTOCALC / 100.00))' +
        ' AS PRECO'
      '            , (PI.VALTOTAL-PI.VALSUBSTITUICAO) AS VALTOTAL'
      'FROM PEDIDOIT PI '
      'INNER JOIN PRODUTO P ON P.CODPRODUTO = PI.CODPRODUTO'
      'WHERE PI.CODPEDIDO =:CODPEDIDO'
      '             ')
    Left = 184
    Top = 152
    ParamData = <
      item
        Name = 'CODPEDIDO'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 6
      end>
    object QryPedidoITPRODUTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'PRODUTO'
      Origin = 'PRODUTO'
      ProviderFlags = []
      ReadOnly = True
      Size = 89
    end
    object QryPedidoITUNIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UNIDADE'
      Origin = 'UNIDADE'
      ProviderFlags = []
      ReadOnly = True
      Size = 22
    end
    object QryPedidoITQUANTATENDIDA: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'QUANTATENDIDA'
      Origin = 'QUANTATENDIDA'
      ProviderFlags = []
      ReadOnly = True
    end
    object QryPedidoITSOLTOATENDIDO: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'SOLTOATENDIDO'
      Origin = 'SOLTOATENDIDO'
      ProviderFlags = []
      ReadOnly = True
    end
    object QryPedidoITQUANTPENDENTE: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'QUANTPENDENTE'
      Origin = 'QUANTPENDENTE'
      ProviderFlags = []
      ReadOnly = True
    end
    object QryPedidoITSOLTOPENDENTE: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'SOLTOPENDENTE'
      Origin = 'SOLTOPENDENTE'
      ProviderFlags = []
      ReadOnly = True
    end
    object QryPedidoITPRECO: TFMTBCDField
      AutoGenerateValue = arDefault
      FieldName = 'PRECO'
      Origin = 'PRECO'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
    end
    object QryPedidoITVALTOTAL: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'VALTOTAL'
      Origin = 'VALTOTAL'
      ProviderFlags = []
      ReadOnly = True
      Precision = 18
      Size = 2
    end
  end
end
