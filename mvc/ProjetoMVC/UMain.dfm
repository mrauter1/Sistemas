object fMain: TfMain
  Left = 334
  Top = 205
  Caption = 'Main'
  ClientHeight = 215
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 80
    Top = 45
    Width = 47
    Height = 13
    Caption = 'Conex'#227'o:'
  end
  object BtnPedidos: TButton
    Left = 96
    Top = 104
    Width = 73
    Height = 25
    Caption = 'Pedidos'
    TabOrder = 0
    OnClick = BtnPedidosClick
  end
  object CbxConexao: TComboBox
    Left = 80
    Top = 64
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'DBX'
    OnChange = CbxConexaoChange
    Items.Strings = (
      'IBO'
      'DBX')
  end
  object BtnClientes: TButton
    Left = 188
    Top = 104
    Width = 89
    Height = 25
    Caption = 'Clientes'
    TabOrder = 2
    OnClick = BtnClientesClick
  end
  object BrnProduto: TButton
    Left = 8
    Top = 104
    Width = 73
    Height = 25
    Caption = 'Produto'
    TabOrder = 3
    OnClick = BrnProdutoClick
  end
  object BtnRelPed: TButton
    Left = 80
    Top = 144
    Width = 97
    Height = 25
    Caption = 'Relat'#243'rio Pedidos'
    TabOrder = 4
    OnClick = BtnRelPedClick
  end
end
