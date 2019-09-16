object Form1: TForm1
  Left = -8
  Top = 116
  Width = 1017
  Height = 328
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 25
    Width = 1009
    Height = 276
    Align = alClient
    BorderStyle = bsNone
    DataSource = DsOrcamento
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Numero'
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRAZO'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FRETE'
        Width = 87
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENTREGA'
        Width = 143
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBSERVACAO'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPNOME'
        Width = 135
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPENDERECO'
        Width = 144
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPFONE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPFAX'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPCEP'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPCNPJ'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPIE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VENNOME'
        Width = 201
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VENFONE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VENEMAIL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLINOME'
        Width = 161
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIENDERECO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLICONTATO'
        Width = 210
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIEMAIL'
        Width = 207
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 0
    Width = 1009
    Height = 25
    DataSource = DsOrcamento
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
    Align = alTop
    TabOrder = 1
  end
  object DsOrcamento: TDataSource
    DataSet = DataModule1.CdsOrcamento
    Left = 56
  end
end
