object FormInputSenha: TFormInputSenha
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Digite a senha'
  ClientHeight = 103
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    445
    103)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 80
    Top = 32
    Width = 34
    Height = 13
    Caption = 'Senha:'
  end
  object EditSenha: TEdit
    Left = 120
    Top = 29
    Width = 248
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    PasswordChar = '*'
    TabOrder = 0
    ExplicitWidth = 257
  end
  object btnOK: TBitBtn
    Left = 188
    Top = 62
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnOKClick
    ExplicitLeft = 193
    ExplicitTop = 69
  end
end
