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
    Height = 375
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 417
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
  object Panel1: TPanel
    Left = 0
    Top = 375
    Width = 1067
    Height = 42
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitWidth = 998
    DesignSize = (
      1067
      42)
    object BtnAtualiza: TButton
      Left = 272
      Top = 9
      Width = 516
      Height = 25
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Atualiza'
      TabOrder = 0
      ExplicitWidth = 447
    end
    object BtnOpcoes: TBitBtn
      Left = 5
      Top = 6
      Width = 26
      Height = 27
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object BtnExcelcxGridTarefa: TBitBtn
      Left = 52
      Top = 7
      Width = 77
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Exportar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E000000000000000000002E7749266E43
        357B532367443070531B594137725D205B4725624E23634D195B3E004622256E
        460351220F612D0A5C2739734A73AC856BA17C679C7B61927664947C58867072
        A08D5A887552836D53896C558E6D48855F4283565394660B501E5F7D5A7D9A79
        E8FFE4E5FEE2F3FFF0C7DDC5E7FAE5C9DCC7D8EBD6D6ECD4E1FAE0DAF6D8B7D6
        B5D6F8D34C71492E562C6F8568778D70D1E7CAF6FFEDD0E3C8E2F3D8F8FFEEE6
        F7DCDEEFD4E5F9DCD6ECCFCEE6C6ECFFE5CEECC96889642E4F2A49715595BDA1
        E4FFEEDFFFE6D7FCDAE4FFE7D5FBD7CDF3CF8FB690365F39244D2726522B2150
        2AC9FAD44A7B552356304E7E6481B296CBFBDE5082602C5D371C4B2432633719
        4A1C265A2B6B9F704C81556BA1762C643BB0E9C256916B29634057876F86B69C
        DDFFF0CEFFDE6C9E766DA0745789595386548FC49273A8765D946319502375AD
        84C0F9D357916E17533162927A7AAA90D9FFECD5FFE3D4FFDE75A97A4679477E
        B27D5D945D4A804B20582570A7785C946BBEF7D1589170215C3D6D9B8487B69C
        DFFFF0DAFFE6C7F6CF5081539ED19F699D686397614379441D5522BDF4C5C5FD
        D4C1FAD45A93722E674867957E94C3A9D6FFE7DCFFEA61906996C79B7BAD7D6F
        A270518452639664497D4D24592DC6FBD3CCFFDD5B93701E57367CA98F99C6AB
        D6FFE5588564AFDBB681AE8785B388578658507F5175A678649569396B412A5F
        37BAF1CA578D6851896676997EB1D4B9EAFFEE80A28368896789AA886A8A67EC
        FFEAE1FFDE648963648963668D675A8560D0FCD77DA98424532D95A78AB7C9AC
        EAF9DDFAFFEDF9FFECECF9DFFDFFEEE9F4DAFDFFEED1DFC3F1FFE4DBEDCEF1FF
        E5D3EBC98FA9854F6B47ABC3A1B9D0B0F6FFEDF6FFECEDFDE5FAFFF1FAFFF2FA
        FFF2EAF6E2F8FFF1EDFFE7F2FFEBE4FCDCE8FFE088A78056784F659971A7DAB4
        A8D8B495C4A4B1DCC190B7A193BAA590B6A488AE9C85AE9990BDA276A7876B9F
        7A7CB489639E71306E3E85C89B78BA9071B0896AA785659C8176AC955287735E
        92805F93813D7560528C703C7C593C7D563E86582F784635804C}
      TabOrder = 2
      OnClick = BtnExcelcxGridTarefaClick
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
  object SaveDialog: TSaveDialog
    DefaultExt = '.xls'
    Title = 'Definir o Caminho e o Nome do Arquivo para Exporta'#231#227'o'
    Left = 75
    Top = 200
  end
end
