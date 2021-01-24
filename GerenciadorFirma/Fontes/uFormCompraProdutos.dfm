object FormCompraProduto: TFormCompraProduto
  Left = 0
  Top = 0
  Caption = 'Compras do Produto'
  ClientHeight = 288
  ClientWidth = 734
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 734
    Height = 59
    Align = alTop
    TabOrder = 0
    ExplicitLeft = -1
    ExplicitTop = -5
    DesignSize = (
      734
      59)
    object Label1: TLabel
      Left = 40
      Top = 14
      Width = 85
      Height = 13
      Caption = 'Grupo do Produto'
    end
    object LabelNomeProduto: TLabel
      Left = 247
      Top = 14
      Width = 90
      Height = 13
      Caption = 'LabelNomeProduto'
    end
    object btnOK: TBitBtn
      Left = 658
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnOKClick
    end
    object EditGrupo: TEdit
      Left = 131
      Top = 12
      Width = 79
      Height = 21
      Color = clMedGray
      ReadOnly = True
      TabOrder = 1
    end
    object BtnSelGrupo: TBitBtn
      Left = 214
      Top = 10
      Width = 26
      Height = 25
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000060D17261737
        64B70A182D6B0001021A0000000C000000040000000100000000000000000000
        0000000000000000000000000000000000000000000000000000274776CE2A5D
        9EFF5180B6FF1F4986F111274BA5050B15460000001400000009000000020000
        0000000000000000000000000000000000000000000000000000284B7AD2295E
        A0FFA6CEE8FF75C2EBFF3A85C1FF265799FF173569DB0C1A328B0203072E0000
        0010000000060000000100000000000000000000000000000000294D7CD23467
        A8FF8DB4D8FF99DAF7FF58BCEFFF4CB1EBFF378FCFFF2664A6FF1F407DFB1223
        4BBF070D1C65000000190000000B0000000300000000000000002A4F7FD24678
        B1FF6E9AC7FFB5E5FAFF5FC2F1FF52B6ECFF44AAE6FF389CDFFF2C8DD5FF2069
        B1FF1C498CFF182E63ED0D18359E03050B3300000005000000002A5282D2628F
        BEFF4C7EB7FFD0EFFCFF64C6F3FF59BDEFFF4CB1EAFF3EA3E2FF3296DCFF2789
        D5FF1E7ECFFF186DBEFF175099FF18336EF703060D37000000022A5384D288AD
        D1FF2D67ACFFDAF2FCFF7CD2F5FF5FC3F2FF54B9EDFF46ABE6FF399CDFFF2D90
        D9FF2285D2FF1B79CDFF1572C7FF164991FF0B132B86000000072C5586D2A5C5
        DEFF3675B4FFC0DAEDFFA0DFF9FF65C8F3FF5ABEF1FF4DB2EAFF3FA5E3FF3498
        DCFF288CD7FF2080D0FF1977CBFF1659A6FF111F43BB0000000C2C5689D2BAD5
        E8FF589CCEFF8DB2D6FFC6EDFCFF91D8F8FF69C7F3FF56BBEFFF48ADE7FF3BA0
        E0FF2F93DBFF2487D4FF1D7ECFFF186CBDFF172C5EE7000000132C598AD2C7DC
        ECFF7FC7E7FF5688BEFFA1C1DFFFCEE7F6FFD0EEFCFFABDFF8FF81CAF1FF57B0
        E8FF379CDFFF2B8FD8FF2384D3FF1A79CDFF1C3A77FD020306282E5C8ED2D1E3
        F0FFA3E8FDFF6DBBE2FF4A91C7FF2D69ADFF4B7CB5FF77A1CBFF9BC4E3FFAADA
        F5FF8DCAEFFF5DADE4FF3995DBFF2082D2FF1C498EFF080E1E60316091D2D5E4
        F1FFF0FCFFFFD0F4FFFFA9EBFDFF8CE2FDFF8FCBE9FF76A5CFFF3F76AFFF3261
        9FFF5E8CBDFF76ABD7FF7BBCE9FF60A9E2FF2B64A7FF0E1B3892172C425D3C71
        A7ED79A1C9FFBBD3E6FFE8F8FDFF91B4D3FF4573A8FF779FC4FFAED3E8FFB1DD
        F2FF6CA1CBFF386CA7FF2B5594FF4476AEFF4C88C2FF142953BC000000000203
        040615283B542C537CB43D71A9F91E395784050A0F18162B436C294D7BCC4B75
        A6FF7DA7CAFFA8DAF0FF6D9EC4FF1C3868C4173263C31B3770E7000000000000
        0000000000000000000001010203000000000000000000000000000000000810
        192A1A314F872B5183E75681ADFF1B3051960000000000010103000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000E1A2A4B080F192D0000000000000000}
      TabOrder = 2
      OnClick = BtnSelGrupoClick
    end
    object CbxMostrarRecebidos: TCheckBox
      Left = 40
      Top = 36
      Width = 153
      Height = 17
      Caption = 'Mostrar j'#225' recebidos'
      TabOrder = 3
      OnClick = CbxMostrarRecebidosClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 59
    Width = 734
    Height = 229
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 560
    object cxGridCompras: TcxGrid
      Left = 1
      Top = 1
      Width = 732
      Height = 227
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 558
      object ViewCompras: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.First.Visible = False
        Navigator.Buttons.PriorPage.Visible = False
        Navigator.Buttons.Prior.Visible = False
        Navigator.Buttons.Next.Visible = False
        Navigator.Buttons.NextPage.Visible = False
        Navigator.Buttons.Last.Visible = False
        Navigator.Buttons.Insert.Visible = False
        Navigator.Buttons.Append.Visible = True
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Refresh.Visible = False
        Navigator.Buttons.SaveBookmark.Visible = False
        Navigator.Buttons.GotoBookmark.Visible = False
        Navigator.Buttons.Filter.Enabled = False
        Navigator.Buttons.Filter.Visible = False
        Navigator.Visible = True
        DataController.DataSource = DsComprasPrevistas
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Appending = True
        OptionsData.CancelOnExit = False
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        object ViewComprasRecebido: TcxGridDBColumn
          DataBinding.FieldName = 'Recebido'
          Width = 65
        end
        object ViewComprasDataRecebimento: TcxGridDBColumn
          DataBinding.FieldName = 'DataRecebimento'
          Width = 80
        end
        object ViewComprasDataCompra: TcxGridDBColumn
          DataBinding.FieldName = 'DataCompra'
        end
        object ViewComprasCodGrupoSub: TcxGridDBColumn
          DataBinding.FieldName = 'CodGrupoSub'
          Visible = False
        end
        object ViewComprasQuant: TcxGridDBColumn
          DataBinding.FieldName = 'Quant'
          Width = 142
        end
        object ViewComprasPreco: TcxGridDBColumn
          DataBinding.FieldName = 'Preco'
        end
        object ViewComprasObs: TcxGridDBColumn
          DataBinding.FieldName = 'Obs'
          Width = 272
        end
      end
      object cxGridLevel2: TcxGridLevel
        GridView = ViewCompras
      end
    end
  end
  object QryComprasPrevistas: TFDQuery
    AfterInsert = QryComprasPrevistasAfterInsert
    BeforePost = QryComprasPrevistasBeforePost
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT * '
      'FROM log.ComprasPrevistas'
      'where'
      'CodGrupoSub=:CodGrupoSub'
      '/*Recebidos*/'
      'order by DataRecebimento')
    Left = 330
    Top = 96
    ParamData = <
      item
        Name = 'CODGRUPOSUB'
        DataType = ftWideString
        FDDataType = dtWideString
        ParamType = ptInput
        Value = '0010004'
      end>
    object QryComprasPrevistasID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryComprasPrevistasDataCompra: TDateField
      DisplayLabel = 'Data Compra'
      FieldName = 'DataCompra'
      Origin = 'DataCompra'
      Required = True
    end
    object QryComprasPrevistasDataRecebimento: TDateField
      DisplayLabel = 'Data Recebimento'
      FieldName = 'DataRecebimento'
      Origin = 'DataRecebimento'
      Required = True
    end
    object QryComprasPrevistasCodGrupoSub: TStringField
      FieldName = 'CodGrupoSub'
      Origin = 'CodGrupoSub'
      Required = True
      Visible = False
      FixedChar = True
      Size = 7
    end
    object QryComprasPrevistasQuant: TBCDField
      FieldName = 'Quant'
      Origin = 'Quant'
      Precision = 18
    end
    object QryComprasPrevistasPreco: TBCDField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'Preco'
      Origin = 'Preco'
      currency = True
      Precision = 14
    end
    object QryComprasPrevistasRecebido: TBooleanField
      FieldName = 'Recebido'
      Origin = 'Recebido'
    end
    object QryComprasPrevistasObs: TMemoField
      FieldName = 'Obs'
      Origin = 'Obs'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object DsComprasPrevistas: TDataSource
    DataSet = QryComprasPrevistas
    Left = 224
    Top = 96
  end
  object QryGrupos: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT * '
      'FROM GrupoSub'
      'where codgrupo = '#39'001'#39
      'order by NomeSubGrupo')
    Left = 362
    Top = 16
    object QryGruposCODGRUPOSUB: TStringField
      DisplayLabel = 'Cod. Grupo'
      DisplayWidth = 12
      FieldName = 'CODGRUPOSUB'
      Origin = 'CODGRUPOSUB'
      Required = True
      FixedChar = True
      Size = 7
    end
    object QryGruposCODGRUPO: TStringField
      FieldName = 'CODGRUPO'
      Origin = 'CODGRUPO'
      Visible = False
      FixedChar = True
      Size = 3
    end
    object QryGruposCODSUBGRUPO: TStringField
      FieldName = 'CODSUBGRUPO'
      Origin = 'CODSUBGRUPO'
      Visible = False
      FixedChar = True
      Size = 4
    end
    object QryGruposNOMESUBGRUPO: TStringField
      DisplayLabel = 'Grupo'
      FieldName = 'NOMESUBGRUPO'
      Origin = 'NOMESUBGRUPO'
      FixedChar = True
      Size = 30
    end
  end
  object DsGrupo: TDataSource
    DataSet = QryGrupos
    Left = 272
    Top = 16
  end
end
