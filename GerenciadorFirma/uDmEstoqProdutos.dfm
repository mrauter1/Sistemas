object DmEstoqProdutos: TDmEstoqProdutos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 270
  Width = 397
  object QryEstoq: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select '
      
        '   ROW_NUMBER() OVER (ORDER BY FALTAHOJE desc, FALTACONFIRMADA d' +
        'esc, FALTATOTAL desc, ProbFaltaHoje DESC, DiasEstoque) AS Rank,'
      '   *, '
      '   A.NomeAplicacao'
      'FROM PrevisaoProdutoEmFalta E'
      'left join APLICA A ON A.CodAplicacao = E.CodAplicacao'
      
        'where (NaoFazEstoque <> 1 and E.EspacoEstoque > 0 and EstoqMaxCa' +
        'lculado > 0) '
      '     or (E.FaltaTotal > 0)'
      
        'ORDER BY FALTAHOJE desc, FALTACONFIRMADA desc, FALTATOTAL desc, ' +
        'ProbFaltaHoje DESC, DiasEstoque')
    Left = 104
    Top = 96
    object QryEstoqRank: TLargeintField
      FieldName = 'Rank'
      Origin = 'Rank'
      ReadOnly = True
    end
    object QryEstoqCODPRODUTO: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryEstoqAPRESENTACAO: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'APRESENTACAO'
      Size = 80
    end
    object QryEstoqCodAplicacao: TStringField
      DisplayLabel = 'Cod. Aplica'#231#227'o'
      FieldName = 'CodAplicacao'
      Origin = 'CodAplicacao'
      FixedChar = True
      Size = 4
    end
    object QryEstoqNOMEAPLICACAO: TStringField
      DisplayLabel = 'Aplicaca'#231#227'o'
      FieldName = 'NOMEAPLICACAO'
      Origin = 'NOMEAPLICACAO'
      FixedChar = True
      Size = 30
    end
    object QryEstoqESTOQUEATUAL: TBCDField
      DisplayLabel = 'Estoque'
      FieldName = 'ESTOQUEATUAL'
      DisplayFormat = '#0.00'
      Precision = 18
    end
    object QryEstoqESPACOESTOQUE: TIntegerField
      DisplayLabel = 'Espa'#231'o Estoque'
      FieldName = 'ESPACOESTOQUE'
      Origin = 'ESPACOESTOQUE'
    end
    object QryEstoqDEMANDAC1: TFMTBCDField
      DisplayLabel = 'Demanda Cliente1'
      FieldName = 'DEMANDAC1'
      Origin = 'DEMANDAC1'
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 5
    end
    object QryEstoqROTACAO: TIntegerField
      DisplayLabel = 'Rota'#231'ao'
      FieldName = 'ROTACAO'
    end
    object QryEstoqMediaSaida: TFMTBCDField
      DisplayLabel = 'M'#233'dia Sa'#237'da'
      FieldName = 'MediaSaida'
      Origin = 'MediaSaida'
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 6
    end
    object QryEstoqStdDev: TFloatField
      DisplayLabel = 'Desvio Padr'#227'o'
      FieldName = 'StdDev'
      Origin = 'StdDev'
      DisplayFormat = '#0.00'
    end
    object QryEstoqFaltaConfirmada: TFMTBCDField
      DisplayLabel = 'Falta Confirmada'
      FieldName = 'FaltaConfirmada'
      Origin = 'FaltaConfirmada'
      ReadOnly = True
      Precision = 38
      Size = 4
    end
    object QryEstoqFaltaHoje: TFMTBCDField
      DisplayLabel = 'Falta Hoje'
      FieldName = 'FaltaHoje'
      Origin = 'FaltaHoje'
      ReadOnly = True
      Precision = 38
      Size = 4
    end
    object QryEstoqFaltaTotal: TFMTBCDField
      DisplayLabel = 'Falta Total'
      FieldName = 'FaltaTotal'
      Origin = 'FaltaTotal'
      ReadOnly = True
      Precision = 38
      Size = 4
    end
    object QryEstoqProbFaltaHoje: TFloatField
      DisplayLabel = 'Prob. Falta Hoje'
      FieldName = 'ProbFaltaHoje'
      Origin = 'ProbFaltaHoje'
      ReadOnly = True
      DisplayFormat = '#0.00'
    end
    object QryEstoqDIASESTOQUE: TBCDField
      DisplayLabel = 'Dias Estoq'
      FieldName = 'DIASESTOQUE'
      Origin = 'DIASESTOQUE'
      DisplayFormat = '#0.00'
      Precision = 14
      Size = 2
    end
    object QryEstoqDemandaDiaria: TBCDField
      DisplayLabel = 'Demanda Diaria'
      FieldName = 'DemandaDiaria'
      Origin = 'DemandaDiaria'
      DisplayFormat = '#0.00'
      Precision = 14
    end
    object QryEstoqDemanda: TFMTBCDField
      FieldName = 'Demanda'
      Origin = 'Demanda'
      Precision = 38
      Size = 5
    end
    object QryEstoqNUMPEDIDOS: TIntegerField
      DisplayLabel = 'Num. Pedidos'
      FieldName = 'NUMPEDIDOS'
      Origin = 'NUMPEDIDOS'
    end
    object QryEstoqPercentDias: TFloatField
      DisplayLabel = '% Dias com Sa'#237'da'
      FieldName = 'PercentDias'
      Origin = 'PercentDias'
      ReadOnly = True
      DisplayFormat = '#0.00'
    end
    object QryEstoqProbFalta: TBCDField
      DisplayLabel = 'Prob. Falta Se Sair'
      FieldName = 'ProbFalta'
      Origin = 'ProbFalta'
      DisplayFormat = '#0.00'
      Precision = 7
      Size = 3
    end
    object QryEstoqEstoqMaxCalculado: TFMTBCDField
      DisplayLabel = 'Estoq Max Calc.'
      FieldName = 'EstoqMaxCalculado'
      Origin = 'EstoqMaxCalculado'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 6
    end
    object QryEstoqNAOFAZESTOQUE: TBooleanField
      DisplayLabel = 'N'#227'o Faz Estoq'
      FieldName = 'NAOFAZESTOQUE'
      Origin = 'NAOFAZESTOQUE'
    end
    object QryEstoqPRODUCAOMINIMA: TIntegerField
      DisplayLabel = 'Produ'#231#227'o Min.'
      FieldName = 'PRODUCAOMINIMA'
      Origin = 'PRODUCAOMINIMA'
      DisplayFormat = '#0.00'
    end
    object QryEstoqSOMANOPESOLIQ: TBooleanField
      DisplayLabel = 'Soma no Peso Liq.'
      FieldName = 'SOMANOPESOLIQ'
      Origin = 'SOMANOPESOLIQ'
    end
  end
  object QryPedPro: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select *'
      'FROM PEDIDOS'
      'ORDER BY CODPRODUTO, DiasParaEntrega, CodCliente')
    Left = 272
    Top = 96
    object QryPedProCODPRODUTO: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'CODPRODUTO'
      Origin = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryPedProCODPEDIDO: TStringField
      DisplayLabel = 'Cod. Pedido'
      FieldName = 'CODPEDIDO'
      Origin = 'CODPEDIDO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryPedProCODCLIENTE: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'CODCLIENTE'
      Origin = 'CODCLIENTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryPedProNOMECLIENTE: TStringField
      DisplayLabel = 'Nome Cliente'
      FieldName = 'NOMECLIENTE'
      Origin = 'NOMECLIENTE'
      Size = 80
    end
    object QryPedProDATAENTREGA: TDateField
      DisplayLabel = 'Data Entrega'
      FieldName = 'DATAENTREGA'
      Origin = 'DATAENTREGA'
    end
    object QryPedProDIASPARAENTREGA: TIntegerField
      DisplayLabel = 'Dias Para Entrega'
      FieldName = 'DIASPARAENTREGA'
      Origin = 'DIASPARAENTREGA'
    end
    object QryPedProSITUACAO: TStringField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object QryPedProNOMEPRODUTO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'NOMEPRODUTO'
      Origin = 'NOMEPRODUTO'
      Size = 80
    end
    object QryPedProQUANTIDADE: TBCDField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      Precision = 18
    end
    object QryPedProQUANTPENDENTE: TBCDField
      DisplayLabel = 'Quant. N'#227'o Atendida'
      FieldName = 'QUANTPENDENTE'
      Origin = 'QUANTPENDENTE'
      Precision = 18
    end
    object QryPedProCODTRANSPORTE: TStringField
      DisplayLabel = 'Cod. Transporte'
      FieldName = 'CODTRANSPORTE'
      Origin = 'CODTRANSPORTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryPedProNOMETRANSPORTE: TStringField
      DisplayLabel = 'Nome Transporte'
      FieldName = 'NOMETRANSPORTE'
      Origin = 'NOMETRANSPORTE'
      Size = 39
    end
  end
end
