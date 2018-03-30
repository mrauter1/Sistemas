object FormProInfo: TFormProInfo
  Left = 0
  Top = 0
  ClientHeight = 272
  ClientWidth = 578
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 578
    Height = 272
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    DataSet = CdsProInfo
    Left = 176
    Top = 80
  end
  object CdsProInfo: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODPRODUTO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'NAOFAZESTOQUE'
        DataType = ftBoolean
      end
      item
        Name = 'ESPACOESTOQUE'
        DataType = ftInteger
      end
      item
        Name = 'PRODUCAOMINIMA'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 320
    Top = 80
    object CdsProInfoCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Size = 10
    end
    object CdsProInfoNAOFAZESTOQUE: TBooleanField
      FieldName = 'NAOFAZESTOQUE'
    end
    object CdsProInfoESPACOESTOQUE: TIntegerField
      FieldName = 'ESPACOESTOQUE'
    end
    object CdsProInfoPRODUCAOMINIMA: TIntegerField
      FieldName = 'PRODUCAOMINIMA'
    end
  end
end
