object FormConfiguraTextoEmailEmbalagem: TFormConfiguraTextoEmailEmbalagem
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight]
  Caption = 'Configurar Texto de Envio de Email de Embalagem'
  ClientHeight = 447
  ClientWidth = 600
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
  object PanelBottom: TPanel
    Left = 0
    Top = 412
    Width = 600
    Height = 35
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      600
      35)
    object BtnOK: TButton
      Left = 260
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop]
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOKClick
    end
    object BtnAddImage: TButton
      Left = 448
      Top = 6
      Width = 114
      Height = 25
      Anchors = [akTop]
      Caption = 'Adicionar Imagem'
      TabOrder = 1
      OnClick = BtnAddImageClick
    end
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 600
    Height = 412
    Align = alClient
    TabOrder = 1
    DesignSize = (
      596
      408)
    object Label3: TLabel
      Left = 48
      Top = 22
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'T'#237'tulo'
    end
    object Label1: TLabel
      Left = 21
      Top = 53
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Introdu'#231#227'o'
    end
    object Label2: TLabel
      Left = 23
      Top = 152
      Width = 51
      Height = 26
      Alignment = taRightJustify
      Caption = 'Pol'#237'tica de devolu'#231#227'o'
      WordWrap = True
    end
    object Label4: TLabel
      Left = 23
      Top = 291
      Width = 51
      Height = 13
      Alignment = taRightJustify
      Caption = 'Assinatura'
      WordWrap = True
    end
    object DBEditUser: TDBEdit
      Left = 80
      Top = 19
      Width = 480
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Titulo'
      DataSource = DsTextoEmail
      TabOrder = 0
    end
    object DBMemoIntroducao: TDBMemo
      Left = 80
      Top = 54
      Width = 480
      Height = 89
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Introducao'
      DataSource = DsTextoEmail
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object DBMemoPolitica: TDBMemo
      Left = 80
      Top = 149
      Width = 480
      Height = 123
      Anchors = [akLeft, akTop, akRight]
      DataField = 'PoliticaDevolucao'
      DataSource = DsTextoEmail
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object DBMemoAssinatura: TDBMemo
      Left = 80
      Top = 289
      Width = 480
      Height = 101
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Assinatura'
      DataSource = DsTextoEmail
      ScrollBars = ssVertical
      TabOrder = 3
    end
  end
  object QryTextoEmail: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from ModeloEmailEmbalagem'
      'where'
      '  Identificador = '#39'EMBALAGEM'#39)
    Left = 240
    Top = 111
    object QryTextoEmailIdentificador: TStringField
      FieldName = 'Identificador'
      Required = True
      FixedChar = True
      Size = 10
    end
    object QryTextoEmailTitulo: TStringField
      FieldName = 'Titulo'
      FixedChar = True
      Size = 255
    end
    object QryTextoEmailIntroducao: TMemoField
      FieldName = 'Introducao'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryTextoEmailPoliticaDevolucao: TMemoField
      FieldName = 'PoliticaDevolucao'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryTextoEmailAssinatura: TMemoField
      FieldName = 'Assinatura'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object DsTextoEmail: TDataSource
    DataSet = QryTextoEmail
    Left = 328
    Top = 111
  end
end
