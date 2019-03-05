object FormFilaProducao: TFormFilaProducao
  Left = 0
  Top = 0
  Caption = 'Fila'
  ClientHeight = 542
  ClientWidth = 998
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
    Width = 998
    Height = 500
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 990
    object cxGridDBTableView: TcxGridDBTableView
      PopupMenu = PopupMenuOpcoes
      OnDblClick = cxGridDBTableViewDblClick
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSourceFila
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
      object cxGridDBTableViewRank: TcxGridDBColumn
        DataBinding.FieldName = 'Rank'
        Width = 29
      end
      object cxGridDBTableViewCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
        Width = 48
      end
      object cxGridDBTableViewNOMEPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'APRESENTACAO'
        Width = 193
      end
      object cxGridDBTableViewFALTAHOJE: TcxGridDBColumn
        DataBinding.FieldName = 'FaltaHoje'
        Width = 51
      end
      object cxGridDBTableViewFALTACONFIRMADA: TcxGridDBColumn
        DataBinding.FieldName = 'FaltaConfirmada'
        Width = 61
      end
      object cxGridDBTableViewFaltaTotal: TcxGridDBColumn
        DataBinding.FieldName = 'FaltaTotal'
        Width = 50
      end
      object cxGridDBTableViewPROBFALTAHOJE: TcxGridDBColumn
        DataBinding.FieldName = 'PROBFALTAHOJE'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 65
      end
      object cxGridDBTableViewNUMPEDIDOS: TcxGridDBColumn
        DataBinding.FieldName = 'NUMPEDIDOS'
        Width = 61
      end
      object cxGridDBTableViewDEMANDADIARIA: TcxGridDBColumn
        DataBinding.FieldName = 'DEMANDADIARIA'
        Width = 71
      end
      object cxGridDBTableViewDIASESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'DIASESTOQUE'
        Width = 63
      end
      object cxGridDBTableViewESTOQUEATUAL: TcxGridDBColumn
        DataBinding.FieldName = 'ESTOQUEATUAL'
        Width = 59
      end
      object cxGridDBTableViewPRODUCAOSUGERIDA: TcxGridDBColumn
        DataBinding.FieldName = 'PRODUCAOSUGERIDA'
        Visible = False
        Width = 69
      end
      object cxGridDBTableViewEstoqMaxCalculado: TcxGridDBColumn
        DataBinding.FieldName = 'EstoqMaxCalculado'
        Width = 60
      end
      object cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'ESPACOESTOQUE'
      end
      object cxGridDBTableViewNOMEAPLICACAO: TcxGridDBColumn
        DataBinding.FieldName = 'NOMEAPLICACAO'
        Width = 101
      end
    end
    object cxGridDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSourcePedidos
      DataController.DetailKeyFieldNames = 'CODPRODUTO'
      DataController.KeyFieldNames = 'CODPRODUTO'
      DataController.MasterKeyFieldNames = 'CODPRODUTO'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridDBTableView1CODPEDIDO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPEDIDO'
        Width = 60
      end
      object cxGridDBTableView1SITUACAO: TcxGridDBColumn
        DataBinding.FieldName = 'SITUACAO'
        OnGetDisplayText = cxGridDBTableView1SITUACAOGetDisplayText
        Width = 54
      end
      object cxGridDBTableView1DATAENTREGA: TcxGridDBColumn
        DataBinding.FieldName = 'DATAENTREGA'
      end
      object cxGridDBTableView1DIASPARAENTREGA: TcxGridDBColumn
        DataBinding.FieldName = 'DIASPARAENTREGA'
        Width = 72
      end
      object cxGridDBTableView1NOMETRANSPORTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMETRANSPORTE'
        Width = 190
      end
      object cxGridDBTableView1NOMECLIENTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMECLIENTE'
        Width = 212
      end
      object cxGridDBTableView1QUANTIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTIDADE'
        Width = 67
      end
      object cxGridDBTableView1QUANTPENDENTE: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTPENDENTE'
        Width = 87
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 500
    Width = 998
    Height = 42
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitWidth = 990
    DesignSize = (
      998
      42)
    object BtnAtualiza: TButton
      Left = 272
      Top = 9
      Width = 447
      Height = 25
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Atualiza'
      TabOrder = 0
      OnClick = BtnAtualizaClick
      ExplicitWidth = 439
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
  object DataSourceFila: TDataSource
    AutoEdit = False
    DataSet = DmEstoqProdutos.QryEstoq
    Left = 320
    Top = 72
  end
  object DataSourcePedidos: TDataSource
    AutoEdit = False
    DataSet = DmEstoqProdutos.QryPedPro
    Left = 320
    Top = 160
  end
  object PopupMenuOpcoes: TPopupMenu
    Left = 528
    Top = 104
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
  object SaveDialog: TSaveDialog
    DefaultExt = '.xls'
    Title = 'Definir o Caminho e o Nome do Arquivo para Exporta'#231#227'o'
    Left = 75
    Top = 200
  end
end
