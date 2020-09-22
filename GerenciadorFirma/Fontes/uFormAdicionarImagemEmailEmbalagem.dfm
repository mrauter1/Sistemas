object FormAdicionarImagemEmailEmbalagem: TFormAdicionarImagemEmailEmbalagem
  Left = 0
  Top = 0
  Caption = 'FormAdicionarImagemEmailEmbalagem'
  ClientHeight = 375
  ClientWidth = 632
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
  object Image1: TImage
    Left = 254
    Top = 0
    Width = 378
    Height = 334
    Align = alClient
    ExplicitLeft = 384
    ExplicitTop = 104
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object PanelBot: TPanel
    Left = 0
    Top = 334
    Width = 632
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      632
      41)
    object BtnOK: TButton
      Left = 275
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop]
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOKClick
    end
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 254
    Height = 334
    Align = alLeft
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 252
      Height = 307
      Align = alClient
      DataSource = DsImagemEmail
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'identificador'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'IdImagem'
          Width = 147
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Imagem'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ext'
          ReadOnly = True
          Width = 55
          Visible = True
        end>
    end
    object DBNavigator1: TDBNavigator
      Left = 1
      Top = 308
      Width = 252
      Height = 25
      DataSource = DsImagemEmail
      VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel]
      Align = alBottom
      TabOrder = 1
    end
  end
  object DsImagemEmail: TDataSource
    DataSet = QryImagemEmail
    Left = 328
    Top = 159
  end
  object QryImagemEmail: TFDQuery
    AfterOpen = QryImagemEmailAfterOpen
    AfterInsert = QryImagemEmailAfterInsert
    AfterScroll = QryImagemEmailAfterScroll
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from ModeloEmailImagens'
      'where'
      '  Identificador = '#39'EMBALAGEM'#39)
    Left = 472
    Top = 159
    object QryImagemEmailidentificador: TStringField
      FieldName = 'identificador'
      Required = True
      FixedChar = True
      Size = 10
    end
    object QryImagemEmailIdImagem: TStringField
      DisplayLabel = 'Identificador'
      DisplayWidth = 10
      FieldName = 'IdImagem'
      Required = True
      Size = 255
    end
    object QryImagemEmailImagem: TBlobField
      FieldName = 'Imagem'
      Size = 2147483647
    end
    object QryImagemEmailext: TStringField
      DisplayLabel = 'Extens'#227'o'
      FieldName = 'ext'
      Origin = 'ext'
      Size = 255
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Images|*.png;*.jpeg;*.jpg|jpeg|*.jpeg;*.jpg|png|*.png'
    Left = 392
    Top = 64
  end
end
