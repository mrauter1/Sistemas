object FormActivityEditor: TFormActivityEditor
  Left = 0
  Top = 0
  Caption = 'Configurar Atividades'
  ClientHeight = 542
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 575
    Height = 78
    Align = alTop
    TabOrder = 0
    DesignSize = (
      575
      78)
    object Label1: TLabel
      Left = 176
      Top = 18
      Width = 90
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome da Atividade'
    end
    object Label2: TLabel
      Left = 47
      Top = 18
      Width = 11
      Height = 13
      Alignment = taRightJustify
      Caption = 'ID'
    end
    object Label3: TLabel
      Left = 12
      Top = 45
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o'
    end
    object DBEditNomeAtividade: TDBEdit
      Left = 272
      Top = 15
      Width = 289
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Name'
      DataSource = DsAtividade
      TabOrder = 1
    end
    object DBEditID: TDBEdit
      Left = 64
      Top = 15
      Width = 93
      Height = 21
      DataField = 'ID'
      DataSource = DsAtividade
      ReadOnly = True
      TabOrder = 0
    end
    object DBEditDescricao: TDBEdit
      Left = 64
      Top = 42
      Width = 497
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Description'
      DataSource = DsAtividade
      TabOrder = 2
    end
  end
  object PanelCentro: TPanel
    Left = 0
    Top = 78
    Width = 575
    Height = 420
    Align = alClient
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 308
      Width = 573
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitLeft = 3
      ExplicitTop = 319
      ExplicitWidth = 597
    end
    object Splitter2: TSplitter
      Left = 1
      Top = 186
      Width = 573
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 1
      ExplicitWidth = 203
    end
    object GroupBoxProcessos: TGroupBox
      Left = 1
      Top = 1
      Width = 573
      Height = 185
      Align = alClient
      Caption = 'Processos'
      TabOrder = 0
      object PanelControles: TPanel
        Left = 2
        Top = 142
        Width = 569
        Height = 41
        Align = alBottom
        TabOrder = 0
        DesignSize = (
          569
          41)
        object Panel1: TPanel
          Left = 87
          Top = 0
          Width = 404
          Height = 36
          Anchors = [akBottom]
          BevelOuter = bvNone
          TabOrder = 0
          object BtnAddProcesso: TBitBtn
            Left = 13
            Top = 8
            Width = 108
            Height = 25
            Caption = 'Adicionar Processo'
            TabOrder = 0
            OnClick = BtnAddProcessoClick
          end
          object BtnRemoveProcesso: TBitBtn
            Left = 145
            Top = 8
            Width = 108
            Height = 25
            Caption = 'Remover Processo'
            TabOrder = 1
            OnClick = BtnRemoveProcessoClick
          end
          object BtnConfiguraProcesso: TBitBtn
            Left = 273
            Top = 8
            Width = 108
            Height = 25
            Caption = 'Configurar Processo'
            TabOrder = 2
            OnClick = BtnConfiguraProcessoClick
          end
        end
        object BtnMoveUp: TBitBtn
          Left = 514
          Top = 0
          Width = 32
          Height = 21
          Anchors = [akTop, akRight]
          Glyph.Data = {
            76060000424D7606000000000000360000002800000014000000140000000100
            2000000000004006000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000810000
            000F000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000F0000008100000094000000C10000000900000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000009000000C100000093000000030000
            00A8000000B10000000400000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000050000
            00B2000000A8000000030000000000000006000000B9000000A0000000020000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000002000000A2000000B80000000600000000000000000000
            00000000000C000000C80000008E000000010000000000000000000000000000
            000000000000000000000000000000000000000000010000008F000000C70000
            000B000000000000000000000000000000000000000000000012000000D50000
            007B000000000000000000000000000000000000000000000000000000000000
            00000000007C000000D400000012000000000000000000000000000000000000
            000000000000000000000000001B000000E00000006800000000000000000000
            000000000000000000000000000000000069000000DF0000001B000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0025000000E70000005700000000000000000000000000000000000000570000
            00E6000000250000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000031000000EB000000470000
            00000000000000000047000000EB000000300000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000003F000000EC0000003900000039000000EC0000003E0000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000000000004E0000
            00ED000000ED0000004D00000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000007D0000007D00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 1
          OnClick = BtnMoveUpClick
        end
        object BtnMoveDown: TBitBtn
          Left = 514
          Top = 18
          Width = 32
          Height = 21
          Anchors = [akTop, akRight]
          Glyph.Data = {
            76060000424D7606000000000000360000002800000014000000140000000100
            2000000000004006000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            007B0000007B0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000004D000000ED000000EC0000004C000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000000000000000003D000000EB0000
            003800000039000000EB0000003D000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000030000000EA00000046000000000000000000000047000000EA0000
            002F000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000024000000E600000056000000000000
            0000000000000000000000000057000000E50000002400000000000000000000
            00000000000000000000000000000000000000000000000000000000001A0000
            00DE000000670000000000000000000000000000000000000000000000000000
            0068000000DE0000001A00000000000000000000000000000000000000000000
            00000000000000000011000000D30000007A0000000000000000000000000000
            0000000000000000000000000000000000000000007B000000D3000000110000
            0000000000000000000000000000000000000000000A000000C60000008E0000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000008F000000C60000000A0000000000000000000000000000
            0005000000B8000000A000000001000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000001000000A10000
            00B7000000050000000000000002000000A7000000B100000003000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000004000000B2000000A600000001000000930000
            00C0000000080000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0008000000C100000092000000800000000E0000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000E00000080000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 2
          OnClick = BtnMoveDownClick
        end
        object BtnExecutar: TBitBtn
          Left = 9
          Top = 8
          Width = 67
          Height = 25
          Caption = 'Executar'
          TabOrder = 3
          OnClick = BtnExecutarClick
        end
      end
      object DBGridRelatorios: TDBGrid
        Left = 2
        Top = 15
        Width = 569
        Height = 127
        Align = alClient
        DataSource = DsProcessos
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Width = 53
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ExecOrder'
            Width = 35
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Name'
            Width = 135
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Description'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ExecutorClass'
            Width = 111
            Visible = True
          end>
      end
    end
    object GroupBoxInputs: TGroupBox
      Left = 1
      Top = 189
      Width = 573
      Height = 119
      Align = alBottom
      Caption = 'Inputs'
      TabOrder = 1
      object cxGridParametros: TcxGrid
        Left = 2
        Top = 15
        Width = 569
        Height = 102
        Align = alClient
        TabOrder = 0
        object cxGridParametrosDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = False
          Navigator.Buttons.PriorPage.Visible = False
          Navigator.Buttons.Prior.Visible = False
          Navigator.Buttons.Next.Visible = False
          Navigator.Buttons.NextPage.Visible = False
          Navigator.Buttons.Last.Visible = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Refresh.Visible = False
          Navigator.Buttons.SaveBookmark.Visible = False
          Navigator.Buttons.GotoBookmark.Visible = False
          Navigator.Buttons.Filter.Visible = False
          Navigator.Visible = True
          DataController.DataSource = DsInputs
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          object cxGridParametrosDBTableView1ID: TcxGridDBColumn
            DataBinding.FieldName = 'ID'
            Options.Editing = False
            Width = 42
          end
          object cxGridParametrosDBTableView1Name: TcxGridDBColumn
            DataBinding.FieldName = 'Name'
            Width = 128
          end
          object cxGridParametrosDBTableView1Expression: TcxGridDBColumn
            DataBinding.FieldName = 'Expression'
            Width = 333
          end
        end
        object cxGridParametrosLevel1: TcxGridLevel
          GridView = cxGridParametrosDBTableView1
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 311
      Width = 573
      Height = 108
      Align = alBottom
      Caption = 'Outputs'
      TabOrder = 2
      object cxGrid1: TcxGrid
        Left = 2
        Top = 15
        Width = 569
        Height = 91
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = False
          Navigator.Buttons.PriorPage.Visible = False
          Navigator.Buttons.Prior.Visible = False
          Navigator.Buttons.Next.Visible = False
          Navigator.Buttons.NextPage.Visible = False
          Navigator.Buttons.Last.Visible = False
          Navigator.Buttons.Append.Visible = False
          Navigator.Buttons.Refresh.Visible = False
          Navigator.Buttons.SaveBookmark.Visible = False
          Navigator.Buttons.GotoBookmark.Visible = False
          Navigator.Buttons.Filter.Visible = False
          Navigator.Visible = True
          DataController.DataSource = DsOutputs
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          object cxGridDBTableView1ID: TcxGridDBColumn
            DataBinding.FieldName = 'ID'
            Options.Editing = False
            Width = 47
          end
          object cxGridDBTableView1Name: TcxGridDBColumn
            DataBinding.FieldName = 'Name'
            Width = 121
          end
          object cxGridDBTableView1Expression: TcxGridDBColumn
            DataBinding.FieldName = 'Expression'
            Width = 376
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
    end
  end
  object PanelBot: TPanel
    Left = 0
    Top = 498
    Width = 575
    Height = 44
    Align = alBottom
    TabOrder = 2
    object BtnSalvar: TBitBtn
      Left = 12
      Top = 5
      Width = 108
      Height = 25
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = BtnSalvarClick
    end
    object BtnFechar: TBitBtn
      Left = 477
      Top = 5
      Width = 108
      Height = 25
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = BtnFecharClick
    end
  end
  object DsAtividade: TDataSource
    DataSet = TbActivity
    Left = 385
    Top = 34
  end
  object DsProcessos: TDataSource
    AutoEdit = False
    DataSet = TbProcessos
    Left = 281
    Top = 146
  end
  object DsOutputs: TDataSource
    DataSet = TBOutputs
    Left = 297
    Top = 442
  end
  object TbProcessos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 377
    Top = 146
    object TbProcessosID: TIntegerField
      FieldName = 'ID'
    end
    object TbProcessosExecOrder: TIntegerField
      DisplayLabel = 'Order'
      FieldName = 'ExecOrder'
    end
    object TbProcessosIDActivity: TIntegerField
      FieldName = 'IDActivity'
      Origin = 'IDActivity'
    end
    object TbProcessosName: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbProcessosDescription: TMemoField
      FieldName = 'Description'
      Origin = 'Description'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbProcessosClassName: TMemoField
      FieldName = 'ClassName'
      Origin = 'ClassName'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbProcessosExecutorClass: TMemoField
      FieldName = 'ExecutorClass'
      Origin = 'ExecutorClass'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object TbActivity: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 305
    Top = 34
    object TbActivityID: TIntegerField
      FieldName = 'ID'
    end
    object TbActivityIDActivity: TIntegerField
      FieldName = 'IDActivity'
      Origin = 'IDActivity'
    end
    object TbActivityName: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      OnGetText = FieldGetText
      OnSetText = FieldSetText
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbActivityDescription: TMemoField
      FieldName = 'Description'
      Origin = 'Description'
      OnGetText = FieldGetText
      OnSetText = FieldSetText
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbActivityClassName: TMemoField
      FieldName = 'ClassName'
      Origin = 'ClassName'
      OnGetText = FieldGetText
      OnSetText = FieldSetText
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbActivityExecutorClass: TMemoField
      FieldName = 'ExecutorClass'
      Origin = 'ExecutorClass'
      OnGetText = FieldGetText
      OnSetText = FieldSetText
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object TBInputs: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 377
    Top = 306
    object TBInputsID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object TBInputsIDProcesso: TIntegerField
      FieldName = 'IDProcesso'
      Origin = 'IDProcesso'
      ReadOnly = True
    end
    object TBInputsName: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      ReadOnly = True
      BlobType = ftMemo
      Size = 2147483647
    end
    object TBInputsParameterType: TIntegerField
      FieldName = 'ParameterType'
      Origin = 'ParameterType'
    end
    object TBInputsExpression: TMemoField
      FieldName = 'Expression'
      Origin = 'Expression'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TBInputsIDMaster: TIntegerField
      FieldName = 'IDMaster'
      Origin = 'IDMaster'
    end
  end
  object DsInputs: TDataSource
    DataSet = TBInputs
    Left = 297
    Top = 306
  end
  object TBOutputs: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 377
    Top = 442
    object TBOutputsID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object TBOutputsIDProcesso: TIntegerField
      FieldName = 'IDProcesso'
      Origin = 'IDProcesso'
      ReadOnly = True
    end
    object TBOutputsName: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TBOutputsParameterType: TIntegerField
      FieldName = 'ParameterType'
      Origin = 'ParameterType'
    end
    object TBOutputsExpression: TMemoField
      FieldName = 'Expression'
      Origin = 'Expression'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TBOutputsIDMaster: TIntegerField
      FieldName = 'IDMaster'
      Origin = 'IDMaster'
    end
  end
end
