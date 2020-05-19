object FormNovoProcesso: TFormNovoProcesso
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Selecione o Tipo do Processo'
  ClientHeight = 86
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object CbxExecutors: TComboBox
    Left = 40
    Top = 16
    Width = 361
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 0
  end
  object BtnOK: TBitBtn
    Left = 184
    Top = 52
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = BtnOKClick
  end
  object QryConsulta: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from cons.Consultas'
      'where ID = :ID')
    Left = 88
    Top = 24
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
    object QryConsultaID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryConsultaNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 255
    end
    object QryConsultaDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 512
    end
    object QryConsultaSql: TMemoField
      FieldName = 'Sql'
      Origin = 'Sql'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryConsultaInfoExtendida: TMemoField
      FieldName = 'InfoExtendida'
      Origin = 'InfoExtendida'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryConsultaTipo: TIntegerField
      FieldName = 'Tipo'
      Origin = 'Tipo'
    end
    object QryConsultaConfigPadrao: TIntegerField
      FieldName = 'ConfigPadrao'
      Origin = 'ConfigPadrao'
    end
    object QryConsultaVisualizacaoPadrao: TIntegerField
      FieldName = 'VisualizacaoPadrao'
      Origin = 'VisualizacaoPadrao'
    end
    object QryConsultaIDPai: TIntegerField
      FieldName = 'IDPai'
      Origin = 'IDPai'
    end
    object QryConsultaFonteDados: TIntegerField
      FieldName = 'FonteDados'
      Origin = 'FonteDados'
    end
  end
  object QryParametros: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from cons.Parametros'
      'where Consulta = :IDConsulta')
    Left = 336
    Top = 24
    ParamData = <
      item
        Name = 'IDCONSULTA'
        ParamType = ptInput
      end>
    object QryParametrosID: TFDAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object QryParametrosConsulta: TIntegerField
      FieldName = 'Consulta'
    end
    object QryParametrosNome: TStringField
      FieldName = 'Nome'
      Size = 255
    end
    object QryParametrosDescricao: TStringField
      FieldName = 'Descricao'
      Size = 255
    end
    object QryParametrosTipo: TIntegerField
      FieldName = 'Tipo'
    end
    object QryParametrosSql: TMemoField
      FieldName = 'Sql'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryParametrosOrdem: TIntegerField
      FieldName = 'Ordem'
    end
    object QryParametrosTamanho: TIntegerField
      FieldName = 'Tamanho'
    end
    object QryParametrosObrigatorio: TBooleanField
      FieldName = 'Obrigatorio'
    end
    object QryParametrosValorPadrao: TMemoField
      FieldName = 'ValorPadrao'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
end
