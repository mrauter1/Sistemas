object FormLista: TFormLista
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Lista'
  ClientHeight = 234
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ListComprov: TListBox
    Left = 0
    Top = 0
    Width = 460
    Height = 160
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 193
    Width = 460
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BtnOk: TBitBtn
      Left = 64
      Top = 6
      Width = 145
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BtnPadrao: TButton
      Left = 232
      Top = 6
      Width = 145
      Height = 25
      Caption = 'Restaurar valores padr'#227'o'
      TabOrder = 1
      OnClick = BtnPadraoClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 160
    Width = 460
    Height = 33
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      460
      33)
    object EditComprov: TEdit
      Left = 17
      Top = 4
      Width = 261
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object BtnAdd: TButton
      Left = 284
      Top = 2
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Adicionar'
      TabOrder = 1
      OnClick = BtnAddClick
    end
    object BtnDel: TButton
      Left = 371
      Top = 2
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Deletar'
      TabOrder = 2
      OnClick = BtnDelClick
    end
  end
end
