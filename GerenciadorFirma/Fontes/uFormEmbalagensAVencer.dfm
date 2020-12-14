object FormEmbalagensAVencer: TFormEmbalagensAVencer
  Left = 0
  Top = 0
  Caption = 'Embalagens pendentes do cliente'
  ClientHeight = 462
  ClientWidth = 866
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
    Width = 866
    Height = 65
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 903
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
    Width = 866
    Height = 397
    Align = alClient
    TabOrder = 1
    ExplicitTop = 62
    ExplicitWidth = 903
    object cxGridViewEmbalagens: TcxGridDBTableView
      PopupMenu = PopupMenu
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DSAVencer
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
      object cxGridViewEmbalagensSATUSAVENCER: TcxGridDBColumn
        DataBinding.FieldName = 'SATUSAVENCER'
        Width = 46
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
        Width = 144
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
        Visible = False
        Width = 58
      end
      object cxGridViewEmbalagensValorPendente: TcxGridDBColumn
        DataBinding.FieldName = 'ValorPendente'
        Width = 57
      end
      object cxGridViewEmbalagensstatus: TcxGridDBColumn
        DataBinding.FieldName = 'status'
        Visible = False
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
      '  Identificador = :Identificador')
    Left = 224
    Top = 364
    ParamData = <
      item
        Name = 'IDENTIFICADOR'
        ParamType = ptInput
      end>
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
    object QryTextoEmailAssinatura: TMemoField
      FieldName = 'Assinatura'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryTextoEmailCorpo: TMemoField
      FieldName = 'Corpo'
      Origin = 'Corpo'
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
  object QryAVencer: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      
        'SELECT *, DateDiff(Day, getdate(), DataVencimento) as DiasParaVe' +
        'ncimento,'
      'CASE WHEN ENVIADOAVENCER=1 THEN '#39'ENVIADO'#39
      #9' WHEN ISNULL(STATUS,0) = 2 THEN '#39'IGNORADO'#39
      #9' ELSE '#39'N'#195'O ENVIADO'#39' END AS SATUSAVENCER'
      'from vwEmbalagemPendente'
      'where'
      '  CodCliente = :CodCliente and'
      '  DataVencimento <= :DataFim'
      '     /*Ignorados*/'
      
        'ORDER BY DataVencimento desc, RAZAOSOCIAL, ValTotal desc, QUANTA' +
        'TENDIDA desc')
    Left = 152
    Top = 216
    ParamData = <
      item
        Name = 'CODCLIENTE'
        DataType = ftWideString
        ParamType = ptInput
        Value = '000601'
      end
      item
        Name = 'DATAFIM'
        DataType = ftDate
        FDDataType = dtDate
        ParamType = ptInput
        Value = '2020/10/27'
      end>
    object QryAVencerSATUSAVENCER: TStringField
      DisplayLabel = 'Status'
      FieldName = 'SATUSAVENCER'
      Origin = 'SATUSAVENCER'
      ReadOnly = True
      Required = True
      Size = 11
    end
    object QryAVencerchavenfpro: TStringField
      FieldName = 'chavenfpro'
      Origin = 'chavenfpro'
      Required = True
      FixedChar = True
      Size = 21
    end
    object QryAVencerDESCSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'DESCSTATUS'
      Origin = 'DESCSTATUS'
      ReadOnly = True
      Required = True
      Size = 11
    end
    object QryAVencercodcliente: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'codcliente'
      Origin = 'codcliente'
      Required = True
      Visible = False
      FixedChar = True
      Size = 6
    end
    object QryAVencerstatus: TIntegerField
      FieldName = 'status'
      Origin = 'status'
    end
    object QryAVencerRAZAOSOCIAL: TStringField
      DisplayLabel = 'Nome Cliente'
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Visible = False
      Size = 80
    end
    object QryAVencerCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Visible = False
      FixedChar = True
      Size = 35
    end
    object QryAVencerdatacomprovante: TDateField
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'datacomprovante'
      Origin = 'datacomprovante'
    end
    object QryAVencerDataVencimento: TDateField
      DisplayLabel = 'Data Vencimento'
      FieldName = 'DataVencimento'
      Origin = 'DataVencimento'
    end
    object QryAVencernumero: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'numero'
      Origin = 'numero'
      FixedChar = True
      Size = 6
    end
    object QryAVencerserie: TStringField
      DisplayLabel = 'S'#233'rie'
      FieldName = 'serie'
      Origin = 'serie'
      FixedChar = True
      Size = 4
    end
    object QryAVencercodproduto: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'codproduto'
      Origin = 'codproduto'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryAVencerapresentacao: TStringField
      DisplayLabel = 'Embalagem'
      FieldName = 'apresentacao'
      Origin = 'apresentacao'
      Size = 80
    end
    object QryAVencerQuantAtendida: TBCDField
      DisplayLabel = 'Qtd. Total'
      FieldName = 'QuantAtendida'
      Origin = 'QuantAtendida'
      Precision = 18
    end
    object QryAVencerCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Origin = 'CHAVENF'
      Required = True
      Visible = False
      FixedChar = True
      Size = 15
    end
    object QryAVencerTOTPAGO: TFMTBCDField
      DisplayLabel = 'Valor Devolvido'
      DisplayWidth = 19
      FieldName = 'TOTPAGO'
      Origin = 'TOTPAGO'
      ReadOnly = True
      currency = True
      Precision = 38
      Size = 2
    end
    object QryAVencerVALTOTAL: TBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'VALTOTAL'
      Origin = 'VALTOTAL'
      currency = True
      Precision = 18
    end
    object QryAVencerEntregaParcial: TStringField
      DisplayLabel = 'Entrega Parcial'
      FieldName = 'EntregaParcial'
      Origin = 'EntregaParcial'
      ReadOnly = True
      Required = True
      Size = 3
    end
    object QryAVencerVALUNIDADE: TFMTBCDField
      FieldName = 'VALUNIDADE'
      Visible = False
      Precision = 38
      Size = 20
    end
    object QryAVencerQuantDevolvida: TFMTBCDField
      DisplayLabel = 'Qtd. Devolvida'
      FieldName = 'QuantDevolvida'
      ReadOnly = True
      Precision = 38
      Size = 6
    end
    object QryAVencerQuantPendente: TFMTBCDField
      DisplayLabel = 'Qtd. Pendente'
      FieldName = 'QuantPendente'
      Origin = 'QuantPendente'
      ReadOnly = True
      Precision = 38
      Size = 6
    end
    object QryAVencerValorPendente: TFMTBCDField
      DisplayLabel = 'Valor Pendente'
      FieldName = 'ValorPendente'
      Origin = 'ValorPendente'
      ReadOnly = True
      currency = True
      Precision = 38
      Size = 6
    end
    object QryAVencerDiasParaVencimento: TIntegerField
      DisplayLabel = 'Dias Para o Vencimento'
      FieldName = 'DiasParaVencimento'
      Origin = 'DiasParaVencimento'
      ReadOnly = True
    end
    object QryAVencerENVIADOAVENCER: TBooleanField
      FieldName = 'ENVIADOAVENCER'
      Origin = 'ENVIADOAVENCER'
      Required = True
    end
  end
  object DSAVencer: TDataSource
    DataSet = QryAVencer
    Left = 232
    Top = 216
  end
end
