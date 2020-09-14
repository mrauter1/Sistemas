object FormConfigurarEmailEmbalagens: TFormConfigurarEmailEmbalagens
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Configurar Email de Envio de Embalagens'
  ClientHeight = 219
  ClientWidth = 494
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
  object Label3: TLabel
    Left = 111
    Top = 30
    Width = 36
    Height = 13
    Alignment = taRightJustify
    Caption = 'Usu'#225'rio'
  end
  object Label1: TLabel
    Left = 117
    Top = 57
    Width = 30
    Height = 13
    Alignment = taRightJustify
    Caption = 'Senha'
  end
  object Label2: TLabel
    Left = 78
    Top = 85
    Width = 69
    Height = 13
    Alignment = taRightJustify
    Caption = 'Servidor SMTP'
  end
  object Label4: TLabel
    Left = 121
    Top = 111
    Width = 26
    Height = 13
    Alignment = taRightJustify
    Caption = 'Porta'
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 184
    Width = 494
    Height = 35
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 216
    ExplicitWidth = 495
    DesignSize = (
      494
      35)
    object BtnOK: TButton
      Left = 208
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akTop]
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOKClick
    end
  end
  object DBCheckBox1: TDBCheckBox
    Left = 49
    Top = 142
    Width = 127
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Requer Autentica'#231#227'o'
    DataField = 'requireAuth'
    DataSource = DsEmail
    TabOrder = 1
  end
  object DBEditUser: TDBEdit
    Left = 161
    Top = 27
    Width = 256
    Height = 21
    DataField = 'Usuario'
    DataSource = DsEmail
    TabOrder = 2
  end
  object DBEditSenha: TDBEdit
    Left = 161
    Top = 54
    Width = 256
    Height = 21
    DataField = 'Password'
    DataSource = DsEmail
    TabOrder = 3
  end
  object DBEditServidor: TDBEdit
    Left = 161
    Top = 81
    Width = 256
    Height = 21
    DataField = 'SMTPServer'
    DataSource = DsEmail
    TabOrder = 4
  end
  object DBEditPorta: TDBEdit
    Left = 161
    Top = 108
    Width = 88
    Height = 21
    BiDiMode = bdLeftToRight
    DataField = 'Port'
    DataSource = DsEmail
    ParentBiDiMode = False
    TabOrder = 5
  end
  object QryEmail: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select *'
      'from EmailEmbalagem'
      'where'
      '  Identificador = '#39'EMBALAGEM'#39)
    Left = 272
    Top = 119
    object QryEmailIdentificador: TStringField
      FieldName = 'Identificador'
      Origin = 'Identificador'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 10
    end
    object QryEmailUsuario: TStringField
      FieldName = 'Usuario'
      Origin = 'Usuario'
      Size = 255
    end
    object QryEmailPassword: TStringField
      FieldName = 'Password'
      Origin = 'Password'
      Size = 255
    end
    object QryEmailSMTPServer: TStringField
      FieldName = 'SMTPServer'
      Origin = 'SMTPServer'
      Size = 255
    end
    object QryEmailPort: TIntegerField
      FieldName = 'Port'
      Origin = 'Port'
    end
    object QryEmailrequireAuth: TBooleanField
      FieldName = 'requireAuth'
      Origin = 'requireAuth'
    end
  end
  object DsEmail: TDataSource
    DataSet = QryEmail
    Left = 360
    Top = 119
  end
end
