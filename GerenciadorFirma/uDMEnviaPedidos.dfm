object DMEnviaPedidos: TDMEnviaPedidos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 234
  Width = 378
  object SQLQuery: TSQLQuery
    MaxBlobSize = -1
    Params = <>
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
    SQLConnection = DmSqlUtils.SQLConnection
    Left = 176
    Top = 88
    object SQLQueryCODPEDIDO: TStringField
      DisplayLabel = 'Nro. Pedido:'
      FieldName = 'CODPEDIDO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object SQLQueryNOMECLI: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'NOMECLI'
      Size = 89
    end
    object SQLQueryDATAENTREGA: TDateField
      DisplayLabel = 'Data Entrega'
      FieldName = 'DATAENTREGA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object SQLQueryNOMETRANSP: TStringField
      DisplayLabel = 'Transportadora'
      FieldName = 'NOMETRANSP'
      Size = 39
    end
    object SQLQueryCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      FixedChar = True
      Size = 35
    end
    object SQLQuerySITUACAO: TStringField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'SITUACAO'
      FixedChar = True
      Size = 9
    end
    object SQLQuerySITBLOQUEIO: TStringField
      DisplayLabel = 'Situa'#231#227'o Bloqueio'
      FieldName = 'SITBLOQUEIO'
      Required = True
      FixedChar = True
      Size = 19
    end
    object SQLQueryNOMECONDICAO: TStringField
      DisplayLabel = 'Cond. Pgto'
      FieldName = 'NOMECONDICAO'
      Size = 36
    end
    object SQLQueryTOTITENS: TIntegerField
      DisplayLabel = 'Total de Itens'
      FieldName = 'TOTITENS'
    end
  end
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
  object QryProdutosPed: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'CODPEDIDO'
        ParamType = ptInput
      end>
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
    SQLConnection = DmSqlUtils.SQLConnection
    Left = 176
    Top = 152
    object QryProdutosPedPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 89
    end
    object QryProdutosPedUNIDADE: TStringField
      FieldName = 'UNIDADE'
      Size = 22
    end
    object QryProdutosPedQUANTATENDIDA: TLargeintField
      DisplayLabel = 'Quant. Atendida'
      FieldName = 'QUANTATENDIDA'
    end
    object QryProdutosPedSOLTOATENDIDO: TLargeintField
      DisplayLabel = 'Solto Atendido'
      FieldName = 'SOLTOATENDIDO'
    end
    object QryProdutosPedQUANTPENDENTE: TLargeintField
      DisplayLabel = 'Quant. Pendente'
      FieldName = 'QUANTPENDENTE'
    end
    object QryProdutosPedSOLTOPENDENTE: TLargeintField
      DisplayLabel = 'Solto Pendente'
      FieldName = 'SOLTOPENDENTE'
    end
    object QryProdutosPedPRECO: TFMTBCDField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'PRECO'
      DisplayFormat = '#0.00'
      Precision = 18
    end
    object QryProdutosPedVALTOTAL: TFMTBCDField
      DisplayLabel = 'Val. Total'
      FieldName = 'VALTOTAL'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 2
    end
  end
  object Timer1: TTimer
    Interval = 120000
    OnTimer = Timer1Timer
    Left = 96
    Top = 48
  end
end
