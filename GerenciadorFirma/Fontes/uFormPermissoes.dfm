object FormPermissoes: TFormPermissoes
  Left = 0
  Top = 0
  Caption = 'Permiss'#245'es'
  ClientHeight = 508
  ClientWidth = 669
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
    Top = 467
    Width = 669
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitWidth = 609
    DesignSize = (
      669
      41)
    object BtnOK: TBitBtn
      Left = 16
      Top = 6
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = BtnOKClick
    end
    object BtnAtualizarMenus: TBitBtn
      Left = 540
      Top = 6
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Atualizar'
      TabOrder = 1
      ExplicitLeft = 480
    end
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 669
    Height = 153
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 609
    object cxGridUsuarios: TcxGrid
      Left = 1
      Top = 1
      Width = 667
      Height = 119
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = -4
      object cxGridDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Visible = fvNever
        DataController.DataSource = DsUsuarios
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.CellAutoHeight = True
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
        object cxGridDBTableView1userid: TcxGridDBColumn
          DataBinding.FieldName = 'userid'
          Options.Editing = False
          Options.Sorting = False
          Width = 51
        end
        object cxGridDBTableView1Nome: TcxGridDBColumn
          DataBinding.FieldName = 'Nome'
          Options.Sorting = False
          Width = 225
        end
        object cxGridDBTableView1admin: TcxGridDBColumn
          DataBinding.FieldName = 'admin'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Options.Sorting = False
          Width = 84
        end
        object cxGridDBTableView1Producao: TcxGridDBColumn
          DataBinding.FieldName = 'Producao'
          Width = 67
        end
        object cxGridDBTableView1Desenvolvedor: TcxGridDBColumn
          DataBinding.FieldName = 'Desenvolvedor'
          Width = 80
        end
        object cxGridDBTableView1CodSidicom: TcxGridDBColumn
          DataBinding.FieldName = 'CodSidicom'
          Width = 75
        end
        object cxGridDBTableView1CodVendedor: TcxGridDBColumn
          DataBinding.FieldName = 'CodVendedor'
          Width = 77
        end
      end
      object cxGridDBTableView4: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DetailKeyFieldNames = 'CODPRODUTO'
        DataController.KeyFieldNames = 'CODPRODUTO'
        DataController.MasterKeyFieldNames = 'CODPRODUTO'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsSelection.CellSelect = False
        OptionsView.GroupByBox = False
        Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      end
      object cxGridLevel2: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
    object DBEditID: TDBEdit
      Left = 16
      Top = 100
      Width = 105
      Height = 21
      DataField = 'userid'
      DataSource = DsUsuarios
      TabOrder = 1
      Visible = False
      OnChange = DBEditIDChange
    end
    object Panel3: TPanel
      Left = 1
      Top = 120
      Width = 667
      Height = 32
      Align = alBottom
      TabOrder = 2
      ExplicitWidth = 607
      object DBNavigator1: TDBNavigator
        Left = 1
        Top = 1
        Width = 587
        Height = 30
        DataSource = DsUsuarios
        VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 527
      end
      object BtnAlterarSenha: TButton
        Left = 588
        Top = 1
        Width = 78
        Height = 30
        Align = alRight
        Caption = 'Alterar a Senha'
        TabOrder = 1
        WordWrap = True
        OnClick = BtnAlterarSenhaClick
        ExplicitLeft = 528
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 153
    Width = 669
    Height = 314
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 609
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 667
      Height = 312
      Align = alClient
      Caption = 'Permiss'#245'es'
      TabOrder = 0
      ExplicitWidth = 607
      object PageControlPermissoes: TPageControl
        Left = 2
        Top = 15
        Width = 663
        Height = 295
        ActivePage = TabMenus
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 603
        object TabSheetConsultas: TTabSheet
          Caption = 'Consultas'
          ExplicitWidth = 595
          object cxGridPermissaoConsulta: TcxGrid
            Left = 0
            Top = 0
            Width = 655
            Height = 267
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 595
            object cxGridDBTableView2: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              FilterBox.Visible = fvNever
              DataController.DataSource = DsPermissaoConsultas
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.CellAutoHeight = True
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
              Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
              object cxGridDBTableView2Descricao: TcxGridDBColumn
                DataBinding.FieldName = 'Descricao'
                Options.Editing = False
                Options.Sorting = False
                Width = 406
              end
              object cxGridDBTableView2Permitido: TcxGridDBColumn
                DataBinding.FieldName = 'Permitido'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.OnChange = cxGridDBTableView2PermitidoPropertiesChange
                Options.Sorting = False
                Width = 60
              end
              object cxGridDBTableView2IDPai: TcxGridDBColumn
                DataBinding.FieldName = 'IDPai'
                Visible = False
                Options.Sorting = False
              end
            end
            object cxGridDBTableView3: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DetailKeyFieldNames = 'CODPRODUTO'
              DataController.KeyFieldNames = 'CODPRODUTO'
              DataController.MasterKeyFieldNames = 'CODPRODUTO'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsSelection.CellSelect = False
              OptionsView.GroupByBox = False
              Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
            end
            object cxGridLevel1: TcxGridLevel
              GridView = cxGridDBTableView2
            end
          end
        end
        object TabMenus: TTabSheet
          Caption = 'Menus'
          ImageIndex = 1
          ExplicitWidth = 595
          object cxGrid1: TcxGrid
            Left = 0
            Top = 0
            Width = 655
            Height = 267
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 595
            object cxGridDBTableViewMenus: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              FilterBox.Visible = fvNever
              OnCellClick = cxGridDBTableViewMenusCellClick
              DataController.DataSource = DsPermissaoMenus
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.CellAutoHeight = True
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
              Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
              object cxGridDBTableViewMenusMenuName: TcxGridDBColumn
                DataBinding.FieldName = 'MenuName'
                Visible = False
                Options.Sorting = False
              end
              object cxGridDBTableViewMenusDescricao: TcxGridDBColumn
                DataBinding.FieldName = 'Descricao'
                Options.Editing = False
                Options.Sorting = False
                Width = 417
              end
              object cxGridDBTableViewMenusPermitido: TcxGridDBColumn
                DataBinding.FieldName = 'Permitido'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.OnChange = cxGridDBTableView5PermitidoPropertiesChange
                Options.Sorting = False
                Width = 80
              end
              object cxGridDBTableViewMenusNomePai: TcxGridDBColumn
                DataBinding.FieldName = 'NomePai'
                Visible = False
                Options.Sorting = False
              end
              object cxGridDBTableViewMenusDefaultMenu: TcxGridDBColumn
                DataBinding.FieldName = 'DefaultMenu'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.OnChange = cxGridDBTableViewMenusDefaultMenuPropertiesChange
                Width = 45
              end
            end
            object cxGridDBTableView6: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              DataController.DetailKeyFieldNames = 'CODPRODUTO'
              DataController.KeyFieldNames = 'CODPRODUTO'
              DataController.MasterKeyFieldNames = 'CODPRODUTO'
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsSelection.CellSelect = False
              OptionsView.GroupByBox = False
              Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
            end
            object cxGridLevel3: TcxGridLevel
              GridView = cxGridDBTableViewMenus
            end
          end
        end
      end
    end
  end
  object QryUsuarios: TFDQuery
    AfterInsert = QryUsuariosAfterInsert
    BeforePost = QryUsuariosBeforePost
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select * '
      'from perm.Usuario')
    Left = 368
    Top = 64
    object QryUsuariosuserid: TFDAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'userid'
      Origin = 'userid'
      ReadOnly = True
    end
    object QryUsuariosNome: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 255
    end
    object QryUsuariosSenha: TStringField
      FieldName = 'Senha'
      Origin = 'Senha'
      Size = 255
    end
    object QryUsuariosadmin: TBooleanField
      DisplayLabel = 'Administrador'
      FieldName = 'admin'
      Origin = 'admin'
    end
    object QryUsuariosDefaultMenu: TMemoField
      FieldName = 'DefaultMenu'
      Origin = 'DefaultMenu'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryUsuariosProducao: TBooleanField
      DisplayLabel = 'Produ'#231#227'o'
      FieldName = 'Producao'
      Origin = 'Producao'
    end
    object QryUsuariosDesenvolvedor: TBooleanField
      FieldName = 'Desenvolvedor'
      Origin = 'Desenvolvedor'
    end
    object QryUsuariosCodSidicom: TStringField
      DisplayLabel = 'Cod. Usu'#225'rio Sidicom'
      FieldName = 'CodSidicom'
      Origin = 'CodSidicom'
      FixedChar = True
      Size = 6
    end
    object QryUsuariosCodVendedor: TStringField
      DisplayLabel = 'Cod. Vendedor'
      FieldName = 'CodVendedor'
      Origin = 'CodVendedor'
      FixedChar = True
      Size = 6
    end
  end
  object DsUsuarios: TDataSource
    DataSet = QryUsuarios
    Left = 296
    Top = 64
  end
  object DsPermissaoConsultas: TDataSource
    DataSet = TablePermissaoConsulta
    Left = 224
    Top = 280
  end
  object TablePermissaoConsulta: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 351
    Top = 281
    object TablePermissaoConsultaID: TIntegerField
      FieldName = 'ID'
    end
    object TablePermissaoConsultaDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 50
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 255
    end
    object TablePermissaoConsultaPermitido: TBooleanField
      FieldName = 'Permitido'
    end
    object TablePermissaoConsultaIDPai: TIntegerField
      FieldName = 'IDPai'
    end
  end
  object QryConsulta: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select cm.*, ISNULL(Permitido,0) as Permitido'
      'from cons.vwNivelMenu cm'
      
        'left join perm.Consultas pu on pu.ConsultaID = cm.ID and userid ' +
        '=:UserID'
      'order by treeID')
    Left = 144
    Top = 216
    ParamData = <
      item
        Name = 'USERID'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
        Value = 0
      end>
    object QryConsultaID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryConsultaDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 255
    end
    object QryConsultaIDPai: TIntegerField
      FieldName = 'IDPai'
      Origin = 'IDPai'
    end
    object QryConsultaTipo: TIntegerField
      FieldName = 'Tipo'
      Origin = 'Tipo'
    end
    object QryConsultaIDAcao: TIntegerField
      FieldName = 'IDAcao'
      Origin = 'IDAcao'
    end
    object QryConsultanivel: TIntegerField
      FieldName = 'nivel'
      Origin = 'nivel'
    end
    object QryConsultaPermitido: TBooleanField
      FieldName = 'Permitido'
      Origin = 'Permitido'
      ReadOnly = True
      Required = True
    end
  end
  object DsConsulta: TDataSource
    DataSet = QryConsulta
    Left = 72
    Top = 216
  end
  object TablePermissaoMenus: TFDMemTable
    OnCalcFields = TablePermissaoMenusCalcFields
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 359
    Top = 385
    object TablePermissaoMenusMenuName: TStringField
      FieldName = 'MenuName'
      Size = 255
    end
    object TablePermissaoMenusDescricao: TStringField
      FieldName = 'Descricao'
      Size = 255
    end
    object TablePermissaoMenusPermitido: TBooleanField
      FieldName = 'Permitido'
    end
    object TablePermissaoMenusNomePai: TStringField
      FieldName = 'NomePai'
      Size = 255
    end
    object TablePermissaoMenusDefaultMenu: TBooleanField
      DisplayLabel = 'Padr'#227'o'
      FieldKind = fkInternalCalc
      FieldName = 'DefaultMenu'
    end
  end
  object DsPermissaoMenus: TDataSource
    DataSet = TablePermissaoMenus
    Left = 224
    Top = 384
  end
  object QryMenus: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select userid, MenuName, ISNULL(Permitido,0) as Permitido'
      'from perm.Menus m'
      'where userID =:userID')
    Left = 416
    Top = 216
    ParamData = <
      item
        Name = 'USERID'
        ParamType = ptInput
      end>
    object QryMenususerid: TIntegerField
      FieldName = 'userid'
      Origin = 'userid'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryMenusMenuName: TStringField
      FieldName = 'MenuName'
      Origin = 'MenuName'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 255
    end
    object QryMenusPermitido: TBooleanField
      FieldName = 'Permitido'
      Origin = 'Permitido'
      ReadOnly = True
      Required = True
    end
  end
  object DsMenus: TDataSource
    DataSet = QryMenus
    Left = 344
    Top = 216
  end
end
