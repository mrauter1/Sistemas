object FrmAjusteNeg: TFrmAjusteNeg
  Left = 0
  Top = 0
  Caption = 'Configura Cidades da Negocia'#231#227'o de Fretes'
  ClientHeight = 599
  ClientWidth = 875
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 875
    Height = 81
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 19
      Top = 19
      Width = 81
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cod. Negocia'#231#227'o'
    end
    object Label2: TLabel
      Left = 37
      Top = 47
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cod. Transp.'
    end
    object Label3: TLabel
      Left = 208
      Top = 47
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = 'Transportadora'
    end
    object DBEditCodNeg: TDBEdit
      Left = 104
      Top = 15
      Width = 89
      Height = 21
      DataField = 'CODNEGOCIACAO'
      DataSource = DSNegociacao
      ReadOnly = True
      TabOrder = 0
    end
    object DBEditCodTransp: TDBEdit
      Left = 104
      Top = 43
      Width = 89
      Height = 21
      DataField = 'CODTRANSP'
      DataSource = DSNegociacao
      ReadOnly = True
      TabOrder = 1
    end
    object DBEditNomeTransp: TDBEdit
      Left = 289
      Top = 43
      Width = 289
      Height = 21
      DataField = 'NOMETRANSPORTE'
      DataSource = DSNegociacao
      ReadOnly = True
      TabOrder = 2
    end
    object BtnPesquisar: TBitBtn
      Left = 200
      Top = 13
      Width = 83
      Height = 25
      Caption = 'Pesquisar'
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
      TabOrder = 3
      OnClick = BtnPesquisarClick
    end
  end
  object cxSplitter1: TcxSplitter
    Left = 0
    Top = 81
    Width = 8
    Height = 518
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 81
    Width = 867
    Height = 518
    ActivePage = TabParametros
    Align = alClient
    TabOrder = 2
    object TabFaixas: TTabSheet
      Caption = 'Faixas'
      object GroupBoxFaixas: TGroupBox
        Left = 0
        Top = 0
        Width = 241
        Height = 490
        Align = alLeft
        Caption = 'Faixas'
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 2
          Top = 15
          Width = 237
          Height = 473
          Align = alClient
          DataSource = DSFaixas
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'CODFAIXA'
              Width = 29
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TITULO'
              Width = 164
              Visible = True
            end>
        end
      end
      object Panel3: TPanel
        Left = 241
        Top = 0
        Width = 618
        Height = 490
        Align = alClient
        TabOrder = 1
        object GroupBoxAdd: TGroupBox
          Left = 233
          Top = 1
          Width = 204
          Height = 488
          Align = alClient
          Caption = 'Cidades para Adicionar'
          TabOrder = 0
          object MemoCidades: TMemo
            Left = 2
            Top = 15
            Width = 200
            Height = 405
            Align = alClient
            TabOrder = 0
          end
          object PanelAddCidades: TPanel
            Left = 2
            Top = 420
            Width = 200
            Height = 66
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 1
            object Label4: TLabel
              Left = 22
              Top = 6
              Width = 13
              Height = 13
              Caption = 'UF'
            end
            object CbxUF: TComboBox
              Left = 43
              Top = 3
              Width = 93
              Height = 22
              Style = csOwnerDrawFixed
              TabOrder = 0
            end
            object BtnAdicionaCidades: TButton
              Left = 26
              Top = 31
              Width = 99
              Height = 25
              Caption = 'Atualiza Cidade'
              TabOrder = 1
              OnClick = BtnAdicionaCidadesClick
            end
          end
        end
        object GroupBoxCidades: TGroupBox
          Left = 1
          Top = 1
          Width = 224
          Height = 488
          Align = alLeft
          Caption = 'Cidades Na Faixa'
          TabOrder = 1
          object DBGrid2: TDBGrid
            Left = 2
            Top = 15
            Width = 220
            Height = 406
            Align = alClient
            DataSource = DSCidades
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'CODESTADO'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NOMECIDADE'
                Width = 163
                Visible = True
              end>
          end
          object Panel5: TPanel
            Left = 2
            Top = 421
            Width = 220
            Height = 65
            Align = alBottom
            TabOrder = 1
            DesignSize = (
              220
              65)
            object BtnRemoveTodas: TButton
              Left = 24
              Top = 37
              Width = 177
              Height = 25
              Anchors = [akTop]
              Caption = 'Remover Todas Cidades'
              TabOrder = 0
              OnClick = BtnRemoveTodasClick
            end
            object BtnRemoveCidadeSelecionada: TButton
              Left = 24
              Top = 6
              Width = 177
              Height = 25
              Anchors = [akTop]
              Caption = 'Remove Cidade Selecionada'
              TabOrder = 1
              OnClick = BtnRemoveCidadeSelecionadaClick
            end
          end
        end
        object GroupBoxErro: TGroupBox
          Left = 445
          Top = 1
          Width = 172
          Height = 488
          Align = alRight
          Caption = 'Cidades com Erro!'
          TabOrder = 2
          object MemoErros: TMemo
            Left = 2
            Top = 15
            Width = 168
            Height = 471
            Align = alClient
            TabOrder = 0
          end
        end
        object cxSplitter2: TcxSplitter
          Left = 225
          Top = 1
          Width = 8
          Height = 488
          Control = GroupBoxCidades
        end
        object cxSplitter3: TcxSplitter
          Left = 437
          Top = 1
          Width = 8
          Height = 488
          AlignSplitter = salRight
          Control = GroupBoxErro
        end
      end
    end
    object TabParametros: TTabSheet
      Caption = 'Par'#226'metros'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 235
        Top = 0
        Width = 624
        Height = 490
        Align = alClient
        TabOrder = 0
        object GroupBox1: TGroupBox
          Left = 233
          Top = 1
          Width = 210
          Height = 488
          Align = alClient
          Caption = 'Cidades para Adicionar'
          TabOrder = 0
          DesignSize = (
            210
            488)
          object MemoCidadesParam: TMemo
            Left = 2
            Top = 15
            Width = 206
            Height = 403
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 0
          end
          object Panel6: TPanel
            Left = 6
            Top = 423
            Width = 190
            Height = 62
            Anchors = [akBottom]
            BevelOuter = bvNone
            TabOrder = 1
            object Label5: TLabel
              Left = 38
              Top = 9
              Width = 13
              Height = 13
              Caption = 'UF'
            end
            object CbxUFParam: TComboBox
              Left = 59
              Top = 6
              Width = 93
              Height = 22
              Style = csOwnerDrawFixed
              TabOrder = 0
            end
            object BtnAddCidadeParam: TButton
              Left = 42
              Top = 34
              Width = 99
              Height = 25
              Caption = 'Atualiza Cidade'
              TabOrder = 1
              OnClick = BtnAddCidadeParamClick
            end
          end
        end
        object GroupBox2: TGroupBox
          Left = 1
          Top = 1
          Width = 224
          Height = 488
          Align = alLeft
          Caption = 'Cidades do Par'#226'metro'
          TabOrder = 1
          object GridCidadesDoParametro: TDBGrid
            Left = 2
            Top = 15
            Width = 220
            Height = 406
            Align = alClient
            DataSource = DSCidadesParametros
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'CODESTADO'
                Width = 39
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NOMECIDADE'
                Width = 147
                Visible = True
              end>
          end
          object Panel7: TPanel
            Left = 2
            Top = 421
            Width = 220
            Height = 65
            Align = alBottom
            TabOrder = 1
            DesignSize = (
              220
              65)
            object BtnRemoveTodasParam: TButton
              Left = 24
              Top = 37
              Width = 177
              Height = 25
              Anchors = [akTop]
              Caption = 'Remover Todas Cidades'
              TabOrder = 0
              OnClick = BtnRemoveTodasParamClick
            end
            object BtnRemoveCidadeParam: TButton
              Left = 24
              Top = 6
              Width = 177
              Height = 25
              Anchors = [akTop]
              Caption = 'Remove Cidade Selecionada'
              TabOrder = 1
              OnClick = BtnRemoveCidadeParamClick
            end
          end
        end
        object GroupBox3: TGroupBox
          Left = 451
          Top = 1
          Width = 172
          Height = 488
          Align = alRight
          Caption = 'Cidades com Erro!'
          TabOrder = 2
          object MemoCidadesComErroParam: TMemo
            Left = 2
            Top = 15
            Width = 168
            Height = 471
            Align = alClient
            TabOrder = 0
            ExplicitLeft = 6
            ExplicitTop = 14
          end
        end
        object cxSplitter4: TcxSplitter
          Left = 225
          Top = 1
          Width = 8
          Height = 488
          Control = GroupBox2
        end
        object cxSplitter5: TcxSplitter
          Left = 443
          Top = 1
          Width = 8
          Height = 488
          AlignSplitter = salRight
          Control = GroupBox3
        end
      end
      object GroupBoxParametros: TGroupBox
        Left = 0
        Top = 0
        Width = 235
        Height = 490
        Align = alLeft
        Caption = 'Par'#226'metros'
        TabOrder = 1
        object DBGrid3: TDBGrid
          Left = 2
          Top = 15
          Width = 231
          Height = 473
          Align = alClient
          DataSource = DSParametros
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'CODPARAM'
              Width = 46
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME'
              Width = 146
              Visible = True
            end>
        end
      end
    end
  end
  object FDQueryFaixas: TFDQuery
    AfterScroll = FDQueryFaixasAfterScroll
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      'SELECT *'
      'FROM NEG_FAIXAS'
      'WHERE CODNEGOCIACAO =:CODNEGOCIACAO')
    Left = 48
    Top = 289
    ParamData = <
      item
        Name = 'CODNEGOCIACAO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object FDQueryFaixasCODFAIXA: TIntegerField
      DisplayLabel = 'Cod. Faixa'
      DisplayWidth = 7
      FieldName = 'CODFAIXA'
      Origin = 'CODFAIXA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQueryFaixasCODNEGOCIACAO: TIntegerField
      FieldName = 'CODNEGOCIACAO'
      Origin = 'CODNEGOCIACAO'
      Required = True
      Visible = False
    end
    object FDQueryFaixasTITULO: TStringField
      DisplayLabel = 'T'#237'tulo'
      DisplayWidth = 36
      FieldName = 'TITULO'
      Origin = 'TITULO'
      Required = True
      FixedChar = True
      Size = 30
    end
  end
  object FDQueryCidades: TFDQuery
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      'SELECT *'
      'FROM NEG_FAIXA_CIDADES'
      'WHERE CODFAIXA =:CODFAIXA'
      'ORDER BY NOMECIDADE')
    Left = 160
    Top = 289
    ParamData = <
      item
        Name = 'CODFAIXA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryCidadesCODFAIXA: TIntegerField
      FieldName = 'CODFAIXA'
      Origin = 'CODFAIXA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object FDQueryCidadesCODESTADO: TStringField
      DisplayLabel = 'Estado'
      FieldName = 'CODESTADO'
      Origin = 'CODESTADO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 2
    end
    object FDQueryCidadesNOMECIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'NOMECIDADE'
      Origin = 'NOMECIDADE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 35
    end
  end
  object FDQueryNegociacao: TFDQuery
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      'select N.*, T.CODTRANSPORTE, T.NOMETRANSPORTE '
      'from negociacao n'
      'inner join TRANSP t on t.codtransporte = n.codtransp'
      'WHERE CODNEGOCIACAO =:CODNEGOCIACAO'
      'and EXCLUIDA_SN <> '#39'S'#39)
    Left = 400
    Top = 1
    ParamData = <
      item
        Name = 'CODNEGOCIACAO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryNegociacaoCODNEGOCIACAO: TIntegerField
      DisplayLabel = 'Cod. Negocia'#231#227'o'
      FieldName = 'CODNEGOCIACAO'
      Origin = 'CODNEGOCIACAO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDQueryNegociacaoCODFILIAL: TStringField
      DisplayLabel = 'Cod. Filial'
      FieldName = 'CODFILIAL'
      Origin = 'CODFILIAL'
      Required = True
      FixedChar = True
      Size = 2
    end
    object FDQueryNegociacaoCODTRANSP: TStringField
      DisplayLabel = 'Cod. Transp.'
      FieldName = 'CODTRANSP'
      Origin = 'CODTRANSP'
      Required = True
      FixedChar = True
      Size = 6
    end
    object FDQueryNegociacaoSITUACAO: TIntegerField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'SITUACAO'
      Origin = 'SITUACAO'
      Required = True
    end
    object FDQueryNegociacaoVIGENCIA_INI: TDateField
      DisplayLabel = 'In'#237'cio Vig'#234'ncia'
      FieldName = 'VIGENCIA_INI'
      Origin = 'VIGENCIA_INI'
      Required = True
    end
    object FDQueryNegociacaoVIGENCIA_FIM: TDateField
      DisplayLabel = 'Fim Vig'#234'ncia'
      FieldName = 'VIGENCIA_FIM'
      Origin = 'VIGENCIA_FIM'
      Required = True
    end
    object FDQueryNegociacaoTIPO_CALCULO: TIntegerField
      FieldName = 'TIPO_CALCULO'
      Origin = 'TIPO_CALCULO'
      Required = True
      Visible = False
    end
    object FDQueryNegociacaoEMUSO: TStringField
      FieldName = 'EMUSO'
      Origin = 'EMUSO'
      Required = True
      Visible = False
      FixedChar = True
      Size = 26
    end
    object FDQueryNegociacaoEXCLUIDA_SN: TStringField
      FieldName = 'EXCLUIDA_SN'
      Origin = 'EXCLUIDA_SN'
      Required = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object FDQueryNegociacaoCODTRANSPORTE: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Cod. Transporte'
      FieldName = 'CODTRANSPORTE'
      Origin = 'CODTRANSPORTE'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 6
    end
    object FDQueryNegociacaoNOMETRANSPORTE: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Transportadora'
      FieldName = 'NOMETRANSPORTE'
      Origin = 'NOMETRANSPORTE'
      ProviderFlags = []
      ReadOnly = True
      FixedChar = True
      Size = 30
    end
  end
  object DSNegociacao: TDataSource
    AutoEdit = False
    DataSet = FDQueryNegociacao
    Left = 504
  end
  object DSFaixas: TDataSource
    AutoEdit = False
    DataSet = FDQueryFaixas
    Left = 48
    Top = 344
  end
  object DSCidades: TDataSource
    AutoEdit = False
    DataSet = FDQueryCidades
    Left = 160
    Top = 344
  end
  object FDQueryEstados: TFDQuery
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      'select * from TABESTADOS'
      'order by CodEstado')
    Left = 562
    Top = 442
    object FDQueryEstadosCODESTADO: TStringField
      FieldName = 'CODESTADO'
      Origin = 'CODESTADO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 2
    end
    object FDQueryEstadosNOMEESTADO: TStringField
      FieldName = 'NOMEESTADO'
      Origin = 'NOMEESTADO'
      Required = True
      FixedChar = True
      Size = 25
    end
    object FDQueryEstadosCODESTADONFE: TStringField
      FieldName = 'CODESTADONFE'
      Origin = 'CODESTADONFE'
      Required = True
      FixedChar = True
      Size = 2
    end
  end
  object MainMenu1: TMainMenu
    Left = 626
    Top = 2
    object Extras: TMenuItem
      Caption = 'Extras'
      object CalculadoraDeFretes1: TMenuItem
        Caption = 'Calculadora De Fretes'
        OnClick = CalculadoraDeFretes1Click
      end
      object ConfernciadosFretesDosMovimentos1: TMenuItem
        Caption = 'Confer'#234'ncia dos Fretes dos Movimentos'
        OnClick = ConfernciadosFretesDosMovimentos1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object AtualizarDadosFrete1: TMenuItem
        Caption = 'Atualizar Dados Negocia'#231#245'es'
        OnClick = AtualizarDadosFrete1Click
      end
    end
  end
  object QryParametros: TFDQuery
    AfterScroll = QryParametrosAfterScroll
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      'SELECT *'
      'FROM NEG_PARAMETROS'
      'WHERE CODNEGOCIACAO =:CODNEGOCIACAO')
    Left = 520
    Top = 153
    ParamData = <
      item
        Name = 'CODNEGOCIACAO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object QryParametrosCODNEGOCIACAO: TIntegerField
      FieldName = 'CODNEGOCIACAO'
      Origin = 'CODNEGOCIACAO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryParametrosCODPARAM: TIntegerField
      DisplayLabel = 'Cod. Param'
      FieldName = 'CODPARAM'
      Origin = 'CODPARAM'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryParametrosNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      FixedChar = True
      Size = 25
    end
  end
  object QueryCidadesParam: TFDQuery
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      'SELECT *'
      'FROM NEG_PARAM_CIDADE'
      'WHERE CODPARAM =:CODPARAM AND CODNEGOCIACAO =:CODNEGOCIACAO'
      'ORDER BY NOMECIDADE')
    Left = 624
    Top = 153
    ParamData = <
      item
        Name = 'CODPARAM'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'CODNEGOCIACAO'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object QueryCidadesParamCODNEGOCIACAO: TIntegerField
      FieldName = 'CODNEGOCIACAO'
      Origin = 'CODNEGOCIACAO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QueryCidadesParamCODPARAM: TIntegerField
      FieldName = 'CODPARAM'
      Origin = 'CODPARAM'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QueryCidadesParamCODESTADO: TStringField
      DisplayLabel = 'Estado'
      FieldName = 'CODESTADO'
      Origin = 'CODESTADO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 2
    end
    object QueryCidadesParamNOMECIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'NOMECIDADE'
      Origin = 'NOMECIDADE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 35
    end
  end
  object DSParametros: TDataSource
    AutoEdit = False
    DataSet = QryParametros
    Left = 520
    Top = 216
  end
  object DSCidadesParametros: TDataSource
    AutoEdit = False
    DataSet = QueryCidadesParam
    Left = 624
    Top = 216
  end
end
