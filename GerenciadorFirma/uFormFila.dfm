object FormFilaProducao: TFormFilaProducao
  Left = 0
  Top = 0
  Caption = 'Fila'
  ClientHeight = 542
  ClientWidth = 965
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
    Width = 965
    Height = 500
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 679
    ExplicitHeight = 326
    object cxGridDBTableView: TcxGridDBTableView
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
      object cxGridDBTableViewCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
        Width = 74
      end
      object cxGridDBTableViewNOMEPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'NOMEPRODUTO'
        Width = 205
      end
      object cxGridDBTableViewQUANTIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTIDADE'
        Width = 73
      end
      object cxGridDBTableViewFALTA: TcxGridDBColumn
        DataBinding.FieldName = 'FALTA'
        Width = 66
      end
      object cxGridDBTableViewNUMPEDIDOS: TcxGridDBColumn
        DataBinding.FieldName = 'NUMPEDIDOS'
        Width = 66
      end
      object cxGridDBTableViewPRODUCAOSUGERIDA: TcxGridDBColumn
        DataBinding.FieldName = 'PRODUCAOSUGERIDA'
        Width = 71
      end
      object cxGridDBTableViewPROBFALTAHOJE: TcxGridDBColumn
        DataBinding.FieldName = 'PROBFALTAHOJE'
        OnGetDataText = cxGridDBTableViewPROBFALTAHOJEGetDataText
        Width = 76
      end
      object cxGridDBTableViewESTOQUEATUAL: TcxGridDBColumn
        DataBinding.FieldName = 'ESTOQUEATUAL'
      end
      object cxGridDBTableViewESTOQMAX: TcxGridDBColumn
        DataBinding.FieldName = 'ESTOQMAX'
      end
      object cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'ESPACOESTOQUE'
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
      object cxGridDBTableView1QUANTIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTIDADE'
        Width = 60
      end
      object cxGridDBTableView1DIASPARAENTREGA: TcxGridDBColumn
        DataBinding.FieldName = 'DIASPARAENTREGA'
        Width = 50
      end
      object cxGridDBTableView1SIT: TcxGridDBColumn
        DataBinding.FieldName = 'SIT'
        Width = 40
      end
      object cxGridDBTableView1NOMECLIENTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMECLIENTE'
        Width = 200
      end
      object cxGridDBTableView1NOMETRANSPORTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMETRANSPORTE'
        Width = 200
      end
      object cxGridDBTableView1QUANTPENDENTE: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTPENDENTE'
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
    Width = 965
    Height = 42
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitTop = 326
    ExplicitWidth = 679
    DesignSize = (
      965
      42)
    object BtnAtualiza: TButton
      Left = 272
      Top = 9
      Width = 414
      Height = 25
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Atualiza'
      TabOrder = 0
      OnClick = BtnAtualizaClick
      ExplicitWidth = 128
    end
  end
  object DataSourceFila: TDataSource
    AutoEdit = False
    DataSet = DMFilaProducao.CdsFilaProducao
    Left = 320
    Top = 72
  end
  object DataSourcePedidos: TDataSource
    AutoEdit = False
    DataSet = Pedidos.Dados
    Left = 320
    Top = 160
  end
end
