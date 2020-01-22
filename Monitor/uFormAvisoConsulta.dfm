object FormAvisoConsulta: TFormAvisoConsulta
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio do Aviso'
  ClientHeight = 417
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
    Height = 69
    Align = alTop
    TabOrder = 0
    DesignSize = (
      611
      69)
    object Label2: TLabel
      Left = 47
      Top = 14
      Width = 57
      Height = 13
      Alignment = taRightJustify
      Caption = 'ID Relat'#243'rio'
    end
    object LblConsulta: TLabel
      Left = 110
      Top = 40
      Width = 50
      Height = 13
      Caption = '(Consulta)'
    end
    object BtnOK: TBitBtn
      Left = 485
      Top = 9
      Width = 108
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOKClick
    end
    object DBEditIDConsulta: TDBEdit
      Left = 110
      Top = 11
      Width = 83
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'IDConsulta'
      DataSource = DsAvisoConsulta
      ReadOnly = True
      TabOrder = 1
      OnChange = DBEditIDConsultaChange
    end
    object BtnSelecionarRelatorio: TBitBtn
      Left = 199
      Top = 9
      Width = 66
      Height = 25
      Caption = 'Selecionar'
      TabOrder = 2
      OnClick = BtnSelecionarRelatorioClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 69
    Width = 611
    Height = 348
    Align = alClient
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 1
      Top = 107
      Width = 609
      Height = 240
      Align = alClient
      Caption = 'Param'#234'tros'
      TabOrder = 0
      object cxGridParametros: TcxGrid
        Left = 2
        Top = 15
        Width = 605
        Height = 223
        Align = alClient
        TabOrder = 0
        object cxGridParametrosDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = DsPaametros
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
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 609
      Height = 106
      Align = alTop
      Caption = 'Configura'#231#245'es'
      TabOrder = 1
      DesignSize = (
        609
        106)
      object Label1: TLabel
        Left = 16
        Top = 25
        Width = 87
        Height = 13
        Alignment = taRightJustify
        Caption = 'T'#237'tulo do Relat'#243'rio'
      end
      object DBRadioPaginaPadrao: TDBRadioGroup
        Left = 109
        Top = 49
        Width = 460
        Height = 41
        Anchors = [akTop, akRight]
        Caption = 'Tipo de Visualiza'#231#227'o'
        Columns = 3
        DataField = 'TipoVisualizacao'
        DataSource = DsAvisoConsulta
        Items.Strings = (
          'Tabela'
          'Pivot'
          'Gr'#225'fico')
        TabOrder = 0
        Values.Strings = (
          '0'
          '1'
          '2')
      end
      object DBEditTitulo: TDBEdit
        Left = 109
        Top = 22
        Width = 460
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Titulo'
        DataSource = DsAvisoConsulta
        TabOrder = 1
      end
    end
  end
  object DsAvisoConsulta: TDataSource
    AutoEdit = False
    DataSet = QryAvisoConsulta
    Left = 425
    Top = 50
  end
  object QryAvisoConsulta: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select *'
      'from cons.AvisoConsulta'
      'where IDConsulta = :IDConsulta and IDAviso =:IDAviso'
      '')
    Left = 313
    Top = 50
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
  object QryParametros: TFDQuery
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
    object QryParametrosIDAviso: TIntegerField
      FieldName = 'IDAviso'
      Origin = 'IDAviso'
    end
    object QryParametrosIDConsulta: TIntegerField
      FieldName = 'IDConsulta'
      Origin = 'IDConsulta'
    end
    object QryParametrosIDParametro: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'IDParametro'
      Origin = 'IDParametro'
    end
    object QryParametrosValor: TMemoField
      FieldName = 'Valor'
      Origin = 'Valor'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object DsPaametros: TDataSource
    AutoEdit = False
    DataSet = QryParametros
    Left = 385
    Top = 218
  end
end
