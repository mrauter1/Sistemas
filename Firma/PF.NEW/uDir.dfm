object fDir: TfDir
  Left = 273
  Top = 153
  ActiveControl = Button1
  BorderStyle = bsToolWindow
  Caption = 'Selecione o diret'#243'rio'
  ClientHeight = 184
  ClientWidth = 283
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LblDir: TLabel
    Left = 0
    Top = 4
    Width = 281
    Height = 13
    AutoSize = False
    Caption = 'F:\Sistemas\Firma\PF.NEW'
  end
  object DirectoryList: TDirectoryListBox
    Left = 0
    Top = 21
    Width = 281
    Height = 124
    DirLabel = LblDir
    TabOrder = 0
  end
  object Button1: TButton
    Left = 73
    Top = 152
    Width = 136
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button1Click
  end
end
