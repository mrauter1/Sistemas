object FormCadastroAviso: TFormCadastroAviso
  Left = 0
  Top = 0
  Caption = 'Configurar Atividades'
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
    Height = 78
    Align = alTop
    TabOrder = 0
    DesignSize = (
      599
      78)
    object Label1: TLabel
      Left = 176
      Top = 18
      Width = 90
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome da Atividade'
    end
    object Label2: TLabel
      Left = 47
      Top = 18
      Width = 11
      Height = 13
      Alignment = taRightJustify
      Caption = 'ID'
    end
    object Label3: TLabel
      Left = 12
      Top = 45
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o'
    end
    object DBEditNomeAtividade: TDBEdit
      Left = 272
      Top = 15
      Width = 313
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Nome'
      DataSource = DsAtividade
      TabOrder = 0
    end
    object DBEditID: TDBEdit
      Left = 64
      Top = 15
      Width = 93
      Height = 21
      DataField = 'ID'
      DataSource = DsAtividade
      ReadOnly = True
      TabOrder = 1
    end
    object DBEditDescricao: TDBEdit
      Left = 64
      Top = 42
      Width = 521
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Titulo'
      DataSource = DsAtividade
      TabOrder = 2
    end
  end
  object PanelCentro: TPanel
    Left = 0
    Top = 78
    Width = 599
    Height = 410
    Align = alClient
    TabOrder = 1
    object GroupBoxProcessos: TGroupBox
      Left = 1
      Top = 1
      Width = 597
      Height = 206
      Align = alClient
      Caption = 'Processos'
      TabOrder = 0
      ExplicitHeight = 255
      object PanelControles: TPanel
        Left = 2
        Top = 163
        Width = 593
        Height = 41
        Align = alBottom
        TabOrder = 0
        ExplicitTop = 212
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
          object BtnAddProcesso: TBitBtn
            Left = 12
            Top = 9
            Width = 108
            Height = 25
            Caption = 'Adicionar Processo'
            TabOrder = 0
            OnClick = BtnAddProcessoClick
          end
          object BtnRemoveProcesso: TBitBtn
            Left = 147
            Top = 9
            Width = 108
            Height = 25
            Caption = 'Remover Processo'
            TabOrder = 1
            OnClick = BtnRemoveProcessoClick
          end
          object BtnConfiguraProcesso: TBitBtn
            Left = 275
            Top = 9
            Width = 108
            Height = 25
            Caption = 'Configurar Processo'
            TabOrder = 2
            OnClick = BtnConfiguraProcessoClick
          end
        end
      end
      object DBGridRelatorios: TDBGrid
        Left = 2
        Top = 15
        Width = 593
        Height = 148
        Align = alClient
        DataSource = DsProcessos
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
    object GroupBoxInputs: TGroupBox
      Left = 1
      Top = 207
      Width = 597
      Height = 97
      Align = alBottom
      Caption = 'Inputs'
      TabOrder = 1
      ExplicitTop = 152
      object cxGridParametros: TcxGrid
        Left = 2
        Top = 15
        Width = 593
        Height = 80
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 11
        object cxGridParametrosDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          object cxGridParametrosDBTableView1IDParametro: TcxGridDBColumn
            DataBinding.FieldName = 'IDParametro'
            Width = 57
          end
          object cxGridParametrosDBTableView1Nome: TcxGridDBColumn
            Caption = 'Nome'
            DataBinding.FieldName = 'IDParametro'
            Width = 187
          end
          object cxGridParametrosDBTableView1Valor: TcxGridDBColumn
            DataBinding.FieldName = 'Valor'
            Width = 213
          end
        end
        object cxGridParametrosLevel1: TcxGridLevel
          GridView = cxGridParametrosDBTableView1
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 304
      Width = 597
      Height = 105
      Align = alBottom
      Caption = 'Outputs'
      TabOrder = 2
      object cxGrid1: TcxGrid
        Left = 2
        Top = 15
        Width = 593
        Height = 88
        Align = alClient
        TabOrder = 0
        ExplicitTop = 56
        ExplicitHeight = 102
        object cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          object cxGridDBColumn1: TcxGridDBColumn
            DataBinding.FieldName = 'IDParametro'
            Width = 57
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Nome'
            DataBinding.FieldName = 'IDParametro'
            Width = 187
          end
          object cxGridDBColumn3: TcxGridDBColumn
            DataBinding.FieldName = 'Valor'
            Width = 213
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
    end
  end
  object PanelBot: TPanel
    Left = 0
    Top = 488
    Width = 599
    Height = 44
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 1
    ExplicitTop = 491
    object BtnSalvar: TBitBtn
      Left = 12
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
  object QryAtividade: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select *'
      'from cons.AvisoAutomatico'
      'where ID = :ID')
    Left = 433
    Top = 34
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end>
    object QryAtividadeID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryAtividadeNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 255
    end
    object QryAtividadeTitulo: TStringField
      FieldName = 'Titulo'
      Origin = 'Titulo'
      Size = 511
    end
    object QryAtividadeMensagem: TMemoField
      FieldName = 'Mensagem'
      Origin = 'Mensagem'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object DsAtividade: TDataSource
    DataSet = QryAtividade
    Left = 529
    Top = 34
  end
  object QryProcessos: TFDQuery
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
    Left = 185
    Top = 146
    ParamData = <
      item
        Name = 'IDAVISO'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end>
    object QryProcessosIDAviso: TIntegerField
      FieldName = 'IDAviso'
      Origin = 'IDAviso'
      Required = True
    end
    object QryProcessosIDConsulta: TIntegerField
      DisplayLabel = 'ID Consulta'
      FieldName = 'IDConsulta'
      Origin = 'IDConsulta'
      Required = True
    end
    object QryProcessosDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 50
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 512
    end
    object QryProcessosVisualizacao: TStringField
      DisplayLabel = 'Visualiza'#231#227'o'
      FieldName = 'Visualizacao'
      Origin = 'Visualizacao'
      ReadOnly = True
      Size = 7
    end
  end
  object DsProcessos: TDataSource
    AutoEdit = False
    DataSet = QryProcessos
    Left = 281
    Top = 146
  end
  object QryInputs: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select *'
      'from cons.AvisoConsultaParametro'
      'where IDConsulta = :IDConsulta and IDAviso =:IDAviso'
      '')
    Left = 233
    Top = 314
    ParamData = <
      item
        Name = 'IDCONSULTA'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end
      item
        Name = 'IDAVISO'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end>
    object QryInputsIDAviso: TIntegerField
      FieldName = 'IDAviso'
      Origin = 'IDAviso'
    end
    object QryInputsIDConsulta: TIntegerField
      FieldName = 'IDConsulta'
      Origin = 'IDConsulta'
    end
    object QryInputsIDParametro: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'IDParametro'
      Origin = 'IDParametro'
    end
    object QryInputsValor: TMemoField
      FieldName = 'Valor'
      Origin = 'Valor'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object DsInputs: TDataSource
    AutoEdit = False
    DataSet = QryInputs
    Left = 345
    Top = 314
  end
  object DsOutputs: TDataSource
    AutoEdit = False
    DataSet = QryOutputs
    Left = 337
    Top = 450
  end
  object QryOutputs: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select *'
      'from cons.AvisoConsultaParametro'
      'where IDConsulta = :IDConsulta and IDAviso =:IDAviso'
      '')
    Left = 225
    Top = 450
    ParamData = <
      item
        Name = 'IDCONSULTA'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end
      item
        Name = 'IDAVISO'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end>
    object IntegerField1: TIntegerField
      FieldName = 'IDAviso'
      Origin = 'IDAviso'
    end
    object IntegerField2: TIntegerField
      FieldName = 'IDConsulta'
      Origin = 'IDConsulta'
    end
    object IntegerField3: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'IDParametro'
      Origin = 'IDParametro'
    end
    object MemoField1: TMemoField
      FieldName = 'Valor'
      Origin = 'Valor'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
end
