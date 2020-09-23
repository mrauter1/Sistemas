object FrmPesquisaTransp: TFrmPesquisaTransp
  Left = 0
  Top = 0
  Caption = 'Pesquisa Transportadora'
  ClientHeight = 350
  ClientWidth = 606
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
    Width = 606
    Height = 65
    Align = alTop
    TabOrder = 0
    DesignSize = (
      606
      65)
    object Label3: TLabel
      Left = 48
      Top = 22
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = 'Transportadora'
    end
    object BtnPesquisar: TBitBtn
      Left = 481
      Top = 17
      Width = 82
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = BtnPesquisarClick
    end
    object EditNomeTransp: TEdit
      Left = 129
      Top = 19
      Width = 346
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnKeyDown = EditNomeTranspKeyDown
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 606
    Height = 285
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 604
      Height = 283
      Align = alClient
      DataSource = DSTransp
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
          FieldName = 'CODTRANSPORTE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMETRANSPORTE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CIDADE'
          Width = 111
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESTADO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FONE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMETRANSPORTEFANT'
          Visible = True
        end>
    end
  end
  object FDQueryTransp: TFDQuery
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      
        'select CodTransporte, NomeTransporte, Cidade, Estado, Fone, Nome' +
        'TransporteFant'
      'FROM TRANSP'
      
        'where ATIVA_SN <> '#39'N'#39' and CODTRANSPORTE in (select N.CODTRANSP f' +
        'rom NEGOCIACAO N WHERE N.EXCLUIDA_SN <> '#39'S'#39')'
      'ORDER BY NomeTransporte')
    Left = 384
    Top = 33
    object FDQueryTranspCODTRANSPORTE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODTRANSPORTE'
      Origin = 'CODTRANSPORTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 6
    end
    object FDQueryTranspNOMETRANSPORTE: TStringField
      DisplayLabel = 'Nome Transp.'
      FieldName = 'NOMETRANSPORTE'
      Origin = 'NOMETRANSPORTE'
      FixedChar = True
      Size = 30
    end
    object FDQueryTranspCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      FixedChar = True
      Size = 35
    end
    object FDQueryTranspESTADO: TStringField
      DisplayLabel = 'Estado'
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      FixedChar = True
      Size = 2
    end
    object FDQueryTranspFONE: TStringField
      DisplayLabel = 'Fone'
      FieldName = 'FONE'
      Origin = 'FONE'
      FixedChar = True
      Size = 15
    end
    object FDQueryTranspNOMETRANSPORTEFANT: TStringField
      DisplayLabel = 'Nome Fantasia'
      FieldName = 'NOMETRANSPORTEFANT'
      Origin = 'NOMETRANSPORTEFANT'
      FixedChar = True
      Size = 30
    end
  end
  object DSTransp: TDataSource
    AutoEdit = False
    DataSet = FDQueryTransp
    Left = 488
    Top = 32
  end
end
