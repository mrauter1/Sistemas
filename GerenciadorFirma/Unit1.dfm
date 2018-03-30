object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 367
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 768
    Height = 367
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnTitleClick = DBGrid1TitleClick
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = DmEstoqProdutos.CdsEstoqProdutos
    Left = 160
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
