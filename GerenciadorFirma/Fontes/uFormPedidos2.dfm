object FormPedidos2: TFormPedidos2
  Left = 0
  Top = 0
  Caption = 'FormPedidos2'
  ClientHeight = 398
  ClientWidth = 849
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 849
    Height = 398
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -245
    ExplicitWidth = 875
    ExplicitHeight = 377
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
        end
        item
          Kind = skSum
        end
        item
          Kind = skSum
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridDBTableViewCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
      end
      object cxGridDBTableViewNOMEPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'NOMEPRODUTO'
        Width = 258
      end
      object cxGridDBTableViewQUANTIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTIDADE'
        Width = 76
      end
      object cxGridDBTableViewDIASPARAENTREGA: TcxGridDBColumn
        DataBinding.FieldName = 'DIASPARAENTREGA'
        Width = 117
      end
      object cxGridDBTableViewSIT: TcxGridDBColumn
        DataBinding.FieldName = 'SIT'
        Width = 31
      end
      object cxGridDBTableViewNUMPEDIDOS: TcxGridDBColumn
        DataBinding.FieldName = 'NUMPEDIDOS'
      end
      object cxGridDBTableViewFALTA: TcxGridDBColumn
        DataBinding.FieldName = 'FALTA'
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = DmEstoqProdutos.CdsPedidos
    Left = 344
    Top = 168
  end
end
