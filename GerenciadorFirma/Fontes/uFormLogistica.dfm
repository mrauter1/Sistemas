object FormLogistica: TFormLogistica
  Left = 0
  Top = 0
  Caption = 'Organizar entregas por produto'
  ClientHeight = 572
  ClientWidth = 843
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
  object Panel1: TPanel
    Left = 0
    Top = 541
    Width = 843
    Height = 31
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 0
    DesignSize = (
      843
      31)
    object BtnAtualiza: TButton
      Left = 392
      Top = 3
      Width = 88
      Height = 25
      Anchors = [akBottom]
      Caption = 'Atualiza'
      TabOrder = 0
    end
    object BtnOpcoes: TBitBtn
      Left = 5
      Top = 1
      Width = 26
      Height = 27
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 843
    Height = 541
    Align = alClient
    TabOrder = 1
    object cxGridDBTableView: TcxGridDBTableView
      PopupMenu = PopupMenuOpcoes
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DsGrupos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.ContentEven = cxStyleDefault
      Styles.ContentOdd = cxStyleDefault
      Styles.OnGetContentStyle = cxGridDBTableViewStylesGetContentStyle
      Styles.Group = cxStyleGroup
      Styles.Header = cxStyleDefault
      Styles.StyleSheet = cxGridTableViewStyleSheet1
      object cxGridDBTableViewCodGrupoSub: TcxGridDBColumn
        DataBinding.FieldName = 'CodGrupoSub'
        Visible = False
      end
      object cxGridDBTableViewNOMESUBGRUPO: TcxGridDBColumn
        DataBinding.FieldName = 'NOMESUBGRUPO'
        Width = 180
      end
      object cxGridDBTableViewTotLitros: TcxGridDBColumn
        DataBinding.FieldName = 'TotLitros'
      end
      object cxGridDBTableViewQuantPedidos: TcxGridDBColumn
        DataBinding.FieldName = 'QuantPedidos'
      end
      object cxGridDBTableViewLitrosEstoque: TcxGridDBColumn
        DataBinding.FieldName = 'LitrosEstoque'
      end
    end
    object cxGridDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DsProdutos
      DataController.DetailKeyFieldNames = 'CodGrupoSub'
      DataController.KeyFieldNames = 'CodGrupoSub'
      DataController.MasterKeyFieldNames = 'CodGrupoSub'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      Styles.OnGetContentStyle = cxGridDBTableView1StylesGetContentStyle
      Styles.Header = cxStyleDefault
      object cxGridDBTableView1CodGrupoSub: TcxGridDBColumn
        DataBinding.FieldName = 'CodGrupoSub'
        Visible = False
      end
      object cxGridDBTableView1NOMEPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'NOMEPRODUTO'
        Width = 229
      end
      object cxGridDBTableView1NumPedidos: TcxGridDBColumn
        DataBinding.FieldName = 'NumPedidos'
      end
      object cxGridDBTableView1LitrosPedidos: TcxGridDBColumn
        DataBinding.FieldName = 'LitrosPedidos'
      end
      object cxGridDBTableView1SomaPedidos: TcxGridDBColumn
        DataBinding.FieldName = 'SomaPedidos'
      end
      object cxGridDBTableView1EstoqueProduto: TcxGridDBColumn
        DataBinding.FieldName = 'EstoqueProduto'
        Width = 99
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
  end
  object PopupMenuOpcoes: TPopupMenu
    Left = 512
    Top = 16
    object MenuGerenciarPedidos: TMenuItem
      Caption = 'Gerenciar Pedidos do Grupo'
      OnClick = MenuGerenciarPedidosClick
    end
  end
  object DsGrupos: TDataSource
    AutoEdit = False
    DataSet = QryGrupos
    Left = 512
    Top = 152
  end
  object QryGrupos: TFDQuery
    Active = True
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from log.PedidosPorGrupoConsolidado'
      'order by TotLitros desc')
    Left = 608
    Top = 152
    object QryGruposCodGrupoSub: TStringField
      FieldName = 'CodGrupoSub'
      Origin = 'CodGrupoSub'
      Required = True
      FixedChar = True
      Size = 7
    end
    object QryGruposNOMESUBGRUPO: TStringField
      DisplayLabel = 'Grupo'
      DisplayWidth = 35
      FieldName = 'NOMESUBGRUPO'
      Origin = 'NOMESUBGRUPO'
      FixedChar = True
      Size = 30
    end
    object QryGruposTotLitros: TFMTBCDField
      DisplayLabel = 'Litros Pedidos'
      DisplayWidth = 10
      FieldName = 'TotLitros'
      Origin = 'TotLitros'
      DisplayFormat = '#0'
      Precision = 38
    end
    object QryGruposTotQuilos: TFMTBCDField
      DisplayLabel = 'Total Quilos'
      DisplayWidth = 10
      FieldName = 'TotQuilos'
      Origin = 'TotQuilos'
      DisplayFormat = '#0'
      Precision = 38
      Size = 6
    end
    object QryGruposQuantPedidos: TIntegerField
      DisplayLabel = 'Num. Pedidos'
      DisplayWidth = 12
      FieldName = 'QuantPedidos'
      Origin = 'QuantPedidos'
    end
    object QryGruposLitrosEstoque: TFMTBCDField
      DisplayLabel = 'Estoque em Litros'
      DisplayWidth = 16
      FieldName = 'LitrosEstoque'
      Origin = 'LitrosEstoque'
      DisplayFormat = '#0'
      Precision = 38
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 555
    Top = 304
    PixelsPerInch = 96
    object cxStyleLinhaPar: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10066329
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyleLinhaImpar: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 9041394
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyleGroup: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object cxStyleVermelho: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxStyleDefault: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxGridTableViewStyleSheet1: TcxGridTableViewStyleSheet
      Styles.ContentEven = cxStyleLinhaImpar
      Styles.ContentOdd = cxStyleLinhaPar
      Styles.Group = cxStyleGroup
      BuiltIn = True
    end
  end
  object QryProdutos: TFDQuery
    Active = True
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from log.PedidosPorProduto'
      'order by CodGrupoSub, LitrosPedidos desc')
    Left = 608
    Top = 216
    object QryProdutosCodGrupoSub: TStringField
      FieldName = 'CodGrupoSub'
      Origin = 'CodGrupoSub'
      Required = True
      Visible = False
      FixedChar = True
      Size = 7
    end
    object QryProdutosCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Origin = 'CODPRODUTO'
      Required = True
      Visible = False
      FixedChar = True
      Size = 6
    end
    object QryProdutosNOMEPRODUTO: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 30
      FieldName = 'NOMEPRODUTO'
      Origin = 'NOMEPRODUTO'
      Size = 80
    end
    object QryProdutosNumPedidos: TIntegerField
      DisplayLabel = 'Num. Pedidos'
      FieldName = 'NumPedidos'
      Origin = 'NumPedidos'
      ReadOnly = True
    end
    object QryProdutosLitrosPedidos: TFMTBCDField
      DisplayLabel = 'Litros Pedidos'
      DisplayWidth = 12
      FieldName = 'LitrosPedidos'
      Origin = 'LitrosPedidos'
      DisplayFormat = '#0'
      Precision = 38
    end
    object QryProdutosSomaPedidos: TFMTBCDField
      DisplayLabel = 'Soma Pedidos'
      DisplayWidth = 12
      FieldName = 'SomaPedidos'
      Origin = 'SomaPedidos'
      ReadOnly = True
      DisplayFormat = '#0'
      Precision = 38
    end
    object QryProdutosEstoqueProduto: TFMTBCDField
      DisplayLabel = 'Estoque Produto'
      DisplayWidth = 12
      FieldName = 'EstoqueProduto'
      Origin = 'EstoqueProduto'
      ReadOnly = True
      DisplayFormat = '#0'
      Precision = 37
    end
  end
  object DsProdutos: TDataSource
    AutoEdit = False
    DataSet = QryProdutos
    Left = 512
    Top = 216
  end
end
