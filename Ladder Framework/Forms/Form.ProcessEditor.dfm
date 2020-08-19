object FormProcessEditor: TFormProcessEditor
  Left = 0
  Top = 0
  Caption = 'Configura'#231#227'o do Processo'
  ClientHeight = 405
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  GlassFrame.Enabled = True
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 597
    Height = 81
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 614
    DesignSize = (
      597
      81)
    object Label2: TLabel
      Left = 77
      Top = 14
      Width = 11
      Height = 13
      Alignment = taRightJustify
      Caption = 'ID'
    end
    object Label3: TLabel
      Left = 167
      Top = 14
      Width = 27
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome'
    end
    object Label4: TLabel
      Left = 42
      Top = 42
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o'
    end
    object BtnOK: TBitBtn
      Left = 473
      Top = 9
      Width = 108
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOKClick
      ExplicitLeft = 490
    end
    object DBEditIDConsulta: TDBEdit
      Left = 97
      Top = 11
      Width = 65
      Height = 21
      DataField = 'ID'
      DataSource = DsProcesso
      ReadOnly = True
      TabOrder = 1
    end
    object DBEditNomeProcesso: TDBEdit
      Left = 200
      Top = 11
      Width = 267
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Name'
      DataSource = DsProcesso
      TabOrder = 2
      ExplicitWidth = 284
    end
    object DBEdit1: TDBEdit
      Left = 97
      Top = 40
      Width = 484
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Description'
      DataSource = DsProcesso
      TabOrder = 3
      ExplicitWidth = 501
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 81
    Width = 597
    Height = 324
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 614
    object Splitter1: TSplitter
      Left = 1
      Top = 159
      Width = 595
      Height = 4
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 111
      ExplicitWidth = 609
    end
    object GroupBoxInputs: TGroupBox
      Left = 1
      Top = 1
      Width = 595
      Height = 158
      Align = alClient
      Caption = 'Inputs'
      TabOrder = 0
      ExplicitWidth = 612
      object ScrollBoxParametros: TScrollBox
        Left = 2
        Top = 15
        Width = 591
        Height = 141
        Align = alClient
        BevelEdges = []
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
        ExplicitLeft = -54
        ExplicitWidth = 645
      end
    end
    object GroupBoxOutputs: TGroupBox
      Left = 1
      Top = 163
      Width = 595
      Height = 160
      Align = alBottom
      Caption = 'Outputs'
      TabOrder = 1
      ExplicitWidth = 612
      object cxGridOutputs: TcxGrid
        Left = 2
        Top = 15
        Width = 591
        Height = 143
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 608
        object cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = DsOutput
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object cxGridDBTableView1ID: TcxGridDBColumn
            DataBinding.FieldName = 'ID'
          end
          object cxGridDBTableView1Name: TcxGridDBColumn
            DataBinding.FieldName = 'Name'
            Width = 173
          end
          object cxGridDBTableView1Expression: TcxGridDBColumn
            DataBinding.FieldName = 'Expression'
            Width = 280
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
    end
  end
  object DsProcesso: TDataSource
    DataSet = TbProcesso
    Left = 427
    Top = 18
  end
  object TbProcesso: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 345
    Top = 18
    object TbProcessoID: TIntegerField
      FieldName = 'ID'
    end
    object TbProcessoIDActivity: TIntegerField
      FieldName = 'IDActivity'
      Origin = 'IDActivity'
    end
    object TbProcessoName: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbProcessoDescription: TMemoField
      FieldName = 'Description'
      Origin = 'Description'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbProcessoClassName: TMemoField
      FieldName = 'ClassName'
      Origin = 'ClassName'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbProcessoExecutorClass: TMemoField
      FieldName = 'ExecutorClass'
      Origin = 'ExecutorClass'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object DsOutput: TDataSource
    DataSet = TBOutput
    Left = 443
    Top = 306
  end
  object TBOutput: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 361
    Top = 306
    object TBOutputID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object TBOutputIDProcesso: TIntegerField
      FieldName = 'IDProcesso'
      Origin = 'IDProcesso'
    end
    object TBOutputName: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TBOutputParameterType: TIntegerField
      FieldName = 'ParameterType'
      Origin = 'ParameterType'
    end
    object TBOutputExpression: TMemoField
      FieldName = 'Expression'
      Origin = 'Expression'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TBOutputIDMaster: TIntegerField
      FieldName = 'IDMaster'
      Origin = 'IDMaster'
    end
  end
end
