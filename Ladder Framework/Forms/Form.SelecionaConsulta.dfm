object FormSelecionaConsulta: TFormSelecionaConsulta
  Left = 0
  Top = 0
  Caption = 'Selecione a Consulta'
  ClientHeight = 510
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object TreeViewMenu: TdxDBTreeView
    Left = 0
    Top = 0
    Width = 360
    Height = 469
    RightClickSelect = True
    ShowNodeHint = True
    DataSource = DsMenu
    KeyField = 'ID'
    ListField = 'Descricao'
    ParentField = 'IDPai'
    RootValue = Null
    SeparatedSt = ' - '
    RaiseOnError = True
    ReadOnly = True
    DragMode = dmAutomatic
    Indent = 19
    Align = alClient
    ParentColor = False
    Options = [trDBCanDelete, trDBConfirmDelete, trCanDBNavigate, trSmartRecordCopy, trCheckHasChildren]
    SelectedIndex = -1
    TabOrder = 0
    OnDblClick = TreeViewMenuDblClick
    ExplicitHeight = 347
  end
  object Panel1: TPanel
    Left = 0
    Top = 469
    Width = 360
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 347
    DesignSize = (
      360
      41)
    object BtnSelecionar: TBitBtn
      Left = 144
      Top = 6
      Width = 89
      Height = 25
      Anchors = [akLeft, akRight]
      Caption = 'Selecionar'
      TabOrder = 0
      OnClick = BtnSelecionarClick
    end
  end
  object DsMenu: TDataSource
    DataSet = QryMenu
    Left = 176
    Top = 136
  end
  object QryMenu: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select * from cons.Menu')
    Left = 248
    Top = 136
    object QryMenuID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryMenuDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 255
    end
    object QryMenuIDPai: TIntegerField
      FieldName = 'IDPai'
      Origin = 'IDPai'
    end
    object QryMenuTipo: TIntegerField
      FieldName = 'Tipo'
      Origin = 'Tipo'
    end
    object QryMenuIDAcao: TIntegerField
      FieldName = 'IDAcao'
      Origin = 'IDAcao'
    end
  end
end
