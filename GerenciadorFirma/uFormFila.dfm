object FormFilaProducao: TFormFilaProducao
  Left = 0
  Top = 0
  Caption = 'Fila'
  ClientHeight = 336
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    639
    336)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 639
    Height = 294
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object BtnAtualiza: TButton
    Left = 272
    Top = 302
    Width = 88
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Atualiza'
    TabOrder = 1
    OnClick = BtnAtualizaClick
    ExplicitTop = 287
    ExplicitWidth = 75
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = DMFilaProducao.CdsFilaProducao
    Left = 160
    Top = 56
  end
end
