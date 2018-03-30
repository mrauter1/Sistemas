object FrmTestProxy: TFrmTestProxy
  Left = 0
  Top = 0
  Caption = 'FrmTestProxy'
  ClientHeight = 395
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    570
    395)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelChavedeAcesso: TLabel
    Left = 8
    Top = 37
    Width = 27
    Height = 19
    Caption = 'Url:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 46
    Height = 19
    Caption = 'Proxy:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object WebBrowser: TWebBrowser
    Left = 8
    Top = 62
    Width = 554
    Height = 308
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabStop = False
    TabOrder = 0
    OnProgressChange = WebBrowserProgressChange
    ControlData = {
      4C00000042390000D51F00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620E000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object edtUrl: TEdit
    Left = 60
    Top = 35
    Width = 397
    Height = 21
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    HideSelection = False
    TabOrder = 1
  end
  object ButtonNovaConsulta: TButton
    Left = 463
    Top = 35
    Width = 99
    Height = 20
    Anchors = [akTop, akRight]
    Caption = 'GO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = ButtonNovaConsultaClick
    ExplicitLeft = 467
  end
  object EdtPrx: TEdit
    Left = 60
    Top = 8
    Width = 397
    Height = 21
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    HideSelection = False
    TabOrder = 3
    ExplicitWidth = 401
  end
  object BtnSetPrx: TButton
    Left = 463
    Top = 8
    Width = 99
    Height = 20
    Anchors = [akTop, akRight]
    Caption = 'SET'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = BtnSetPrxClick
    ExplicitLeft = 467
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 376
    Width = 554
    Height = 18
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 5
  end
end
