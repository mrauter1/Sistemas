object FrmRefreshData: TFrmRefreshData
  Left = 0
  Top = 0
  Caption = 'FrmRefreshData'
  ClientHeight = 411
  ClientWidth = 679
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 337
    Height = 200
    Align = alLeft
    Lines.Strings = (
      'SELECT CODCLIENTE, RAZAOSOCIAL FROM CLIENTE')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 200
    Width = 679
    Height = 211
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 1
    DesignSize = (
      679
      211)
    object EditNomeTabela: TEdit
      Left = 120
      Top = 177
      Width = 241
      Height = 21
      Anchors = [akLeft, akBottom]
      TabOrder = 0
      Text = 'CLIENTE'
    end
    object Button1: TButton
      Left = 392
      Top = 177
      Width = 118
      Height = 25
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Exec'
      TabOrder = 1
      OnClick = Button1Click
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 677
      Height = 170
      Align = alTop
      DataSource = DataSource1
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object Button2: TButton
      Left = 528
      Top = 177
      Width = 118
      Height = 25
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Criar'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object DBGrid2: TDBGrid
    Left = 337
    Top = 0
    Width = 342
    Height = 200
    Align = alClient
    DataSource = DsFirebird
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object QryFirebird: TFDQuery
    Connection = DataModule1.FDConFirebird
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtWideString
        TargetDataType = dtAnsiString
      end>
    SQL.Strings = (
      'SELECT codcliente, observacao FROM CLIENTE')
    Left = 176
    Top = 8
    object QryFirebirdCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      Origin = 'CODCLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryFirebirdOBSERVACAO: TMemoField
      FieldName = 'OBSERVACAO'
      Origin = 'OBSERVACAO'
      BlobType = ftMemo
    end
  end
  object FDTable1: TFDTable
    Connection = DataModule1.FDConPostgres
    UpdateOptions.UpdateTableName = 'PRODUTO'
    TableName = 'PRODUTO'
    Left = 360
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = FDTableResult
    Left = 280
    Top = 240
  end
  object DsFirebird: TDataSource
    DataSet = QryResultFb
    Left = 88
    Top = 80
  end
  object FDBatchMove: TFDBatchMove
    Mappings = <>
    LogFileName = 'Data.log'
    Left = 520
    Top = 64
  end
  object FDTableResult: TFDTable
    Connection = DataModule1.FDConPostgres
    UpdateOptions.UpdateTableName = 'cliente'
    TableName = 'cliente'
    Left = 376
    Top = 240
    object FDTableResultcodcliente: TStringField
      FieldName = 'codcliente'
      Origin = 'codcliente'
      Size = 6
    end
    object FDTableResultrazaosocial: TStringField
      FieldName = 'razaosocial'
      Origin = 'razaosocial'
      Size = 80
    end
    object FDTableResultobservacao: TWideMemoField
      FieldName = 'observacao'
      Origin = 'observacao'
      BlobType = ftWideMemo
    end
  end
  object QryResultFb: TFDQuery
    Connection = DataModule1.FDConFirebird
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtWideString
        TargetDataType = dtAnsiString
      end>
    SQL.Strings = (
      'SELECT CODCLIENTE, OBSERVACAO FROM CLIENTE')
    Left = 176
    Top = 80
    object QryResultFbCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      Origin = 'CODCLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryResultFbOBSERVACAO: TMemoField
      FieldName = 'OBSERVACAO'
      Origin = 'OBSERVACAO'
      BlobType = ftMemo
    end
  end
end
