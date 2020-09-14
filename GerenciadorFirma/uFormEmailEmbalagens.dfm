object FormGravaEmbalagens: TFormGravaEmbalagens
  Left = 0
  Top = 0
  Caption = 'Email de embalagens para os clientes'
  ClientHeight = 529
  ClientWidth = 955
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 955
    Height = 65
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 946
    object Label1: TLabel
      Left = 214
      Top = 41
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 427
      Top = 41
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data Final'
    end
    object Label3: TLabel
      Left = 234
      Top = 14
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cliente'
    end
    object BtnAtualizar: TButton
      Left = 632
      Top = 35
      Width = 75
      Height = 25
      Caption = 'Atualizar'
      TabOrder = 0
      OnClick = BtnAtualizarClick
    end
    object DataIniPicker: TDateTimePicker
      Left = 273
      Top = 38
      Width = 112
      Height = 21
      Date = 44071.444021122680000000
      Time = 44071.444021122680000000
      TabOrder = 1
    end
    object DataFimPicker: TDateTimePicker
      Left = 481
      Top = 38
      Width = 107
      Height = 21
      Date = 44071.444021122680000000
      Time = 44071.444021122680000000
      TabOrder = 2
    end
    object CheckBoxMostrarIgnorados: TCheckBox
      Left = 16
      Top = 42
      Width = 169
      Height = 17
      Caption = 'Mostrar Embalagens Ignoradas'
      TabOrder = 3
      OnClick = CheckBoxMostrarIgnoradosClick
    end
    object EditCliente: TEdit
      Left = 273
      Top = 11
      Width = 315
      Height = 21
      TabOrder = 4
      OnKeyDown = EditClienteKeyDown
    end
    object CheckBoxMostrarEnviados: TCheckBox
      Left = 16
      Top = 15
      Width = 169
      Height = 17
      Caption = 'Mostrar Embalagens Enviadas'
      TabOrder = 5
      OnClick = CheckBoxMostrarIgnoradosClick
    end
    object BtnEnviarEmail: TButton
      Left = 728
      Top = 35
      Width = 75
      Height = 25
      Caption = 'Enviar Email'
      TabOrder = 6
      OnClick = BtnEnviarEmailClick
    end
    object BtnOpcoes: TButton
      Left = 632
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Op'#231#245'es'
      TabOrder = 7
      OnClick = BtnOpcoesClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 955
    Height = 422
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    ExplicitWidth = 946
    ExplicitHeight = 402
    object cxGridEmbalagens: TcxGrid
      Left = 1
      Top = 1
      Width = 953
      Height = 420
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitHeight = 400
      object cxGridViewClientes: TcxGridDBTableView
        PopupMenu = PopupMenu
        Navigator.Buttons.CustomButtons = <>
        OnCellClick = cxGridViewClientesCellClick
        DataController.DataSource = DsEmbalagens
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.Visible = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.HeaderAutoHeight = True
        Styles.OnGetContentStyle = cxGridViewClientesStylesGetContentStyle
        Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
        object cxGridViewClientesSelecionado: TcxGridDBColumn
          DataBinding.FieldName = 'Selecionado'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Width = 26
        end
        object cxGridViewClientesDESCSTATUS: TcxGridDBColumn
          DataBinding.FieldName = 'DESCSTATUS'
          Width = 83
        end
        object cxGridViewClientesstatus: TcxGridDBColumn
          DataBinding.FieldName = 'status'
          Visible = False
        end
        object cxGridViewClientesCODCLIENTE: TcxGridDBColumn
          DataBinding.FieldName = 'CODCLIENTE'
          Visible = False
          Width = 59
        end
        object cxGridViewClientesRAZAOSOCIAL: TcxGridDBColumn
          DataBinding.FieldName = 'RAZAOSOCIAL'
          Width = 158
        end
        object cxGridViewClientesCIDADE: TcxGridDBColumn
          DataBinding.FieldName = 'CIDADE'
          Width = 83
        end
        object cxGridViewClientesdatacomprovante: TcxGridDBColumn
          DataBinding.FieldName = 'datacomprovante'
          Width = 73
        end
        object cxGridViewClienteschavenfpro: TcxGridDBColumn
          DataBinding.FieldName = 'chavenfpro'
          Visible = False
        end
        object cxGridViewClientesnumero: TcxGridDBColumn
          DataBinding.FieldName = 'numero'
          Width = 43
        end
        object cxGridViewClientesserie: TcxGridDBColumn
          DataBinding.FieldName = 'serie'
          Width = 33
        end
        object cxGridViewClientescodproduto: TcxGridDBColumn
          DataBinding.FieldName = 'codproduto'
          Visible = False
          Width = 49
        end
        object cxGridViewClientesapresentacao: TcxGridDBColumn
          DataBinding.FieldName = 'apresentacao'
          Width = 121
        end
        object cxGridViewClientesQuantPendente: TcxGridDBColumn
          DataBinding.FieldName = 'QuantPendente'
          Width = 56
        end
        object cxGridViewClientesQuantDevolvida: TcxGridDBColumn
          DataBinding.FieldName = 'QuantDevolvida'
          Width = 55
        end
        object cxGridViewClientesTOTPAGO: TcxGridDBColumn
          DataBinding.FieldName = 'TOTPAGO'
          Visible = False
          Width = 70
        end
        object cxGridViewClientesVALTOTAL: TcxGridDBColumn
          DataBinding.FieldName = 'VALTOTAL'
          Visible = False
          Width = 59
        end
        object cxGridViewClientesEntregaParcial: TcxGridDBColumn
          DataBinding.FieldName = 'EntregaParcial'
          Visible = False
          Width = 62
        end
        object cxGridViewClientesCHAVENF: TcxGridDBColumn
          DataBinding.FieldName = 'CHAVENF'
          Visible = False
        end
        object cxGridViewClientesVALUNIDADE: TcxGridDBColumn
          DataBinding.FieldName = 'VALUNIDADE'
          Visible = False
        end
        object cxGridViewClientesQuantAtendida: TcxGridDBColumn
          DataBinding.FieldName = 'QuantAtendida'
          Width = 47
        end
      end
      object cxGridEmbalagensDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DetailKeyFieldNames = 'CODPRODUTO'
        DataController.KeyFieldNames = 'CODPRODUTO'
        DataController.MasterKeyFieldNames = 'CODPRODUTO'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      end
      object cxGridEmbalagensDBTableView2: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Visible = fvNever
        DataController.DataSource = DsEmbalagens
        DataController.DetailKeyFieldNames = 'codcliente'
        DataController.KeyFieldNames = 'codcliente'
        DataController.MasterKeyFieldNames = 'CODCLIENTE'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        object cxGridEmbalagensDBTableView2Selecionado: TcxGridDBColumn
          DataBinding.FieldName = 'Selecionado'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Width = 41
        end
        object cxGridEmbalagensDBTableView2chavenfpro: TcxGridDBColumn
          DataBinding.FieldName = 'chavenfpro'
        end
        object cxGridEmbalagensDBTableView2codcliente: TcxGridDBColumn
          DataBinding.FieldName = 'codcliente'
          Visible = False
          Options.Editing = False
        end
        object cxGridEmbalagensDBTableView2numero: TcxGridDBColumn
          DataBinding.FieldName = 'numero'
          Options.Editing = False
          Width = 62
        end
        object cxGridEmbalagensDBTableView2serie: TcxGridDBColumn
          DataBinding.FieldName = 'serie'
          Options.Editing = False
          Width = 49
        end
        object cxGridEmbalagensDBTableView2datacomprovante: TcxGridDBColumn
          Caption = 'Data Nota'
          DataBinding.FieldName = 'datacomprovante'
          Options.Editing = False
          Width = 90
        end
        object cxGridEmbalagensDBTableView2codproduto: TcxGridDBColumn
          DataBinding.FieldName = 'codproduto'
          Options.Editing = False
          Width = 62
        end
        object cxGridEmbalagensDBTableView2apresentacao: TcxGridDBColumn
          DataBinding.FieldName = 'apresentacao'
          Options.Editing = False
          Width = 196
        end
        object cxGridEmbalagensDBTableView2NOMECLIENTE: TcxGridDBColumn
          DataBinding.FieldName = 'NOMECLIENTE'
          Visible = False
          Options.Editing = False
        end
      end
      object cxGridClientesLevel: TcxGridLevel
        GridView = cxGridViewClientes
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 487
    Width = 955
    Height = 42
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 1
    ExplicitTop = 472
    object BtnSeleciona: TBitBtn
      Left = 8
      Top = 6
      Width = 49
      Height = 27
      Caption = '[V]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BtnSelecionaClick
    end
  end
  object QryEmbalagens: TFDQuery
    AfterClose = QryEmbalagensAfterClose
    AfterPost = QryEmbalagensAfterPost
    OnCalcFields = QryEmbalagensCalcFields
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT *'
      'from vwEmbalagemPendente'
      'where'
      '  DATACOMPROVANTE between :DataIni and :DataFim'
      '     /*Ignorados*/'
      '     /*Cliente*/'
      
        'ORDER BY datacomprovante desc, RAZAOSOCIAL, ValTotal desc, QUANT' +
        'ATENDIDA desc')
    Left = 272
    Top = 288
    ParamData = <
      item
        Name = 'DATAINI'
        DataType = ftDate
        ParamType = ptInput
        Value = '28/08/2020'
      end
      item
        Name = 'DATAFIM'
        DataType = ftDate
        ParamType = ptInput
        Value = '28/08/2020'
      end>
    object QryEmbalagensSelecionado: TBooleanField
      DisplayLabel = 'Sel'
      FieldKind = fkCalculated
      FieldName = 'Selecionado'
      Calculated = True
    end
    object QryEmbalagensDESCSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'DESCSTATUS'
      Origin = 'DESCSTATUS'
      ReadOnly = True
      Required = True
      Size = 11
    end
    object QryEmbalagenscodcliente: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'codcliente'
      Origin = 'codcliente'
      Required = True
      Visible = False
      FixedChar = True
      Size = 6
    end
    object QryEmbalagensstatus: TIntegerField
      FieldName = 'status'
      Origin = 'status'
    end
    object QryEmbalagensRAZAOSOCIAL: TStringField
      DisplayLabel = 'Nome Cliente'
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Visible = False
      Size = 80
    end
    object QryEmbalagensCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Visible = False
      FixedChar = True
      Size = 35
    end
    object QryEmbalagenschavenfpro: TStringField
      FieldName = 'chavenfpro'
      Origin = 'chavenfpro'
      Required = True
      FixedChar = True
      Size = 21
    end
    object QryEmbalagensdatacomprovante: TDateField
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'datacomprovante'
      Origin = 'datacomprovante'
    end
    object QryEmbalagensnumero: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'numero'
      Origin = 'numero'
      FixedChar = True
      Size = 6
    end
    object QryEmbalagensserie: TStringField
      DisplayLabel = 'S'#233'rie'
      FieldName = 'serie'
      Origin = 'serie'
      FixedChar = True
      Size = 4
    end
    object QryEmbalagenscodproduto: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'codproduto'
      Origin = 'codproduto'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryEmbalagensapresentacao: TStringField
      DisplayLabel = 'Embalagem'
      FieldName = 'apresentacao'
      Origin = 'apresentacao'
      Size = 80
    end
    object QryEmbalagensQuantAtendida: TBCDField
      DisplayLabel = 'Qtd. Total'
      FieldName = 'QuantAtendida'
      Origin = 'QuantAtendida'
      Precision = 18
    end
    object QryEmbalagensCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Origin = 'CHAVENF'
      Required = True
      Visible = False
      FixedChar = True
      Size = 15
    end
    object QryEmbalagensTOTPAGO: TFMTBCDField
      DisplayLabel = 'Valor Devolvido'
      DisplayWidth = 19
      FieldName = 'TOTPAGO'
      Origin = 'TOTPAGO'
      ReadOnly = True
      currency = True
      Precision = 38
      Size = 2
    end
    object QryEmbalagensVALTOTAL: TBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'VALTOTAL'
      Origin = 'VALTOTAL'
      currency = True
      Precision = 18
    end
    object QryEmbalagensEntregaParcial: TStringField
      DisplayLabel = 'Entrega Parcial'
      FieldName = 'EntregaParcial'
      Origin = 'EntregaParcial'
      ReadOnly = True
      Required = True
      Size = 3
    end
    object QryEmbalagensVALUNIDADE: TFMTBCDField
      FieldName = 'VALUNIDADE'
      Visible = False
      Precision = 38
      Size = 20
    end
    object QryEmbalagensQuantDevolvida: TFMTBCDField
      DisplayLabel = 'Qtd. Devolvida'
      FieldName = 'QuantDevolvida'
      ReadOnly = True
      Precision = 38
      Size = 6
    end
    object QryEmbalagensQuantPendente: TFMTBCDField
      DisplayLabel = 'Qtd. Pendente'
      FieldName = 'QuantPendente'
      Origin = 'QuantPendente'
      ReadOnly = True
      Precision = 38
      Size = 6
    end
  end
  object DsEmbalagens: TDataSource
    DataSet = QryEmbalagens
    Left = 360
    Top = 288
  end
  object PopupMenu: TPopupMenu
    OnPopup = PopupMenuPopup
    Left = 496
    Top = 248
    object EmbalagensCli1: TMenuItem
      Caption = 'Abrir Embalagens do Cliente'
      OnClick = EmbalagensCli1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object IgnorarEmbalagem1: TMenuItem
      Caption = 'Ignorar Embalagem'
      OnClick = IgnorarEmbalagem1Click
    end
    object DeixardeIgnorarEmbalagem1: TMenuItem
      Caption = 'Deixar de Ignorar Embalagem'
      OnClick = DeixardeIgnorarEmbalagem1Click
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 512
    Top = 8
    PixelsPerInch = 96
    object cxStyleVermelho: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 2105599
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxStyleAmarelo: TcxStyle
      AssignedValues = [svColor]
      Color = clYellow
    end
  end
  object PopupOpcoes: TPopupMenu
    Left = 328
    Top = 201
    object ConfiguarEmaildeEnvio1: TMenuItem
      Caption = 'Configuar Email de Envio'
      OnClick = ConfiguarEmaildeEnvio1Click
    end
    object ConfigurarTextodoEmail1: TMenuItem
      Caption = 'Configurar Texto do Email'
      OnClick = ConfigurarTextodoEmail1Click
    end
  end
end
