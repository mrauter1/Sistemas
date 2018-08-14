object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Informa'#231#245'es de estoque e demanda'
  ClientHeight = 397
  ClientWidth = 977
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 977
    Height = 397
    Align = alClient
    TabOrder = 0
    object TreeViewMenu: TdxDBTreeView
      Left = 1
      Top = 1
      Width = 152
      Height = 395
      ShowNodeHint = True
      DataSource = DsMenu
      KeyField = 'ID'
      ListField = 'Descricao'
      ParentField = 'IDPai'
      RootValue = Null
      SeparatedSt = ' - '
      RaiseOnError = True
      Indent = 19
      Align = alLeft
      ParentColor = False
      Options = [trDBCanDelete, trDBConfirmDelete, trCanDBNavigate, trSmartRecordCopy, trCheckHasChildren]
      SelectedIndex = -1
      TabOrder = 0
      OnDblClick = TreeViewMenuDblClick
      PopupMenu = PopupMenuTreeView
    end
  end
  object MainMenu: TMainMenu
    Left = 50
    Top = 56
    object Utilidades1: TMenuItem
      Caption = 'Utilit'#225'rios'
      object Pedidos1: TMenuItem
        Caption = 'Pedidos'
        OnClick = Pedidos1Click
      end
      object Fila1: TMenuItem
        Caption = 'Fila de Produ'#231#227'o'
        OnClick = Fila1Click
      end
      object DetalhedosProdutos1: TMenuItem
        Caption = 'Detalhe dos Produtos'
        OnClick = DetalhedosProdutos1Click
      end
      object MenuItemProInfo: TMenuItem
        Caption = 'Cofig. dos Produtos'
        OnClick = MenuItemProInfoClick
      end
      object Pedidos21: TMenuItem
        Caption = 'Pedidos2'
        OnClick = Pedidos21Click
      end
    end
    object Extras1: TMenuItem
      Caption = 'Extras'
      object Densidade1: TMenuItem
        Caption = 'Densidade'
        OnClick = Densidade1Click
      end
      object Conversor1: TMenuItem
        Caption = 'Conversor'
        OnClick = Conversor1Click
      end
      object ValidaModelos1: TMenuItem
        Caption = 'Valida Modelos'
        OnClick = ValidaModelos1Click
      end
      object ExecutarSql1: TMenuItem
        Caption = 'Executar Sql'
        OnClick = ExecutarSql1Click
      end
      object CriarConsulta1: TMenuItem
        Caption = 'Gerenciar Relat'#243'rios'
        OnClick = CriarConsulta1Click
      end
    end
    object Consultas1: TMenuItem
      Caption = 'Consultas'
    end
  end
  object Timer1: TTimer
    Interval = 210000
    OnTimer = Timer1Timer
    Left = 472
    Top = 56
  end
  object QryConsultas: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT v.* FROM '
      'sys.views v'
      'where v.schema_id = schema_id('#39'cons'#39')')
    Left = 144
    Top = 56
    object QryConsultasname: TWideStringField
      FieldName = 'name'
      Origin = 'name'
      Required = True
      Size = 128
    end
  end
  object QryMenu: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select * from cons.Menu')
    Left = 144
    Top = 128
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
  object DsMenu: TDataSource
    DataSet = QryMenu
    Left = 80
    Top = 128
  end
  object PopupMenuTreeView: TPopupMenu
    Left = 72
    Top = 224
    object AbrirConsulta1: TMenuItem
      Caption = 'Abrir Consulta'
      Default = True
      OnClick = AbrirConsulta1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object NovoGrupo1: TMenuItem
      Caption = 'Novo Grupo'
      OnClick = NovoGrupo1Click
    end
    object NovaConsulta1: TMenuItem
      Caption = 'Nova Consulta'
      OnClick = NovaConsulta1Click
    end
    object EditarConsulta1: TMenuItem
      Caption = 'Editar Consulta'
      OnClick = EditarConsulta1Click
    end
  end
end
