object fDNF: TfDNF
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'DNF'
  ClientHeight = 313
  ClientWidth = 564
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
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 8
    Top = 256
    Width = 433
    Height = 21
    Progress = 0
  end
  object Label2: TLabel
    Left = 12
    Top = 292
    Width = 39
    Height = 13
    Caption = 'Diret'#243'rio'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 545
    Height = 57
    Caption = 'Gerar arquivos com data de emiss'#227'o do m'#234's de'
    TabOrder = 0
    object Label1: TLabel
      Left = 264
      Top = 29
      Width = 12
      Height = 13
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
      Left = 352
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 1
      OnExit = EditAnoExit
      OnKeyDown = EditAnoKeyDown
    end
  end
  object DBGrid: TDBGrid
    Left = 8
    Top = 80
    Width = 545
    Height = 169
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
        Width = 64
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
    Top = 286
    Width = 465
    Height = 21
    TabOrder = 2
  end
  object BtnGerar: TButton
    Left = 456
    Top = 256
    Width = 99
    Height = 25
    Caption = 'Gerar Arquivo'
    TabOrder = 4
    OnClick = BtnGerarClick
  end
  object Button1: TButton
    Left = 529
    Top = 286
    Width = 22
    Height = 20
    Caption = '...'
    TabOrder = 3
    OnClick = Button1Click
  end
end
