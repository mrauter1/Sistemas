object FormCadastroAviso: TFormCadastroAviso
  Left = 0
  Top = 0
  Caption = 'Cadastrar Avisos Autom'#225'ticos'
  ClientHeight = 532
  ClientWidth = 599
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 599
    Height = 65
    Align = alTop
    TabOrder = 0
    DesignSize = (
      599
      65)
    object Label1: TLabel
      Left = 179
      Top = 26
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome do Aviso'
    end
    object Label2: TLabel
      Left = 47
      Top = 26
      Width = 11
      Height = 13
      Alignment = taRightJustify
      Caption = 'ID'
    end
    object DBEditNomeAviso: TDBEdit
      Left = 256
      Top = 23
      Width = 329
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Nome'
      DataSource = DsAviso
      TabOrder = 0
    end
    object DBEditID: TDBEdit
      Left = 64
      Top = 23
      Width = 93
      Height = 21
      DataField = 'ID'
      DataSource = DsAviso
      ReadOnly = True
      TabOrder = 1
    end
  end
  object PanelCentro: TPanel
    Left = 0
    Top = 65
    Width = 599
    Height = 423
    Align = alClient
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 1
      Top = 269
      Width = 597
      Height = 77
      Align = alBottom
      Caption = 'Forma de Notifica'#231#227'o'
      TabOrder = 0
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 137
      Width = 597
      Height = 132
      Align = alClient
      Caption = 'Relat'#243'rios'
      TabOrder = 1
      object PanelControles: TPanel
        Left = 2
        Top = 89
        Width = 593
        Height = 41
        Align = alBottom
        TabOrder = 0
        DesignSize = (
          593
          41)
        object Panel1: TPanel
          Left = 98
          Top = 0
          Width = 404
          Height = 41
          Anchors = [akBottom]
          BevelOuter = bvNone
          TabOrder = 0
          object BtnAddConsulta: TBitBtn
            Left = 12
            Top = 9
            Width = 108
            Height = 25
            Caption = 'Adicionar Consulta'
            TabOrder = 0
            OnClick = BtnAddConsultaClick
          end
          object BtnRemoveConsulta: TBitBtn
            Left = 147
            Top = 9
            Width = 108
            Height = 25
            Caption = 'Remover Consulta'
            TabOrder = 1
            OnClick = BtnRemoveConsultaClick
          end
          object BtnConfiguraConsulta: TBitBtn
            Left = 275
            Top = 9
            Width = 108
            Height = 25
            Caption = 'Configurar Consulta'
            TabOrder = 2
            OnClick = BtnConfiguraConsultaClick
          end
        end
      end
      object DBGridRelatorios: TDBGrid
        Left = 2
        Top = 15
        Width = 593
        Height = 74
        Align = alClient
        DataSource = DsAvisoConsulta
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'IDConsulta'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Descricao'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Visualizacao'
            Width = 90
            Visible = True
          end>
      end
    end
    object GroupBox4: TGroupBox
      Left = 1
      Top = 1
      Width = 597
      Height = 136
      Align = alTop
      Caption = 'Configura'#231#227'o'
      TabOrder = 2
      ExplicitLeft = 2
      ExplicitTop = -5
      DesignSize = (
        597
        136)
      object Label3: TLabel
        Left = 31
        Top = 26
        Width = 26
        Height = 13
        Alignment = taRightJustify
        Caption = 'T'#237'tulo'
      end
      object Label4: TLabel
        Left = 6
        Top = 58
        Width = 51
        Height = 13
        Alignment = taRightJustify
        Caption = 'Mensagem'
      end
      object DBEditTitulo: TDBEdit
        Left = 63
        Top = 23
        Width = 521
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Titulo'
        DataSource = DsAviso
        TabOrder = 0
      end
      object DBMemoMensagem: TDBMemo
        Left = 63
        Top = 55
        Width = 521
        Height = 75
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataField = 'Mensagem'
        DataSource = DsAviso
        TabOrder = 1
      end
    end
    object GroupBox3: TGroupBox
      Left = 1
      Top = 346
      Width = 597
      Height = 76
      Align = alBottom
      Caption = 'Agendamento'
      TabOrder = 3
    end
  end
  object PanelBot: TPanel
    Left = 0
    Top = 488
    Width = 599
    Height = 44
    Align = alBottom
    TabOrder = 2
    object BtnSalvar: TBitBtn
      Left = 7
      Top = 5
      Width = 108
      Height = 25
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = BtnSalvarClick
    end
    object BtnCancelar: TBitBtn
      Left = 142
      Top = 5
      Width = 108
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = BtnCancelarClick
    end
    object BtnFechar: TBitBtn
      Left = 477
      Top = 5
      Width = 108
      Height = 25
      Caption = 'Fechar'
      TabOrder = 2
      OnClick = BtnFecharClick
    end
  end
  object QryAviso: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select *'
      'from cons.AvisoAutomatico'
      'where ID = :ID')
    Left = 209
    Top = 90
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end>
    object QryAvisoID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryAvisoNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 255
    end
    object QryAvisoTitulo: TStringField
      FieldName = 'Titulo'
      Origin = 'Titulo'
      Size = 511
    end
    object QryAvisoMensagem: TMemoField
      FieldName = 'Mensagem'
      Origin = 'Mensagem'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object DsAviso: TDataSource
    DataSet = QryAviso
    Left = 305
    Top = 90
  end
  object QryAvisoConsulta: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select ac.IDAviso, IDConsulta, cc.Descricao, '
      '  case when ac.TipoVisualizacao = 0 then '#39'Tabela'#39
      '          when ac.TipoVisualizacao = 1 then '#39'Pivot'#39
      '          when ac.TipoVisualizacao = 2 then '#39'Gr'#225'fico'#39
      '   end as Visualizacao'
      'from cons.AvisoConsulta ac'
      'left join cons.Consultas cc on cc.ID = ac.IDConsulta'
      'where IDAviso = :IDAviso')
    Left = 201
    Top = 234
    ParamData = <
      item
        Name = 'IDAVISO'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end>
    object QryAvisoConsultaIDAviso: TIntegerField
      FieldName = 'IDAviso'
      Origin = 'IDAviso'
      Required = True
    end
    object QryAvisoConsultaIDConsulta: TIntegerField
      DisplayLabel = 'ID Consulta'
      FieldName = 'IDConsulta'
      Origin = 'IDConsulta'
      Required = True
    end
    object QryAvisoConsultaDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 50
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 512
    end
    object QryAvisoConsultaVisualizacao: TStringField
      DisplayLabel = 'Visualiza'#231#227'o'
      FieldName = 'Visualizacao'
      Origin = 'Visualizacao'
      ReadOnly = True
      Size = 7
    end
  end
  object DsAvisoConsulta: TDataSource
    AutoEdit = False
    DataSet = QryAvisoConsulta
    Left = 297
    Top = 234
  end
end
