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
end
