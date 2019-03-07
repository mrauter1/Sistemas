object FrmCalculadoraDeFretes: TFrmCalculadoraDeFretes
  Left = 0
  Top = 0
  Caption = 'Calculadora de Fretes'
  ClientHeight = 388
  ClientWidth = 724
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
    Width = 724
    Height = 97
    Align = alTop
    TabOrder = 0
    DesignSize = (
      724
      97)
    object Label2: TLabel
      Left = 27
      Top = 23
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cod. Transp.'
    end
    object Label1: TLabel
      Left = 219
      Top = 22
      Width = 13
      Height = 13
      Alignment = taRightJustify
      Caption = 'UF'
    end
    object Label3: TLabel
      Left = 327
      Top = 20
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cidade'
    end
    object Label4: TLabel
      Left = 65
      Top = 58
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Caption = 'Peso'
    end
    object Label5: TLabel
      Left = 208
      Top = 58
      Width = 24
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor'
    end
    object EditCidade: TEdit
      Left = 366
      Top = 17
      Width = 171
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object BtnCalcular: TButton
      Left = 549
      Top = 51
      Width = 157
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Calcular'
      TabOrder = 5
      OnClick = BtnCalcularClick
    end
    object EditValor: TcxCurrencyEdit
      Left = 238
      Top = 55
      Properties.DisplayFormat = '#0.00'
      TabOrder = 4
      Width = 83
    end
    object EditPeso: TcxCurrencyEdit
      Left = 94
      Top = 55
      Properties.DisplayFormat = '#0.00'
      TabOrder = 3
      Width = 81
    end
    object CbxUF: TComboBox
      Left = 240
      Top = 20
      Width = 57
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 1
      Items.Strings = (
        'AC'
        'AL'
        'AM'
        'AP'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MG'
        'MS'
        'MT'
        'PA'
        'PB'
        'PE'
        'PI'
        'PR'
        'RJ'
        'RN'
        'RO'
        'RR'
        'RS'
        'SC'
        'SE'
        'SP'
        'TO')
    end
    object EditCodTransp: TcxTextEdit
      Left = 94
      Top = 19
      TabOrder = 0
      OnExit = EditCodTranspExit
      OnKeyPress = EditCodTranspKeyPress
      Width = 81
    end
    object Button1: TButton
      Left = 549
      Top = 15
      Width = 157
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Atualiza Dados Negocia'#231#245'es'
      TabOrder = 6
      OnClick = Button1Click
    end
    object BtnPesquisar: TBitBtn
      Left = 181
      Top = 17
      Width = 29
      Height = 25
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000060D17261737
        64B70A182D6B0001021A0000000C000000040000000100000000000000000000
        0000000000000000000000000000000000000000000000000000274776CE2A5D
        9EFF5180B6FF1F4986F111274BA5050B15460000001400000009000000020000
        0000000000000000000000000000000000000000000000000000284B7AD2295E
        A0FFA6CEE8FF75C2EBFF3A85C1FF265799FF173569DB0C1A328B0203072E0000
        0010000000060000000100000000000000000000000000000000294D7CD23467
        A8FF8DB4D8FF99DAF7FF58BCEFFF4CB1EBFF378FCFFF2664A6FF1F407DFB1223
        4BBF070D1C65000000190000000B0000000300000000000000002A4F7FD24678
        B1FF6E9AC7FFB5E5FAFF5FC2F1FF52B6ECFF44AAE6FF389CDFFF2C8DD5FF2069
        B1FF1C498CFF182E63ED0D18359E03050B3300000005000000002A5282D2628F
        BEFF4C7EB7FFD0EFFCFF64C6F3FF59BDEFFF4CB1EAFF3EA3E2FF3296DCFF2789
        D5FF1E7ECFFF186DBEFF175099FF18336EF703060D37000000022A5384D288AD
        D1FF2D67ACFFDAF2FCFF7CD2F5FF5FC3F2FF54B9EDFF46ABE6FF399CDFFF2D90
        D9FF2285D2FF1B79CDFF1572C7FF164991FF0B132B86000000072C5586D2A5C5
        DEFF3675B4FFC0DAEDFFA0DFF9FF65C8F3FF5ABEF1FF4DB2EAFF3FA5E3FF3498
        DCFF288CD7FF2080D0FF1977CBFF1659A6FF111F43BB0000000C2C5689D2BAD5
        E8FF589CCEFF8DB2D6FFC6EDFCFF91D8F8FF69C7F3FF56BBEFFF48ADE7FF3BA0
        E0FF2F93DBFF2487D4FF1D7ECFFF186CBDFF172C5EE7000000132C598AD2C7DC
        ECFF7FC7E7FF5688BEFFA1C1DFFFCEE7F6FFD0EEFCFFABDFF8FF81CAF1FF57B0
        E8FF379CDFFF2B8FD8FF2384D3FF1A79CDFF1C3A77FD020306282E5C8ED2D1E3
        F0FFA3E8FDFF6DBBE2FF4A91C7FF2D69ADFF4B7CB5FF77A1CBFF9BC4E3FFAADA
        F5FF8DCAEFFF5DADE4FF3995DBFF2082D2FF1C498EFF080E1E60316091D2D5E4
        F1FFF0FCFFFFD0F4FFFFA9EBFDFF8CE2FDFF8FCBE9FF76A5CFFF3F76AFFF3261
        9FFF5E8CBDFF76ABD7FF7BBCE9FF60A9E2FF2B64A7FF0E1B3892172C425D3C71
        A7ED79A1C9FFBBD3E6FFE8F8FDFF91B4D3FF4573A8FF779FC4FFAED3E8FFB1DD
        F2FF6CA1CBFF386CA7FF2B5594FF4476AEFF4C88C2FF142953BC000000000203
        040615283B542C537CB43D71A9F91E395784050A0F18162B436C294D7BCC4B75
        A6FF7DA7CAFFA8DAF0FF6D9EC4FF1C3868C4173263C31B3770E7000000000000
        0000000000000000000001010203000000000000000000000000000000000810
        192A1A314F872B5183E75681ADFF1B3051960000000000010103000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000E1A2A4B080F192D0000000000000000}
      TabOrder = 7
      OnClick = BtnPesquisarClick
    end
  end
  object DBGridFrete: TDBGrid
    Left = 0
    Top = 97
    Width = 724
    Height = 173
    Align = alClient
    DataSource = DSFrete
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODNEGOCIACAO'
        Width = 47
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CodTransp'
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NomeTransp'
        Width = 118
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorCalculado'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor_Parametros'
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor_Frete'
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Excedente_Peso'
        Width = 117
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Excedente_NF'
        Width = 132
        Visible = True
      end>
  end
  object DBGridParametros: TDBGrid
    Left = 0
    Top = 278
    Width = 724
    Height = 110
    Align = alBottom
    DataSource = DsParametros
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODNEGOCIACAO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODPARAM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorCalculado'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BASE'
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Fracao_Peso'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor_Minimo'
        Visible = True
      end>
  end
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 270
    Width = 724
    Height = 8
    AlignSplitter = salBottom
  end
  object FDQryFrete: TFDQuery
    AfterScroll = FDQryFreteAfterScroll
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select * from FRETE.CalculaFretes(:UF, :Cidade, :Peso, :Valor)'
      'where CodTransp = IsNull(NullIf(:CodTransp, '#39#39'), CodTransp)'
      'order by ValorCalculado')
    Left = 384
    Top = 120
    ParamData = <
      item
        Name = 'UF'
        DataType = ftString
        ParamType = ptInput
        Size = 2
        Value = Null
      end
      item
        Name = 'CIDADE'
        DataType = ftString
        ParamType = ptInput
        Size = 255
        Value = Null
      end
      item
        Name = 'PESO'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALOR'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CODTRANSP'
        DataType = ftString
        ParamType = ptInput
        Size = 10
        Value = Null
      end>
    object FDQryFreteCODNEGOCIACAO: TIntegerField
      DisplayLabel = 'Cod. Negocia'#231#227'o'
      FieldName = 'CODNEGOCIACAO'
      Origin = 'CODNEGOCIACAO'
      Required = True
    end
    object FDQryFreteCodTransp: TStringField
      DisplayLabel = 'Cod. Transp.'
      FieldName = 'CodTransp'
      Origin = 'CodTransp'
      Required = True
      FixedChar = True
      Size = 6
    end
    object FDQryFreteNomeTransp: TStringField
      DisplayLabel = 'Nome Transp.'
      DisplayWidth = 21
      FieldName = 'NomeTransp'
      Origin = 'NomeTransp'
      FixedChar = True
      Size = 30
    end
    object FDQryFreteValorCalculado: TFMTBCDField
      DisplayLabel = 'Valor Calculado'
      DisplayWidth = 24
      FieldName = 'ValorCalculado'
      Origin = 'ValorCalculado'
      ReadOnly = True
      currency = True
      Precision = 38
      Size = 10
    end
    object FDQryFreteValor_Parametros: TFMTBCDField
      DisplayLabel = 'Valor Parametros'
      DisplayWidth = 47
      FieldName = 'Valor_Parametros'
      Origin = 'Valor_Parametros'
      currency = True
      Precision = 38
      Size = 11
    end
    object FDQryFreteValor_Frete: TBCDField
      DisplayLabel = 'Valor Frete'
      DisplayWidth = 23
      FieldName = 'Valor_Frete'
      Origin = 'Valor_Frete'
      Required = True
      currency = True
      Precision = 18
    end
    object FDQryFreteExcedente_Peso: TFMTBCDField
      DisplayLabel = 'Valor Excedente Peso'
      DisplayWidth = 47
      FieldName = 'Excedente_Peso'
      Origin = 'Excedente_Peso'
      currency = True
      Precision = 38
      Size = 10
    end
    object FDQryFreteExcedente_NF: TFMTBCDField
      DisplayLabel = 'Valor Excedente NF'
      DisplayWidth = 47
      FieldName = 'Excedente_NF'
      Origin = 'Excedente_NF'
      currency = True
      Precision = 38
      Size = 10
    end
  end
  object DSFrete: TDataSource
    AutoEdit = False
    DataSet = FDQryFrete
    Left = 384
    Top = 184
  end
  object FDQryParametros: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select * from'
      
        'FRETE.CalculaParametros(:CodNegociacao, :UF, :Cidade, :Peso, :Va' +
        'lor) Par')
    Left = 384
    Top = 280
    ParamData = <
      item
        Name = 'CODNEGOCIACAO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'UF'
        DataType = ftString
        ParamType = ptInput
        Size = 2
        Value = Null
      end
      item
        Name = 'CIDADE'
        DataType = ftString
        ParamType = ptInput
        Size = 255
        Value = Null
      end
      item
        Name = 'PESO'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALOR'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end>
    object FDQryParametrosCODNEGOCIACAO: TIntegerField
      DisplayLabel = 'Cod. Negoc.'
      FieldName = 'CODNEGOCIACAO'
      Origin = 'CODNEGOCIACAO'
      Required = True
      Visible = False
    end
    object FDQryParametrosCODPARAM: TIntegerField
      DisplayLabel = 'Cod. Param.'
      FieldName = 'CODPARAM'
      Origin = 'CODPARAM'
      Required = True
    end
    object FDQryParametrosNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      FixedChar = True
      Size = 25
    end
    object FDQryParametrosTIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Origin = 'TIPO'
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object FDQryParametrosVALOR: TBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
      currency = True
      Precision = 9
    end
    object FDQryParametrosBASE: TStringField
      DisplayLabel = 'Base'
      FieldName = 'BASE'
      Origin = 'BASE'
      Required = True
      FixedChar = True
    end
    object FDQryParametrosLINKCLIENTE_SN: TStringField
      FieldName = 'LINKCLIENTE_SN'
      Origin = 'LINKCLIENTE_SN'
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object FDQryParametrosARREDONDA_FRACAO: TStringField
      FieldName = 'ARREDONDA_FRACAO'
      Origin = 'ARREDONDA_FRACAO'
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object FDQryParametrosValorCalculado2: TFMTBCDField
      DisplayLabel = 'Valor Calculado'
      FieldName = 'ValorCalculado'
      Origin = 'ValorCalculado'
      ReadOnly = True
      Precision = 38
      Size = 4
    end
    object FDQryParametrosFracao_Peso2: TBCDField
      DisplayLabel = 'Fra'#231#227'o Peso'
      FieldName = 'Fracao_Peso'
      Origin = 'Fracao_Peso'
      Required = True
      Precision = 18
    end
    object FDQryParametrosValor_Minimo2: TBCDField
      DisplayLabel = 'Valor Minimo'
      FieldName = 'Valor_Minimo'
      Origin = 'Valor_Minimo'
      Required = True
      Precision = 18
    end
  end
  object DsParametros: TDataSource
    AutoEdit = False
    DataSet = FDQryParametros
    Left = 384
    Top = 328
  end
end
