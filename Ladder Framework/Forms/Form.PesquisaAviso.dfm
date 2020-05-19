object FormPesquisaAviso: TFormPesquisaAviso
  Left = 0
  Top = 0
  Caption = 'Pesquisa Aviso'
  ClientHeight = 346
  ClientWidth = 599
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 599
    Height = 305
    Align = alClient
    TabOrder = 0
    object cxGridAvisos: TcxGrid
      Left = 1
      Top = 1
      Width = 597
      Height = 303
      Align = alClient
      TabOrder = 0
      object cxGridAvisosDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = DsAvisos
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object cxGridAvisosDBTableView1ID: TcxGridDBColumn
          DataBinding.FieldName = 'ID'
          Width = 61
        end
        object cxGridAvisosDBTableView1IDActivity: TcxGridDBColumn
          DataBinding.FieldName = 'IDActivity'
          Visible = False
        end
        object cxGridAvisosDBTableView1Name: TcxGridDBColumn
          DataBinding.FieldName = 'Name'
          Width = 169
        end
        object cxGridAvisosDBTableView1Description: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 310
        end
      end
      object cxGridAvisosLevel1: TcxGridLevel
        GridView = cxGridAvisosDBTableView1
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 305
    Width = 599
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      599
      41)
    object BtnSelecionar: TButton
      Left = 240
      Top = 6
      Width = 97
      Height = 25
      Caption = 'Configurar Aviso'
      TabOrder = 0
      OnClick = BtnSelecionarClick
    end
    object BtnFechar: TButton
      Left = 496
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = BtnFecharClick
    end
    object BtnRemoverAviso: TButton
      Left = 119
      Top = 6
      Width = 97
      Height = 25
      Caption = 'Remover Aviso'
      TabOrder = 2
      OnClick = BtnRemoverAvisoClick
    end
    object BtnNovoAviso: TButton
      Left = 24
      Top = 6
      Width = 89
      Height = 25
      Caption = 'Novo Aviso'
      TabOrder = 3
      OnClick = BtnNovoAvisoClick
    end
  end
  object QryAvisos: TFDQuery
    Active = True
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select * from '
      'ladder.Processos'
      'where ClassName = '#39'TActivity'#39)
    Left = 120
    Top = 104
    object QryAvisosID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryAvisosIDActivity: TIntegerField
      FieldName = 'IDActivity'
      Origin = 'IDActivity'
      Visible = False
    end
    object QryAvisosName: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryAvisosDescription: TMemoField
      FieldName = 'Description'
      Origin = 'Description'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryAvisosClassName: TMemoField
      FieldName = 'ClassName'
      Origin = 'ClassName'
      Visible = False
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryAvisosExecutorClass: TMemoField
      FieldName = 'ExecutorClass'
      Origin = 'ExecutorClass'
      Visible = False
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object DsAvisos: TDataSource
    AutoEdit = False
    DataSet = QryAvisos
    Left = 248
    Top = 104
  end
end
