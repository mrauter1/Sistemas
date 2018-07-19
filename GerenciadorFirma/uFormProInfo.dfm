object FormProInfo: TFormProInfo
  Left = 0
  Top = 0
  Caption = 'Configura'#231#227'o dos Produtos'
  ClientHeight = 272
  ClientWidth = 679
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
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 679
    Height = 272
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -8
    ExplicitWidth = 578
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
        end
        item
          Kind = skSum
        end
        item
          Kind = skSum
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridDBTableViewCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
        Width = 56
      end
      object cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn
        Caption = 'Nome Pro'
        DataBinding.FieldName = 'APRESENTACAO'
        Width = 200
      end
      object cxGridDBTableViewNAOFAZESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'NAOFAZESTOQUE'
        Width = 54
      end
      object cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'ESPACOESTOQUE'
        Width = 72
      end
      object cxGridDBTableViewPRODUCAOMINIMA: TcxGridDBColumn
        DataBinding.FieldName = 'PRODUCAOMINIMA'
        Width = 68
      end
      object cxGridDBTableViewSOMANOPESOLIQ: TcxGridDBColumn
        DataBinding.FieldName = 'SOMANOPESOLIQ'
        Width = 55
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object DataSource1: TDataSource
    DataSet = QryProInfo
    Left = 176
    Top = 80
  end
  object QryProInfo: TFDQuery
    Connection = DmCon.FDConSqlServer
    SQL.Strings = (
      'select * '
      'from PROINFO')
    Left = 408
    Top = 80
    object QryProInfoCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Origin = 'CODPRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 6
    end
    object QryProInfoNAOFAZESTOQUE: TBooleanField
      DisplayLabel = 'N'#227'o Faz Estoque'
      FieldName = 'NAOFAZESTOQUE'
      Origin = 'NAOFAZESTOQUE'
    end
    object QryProInfoESPACOESTOQUE: TIntegerField
      DisplayLabel = 'Espa'#231'o Estoque'
      FieldName = 'ESPACOESTOQUE'
      Origin = 'ESPACOESTOQUE'
    end
    object QryProInfoPRODUCAOMINIMA: TIntegerField
      DisplayLabel = 'Produ'#231#227'o Minima'
      FieldName = 'PRODUCAOMINIMA'
      Origin = 'PRODUCAOMINIMA'
    end
    object QryProInfoSOMANOPESOLIQ: TBooleanField
      DisplayLabel = 'Soma no Peso Liq.'
      FieldName = 'SOMANOPESOLIQ'
      Origin = 'SOMANOPESOLIQ'
    end
    object QryProInfoAPRESENTACAO: TStringField
      FieldKind = fkCalculated
      FieldName = 'APRESENTACAO'
      ReadOnly = True
      Size = 80
      Calculated = True
    end
  end
end
