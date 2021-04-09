object FormPropriedadesGrafico: TFormPropriedadesGrafico
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Propriedades'
  ClientHeight = 290
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 224
    Height = 49
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 273
    DesignSize = (
      224
      49)
    object Label1: TLabel
      Left = 1
      Top = 16
      Width = 26
      Height = 13
      Caption = 'T'#237'tulo'
    end
    object EditTitulo: TEdit
      Left = 33
      Top = 13
      Width = 185
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      ExplicitWidth = 232
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 224
    Height = 241
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 273
    object cxGrid1: TcxGrid
      Left = 1
      Top = 1
      Width = 222
      Height = 198
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 271
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
      end
      object cxGrid1BandedTableView1: TcxGridBandedTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        Bands = <
          item
          end>
      end
      object cxGrid1TableView1: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
      end
      object ViewSeries: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.CustomizeDialog = False
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsView.GroupByBox = False
        object cxSeriesID: TcxGridColumn
          Caption = 'ID'
          DataBinding.ValueType = 'Integer'
          Visible = False
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Options.FilteringWithFindPanel = False
          Width = 41
        end
        object cxSeriesName: TcxGridColumn
          Caption = 'Series'
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Options.FilteringWithFindPanel = False
          Width = 205
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = ViewSeries
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 199
      Width = 222
      Height = 41
      Align = alBottom
      TabOrder = 1
      ExplicitWidth = 271
      DesignSize = (
        222
        41)
      object BtnOK: TButton
        Left = 67
        Top = 6
        Width = 75
        Height = 25
        Anchors = [akTop]
        Caption = 'OK'
        TabOrder = 0
        OnClick = BtnOKClick
      end
    end
  end
end
