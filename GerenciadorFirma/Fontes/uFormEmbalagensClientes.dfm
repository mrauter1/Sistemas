object FormEmbalagensClientes: TFormEmbalagensClientes
  Left = 0
  Top = 0
  Caption = 'Embalagens pendentes do cliente'
  ClientHeight = 422
  ClientWidth = 825
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
  object Panel1: TPanel
    Left = 0
    Top = 380
    Width = 825
    Height = 42
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 328
    ExplicitWidth = 753
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
    end
  end
  object TPanel
    Left = 0
    Top = 0
    Width = 825
    Height = 33
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 753
    object Label1: TLabel
      Left = 190
      Top = 10
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data Inicial'
    end
    object CheckBoxMostrarIgnorados: TCheckBox
      Left = 8
      Top = 8
      Width = 169
      Height = 17
      Caption = 'Mostrar Notas Ignoradas'
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
  end
  object cxGridEmbalagens: TcxGrid
    Left = 0
    Top = 33
    Width = 825
    Height = 347
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 753
    ExplicitHeight = 295
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
        Width = 44
      end
      object cxGridViewEmbalagensCIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'CIDADE'
        Visible = False
        Width = 105
      end
      object cxGridViewEmbalagensTOTPAGO: TcxGridDBColumn
        DataBinding.FieldName = 'TOTPAGO'
        Width = 58
      end
      object cxGridViewEmbalagensENTREGAPARCIAL: TcxGridDBColumn
        DataBinding.FieldName = 'ENTREGAPARCIAL'
        Width = 51
      end
      object cxGridViewEmbalagensCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
        Visible = False
        Width = 51
      end
      object cxGridViewEmbalagensAPRESENTACAO: TcxGridDBColumn
        DataBinding.FieldName = 'APRESENTACAO'
        Width = 206
      end
      object cxGridViewEmbalagensQUANTATENDIDA: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTATENDIDA'
        Width = 56
      end
      object cxGridViewEmbalagensVALTOTAL: TcxGridDBColumn
        DataBinding.FieldName = 'VALTOTAL'
        Width = 94
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
  object DsEmbalagensCli: TDataSource
    DataSet = QryEmbalagensCli
    Left = 376
    Top = 192
  end
  object QryEmbalagensCli: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT MCLIRECB.CHAVENF,'
      '       CASE WHEN MS.STATUS = 1 THEN '#39'ENVIADO'#39
      '            WHEN MS.STATUS = 2 THEN '#39'IGNORADO'#39
      '       ELSE '#39'N'#195'O ENVIADO'#39' END AS DESCSTATUS,'
      '       ISNULL(MS.STATUS,0) AS STATUS,'
      '       MP.CHAVENFPRO,'
      '       MCLIRECB.CODCLIENTE,'
      '       M.DATACOMPROVANTE,'
      '       MCLIRECB.DataVencimento,'
      '       M.NUMERO,'
      '       M.SERIE,'
      '       C.RAZAOSOCIAL,       '
      '       C.CIDADE,'
      '       IsNull(PAGO.TOTPAGO,0) as TOTPAGO,'
      '       CASE WHEN PAGO.TOTPAGO > 0 THEN '
      '       '#9#9#39'SIM'#39
      '       ELSE '#39'N'#195'O'#39'     '
      '       END AS EntregaParcial,'
      '       P.CODPRODUTO,'
      '       P.APRESENTACAO,'
      '       MP.QUANTATENDIDA,'
      '       MP.VALTOTAL'
      'FROM MCLIRECB MCLIRECB'
      'INNER JOIN MCLI M ON M.CHAVENF = MCLIRECB.CHAVENF'
      'LEFT JOIN (SELECT PAGO.CHAVENF, SUM(PAGO.TOTNOTA) AS TOTPAGO'
      
        ' '#9#9'   FROM MCLIPAGO PAGO GROUP BY PAGO.CHAVENF) PAGO ON PAGO.CHA' +
        'VENF = MCLIRECB.CHAVENF'
      'LEFT JOIN MCLIPRO MP ON MP.CHAVENF = MCLIRECB.CHAVENF'
      'LEFT JOIN PRODUTO P ON P.CODPRODUTO = MP.CODPRODUTO'
      'LEFT JOIN CLIENTE C ON C.CODCLIENTE = MCLIRECB.CODCLIENTE'
      'LEFT JOIN MCLIPROSTATUSRECB MS ON MS.CHAVENFPRO = MP.CHAVENFPRO'
      'WHERE '
      '     MCLIRECB.CODCOMPROVANTE IN ('#39'014'#39')'
      '     AND MCLIRECB.DATACOMPROVANTE >= :DataIni'
      '     AND C.CODCLIENTE = :CODCLIENTE'
      '     /*Ignorados*/'
      
        'ORDER BY m.datacomprovante desc, C.RAZAOSOCIAL, MCLIRECB.TOTNOTA' +
        ' desc, MP.QUANTATENDIDA desc')
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
    object QryEmbalagensCliTOTPAGO: TFMTBCDField
      DisplayLabel = 'Tot. Devolvido'
      FieldName = 'TOTPAGO'
      Origin = 'TOTPAGO'
      ReadOnly = True
      currency = True
      Precision = 38
      Size = 2
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
      DisplayLabel = 'Quant.'
      FieldName = 'QUANTATENDIDA'
      Origin = 'QUANTATENDIDA'
      Precision = 18
    end
    object QryEmbalagensCliVALTOTAL: TBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'VALTOTAL'
      Origin = 'VALTOTAL'
      currency = True
      Precision = 18
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
    Left = 712
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
end
