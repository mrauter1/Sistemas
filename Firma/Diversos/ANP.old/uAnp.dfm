object fAnp: TfAnp
  Left = 172
  Top = 137
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Anp'
  ClientHeight = 303
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 9
    Top = 72
    Width = 264
    Height = 21
    Progress = 0
  end
  object Label2: TLabel
    Left = 12
    Top = 108
    Width = 39
    Height = 13
    Caption = 'Diret'#243'rio'
  end
  object GroupBox1: TGroupBox
    Left = 9
    Top = 8
    Width = 360
    Height = 57
    Caption = 'Gerar arquivos com data de emiss'#227'o do m'#234's de'
    TabOrder = 0
    object Label1: TLabel
      Left = 184
      Top = 29
      Width = 12
      Height = 13
      Caption = 'de'
    end
    object CBXMes: TComboBox
      Left = 8
      Top = 24
      Width = 145
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Janeiro'
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
      Left = 224
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 1
    end
  end
  object BtnGerar: TButton
    Left = 279
    Top = 72
    Width = 90
    Height = 22
    Caption = 'Gerar Arquivo'
    TabOrder = 1
    OnClick = BtnGerarClick
  end
  object Button1: TButton
    Left = 348
    Top = 105
    Width = 22
    Height = 20
    Caption = '...'
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 56
    Top = 104
    Width = 292
    Height = 21
    TabOrder = 3
  end
  object DBGrid: TDBGrid
    Left = 6
    Top = 128
    Width = 363
    Height = 169
    DataSource = Dtm_Anp.DS_MovCli
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
end
