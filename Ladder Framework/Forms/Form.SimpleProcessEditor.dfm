inherited FormSimpleProcessEditor: TFormSimpleProcessEditor
  Caption = 'Simple Process Editor'
  ClientHeight = 418
  ExplicitHeight = 457
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    ExplicitLeft = -8
    ExplicitTop = 8
  end
  inherited Panel2: TPanel
    Height = 337
    ExplicitHeight = 337
    inherited Splitter1: TSplitter
      Top = 172
      ExplicitTop = 173
    end
    inherited GroupBoxInputs: TGroupBox
      Height = 171
      ExplicitHeight = 171
      inherited ScrollBoxParametros: TScrollBox
        Height = 154
        ExplicitHeight = 154
        object cxGridInputs: TcxGrid
          Left = 0
          Top = 0
          Width = 608
          Height = 154
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 2
          ExplicitTop = 15
          ExplicitWidth = 605
          ExplicitHeight = 143
          object cxGridDBTableView2: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.First.Visible = False
            Navigator.Buttons.PriorPage.Visible = False
            Navigator.Buttons.Prior.Visible = False
            Navigator.Buttons.Next.Visible = False
            Navigator.Buttons.NextPage.Visible = False
            Navigator.Buttons.Last.Visible = False
            Navigator.Buttons.Insert.Visible = True
            Navigator.Buttons.Append.Visible = False
            Navigator.Buttons.Post.Visible = True
            Navigator.Buttons.Cancel.Visible = True
            Navigator.Buttons.Refresh.Visible = False
            Navigator.Buttons.SaveBookmark.Visible = False
            Navigator.Buttons.GotoBookmark.Visible = False
            Navigator.Buttons.Filter.Visible = False
            Navigator.Visible = True
            DataController.DataSource = DsInput
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Appending = True
            OptionsView.GroupByBox = False
            object cxGridDBColumn1: TcxGridDBColumn
              DataBinding.FieldName = 'ID'
            end
            object cxGridDBColumn2: TcxGridDBColumn
              DataBinding.FieldName = 'Name'
              Width = 173
            end
            object cxGridDBColumn3: TcxGridDBColumn
              DataBinding.FieldName = 'Expression'
              Width = 280
            end
          end
          object cxGridLevel2: TcxGridLevel
            GridView = cxGridDBTableView2
          end
        end
      end
    end
    inherited GroupBoxOutputs: TGroupBox
      Top = 176
      ExplicitTop = 176
      inherited cxGridOutputs: TcxGrid
        inherited cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.First.Visible = False
          Navigator.Buttons.PriorPage.Visible = False
          Navigator.Buttons.Prior.Visible = False
          Navigator.Buttons.Next.Visible = False
          Navigator.Buttons.NextPage.Visible = False
          Navigator.Buttons.Last.Visible = False
          Navigator.Buttons.Refresh.Visible = False
          Navigator.Buttons.SaveBookmark.Visible = False
          Navigator.Buttons.GotoBookmark.Visible = False
          Navigator.Buttons.Filter.Visible = False
          Navigator.Visible = True
          OptionsData.Appending = True
          OptionsData.Deleting = True
          OptionsData.DeletingConfirmation = True
          OptionsData.Editing = True
          OptionsData.Inserting = True
        end
      end
    end
  end
  object DsInput: TDataSource
    DataSet = TBInput
    Left = 459
    Top = 154
  end
  object TBInput: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 377
    Top = 154
    object FDAutoIncField1: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object IntegerField1: TIntegerField
      FieldName = 'IDProcesso'
      Origin = 'IDProcesso'
    end
    object MemoField1: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      BlobType = ftMemo
      Size = 2147483647
    end
    object IntegerField2: TIntegerField
      FieldName = 'ParameterType'
      Origin = 'ParameterType'
    end
    object MemoField2: TMemoField
      FieldName = 'Expression'
      Origin = 'Expression'
      BlobType = ftMemo
      Size = 2147483647
    end
    object IntegerField3: TIntegerField
      FieldName = 'IDMaster'
      Origin = 'IDMaster'
    end
  end
end
