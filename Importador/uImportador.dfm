object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 405
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 622
    Height = 41
    Align = alTop
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 383
      Top = 12
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        555555555555555555555555555555555555555FFFFFFFFFF555550000000000
        55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
        B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
        000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
        555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
        55555575FFF75555555555700007555555555557777555555555555555555555
        5555555555555555555555555555555555555555555555555555}
      NumGlyphs = 2
    end
    object Button1: TButton
      Left = 412
      Top = 9
      Width = 61
      Height = 25
      Caption = 'Carregar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object EditArquivo: TEdit
      Left = 51
      Top = 13
      Width = 333
      Height = 21
      TabOrder = 1
      Text = 'F:\GoldFly\Sistemas\transpaulo2015.csv'
    end
    object EditCodTransp: TEdit
      Left = 5
      Top = 13
      Width = 40
      Height = 21
      TabOrder = 2
      Text = '1'
    end
    object Button2: TButton
      Left = 478
      Top = 9
      Width = 61
      Height = 25
      Caption = 'Salvar'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 622
    Height = 364
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 620
      Height = 362
      Align = alClient
      DataSource = dts
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object ConSidicom: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxfb.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=F:\GoldFly\gold.fdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    VendorLib = 'fbclient.dll'
    Left = 160
    Top = 112
  end
  object Cds: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Cod'
        DataType = ftInteger
      end
      item
        Name = 'CodTransp'
        DataType = ftInteger
      end
      item
        Name = 'UF'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'destino'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'fretePorKG'
        DataType = ftFloat
      end
      item
        Name = 'freteValor'
        DataType = ftFloat
      end
      item
        Name = 'SecCat'
        DataType = ftFloat
      end
      item
        Name = 'Pedagio'
        DataType = ftFloat
      end
      item
        Name = 'frete10kg'
        DataType = ftFloat
      end
      item
        Name = 'frete20kg'
        DataType = ftFloat
      end
      item
        Name = 'frete30kg'
        DataType = ftFloat
      end
      item
        Name = 'frete50kg'
        DataType = ftFloat
      end
      item
        Name = 'frete70kg'
        DataType = ftFloat
      end
      item
        Name = 'frete100kg'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 296
    Top = 152
    Data = {
      1D0100009619E0BD01000000180000000E0000000000030000001D0103436F64
      040001000000000009436F645472616E73700400010000000000025546010049
      00000001000557494454480200020014000764657374696E6F01004900000001
      0005574944544802000200FA000A6672657465506F724B470800040000000000
      0A667265746556616C6F72080004000000000006536563436174080004000000
      0000075065646167696F080004000000000009667265746531306B6708000400
      0000000009667265746532306B67080004000000000009667265746533306B67
      080004000000000009667265746535306B670800040000000000096672657465
      37306B6708000400000000000A66726574653130306B67080004000000000000
      00}
    object CdsCod: TIntegerField
      FieldName = 'Cod'
    end
    object CdsCodTransp: TIntegerField
      FieldName = 'CodTransp'
    end
    object CdsUF: TStringField
      FieldName = 'UF'
    end
    object Cdsdestino: TStringField
      DisplayWidth = 30
      FieldName = 'destino'
      Size = 250
    end
    object CdsfretePorKG: TFloatField
      FieldName = 'fretePorKG'
    end
    object CdsfreteValor: TFloatField
      FieldName = 'freteValor'
    end
    object CdsSecCat: TFloatField
      FieldName = 'SecCat'
    end
    object CdsPedagio: TFloatField
      FieldName = 'Pedagio'
    end
    object Cdsfrete10kg: TFloatField
      FieldName = 'frete10kg'
    end
    object Cdsfrete20kg: TFloatField
      FieldName = 'frete20kg'
    end
    object Cdsfrete30kg: TFloatField
      FieldName = 'frete30kg'
    end
    object Cdsfrete50kg: TFloatField
      FieldName = 'frete50kg'
    end
    object Cdsfrete70kg: TFloatField
      FieldName = 'frete70kg'
    end
    object Cdsfrete100kg: TFloatField
      FieldName = 'frete100kg'
    end
  end
  object dts: TDataSource
    DataSet = Cds
    Left = 296
    Top = 216
  end
  object CustoFrete: TSQLTable
    MaxBlobSize = -1
    SQLConnection = ConSidicom
    TableName = 'CUSTOFRETE'
    Left = 376
    Top = 80
    object CustoFreteCOD: TIntegerField
      FieldName = 'COD'
      Required = True
    end
    object CustoFreteCODTRANSP: TIntegerField
      FieldName = 'CODTRANSP'
      Required = True
    end
    object CustoFreteUF: TStringField
      FieldName = 'UF'
      Required = True
      FixedChar = True
      Size = 2
    end
    object CustoFreteDESTINO: TStringField
      FieldName = 'DESTINO'
      Required = True
      Size = 100
    end
    object CustoFreteFRETEKG: TSingleField
      FieldName = 'FRETEKG'
    end
    object CustoFretePERCFRETEVALOR: TSingleField
      FieldName = 'PERCFRETEVALOR'
    end
    object CustoFreteSECCAT: TSingleField
      FieldName = 'SECCAT'
    end
    object CustoFretePEDAGIOPOR100: TSingleField
      FieldName = 'PEDAGIOPOR100'
    end
  end
  object FreteMin: TSQLTable
    MaxBlobSize = -1
    SQLConnection = ConSidicom
    TableName = 'FRETEMIN'
    Left = 376
    Top = 152
    object FreteMinCODFRETE: TIntegerField
      FieldName = 'CODFRETE'
    end
    object FreteMinPESOMIN: TSingleField
      FieldName = 'PESOMIN'
    end
    object FreteMinPESOMAX: TSingleField
      FieldName = 'PESOMAX'
    end
    object FreteMinVALOR: TSingleField
      FieldName = 'VALOR'
    end
  end
  object Query: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = ConSidicom
    Left = 376
    Top = 224
  end
end
