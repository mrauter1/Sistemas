object FrmPesquisaNeg: TFrmPesquisaNeg
  Left = 0
  Top = 0
  Caption = 'Pesquisa Negocia'#231#227'o'
  ClientHeight = 348
  ClientWidth = 730
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 730
    Height = 81
    Align = alTop
    TabOrder = 0
    object Label3: TLabel
      Left = 200
      Top = 22
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = 'Transportadora'
    end
    object Label2: TLabel
      Left = 21
      Top = 23
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = 'Cod. Transp.'
    end
    object BtnPesquisar: TBitBtn
      Left = 262
      Top = 46
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 2
      OnClick = BtnPesquisarClick
    end
    object EditCodTransp: TEdit
      Left = 88
      Top = 19
      Width = 89
      Height = 21
      TabOrder = 0
      OnKeyDown = EditCodTranspKeyDown
    end
    object EditNomeTransp: TEdit
      Left = 281
      Top = 19
      Width = 272
      Height = 21
      TabOrder = 1
      OnKeyDown = EditNomeTranspKeyDown
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 81
    Width = 730
    Height = 267
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 728
      Height = 265
      Align = alClient
      DataSource = DSNegociacao
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'CODNEGOCIACAO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CODTRANSP'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMETRANSPORTE'
          Width = 282
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VIGENCIA_INI'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VIGENCIA_FIM'
          Visible = True
        end>
    end
  end
  object FDQueryNegociacao: TFDQuery
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      'select N.*, T.CODTRANSPORTE, T.NOMETRANSPORTE '
      'from negociacao n'
      'inner join TRANSP t on t.codtransporte = n.codtransp'
      'WHERE  EXCLUIDA_SN <> '#39'S'#39
      'ORDER BY T.NOMETRANSPORTE')
    Left = 384
    Top = 33
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
    Left = 488
    Top = 32
  end
end
