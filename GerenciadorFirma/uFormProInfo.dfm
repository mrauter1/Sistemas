object FormProInfo: TFormProInfo
  Left = 0
  Top = 0
  Caption = 'Configura'#231#227'o dos Produtos'
  ClientHeight = 272
  ClientWidth = 578
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 578
    Height = 272
    Align = alClient
    TabOrder = 0
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
      OptionsData.Inserting = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridDBTableViewCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
        Width = 67
      end
      object cxGridDBTableViewNAOFAZESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'NAOFAZESTOQUE'
        Width = 106
      end
      object cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'ESPACOESTOQUE'
        Width = 124
      end
      object cxGridDBTableViewPRODUCAOMINIMA: TcxGridDBColumn
        DataBinding.FieldName = 'PRODUCAOMINIMA'
        Width = 157
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object DataSource1: TDataSource
    DataSet = CdsProInfo
    Left = 176
    Top = 80
  end
  object CdsProInfo: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODPRODUTO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'NAOFAZESTOQUE'
        DataType = ftBoolean
      end
      item
        Name = 'ESPACOESTOQUE'
        DataType = ftInteger
      end
      item
        Name = 'PRODUCAOMINIMA'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 320
    Top = 80
    object CdsProInfoCODPRODUTO: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'CODPRODUTO'
      Size = 10
    end
    object CdsProInfoNAOFAZESTOQUE: TBooleanField
      DisplayLabel = 'N'#227'o Faz Estoque'
      FieldName = 'NAOFAZESTOQUE'
    end
    object CdsProInfoESPACOESTOQUE: TIntegerField
      DisplayLabel = 'Espa'#231'o Estoque'
      FieldName = 'ESPACOESTOQUE'
    end
    object CdsProInfoPRODUCAOMINIMA: TIntegerField
      DisplayLabel = 'Produ'#231#227'o Minima'
      FieldName = 'PRODUCAOMINIMA'
    end
  end
end
