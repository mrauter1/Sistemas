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
  OnClose = FormClose
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
        DataField = 'Nome'
        DataSource = DsConsultas
        TabOrder = 0
      end
      object EdtDescricao: TDBEdit
        Left = 263
        Top = 23
        Width = 234
        Height = 21
        DataField = 'Descricao'
        DataSource = DsConsultas
        TabOrder = 1
      end
    end
    object PanelControles: TPanel
      Left = 1
      Top = 448
      Width = 610
      Height = 43
      Align = alBottom
      TabOrder = 1
      object BtnSalvar: TButton
        Left = 240
        Top = 6
        Width = 98
        Height = 25
        Caption = 'Salvar'
        TabOrder = 0
      end
    end
    object DBMemoSql: TDBMemo
      Left = 1
      Top = 67
      Width = 610
      Height = 381
      Align = alClient
      DataField = 'Sql'
      DataSource = DsConsultas
      TabOrder = 2
      ExplicitLeft = 168
      ExplicitTop = 236
      ExplicitWidth = 185
      ExplicitHeight = 89
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
    object QryConsultasID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryConsultasNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 255
    end
    object QryConsultasDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 512
    end
    object QryConsultasSql: TMemoField
      FieldName = 'Sql'
      Origin = 'Sql'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object DsConsultas: TDataSource
    DataSet = QryConsultas
    Left = 416
    Top = 128
  end
end
