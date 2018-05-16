object FormSelecionaModelo: TFormSelecionaModelo
  Left = 0
  Top = 0
  Caption = 'FormSelecionaModelo'
  ClientHeight = 100
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object CbxModelos: TComboBox
    Left = 32
    Top = 24
    Width = 401
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 0
  end
  object BtnOK: TBitBtn
    Left = 200
    Top = 67
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = BtnOKClick
  end
end
