object FormFeriados: TFormFeriados
  Left = 0
  Top = 0
  Caption = 'Tabela de Feriados'
  ClientHeight = 376
  ClientWidth = 494
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 273
    Height = 376
    Align = alLeft
    Caption = 'Feriados para adicionar - Formato dd/mm/yyyy'
    TabOrder = 0
    object MemoDatas: TMemo
      Left = 2
      Top = 15
      Width = 269
      Height = 318
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 247
    end
    object Panel1: TPanel
      Left = 2
      Top = 333
      Width = 269
      Height = 41
      Align = alBottom
      TabOrder = 1
      ExplicitLeft = 72
      ExplicitTop = 319
      ExplicitWidth = 185
      object BitBtn1: TBitBtn
        Left = 96
        Top = 6
        Width = 145
        Height = 25
        Caption = 'Adicionar Feriados'
        TabOrder = 0
        OnClick = BitBtn1Click
      end
    end
  end
  object cxGrid: TcxGrid
    Left = 281
    Top = 0
    Width = 213
    Height = 376
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 280
    ExplicitWidth = 210
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = False
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.Prior.Visible = False
      Navigator.Buttons.Next.Visible = False
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Last.Visible = False
      Navigator.Buttons.Edit.Visible = False
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = False
      Navigator.Buttons.Refresh.Visible = False
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = False
      Navigator.Visible = True
      DataController.DataSource = DsFeriados
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
      OptionsData.Editing = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridDBTableViewData: TcxGridDBColumn
        DataBinding.FieldName = 'Data'
        Width = 126
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 273
    Top = 0
    Width = 8
    Height = 376
    Control = GroupBox1
    ExplicitLeft = 280
    ExplicitTop = 80
    ExplicitHeight = 100
  end
  object QryFeriados: TFDQuery
    Active = True
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT * FROM FERIADOS')
    Left = 360
    Top = 120
    object QryFeriadosData: TDateField
      FieldName = 'Data'
      Origin = 'Data'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object DsFeriados: TDataSource
    AutoEdit = False
    DataSet = QryFeriados
    Left = 432
    Top = 120
  end
end
