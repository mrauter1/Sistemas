object FormEntregaPorProduto: TFormEntregaPorProduto
  Left = 0
  Top = 0
  Caption = 'Gerencia Entregas por Produto'
  ClientHeight = 496
  ClientWidth = 982
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 211
    Width = 982
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 29
  end
  object PanelTop: TPanel
    Left = 0
    Top = 41
    Width = 982
    Height = 170
    Align = alTop
    TabOrder = 0
    object PanelRight: TPanel
      Left = 683
      Top = 1
      Width = 298
      Height = 168
      Align = alRight
      TabOrder = 0
      object PanelTitulo: TPanel
        Left = 1
        Top = 1
        Width = 296
        Height = 24
        Align = alTop
        Caption = 'Compras'
        TabOrder = 0
      end
      object cxGridCompras: TcxGrid
        Left = 1
        Top = 25
        Width = 296
        Height = 142
        Align = alClient
        TabOrder = 1
        object ViewCompras: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = False
          Navigator.Buttons.PriorPage.Visible = False
          Navigator.Buttons.Prior.Visible = False
          Navigator.Buttons.Next.Visible = False
          Navigator.Buttons.NextPage.Visible = False
          Navigator.Buttons.Last.Visible = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Visible = True
          Navigator.Buttons.Post.Visible = True
          Navigator.Buttons.Refresh.Visible = False
          Navigator.Buttons.SaveBookmark.Visible = False
          Navigator.Buttons.GotoBookmark.Visible = False
          Navigator.Buttons.Filter.Enabled = False
          Navigator.Buttons.Filter.Visible = False
          Navigator.Visible = True
          DataController.DataSource = DsComprasPrevistas
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Appending = True
          OptionsData.CancelOnExit = False
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Styles.Content = cxStyle2
          Styles.Header = cxStyle2
          object ViewComprasData: TcxGridDBColumn
            DataBinding.FieldName = 'Data'
            PropertiesClassName = 'TcxDateEditProperties'
            Width = 114
          end
          object ViewComprasCodGrupoSub: TcxGridDBColumn
            DataBinding.FieldName = 'CodGrupoSub'
            Visible = False
          end
          object ViewComprasCompraPrevista: TcxGridDBColumn
            DataBinding.FieldName = 'CompraPrevista'
            Width = 105
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = ViewCompras
        end
      end
    end
    object PanelLeft: TPanel
      Left = 1
      Top = 1
      Width = 682
      Height = 168
      Align = alClient
      TabOrder = 1
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 680
        Height = 24
        Align = alTop
        Caption = 'Estoque Previsto na Data'
        TabOrder = 0
      end
      object cxGridDatas: TcxGrid
        Left = 1
        Top = 25
        Width = 680
        Height = 142
        Align = alClient
        TabOrder = 1
        object ViewEstoquePrevisto: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = DsEstoquePrevisto
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
          Styles.Content = cxStyle2
          Styles.Header = cxStyle2
          object ViewEstoquePrevistoData: TcxGridDBColumn
            DataBinding.FieldName = 'Data'
            Width = 73
          end
          object ViewEstoquePrevistoCodGrupoSub: TcxGridDBColumn
            DataBinding.FieldName = 'CodGrupoSub'
            Visible = False
          end
          object ViewEstoquePrevistoNOMESUBGRUPO: TcxGridDBColumn
            DataBinding.FieldName = 'NOMESUBGRUPO'
            Visible = False
          end
          object ViewEstoquePrevistoEstoqueAtual: TcxGridDBColumn
            DataBinding.FieldName = 'EstoqueAtual'
            Width = 78
          end
          object ViewEstoquePrevistoCompraPrevista: TcxGridDBColumn
            DataBinding.FieldName = 'CompraPrevista'
            Visible = False
            Width = 98
          end
          object ViewEstoquePrevistoSomaCompras: TcxGridDBColumn
            DataBinding.FieldName = 'SomaCompras'
            Width = 72
          end
          object ViewEstoquePrevistoQuantPedidos: TcxGridDBColumn
            DataBinding.FieldName = 'QuantPedidos'
            Width = 84
          end
          object ViewEstoquePrevistoPedidosDia: TcxGridDBColumn
            DataBinding.FieldName = 'PedidosDia'
          end
          object ViewEstoquePrevistoSomaPedidos: TcxGridDBColumn
            DataBinding.FieldName = 'SomaPedidos'
          end
          object ViewEstoquePrevistoEstoquePrevisto: TcxGridDBColumn
            DataBinding.FieldName = 'EstoquePrevisto'
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = ViewEstoquePrevisto
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 214
    Width = 982
    Height = 282
    Align = alClient
    TabOrder = 1
    object cxGridPedidos: TcxGrid
      Left = 1
      Top = 25
      Width = 980
      Height = 216
      Align = alClient
      TabOrder = 0
      object ViewPedidos: TcxGridDBTableView
        OnKeyDown = ViewPedidosKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = ViewPedidosCellClick
        OnCellDblClick = ViewPedidosCellDblClick
        DataController.DataSource = DsPedidos
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        Styles.Content = cxStyle1
        object ViewPedidosCheck: TcxGridDBColumn
          DataBinding.FieldName = 'Check'
          Width = 30
        end
        object ViewPedidosCodGrupoSub: TcxGridDBColumn
          DataBinding.FieldName = 'CodGrupoSub'
          Visible = False
        end
        object ViewPedidosNOMESUBGRUPO: TcxGridDBColumn
          DataBinding.FieldName = 'NOMESUBGRUPO'
          Visible = False
        end
        object ViewPedidosCodPedido: TcxGridDBColumn
          DataBinding.FieldName = 'CodPedido'
          Width = 44
        end
        object ViewPedidosSituacao: TcxGridDBColumn
          DataBinding.FieldName = 'Situacao'
          Width = 59
        end
        object ViewPedidosNOMECLIENTE: TcxGridDBColumn
          DataBinding.FieldName = 'NOMECLIENTE'
          Width = 177
        end
        object ViewPedidosCODTRANSPORTE: TcxGridDBColumn
          DataBinding.FieldName = 'CODTRANSPORTE'
          Visible = False
        end
        object ViewPedidosNOMETRANSPORTE: TcxGridDBColumn
          DataBinding.FieldName = 'NOMETRANSPORTE'
          Width = 198
        end
        object ViewPedidosCODPRODUTO: TcxGridDBColumn
          DataBinding.FieldName = 'CODPRODUTO'
          Visible = False
        end
        object ViewPedidosNOMEPRODUTO: TcxGridDBColumn
          DataBinding.FieldName = 'NOMEPRODUTO'
        end
        object ViewPedidosLitros: TcxGridDBColumn
          DataBinding.FieldName = 'Litros'
          Width = 51
        end
        object ViewPedidosPeso: TcxGridDBColumn
          DataBinding.FieldName = 'Peso'
          Visible = False
        end
        object ViewPedidosDataProgramada: TcxGridDBColumn
          DataBinding.FieldName = 'DataProgramada'
          Width = 68
        end
        object ViewPedidosDataPedido: TcxGridDBColumn
          DataBinding.FieldName = 'DataPedido'
        end
        object ViewPedidosSomaPedidos: TcxGridDBColumn
          DataBinding.FieldName = 'SomaPedidos'
          Width = 55
        end
      end
      object cxGridPedidosLevel: TcxGridLevel
        GridView = ViewPedidos
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 980
      Height = 24
      Align = alTop
      TabOrder = 1
      object Label2: TLabel
        Left = 39
        Top = 2
        Width = 148
        Height = 16
        Alignment = taRightJustify
        Caption = 'Total Litros Selecionados:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LblLitros: TLabel
        Left = 193
        Top = 2
        Width = 31
        Height = 16
        Caption = 'Litros'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
    object PanelComandos: TPanel
      Left = 1
      Top = 241
      Width = 980
      Height = 40
      Align = alBottom
      TabOrder = 2
      DesignSize = (
        980
        40)
      object Label1: TLabel
        Left = 14
        Top = 8
        Width = 178
        Height = 13
        Alignment = taRightJustify
        Caption = 'Nova Data Programada para Entrega'
      end
      object DatePicker: TDateTimePicker
        Left = 198
        Top = 6
        Width = 186
        Height = 21
        Date = 43915.691506562500000000
        Time = 43915.691506562500000000
        TabOrder = 0
      end
      object BtnAlterarData: TBitBtn
        Left = 390
        Top = 4
        Width = 156
        Height = 25
        Caption = 'Atualiza Pedidos Selecionados'
        TabOrder = 1
        OnClick = BtnAlterarDataClick
      end
      object BtnExcelcxGridTarefa: TBitBtn
        Left = 872
        Top = 4
        Width = 77
        Height = 25
        Anchors = [akTop, akRight]
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
      object BtnAtualizaDatasSidicom: TBitBtn
        Left = 673
        Top = 4
        Width = 193
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Atualiza Data de Entregas no Sidicom'
        TabOrder = 3
        OnClick = BtnAtualizaDatasSidicomClick
      end
    end
  end
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 982
    Height = 41
    Align = alTop
    TabOrder = 2
    object DBTextGrupo: TDBText
      Left = 40
      Top = 9
      Width = 289
      Height = 17
      DataField = 'NOMESUBGRUPO'
      DataSource = DsEstoquePrevisto
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DsPedidos: TDataSource
    DataSet = QryPedidos
    Left = 584
    Top = 400
  end
  object DsEstoquePrevisto: TDataSource
    AutoEdit = False
    DataSet = QryEstoquePrevisto
    Left = 112
    Top = 32
  end
  object QryEstoquePrevisto: TFDQuery
    Active = True
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT * '
      'FROM LOG.EstoquePrevisto'
      'where CodGrupoSub =:CodGrupoSub'
      'order by CODGRUPOSUB, Data')
    Left = 208
    Top = 24
    ParamData = <
      item
        Name = 'CODGRUPOSUB'
        DataType = ftWideString
        FDDataType = dtWideString
        ParamType = ptInput
        Value = '0010004'
      end>
    object QryEstoquePrevistoData: TDateField
      FieldName = 'Data'
      Origin = 'Data'
    end
    object QryEstoquePrevistoCodGrupoSub: TStringField
      FieldName = 'CodGrupoSub'
      Origin = 'CodGrupoSub'
      Visible = False
      FixedChar = True
      Size = 7
    end
    object QryEstoquePrevistoNOMESUBGRUPO: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'NOMESUBGRUPO'
      Origin = 'NOMESUBGRUPO'
      Visible = False
      FixedChar = True
      Size = 30
    end
    object QryEstoquePrevistoEstoqueAtual: TFMTBCDField
      DisplayLabel = 'Estoque Atual'
      DisplayWidth = 10
      FieldName = 'EstoqueAtual'
      Origin = 'EstoqueAtual'
      DisplayFormat = '#0'
      Precision = 38
    end
    object QryEstoquePrevistoCompraPrevista2: TBCDField
      DisplayLabel = 'Compras Previstas na Data'
      DisplayWidth = 14
      FieldName = 'CompraPrevista'
      Origin = 'CompraPrevista'
      Required = True
      Precision = 18
    end
    object QryEstoquePrevistoSomaCompras: TFMTBCDField
      DisplayLabel = 'Soma Compras'
      DisplayWidth = 10
      FieldName = 'SomaCompras'
      Origin = 'SomaCompras'
      Precision = 38
      Size = 4
    end
    object QryEstoquePrevistoQuantPedidos: TIntegerField
      DisplayLabel = 'N'#250'mero de Pedidos'
      FieldName = 'QuantPedidos'
      Origin = 'QuantPedidos'
      Required = True
    end
    object QryEstoquePrevistoPedidosDia: TFMTBCDField
      DisplayLabel = 'Pedidos na Data'
      DisplayWidth = 10
      FieldName = 'PedidosDia'
      Origin = 'PedidosDia'
      Required = True
      Precision = 38
    end
    object QryEstoquePrevistoSomaPedidos: TFMTBCDField
      DisplayLabel = 'Soma Pedidos'
      DisplayWidth = 10
      FieldName = 'SomaPedidos'
      Origin = 'SomaPedidos'
      Required = True
      Precision = 38
    end
    object QryEstoquePrevistoEstoquePrevisto: TFMTBCDField
      DisplayLabel = 'Estoque Previsto'
      DisplayWidth = 10
      FieldName = 'EstoquePrevisto'
      Origin = 'EstoquePrevisto'
      ReadOnly = True
      DisplayFormat = '#0'
      Precision = 38
      Size = 4
    end
  end
  object QryComprasPrevistas: TFDQuery
    Active = True
    BeforePost = QryComprasPrevistasBeforePost
    AfterPost = QryComprasPrevistasAfterPost
    AfterDelete = QryComprasPrevistasAfterDelete
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT * '
      'FROM log.ComprasPrevistas'
      'where'
      'CodGrupoSub=:CodGrupoSub'
      'order by Data')
    Left = 616
    Top = 96
    ParamData = <
      item
        Name = 'CODGRUPOSUB'
        DataType = ftWideString
        FDDataType = dtWideString
        ParamType = ptInput
        Value = '0010004'
      end>
    object DateField1: TDateField
      FieldName = 'Data'
      Origin = 'Data'
    end
    object QryComprasPrevistasCodGrupoSub: TStringField
      FieldName = 'CodGrupoSub'
      Origin = 'CodGrupoSub'
      Required = True
      Visible = False
      FixedChar = True
      Size = 7
    end
    object QryComprasPrevistasCompraPrevista: TBCDField
      DisplayLabel = 'Compras Previstas'
      DisplayWidth = 14
      FieldName = 'CompraPrevista'
      Origin = 'CompraPrevista'
      Precision = 18
    end
  end
  object DsComprasPrevistas: TDataSource
    DataSet = QryComprasPrevistas
    Left = 512
    Top = 96
  end
  object QryPedidos: TFDQuery
    Active = True
    OnCalcFields = QryPedidosCalcFields
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      
        'select CodGrupoSub, dbo.SituacaoPedTexto(SITUACAO) as Situacao, ' +
        'NOMESUBGRUPO, CodPedido, NOMECLIENTE, CODTRANSPORTE, NOMETRANSPO' +
        'RTE, '
      
        #9'   CODPRODUTO, NOMEPRODUTO, Litros, Peso, DataProgramada, DataP' +
        'edido,'
      
        #9'   SUM(Litros) over (partition by CodGrupoSub order by CodGrupo' +
        'Sub, DataProgramada, Litros desc, NomeCliente ) as SomaPedidos'
      'from log.PedidosPorGrupo'
      'where CodGrupoSub = :CodGrupoSub'
      'order by CodGrupoSub, DataProgramada, litros desc, NomeCliente')
    Left = 688
    Top = 400
    ParamData = <
      item
        Name = 'CODGRUPOSUB'
        DataType = ftString
        FDDataType = dtAnsiString
        ParamType = ptInput
        Size = 7
        Value = '0010004'
      end>
    object QryPedidosCheck: TBooleanField
      DisplayLabel = '   X'
      FieldKind = fkCalculated
      FieldName = 'Check'
      OnChange = QryPedidosCheckChange
      Calculated = True
    end
    object QryPedidosCodGrupoSub: TStringField
      FieldName = 'CodGrupoSub'
      Origin = 'CodGrupoSub'
      ReadOnly = True
      Required = True
      Visible = False
      FixedChar = True
      Size = 7
    end
    object QryPedidosNOMESUBGRUPO: TStringField
      FieldName = 'NOMESUBGRUPO'
      Origin = 'NOMESUBGRUPO'
      ReadOnly = True
      Visible = False
      FixedChar = True
      Size = 30
    end
    object QryPedidosCodPedido: TStringField
      DisplayLabel = 'Pedido'
      FieldName = 'CodPedido'
      Origin = 'CodPedido'
      ReadOnly = True
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryPedidosSituacao: TStringField
      DisplayWidth = 16
      FieldName = 'Situacao'
      Origin = 'Situacao'
      ReadOnly = True
      Size = 100
    end
    object QryPedidosNOMECLIENTE: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 25
      FieldName = 'NOMECLIENTE'
      Origin = 'NOMECLIENTE'
      ReadOnly = True
      Size = 80
    end
    object QryPedidosCODTRANSPORTE: TStringField
      FieldName = 'CODTRANSPORTE'
      Origin = 'CODTRANSPORTE'
      ReadOnly = True
      Required = True
      Visible = False
      FixedChar = True
      Size = 6
    end
    object QryPedidosNOMETRANSPORTE: TStringField
      DisplayLabel = 'Transportadora'
      DisplayWidth = 25
      FieldName = 'NOMETRANSPORTE'
      Origin = 'NOMETRANSPORTE'
      ReadOnly = True
      Size = 39
    end
    object QryPedidosCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Origin = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryPedidosNOMEPRODUTO: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 25
      FieldName = 'NOMEPRODUTO'
      Origin = 'NOMEPRODUTO'
      ReadOnly = True
      Size = 80
    end
    object QryPedidosLitros: TFMTBCDField
      DisplayLabel = 'Litros Pedido'
      DisplayWidth = 10
      FieldName = 'Litros'
      Origin = 'Litros'
      ReadOnly = True
      Precision = 37
    end
    object QryPedidosPeso: TFMTBCDField
      DisplayWidth = 12
      FieldName = 'Peso'
      Origin = 'Peso'
      ReadOnly = True
      Visible = False
      Precision = 38
      Size = 6
    end
    object QryPedidosDataProgramada: TDateField
      DisplayLabel = 'Data Programada'
      FieldName = 'DataProgramada'
      Origin = 'DataProgramada'
      ReadOnly = True
    end
    object QryPedidosDataPedido: TDateField
      DisplayLabel = 'Data Pedido'
      FieldName = 'DataPedido'
      Origin = 'DataPedido'
      ReadOnly = True
    end
    object QryPedidosSomaPedidos: TFMTBCDField
      DisplayLabel = 'Soma Pedidos'
      DisplayWidth = 10
      FieldName = 'SomaPedidos'
      Origin = 'SomaPedidos'
      ReadOnly = True
      Precision = 38
    end
  end
  object DsPedidosProgramados: TDataSource
    DataSet = QryPedidosProgramados
    Left = 584
    Top = 288
  end
  object QryPedidosProgramados: TFDQuery
    OnCalcFields = QryPedidosCalcFields
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from log.ProgramacaoPedido'
      'where CodProduto in '
      '  (select CodProduto from produto '
      '  where codgruposub =:codgruposub)')
    Left = 688
    Top = 288
    ParamData = <
      item
        Name = 'CODGRUPOSUB'
        DataType = ftWideString
        FDDataType = dtWideString
        ParamType = ptInput
        Size = 7
        Value = '0010004'
      end>
    object QryPedidosProgramadosCodPedido: TStringField
      FieldName = 'CodPedido'
      Origin = 'CodPedido'
      FixedChar = True
      Size = 6
    end
    object QryPedidosProgramadosCodProduto: TStringField
      FieldName = 'CodProduto'
      Origin = 'CodProduto'
      FixedChar = True
      Size = 6
    end
    object QryPedidosProgramadosQuantidade: TBCDField
      FieldName = 'Quantidade'
      Origin = 'Quantidade'
      Precision = 18
    end
    object QryPedidosProgramadosDataProgramada: TDateField
      FieldName = 'DataProgramada'
      Origin = 'DataProgramada'
    end
    object QryPedidosProgramadosQuantidadeProgramada: TBCDField
      FieldName = 'QuantidadeProgramada'
      Origin = 'QuantidadeProgramada'
      Precision = 18
    end
    object QryPedidosProgramadosTranspProgramada: TStringField
      FieldName = 'TranspProgramada'
      Origin = 'TranspProgramada'
      FixedChar = True
      Size = 6
    end
    object QryPedidosProgramadosOrdem: TIntegerField
      FieldName = 'Ordem'
      Origin = 'Ordem'
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.xls'
    Title = 'Definir o Caminho e o Nome do Arquivo para Exporta'#231#227'o'
    Left = 59
    Top = 152
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 128
    Top = 8
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
    end
  end
  object Timer1: TTimer
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 289
    Top = 114
  end
end
