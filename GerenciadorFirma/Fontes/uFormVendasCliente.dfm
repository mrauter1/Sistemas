object FormVendasCliente: TFormVendasCliente
  Left = 0
  Top = 0
  Caption = 'Vendas do Cliente'
  ClientHeight = 441
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 737
    Height = 441
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -348
    ExplicitTop = -151
    ExplicitWidth = 974
    ExplicitHeight = 467
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DsVendas
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
      object cxGridDBTableViewChaveNf: TcxGridDBColumn
        DataBinding.FieldName = 'ChaveNf'
        Visible = False
      end
      object cxGridDBTableViewNumero: TcxGridDBColumn
        DataBinding.FieldName = 'Numero'
        Width = 48
      end
      object cxGridDBTableViewCodPedido: TcxGridDBColumn
        DataBinding.FieldName = 'CodPedido'
        Width = 50
      end
      object cxGridDBTableViewCODCLIENTE: TcxGridDBColumn
        DataBinding.FieldName = 'CODCLIENTE'
        Visible = False
      end
      object cxGridDBTableViewNOMECLIENTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMECLIENTE'
        Visible = False
        Width = 191
      end
      object cxGridDBTableViewDATACOMPROVANTE: TcxGridDBColumn
        DataBinding.FieldName = 'DATACOMPROVANTE'
        Width = 70
      end
      object cxGridDBTableViewTOTNOTA: TcxGridDBColumn
        DataBinding.FieldName = 'TOTNOTA'
        Width = 101
      end
      object cxGridDBTableViewTOTITENS: TcxGridDBColumn
        DataBinding.FieldName = 'TOTITENS'
      end
      object cxGridDBTableViewNOMECONDICAO: TcxGridDBColumn
        DataBinding.FieldName = 'NOMECONDICAO'
        Width = 101
      end
      object cxGridDBTableViewNOMETRANSPORTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMETRANSPORTE'
      end
    end
    object cxGridDBTableView1: TcxGridDBTableView
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
    object cxGridDBTableView2: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DsProdutos
      DataController.DetailKeyFieldNames = 'CHAVENF'
      DataController.KeyFieldNames = 'CHAVENF'
      DataController.MasterKeyFieldNames = 'ChaveNf'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGridDBTableView2CHAVENF: TcxGridDBColumn
        DataBinding.FieldName = 'CHAVENF'
        Visible = False
      end
      object cxGridDBTableView2CODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
        Width = 54
      end
      object cxGridDBTableView2APRESENTACAO: TcxGridDBColumn
        DataBinding.FieldName = 'APRESENTACAO'
        Width = 232
      end
      object cxGridDBTableView2Quantidade: TcxGridDBColumn
        DataBinding.FieldName = 'Quantidade'
        Width = 71
      end
      object cxGridDBTableView2VALTOTAL: TcxGridDBColumn
        DataBinding.FieldName = 'VALTOTAL'
        Width = 105
      end
      object cxGridDBTableView2ValUnitario: TcxGridDBColumn
        DataBinding.FieldName = 'ValUnitario'
        Width = 104
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView2
      end
    end
  end
  object QryVendas: TFDQuery
    Active = True
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      
        'select M.ChaveNf, M.Numero, M.CodPedido, c.CODCLIENTE, c.NOMECLI' +
        'ENTE, M.DATACOMPROVANTE, M.TOTNOTA, M.TOTITENS, CP.NOMECONDICAO,' +
        ' t.NOMETRANSPORTE'
      'from MCLI M'
      'inner join CLIENTE c on c.CODCLIENTE = M.CODCLIENTE'
      'left join CONDPGTO CP on CP.CODCONDICAO = M.CODCONDPGTO'
      'left join TRANSP t on t.CODTRANSPORTE = M.CODTRANSPORTADORA'
      'where M.CODCLIENTE = '#39'003657'#39
      
        'and M.CODCOMPROVANTE in (select CODCOMPROVANTE from COMPRVVENDAS' +
        ')'
      'order by DATACOMPROVANTE desc')
    Left = 160
    Top = 80
    object QryVendasChaveNf: TStringField
      FieldName = 'ChaveNf'
      Origin = 'ChaveNf'
      Required = True
      FixedChar = True
      Size = 15
    end
    object QryVendasNumero: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'Numero'
      Origin = 'Numero'
      FixedChar = True
      Size = 6
    end
    object QryVendasCodPedido: TStringField
      DisplayLabel = 'Cod. Pedido'
      FieldName = 'CodPedido'
      Origin = 'CodPedido'
      FixedChar = True
      Size = 6
    end
    object QryVendasCODCLIENTE: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'CODCLIENTE'
      Origin = 'CODCLIENTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryVendasNOMECLIENTE: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 20
      FieldName = 'NOMECLIENTE'
      Origin = 'NOMECLIENTE'
      Size = 40
    end
    object QryVendasDATACOMPROVANTE: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATACOMPROVANTE'
      Origin = 'DATACOMPROVANTE'
    end
    object QryVendasTOTNOTA: TBCDField
      DisplayLabel = 'Total Nota'
      FieldName = 'TOTNOTA'
      Origin = 'TOTNOTA'
      currency = True
      Precision = 18
    end
    object QryVendasTOTITENS: TIntegerField
      DisplayLabel = 'Nro. Itens'
      FieldName = 'TOTITENS'
      Origin = 'TOTITENS'
    end
    object QryVendasNOMECONDICAO: TStringField
      DisplayLabel = 'Cond. Pgto'
      FieldName = 'NOMECONDICAO'
      Origin = 'NOMECONDICAO'
      FixedChar = True
      Size = 30
    end
    object QryVendasNOMETRANSPORTE: TStringField
      DisplayLabel = 'Transportadora'
      FieldName = 'NOMETRANSPORTE'
      Origin = 'NOMETRANSPORTE'
      FixedChar = True
      Size = 30
    end
  end
  object DsVendas: TDataSource
    AutoEdit = False
    DataSet = QryVendas
    Left = 272
    Top = 80
  end
  object QryProdutos: TFDQuery
    Active = True
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      
        'select M.CHAVENF, mp.CODPRODUTO, p.APRESENTACAO, mp.QUANTATENDID' +
        'A / p.UNIDADEESTOQUE as Quantidade, mp.VALTOTAL,'
      
        'mp.VALTOTAL / (mp.QUANTATENDIDA / p.UNIDADEESTOQUE) as ValUnitar' +
        'io'
      'from MCLI M'
      'inner join MCLIPRO mp on mp.CHAVENF = M.CHAVENF'
      'inner join PRODUTO p on p.CODPRODUTO = mp.CODPRODUTO'
      'where M.CODCLIENTE = '#39'003657'#39
      
        'and M.CODCOMPROVANTE in (select CODCOMPROVANTE from COMPRVVENDAS' +
        ')'
      'order by m.CHAVENF desc, mp.VALtotal desc')
    Left = 160
    Top = 192
    object QryProdutosCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Origin = 'CHAVENF'
      Required = True
      FixedChar = True
      Size = 15
    end
    object QryProdutosCODPRODUTO: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'CODPRODUTO'
      Origin = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryProdutosAPRESENTACAO: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'APRESENTACAO'
      Origin = 'APRESENTACAO'
      Size = 80
    end
    object QryProdutosQuantidade: TFMTBCDField
      FieldName = 'Quantidade'
      Origin = 'Quantidade'
      ReadOnly = True
      Precision = 29
      Size = 15
    end
    object QryProdutosVALTOTAL: TBCDField
      DisplayLabel = 'Valor'
      FieldName = 'VALTOTAL'
      Origin = 'VALTOTAL'
      currency = True
      Precision = 18
    end
    object QryProdutosValUnitario: TFMTBCDField
      DisplayLabel = 'Valor Unidade'
      FieldName = 'ValUnitario'
      Origin = 'ValUnitario'
      ReadOnly = True
      currency = True
      Precision = 38
      Size = 9
    end
  end
  object DsProdutos: TDataSource
    AutoEdit = False
    DataSet = QryProdutos
    Left = 272
    Top = 192
  end
end
