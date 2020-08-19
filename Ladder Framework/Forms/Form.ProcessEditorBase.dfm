object FormProcessEditorBase: TFormProcessEditorBase
  Left = 0
  Top = 0
  Caption = 'FormProcessEditorBase'
  ClientHeight = 290
  ClientWidth = 614
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MaskEdit1: TMaskEdit
    Left = 192
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'MaskEdit1'
  end
  object Memo1: TMemo
    Left = 264
    Top = 104
    Width = 185
    Height = 49
    Lines.Strings = (
      'teste123'
      '456'
      '789'
      '910')
    TabOrder = 1
  end
end
