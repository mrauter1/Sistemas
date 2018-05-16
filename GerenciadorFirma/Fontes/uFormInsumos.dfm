object FormInsumos: TFormInsumos
  Left = 0
  Top = 0
  Caption = 'Insumos do Produto'
  ClientHeight = 399
  ClientWidth = 747
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
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 747
    Height = 399
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 24
    ExplicitTop = 8
    ExplicitWidth = 735
    object cxGridDBTableView: TcxGridDBTableView
      PopupMenu = PopupMenuOpcoes
      OnDblClick = cxGridDBTableViewDblClick
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DsInsumos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skSum
          FieldName = 'QUANTINSUMO'
          Column = cxGridDBTableViewQUANTINSUMO
          DisplayText = 'Quant. Insumo'
        end
        item
          Kind = skSum
          FieldName = 'LITROS'
          Column = cxGridDBTableViewLITROS
          DisplayText = 'Quant. Em Litros'
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridDBTableViewCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
        Visible = False
        Width = 67
      end
      object cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'APRESENTACAO'
        Visible = False
        Width = 116
      end
      object cxGridDBTableViewINSUMO: TcxGridDBColumn
        DataBinding.FieldName = 'INSUMO'
        Width = 222
      end
      object cxGridDBTableViewQUANTINSUMO: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTINSUMO'
        Width = 83
      end
      object cxGridDBTableViewLITROS: TcxGridDBColumn
        DataBinding.FieldName = 'LITROS'
      end
      object cxGridDBTableViewDENSIDADECALCULADA: TcxGridDBColumn
        DataBinding.FieldName = 'DENSIDADECALCULADA'
        Width = 82
      end
      object cxGridDBTableViewSALDOATUAL: TcxGridDBColumn
        DataBinding.FieldName = 'SALDOATUAL'
        Width = 86
      end
      object cxGridDBTableViewDIASESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'DIASESTOQUE'
      end
      object cxGridDBTableViewDEMANDADIARIA: TcxGridDBColumn
        DataBinding.FieldName = 'DEMANDADIARIA'
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
      object cxGridDBTableView1CODPEDIDO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPEDIDO'
        Width = 60
      end
      object cxGridDBTableView1QUANTIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTIDADE'
        Width = 60
      end
      object cxGridDBTableView1DIASPARAENTREGA: TcxGridDBColumn
        DataBinding.FieldName = 'DIASPARAENTREGA'
        Width = 50
      end
      object cxGridDBTableView1SIT: TcxGridDBColumn
        DataBinding.FieldName = 'SIT'
        Width = 40
      end
      object cxGridDBTableView1NOMECLIENTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMECLIENTE'
        Width = 200
      end
      object cxGridDBTableView1NOMETRANSPORTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMETRANSPORTE'
        Width = 200
      end
      object cxGridDBTableView1QUANTPENDENTE: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTPENDENTE'
      end
    end
    object cxGridDBTableView2: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DSInsumosDetalhe
      DataController.DetailKeyFieldNames = 'CODPRO'
      DataController.KeyFieldNames = 'CODPRO'
      DataController.MasterKeyFieldNames = 'CODPRODUTO'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      OptionsView.GroupFooterMultiSummaries = True
      object cxGridDBTableView2CODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
      end
      object cxGridDBTableView2APRESENTACAO: TcxGridDBColumn
        DataBinding.FieldName = 'APRESENTACAO'
        Width = 214
      end
      object cxGridDBTableView2SALDOATUAL: TcxGridDBColumn
        DataBinding.FieldName = 'SALDOATUAL'
        Width = 80
      end
      object cxGridDBTableView2DEMANDADIARIA: TcxGridDBColumn
        DataBinding.FieldName = 'DEMANDADIARIA'
        Width = 80
      end
      object cxGridDBTableView2DIASESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'DIASESTOQUE'
        Width = 80
      end
      object cxGridDBTableView2CODPRO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRO'
        Visible = False
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView2
      end
    end
  end
  object DsInsumos: TDataSource
    DataSet = CdsInsumos
    Left = 352
    Top = 96
  end
  object CdsInsumos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 352
    Top = 48
    object CdsInsumosCodProduto: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'CODPRODUTO'
      Size = 10
    end
    object CdsInsumosAPRESENTACAO: TStringField
      DisplayLabel = 'Apresenta'#231#227'o'
      FieldName = 'APRESENTACAO'
      Size = 80
    end
    object CdsInsumosQUANTINSUMO: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTINSUMO'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosDEMANDA: TFloatField
      DisplayLabel = 'Demanda'
      FieldName = 'DEMANDADIARIA'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosSALDOATUAL: TFloatField
      DisplayLabel = 'Estoque Atual'
      FieldName = 'SALDOATUAL'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosDIASESTOQUE: TFloatField
      DisplayLabel = 'Dias Estoque'
      FieldName = 'DIASESTOQUE'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosINSUMO: TStringField
      DisplayLabel = 'Insumo'
      FieldName = 'INSUMO'
      Size = 80
    end
    object CdsInsumosLITROS: TFloatField
      DisplayLabel = 'Quant. Em Litros'
      FieldName = 'LITROS'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosDENSIDADECALCULADA: TFloatField
      DisplayLabel = 'Densidade Calculada'
      FieldName = 'DENSIDADECALCULADA'
      DisplayFormat = '#0.000'
    end
  end
  object PopupMenuOpcoes: TPopupMenu
    Left = 528
    Top = 88
    object VerSimilares1: TMenuItem
      Caption = 'Produtos Equivalentes'
      OnClick = VerSimilares1Click
    end
    object VerInsumos1: TMenuItem
      Caption = 'Ver Insumos'
      OnClick = VerInsumos1Click
    end
  end
  object CdsInsumosDetalhe: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 248
    Top = 152
    object CdsInsumosDetalheCODPRODUTO: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'CODPRODUTO'
      Size = 10
    end
    object CdsInsumosDetalheAPRESENTACAO: TStringField
      DisplayLabel = 'Apresenta'#231#227'o'
      FieldName = 'APRESENTACAO'
      Size = 80
    end
    object CdsInsumosDetalheSALDOATUAL: TFloatField
      DisplayLabel = 'Estoque Atual'
      FieldName = 'SALDOATUAL'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosDetalheDEMANDADIARIA: TFloatField
      DisplayLabel = 'Demanda'
      FieldName = 'DEMANDADIARIA'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosDetalheDIASESTOQUE: TFloatField
      DisplayLabel = 'Dias Estoque'
      FieldName = 'DIASESTOQUE'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosDetalheCODPRO: TStringField
      FieldName = 'CODPRO'
      Visible = False
      Size = 10
    end
  end
  object DSInsumosDetalhe: TDataSource
    DataSet = CdsInsumosDetalhe
    Left = 248
    Top = 200
  end
end
