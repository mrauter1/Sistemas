inherited FormConsultaEditor: TFormConsultaEditor
  Caption = 'FormConsultaEditor'
  ClientHeight = 474
  ClientWidth = 590
  ExplicitWidth = 606
  ExplicitHeight = 513
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 590
    Height = 91
    ExplicitWidth = 607
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
      Left = 466
      ExplicitLeft = 483
    end
    inherited DBEditNomeProcesso: TDBEdit
      Width = 260
      ExplicitWidth = 277
    end
    inherited DBEdit1: TDBEdit
      Width = 477
      ExplicitWidth = 494
    end
  end
  inherited Panel2: TPanel
    Top = 91
    Width = 590
    Height = 383
    ExplicitTop = 91
    ExplicitWidth = 607
    ExplicitHeight = 383
    inherited Splitter1: TSplitter
      Top = 165
      Width = 588
      Height = 3
      ExplicitTop = 159
      ExplicitWidth = 605
      ExplicitHeight = 3
    end
    inherited GroupBoxInputs: TGroupBox
      Width = 588
      Height = 164
      ExplicitWidth = 605
      ExplicitHeight = 164
      inherited ScrollBoxParametros: TScrollBox
        Width = 584
        Height = 147
        ExplicitLeft = 2
        ExplicitWidth = 601
        ExplicitHeight = 147
      end
    end
    inherited GroupBoxOutputs: TGroupBox
      Top = 272
      Width = 588
      Height = 110
      ExplicitTop = 272
      ExplicitWidth = 605
      ExplicitHeight = 110
      inherited cxGridOutputs: TcxGrid
        Width = 584
        Height = 93
        ExplicitWidth = 601
        ExplicitHeight = 93
      end
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 168
      Width = 588
      Height = 104
      Align = alBottom
      Caption = 'Arquivos para exporta'#231#227'o'
      TabOrder = 2
      ExplicitWidth = 605
      object cxGridExport: TcxGrid
        Left = 2
        Top = 15
        Width = 584
        Height = 87
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 601
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
  end
  object TBExport: TFDMemTable [4]
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
  object DsExport: TDataSource [5]
    DataSet = TBExport
    Left = 467
    Top = 226
  end
end
