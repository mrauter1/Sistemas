object FormRelatoriosPersonalizados: TFormRelatoriosPersonalizados
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rios Personalizados'
  ClientHeight = 492
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxDBTreeList1: TcxDBTreeList
    Left = 0
    Top = 0
    Width = 169
    Height = 492
    Align = alLeft
    Bands = <>
    DataController.DataSource = DsConsultas
    Navigator.Buttons.CustomButtons = <>
    RootValue = -1
    TabOrder = 0
  end
  object PanelConsulta: TPanel
    Left = 169
    Top = 0
    Width = 612
    Height = 492
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 272
    ExplicitTop = 160
    ExplicitWidth = 185
    ExplicitHeight = 41
    object PanelInfo: TPanel
      Left = 1
      Top = 1
      Width = 610
      Height = 66
      Align = alTop
      TabOrder = 0
      object EdtNome: TDBEdit
        Left = 88
        Top = 23
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object EdtDescricao: TDBEdit
        Left = 263
        Top = 23
        Width = 234
        Height = 21
        TabOrder = 1
      end
    end
    object MemoSql: TMemo
      Left = 1
      Top = 67
      Width = 610
      Height = 381
      Align = alClient
      Lines.Strings = (
        'MemoSql')
      TabOrder = 1
      ExplicitTop = 99
      ExplicitHeight = 341
    end
    object PanelControles: TPanel
      Left = 1
      Top = 448
      Width = 610
      Height = 43
      Align = alBottom
      TabOrder = 2
      object BtnSalvar: TButton
        Left = 240
        Top = 6
        Width = 98
        Height = 25
        Caption = 'Salvar'
        TabOrder = 0
      end
    end
  end
  object BtnDefineCampos: TButton
    Left = 648
    Top = 454
    Width = 98
    Height = 25
    Caption = 'Definir Campos'
    TabOrder = 2
  end
  object QryConsultas: TFDQuery
    Active = True
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from cons.Consultas')
    Left = 305
    Top = 128
  end
  object DsConsultas: TDataSource
    DataSet = QryConsultas
    Left = 416
    Top = 128
  end
end
