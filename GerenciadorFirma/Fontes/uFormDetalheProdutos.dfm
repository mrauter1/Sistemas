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
      end
      object cxGridDBTableViewPROBSAI2DIAS: TcxGridDBColumn
        DataBinding.FieldName = 'PROBSAI2DIAS'
        Visible = False
      end
      object cxGridDBTableViewPROBFALTA: TcxGridDBColumn
        DataBinding.FieldName = 'PROBFALTA'
      end
      object cxGridDBTableViewPERCENTDIAS: TcxGridDBColumn
        DataBinding.FieldName = 'PERCENTDIAS'
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
    DataSet = DmEstoqProdutos.CdsEstoqProdutos
    Left = 144
    Top = 56
  end
end
