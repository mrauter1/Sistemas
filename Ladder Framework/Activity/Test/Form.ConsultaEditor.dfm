inherited FormConsultaEditor: TFormConsultaEditor
  Caption = 'FormConsultaEditor'
  ClientHeight = 482
  ClientWidth = 607
  ExplicitWidth = 623
  ExplicitHeight = 521
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 607
    Height = 91
    ExplicitHeight = 91
    object LblConsulta: TLabel [3]
      Left = 43
      Top = 68
      Width = 552
      Height = 13
      AutoSize = False
      Caption = 'Consulta'
    end
    inherited BtnOK: TBitBtn
      Left = 483
    end
    inherited DBEditNomeProcesso: TDBEdit
      Width = 277
    end
    inherited DBEdit1: TDBEdit
      Width = 494
    end
  end
  inherited Panel2: TPanel
    Top = 91
    Width = 607
    Height = 391
    object Splitter1: TSplitter [0]
      Left = 1
      Top = 168
      Width = 605
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 1
      ExplicitWidth = 192
    end
    inherited GroupBoxInputs: TGroupBox
      Width = 605
      Height = 167
      ExplicitWidth = 605
      ExplicitHeight = 181
      inherited ScrollBoxParametros: TScrollBox
        Width = 601
        Height = 150
        ExplicitTop = 11
        ExplicitWidth = 601
        ExplicitHeight = 150
      end
    end
    inherited GroupBoxOutputs: TGroupBox
      Top = 280
      Width = 605
      Height = 110
      ExplicitTop = 288
      ExplicitWidth = 630
      ExplicitHeight = 110
      inherited cxGrid1: TcxGrid
        Width = 601
        Height = 93
        ExplicitLeft = 1
      end
    end
    object cxGridExport: TcxGrid
      Left = 1
      Top = 171
      Width = 605
      Height = 109
      Align = alBottom
      TabOrder = 2
      object cxGridDBTableView2: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
      end
      object cxGridExportDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.First.Visible = False
        Navigator.Buttons.PriorPage.Visible = False
        Navigator.Buttons.Prior.Visible = False
        Navigator.Buttons.Next.Visible = False
        Navigator.Buttons.NextPage.Visible = False
        Navigator.Buttons.Last.Visible = False
        Navigator.Buttons.Delete.Visible = True
        Navigator.Buttons.Edit.Visible = False
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Cancel.Visible = False
        Navigator.Buttons.Refresh.Visible = False
        Navigator.Buttons.SaveBookmark.Visible = False
        Navigator.Buttons.GotoBookmark.Visible = False
        Navigator.Buttons.Filter.Visible = False
        Navigator.Visible = True
        DataController.DataSource = DsExport
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object cxGridExportDBTableView1Nome: TcxGridDBColumn
          DataBinding.FieldName = 'Nome'
          Width = 142
        end
        object cxGridExportDBTableView1Visualizacao: TcxGridDBColumn
          DataBinding.FieldName = 'Visualizacao'
          Width = 173
        end
        object cxGridExportDBTableView1NomeArquivo: TcxGridDBColumn
          DataBinding.FieldName = 'NomeArquivo'
          Width = 152
        end
        object cxGridExportDBTableView1TipoVisualizacao: TcxGridDBColumn
          DataBinding.FieldName = 'TipoVisualizacao'
          PropertiesClassName = 'TcxComboBoxProperties'
          Properties.DropDownListStyle = lsEditFixedList
          Properties.Items.Strings = (
            'TABELA'
            'TABELADINAMICA'
            'GRAFICO')
        end
      end
      object cxGridExportLevel1: TcxGridLevel
        GridView = cxGridExportDBTableView1
      end
    end
  end
  object TBExport: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 393
    Top = 226
    object TBExportNome: TStringField
      DisplayWidth = 80
      FieldName = 'Nome'
      Size = 255
    end
    object TBExportVisualizacao: TStringField
      DisplayLabel = 'Visualiza'#231#227'o'
      DisplayWidth = 20
      FieldName = 'Visualizacao'
      Size = 255
    end
    object TBExportNomeArquivo: TStringField
      DisplayLabel = 'Nome Arquivo'
      DisplayWidth = 20
      FieldName = 'NomeArquivo'
      Size = 2555
    end
    object TBExportTipoVisualizacao: TStringField
      DisplayLabel = 'Formato Exporta'#231#227'o'
      DisplayWidth = 20
      FieldName = 'TipoVisualizacao'
      Size = 255
    end
  end
  object DsExport: TDataSource
    DataSet = TBExport
    Left = 467
    Top = 226
  end
end
