object FormCadastroProcesso: TFormCadastroProcesso
  Left = 0
  Top = 0
  Caption = 'Configura'#231#227'o do Processo'
  ClientHeight = 426
  ClientWidth = 611
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 611
    Height = 105
    Align = alTop
    TabOrder = 0
    DesignSize = (
      611
      105)
    object Label2: TLabel
      Left = 77
      Top = 14
      Width = 11
      Height = 13
      Alignment = taRightJustify
      Caption = 'ID'
    end
    object Label3: TLabel
      Left = 167
      Top = 14
      Width = 27
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome'
    end
    object Label4: TLabel
      Left = 42
      Top = 42
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o'
    end
    object Label1: TLabel
      Left = 10
      Top = 69
      Width = 81
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tipo do Processo'
    end
    object BtnOK: TBitBtn
      Left = 487
      Top = 9
      Width = 108
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOKClick
    end
    object DBEditIDConsulta: TDBEdit
      Left = 97
      Top = 11
      Width = 62
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'IDAviso'
      DataSource = DsAvisoConsulta
      ReadOnly = True
      TabOrder = 1
      OnChange = DBEditIDConsultaChange
    end
    object DBEditNomeProcesso: TDBEdit
      Left = 200
      Top = 11
      Width = 281
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Titulo'
      DataSource = DsAvisoConsulta
      TabOrder = 2
    end
    object DBEdit1: TDBEdit
      Left = 97
      Top = 40
      Width = 498
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Titulo'
      DataSource = DsAvisoConsulta
      TabOrder = 3
    end
    object DBTipoProcesso: TDBComboBox
      Left = 97
      Top = 67
      Width = 297
      Height = 21
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 105
    Width = 611
    Height = 321
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 312
    object GroupBoxInputs: TGroupBox
      Left = 1
      Top = 1
      Width = 609
      Height = 159
      Align = alClient
      Caption = 'Inputs'
      TabOrder = 0
      ExplicitHeight = 196
      object cxGridParametros: TcxGrid
        Left = 2
        Top = 15
        Width = 605
        Height = 142
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 170
        object cxGridParametrosDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = DsInputs
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
      Top = 160
      Width = 609
      Height = 160
      Align = alBottom
      Caption = 'Outputs'
      TabOrder = 1
      object cxGrid1: TcxGrid
        Left = 2
        Top = 15
        Width = 605
        Height = 143
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 1
        object cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = DsInputs
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
  object DsAvisoConsulta: TDataSource
    AutoEdit = False
    DataSet = QryAvisoConsulta
    Left = 545
    Top = 130
  end
  object QryAvisoConsulta: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select *'
      'from cons.AvisoConsulta'
      'where IDConsulta = :IDConsulta and IDAviso =:IDAviso'
      '')
    Left = 433
    Top = 130
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
    object QryAvisoConsultaIDAviso: TIntegerField
      FieldName = 'IDAviso'
      Origin = 'IDAviso'
      Required = True
    end
    object QryAvisoConsultaIDConsulta: TIntegerField
      FieldName = 'IDConsulta'
      Origin = 'IDConsulta'
      Required = True
    end
    object QryAvisoConsultaTipoVisualizacao: TIntegerField
      FieldName = 'TipoVisualizacao'
      Origin = 'TipoVisualizacao'
    end
    object QryAvisoConsultaTitulo: TStringField
      FieldName = 'Titulo'
      Origin = 'Titulo'
      Size = 511
    end
  end
  object QryInputs: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select *'
      'from cons.AvisoConsultaParametro'
      'where IDConsulta = :IDConsulta and IDAviso =:IDAviso'
      '')
    Left = 273
    Top = 218
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
    Left = 385
    Top = 218
  end
  object QryOutputs: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select *'
      'from cons.AvisoConsultaParametro'
      'where IDConsulta = :IDConsulta and IDAviso =:IDAviso'
      '')
    Left = 265
    Top = 354
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
    Left = 377
    Top = 354
  end
end
