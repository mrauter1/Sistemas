object FormViewBase: TFormViewBase
  Left = 0
  Top = 0
  Caption = 'FormViewBase'
  ClientHeight = 244
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object View: TCadView
    AutoAddEventosControles = True
    ConfirmarDelecao = True
    DesabilitaEditIndiceEmEdicao = True
    AutoAdicionaRegistro = True
    ConfirmaAdicao = True
    Left = 200
    Top = 16
  end
end
