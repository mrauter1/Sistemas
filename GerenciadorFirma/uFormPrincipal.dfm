object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Informa'#231#245'es de estoque e demanda'
  ClientHeight = 454
  ClientWidth = 899
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 899
    Height = 454
    Align = alClient
    TabOrder = 0
  end
  object MainMenu: TMainMenu
    Left = 328
    Top = 56
    object Utilidades1: TMenuItem
      Caption = 'Utilit'#225'rios'
      object Pedidos1: TMenuItem
        Caption = 'Pedidos'
        OnClick = Pedidos1Click
      end
      object Fila1: TMenuItem
        Caption = 'Fila de Produ'#231#227'o'
        OnClick = Fila1Click
      end
      object DetalhedosProdutos1: TMenuItem
        Caption = 'Detalhe dos Produtos'
        OnClick = DetalhedosProdutos1Click
      end
      object MenuItemProInfo: TMenuItem
        Caption = 'Cofig. dos Produtos'
        OnClick = MenuItemProInfoClick
      end
      object Pedidos21: TMenuItem
        Caption = 'Pedidos2'
        OnClick = Pedidos21Click
      end
    end
    object Extras1: TMenuItem
      Caption = 'Extras'
      object Densidade1: TMenuItem
        Caption = 'Densidade'
        OnClick = Densidade1Click
      end
      object Conversor1: TMenuItem
        Caption = 'Conversor'
        OnClick = Conversor1Click
      end
    end
  end
end
