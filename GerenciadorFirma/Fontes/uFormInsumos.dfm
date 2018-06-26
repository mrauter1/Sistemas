object FormInsumos: TFormInsumos
  Left = 0
  Top = 0
  Caption = 'Insumos do Produto'
  ClientHeight = 400
  ClientWidth = 855
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
    Top = 81
    Width = 855
    Height = 319
    Align = alClient
    TabOrder = 0
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
        end
        item
          Kind = skSum
          FieldName = 'PESO'
          Column = cxGridDBTableViewPESO
          DisplayText = 'Peso'
        end
        item
          Kind = skSum
          OnGetText = cxGridDBTableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems3GetText
          FieldName = 'PERCLITROS'
          Column = cxGridDBTableViewPERCLITROS
          DisplayText = '% Litros Total'
        end
        item
          Kind = skSum
          OnGetText = cxGridDBTableViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems3GetText
          FieldName = 'PERCPESO'
          Column = cxGridDBTableViewPERCPESO
          DisplayText = '% Peso Total'
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
        Width = 49
      end
      object cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'APRESENTACAO'
        Visible = False
        Width = 116
      end
      object cxGridDBTableViewINSUMO: TcxGridDBColumn
        DataBinding.FieldName = 'INSUMO'
        Width = 167
      end
      object cxGridDBTableViewQUANTINSUMO: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTINSUMO'
        Width = 83
      end
      object cxGridDBTableViewLITROS: TcxGridDBColumn
        DataBinding.FieldName = 'LITROS'
        Width = 68
      end
      object cxGridDBTableViewPERCLITROS: TcxGridDBColumn
        DataBinding.FieldName = 'PERCLITROS'
        OnGetDataText = cxGridDBTableViewPERCLITROSGetDataText
        Width = 59
      end
      object cxGridDBTableViewPESO: TcxGridDBColumn
        DataBinding.FieldName = 'PESO'
        Width = 55
      end
      object cxGridDBTableViewPERCPESO: TcxGridDBColumn
        DataBinding.FieldName = 'PERCPESO'
        OnGetDataText = cxGridDBTableViewPERCLITROSGetDataText
        Width = 73
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 855
    Height = 81
    Align = alTop
    TabOrder = 1
    object GroupPeso: TGroupBox
      Left = 24
      Top = 10
      Width = 225
      Height = 55
      Caption = 'Peso'
      Color = clBtnFace
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 15
        Width = 75
        Height = 13
        Alignment = taRightJustify
        Caption = 'Prod. Acabado:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label2: TLabel
        Left = 41
        Top = 35
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'Calculado:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LblPesoPAcabado: TLabel
        Left = 97
        Top = 15
        Width = 38
        Height = 13
        Caption = '0.00 KG'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LblPesoCalculado: TLabel
        Left = 97
        Top = 35
        Width = 38
        Height = 13
        Caption = '0.00 KG'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
    object GroupLitros: TGroupBox
      Left = 288
      Top = 10
      Width = 225
      Height = 55
      Caption = 'Em Litros'
      TabOrder = 1
      object Label3: TLabel
        Left = 15
        Top = 15
        Width = 75
        Height = 13
        Alignment = taRightJustify
        Caption = 'Prod. Acabado:'
      end
      object Label4: TLabel
        Left = 40
        Top = 34
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'Calculado:'
      end
      object LblLitrosCalculado: TLabel
        Left = 96
        Top = 34
        Width = 51
        Height = 13
        Caption = '0.00 Litros'
      end
      object LblLitrosPAcabado: TLabel
        Left = 96
        Top = 15
        Width = 51
        Height = 13
        Caption = '0.00 Litros'
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
    object CdsInsumosPESO: TFloatField
      DisplayLabel = 'Quant. Em Kg'
      FieldName = 'PESO'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosDENSIDADECALCULADA: TFloatField
      DisplayLabel = 'Densidade Calculada'
      FieldName = 'DENSIDADECALCULADA'
      DisplayFormat = '#0.000'
    end
    object CdsInsumosPERCPESO: TFloatField
      DisplayLabel = '% Peso'
      FieldName = 'PERCPESO'
    end
    object CdsInsumosPERCLITROS: TFloatField
      DisplayLabel = '% Litros'
      FieldName = 'PERCLITROS'
    end
  end
  object PopupMenuOpcoes: TPopupMenu
    Left = 528
    Top = 88
    object ConfiguraodoProduto1: TMenuItem
      Caption = 'Configura'#231#227'o do Produto'
      OnClick = ConfiguraodoProduto1Click
    end
    object DetalhamentodoProduto1: TMenuItem
      Caption = 'Detalhamento do Produto'
      OnClick = DetalhamentodoProduto1Click
    end
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
  object CdsProdutoAcabado: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 152
    object CdsProdutoAcabadoCodProduto: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'CODPRODUTO'
      Size = 10
    end
    object CdsProdutoAcabadoApresentacao: TStringField
      DisplayLabel = 'Apresenta'#231#227'o'
      FieldName = 'APRESENTACAO'
      Size = 80
    end
    object CdsProdutoAcabadoPESO: TFloatField
      DisplayLabel = 'Peso'
      FieldName = 'PESO'
      DisplayFormat = '#0.00'
    end
    object CdsProdutoAcabadoLITROS: TFloatField
      DisplayLabel = 'Litros'
      FieldName = 'LITROS'
      DisplayFormat = '#0.00'
    end
  end
end
