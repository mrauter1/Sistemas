object FormConversorLKG: TFormConversorLKG
  Left = 0
  Top = 0
  Caption = 'Conversor L - KG'
  ClientHeight = 329
  ClientWidth = 554
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
    Top = 150
    Width = 554
    Height = 179
    Align = alBottom
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 105
    Align = alTop
    TabOrder = 1
    object label1: TLabel
      Left = 56
      Top = 16
      Width = 74
      Height = 13
      Caption = 'C'#243'digo Modelo:'
    end
    object lblName: TLabel
      Left = 295
      Top = 9
      Width = 58
      Height = 19
      Caption = 'lblName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 41
      Width = 63
      Height = 13
      Caption = 'Multiplicador:'
    end
    object Label3: TLabel
      Left = 226
      Top = 41
      Width = 60
      Height = 13
      Caption = 'Quantidade:'
    end
    object Label4: TLabel
      Left = 16
      Top = 71
      Width = 66
      Height = 13
      Caption = 'Volume linha: '
    end
    object Label7: TLabel
      Left = 226
      Top = 70
      Width = 58
      Height = 13
      Caption = 'QuantTotal:'
    end
    object EditModelo: TEdit
      Left = 144
      Top = 11
      Width = 145
      Height = 21
      TabOrder = 0
      OnExit = EditModeloExit
    end
    object btnOK: TBitBtn
      Left = 460
      Top = 35
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
    object EditMultiplicador: TEdit
      Left = 89
      Top = 37
      Width = 105
      Height = 21
      TabOrder = 2
      Text = '0,995'
    end
    object EditQuantidade: TEdit
      Left = 292
      Top = 38
      Width = 105
      Height = 21
      TabOrder = 3
      Text = '1000'
    end
    object EditVolumeLinha: TEdit
      Left = 88
      Top = 64
      Width = 105
      Height = 21
      TabOrder = 4
      Text = '28'
    end
    object EditQuantTotal: TEdit
      Left = 290
      Top = 65
      Width = 105
      Height = 21
      Color = clMenuBar
      ReadOnly = True
      TabOrder = 5
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 105
    Width = 554
    Height = 45
    Align = alClient
    TabOrder = 2
    object Label5: TLabel
      Left = 20
      Top = 16
      Width = 101
      Height = 13
      Caption = 'Densidade calculada:'
    end
    object Label6: TLabel
      Left = 338
      Top = 16
      Width = 52
      Height = 13
      Caption = 'Peso total:'
    end
    object EditDensidadeCalc: TEdit
      Left = 127
      Top = 13
      Width = 105
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object EditPesoTotal: TEdit
      Left = 396
      Top = 13
      Width = 105
      Height = 21
      TabOrder = 1
      Text = '1000'
    end
  end
  object DataSource1: TDataSource
    DataSet = CdsConversor
    Left = 208
    Top = 61
  end
  object CdsConversor: TClientDataSet
    PersistDataPacket.Data = {
      CA0000009619E0BD010000001800000008000000000003000000CA0009434F44
      494E53554D4F01004900000001000557494454480200020014000A4E4F4D4549
      4E53554D4F01004900000001000557494454480200020064000944454E534944
      4144450800040000000000064C4954524F5308000400000000000A4B494C4F53
      544F54414C08000400000000000C4B494C4F535041524349414C080004000000
      00000D50455243454E54564F4C554D4508000400000000000B50455243454E54
      5045534F08000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODINSUMO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NOMEINSUMO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'DENSIDADE'
        DataType = ftFloat
      end
      item
        Name = 'LITROS'
        DataType = ftFloat
      end
      item
        Name = 'KILOSTOTAL'
        DataType = ftFloat
      end
      item
        Name = 'KILOSPARCIAL'
        DataType = ftFloat
      end
      item
        Name = 'PERCENTVOLUME'
        DataType = ftFloat
      end
      item
        Name = 'PERCENTPESO'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 312
    Top = 61
    object CdsConversorCODINSUMO: TStringField
      DisplayWidth = 10
      FieldName = 'CODINSUMO'
    end
    object CdsConversorNOMEINSUMO: TStringField
      DisplayWidth = 25
      FieldName = 'NOMEINSUMO'
      Size = 100
    end
    object CdsConversorDENSIDADE: TFloatField
      FieldName = 'DENSIDADE'
    end
    object CdsConversorLITROS: TFloatField
      FieldName = 'LITROS'
    end
    object CdsConversorKILOSTOTAL: TFloatField
      FieldName = 'KILOSTOTAL'
    end
    object CdsConversorKILOSPARCIAL: TFloatField
      FieldName = 'KILOSPARCIAL'
    end
    object CdsConversorPERCENTVOLUME: TFloatField
      FieldName = 'PERCENTVOLUME'
    end
    object CdsConversorPERCENTPESO: TFloatField
      FieldName = 'PERCENTPESO'
    end
  end
end
