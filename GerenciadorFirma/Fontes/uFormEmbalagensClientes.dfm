object FormEmbalagensClientes: TFormEmbalagensClientes
  Left = 0
  Top = 0
  Caption = 'Embalagens pendentes do cliente'
  ClientHeight = 422
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 833
    Height = 65
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -8
    ExplicitTop = -6
    object Label1: TLabel
      Left = 190
      Top = 10
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 28
      Top = 35
      Width = 215
      Height = 13
      Alignment = taRightJustify
      Caption = 'Emails para envio de lembrete de embalagem'
    end
    object CheckBoxMostrarIgnorados: TCheckBox
      Left = 14
      Top = 8
      Width = 169
      Height = 17
      Caption = 'Mostrar Embalagens Ignoradas'
      TabOrder = 0
      OnClick = CheckBoxMostrarIgnoradosClick
    end
    object DataIniPicker: TDateTimePicker
      Left = 249
      Top = 6
      Width = 112
      Height = 21
      Date = 42736.444021122680000000
      Time = 42736.444021122680000000
      TabOrder = 1
    end
    object BtnAtualizar: TButton
      Left = 488
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Atualizar'
      TabOrder = 2
      OnClick = BtnAtualizarClick
    end
    object BtnEnviarEmail: TButton
      Left = 600
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Enviar Email'
      TabOrder = 3
      OnClick = BtnEnviarEmailClick
    end
    object EditEmails: TEdit
      Left = 249
      Top = 33
      Width = 345
      Height = 21
      TabOrder = 4
    end
  end
  object cxGridEmbalagens: TcxGrid
    Left = 0
    Top = 65
    Width = 833
    Height = 357
    Align = alClient
    TabOrder = 1
    ExplicitTop = 62
    object cxGridViewEmbalagens: TcxGridDBTableView
      PopupMenu = PopupMenu
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DsEmbalagensCli
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
      object cxGridViewEmbalagensDESCSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'DESCSTATUS'
      end
      object cxGridViewEmbalagensSTATUS: TcxGridDBColumn
        DataBinding.FieldName = 'STATUS'
        Visible = False
      end
      object cxGridViewEmbalagensCHAVENF: TcxGridDBColumn
        DataBinding.FieldName = 'CHAVENF'
        Visible = False
      end
      object cxGridViewEmbalagensCHAVENFPRO: TcxGridDBColumn
        DataBinding.FieldName = 'CHAVENFPRO'
        Visible = False
      end
      object cxGridViewEmbalagensCODCLIENTE: TcxGridDBColumn
        DataBinding.FieldName = 'CODCLIENTE'
        Visible = False
      end
      object cxGridViewEmbalagensRAZAOSOCIAL: TcxGridDBColumn
        DataBinding.FieldName = 'RAZAOSOCIAL'
        Visible = False
        Width = 206
      end
      object cxGridViewEmbalagensDATACOMPROVANTE: TcxGridDBColumn
        DataBinding.FieldName = 'DATACOMPROVANTE'
        Width = 87
      end
      object cxGridViewEmbalagensDataVencimento: TcxGridDBColumn
        DataBinding.FieldName = 'DataVencimento'
      end
      object cxGridViewEmbalagensNUMERO: TcxGridDBColumn
        DataBinding.FieldName = 'NUMERO'
        Width = 56
      end
      object cxGridViewEmbalagensSERIE: TcxGridDBColumn
        DataBinding.FieldName = 'SERIE'
        Width = 34
      end
      object cxGridViewEmbalagensCIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'CIDADE'
        Visible = False
        Width = 105
      end
      object cxGridViewEmbalagensCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
        Visible = False
        Width = 51
      end
      object cxGridViewEmbalagensAPRESENTACAO: TcxGridDBColumn
        DataBinding.FieldName = 'APRESENTACAO'
        Width = 163
      end
      object cxGridViewEmbalagensENTREGAPARCIAL: TcxGridDBColumn
        DataBinding.FieldName = 'ENTREGAPARCIAL'
        Width = 51
      end
      object cxGridViewEmbalagensQuantPendente: TcxGridDBColumn
        DataBinding.FieldName = 'QuantPendente'
        Width = 55
      end
      object cxGridViewEmbalagensQuantDevolvida: TcxGridDBColumn
        DataBinding.FieldName = 'QuantDevolvida'
        Width = 55
      end
      object cxGridViewEmbalagensQUANTATENDIDA: TcxGridDBColumn
        Caption = 'Qtd. Total'
        DataBinding.FieldName = 'QUANTATENDIDA'
        Width = 49
      end
      object cxGridViewEmbalagensVALTOTAL: TcxGridDBColumn
        DataBinding.FieldName = 'VALTOTAL'
        Width = 71
      end
      object cxGridViewEmbalagensVALUNIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'VALUNIDADE'
        Visible = False
      end
      object cxGridViewEmbalagensTOTPAGO: TcxGridDBColumn
        DataBinding.FieldName = 'TOTPAGO'
        Width = 58
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
        Caption = 'Sel'
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
    object cxGridEmbalagensLevel: TcxGridLevel
      GridView = cxGridViewEmbalagens
    end
  end
  object BtnContatos: TButton
    Left = 600
    Top = 33
    Width = 75
    Height = 23
    Caption = 'Contatos'
    TabOrder = 2
    OnClick = BtnContatosClick
  end
  object DsEmbalagensCli: TDataSource
    DataSet = QryEmbalagensCli
    Left = 376
    Top = 192
  end
  object QryEmbalagensCli: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from vwEmbalagemPendente'
      'WHERE '
      '     DATACOMPROVANTE >= :DataIni'
      '     AND CODCLIENTE = :CODCLIENTE'
      '     /*Ignorados*/'
      
        'ORDER BY datacomprovante desc, RAZAOSOCIAL, ValTotal desc, QUANT' +
        'ATENDIDA desc')
    Left = 224
    Top = 192
    ParamData = <
      item
        Name = 'DATAINI'
        DataType = ftDate
        ParamType = ptInput
        Value = '2020-09-04'
      end
      item
        Name = 'CODCLIENTE'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 6
      end>
    object QryEmbalagensCliDESCSTATUS: TStringField
      DisplayLabel = 'Descri'#231#227'o Status'
      FieldName = 'DESCSTATUS'
      Origin = 'DESCSTATUS'
      ReadOnly = True
      Required = True
      Size = 11
    end
    object QryEmbalagensCliSTATUS: TIntegerField
      DisplayLabel = 'Status'
      FieldName = 'STATUS'
      Origin = 'STATUS'
      Visible = False
    end
    object QryEmbalagensCliCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Origin = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 15
    end
    object QryEmbalagensCliCHAVENFPRO: TStringField
      FieldName = 'CHAVENFPRO'
      Origin = 'CHAVENFPRO'
      FixedChar = True
      Size = 21
    end
    object QryEmbalagensCliCODCLIENTE: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'CODCLIENTE'
      Origin = 'CODCLIENTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryEmbalagensCliRAZAOSOCIAL: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Cliente'
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      ProviderFlags = []
      ReadOnly = True
      Size = 80
    end
    object QryEmbalagensCliDATACOMPROVANTE: TDateField
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'DATACOMPROVANTE'
      Origin = 'DATACOMPROVANTE'
    end
    object QryEmbalagensCliDataVencimento: TDateField
      DisplayLabel = 'Data Vencimento'
      FieldName = 'DataVencimento'
      Origin = 'DataVencimento'
    end
    object QryEmbalagensCliNUMERO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 6
    end
    object QryEmbalagensCliSERIE: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'S'#233'rie'
      FieldName = 'SERIE'
      Origin = 'SERIE'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 4
    end
    object QryEmbalagensCliCIDADE: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 35
    end
    object QryEmbalagensCliENTREGAPARCIAL: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Entrega Parcial'
      FieldName = 'ENTREGAPARCIAL'
      Origin = 'ENTREGAPARCIAL'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 3
    end
    object QryEmbalagensCliCODPRODUTO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Cod. Produto'
      FieldName = 'CODPRODUTO'
      Origin = 'CODPRODUTO'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 6
    end
    object QryEmbalagensCliAPRESENTACAO: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Embalagem'
      FieldName = 'APRESENTACAO'
      Origin = 'APRESENTACAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 80
    end
    object QryEmbalagensCliQUANTATENDIDA: TBCDField
      DisplayLabel = 'Qtd.'
      FieldName = 'QUANTATENDIDA'
      Origin = 'QUANTATENDIDA'
      Precision = 18
    end
    object QryEmbalagensCliQuantDevolvida: TFMTBCDField
      DisplayLabel = 'Qtd. Devolvida'
      FieldName = 'QuantDevolvida'
      Origin = 'QuantDevolvida'
      ReadOnly = True
      Precision = 38
      Size = 6
    end
    object QryEmbalagensCliVALTOTAL: TBCDField
      DisplayLabel = 'Val. Total'
      FieldName = 'VALTOTAL'
      Origin = 'VALTOTAL'
      currency = True
      Precision = 18
    end
    object QryEmbalagensCliTOTPAGO: TFMTBCDField
      DisplayLabel = 'Valor Devolvido'
      FieldName = 'TOTPAGO'
      Origin = 'TOTPAGO'
      ReadOnly = True
      currency = True
      Precision = 38
      Size = 2
    end
    object QryEmbalagensCliVALUNIDADE: TFMTBCDField
      FieldName = 'VALUNIDADE'
      Origin = 'VALUNIDADE'
      Visible = False
      Precision = 38
      Size = 20
    end
    object QryEmbalagensCliQuantPendente: TFMTBCDField
      DisplayLabel = 'Qtd. Pendente'
      FieldName = 'QuantPendente'
      Origin = 'QuantPendente'
      ReadOnly = True
      Precision = 38
      Size = 6
    end
  end
  object PopupMenu: TPopupMenu
    OnPopup = PopupMenuPopup
    Left = 552
    Top = 152
    object Ignorarembalagem1: TMenuItem
      Caption = 'Ignorar Embalagem'
      OnClick = Ignorarembalagem1Click
    end
    object DeixardeIgnorarEmbalagem1: TMenuItem
      Caption = 'Deixar de Ignorar Embalagem'
      OnClick = DeixardeIgnorarEmbalagem1Click
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 768
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
  object DsEmail: TDataSource
    DataSet = QryEmail
    Left = 288
    Top = 311
  end
  object QryEmail: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from EmailEmbalagem'
      'where'
      '  Identificador = '#39'EMBALAGEM'#39)
    Left = 224
    Top = 311
    object QryEmailIdentificador: TStringField
      FieldName = 'Identificador'
      Origin = 'Identificador'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 10
    end
    object QryEmailUsuario: TStringField
      FieldName = 'Usuario'
      Origin = 'Usuario'
      Size = 255
    end
    object QryEmailPassword: TStringField
      FieldName = 'Password'
      Origin = 'Password'
      Size = 255
    end
    object QryEmailSMTPServer: TStringField
      FieldName = 'SMTPServer'
      Origin = 'SMTPServer'
      Size = 255
    end
    object QryEmailPort: TIntegerField
      FieldName = 'Port'
      Origin = 'Port'
    end
    object QryEmailrequireAuth: TBooleanField
      FieldName = 'requireAuth'
      Origin = 'requireAuth'
    end
  end
  object DsTextoEmail: TDataSource
    DataSet = QryTextoEmail
    Left = 288
    Top = 364
  end
  object QryTextoEmail: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from ModeloEmailEmbalagem'
      'where'
      '  Identificador = '#39'EMBALAGEM'#39)
    Left = 224
    Top = 364
    object QryTextoEmailIdentificador: TStringField
      FieldName = 'Identificador'
      Required = True
      FixedChar = True
      Size = 10
    end
    object QryTextoEmailTitulo: TStringField
      FieldName = 'Titulo'
      FixedChar = True
      Size = 255
    end
    object QryTextoEmailIntroducao: TMemoField
      FieldName = 'Introducao'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryTextoEmailPoliticaDevolucao: TMemoField
      FieldName = 'PoliticaDevolucao'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryTextoEmailAssinatura: TMemoField
      FieldName = 'Assinatura'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object QryImagemEmail: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from ModeloEmailImagens'
      'where'
      '  Identificador = '#39'EMBALAGEM'#39)
    Left = 384
    Top = 359
    object QryImagemEmailidentificador: TStringField
      FieldName = 'identificador'
      Required = True
      FixedChar = True
      Size = 10
    end
    object QryImagemEmailIdImagem: TStringField
      DisplayLabel = 'Identificador'
      DisplayWidth = 10
      FieldName = 'IdImagem'
      Required = True
      Size = 255
    end
    object QryImagemEmailImagem: TBlobField
      FieldName = 'Imagem'
      Size = 2147483647
    end
    object QryImagemEmailext: TStringField
      DisplayLabel = 'Extens'#227'o'
      FieldName = 'ext'
      Origin = 'ext'
      Size = 255
    end
  end
  object DsImagemEmail: TDataSource
    AutoEdit = False
    DataSet = QryImagemEmail
    Left = 480
    Top = 359
  end
end
