object FormCadastroAtividade: TFormCadastroAtividade
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
      DataField = 'Name'
      DataSource = DsAtividade
      TabOrder = 1
    end
    object DBEditID: TDBEdit
      Left = 64
      Top = 15
      Width = 93
      Height = 21
      DataField = 'ID'
      DataSource = DsAtividade
      ReadOnly = True
      TabOrder = 0
    end
    object DBEditDescricao: TDBEdit
      Left = 64
      Top = 42
      Width = 521
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Description'
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
      object PanelControles: TPanel
        Left = 2
        Top = 163
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
            FieldName = 'ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Name'
            Width = 135
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Description'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ExecutorClass'
            Width = 111
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
      object cxGridParametros: TcxGrid
        Left = 2
        Top = 15
        Width = 593
        Height = 80
        Align = alClient
        TabOrder = 0
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
    object BtnSalvar: TBitBtn
      Left = 12
      Top = 5
      Width = 108
      Height = 25
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = BtnSalvarClick
    end
    object BtnFechar: TBitBtn
      Left = 477
      Top = 5
      Width = 108
      Height = 25
      Caption = 'Fechar'
      TabOrder = 1
      OnClick = BtnFecharClick
    end
  end
  object DsAtividade: TDataSource
    DataSet = TbActivity
    Left = 385
    Top = 34
  end
  object DsProcessos: TDataSource
    AutoEdit = False
    DataSet = TblProcessos
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
  object TblProcessos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 377
    Top = 146
    object TblProcessosID: TIntegerField
      FieldName = 'ID'
    end
    object TblProcessosIDActivity: TIntegerField
      FieldName = 'IDActivity'
      Origin = 'IDActivity'
    end
    object TblProcessosName: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TblProcessosDescription: TMemoField
      FieldName = 'Description'
      Origin = 'Description'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TblProcessosClassName: TMemoField
      FieldName = 'ClassName'
      Origin = 'ClassName'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TblProcessosExecutorClass: TMemoField
      FieldName = 'ExecutorClass'
      Origin = 'ExecutorClass'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object TbActivity: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 305
    Top = 34
    object TbActivityID: TIntegerField
      FieldName = 'ID'
    end
    object TbActivityIDActivity: TIntegerField
      FieldName = 'IDActivity'
      Origin = 'IDActivity'
    end
    object TbActivityName: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      OnGetText = FieldGetText
      OnSetText = FieldSetText
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbActivityDescription: TMemoField
      FieldName = 'Description'
      Origin = 'Description'
      OnGetText = FieldGetText
      OnSetText = FieldSetText
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbActivityClassName: TMemoField
      FieldName = 'ClassName'
      Origin = 'ClassName'
      OnGetText = FieldGetText
      OnSetText = FieldSetText
      BlobType = ftMemo
      Size = 2147483647
    end
    object TbActivityExecutorClass: TMemoField
      FieldName = 'ExecutorClass'
      Origin = 'ExecutorClass'
      OnGetText = FieldGetText
      OnSetText = FieldSetText
      BlobType = ftMemo
      Size = 2147483647
    end
  end
end
