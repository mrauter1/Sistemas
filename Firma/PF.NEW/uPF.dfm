object fPF: TfPF
  Left = 169
  Top = 176
  Caption = 'Policia Federal'
  ClientHeight = 362
  ClientWidth = 676
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  DesignSize = (
    676
    362)
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 8
    Top = 305
    Width = 545
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    Progress = 0
    ExplicitTop = 282
    ExplicitWidth = 404
  end
  object Label2: TLabel
    Left = 12
    Top = 341
    Width = 42
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Diret'#243'rio:'
    ExplicitTop = 333
  end
  object GroupBox1: TGroupBox
    Left = 11
    Top = 8
    Width = 657
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Gerar arquivos com data de emiss'#227'o do m'#234's de'
    TabOrder = 0
    ExplicitWidth = 539
    DesignSize = (
      657
      57)
    object Label1: TLabel
      Left = 390
      Top = 27
      Width = 22
      Height = 13
      Anchors = [akTop]
      Caption = 'Ano:'
      ExplicitLeft = 318
    end
    object CBXMes: TComboBox
      Left = 48
      Top = 24
      Width = 145
      Height = 21
      TabOrder = 0
      Text = 'Janeiro'
      OnExit = EditAnoExit
      OnKeyDown = CBXMesKeyDown
      OnSelect = EditAnoExit
      Items.Strings = (
        'Janeiro'
        'Fevereiro'
        'Mar'#231'o'
        'Abril'
        'Maio'
        'Junho'
        'Julho'
        'Agosto'
        'Setembro'
        'Outubro'
        'Novembro'
        'Dezembro')
    end
    object EditAno: TEdit
      Left = 464
      Top = 24
      Width = 121
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnExit = EditAnoExit
      OnKeyDown = EditAnoKeyDown
      ExplicitLeft = 346
    end
  end
  object DBGrid: TDBGrid
    Left = 8
    Top = 83
    Width = 657
    Height = 185
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DmDados.DS_ProdutoControlado
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODGRUPOSUB'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMESUBGRUPO'
        Width = 139
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CodMercosulNCM'
        Width = 135
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Densidade'
        Width = 99
        Visible = True
      end>
  end
  object BtnGerar: TButton
    Left = 568
    Top = 305
    Width = 99
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gerar Arquivo'
    TabOrder = 2
    OnClick = BtnGerarClick
    ExplicitLeft = 450
    ExplicitTop = 297
  end
  object ButtonSelDir: TButton
    Left = 641
    Top = 335
    Width = 22
    Height = 20
    Anchors = [akRight, akBottom]
    Caption = '...'
    TabOrder = 3
    OnClick = ButtonSelDirClick
    ExplicitLeft = 523
    ExplicitTop = 327
  end
  object EditDir: TEdit
    Left = 57
    Top = 336
    Width = 577
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 4
    ExplicitTop = 328
    ExplicitWidth = 459
  end
  object btnComprov: TButton
    Left = 8
    Top = 274
    Width = 153
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Comprovantes Compra'
    TabOrder = 5
    OnClick = btnComprovClick
    ExplicitTop = 266
  end
  object Button2: TButton
    Left = 330
    Top = 274
    Width = 98
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Grupos'
    TabOrder = 6
    OnClick = BtnGrupos
    ExplicitTop = 266
  end
  object BtnTransp: TButton
    Left = 438
    Top = 274
    Width = 99
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Transporte Pr'#243'prio'
    TabOrder = 7
  end
  object Button1: TButton
    Left = 167
    Top = 274
    Width = 153
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Comprovantes Venda'
    TabOrder = 8
    OnClick = Button1Click
    ExplicitTop = 266
  end
  object BtnIdentificacao: TButton
    Left = 543
    Top = 274
    Width = 123
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Identifica'#231#227'o Empresa'
    TabOrder = 9
    OnClick = BtnIdentificacaoClick
  end
end
