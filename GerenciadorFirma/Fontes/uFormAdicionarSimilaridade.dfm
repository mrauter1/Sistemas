object FormAdicionarSimilaridade: TFormAdicionarSimilaridade
  Left = 0
  Top = 0
  Caption = 'Configurar Produtos Equivalentes'
  ClientHeight = 335
  ClientWidth = 711
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
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 711
    Height = 294
    Align = alClient
    TabOrder = 0
    object cxGridDBTableView: TcxGridDBTableView
      PopupMenu = PopupMenuOpcoes
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridDBTableViewEquivalente: TcxGridDBColumn
        DataBinding.FieldName = 'Equivalente'
        Width = 73
      end
      object cxGridDBTableViewCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
        Options.Editing = False
      end
      object cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn
        DataBinding.FieldName = 'APRESENTACAO'
        Options.Editing = False
        Width = 151
      end
      object cxGridDBTableViewNOMEAPLICACAO: TcxGridDBColumn
        DataBinding.FieldName = 'NOMEAPLICACAO'
        Options.Editing = False
        Width = 98
      end
      object cxGridDBTableViewUNIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'UNIDADE'
        Options.Editing = False
        Width = 111
      end
      object cxGridDBTableViewUNIDADEESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'UNIDADEESTOQUE'
        Options.Editing = False
      end
      object cxGridDBTableViewNOMESUBUNIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMESUBUNIDADE'
        Options.Editing = False
        Width = 124
      end
    end
    object cxGridDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
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
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 294
    Width = 711
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BtnConfirmarEquivalencias: TBitBtn
      Left = 296
      Top = 6
      Width = 161
      Height = 25
      Caption = 'Confirmar Equival'#234'ncias'
      TabOrder = 0
      OnClick = BtnConfirmarEquivalenciasClick
    end
  end
  object CdsSimilares: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 248
    Top = 88
    object CdsSimilaresCodProduto: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'CODPRODUTO'
      Size = 10
    end
    object CdsSimilaresAPRESENTACAO: TStringField
      DisplayLabel = 'Apresenta'#231#227'o'
      FieldName = 'APRESENTACAO'
      Size = 80
    end
    object CdsSimilaresAplicacao: TStringField
      DisplayLabel = 'Aplica'#231#227'o'
      FieldName = 'NOMEAPLICACAO'
      Size = 80
    end
    object CdsSimilaresNOMEUNIDADE: TStringField
      DisplayLabel = 'Unidade'
      FieldName = 'UNIDADE'
      Size = 50
    end
    object CdsSimilaresUNIDADEESTOQUE: TIntegerField
      DisplayLabel = 'Sub Unidade'
      FieldName = 'UNIDADEESTOQUE'
    end
    object CdsSimilaresNOMESUBUNIDADE: TStringField
      DisplayLabel = 'Nome Sub Unidade'
      FieldName = 'NOMESUBUNIDADE'
      Size = 60
    end
    object CdsSimilaresEquivalente: TBooleanField
      FieldName = 'Equivalente'
    end
  end
  object DataSource1: TDataSource
    DataSet = CdsSimilares
    Left = 408
    Top = 88
  end
  object PopupMenuOpcoes: TPopupMenu
    Left = 552
    Top = 88
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
