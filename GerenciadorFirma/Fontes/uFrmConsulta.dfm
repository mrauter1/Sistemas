object FrmConsulta: TFrmConsulta
  Left = 0
  Top = 0
  Caption = 'Consulta'
  ClientHeight = 484
  ClientWidth = 875
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 875
    Height = 441
    Align = alClient
    TabOrder = 0
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource1
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
      OptionsView.CellAutoHeight = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 441
    Width = 875
    Height = 43
    Align = alBottom
    TabOrder = 1
    object BtnExec: TButton
      Left = 175
      Top = 6
      Width = 98
      Height = 25
      Caption = 'Refresh'
      TabOrder = 0
    end
    object BtnExport: TButton
      Left = 711
      Top = 6
      Width = 106
      Height = 25
      Caption = 'Exportar para Excel'
      TabOrder = 1
      OnClick = BtnExportClick
    end
  end
  object Qry: TFDQuery
    Connection = ConSqlServer.FDConnection
    Left = 224
    Top = 176
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = Qry
    Left = 368
    Top = 176
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.xml'
    Filter = '.xml|.xml'
    Left = 600
    Top = 65
  end
end
