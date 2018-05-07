object FormGlobal: TFormGlobal
  Left = 0
  Top = 0
  Caption = 'FormGlobal'
  ClientHeight = 222
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxStyleRepository1: TcxStyleRepository
    Left = 187
    Top = 80
    PixelsPerInch = 96
    object cxStyleLinhaPar: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 12961221
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10066329
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyleLinhaImpar: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 5491711
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyleGroup: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object cxGridTableViewStyleSheet1: TcxGridTableViewStyleSheet
      Styles.ContentEven = cxStyleLinhaImpar
      Styles.ContentOdd = cxStyleLinhaPar
      Styles.Group = cxStyleGroup
      BuiltIn = True
    end
  end
end
