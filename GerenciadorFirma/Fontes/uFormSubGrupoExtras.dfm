object FormSubGrupoExtras: TFormSubGrupoExtras
  Left = 0
  Top = 0
  Caption = 'Informa'#231#245'es da Etiqueta por Grupo de Produto'
  ClientHeight = 538
  ClientWidth = 785
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
  object cxGridDadosGrupo: TcxGrid
    Left = 0
    Top = 0
    Width = 785
    Height = 513
    Align = alClient
    TabOrder = 0
    object cxGridDadosGrupoDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.PriorPage.Enabled = False
      Navigator.Buttons.PriorPage.Visible = False
      Navigator.Buttons.Prior.Visible = True
      Navigator.Buttons.NextPage.Visible = False
      Navigator.Buttons.Insert.Visible = False
      Navigator.Buttons.Delete.Visible = False
      Navigator.Buttons.Post.Visible = True
      Navigator.Buttons.Refresh.Enabled = False
      Navigator.Buttons.Refresh.Visible = False
      Navigator.Buttons.SaveBookmark.Visible = False
      Navigator.Buttons.GotoBookmark.Visible = False
      Navigator.Buttons.Filter.Visible = False
      DataController.DataSource = DsGrupoSubExtras
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridDadosGrupoDBTableViewCODGRUPOSUB: TcxGridDBColumn
        DataBinding.FieldName = 'CODGRUPOSUB'
        Width = 96
      end
      object cxGridDadosGrupoDBTableViewDESCRICAOETIQUETA: TcxGridDBColumn
        DataBinding.FieldName = 'DESCRICAOETIQUETA'
        Width = 222
      end
      object cxGridDadosGrupoDBTableViewONU: TcxGridDBColumn
        DataBinding.FieldName = 'ONU'
      end
      object cxGridDadosGrupoDBTableViewRISCO: TcxGridDBColumn
        DataBinding.FieldName = 'RISCO'
      end
      object cxGridDadosGrupoDBTableViewFABRICACAO: TcxGridDBColumn
        DataBinding.FieldName = 'FABRICACAO'
        PropertiesClassName = 'TcxDateEditProperties'
      end
      object cxGridDadosGrupoDBTableViewMESESVALIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'MESESVALIDADE'
      end
      object cxGridDadosGrupoDBTableViewDATAVALIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'DATAVALIDADE'
        PropertiesClassName = 'TcxDateEditProperties'
        Width = 104
      end
      object cxGridDadosGrupoDBTableViewSubclasserisco: TcxGridDBColumn
        DataBinding.FieldName = 'Subclasserisco'
      end
      object cxGridDadosGrupoDBTableViewDescricaoRisco: TcxGridDBColumn
        DataBinding.FieldName = 'DescricaoRisco'
        Width = 104
      end
      object cxGridDadosGrupoDBTableViewDiasParaEntrega: TcxGridDBColumn
        DataBinding.FieldName = 'DiasParaEntrega'
        Width = 81
      end
    end
    object cxGridDadosGrupoLevel: TcxGridLevel
      GridView = cxGridDadosGrupoDBTableView
    end
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 513
    Width = 785
    Height = 25
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbEdit, nbPost, nbCancel]
    Align = alBottom
    TabOrder = 1
  end
  object DsGrupoSubExtras: TDataSource
    DataSet = QryGrupoSubExtras
    Left = 284
    Top = 200
  end
  object QryGrupoSubExtras: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT * FROM GrupoSubExtras')
    Left = 448
    Top = 200
    object QryGrupoSubExtrasCODGRUPOSUB: TStringField
      DisplayLabel = 'Cod. Grupo Sub'
      FieldName = 'CODGRUPOSUB'
      Origin = 'CODGRUPOSUB'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Required = True
      FixedChar = True
      Size = 7
    end
    object QryGrupoSubExtrasONU: TIntegerField
      FieldName = 'ONU'
      Origin = 'ONU'
    end
    object QryGrupoSubExtrasRISCO: TIntegerField
      FieldName = 'RISCO'
      Origin = 'RISCO'
    end
    object QryGrupoSubExtrasFABRICACAO: TDateField
      DisplayLabel = 'Data Fabrica'#231#227'o'
      FieldName = 'FABRICACAO'
      Origin = 'FABRICACAO'
      OnChange = QryGrupoSubExtrasFABRICACAOChange
    end
    object QryGrupoSubExtrasMESESVALIDADE: TIntegerField
      DisplayLabel = 'Meses Validade'
      FieldName = 'MESESVALIDADE'
      Origin = 'MESESVALIDADE'
      OnChange = QryGrupoSubExtrasMESESVALIDADEChange
    end
    object QryGrupoSubExtrasDescricaoEtiqueta: TStringField
      DisplayLabel = 'Descri'#231#227'o Etiqueta'
      FieldName = 'DescricaoEtiqueta'
      Origin = 'DescricaoEtiqueta'
      Size = 80
    end
    object QryGrupoSubExtrasDATAVALIDADE: TDateField
      DisplayLabel = 'Data Validade'
      FieldName = 'DATAVALIDADE'
    end
    object QryGrupoSubExtrasDiasParaEntrega: TIntegerField
      DisplayLabel = 'Dias '#250'teis para Entrega'
      FieldName = 'DiasParaEntrega'
      Origin = 'DiasParaEntrega'
    end
    object QryGrupoSubExtrasSubclasseRisco: TMemoField
      DisplayLabel = 'Subclasse de Risco'
      FieldName = 'Subclasserisco'
      Origin = 'SubclasseRisco'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryGrupoSubExtrasDescricaoRisco: TMemoField
      DisplayLabel = 'Descri'#231#227'o Risco'
      FieldName = 'DescricaoRisco'
      Origin = 'DescricaoRisco'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
end
