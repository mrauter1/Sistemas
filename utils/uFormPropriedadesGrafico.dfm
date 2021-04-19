object FormPropriedadesGrafico: TFormPropriedadesGrafico
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Propriedades'
  ClientHeight = 280
  ClientWidth = 266
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
    Width = 266
    Height = 68
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 196
    DesignSize = (
      266
      68)
    object Label1: TLabel
      Left = 3
      Top = 8
      Width = 26
      Height = 13
      Caption = 'T'#237'tulo'
    end
    object EditTitulo: TEdit
      Left = 34
      Top = 5
      Width = 226
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnExit = EditTituloExit
      OnKeyDown = EditTituloKeyDown
      ExplicitWidth = 156
    end
    object GroupBoxFonte: TGroupBox
      Left = 1
      Top = 28
      Width = 264
      Height = 39
      Align = alBottom
      Caption = 'Fonte'
      TabOrder = 1
      ExplicitWidth = 194
      DesignSize = (
        264
        39)
      object Label3: TLabel
        Left = 86
        Top = 17
        Width = 48
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Tamanho:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object cbTamFonteGrafico: TComboBox
        Left = 139
        Top = 13
        Width = 46
        Height = 21
        ItemIndex = 1
        TabOrder = 0
        Text = '10'
        OnClick = cbTamFonteGraficoClick
        OnExit = cbTamFonteGraficoExit
        OnKeyDown = cbTamFonteGraficoKeyDown
        Items.Strings = (
          '8'
          '10'
          '12'
          '14'
          '16'
          '18'
          '20'
          '')
      end
      object BtnItalico: TButton
        Left = 56
        Top = 13
        Width = 23
        Height = 23
        Hint = 'It'#225'lico'
        Caption = 'I'
        DragCursor = crHandPoint
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = BtnItalicoClick
      end
      object BtnNegrito: TButton
        Left = 32
        Top = 13
        Width = 23
        Height = 23
        Hint = 'Negrito'
        Caption = 'N'
        DragCursor = crHandPoint
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = BtnNegritoClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 68
    Width = 266
    Height = 212
    Align = alClient
    TabOrder = 0
    ExplicitTop = 73
    ExplicitWidth = 212
    ExplicitHeight = 261
    object cxGrid1: TcxGrid
      Left = 1
      Top = 1
      Width = 264
      Height = 177
      Align = alClient
      TabOrder = 0
      ExplicitLeft = -4
      ExplicitTop = 6
      ExplicitWidth = 259
      ExplicitHeight = 169
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
        object cxSeriesFullName: TcxGridColumn
          Visible = False
        end
        object cxSeriesColor: TcxGridColumn
          Caption = 'Color'
          PropertiesClassName = 'TdxColorEditProperties'
          Properties.OnEditValueChanged = cxSeriesColorPropertiesEditValueChanged
          HeaderAlignmentHorz = taCenter
          Width = 33
        end
        object cxSeriesName: TcxGridColumn
          Caption = 'Series'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnEditValueChanged = cxSeriesNamePropertiesEditValueChanged
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Options.FilteringWithFindPanel = False
          Width = 143
        end
        object cxSeriesDisplayFormat: TcxGridColumn
          Caption = 'Display Format'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.OnEditValueChanged = cxSeriesDisplayFormatPropertiesEditValueChanged
          Width = 77
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = ViewSeries
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 178
      Width = 264
      Height = 33
      Align = alBottom
      TabOrder = 1
      ExplicitWidth = 259
      DesignSize = (
        264
        33)
      object BtnOK: TButton
        Left = 92
        Top = 5
        Width = 75
        Height = 25
        Anchors = [akTop]
        Caption = 'OK'
        TabOrder = 0
        OnClick = BtnOKClick
        ExplicitLeft = 90
      end
    end
  end
end
