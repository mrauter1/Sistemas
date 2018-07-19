object FormFilaProducao: TFormFilaProducao
  Left = 0
  Top = 0
  Caption = 'Fila'
  ClientHeight = 542
  ClientWidth = 990
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
    Width = 990
    Height = 500
    Align = alClient
    TabOrder = 0
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
        OnGetDisplayText = cxGridDBTableViewPROBFALTAHOJEGetDisplayText
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
    Width = 990
    Height = 42
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 1
    DesignSize = (
      990
      42)
    object BtnAtualiza: TButton
      Left = 272
      Top = 9
      Width = 439
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
end
