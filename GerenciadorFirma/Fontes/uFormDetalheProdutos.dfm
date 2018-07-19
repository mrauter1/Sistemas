object FormDetalheProdutos: TFormDetalheProdutos
  Left = 0
  Top = 0
  Caption = 'Detalhamento da An'#225'lise dos Produtos'
  ClientHeight = 417
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
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridDBTableViewRANK: TcxGridDBColumn
        DataBinding.FieldName = 'RANK'
      end
      object cxGridDBTableViewCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
      end
      object cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn
        DataBinding.FieldName = 'APRESENTACAO'
      end
      object cxGridDBTableViewPROBFALTAHOJE: TcxGridDBColumn
        DataBinding.FieldName = 'PROBFALTAHOJE'
        OnGetDataText = cxColumnProbabilidadeGetDataText
      end
      object cxGridDBTableViewPROBSAI2DIAS: TcxGridDBColumn
        DataBinding.FieldName = 'PROBSAI2DIAS'
        Visible = False
        OnGetDataText = cxColumnProbabilidadeGetDataText
      end
      object cxGridDBTableViewPROBFALTA: TcxGridDBColumn
        DataBinding.FieldName = 'PROBFALTA'
        OnGetDataText = cxColumnProbabilidadeGetDataText
      end
      object cxGridDBTableViewPERCENTDIAS: TcxGridDBColumn
        DataBinding.FieldName = 'PERCENTDIAS'
        OnGetDataText = cxColumnProbabilidadeGetDataText
      end
      object cxGridDBTableViewMEDIASAIDA: TcxGridDBColumn
        DataBinding.FieldName = 'MEDIASAIDA'
      end
      object cxGridDBTableViewSTDDEV: TcxGridDBColumn
        DataBinding.FieldName = 'STDDEV'
        Visible = False
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
      object cxGridDBTableViewPRODUCAOMINIMA: TcxGridDBColumn
        DataBinding.FieldName = 'PRODUCAOMINIMA'
      end
      object cxGridDBTableViewDEMANDAC1: TcxGridDBColumn
        DataBinding.FieldName = 'DEMANDAC1'
      end
      object cxGridDBTableViewDEMANDADIARIA: TcxGridDBColumn
        DataBinding.FieldName = 'DEMANDADIARIA'
      end
      object cxGridDBTableViewDEMANDA: TcxGridDBColumn
        DataBinding.FieldName = 'DEMANDA'
      end
      object cxGridDBTableViewDIASESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'DIASESTOQUE'
      end
      object cxGridDBTableViewROTACAO: TcxGridDBColumn
        DataBinding.FieldName = 'ROTACAO'
      end
      object cxGridDBTableViewUNIDADEESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'UNIDADEESTOQUE'
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    Left = 144
    Top = 56
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
end
