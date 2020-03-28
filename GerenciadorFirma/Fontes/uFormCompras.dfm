object FormCiclos: TFormCiclos
  Left = 0
  Top = 0
  Caption = 'Compras do Cliente'
  ClientHeight = 415
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGridComprasCliente: TcxGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 415
    Align = alClient
    TabOrder = 0
    object tvComprasCliente: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DsComprasCliente
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
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
      GridView = tvComprasCliente
    end
  end
  object QryComprasCliente: TFDQuery
    Active = True
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select cc.*, C.Cidade, C.Estado'
      'from CicloCompras cc'
      'inner join Cliente C on C.CodCliente = cc.CodCliente'
      'where cc.CiclosSemCompra > 3'
      'and NroCompras > 2'
      
        'and getdate() >= IsNull((select DataRelembrar from LembreteCiclo' +
        's lc where lc.codCliente = cc.CodCliente and lc.CodProduto = cc.' +
        'CodProduto), getdate())'
      
        'order by cc.TicketMedio desc, CiclosSemCompra, cc.CodCliente, Co' +
        'dProduto')
    Left = 160
    Top = 168
    object QryComprasClienteCodCliente: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'CodCliente'
      Origin = 'CodCliente'
      FixedChar = True
      Size = 6
    end
    object StringField2: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 28
      FieldName = 'NOMECLIENTE'
      Origin = 'NOMECLIENTE'
      Size = 40
    end
    object QryComprasClienteProduto: TStringField
      DisplayWidth = 30
      FieldName = 'Produto'
      Origin = 'Produto'
      Size = 80
    end
    object StringField4: TStringField
      FieldName = 'CODVENDEDOR2'
      Origin = 'CODVENDEDOR2'
      Visible = False
      FixedChar = True
      Size = 6
    end
    object StringField5: TStringField
      DisplayWidth = 25
      FieldName = 'Vendedor'
      Origin = 'Vendedor'
      ReadOnly = True
      FixedChar = True
      Size = 30
    end
    object QryComprasClienteCodProduto: TStringField
      DisplayLabel = 'Cod. Produto'
      DisplayWidth = 7
      FieldName = 'CodProduto'
      Origin = 'CodProduto'
      Required = True
      FixedChar = True
      Size = 6
    end
    object IntegerField1: TIntegerField
      FieldName = 'NroCompras'
      Origin = 'DiasUteisEntreCompras'
    end
    object FMTBCDField1: TFMTBCDField
      DisplayLabel = 'Ticket M'#233'dio'
      DisplayWidth = 15
      FieldName = 'TicketMedio'
      Origin = 'TicketMedio'
      currency = True
      Precision = 38
      Size = 6
    end
    object DateField1: TDateField
      DisplayLabel = 'Data Ultima Compra'
      FieldName = 'DataUltimaCompra'
      Origin = 'DataUltimaCompra'
    end
    object StringField7: TStringField
      DisplayWidth = 18
      FieldName = 'Cidade'
      Origin = 'Cidade'
      FixedChar = True
      Size = 35
    end
    object StringField8: TStringField
      DisplayWidth = 6
      FieldName = 'Estado'
      Origin = 'Estado'
      FixedChar = True
      Size = 2
    end
    object FloatField1: TFloatField
      DisplayLabel = 'Dias '#218'teis Entre Compras'
      FieldName = 'DiasUteisEntreCompras'
    end
    object IntegerField2: TIntegerField
      DisplayLabel = 'Dias '#218'teis Sem Comprar'
      FieldName = 'DiasUteisSemComprar'
    end
    object BCDField1: TBCDField
      DisplayLabel = 'Ciclos Sem Compra'
      FieldName = 'CiclosSemCompra'
      ReadOnly = True
      Precision = 18
      Size = 1
    end
  end
  object DsComprasCliente: TDataSource
    AutoEdit = False
    DataSet = QryComprasCliente
    Left = 296
    Top = 168
  end
end
