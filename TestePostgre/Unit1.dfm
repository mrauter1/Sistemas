object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 307
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 527
    Height = 307
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'teste'
    DriverName = 'ODBC'
    LoginPrompt = False
    Params.Strings = (
      'drivername=ODBC'
      'hostname=127.0.0.1'
      'Database=PostgreSQL35W'
      'user_name=postgres'
      'password=28021990')
    Connected = True
    Left = 72
    Top = 40
  end
  object SQLQuery1: TSQLQuery
    MaxBlobSize = 1
    Params = <>
    SQL.Strings = (
      'select * from cadastro')
    SQLConnection = SQLConnection1
    Left = 248
    Top = 24
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = SQLQuery1
    Left = 248
    Top = 88
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 248
    Top = 152
    object ClientDataSet1ID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ClientDataSet1NOME: TWideMemoField
      FieldName = 'NOME'
      BlobType = ftWideMemo
      Size = 1
    end
    object ClientDataSet1CPF: TWideMemoField
      FieldName = 'CPF'
      BlobType = ftWideMemo
      Size = 1
    end
    object ClientDataSet1FONE: TWideMemoField
      FieldName = 'FONE'
      BlobType = ftWideMemo
      Size = 1
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 376
    Top = 152
  end
end
