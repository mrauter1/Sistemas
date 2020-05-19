object FormCadastroProcessoConsulta: TFormCadastroProcessoConsulta
  Left = 0
  Top = 0
  Caption = 'Cadastro Processo de Consulta Personalizada'
  ClientHeight = 546
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 629
    Height = 81
    Align = alTop
    TabOrder = 0
    DesignSize = (
      629
      81)
    object Label2: TLabel
      Left = 61
      Top = 16
      Width = 11
      Height = 13
      Alignment = taRightJustify
      Caption = 'ID'
    end
    object Label3: TLabel
      Left = 167
      Top = 16
      Width = 27
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome'
    end
    object Label4: TLabel
      Left = 26
      Top = 43
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o'
    end
    object BtnOK: TBitBtn
      Left = 505
      Top = 9
      Width = 108
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOKClick
    end
    object DBEditIDConsulta: TDBEdit
      Left = 81
      Top = 13
      Width = 80
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'ID'
      DataSource = DsProcesso
      ReadOnly = True
      TabOrder = 1
    end
    object DBEditNomeProcesso: TDBEdit
      Left = 200
      Top = 13
      Width = 299
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Name'
      DataSource = DsProcesso
      TabOrder = 2
    end
    object DBEditDescription: TDBEdit
      Left = 81
      Top = 40
      Width = 532
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Description'
      DataSource = DsProcesso
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 81
    Width = 629
    Height = 465
    Align = alClient
    TabOrder = 1
    object GroupBoxInputs: TGroupBox
      Left = 1
      Top = 1
      Width = 627
      Height = 264
      Align = alClient
      Caption = 'Par'#226'metros da Consulta'
      TabOrder = 0
      object ScrollBoxParametros: TScrollBox
        Left = 2
        Top = 15
        Width = 623
        Height = 247
        Align = alClient
        BevelEdges = []
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        TabOrder = 0
      end
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 352
      Width = 627
      Height = 112
      Align = alBottom
      Caption = 'Outputs'
      TabOrder = 1
      object cxGrid1: TcxGrid
        Left = 2
        Top = 15
        Width = 623
        Height = 95
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = DsParametros
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
    object GroupBox2: TGroupBox
      Left = 1
      Top = 265
      Width = 627
      Height = 87
      Align = alBottom
      Caption = 'Arquivos para Exporta'#231#227'o'
      TabOrder = 2
      object GridArquivos: TcxGrid
        Left = 2
        Top = 15
        Width = 623
        Height = 70
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView2: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Enabled = False
          Navigator.Buttons.First.Visible = False
          Navigator.Buttons.PriorPage.Visible = False
          Navigator.Buttons.Prior.Visible = False
          Navigator.Buttons.Next.Visible = False
          Navigator.Buttons.NextPage.Visible = False
          Navigator.Buttons.Last.Enabled = False
          Navigator.Buttons.Last.Visible = False
          Navigator.Buttons.Insert.Enabled = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Visible = True
          Navigator.Buttons.Delete.Visible = True
          Navigator.Buttons.Edit.Enabled = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Enabled = False
          Navigator.Buttons.Refresh.Visible = False
          Navigator.Buttons.SaveBookmark.Visible = False
          Navigator.Buttons.GotoBookmark.Enabled = False
          Navigator.Buttons.GotoBookmark.Visible = False
          Navigator.Buttons.Filter.Enabled = False
          Navigator.Buttons.Filter.Visible = False
          Navigator.Visible = True
          DataController.DataSource = DsArquivosExport
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          object cxGridDBTableView2Description: TcxGridDBColumn
            DataBinding.FieldName = 'Description'
            Width = 113
          end
          object cxGridDBTableView2Visualizacao: TcxGridDBColumn
            DataBinding.FieldName = 'Visualizacao'
            Width = 168
          end
          object cxGridDBTableView2TipoVisualizacao: TcxGridDBColumn
            DataBinding.FieldName = 'TipoVisualizacao'
            Width = 138
          end
          object cxGridDBTableView2NomeArquivo: TcxGridDBColumn
            DataBinding.FieldName = 'NomeArquivo'
            Width = 195
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridDBTableView2
        end
      end
    end
  end
  object DsProcesso: TDataSource
    DataSet = TblProcesso
    Left = 427
    Top = 18
  end
  object QryParametros: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select *'
      'from cons.Parametros'
      'where Consulta = :IDConsulta'
      '')
    Left = 457
    Top = 285
    ParamData = <
      item
        Name = 'IDCONSULTA'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end>
    object QryParametrosID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryParametrosConsulta: TIntegerField
      FieldName = 'Consulta'
      Origin = 'Consulta'
    end
    object QryParametrosNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 255
    end
    object QryParametrosDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 255
    end
    object QryParametrosTipo: TIntegerField
      FieldName = 'Tipo'
      Origin = 'Tipo'
    end
    object QryParametrosSql: TMemoField
      FieldName = 'Sql'
      Origin = 'Sql'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryParametrosOrdem: TIntegerField
      FieldName = 'Ordem'
      Origin = 'Ordem'
    end
    object QryParametrosTamanho: TIntegerField
      FieldName = 'Tamanho'
      Origin = 'Tamanho'
    end
    object QryParametrosObrigatorio: TBooleanField
      FieldName = 'Obrigatorio'
      Origin = 'Obrigatorio'
    end
    object QryParametrosValorPadrao: TMemoField
      FieldName = 'ValorPadrao'
      Origin = 'ValorPadrao'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object DsParametros: TDataSource
    AutoEdit = False
    DataSet = QryParametros
    Left = 537
    Top = 285
  end
  object QryOutputs: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select *'
      'from cons.AvisoConsultaParametro'
      'where IDConsulta = :IDConsulta and IDAviso =:IDAviso'
      '')
    Left = 297
    Top = 421
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
  object DsOutputs: TDataSource
    AutoEdit = False
    DataSet = QryOutputs
    Left = 385
    Top = 421
  end
  object ArquivosExport: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 97
    Top = 386
    object ArquivosExportDescription: TStringField
      DisplayWidth = 50
      FieldName = 'Description'
      Size = 100
    end
    object ArquivosExportVisualizacao: TStringField
      DisplayWidth = 50
      FieldName = 'Visualizacao'
      Size = 100
    end
    object ArquivosExportTipoVisualizacao: TStringField
      DisplayWidth = 50
      FieldName = 'TipoVisualizacao'
      Size = 255
    end
    object ArquivosExportNomeArquivo: TStringField
      DisplayWidth = 50
      FieldName = 'NomeArquivo'
      Size = 255
    end
  end
  object DsArquivosExport: TDataSource
    AutoEdit = False
    DataSet = ArquivosExport
    Left = 187
    Top = 386
  end
  object TblProcesso: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 345
    Top = 18
    object TblProcessoID: TIntegerField
      FieldName = 'ID'
    end
    object TblProcessoIDActivity: TIntegerField
      FieldName = 'IDActivity'
      Origin = 'IDActivity'
    end
    object TblProcessoName: TMemoField
      FieldName = 'Name'
      Origin = 'Name'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TblProcessoDescription: TMemoField
      FieldName = 'Description'
      Origin = 'Description'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TblProcessoClassName: TMemoField
      FieldName = 'ClassName'
      Origin = 'ClassName'
      BlobType = ftMemo
      Size = 2147483647
    end
    object TblProcessoExecutorClass: TMemoField
      FieldName = 'ExecutorClass'
      Origin = 'ExecutorClass'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
end
