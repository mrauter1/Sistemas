object fNota: TfNota
  Left = 338
  Top = 265
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Notas'
  ClientHeight = 394
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 12
    Top = 369
    Width = 39
    Height = 13
    Caption = 'Diret'#243'rio'
  end
  object Gauge1: TGauge
    Left = 8
    Top = 336
    Width = 433
    Height = 21
    Progress = 0
  end
  object RadioGroup: TRadioGroup
    Left = 8
    Top = 16
    Width = 545
    Height = 65
    BiDiMode = bdLeftToRight
    Caption = 'Destino'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'MARCOPOLO'
      'CIFERAL'
      'SYNCROPARTS')
    ParentBiDiMode = False
    TabOrder = 0
    OnClick = RadioGroupClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 88
    Width = 545
    Height = 57
    Caption = 'Gerar arquivos com data de emiss'#227'o entre'
    TabOrder = 1
    object Label1: TLabel
      Left = 269
      Top = 27
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object DataINI: TDateTimePicker
      Left = 32
      Top = 24
      Width = 186
      Height = 21
      Date = 38700.414907581020000000
      Time = 38700.414907581020000000
      TabOrder = 0
      OnChange = DataINIChange
    end
    object DataFim: TDateTimePicker
      Left = 328
      Top = 24
      Width = 186
      Height = 21
      Date = 38700.415362407410000000
      Time = 38700.415362407410000000
      TabOrder = 1
      OnChange = DataINIChange
    end
  end
  object DBGrid: TDBGrid
    Left = 8
    Top = 160
    Width = 545
    Height = 169
    DataSource = Dtm_Notas.Con_Filtro
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object BtnGerar: TButton
    Left = 456
    Top = 336
    Width = 99
    Height = 25
    Caption = 'Gerar Arquivo'
    TabOrder = 3
    OnClick = BtnGerarClick
  end
  object Edit1: TEdit
    Left = 64
    Top = 366
    Width = 465
    Height = 21
    TabOrder = 4
  end
  object Button1: TButton
    Left = 529
    Top = 366
    Width = 22
    Height = 20
    Caption = '...'
    TabOrder = 5
    OnClick = Button1Click
  end
end
