object FormSelecionaEmailCliente: TFormSelecionaEmailCliente
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Selecione os emails do cliente'
  ClientHeight = 254
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 489
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 176
    ExplicitTop = 48
    ExplicitWidth = 185
    object BtnSelecionar: TButton
      Left = 384
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Selecionar'
      TabOrder = 0
      OnClick = BtnSelecionarClick
    end
    object EditEmails: TEdit
      Left = 16
      Top = 14
      Width = 353
      Height = 21
      TabOrder = 1
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 489
    Height = 213
    Align = alClient
    DataSource = DsContatosCliente
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CONTATO'
        Width = 149
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Width = 182
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE'
        Visible = True
      end>
  end
  object QryContatosCliente: TFDQuery
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      'select *'
      'from CLIENTEFONE'
      'where CodCliente =:CodCliente'
      'order by CodSequencia')
    Left = 136
    Top = 112
    ParamData = <
      item
        Name = 'CODCLIENTE'
        DataType = ftFixedChar
        ParamType = ptInput
        Size = 6
      end>
    object QryContatosClienteCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      Origin = 'CODCLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
      FixedChar = True
      Size = 6
    end
    object QryContatosClienteCODSEQUENCIA: TIntegerField
      FieldName = 'CODSEQUENCIA'
      Origin = 'CODSEQUENCIA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object QryContatosClienteCONTATO: TStringField
      DisplayLabel = 'Contato'
      FieldName = 'CONTATO'
      Origin = 'CONTATO'
      Size = 40
    end
    object QryContatosClienteEMAIL: TStringField
      DisplayLabel = 'Email'
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 80
    end
    object QryContatosClienteTELEFONE: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      FixedChar = True
      Size = 15
    end
  end
  object DsContatosCliente: TDataSource
    AutoEdit = False
    DataSet = QryContatosCliente
    Left = 288
    Top = 112
  end
  object PopupMenu1: TPopupMenu
    Left = 432
    Top = 72
    object AdicionarEmail1: TMenuItem
      Caption = 'Adicionar Email'
      OnClick = AdicionarEmail1Click
    end
  end
end
