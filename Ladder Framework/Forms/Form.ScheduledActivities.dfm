object FormScheduledActivities: TFormScheduledActivities
  Left = 0
  Top = 0
  Caption = 'Agendamentos'
  ClientHeight = 346
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 764
    Height = 305
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 599
    object cxGridAvisos: TcxGrid
      Left = 1
      Top = 1
      Width = 762
      Height = 303
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 0
      object cxGridAvisosDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = DsSchedules
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
          Width = 57
        end
        object cxGridAvisosDBTableView1IDActivity: TcxGridDBColumn
          DataBinding.FieldName = 'IDActivity'
          Visible = False
        end
        object cxGridAvisosDBTableView1Name: TcxGridDBColumn
          DataBinding.FieldName = 'Name'
          Width = 156
        end
        object cxGridAvisosDBTableView1Description: TcxGridDBColumn
          DataBinding.FieldName = 'Description'
          Width = 213
        end
        object cxGridAvisosDBTableView1CronExpression: TcxGridDBColumn
          DataBinding.FieldName = 'CronExpression'
          Width = 85
        end
        object cxGridAvisosDBTableView1LastExecutionTime: TcxGridDBColumn
          DataBinding.FieldName = 'LastExecutionTime'
          Width = 103
        end
        object cxGridAvisosDBTableView1NextExecutionTime: TcxGridDBColumn
          DataBinding.FieldName = 'NextExecutionTime'
          Width = 110
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
    Width = 764
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 599
    DesignSize = (
      764
      41)
    object BtnSelecionar: TButton
      Left = 240
      Top = 6
      Width = 97
      Height = 25
      Caption = 'Configurar'
      TabOrder = 0
      OnClick = BtnSelecionarClick
    end
    object BtnFechar: TButton
      Left = 661
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = BtnFecharClick
      ExplicitLeft = 496
    end
    object BtnRemoverAviso: TButton
      Left = 119
      Top = 6
      Width = 97
      Height = 25
      Caption = 'Remover'
      TabOrder = 2
      OnClick = BtnRemoverAvisoClick
    end
    object BtnNovoAviso: TButton
      Left = 24
      Top = 5
      Width = 89
      Height = 25
      Caption = 'Novo'
      TabOrder = 3
      OnClick = BtnNovoAvisoClick
    end
  end
  object DsSchedules: TDataSource
    AutoEdit = False
    DataSet = TbSchedules
    Left = 280
    Top = 104
  end
  object TbSchedules: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 385
    Top = 106
    object TbSchedulesID: TIntegerField
      FieldName = 'ID'
    end
    object TbSchedulesIDActivity: TIntegerField
      FieldName = 'IDActivity'
      Origin = 'IDActivity'
    end
    object TbSchedulesName: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbSchedulesDescription: TMemoField
      FieldName = 'Description'
      Origin = 'Description'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbSchedulesClassName: TMemoField
      FieldName = 'ClassName'
      Origin = 'ClassName'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbSchedulesExecutorClass: TMemoField
      FieldName = 'ExecutorClass'
      Origin = 'ExecutorClass'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbSchedulesCronExpression: TMemoField
      FieldName = 'CronExpression'
      BlobType = ftMemo
    end
    object TbSchedulesLastExecutionTime: TDateTimeField
      FieldName = 'LastExecutionTime'
    end
    object TbSchedulesNextExecutionTime: TDateTimeField
      FieldName = 'NextExecutionTime'
    end
  end
end
