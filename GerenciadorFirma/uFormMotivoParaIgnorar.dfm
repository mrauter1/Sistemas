object FormMotivoIgnorar: TFormMotivoIgnorar
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Motivo para Ignorar'
  ClientHeight = 230
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    427
    230)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 48
    Width = 58
    Height = 13
    Caption = 'Observa'#231#227'o'
  end
  object Label2: TLabel
    Left = 24
    Top = 19
    Width = 42
    Height = 13
    Alignment = taRightJustify
    Caption = 'Motivo:'
  end
  object BtnOK: TBitBtn
    Left = 118
    Top = 197
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Caption = 'OK'
    TabOrder = 0
    OnClick = BtnOKClick
    ExplicitTop = 209
  end
  object MemoObs: TMemo
    Left = 8
    Top = 67
    Width = 411
    Height = 124
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    ExplicitHeight = 114
  end
  object BtnCancel: TBitBtn
    Left = 230
    Top = 197
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Cancel = True
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = BtnCancelClick
    ExplicitTop = 209
  end
  object CbxMotivo: TDBLookupComboBox
    Left = 73
    Top = 17
    Width = 346
    Height = 21
    KeyField = 'Cod'
    ListField = 'Motivo'
    ListSource = DsMotivos
    TabOrder = 3
  end
  object DsMotivos: TDataSource
    AutoEdit = False
    DataSet = QryMotivos
    Left = 280
    Top = 48
  end
  object QryMotivos: TFDQuery
    Active = True
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select 0 as Cod, '#39#39' as Motivo'
      'union all'
      'select * from MotivoIgnorarCiclo')
    Left = 144
    Top = 48
    object QryMotivosCod: TFDAutoIncField
      FieldName = 'Cod'
      Origin = 'Cod'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryMotivosMotivo: TStringField
      FieldName = 'Motivo'
      Origin = 'Motivo'
      Size = 255
    end
  end
end
