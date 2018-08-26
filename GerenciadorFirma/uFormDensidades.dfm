object FormDensidades: TFormDensidades
  Left = 0
  Top = 0
  Caption = 'Densidades'
  ClientHeight = 412
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 496
    Top = 0
    Width = 186
    Height = 412
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 287
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 379
    Height = 412
    Align = alLeft
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 209
      Width = 377
      Height = 202
      Align = alClient
      DataSource = DataSource2
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object DBGrid2: TDBGrid
      Left = 1
      Top = 1
      Width = 377
      Height = 208
      Align = alTop
      DataSource = DataSource1
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object Panel2: TPanel
    Left = 379
    Top = 0
    Width = 117
    Height = 412
    Align = alLeft
    TabOrder = 2
    ExplicitLeft = 408
    ExplicitTop = 104
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Button2: TButton
      Left = 6
      Top = 39
      Width = 106
      Height = 25
      Caption = 'Json to dataset'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 7
      Top = 8
      Width = 105
      Height = 25
      Caption = 'DataSet to JSon'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object DataSource1: TDataSource
    DataSet = CdsDensidade
    Left = 144
    Top = 80
  end
  object CdsDensidade: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODGRUPOSUB'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NOMESUBGRUPO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'DENSIDADE'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 320
    Top = 80
    object CdsDensidadeCODGRUPOSUB: TStringField
      FieldName = 'CODGRUPOSUB'
      Size = 10
    end
    object CdsDensidadeNOMESUBGRUPO: TStringField
      FieldName = 'NOMESUBGRUPO'
      Size = 25
    end
    object CdsDensidadeDENSIDADE: TFloatField
      FieldName = 'DENSIDADE'
    end
  end
  object CdsTeste: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODGRUPOSUB'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NOMESUBGRUPO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'DENSIDADE'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 320
    Top = 176
    object StringField1: TStringField
      FieldName = 'CODGRUPOSUB'
      Size = 10
    end
    object StringField2: TStringField
      FieldName = 'NOMESUBGRUPO'
      Size = 25
    end
    object FloatField1: TFloatField
      FieldName = 'DENSIDADE'
    end
  end
  object DataSource2: TDataSource
    DataSet = CdsTeste
    Left = 144
    Top = 176
  end
end
