object Form1: TForm1
  Left = 478
  Top = 225
  Caption = 'Form1'
  ClientHeight = 536
  ClientWidth = 767
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cxDBPivotGrid1: TcxDBPivotGrid
    Left = 8
    Top = 8
    Width = 753
    Height = 273
    DataSource = DataSource1
    Groups = <>
    OptionsView.ColumnGrandTotalWidth = 204
    TabOrder = 0
    object cxDBPivotGrid1RecId: TcxDBPivotGridField
      Area = faData
      AreaIndex = 1
      DataBinding.FieldName = 'RecId'
      SummaryType = stCustom
      Visible = True
      OnCalculateCustomSummary = cxDBPivotGrid1RecIdCalculateCustomSummary
      UniqueName = 'RecId'
    end
    object cxDBPivotGrid1Values: TcxDBPivotGridField
      Area = faData
      AreaIndex = 0
      DataBinding.FieldName = 'Values'
      Visible = True
      OnCalculateCustomSummary = cxDBPivotGrid1ValuesCalculateCustomSummary
      UniqueName = 'Values'
    end
    object cxDBPivotGrid1ValuesCategory: TcxDBPivotGridField
      Area = faColumn
      AreaIndex = 0
      DataBinding.FieldName = 'ValuesCategory'
      Visible = True
      Width = 151
      UniqueName = 'ValuesCategory'
    end
    object cxDBPivotGrid1Date: TcxDBPivotGridField
      Area = faRow
      AreaIndex = 0
      DataBinding.FieldName = 'Date'
      SummaryType = stCustom
      TotalsVisibility = tvCustom
      Visible = True
      UniqueName = 'Date'
    end
    object cxDBPivotGrid1Index: TcxDBPivotGridField
      Area = faRow
      AreaIndex = 1
      DataBinding.FieldName = 'Index'
      Visible = True
      UniqueName = 'Index'
    end
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 288
    Width = 753
    Height = 241
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.First.Visible = True
      Navigator.Buttons.PriorPage.Visible = True
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.Next.Visible = True
      Navigator.Buttons.NextPage.Visible = True
      Navigator.Buttons.Last.Visible = True
      Navigator.Buttons.Insert.Visible = True
      Navigator.Buttons.Append.Visible = False
      Navigator.Buttons.Delete.Visible = True
      Navigator.Buttons.Edit.Visible = True
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Cancel.Visible = True
      Navigator.Buttons.Refresh.Visible = True
      Navigator.Buttons.SaveBookmark.Visible = True
      Navigator.Buttons.GotoBookmark.Visible = True
      Navigator.Buttons.Filter.Visible = True
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1RecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object cxGrid1DBTableView1Values: TcxGridDBColumn
        DataBinding.FieldName = 'Values'
        Width = 84
      end
      object cxGrid1DBTableView1ValuesCategory: TcxGridDBColumn
        DataBinding.FieldName = 'ValuesCategory'
        Width = 148
      end
      object cxGrid1DBTableView1Date: TcxGridDBColumn
        DataBinding.FieldName = 'Date'
        Width = 101
      end
      object cxGrid1DBTableView1Index: TcxGridDBColumn
        DataBinding.FieldName = 'Index'
        Width = 83
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object dxMemData1: TdxMemData
    Active = True
    Indexes = <>
    Persistent.Data = {
      5665728FC2F5285C8FFE3F04000000040000000300070056616C756573001400
      000001000F0056616C75657343617465676F7279000400000009000500446174
      65000400000003000600496E6465780001640000000101000000410191400B00
      010100000001C80000000101000000410191400B000102000000010A00000001
      01000000420191400B00010300000001140000000101000000420191400B0001
      04000000012C0100000101000000410192400B00010500000001900100000101
      000000410192400B000106000000011E0000000101000000420192400B000101
      00000001280000000101000000420192400B00010200000001F4010000010100
      0000410193400B00010300000001580200000101000000410193400B00010400
      000001320000000101000000420193400B000105000000013C00000001010000
      00420193400B000106000000}
    SortOptions = []
    Left = 480
    Top = 312
    object dxMemData1header: TIntegerField
      FieldName = 'Values'
    end
    object dxMemData1HeaderCategory: TStringField
      FieldName = 'ValuesCategory'
    end
    object dxMemData1Date: TDateField
      FieldName = 'Date'
    end
    object dxMemData1Value: TIntegerField
      FieldName = 'Index'
    end
  end
  object DataSource1: TDataSource
    DataSet = dxMemData1
    Left = 480
    Top = 360
  end
end
