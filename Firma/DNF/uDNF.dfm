object fDNF: TfDNF
  Left = 192
  Top = 114
  Width = 581
  Height = 369
  Caption = 'DNF'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    565
    331)
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 8
    Top = 275
    Width = 441
    Height = 21
    Anchors = [akLeft, akRight]
    Progress = 0
  end
  object Label2: TLabel
    Left = 12
    Top = 309
    Width = 39
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Diret'#243'rio'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 546
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Gerar arquivos com data de emiss'#227'o do m'#234's de'
    TabOrder = 0
    DesignSize = (
      546
      57)
    object Label1: TLabel
      Left = 269
      Top = 29
      Width = 12
      Height = 13
      Anchors = [akTop]
      Caption = 'de'
    end
    object CBXMes: TComboBox
      Left = 48
      Top = 24
      Width = 145
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
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
      Left = 362
      Top = 24
      Width = 127
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
      OnExit = EditAnoExit
      OnKeyDown = EditAnoKeyDown
    end
  end
  object DBGrid: TDBGrid
    Left = 8
    Top = 80
    Width = 546
    Height = 187
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = Dtm_DNF.Con_Filtro
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
        FieldName = 'NUMERO'
        Title.Caption = 'Numero Nota'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SERIE'
        Title.Caption = 'S'#233'rie Nota'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATADOCUMENTO'
        Title.Caption = 'Data Documento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMEROCGCMF'
        Title.Caption = 'CNPJ Destino'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMECLIENTE'
        Title.Caption = 'Nome Destino'
        Width = 276
        Visible = True
      end>
  end
  object Edit1: TEdit
    Left = 64
    Top = 304
    Width = 466
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
  end
  object BtnGerar: TButton
    Left = 455
    Top = 273
    Width = 99
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'Gerar Arquivo'
    TabOrder = 4
    OnClick = BtnGerarClick
  end
  object Button1: TButton
    Left = 530
    Top = 303
    Width = 22
    Height = 20
    Anchors = [akRight, akBottom]
    Caption = '...'
    TabOrder = 3
    OnClick = Button1Click
  end
end
