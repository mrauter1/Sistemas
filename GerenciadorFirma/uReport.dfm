object fReport: TfReport
  Left = 0
  Top = 0
  Caption = 'fReport'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ReportEstoq: TfrxReport
    Version = '4.12.2'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42023.381874907400000000
    ReportOptions.LastChange = 42023.472275115740000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 112
    Top = 48
    Datasets = <
      item
        DataSet = frxDBFilaEstoq
        DataSetName = 'frxDBFilaEstoq'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        Height = 37.795300000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 230.551330000000000000
          Top = 3.779530000000001000
          Width = 253.228510000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Memo.UTF8W = (
            'Relat'#243'rio de necessidade de produ'#231#227'o')
        end
      end
      object MasterData1: TfrxMasterData
        Height = 22.677180000000000000
        Top = 162.519790000000000000
        Width = 718.110700000000000000
        DataSet = frxDBFilaEstoq
        DataSetName = 'frxDBFilaEstoq'
        RowCount = 0
        object Memo2: TfrxMemoView
          Left = 7.559060000000000000
          Width = 336.378170000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'APRESENTACAO'
          DataSet = frxDBFilaEstoq
          DataSetName = 'frxDBFilaEstoq'
          Memo.UTF8W = (
            '[frxDBFilaEstoq."APRESENTACAO"]')
        end
        object Memo3: TfrxMemoView
          Left = 351.496290000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'PROBFALTAHOJE'
          DataSet = frxDBFilaEstoq
          DataSetName = 'frxDBFilaEstoq'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBFilaEstoq."PROBFALTAHOJE"]')
        end
        object Memo4: TfrxMemoView
          Left = 449.764070000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'ESTOQUEATUAL'
          DataSet = frxDBFilaEstoq
          DataSetName = 'frxDBFilaEstoq'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBFilaEstoq."ESTOQUEATUAL"]')
        end
        object Memo5: TfrxMemoView
          Left = 532.913730000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'ESTOQMAX'
          DataSet = frxDBFilaEstoq
          DataSetName = 'frxDBFilaEstoq'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBFilaEstoq."ESTOQMAX"]')
        end
        object Memo6: TfrxMemoView
          Left = 623.622450000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'DIASESTOQUE'
          DataSet = frxDBFilaEstoq
          DataSetName = 'frxDBFilaEstoq'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBFilaEstoq."DIASESTOQUE"]')
        end
      end
      object Header1: TfrxHeader
        Height = 22.677180000000000000
        Top = 117.165430000000000000
        Width = 718.110700000000000000
        object Memo7: TfrxMemoView
          Left = 11.338590000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Memo.UTF8W = (
            'Produto')
        end
        object Memo8: TfrxMemoView
          Left = 359.055350000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Memo.UTF8W = (
            'Porb. Falta')
        end
        object Memo9: TfrxMemoView
          Left = 449.764070000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Memo.UTF8W = (
            'Estoq. Atual')
        end
        object Memo10: TfrxMemoView
          Left = 536.693260000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Memo.UTF8W = (
            'Estoq. Max')
        end
        object Memo11: TfrxMemoView
          Left = 627.401980000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Memo.UTF8W = (
            'Dias Estoq.')
        end
      end
    end
  end
  object frxDBFilaEstoq: TfrxDBDataset
    UserName = 'frxDBFilaEstoq'
    CloseDataSource = False
    FieldAliases.Strings = (
      'RANK=RANK'
      'CODPRODUTO=CODPRODUTO'
      'APRESENTACAO=APRESENTACAO'
      'PROBFALTAHOJE=PROBFALTAHOJE'
      'PROBSAI2DIAS=PROBSAI2DIAS'
      'PROBFALTA=PROBFALTA'
      'PERCENTDIAS=PERCENTDIAS'
      'MEDIASAIDA=MEDIASAIDA'
      'STDDEV=STDDEV'
      'ESTOQMAX=ESTOQMAX'
      'ESTOQUEATUAL=ESTOQUEATUAL'
      'DEMANDAC1=DEMANDAC1'
      'DEMANDA=DEMANDA'
      'DIASESTOQUE=DIASESTOQUE'
      'ESPACOESTOQUE=ESPACOESTOQUE'
      'ROTACAO=ROTACAO'
      'DEMANDADIARIA=DEMANDADIARIA'
      'UNIDADEESTOQUE=UNIDADEESTOQUE'
      'PRODUCAOMINIMA=PRODUCAOMINIMA')
    DataSource = DsFilaEstoq
    BCDToCurrency = False
    Left = 248
    Top = 48
  end
  object DsFilaEstoq: TDataSource
    DataSet = DmEstoqProdutos.CdsEstoqProdutos
    Left = 248
    Top = 112
  end
end
