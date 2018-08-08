object FormExecSql: TFormExecSql
  Left = 0
  Top = 0
  Caption = 'Executar Sql'
  ClientHeight = 448
  ClientWidth = 735
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
  object MemoSql: TMemo
    Left = 0
    Top = 0
    Width = 735
    Height = 405
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 168
    ExplicitTop = 128
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
  object PanelTop: TPanel
    Left = 0
    Top = 405
    Width = 735
    Height = 43
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 411
    object BtnExec: TButton
      Left = 319
      Top = 6
      Width = 98
      Height = 25
      Caption = 'Executar'
      TabOrder = 0
      OnClick = BtnExecClick
    end
  end
end
