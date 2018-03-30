object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'FormMistura'
  ClientHeight = 257
  ClientWidth = 564
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 564
    Height = 257
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 328
    object TabSheet1: TTabSheet
      Caption = 'Opcoes'
      ExplicitLeft = -76
      ExplicitTop = 32
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 556
        Height = 229
        Align = alClient
        ParentBackground = False
        TabOrder = 0
        ExplicitLeft = 160
        ExplicitTop = 112
        ExplicitWidth = 185
        ExplicitHeight = 41
        object Label1: TLabel
          Left = 20
          Top = 27
          Width = 78
          Height = 13
          Alignment = taRightJustify
          Caption = 'Codigo Produto:'
        end
        object Label2: TLabel
          Left = 35
          Top = 67
          Width = 63
          Height = 13
          Alignment = taRightJustify
          Caption = 'Volume linha:'
        end
        object Label3: TLabel
          Left = 38
          Top = 115
          Width = 60
          Height = 13
          Alignment = taRightJustify
          Caption = 'Quantidade:'
        end
        object Edit1: TEdit
          Left = 104
          Top = 24
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object Edit2: TEdit
          Left = 104
          Top = 64
          Width = 121
          Height = 21
          TabOrder = 1
        end
        object BitBtn1: TBitBtn
          Left = 256
          Top = 184
          Width = 75
          Height = 25
          Kind = bkOK
          NumGlyphs = 2
          TabOrder = 2
        end
        object Edit3: TEdit
          Left = 104
          Top = 112
          Width = 121
          Height = 21
          TabOrder = 3
        end
      end
    end
    object Ajustes: TTabSheet
      Caption = 'Ajustes'
      ImageIndex = 1
      ExplicitHeight = 300
    end
    object Insumos: TTabSheet
      Caption = 'Insumos'
      ImageIndex = 2
      ExplicitHeight = 300
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 556
        Height = 229
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = CdsConversor
    Left = 496
    Top = 48
  end
  object CdsConversor: TClientDataSet
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
    Left = 336
    Top = 53
    Data = {
      CA0000009619E0BD010000001800000008000000000003000000CA0009434F44
      494E53554D4F01004900000001000557494454480200020014000A4E4F4D4549
      4E53554D4F01004900000001000557494454480200020064000944454E534944
      4144450800040000000000064C4954524F5308000400000000000A4B494C4F53
      544F54414C08000400000000000C4B494C4F535041524349414C080004000000
      00000D50455243454E54564F4C554D4508000400000000000B50455243454E54
      5045534F08000400000000000000}
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
