object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Transportadoras'
  ClientHeight = 483
  ClientWidth = 877
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GridTransp: TcxGrid
    Left = 0
    Top = 0
    Width = 877
    Height = 483
    Align = alClient
    TabOrder = 0
    object GridTranspDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DsTransp
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.CellAutoHeight = True
      OptionsView.CellTextMaxLineCount = 2
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      object GridTranspDBTableView1CODTRANSPORTE: TcxGridDBColumn
        DataBinding.FieldName = 'CODTRANSPORTE'
        Width = 59
      end
      object GridTranspDBTableView1NOMETRANSPORTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMETRANSPORTE'
      end
      object GridTranspDBTableView1NUMENTREGAS: TcxGridDBColumn
        DataBinding.FieldName = 'NUMENTREGAS'
      end
      object GridTranspDBTableView1VOLUMES: TcxGridDBColumn
        DataBinding.FieldName = 'VOLUMES'
      end
      object GridTranspDBTableView1AREATOTAL: TcxGridDBColumn
        DataBinding.FieldName = 'AREATOTAL'
      end
      object GridTranspDBTableView1PESOTOTAL: TcxGridDBColumn
        DataBinding.FieldName = 'PESOTOTAL'
      end
    end
    object cxViewTranspDetalhe: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DsTranspDetalhe
      DataController.DetailKeyFieldNames = 'CODTRANSPORTE'
      DataController.KeyFieldNames = 'CODTRANSPORTE'
      DataController.MasterKeyFieldNames = 'CODTRANSPORTE'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#0.00'
          Kind = skSum
          FieldName = 'TRANQUANTIDADE'
          Column = cxViewTranspDetalheTRANQUANTIDADE
          DisplayText = 'Volumes'
        end
        item
          Kind = skCount
          FieldName = 'CODPEDIDO'
          Column = cxViewTranspDetalheCODPEDIDO
          DisplayText = 'Qtd. Pedidos'
        end
        item
          Kind = skSum
          FieldName = 'PESOBRUTO'
          Column = cxViewTranspDetalhePESOBRUTO
          DisplayText = 'Peso Total'
        end
        item
          Kind = skSum
          FieldName = 'AREA'
          Column = cxViewTranspDetalheAREA
          DisplayText = #193'rea Total'
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsView.CellAutoHeight = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      object cxViewTranspDetalheORIG: TcxGridDBColumn
        DataBinding.FieldName = 'ORIG'
        Width = 30
      end
      object cxViewTranspDetalheCODPEDIDO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPEDIDO'
        Width = 60
      end
      object cxViewTranspDetalheSITUACAO: TcxGridDBColumn
        DataBinding.FieldName = 'SITUACAO'
        Width = 61
      end
      object cxViewTranspDetalheRAZAOSOCIAL: TcxGridDBColumn
        DataBinding.FieldName = 'RAZAOSOCIAL'
        Width = 306
      end
      object cxViewTranspDetalheDATAENTREGA: TcxGridDBColumn
        DataBinding.FieldName = 'DATAENTREGA'
      end
      object cxViewTranspDetalheTRANQUANTIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'TRANQUANTIDADE'
      end
      object cxViewTranspDetalheTRANVOLUME: TcxGridDBColumn
        DataBinding.FieldName = 'TRANVOLUME'
        Width = 86
      end
      object cxViewTranspDetalheCODTRANSPORTE: TcxGridDBColumn
        DataBinding.FieldName = 'CODTRANSPORTE'
        Visible = False
        Width = 55
      end
      object cxViewTranspDetalheNOMETRANSPORTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMETRANSPORTE'
        Visible = False
        Width = 134
      end
      object cxViewTranspDetalheAREA: TcxGridDBColumn
        DataBinding.FieldName = 'AREA'
        Width = 87
      end
      object cxViewTranspDetalhePESOBRUTO: TcxGridDBColumn
        DataBinding.FieldName = 'PESOBRUTO'
        Width = 93
      end
    end
    object GridTranspLevel1: TcxGridLevel
      GridView = GridTranspDBTableView1
      object GridTranspLevel2: TcxGridLevel
        GridView = cxViewTranspDetalhe
      end
    end
  end
  object DsTransp: TDataSource
    DataSet = QryTransp
    Left = 192
    Top = 112
  end
  object DsTranspDetalhe: TDataSource
    DataSet = QryTranspDetalhe
    Left = 192
    Top = 200
  end
  object QryTransp: TFDQuery
    Filtered = True
    Connection = DataModule1.FDConFirebird
    SQL.Strings = (
      'SELECT'
      '  CODTRANSPORTE, NOMETRANSPORTE,'
      '  COUNT(CODPEDIDO) AS NUMENTREGAS,'
      '  SUM(TRANQUANTIDADE) AS VOLUMES,'
      '  SUM(AREA) AS AREATOTAL,'
      '  SUM(PESOBRUTO) AS PESOTOTAL'
      'FROM '
      '  (SELECT X.ORIG, X.CODPEDIDO, C.RAZAOSOCIAL, P.DATAENTREGA,'
      '  P.SITUACAO,'
      '  P.TRANQUANTIDADE,'
      '  P.TRANVOLUME,'
      '  T.CODTRANSPORTE,'
      '  T.NOMETRANSPORTE,'
      
        '  SUM((IT.QUANTPEDIDA / PRO.UNIDADEESTOQUE) * PRO.AREAM2) AS ARE' +
        'A,'
      
        '  SUM((IT.QUANTPEDIDA / PRO.UNIDADEESTOQUE) * PRO.PESOBRUTO) AS ' +
        'PESOBRUTO'
      '  FROM'
      '  (SELECT '#39'P'#39' AS ORIG, P.CODPEDIDO AS CODPEDIDO'
      '  FROM PEDIDO P'
      
        '  WHERE P.DATAENTREGA <= CAST('#39'NOW'#39' AS DATE) AND P.SITUACAO IN (' +
        #39'0'#39', '#39'1'#39', '#39'2'#39')'
      '  UNION ALL'
      '  SELECT '#39'N'#39' AS ORIG, M.CODPEDIDO AS CODPEDIDO'
      '  FROM MCLI M'
      '  WHERE M.DATADOCUMENTO >= (CAST('#39'NOW'#39' AS DATE)-1)'
      '      AND CODPEDIDO IS NOT NULL'
      '  )X'
      '  INNER JOIN PEDIDO P ON P.CODPEDIDO = X.CODPEDIDO'
      '  INNER JOIN CLIENTE C ON C.CODCLIENTE = P.CODCLIENTE'
      '  INNER JOIN TRANSP T ON P.CODTRANSPORTE = T.CODTRANSPORTE'
      '  LEFT JOIN PEDIDOIT IT ON IT.CODPEDIDO = P.CODPEDIDO'
      '  LEFT JOIN PRODUTO PRO ON PRO.CODPRODUTO = IT.CODPRODUTO'
      '  WHERE T.CODTRANSPORTE IN ('#39'001612'#39', '#39'001640'#39', '#39'001650'#39')'
      
        '  GROUP BY X.ORIG, X.CODPEDIDO, C.RAZAOSOCIAL, P.DATAENTREGA, P.' +
        'SITUACAO, P.TRANQUANTIDADE, P.TRANVOLUME,'
      '  T.CODTRANSPORTE, T.NOMETRANSPORTE'
      '  ORDER BY T.CODTRANSPORTE) Y'
      'GROUP BY CODTRANSPORTE, NOMETRANSPORTE'
      '')
    Left = 288
    Top = 112
    object QryTranspCODTRANSPORTE: TStringField
      DisplayLabel = 'Cod. Transp'
      FieldName = 'CODTRANSPORTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryTranspNOMETRANSPORTE: TStringField
      DisplayLabel = 'Nome Transporte'
      FieldName = 'NOMETRANSPORTE'
      FixedChar = True
      Size = 30
    end
    object QryTranspNUMENTREGAS: TIntegerField
      DisplayLabel = 'Qtd. Entregas'
      FieldName = 'NUMENTREGAS'
      Required = True
    end
    object QryTranspVOLUMES: TLargeintField
      DisplayLabel = 'Volumes'
      FieldName = 'VOLUMES'
    end
    object QryTranspAREATOTAL: TFMTBCDField
      DisplayLabel = #193'rea Total'
      FieldName = 'AREATOTAL'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 10
    end
    object QryTranspPESOTOTAL: TFMTBCDField
      DisplayLabel = 'Peso Total'
      FieldName = 'PESOTOTAL'
      DisplayFormat = '#0.00'
      Precision = 18
    end
  end
  object QryTranspDetalhe: TFDQuery
    Filtered = True
    Connection = DataModule1.FDConFirebird
    SQL.Strings = (
      'SELECT X.ORIG, X.CODPEDIDO, C.RAZAOSOCIAL, P.DATAENTREGA,'
      'P.SITUACAO,'
      'P.TRANQUANTIDADE,'
      'P.TRANVOLUME,'
      'T.CODTRANSPORTE,'
      'T.NOMETRANSPORTE,'
      'SUM((IT.QUANTPEDIDA / PRO.UNIDADEESTOQUE) * PRO.AREAM2) AS AREA,'
      
        'SUM((IT.QUANTPEDIDA / PRO.UNIDADEESTOQUE) * PRO.PESOBRUTO) AS PE' +
        'SOBRUTO'
      'FROM '
      '(SELECT '#39'P'#39' AS ORIG, P.CODPEDIDO AS CODPEDIDO'
      'FROM PEDIDO P'
      
        'WHERE P.DATAENTREGA <= CAST('#39'NOW'#39' AS DATE) AND P.SITUACAO IN ('#39'0' +
        #39', '#39'1'#39', '#39'2'#39')'
      'UNION ALL '
      'SELECT '#39'N'#39' AS ORIG, M.CODPEDIDO AS CODPEDIDO'
      'FROM MCLI M'
      'WHERE M.DATADOCUMENTO >= (CAST('#39'NOW'#39' AS DATE)-1)'
      #9'  AND CODPEDIDO IS NOT NULL'
      ')X'
      'INNER JOIN PEDIDO P ON P.CODPEDIDO = X.CODPEDIDO'
      'INNER JOIN CLIENTE C ON C.CODCLIENTE = P.CODCLIENTE'
      'INNER JOIN TRANSP T ON P.CODTRANSPORTE = T.CODTRANSPORTE '
      'LEFT JOIN PEDIDOIT IT ON IT.CODPEDIDO = P.CODPEDIDO'
      'LEFT JOIN PRODUTO PRO ON PRO.CODPRODUTO = IT.CODPRODUTO'
      'WHERE T.CODTRANSPORTE IN ('#39'001612'#39', '#39'001640'#39', '#39'001650'#39')'
      
        'GROUP BY X.ORIG, X.CODPEDIDO, C.RAZAOSOCIAL, P.DATAENTREGA, P.SI' +
        'TUACAO, P.TRANQUANTIDADE, P.TRANVOLUME,'
      'T.CODTRANSPORTE, T.NOMETRANSPORTE'
      'ORDER BY T.CODTRANSPORTE'
      '')
    Left = 288
    Top = 200
    object QryTranspDetalheORIG: TStringField
      DisplayLabel = 'Origem'
      FieldName = 'ORIG'
      Required = True
      FixedChar = True
      Size = 1
    end
    object QryTranspDetalheCODPEDIDO: TStringField
      DisplayLabel = 'Cod. Pedido'
      FieldName = 'CODPEDIDO'
      FixedChar = True
      Size = 6
    end
    object QryTranspDetalheSITUACAO: TStringField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'SITUACAO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object QryTranspDetalheRAZAOSOCIAL: TStringField
      DisplayLabel = 'Cliente'
      FieldName = 'RAZAOSOCIAL'
      Size = 80
    end
    object QryTranspDetalheDATAENTREGA: TDateField
      DisplayLabel = 'Data Entrega'
      FieldName = 'DATAENTREGA'
    end
    object QryTranspDetalheTRANQUANTIDADE: TIntegerField
      DisplayLabel = 'Itens'
      FieldName = 'TRANQUANTIDADE'
    end
    object QryTranspDetalheTRANVOLUME: TStringField
      DisplayLabel = 'Tipo Volume'
      FieldName = 'TRANVOLUME'
      FixedChar = True
      Size = 10
    end
    object QryTranspDetalheCODTRANSPORTE: TStringField
      DisplayLabel = 'Cod. Transporte'
      FieldName = 'CODTRANSPORTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryTranspDetalheNOMETRANSPORTE: TStringField
      DisplayLabel = 'Nome Transporte'
      FieldName = 'NOMETRANSPORTE'
      FixedChar = True
      Size = 30
    end
    object QryTranspDetalheAREA: TFMTBCDField
      DisplayLabel = #193'rea'
      FieldName = 'AREA'
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 10
    end
    object QryTranspDetalhePESOBRUTO: TFMTBCDField
      DisplayLabel = 'Peso Bruto'
      FieldName = 'PESOBRUTO'
      DisplayFormat = '#0.00'
      Precision = 18
    end
  end
end
