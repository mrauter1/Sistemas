object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 340
  ClientWidth = 636
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BtnLer: TButton
    Left = 72
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Ler'
    TabOrder = 0
    OnClick = BtnLerClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 72
    Width = 281
    Height = 260
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object BtnSalvar: TButton
    Left = 408
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 2
    OnClick = BtnSalvarClick
  end
  object MemoProxys: TMemo
    Left = 320
    Top = 72
    Width = 308
    Height = 260
    TabOrder = 3
  end
end
