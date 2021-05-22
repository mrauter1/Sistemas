object FormAjustaInconsistencias: TFormAjustaInconsistencias
  Left = 0
  Top = 0
  Caption = 'Ajustar inconsist'#234'ncias embalagens'
  ClientHeight = 349
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 678
    Height = 75
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 33
      Height = 13
      Caption = 'Cliente'
    end
    object Label2: TLabel
      Left = 224
      Top = 27
      Width = 74
      Height = 13
      Caption = 'Valor Devolvido'
    end
    object Label3: TLabel
      Left = 16
      Top = 27
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object Label4: TLabel
      Left = 360
      Top = 8
      Width = 57
      Height = 13
      Caption = 'N'#250'mero NF:'
    end
    object Label5: TLabel
      Left = 408
      Top = 27
      Width = 73
      Height = 13
      Caption = 'Valor Pendente'
    end
    object DBText1: TDBText
      Left = 55
      Top = 8
      Width = 270
      Height = 17
      DataField = 'RAZAOSOCIAL'
      DataSource = DsAjustaEmbalagens
    end
    object DBText2: TDBText
      Left = 423
      Top = 8
      Width = 90
      Height = 17
      DataField = 'numero'
      DataSource = DsAjustaEmbalagens
    end
    object DBText4: TDBText
      Left = 305
      Top = 27
      Width = 97
      Height = 17
      DataField = 'TOTPAGO'
      DataSource = DsAjustaEmbalagens
    end
    object LabelValorTotal: TLabel
      Left = 75
      Top = 27
      Width = 38
      Height = 13
      Caption = 'R$ 0,00'
    end
    object LabelValorPendente: TLabel
      Left = 490
      Top = 27
      Width = 38
      Height = 13
      Caption = 'R$ 0,00'
    end
    object Label6: TLabel
      Left = 176
      Top = 50
      Width = 123
      Height = 13
      Caption = 'Valor Devolvido Calculado'
    end
    object LabelDevolvidoCalculado: TLabel
      Left = 305
      Top = 50
      Width = 38
      Height = 13
      Caption = 'R$ 0,00'
    end
  end
  object cxGridEmbalagens: TcxGrid
    Left = 0
    Top = 75
    Width = 678
    Height = 233
    Align = alClient
    TabOrder = 1
    object cxGridViewClientes: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.DataSource = DsAjustaEmbalagens
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridViewClientesCHAVENFPRO: TcxGridDBColumn
        DataBinding.FieldName = 'CHAVENFPRO'
        Visible = False
        Options.Editing = False
        Options.Filtering = False
      end
      object cxGridViewClientesAPRESENTACAO: TcxGridDBColumn
        DataBinding.FieldName = 'APRESENTACAO'
        Options.Editing = False
        Options.Filtering = False
        Width = 133
      end
      object cxGridViewClientesQUANTATENDIDA: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTATENDIDA'
        Options.Editing = False
        Options.Filtering = False
        Width = 56
      end
      object cxGridViewClientesQuantDevolvida: TcxGridDBColumn
        DataBinding.FieldName = 'QuantDevolvida'
        Options.Filtering = False
        Styles.Content = cxStyle1
        Styles.Header = cxStyle1
        Width = 73
      end
      object cxGridViewClientesQuantPendente: TcxGridDBColumn
        DataBinding.FieldName = 'QuantPendente'
        Options.Editing = False
        Options.Filtering = False
        Width = 60
      end
      object cxGridViewClientesValorDevolvido: TcxGridDBColumn
        DataBinding.FieldName = 'ValorDevolvido'
        Width = 65
      end
      object cxGridViewClientesValorPendente: TcxGridDBColumn
        DataBinding.FieldName = 'ValorPendente'
        Options.Editing = False
        Options.Filtering = False
        Width = 74
      end
      object cxGridViewClientesVALTOTAL: TcxGridDBColumn
        DataBinding.FieldName = 'VALTOTAL'
        Options.Editing = False
        Options.Filtering = False
        Width = 70
      end
      object cxGridViewClientesVALUNIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'VALUNIDADE'
        Options.Editing = False
        Options.Filtering = False
        Width = 69
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
  object Panel2: TPanel
    Left = 0
    Top = 308
    Width = 678
    Height = 41
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      678
      41)
    object BtnOK: TButton
      Left = 299
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop]
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOKClick
    end
  end
  object QryEmbalagens: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT *'
      'from vwEmbalagemPendente'
      'where'
      '  ChaveNF =:ChaveNF'
      
        'ORDER BY datacomprovante desc, RAZAOSOCIAL, ValTotal desc, QUANT' +
        'ATENDIDA desc')
    Left = 104
    Top = 104
    ParamData = <
      item
        Name = 'CHAVENF'
        DataType = ftString
        FDDataType = dtWideString
        ParamType = ptInput
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
    object QryEmbalagensSEQUENCIADOPRODUTO: TIntegerField
      FieldName = 'SEQUENCIADOPRODUTO'
      Origin = 'SEQUENCIADOPRODUTO'
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
    object QryEmbalagensENVIADOAVENCER: TBooleanField
      FieldName = 'ENVIADOAVENCER'
      Origin = 'ENVIADOAVENCER'
      Required = True
    end
    object QryEmbalagensDataVencimento: TDateField
      FieldName = 'DataVencimento'
      Origin = 'DataVencimento'
    end
    object QryEmbalagensValorPendente: TFMTBCDField
      FieldName = 'ValorPendente'
      Origin = 'ValorPendente'
      ReadOnly = True
      currency = True
      Precision = 38
      Size = 6
    end
  end
  object DsAjustaEmbalagens: TDataSource
    DataSet = FDMemAjusteEmbalagens
    Left = 480
    Top = 128
  end
  object FDMemAjusteEmbalagens: TFDMemTable
    BeforeEdit = FDMemAjusteEmbalagensBeforeEdit
    AfterPost = FDMemAjusteEmbalagensAfterPost
    OnCalcFields = FDMemAjusteEmbalagensCalcFields
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 360
    Top = 128
    object FDMemAjusteEmbalagensCHAVENFPRO: TStringField
      FieldName = 'CHAVENFPRO'
      FixedChar = True
      Size = 21
    end
    object FDMemAjusteEmbalagensSEQUENCIADOPRODUTO: TIntegerField
      FieldName = 'SEQUENCIADOPRODUTO'
      Origin = 'SEQUENCIADOPRODUTO'
    end
    object FDMemAjusteEmbalagensRAZAOSOCIAL: TStringField
      DisplayLabel = 'Nome Cliente'
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Visible = False
      Size = 80
    end
    object FDMemAjusteEmbalagensAPRESENTACAO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'APRESENTACAO'
      Size = 80
    end
    object FDMemAjusteEmbalagensQUANTATENDIDA: TBCDField
      DisplayLabel = 'Qtd.'
      FieldName = 'QUANTATENDIDA'
      Precision = 18
    end
    object FDMemAjusteEmbalagensVALTOTAL: TBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'VALTOTAL'
      currency = True
      Precision = 18
    end
    object FDMemAjusteEmbalagensVALUNIDADE: TFMTBCDField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VALUNIDADE'
      currency = True
      Precision = 38
      Size = 20
    end
    object FDMemAjusteEmbalagensnumero: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'numero'
      Origin = 'numero'
      FixedChar = True
      Size = 6
    end
    object FDMemAjusteEmbalagensTOTPAGO: TFMTBCDField
      DisplayLabel = 'Valor Devolvido'
      DisplayWidth = 19
      FieldName = 'TOTPAGO'
      Origin = 'TOTPAGO'
      currency = True
      Precision = 38
      Size = 2
    end
    object FDMemAjusteEmbalagensQuantDevolvida: TFMTBCDField
      DisplayLabel = 'Qtd. Devolvida'
      FieldName = 'QuantDevolvida'
      OnChange = FDMemAjusteEmbalagensQuantDevolvidaChange
      Precision = 38
      Size = 6
    end
    object FDMemAjusteEmbalagensQuantPendente: TFMTBCDField
      DisplayLabel = 'Qtd. Pendente'
      FieldKind = fkCalculated
      FieldName = 'QuantPendente'
      Precision = 38
      Size = 6
      Calculated = True
    end
    object FDMemAjusteEmbalagensValorPendente: TFMTBCDField
      DisplayLabel = 'Valor Pendente'
      FieldKind = fkCalculated
      FieldName = 'ValorPendente'
      currency = True
      Precision = 38
      Size = 6
      Calculated = True
    end
    object FDMemAjusteEmbalagensValorDevolvido: TCurrencyField
      DisplayLabel = 'Valor Devolvido'
      FieldKind = fkCalculated
      FieldName = 'ValorDevolvido'
      Calculated = True
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 72
    Top = 176
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
