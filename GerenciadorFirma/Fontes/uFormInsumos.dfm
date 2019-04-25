object FormInsumos: TFormInsumos
  Left = 0
  Top = 0
  Caption = 'Insumos do Produto'
  ClientHeight = 400
  ClientWidth = 863
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
    Width = 863
    Height = 319
    Align = alClient
    TabOrder = 0
    ExplicitTop = 87
    object cxGridDBTableView: TcxGridDBTableView
      PopupMenu = PopupMenuOpcoes
      OnDblClick = cxGridDBTableViewDblClick
      OnMouseUp = cxGridDBTableViewMouseUp
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
      object cxGridDBTableViewCODINSUMO: TcxGridDBColumn
        DataBinding.FieldName = 'CODINSUMO'
      end
      object cxGridDBTableViewAPRESENTACAO: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'APRESENTACAO'
        Visible = False
        Width = 116
      end
      object cxGridDBTableViewINSUMO: TcxGridDBColumn
        DataBinding.FieldName = 'INSUMO'
        Width = 161
      end
      object cxGridDBTableViewQUANTINSUMO: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTINSUMO'
        Width = 67
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
        Width = 56
      end
      object cxGridDBTableViewESTOQUESUB: TcxGridDBColumn
        DataBinding.FieldName = 'ESTOQUESUB'
      end
      object cxGridDBTableViewDIASESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'DIASESTOQUE'
        Width = 50
      end
      object cxGridDBTableViewDEMANDASUB: TcxGridDBColumn
        DataBinding.FieldName = 'DEMANDASUB'
      end
    end
    object cxGridDBTableView2: TcxGridDBTableView
      PopupMenu = PopupMenuOpcoes
      OnMouseUp = cxGridDBTableView2MouseUp
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DSInsumosDetalhe
      DataController.DetailKeyFieldNames = 'CODINSUMO'
      DataController.KeyFieldNames = 'CODINSUMO'
      DataController.MasterKeyFieldNames = 'CODINSUMO'
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
      object cxGridDBTableView2CODSIMILAR: TcxGridDBColumn
        DataBinding.FieldName = 'CODSIMILAR'
      end
      object cxGridDBTableView2PROSIMILAR: TcxGridDBColumn
        DataBinding.FieldName = 'PROSIMILAR'
      end
      object cxGridDBTableView2ESTOQUESUB: TcxGridDBColumn
        DataBinding.FieldName = 'ESTOQUESUB'
      end
      object cxGridDBTableView2DEMANDASUB: TcxGridDBColumn
        DataBinding.FieldName = 'DEMANDASUB'
      end
      object cxGridDBTableView2DIASESTOQUE: TcxGridDBColumn
        DataBinding.FieldName = 'DIASESTOQUE'
        Width = 80
      end
      object cxGridDBTableView2CODINSUMO: TcxGridDBColumn
        DataBinding.FieldName = 'CODINSUMO'
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
    Width = 863
    Height = 81
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 855
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
      FieldName = 'CODINSUMO'
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
      FieldName = 'DEMANDASUB'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosSALDOATUAL: TFloatField
      DisplayLabel = 'Estoque Atual'
      FieldName = 'ESTOQUESUB'
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
      FieldName = 'CODSIMILAR'
      Size = 10
    end
    object CdsInsumosDetalheAPRESENTACAO: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 40
      FieldName = 'PROSIMILAR'
      Size = 80
    end
    object CdsInsumosDetalheSALDOATUAL: TFloatField
      DisplayLabel = 'Estoque (Sub. Unid.)'
      DisplayWidth = 15
      FieldName = 'ESTOQUESUB'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosDetalheDEMANDADIARIA: TFloatField
      DisplayLabel = 'Demanda'
      DisplayWidth = 15
      FieldName = 'DEMANDASUB'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosDetalheDIASESTOQUE: TFloatField
      DisplayLabel = 'Dias Estoque'
      DisplayWidth = 15
      FieldName = 'DIASESTOQUE'
      DisplayFormat = '#0.00'
    end
    object CdsInsumosDetalheCODPRO: TStringField
      DisplayLabel = 'Cod. Pro. Original'
      FieldName = 'CODINSUMO'
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
