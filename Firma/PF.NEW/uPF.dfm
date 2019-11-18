object fPF: TfPF
  Left = 169
  Top = 176
  Caption = 'Policia Federal'
  ClientHeight = 354
  ClientWidth = 558
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  DesignSize = (
    558
    354)
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 8
    Top = 297
    Width = 427
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    Progress = 0
    ExplicitTop = 282
    ExplicitWidth = 404
  end
  object Label2: TLabel
    Left = 12
    Top = 333
    Width = 42
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Diret'#243'rio:'
  end
  object GroupBox1: TGroupBox
    Left = 11
    Top = 8
    Width = 539
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Gerar arquivos com data de emiss'#227'o do m'#234's de'
    TabOrder = 0
    DesignSize = (
      539
      57)
    object Label1: TLabel
      Left = 318
      Top = 27
      Width = 22
      Height = 13
      Anchors = [akTop]
      Caption = 'Ano:'
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
      Left = 346
      Top = 24
      Width = 121
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnExit = EditAnoExit
      OnKeyDown = EditAnoKeyDown
    end
  end
  object DBGrid: TDBGrid
    Left = 8
    Top = 83
    Width = 539
    Height = 177
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
    Left = 450
    Top = 297
    Width = 99
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gerar Arquivo'
    TabOrder = 2
    OnClick = BtnGerarClick
  end
  object ButtonSelDir: TButton
    Left = 523
    Top = 327
    Width = 22
    Height = 20
    Anchors = [akRight, akBottom]
    Caption = '...'
    TabOrder = 3
    OnClick = ButtonSelDirClick
  end
  object EditDir: TEdit
    Left = 57
    Top = 328
    Width = 459
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 4
  end
  object btnComprov: TButton
    Left = 8
    Top = 266
    Width = 153
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Comprovantes Compra'
    TabOrder = 5
    OnClick = btnComprovClick
  end
  object Button2: TButton
    Left = 330
    Top = 266
    Width = 98
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Grupos'
    TabOrder = 6
    OnClick = BtnGrupos
  end
  object BtnTransp: TButton
    Left = 438
    Top = 266
    Width = 111
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Transporte Pr'#243'prio'
    TabOrder = 7
    OnClick = BtnTranspClick
  end
  object Button1: TButton
    Left = 167
    Top = 266
    Width = 153
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Comprovantes Venda'
    TabOrder = 8
    OnClick = Button1Click
  end
end
