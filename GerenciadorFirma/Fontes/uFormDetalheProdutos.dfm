object FormDetalheProdutos: TFormDetalheProdutos
  Left = 0
  Top = 0
  Caption = 'Detalhamento da An'#225'lise dos Produtos'
  ClientHeight = 417
  ClientWidth = 1067
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 1067
    Height = 417
    Align = alClient
    TabOrder = 0
    object cxGridDBTableView: TcxGridDBTableView
      PopupMenu = PopupMenu1
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxGridDBTableViewCellDblClick
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellAutoHeight = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridDBTableViewCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
        Width = 44
      end
      object cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn
        DataBinding.FieldName = 'APRESENTACAO'
        Width = 225
      end
      object cxGridDBTableViewNOMEAPLICACAO: TcxGridDBColumn
        DataBinding.FieldName = 'NOMEAPLICACAO'
        Width = 98
      end
      object cxGridDBTableViewESTOQUEATUAL: TcxGridDBColumn
        DataBinding.FieldName = 'ESTOQUEATUAL'
        Width = 59
      end
      object cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'ESPACOESTOQUE'
        Width = 55
      end
      object cxGridDBTableViewDemandaDiaria: TcxGridDBColumn
        DataBinding.FieldName = 'DemandaDiaria'
        Width = 60
      end
      object cxGridDBTableViewMediaSaida: TcxGridDBColumn
        DataBinding.FieldName = 'MediaSaida'
        Width = 52
      end
      object cxGridDBTableViewStdDev: TcxGridDBColumn
        DataBinding.FieldName = 'StdDev'
        Width = 54
      end
      object cxGridDBTableViewProbFalta: TcxGridDBColumn
        DataBinding.FieldName = 'ProbFalta'
        OnGetDisplayText = cxGridDBTableViewPercentDiasGetDisplayText
        Width = 62
      end
      object cxGridDBTableViewPercentDias: TcxGridDBColumn
        DataBinding.FieldName = 'PercentDias'
        OnGetDisplayText = cxGridDBTableViewPercentDiasGetDisplayText
        Width = 62
      end
      object cxGridDBTableViewProbFaltaHoje: TcxGridDBColumn
        DataBinding.FieldName = 'ProbFaltaHoje'
        OnGetDisplayText = cxGridDBTableViewPercentDiasGetDisplayText
        Width = 60
      end
      object cxGridDBTableViewDIASESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'DIASESTOQUE'
        Width = 62
      end
      object cxGridDBTableViewROTACAO: TcxGridDBColumn
        DataBinding.FieldName = 'ROTACAO'
        Width = 49
      end
      object cxGridDBTableViewDEMANDAC1: TcxGridDBColumn
        DataBinding.FieldName = 'DEMANDAC1'
        Width = 57
      end
      object cxGridDBTableViewDemanda: TcxGridDBColumn
        DataBinding.FieldName = 'Demanda'
        Width = 57
      end
      object cxGridDBTableViewEstoqMaxCalculado: TcxGridDBColumn
        DataBinding.FieldName = 'EstoqMaxCalculado'
        Width = 57
      end
      object cxGridDBTableViewNAOFAZESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'NAOFAZESTOQUE'
        Width = 55
      end
      object cxGridDBTableViewPRODUCAOMINIMA: TcxGridDBColumn
        DataBinding.FieldName = 'PRODUCAOMINIMA'
        Width = 53
      end
      object cxGridDBTableViewSOMANOPESOLIQ: TcxGridDBColumn
        DataBinding.FieldName = 'SOMANOPESOLIQ'
        Width = 59
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = QryDetalhesPro
    Left = 368
    Top = 176
  end
  object PopupMenu1: TPopupMenu
    Left = 368
    Top = 88
    object AbrirConfigPro: TMenuItem
      Caption = 'Configura'#231#227'o do Produto'
      OnClick = AbrirConfigProClick
    end
    object AbrirDetalhePro: TMenuItem
      Caption = 'Detalhamento do Produto'
      OnClick = AbrirDetalheProClick
    end
    object VerSimilares1: TMenuItem
      Caption = 'Produtos Equivalentes'
      OnClick = VerSimilares1Click
    end
    object VerInsumos1: TMenuItem
      Caption = 'Ver Insumos'
      OnClick = VerInsumos1Click
    end
  end
  object QryDetalhesPro: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select '
      '   E.*, '
      '   G.NomeSubGrupo,'
      '   A.NomeAplicacao'
      'FROM PrevisaoProdutoEmFalta E'
      'inner join PRODUTO P ON P.CodProduto = E.CodProduto'
      'inner join GrupoSub G on G.CodGrupoSub = P.CodGrupoSub'
      'left join APLICA A ON A.CodAplicacao = E.CodAplicacao'
      'ORDER BY P.CodGrupoSub, E.CodAplicacao, E.Apresentacao')
    Left = 224
    Top = 176
    object QryDetalhesProCODPRODUTO: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryDetalhesProAPRESENTACAO: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'APRESENTACAO'
      Size = 80
    end
    object QryDetalhesProCodAplicacao: TStringField
      DisplayLabel = 'Cod. Aplica'#231#227'o'
      FieldName = 'CodAplicacao'
      Origin = 'CodAplicacao'
      FixedChar = True
      Size = 4
    end
    object QryDetalhesProNOMEAPLICACAO: TStringField
      DisplayLabel = 'Aplicaca'#231#227'o'
      FieldName = 'NOMEAPLICACAO'
      Origin = 'NOMEAPLICACAO'
      FixedChar = True
      Size = 30
    end
    object QryDetalhesProESTOQUEATUAL: TBCDField
      DisplayLabel = 'Estoque'
      FieldName = 'ESTOQUEATUAL'
      DisplayFormat = '#0.00'
      Precision = 18
    end
    object QryDetalhesProESPACOESTOQUE: TIntegerField
      DisplayLabel = 'Espa'#231'o Estoque'
      FieldName = 'ESPACOESTOQUE'
      Origin = 'ESPACOESTOQUE'
    end
    object QryDetalhesProDEMANDAC1: TFMTBCDField
      DisplayLabel = 'Demanda Cliente1'
      FieldName = 'DEMANDAC1'
      Origin = 'DEMANDAC1'
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 5
    end
    object QryDetalhesProROTACAO: TIntegerField
      DisplayLabel = 'Rota'#231'ao'
      FieldName = 'ROTACAO'
    end
    object QryDetalhesProMediaSaida: TFMTBCDField
      DisplayLabel = 'M'#233'dia Sa'#237'da'
      FieldName = 'MediaSaida'
      Origin = 'MediaSaida'
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 6
    end
    object QryDetalhesProStdDev: TFloatField
      DisplayLabel = 'Desvio Padr'#227'o'
      FieldName = 'StdDev'
      Origin = 'StdDev'
      DisplayFormat = '#0.00'
    end
    object QryDetalhesProFaltaConfirmada: TFMTBCDField
      DisplayLabel = 'Falta Confirmada'
      FieldName = 'FaltaConfirmada'
      Origin = 'FaltaConfirmada'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 4
    end
    object QryDetalhesProFaltaHoje: TFMTBCDField
      DisplayLabel = 'Falta Hoje'
      FieldName = 'FaltaHoje'
      Origin = 'FaltaHoje'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 4
    end
    object QryDetalhesProFaltaTotal: TFMTBCDField
      DisplayLabel = 'Falta Total'
      FieldName = 'FaltaTotal'
      Origin = 'FaltaTotal'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 4
    end
    object QryDetalhesProProbFaltaHoje: TFloatField
      DisplayLabel = 'Prob. Falta Hoje'
      FieldName = 'ProbFaltaHoje'
      Origin = 'ProbFaltaHoje'
      ReadOnly = True
      DisplayFormat = '#0.00'
    end
    object QryDetalhesProDIASESTOQUE: TBCDField
      DisplayLabel = 'Dias Estoq'
      FieldName = 'DIASESTOQUE'
      Origin = 'DIASESTOQUE'
      DisplayFormat = '#0.00'
      Precision = 14
      Size = 2
    end
    object QryDetalhesProDemandaDiaria: TBCDField
      DisplayLabel = 'Demanda Diaria'
      FieldName = 'DemandaDiaria'
      Origin = 'DemandaDiaria'
      DisplayFormat = '#0.00'
      Precision = 14
    end
    object QryDetalhesProDemanda: TFMTBCDField
      FieldName = 'Demanda'
      Origin = 'Demanda'
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 5
    end
    object QryDetalhesProNUMPEDIDOS: TIntegerField
      DisplayLabel = 'Num. Pedidos'
      FieldName = 'NUMPEDIDOS'
      Origin = 'NUMPEDIDOS'
    end
    object QryDetalhesProPercentDias: TFloatField
      DisplayLabel = '% Dias com Sa'#237'da'
      FieldName = 'PercentDias'
      Origin = 'PercentDias'
      ReadOnly = True
      DisplayFormat = '#0.00'
    end
    object QryDetalhesProProbFalta: TBCDField
      DisplayLabel = 'Prob. Falta Se Sair'
      FieldName = 'ProbFalta'
      Origin = 'ProbFalta'
      DisplayFormat = '#0.00'
      Precision = 7
      Size = 3
    end
    object QryDetalhesProEstoqMaxCalculado: TFMTBCDField
      DisplayLabel = 'Estoq Max Calc.'
      FieldName = 'EstoqMaxCalculado'
      Origin = 'EstoqMaxCalculado'
      ReadOnly = True
      DisplayFormat = '#0.00'
      Precision = 38
      Size = 6
    end
    object QryDetalhesProNAOFAZESTOQUE: TBooleanField
      DisplayLabel = 'N'#227'o Faz Estoq'
      FieldName = 'NAOFAZESTOQUE'
      Origin = 'NAOFAZESTOQUE'
    end
    object QryDetalhesProPRODUCAOMINIMA: TIntegerField
      DisplayLabel = 'Produ'#231#227'o Min.'
      FieldName = 'PRODUCAOMINIMA'
      Origin = 'PRODUCAOMINIMA'
      DisplayFormat = '#0.00'
    end
    object QryDetalhesProSOMANOPESOLIQ: TBooleanField
      DisplayLabel = 'Soma no Peso Liq.'
      FieldName = 'SOMANOPESOLIQ'
      Origin = 'SOMANOPESOLIQ'
    end
  end
end
