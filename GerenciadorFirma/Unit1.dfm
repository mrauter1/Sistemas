object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Informa'#231#245'es de estoque e demanda'
  ClientHeight = 402
  ClientWidth = 768
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 768
    Height = 361
    Align = alClient
    TabOrder = 0
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxGridDBTableViewCellDblClick
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 361
    Width = 768
    Height = 41
    Align = alBottom
    Anchors = [akBottom]
    Caption = 'Panel1'
    TabOrder = 1
    DesignSize = (
      768
      41)
    object BtnAtualiza: TButton
      Left = 352
      Top = 14
      Width = 88
      Height = 25
      Anchors = [akBottom]
      Caption = 'Atualiza'
      TabOrder = 0
      OnClick = BtnAtualizaClick
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = DmEstoqProdutos.CdsEstoqProdutos
    Left = 144
    Top = 56
  end
  object MainMenu: TMainMenu
    Left = 328
    Top = 56
    object Pedidos1: TMenuItem
      Caption = 'Pedidos'
      OnClick = Pedidos1Click
    end
    object Fila1: TMenuItem
      Caption = 'Fila'
      OnClick = Fila1Click
    end
    object Densidade1: TMenuItem
      Caption = 'Densidade'
      OnClick = Densidade1Click
    end
    object Conversor1: TMenuItem
      Caption = 'Conversor'
      OnClick = Conversor1Click
    end
    object MenuItemProInfo: TMenuItem
      Caption = 'ProInfo'
      OnClick = MenuItemProInfoClick
    end
  end
end
