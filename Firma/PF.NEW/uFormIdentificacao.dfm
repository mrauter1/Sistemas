object FormIdentificacaoEmpresa: TFormIdentificacaoEmpresa
  Left = 0
  Top = 0
  Caption = 'Identifica'#231#227'o da Empresa/Mapa'
  ClientHeight = 280
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object CheckListBox: TCheckListBox
    Left = 16
    Top = 16
    Width = 233
    Height = 217
    ItemHeight = 13
    Items.Strings = (
      'Comercializa'#231#227'o Nacional'
      'Comercializa'#231#227'o Internacional'
      'Produ'#231#227'o'
      'Transforma'#231#227'o'
      'Consumo'
      'Fabrica'#231#227'o'
      'Transporte'
      'Armazenamento')
    TabOrder = 0
  end
  object BtnOk: TBitBtn
    Left = 64
    Top = 247
    Width = 145
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
end
