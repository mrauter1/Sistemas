object FormValidaModelos: TFormValidaModelos
  Left = 0
  Top = 0
  Caption = 'Valida'#231#227'o dos Modelos de Produ'#231#227'o'
  ClientHeight = 363
  ClientWidth = 706
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 706
    Height = 363
    Align = alClient
    TabOrder = 0
    object cxGridDBTableView: TcxGridDBTableView
      PopupMenu = PopupMenu1
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DSModelosComDivergencia
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
      object cxGridDBTableViewCodModelo: TcxGridDBColumn
        DataBinding.FieldName = 'CodModelo'
        Width = 88
      end
      object cxGridDBTableViewCodProduto: TcxGridDBColumn
        DataBinding.FieldName = 'CodProduto'
        Width = 86
      end
      object cxGridDBTableViewApresentacao: TcxGridDBColumn
        DataBinding.FieldName = 'Apresentacao'
        Width = 256
      end
      object cxGridDBTableViewPesoAcabado: TcxGridDBColumn
        DataBinding.FieldName = 'PesoAcabado'
      end
      object cxGridDBTableViewPesoCalculado: TcxGridDBColumn
        DataBinding.FieldName = 'PesoCalculado'
      end
      object cxGridDBTableViewLitroAcabado: TcxGridDBColumn
        Caption = 'Litros Acabado'
        DataBinding.FieldName = 'LitrosAcabado'
      end
      object cxGridDBTableViewLitroCalculado: TcxGridDBColumn
        Caption = 'Litros Calculado'
        DataBinding.FieldName = 'LitrosCalculado'
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object CdsModelosComDivergencia: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 248
    Top = 152
    object CdsModelosComDivergenciaCodModelo: TIntegerField
      DisplayLabel = 'Cod. Modelo'
      FieldName = 'CodModelo'
    end
    object CdsModelosComDivergenciaCodProduto: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'CodProduto'
      Size = 6
    end
    object CdsModelosComDivergenciaApresentacao: TStringField
      DisplayLabel = 'Apresenta'#231#227'o'
      FieldName = 'Apresentacao'
      Size = 80
    end
    object CdsModelosComDivergenciaPesoAcabado: TFloatField
      DisplayLabel = 'Peso Acabado'
      FieldName = 'PesoAcabado'
    end
    object CdsModelosComDivergenciaPesoCalculado: TFloatField
      DisplayLabel = 'Peso Calculado'
      FieldName = 'PesoCalculado'
    end
    object CdsModelosComDivergenciaLitroAcabado: TFloatField
      DisplayLabel = 'Litro Acabado'
      FieldName = 'LitrosAcabado'
    end
    object CdsModelosComDivergenciaLitroCalculado: TFloatField
      DisplayLabel = 'Litro Calculado'
      FieldName = 'LitrosCalculado'
    end
  end
  object DSModelosComDivergencia: TDataSource
    DataSet = CdsModelosComDivergencia
    Left = 248
    Top = 200
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
