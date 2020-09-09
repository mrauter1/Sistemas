object FormCiclosVenda: TFormCiclosVenda
  Left = 0
  Top = 0
  Align = alClient
  Caption = 'Ciclos de Venda por Produto'
  ClientHeight = 544
  ClientWidth = 920
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
    Top = 502
    Width = 920
    Height = 42
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 0
    DesignSize = (
      920
      42)
    object BtnAtualiza: TButton
      Left = 272
      Top = 9
      Width = 369
      Height = 25
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Atualiza'
      TabOrder = 0
      OnClick = BtnAtualizaClick
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
      OnClick = BtnOpcoesClick
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 920
    Height = 502
    ActivePage = TabIgnorados
    Align = alClient
    TabOrder = 1
    object TabParaComprar: TTabSheet
      Caption = 'Clientes que est'#227'o para Comprar'
      object cxGridParaComprar: TcxGrid
        Left = 0
        Top = 0
        Width = 912
        Height = 474
        Align = alClient
        TabOrder = 0
        object cxGridParaComprarDBTableView: TcxGridDBTableView
          PopupMenu = PopupMenuOpcoes
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = DsCiclos
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
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
          object cxGridParaComprarDBTableViewCodCliente: TcxGridDBColumn
            DataBinding.FieldName = 'CodCliente'
          end
          object cxGridParaComprarDBTableViewNOMECLIENTE: TcxGridDBColumn
            DataBinding.FieldName = 'NOMECLIENTE'
          end
          object cxGridParaComprarDBTableViewCodProduto: TcxGridDBColumn
            DataBinding.FieldName = 'CodProduto'
          end
          object cxGridParaComprarDBTableViewProduto: TcxGridDBColumn
            DataBinding.FieldName = 'Produto'
            Width = 168
          end
          object cxGridParaComprarDBTableViewCODVENDEDOR2: TcxGridDBColumn
            DataBinding.FieldName = 'CODVENDEDOR2'
            Visible = False
          end
          object cxGridParaComprarDBTableViewVendedor: TcxGridDBColumn
            DataBinding.FieldName = 'Vendedor'
            Width = 91
          end
          object cxGridParaComprarDBTableViewTicketMedio: TcxGridDBColumn
            DataBinding.FieldName = 'TicketMedio'
            Width = 84
          end
          object cxGridParaComprarDBTableViewDiasUteisEntreCompras: TcxGridDBColumn
            DataBinding.FieldName = 'DiasUteisEntreCompras'
            Width = 62
          end
          object cxGridParaComprarDBTableViewCiclosSemCompra: TcxGridDBColumn
            DataBinding.FieldName = 'CiclosSemCompra'
            Width = 52
          end
          object cxGridParaComprarDBTableViewDiasUteisSemComprar: TcxGridDBColumn
            DataBinding.FieldName = 'DiasUteisSemComprar'
            Width = 57
          end
          object cxGridParaComprarDBTableViewDataUltimaCompra: TcxGridDBColumn
            DataBinding.FieldName = 'DataUltimaCompra'
          end
          object cxGridParaComprarDBTableViewCidade: TcxGridDBColumn
            DataBinding.FieldName = 'Cidade'
          end
          object cxGridParaComprarDBTableViewEstado: TcxGridDBColumn
            DataBinding.FieldName = 'Estado'
          end
        end
        object cxGridParaComprarDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DetailKeyFieldNames = 'CODPRODUTO'
          DataController.KeyFieldNames = 'CODPRODUTO'
          DataController.MasterKeyFieldNames = 'CODPRODUTO'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsSelection.CellSelect = False
          OptionsView.GroupByBox = False
          Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
        end
        object cxGridParaComprarLevel: TcxGridLevel
          GridView = cxGridParaComprarDBTableView
        end
      end
    end
    object TabRecuperar: TTabSheet
      Caption = 'Clientes para Recuperar'
      ImageIndex = 1
      object cxGridParaRecuperar: TcxGrid
        Left = 0
        Top = 0
        Width = 912
        Height = 474
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView2: TcxGridDBTableView
          PopupMenu = PopupMenuOpcoes
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = DsRecuperar
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
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
          object cxGridDBColumn1: TcxGridDBColumn
            DataBinding.FieldName = 'CodCliente'
          end
          object cxGridDBColumn2: TcxGridDBColumn
            DataBinding.FieldName = 'NOMECLIENTE'
          end
          object cxGridDBColumn6: TcxGridDBColumn
            DataBinding.FieldName = 'CodProduto'
          end
          object cxGridDBColumn3: TcxGridDBColumn
            DataBinding.FieldName = 'Produto'
            Width = 173
          end
          object cxGridDBColumn4: TcxGridDBColumn
            DataBinding.FieldName = 'CODVENDEDOR2'
            Visible = False
          end
          object cxGridDBColumn5: TcxGridDBColumn
            DataBinding.FieldName = 'Vendedor'
            Width = 96
          end
          object cxGridDBColumn8: TcxGridDBColumn
            DataBinding.FieldName = 'TicketMedio'
          end
          object cxGridDBColumn9: TcxGridDBColumn
            DataBinding.FieldName = 'DiasUteisEntreCompras'
          end
          object cxGridDBColumn10: TcxGridDBColumn
            DataBinding.FieldName = 'CiclosSemCompra'
            Width = 45
          end
          object cxGridDBColumn11: TcxGridDBColumn
            DataBinding.FieldName = 'DiasUteisSemComprar'
          end
          object cxGridDBColumn12: TcxGridDBColumn
            DataBinding.FieldName = 'DataUltimaCompra'
          end
          object cxGridDBColumn13: TcxGridDBColumn
            DataBinding.FieldName = 'Cidade'
          end
          object cxGridDBColumn14: TcxGridDBColumn
            DataBinding.FieldName = 'Estado'
          end
        end
        object cxGridDBTableView3: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DetailKeyFieldNames = 'CODPRODUTO'
          DataController.KeyFieldNames = 'CODPRODUTO'
          DataController.MasterKeyFieldNames = 'CODPRODUTO'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsSelection.CellSelect = False
          OptionsView.GroupByBox = False
          Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView2
        end
      end
    end
    object TabIgnorados: TTabSheet
      Caption = 'Clientes Ignorados'
      ImageIndex = 2
      object cxGridClientesIgnorados: TcxGrid
        Left = 0
        Top = 0
        Width = 912
        Height = 474
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView1: TcxGridDBTableView
          PopupMenu = PopupMenuIgnorados
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = DsIgnorados
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
          object cxGridDBTableView1DataRelembrar: TcxGridDBColumn
            DataBinding.FieldName = 'DataRelembrar'
          end
          object cxGridDBTableView1Motivo: TcxGridDBColumn
            DataBinding.FieldName = 'Motivo'
            Width = 114
          end
          object cxGridDBTableView1Obs: TcxGridDBColumn
            DataBinding.FieldName = 'Obs'
            Width = 119
          end
          object cxGridDBTableView1CodCliente: TcxGridDBColumn
            DataBinding.FieldName = 'CodCliente'
            Width = 48
          end
          object cxGridDBTableView1NOMECLIENTE: TcxGridDBColumn
            DataBinding.FieldName = 'NOMECLIENTE'
            Width = 144
          end
          object cxGridDBTableView1CodProduto: TcxGridDBColumn
            DataBinding.FieldName = 'CodProduto'
          end
          object cxGridDBTableView1Produto: TcxGridDBColumn
            DataBinding.FieldName = 'Produto'
            Width = 132
          end
          object cxGridDBTableView1CODVENDEDOR2: TcxGridDBColumn
            DataBinding.FieldName = 'CODVENDEDOR2'
            Visible = False
          end
          object cxGridDBTableView1Vendedor: TcxGridDBColumn
            DataBinding.FieldName = 'Vendedor'
            Width = 100
          end
          object cxGridDBTableView1TicketMedio: TcxGridDBColumn
            DataBinding.FieldName = 'TicketMedio'
            Width = 89
          end
          object cxGridDBTableView1DataUltimaCompra: TcxGridDBColumn
            DataBinding.FieldName = 'DataUltimaCompra'
          end
          object cxGridDBTableView1Cidade: TcxGridDBColumn
            DataBinding.FieldName = 'Cidade'
            Width = 88
          end
          object cxGridDBTableView1Estado: TcxGridDBColumn
            DataBinding.FieldName = 'Estado'
            Width = 39
          end
          object cxGridDBTableView1DiasUteisEntreCompras: TcxGridDBColumn
            DataBinding.FieldName = 'DiasUteisEntreCompras'
          end
          object cxGridDBTableView1DiasUteisSemComprar: TcxGridDBColumn
            DataBinding.FieldName = 'DiasUteisSemComprar'
          end
          object cxGridDBTableView1CiclosSemCompra: TcxGridDBColumn
            DataBinding.FieldName = 'CiclosSemCompra'
            Width = 52
          end
        end
        object cxGridDBTableView4: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DetailKeyFieldNames = 'CODPRODUTO'
          DataController.KeyFieldNames = 'CODPRODUTO'
          DataController.MasterKeyFieldNames = 'CODPRODUTO'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsSelection.CellSelect = False
          OptionsView.GroupByBox = False
          Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Todos os Clientes'
      ImageIndex = 3
      object cxGridTodosClientes: TcxGrid
        Left = 0
        Top = 0
        Width = 912
        Height = 474
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView5: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = DsTodosClientes
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
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
          object cxGridDBTableView5CodCliente: TcxGridDBColumn
            DataBinding.FieldName = 'CodCliente'
            Width = 47
          end
          object cxGridDBTableView5NOMECLIENTE: TcxGridDBColumn
            DataBinding.FieldName = 'NOMECLIENTE'
          end
          object cxGridDBTableView5Produto: TcxGridDBColumn
            DataBinding.FieldName = 'Produto'
            Width = 177
          end
          object cxGridDBTableView5CODVENDEDOR2: TcxGridDBColumn
            DataBinding.FieldName = 'CODVENDEDOR2'
            Visible = False
          end
          object cxGridDBTableView5Vendedor: TcxGridDBColumn
            DataBinding.FieldName = 'Vendedor'
            Width = 89
          end
          object cxGridDBTableView5CodProduto: TcxGridDBColumn
            DataBinding.FieldName = 'CodProduto'
          end
          object cxGridDBTableView5NroCompras: TcxGridDBColumn
            DataBinding.FieldName = 'NroCompras'
            Width = 51
          end
          object cxGridDBTableView5TicketMedio: TcxGridDBColumn
            DataBinding.FieldName = 'TicketMedio'
          end
          object cxGridDBTableView5DataUltimaCompra: TcxGridDBColumn
            DataBinding.FieldName = 'DataUltimaCompra'
          end
          object cxGridDBTableView5Cidade: TcxGridDBColumn
            DataBinding.FieldName = 'Cidade'
          end
          object cxGridDBTableView5Estado: TcxGridDBColumn
            DataBinding.FieldName = 'Estado'
          end
          object cxGridDBTableView5DiasUteisEntreCompras: TcxGridDBColumn
            DataBinding.FieldName = 'DiasUteisEntreCompras'
          end
          object cxGridDBTableView5DiasUteisSemComprar: TcxGridDBColumn
            DataBinding.FieldName = 'DiasUteisSemComprar'
          end
          object cxGridDBTableView5CiclosSemCompra: TcxGridDBColumn
            DataBinding.FieldName = 'CiclosSemCompra'
            Width = 66
          end
        end
        object cxGridDBTableView6: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DetailKeyFieldNames = 'CODPRODUTO'
          DataController.KeyFieldNames = 'CODPRODUTO'
          DataController.MasterKeyFieldNames = 'CODPRODUTO'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsSelection.CellSelect = False
          OptionsView.GroupByBox = False
          Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
        end
        object cxGridLevel3: TcxGridLevel
          GridView = cxGridDBTableView5
        end
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.xls'
    Title = 'Definir o Caminho e o Nome do Arquivo para Exporta'#231#227'o'
    Left = 51
    Top = 184
  end
  object PopupMenuOpcoes: TPopupMenu
    Left = 528
    Top = 136
    object Relembrarem3dias1: TMenuItem
      Caption = 'Ignorar por 3 dias'
      OnClick = Relembrarem3dias1Click
    end
    object Relembrarem10dias1: TMenuItem
      Caption = 'Ignorar por 10 dias'
      OnClick = Relembrarem10dias1Click
    end
    object Relembrarem30dias1: TMenuItem
      Caption = 'Ignorar por 30 dias'
      OnClick = Relembrarem30dias1Click
    end
  end
  object QryCiclos: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select cc.*, C.Cidade, C.Estado'
      'from CicloCompras cc'
      'inner join Cliente C on C.CodCliente = cc.CodCliente'
      'where cc.CiclosSemCompra between 0.9 and 3'
      'and NroCompras > 4'
      
        'and getdate() >= IsNull((select DataRelembrar from LembreteCiclo' +
        's lc where lc.codCliente = cc.CodCliente and lc.CodProduto = cc.' +
        'CodProduto), getdate())'
      'order by CiclosSemCompra, cc.CodCliente, CodProduto')
    Left = 160
    Top = 56
    object QryCiclosCodCliente: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'CodCliente'
      Origin = 'CodCliente'
      FixedChar = True
      Size = 6
    end
    object QryCiclosNOMECLIENTE: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 28
      FieldName = 'NOMECLIENTE'
      Origin = 'NOMECLIENTE'
      Size = 40
    end
    object QryCiclosProduto: TStringField
      DisplayWidth = 30
      FieldName = 'Produto'
      Origin = 'Produto'
      Size = 80
    end
    object QryCiclosCODVENDEDOR2: TStringField
      FieldName = 'CODVENDEDOR2'
      Origin = 'CODVENDEDOR2'
      Visible = False
      FixedChar = True
      Size = 6
    end
    object QryCiclosVendedor: TStringField
      DisplayWidth = 25
      FieldName = 'Vendedor'
      Origin = 'Vendedor'
      ReadOnly = True
      FixedChar = True
      Size = 30
    end
    object QryCiclosCodProduto: TStringField
      DisplayLabel = 'Cod. Produto'
      DisplayWidth = 7
      FieldName = 'CodProduto'
      Origin = 'CodProduto'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryCiclosNroCompras: TIntegerField
      FieldName = 'NroCompras'
      Origin = 'DiasUteisEntreCompras'
    end
    object QryCiclosTicketMedio: TFMTBCDField
      DisplayLabel = 'Ticket M'#233'dio'
      DisplayWidth = 15
      FieldName = 'TicketMedio'
      Origin = 'TicketMedio'
      currency = True
      Precision = 38
      Size = 6
    end
    object QryCiclosDataUltimaCompra: TDateField
      DisplayLabel = 'Data Ultima Compra'
      FieldName = 'DataUltimaCompra'
      Origin = 'DataUltimaCompra'
    end
    object QryCiclosCidade: TStringField
      DisplayWidth = 18
      FieldName = 'Cidade'
      Origin = 'Cidade'
      FixedChar = True
      Size = 35
    end
    object QryCiclosEstado: TStringField
      DisplayWidth = 6
      FieldName = 'Estado'
      Origin = 'Estado'
      FixedChar = True
      Size = 2
    end
    object QryCiclosDiasUteisEntreCompras: TFloatField
      DisplayLabel = 'Dias '#218'teis Entre Compras'
      FieldName = 'DiasUteisEntreCompras'
    end
    object QryCiclosDiasUteisSemComprar: TIntegerField
      DisplayLabel = 'Dias '#218'teis Sem Comprar'
      FieldName = 'DiasUteisSemComprar'
    end
    object QryCiclosCiclosSemCompra: TBCDField
      DisplayLabel = 'Ciclos Sem Compra'
      FieldName = 'CiclosSemCompra'
      ReadOnly = True
      Precision = 18
      Size = 1
    end
  end
  object DsCiclos: TDataSource
    AutoEdit = False
    DataSet = QryCiclos
    Left = 296
    Top = 56
  end
  object QryRecuperar: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select cc.*, C.Cidade, C.Estado'
      'from CicloCompras cc'
      'inner join Cliente C on C.CodCliente = cc.CodCliente'
      'where cc.CiclosSemCompra > 3'
      'and NroCompras > 2'
      
        'and getdate() >= IsNull((select DataRelembrar from LembreteCiclo' +
        's lc where lc.codCliente = cc.CodCliente and lc.CodProduto = cc.' +
        'CodProduto), getdate())'
      
        'order by cc.TicketMedio desc, CiclosSemCompra, cc.CodCliente, Co' +
        'dProduto')
    Left = 160
    Top = 168
    object QryRecuperarCodCliente: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'CodCliente'
      Origin = 'CodCliente'
      FixedChar = True
      Size = 6
    end
    object StringField2: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 28
      FieldName = 'NOMECLIENTE'
      Origin = 'NOMECLIENTE'
      Size = 40
    end
    object QryRecuperarProduto: TStringField
      DisplayWidth = 30
      FieldName = 'Produto'
      Origin = 'Produto'
      Size = 80
    end
    object StringField4: TStringField
      FieldName = 'CODVENDEDOR2'
      Origin = 'CODVENDEDOR2'
      Visible = False
      FixedChar = True
      Size = 6
    end
    object StringField5: TStringField
      DisplayWidth = 25
      FieldName = 'Vendedor'
      Origin = 'Vendedor'
      ReadOnly = True
      FixedChar = True
      Size = 30
    end
    object QryRecuperarCodProduto: TStringField
      DisplayLabel = 'Cod. Produto'
      DisplayWidth = 7
      FieldName = 'CodProduto'
      Origin = 'CodProduto'
      Required = True
      FixedChar = True
      Size = 6
    end
    object IntegerField1: TIntegerField
      FieldName = 'NroCompras'
      Origin = 'DiasUteisEntreCompras'
    end
    object FMTBCDField1: TFMTBCDField
      DisplayLabel = 'Ticket M'#233'dio'
      DisplayWidth = 15
      FieldName = 'TicketMedio'
      Origin = 'TicketMedio'
      currency = True
      Precision = 38
      Size = 6
    end
    object DateField1: TDateField
      DisplayLabel = 'Data Ultima Compra'
      FieldName = 'DataUltimaCompra'
      Origin = 'DataUltimaCompra'
    end
    object StringField7: TStringField
      DisplayWidth = 18
      FieldName = 'Cidade'
      Origin = 'Cidade'
      FixedChar = True
      Size = 35
    end
    object StringField8: TStringField
      DisplayWidth = 6
      FieldName = 'Estado'
      Origin = 'Estado'
      FixedChar = True
      Size = 2
    end
    object FloatField1: TFloatField
      DisplayLabel = 'Dias '#218'teis Entre Compras'
      FieldName = 'DiasUteisEntreCompras'
    end
    object IntegerField2: TIntegerField
      DisplayLabel = 'Dias '#218'teis Sem Comprar'
      FieldName = 'DiasUteisSemComprar'
    end
    object BCDField1: TBCDField
      DisplayLabel = 'Ciclos Sem Compra'
      FieldName = 'CiclosSemCompra'
      ReadOnly = True
      Precision = 18
      Size = 1
    end
  end
  object DsRecuperar: TDataSource
    AutoEdit = False
    DataSet = QryRecuperar
    Left = 296
    Top = 168
  end
  object QryIgnorados: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      
        'select cc.*, C.Cidade, C.Estado, lc.DataRelembrar, mi.Motivo, lc' +
        '.Obs'
      'from CicloCompras cc'
      'inner join Cliente C on C.CodCliente = cc.CodCliente'
      
        'inner join LembreteCiclos lc on lc.CodCliente = cc.CODCLIENTE an' +
        'd lc.CodProduto = cc.CODPRODUTO'
      'left join MotivoIgnorarCiclo mi on mi.Cod = lc.CodMotivo'
      
        'order by DataRelembrar desc, cc.TicketMedio desc, CiclosSemCompr' +
        'a, cc.CodCliente, CodProduto')
    Left = 160
    Top = 256
    object QryIgnoradosDataRelembrar: TDateField
      DisplayLabel = 'Data Lembrete'
      FieldName = 'DataRelembrar'
      Origin = 'DataRelembrar'
    end
    object QryIgnoradosMotivo: TStringField
      FieldName = 'Motivo'
      Origin = 'Motivo'
      Size = 255
    end
    object QryIgnoradosCodCliente: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'CodCliente'
      Origin = 'CodCliente'
      FixedChar = True
      Size = 6
    end
    object QryIgnoradosNOMECLIENTE: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 28
      FieldName = 'NOMECLIENTE'
      Origin = 'NOMECLIENTE'
      Size = 40
    end
    object QryIgnoradosProduto: TStringField
      DisplayWidth = 30
      FieldName = 'Produto'
      Origin = 'Produto'
      Size = 80
    end
    object QryIgnoradosCODVENDEDOR2: TStringField
      FieldName = 'CODVENDEDOR2'
      Origin = 'CODVENDEDOR2'
      Visible = False
      FixedChar = True
      Size = 6
    end
    object QryIgnoradosVendedor: TStringField
      DisplayWidth = 25
      FieldName = 'Vendedor'
      Origin = 'Vendedor'
      ReadOnly = True
      FixedChar = True
      Size = 30
    end
    object QryIgnoradosCodProduto: TStringField
      DisplayLabel = 'Cod. Produto'
      DisplayWidth = 7
      FieldName = 'CodProduto'
      Origin = 'CodProduto'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryIgnoradosNroCompras: TIntegerField
      FieldName = 'NroCompras'
      Origin = 'DiasUteisEntreCompras'
    end
    object QryIgnoradosTicketMedio: TFMTBCDField
      DisplayLabel = 'Ticket M'#233'dio'
      DisplayWidth = 15
      FieldName = 'TicketMedio'
      Origin = 'TicketMedio'
      currency = True
      Precision = 38
      Size = 6
    end
    object QryIgnoradosDataUltimaCompra: TDateField
      DisplayLabel = 'Data Ultima Compra'
      FieldName = 'DataUltimaCompra'
      Origin = 'DataUltimaCompra'
    end
    object QryIgnoradosCidade: TStringField
      DisplayWidth = 18
      FieldName = 'Cidade'
      Origin = 'Cidade'
      FixedChar = True
      Size = 35
    end
    object QryIgnoradosEstado: TStringField
      DisplayWidth = 6
      FieldName = 'Estado'
      Origin = 'Estado'
      FixedChar = True
      Size = 2
    end
    object QryIgnoradosDiasUteisEntreCompras: TFloatField
      DisplayLabel = 'Dias '#218'teis Entre Compras'
      FieldName = 'DiasUteisEntreCompras'
    end
    object QryIgnoradosDiasUteisSemComprar: TIntegerField
      DisplayLabel = 'Dias '#218'teis Sem Comprar'
      FieldName = 'DiasUteisSemComprar'
    end
    object QryIgnoradosCiclosSemCompra: TBCDField
      DisplayLabel = 'Ciclos Sem Compra'
      FieldName = 'CiclosSemCompra'
      ReadOnly = True
      Precision = 18
      Size = 1
    end
    object QryIgnoradosObs: TMemoField
      DisplayWidth = 15
      FieldName = 'Obs'
      Origin = 'Obs'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object DsIgnorados: TDataSource
    AutoEdit = False
    DataSet = QryIgnorados
    Left = 296
    Top = 256
  end
  object PopupMenuIgnorados: TPopupMenu
    Left = 528
    Top = 256
    object Deixardeignorar1: TMenuItem
      Caption = 'Deixar de ignorar'
      OnClick = Deixardeignorar1Click
    end
  end
  object QryTodosClientes: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select cc.*, C.Cidade, C.Estado'
      'from CicloCompras cc'
      'inner join Cliente C on C.CodCliente = cc.CodCliente'
      'order by Cidade, DataUltimaCompra, cc.CodCliente, CodProduto')
    Left = 160
    Top = 360
    object QryTodosClientesCodCliente: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'CodCliente'
      Origin = 'CodCliente'
      FixedChar = True
      Size = 6
    end
    object QryTodosClientesNOMECLIENTE: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 28
      FieldName = 'NOMECLIENTE'
      Origin = 'NOMECLIENTE'
      Size = 40
    end
    object QryTodosClientesProduto: TStringField
      DisplayWidth = 30
      FieldName = 'Produto'
      Origin = 'Produto'
      Size = 80
    end
    object QryTodosClientesCODVENDEDOR2: TStringField
      FieldName = 'CODVENDEDOR2'
      Origin = 'CODVENDEDOR2'
      Visible = False
      FixedChar = True
      Size = 6
    end
    object QryTodosClientesVendedor: TStringField
      DisplayWidth = 25
      FieldName = 'Vendedor'
      Origin = 'Vendedor'
      ReadOnly = True
      FixedChar = True
      Size = 30
    end
    object QryTodosClientesCodProduto: TStringField
      DisplayLabel = 'Cod. Produto'
      DisplayWidth = 7
      FieldName = 'CodProduto'
      Origin = 'CodProduto'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryTodosClientesNroCompras: TIntegerField
      DisplayLabel = 'Nro. Compras'
      FieldName = 'NroCompras'
      Origin = 'DiasUteisEntreCompras'
    end
    object QryTodosClientesTicketMedio: TFMTBCDField
      DisplayLabel = 'Ticket M'#233'dio'
      DisplayWidth = 15
      FieldName = 'TicketMedio'
      Origin = 'TicketMedio'
      currency = True
      Precision = 38
      Size = 6
    end
    object QryTodosClientesDataUltimaCompra: TDateField
      DisplayLabel = 'Data Ultima Compra'
      FieldName = 'DataUltimaCompra'
      Origin = 'DataUltimaCompra'
    end
    object QryTodosClientesCidade: TStringField
      DisplayWidth = 18
      FieldName = 'Cidade'
      Origin = 'Cidade'
      FixedChar = True
      Size = 35
    end
    object QryTodosClientesEstado: TStringField
      DisplayWidth = 6
      FieldName = 'Estado'
      Origin = 'Estado'
      FixedChar = True
      Size = 2
    end
    object QryTodosClientesDiasUteisEntreCompras: TFloatField
      DisplayLabel = 'Dias '#218'teis Entre Compras'
      FieldName = 'DiasUteisEntreCompras'
    end
    object QryTodosClientesDiasUteisSemComprar: TIntegerField
      DisplayLabel = 'Dias '#218'teis Sem Comprar'
      FieldName = 'DiasUteisSemComprar'
    end
    object QryTodosClientesCiclosSemCompra: TBCDField
      DisplayLabel = 'Ciclos Sem Compra'
      FieldName = 'CiclosSemCompra'
      ReadOnly = True
      Precision = 18
      Size = 1
    end
  end
  object DsTodosClientes: TDataSource
    AutoEdit = False
    DataSet = QryTodosClientes
    Left = 296
    Top = 360
  end
end
