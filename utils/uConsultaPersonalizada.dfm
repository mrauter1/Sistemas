object FrmConsultaPersonalizada: TFrmConsultaPersonalizada
  Left = 444
  Top = 112
  BorderStyle = bsSingle
  Caption = 'EXECUTAR CONSULTA PERSONALIZADA'
  ClientHeight = 580
  ClientWidth = 824
  Color = clBtnFace
  Constraints.MinHeight = 609
  Constraints.MinWidth = 830
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    824
    580)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 824
    Height = 566
    ActivePage = TabSheetResultado
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object TabParametros: TTabSheet
      Caption = 'DEFINIR PAR'#194'METROS'
      ImageIndex = 1
      object DBText: TDBText
        Left = 0
        Top = 0
        Width = 816
        Height = 21
        Align = alTop
        DataField = 'Descricao'
        DataSource = DmGeradorConsultas.DsConsultas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ScrollBox: TScrollBox
        Left = 0
        Top = 74
        Width = 816
        Height = 427
        HorzScrollBar.Visible = False
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        DesignSize = (
          816
          427)
        object IR_EXECUTANDOCONSULTA: TBitBtn
          Left = 733
          Top = 386
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Executar'
          Glyph.Data = {
            B6030000424DB603000000000000B60200002800000010000000100000000100
            08000000000000010000120B0000120B0000A0000000A000000000000000FFFF
            FF00FF00FF00FAFEFA00FCFEFC00014603000145030001430300014203000134
            0200013302000130020002510400024C0400029E0A00029D0A00014D0400014A
            04000141030003A00B00039D0A00039C0B00026A06000269060003960A00038C
            0A00037B080003780800025205000357060003A70C0003A60C0003A50C0003A1
            0C0003A00C00039F0C00039E0C00039E0F00039D0C00027E090004A30D00049F
            0D00049E0D00036B0A000365090006A0110007A0110006780E00044F09000668
            0D0016AA2000E9F8EA0005A0130006A71600034F090007A4150006620F000874
            12003EBC480040BC4A0048C0520054C55E0074D07D0082D58900EEFAEF0007A5
            180009AF1C0009A41C00066B110013992300AAE3B000D5F2D8000AAB1F000A99
            1F000BA42000F3FBF4000DAB28001AAD330021A33600F6FCF7000CA627000FB0
            2D000EA729000D822300138C2A001DA435000EA92D0010AC300010AB2F0011AA
            320011A3300097DDA500B7E9C10011AB340012AA340038B454004BBF6700B7E9
            C20017B641001B9D3D002BA649004CBD690056C5730088D99D00B5E9C200B8EA
            C500BAEAC600F4FCF60013AC3C0023BC4F0042B8630046BC660079D5920019B1
            480017A341006ACC880084D99E0016AF480018B54A001BB14C001CB24E001EB7
            510021B1510023B554002FBC5D0020B4520022B6550022B554002ABA5C002CBA
            5D0030BB600038BD670039BF68003EBD690049C5730050C77A0055CA7F0054C5
            7A00BFEDCF0044C6740049C7790052C77D0056CA800057CA810066CF8C0068D0
            8E0096DEB100AAE6C000E1F6E900F4FCF70078D99F0083DDA70098E1B5009AE1
            B60090E0B100AAE7C500C5F0D800A7E7C400BDEED400D0F4E30002020202020B
            120C0C070A020202020202020206061B152323262710100202020202362C281F
            130E2322201F1709020202304448372A0F14242424221E160D020230574C4325
            3247333C2424231E0D021D53625634292E3F016B3B2424201A081D72765D2D24
            29243E044B3A24211808317A798A6A6169685C4F01403D222311398580010101
            0101010401014622231C2F898B8D8F8E8F867003015B4D4126052F65977E787F
            7F889401675850351905024E9B9175778495017459524A422B02024E669C907D
            7B9392716C5E51492B02020245739F99878381827C6D5A380202020202606098
            9E9D9A968C63630202020202020202555F6F6E64540202020202}
          Layout = blGlyphRight
          TabOrder = 0
          OnClick = IR_EXECUTANDOCONSULTAClick
        end
        object BtnGravar: TBitBtn
          Left = 272
          Top = 386
          Width = 121
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Gravar'
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            0800000000000001000000000000000000000001000000010000FF00FF00004B
            0000098611000A8615000D931A000C9518000C9C19000F991C000E9D1D001392
            240011A0210011A422001CA134001CB1350024BC430029B548002EC6520035CA
            5E0039D465000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000001
            0100000000000000000000000000010808010000000000000000000000010D0B
            080B0100000000000000000001100E0901040801000000000000000111120C01
            000103080100000000000000010F010000000001040100000000000000010000
            0000000001030100000000000000000000000000000001010000000000000000
            0000000000000001010000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 1
          OnClick = BtnGravarClick
        end
        object BtnCancelar: TBitBtn
          Left = 464
          Top = 386
          Width = 129
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Cancelar'
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            0800000000000001000000000000000000000001000000010000FF00FF000000
            9A00012AF200002CF600002CF8000733F6000031FE000431FE000134FF000C3C
            FF00123BF100103BF400143EF400103DFB001743F6001B46F6001C47F6001D48
            F6001342FF001A47F8001847FF00174AFD001A48F9001D4BFF001A4CFF001D50
            FF00224DF100224CF400204BF800214CF800214EFC002550F4002D59F4002655
            FA002355FF002659FF002E5BF9002C5FFF00325DF1003B66F3003664FA00386B
            FF004071FA004274FF00497AFC00000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000010100
            00000000000101000000000001150B010000000001040601000000000113180B
            010000010306030100000000000110180B010104060301000000000000000111
            190D060603010000000000000000000118120D05010000000000000000000001
            1D181312010000000000000000000124241D1D19110100000000000000012829
            2401011F191F010000000000012A2A26010000011F231D0100000000012C2701
            00000000011F1901000000000001010000000000000101000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 2
          OnClick = BtnCancelarClick
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 501
        Width = 816
        Height = 34
        Align = alBottom
        Caption = 'PanelSqls'
        TabOrder = 1
        Visible = False
        object MemoSQL: TMemo
          Left = 1
          Top = 1
          Width = 814
          Height = 32
          Align = alClient
          Lines.Strings = (
            '')
          TabOrder = 0
          Visible = False
        end
      end
      object DBMemoDescricao: TDBMemo
        Left = 0
        Top = 21
        Width = 816
        Height = 53
        Align = alTop
        BorderStyle = bsNone
        Color = clBtnFace
        DataField = 'InfoExtendida'
        DataSource = DmGeradorConsultas.DsConsultas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
    object TabSheetAguarde: TTabSheet
      Caption = 'EXECUTANDO CONSULTA'
      ImageIndex = 3
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 816
        Height = 535
        Align = alClient
        Alignment = taCenter
        Caption = 'Aguarde.......'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -24
        Font.Name = 'Palatino Linotype'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 136
        ExplicitHeight = 32
      end
    end
    object TabSheetResultado: TTabSheet
      Caption = 'RESULTADO'
      ImageIndex = 2
      object PageControlVisualizacoes: TPageControl
        Left = 0
        Top = 28
        Width = 816
        Height = 478
        ActivePage = TabSheetSql
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        OnChange = PageControlVisualizacoesChange
        object TsTabela: TTabSheet
          Caption = 'Tabela'
          object cxGridTabela: TcxGrid
            Left = 0
            Top = 0
            Width = 808
            Height = 447
            Align = alClient
            TabOrder = 0
            object cxGridTabelaDBTableView1: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              Navigator.Buttons.First.Visible = False
              Navigator.Buttons.PriorPage.Visible = False
              Navigator.Buttons.Prior.Visible = False
              Navigator.Buttons.Next.Visible = False
              Navigator.Buttons.NextPage.Visible = False
              Navigator.Buttons.Last.Visible = False
              Navigator.Buttons.Insert.Visible = False
              Navigator.Buttons.Append.Visible = False
              Navigator.Buttons.Delete.Visible = False
              Navigator.Buttons.Edit.Visible = False
              Navigator.Buttons.Post.Visible = False
              Navigator.Buttons.Cancel.Visible = False
              Navigator.Buttons.Refresh.Visible = False
              Navigator.Buttons.SaveBookmark.Visible = False
              Navigator.Buttons.GotoBookmark.Visible = False
              Navigator.Buttons.Filter.Visible = True
              FilterBox.Visible = fvAlways
              DataController.DataSource = DsConsulta
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.Visible = True
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.HeaderAutoHeight = True
              Styles.StyleSheet = cxGridTableViewStyleSheet1
            end
            object cxGridTabelaLevel1: TcxGridLevel
              GridView = cxGridTabelaDBTableView1
            end
          end
        end
        object TsDinamica: TTabSheet
          Caption = 'Tabela Din'#226'mica'
          ImageIndex = 1
        end
        object TsGrafico: TTabSheet
          Caption = 'Gr'#225'fico'
          ImageIndex = 2
          OnResize = TsGraficoResize
          object PanelTsGrafico: TPanel
            Left = 0
            Top = 0
            Width = 808
            Height = 447
            Align = alClient
            TabOrder = 0
            object PanelGrafico: TPanel
              Left = 1
              Top = 1
              Width = 806
              Height = 445
              Align = alClient
              TabOrder = 0
              object cxGridGrafico: TcxGrid
                Left = 1
                Top = 78
                Width = 804
                Height = 366
                Align = alClient
                TabOrder = 0
                object cxGridGraficoChartView: TcxGridChartView
                  Categories.OnGetValueDisplayText = cxGridChartViewCategoriesGetValueDisplayText
                  DiagramArea.OnCustomDrawLegendItem = cxChangeLegendColorCustomDrawLegendItem
                  DiagramArea.OnCustomDrawValue = cxChangeSectionColorCustomDrawValue
                  DiagramArea.Styles.Legend = FontSizeStyle
                  DiagramArea.Styles.ValueCaptions = FontSizeStyle
                  DiagramArea.Values.CaptionPosition = ldvcpAbove
                  DiagramArea.Values.LineWidth = 2
                  DiagramArea.Values.MarkerStyle = cmsDiamond
                  DiagramBar.OnCustomDrawLegendItem = cxChangeLegendColorCustomDrawLegendItem
                  DiagramBar.OnCustomDrawValue = cxChangeSectionColorCustomDrawValue
                  DiagramBar.Styles.Legend = FontSizeStyle
                  DiagramBar.Styles.ValueCaptions = FontSizeStyle
                  DiagramBar.Values.BorderWidth = 2
                  DiagramBar.Values.CaptionPosition = cdvcpOutsideEnd
                  DiagramColumn.OnCustomDrawLegendItem = cxChangeLegendColorCustomDrawLegendItem
                  DiagramColumn.OnCustomDrawValue = cxChangeSectionColorCustomDrawValue
                  DiagramColumn.Styles.Legend = FontSizeStyle
                  DiagramColumn.Styles.ValueCaptions = FontSizeStyle
                  DiagramColumn.Values.CaptionPosition = cdvcpOutsideEnd
                  DiagramLine.OnCustomDrawLegendItem = cxChangeLegendColorCustomDrawLegendItem
                  DiagramLine.OnCustomDrawValue = cxChangeSectionColorCustomDrawValue
                  DiagramLine.AxisCategory.TickMarkKind = tmkCross
                  DiagramLine.AxisValue.TickMarkKind = tmkCross
                  DiagramLine.Styles.Legend = FontSizeStyle
                  DiagramLine.Styles.ValueCaptions = FontSizeStyle
                  DiagramLine.Values.VaryColorsByCategory = True
                  DiagramLine.Values.CaptionPosition = ldvcpAbove
                  DiagramLine.Values.LineWidth = 3
                  DiagramLine.Values.MarkerStyle = cmsTriangle
                  DiagramPie.Active = True
                  DiagramPie.OnCustomDrawLegendItem = cxChangeLegendColorCustomDrawLegendItem
                  DiagramPie.OnCustomDrawValue = cxChangeSectionColorCustomDrawValue
                  DiagramPie.SeriesColumnCount = 4
                  DiagramPie.Styles.Legend = FontSizeStyle
                  DiagramPie.Styles.ValueCaptions = FontSizeStyle
                  DiagramPie.Values.CaptionPosition = pdvcpOutsideEndWithLeaderLines
                  DiagramPie.Values.CaptionItems = [pdvciCategory, pdvciPercentage]
                  DiagramPie.Values.CaptionItemSeparator = ' - '
                  DiagramStackedArea.OnCustomDrawLegendItem = cxChangeLegendColorCustomDrawLegendItem
                  DiagramStackedArea.OnCustomDrawValue = cxChangeSectionColorCustomDrawValue
                  DiagramStackedArea.Styles.Legend = FontSizeStyle
                  DiagramStackedArea.Styles.ValueCaptions = FontSizeStyle
                  DiagramStackedArea.Values.CaptionPosition = ldvcpAbove
                  DiagramStackedArea.Values.LineWidth = 2
                  DiagramStackedArea.Values.MarkerStyle = cmsDiamond
                  DiagramStackedBar.OnCustomDrawLegendItem = cxChangeLegendColorCustomDrawLegendItem
                  DiagramStackedBar.OnCustomDrawValue = cxChangeSectionColorCustomDrawValue
                  DiagramStackedBar.Styles.Legend = FontSizeStyle
                  DiagramStackedBar.Styles.ValueAxis = FontSizeStyle
                  DiagramStackedBar.Values.CaptionPosition = cdvcpOutsideEnd
                  DiagramStackedColumn.OnCustomDrawLegendItem = cxChangeLegendColorCustomDrawLegendItem
                  DiagramStackedColumn.OnCustomDrawValue = cxChangeSectionColorCustomDrawValue
                  DiagramStackedColumn.Styles.Legend = FontSizeStyle
                  DiagramStackedColumn.Styles.ValueCaptions = FontSizeStyle
                  DiagramStackedColumn.Values.CaptionPosition = cdvcpOutsideEnd
                  Legend.Alignment = cpaStart
                  Legend.Border = lbSingle
                  Legend.Position = cppBottom
                  Styles.Title = cxStyleTitulo
                  ToolBox.CustomizeButton = True
                  ToolBox.DiagramSelector = True
                  OnActiveDiagramChanged = cxGridGraficoChartViewActiveDiagramChanged
                  OnCustomDrawLegendItem = cxGridGraficoChartViewCustomDrawLegendItem
                end
                object cxGridGraficoLevel: TcxGridLevel
                  GridView = cxGridGraficoChartView
                end
              end
              object PanelTabelaDinamica: TPanel
                Left = 1
                Top = 1
                Width = 804
                Height = 72
                Align = alTop
                TabOrder = 1
                object DBPivotGrid: TcxDBPivotGrid
                  Left = 1
                  Top = 1
                  Width = 802
                  Height = 54
                  Align = alClient
                  DataSource = DsConsulta
                  Groups = <>
                  LookAndFeel.Kind = lfOffice11
                  OptionsSelection.MultiSelect = True
                  OptionsView.ColumnGrandTotalWidth = 151
                  OptionsView.RowGrandTotalWidth = 851
                  TabOrder = 0
                end
                object PanelControlesGrafico: TPanel
                  Left = 1
                  Top = 55
                  Width = 802
                  Height = 16
                  Align = alBottom
                  Caption = 'Visualiza'#231#227'o Din'#226'mica'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -12
                  Font.Name = 'Comic Sans MS'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                  object BtnDiminuir: TSpeedButton
                    Left = 19
                    Top = -1
                    Width = 18
                    Height = 17
                    Hint = 'Minimizar Tabela'
                    Glyph.Data = {
                      E6010000424DE60100000000000036000000280000000C0000000C0000000100
                      180000000000B0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1D538625689E25689E25689E
                      25689E25689E25689E1D5386FFFFFFFFFFFFFFFFFFFFFFFF0D2B5610325F1032
                      5F10325F10325F10325F10325F0D2B56FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFF}
                    OnClick = BtnDiminuirClick
                  end
                  object BtnMaximizar: TSpeedButton
                    Left = 38
                    Top = -1
                    Width = 18
                    Height = 17
                    Hint = 'Maximizar Tabela'
                    Glyph.Data = {
                      E6010000424DE60100000000000036000000280000000C0000000C0000000100
                      180000000000B0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FF906F5F906F5F906F5F906F5F906F5F906F5F906F5F906F5F906F5F906F5FFF
                      FFFFFFFFFF906F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      906F5FFFFFFFFFFFFF906F5FFFFFFF906F5F906F5F906F5F906F5F906F5F906F
                      5FFFFFFF906F5FFFFFFFFFFFFF906F5FFFFFFF906F5F906F5F906F5F906F5F90
                      6F5F906F5FFFFFFF906F5FFFFFFFFFFFFF906F5FFFFFFF906F5F906F5F906F5F
                      906F5F906F5F906F5FFFFFFF906F5FFFFFFFFFFFFF906F5FFFFFFF906F5F906F
                      5F906F5F906F5F906F5F906F5FFFFFFF906F5FFFFFFFFFFFFF906F5FFFFFFF90
                      6F5F906F5F906F5F906F5F906F5F906F5FFFFFFF906F5FFFFFFFFFFFFF906F5F
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF906F5FFFFFFFFFFF
                      FF906F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF906F5FFF
                      FFFFFFFFFF906F5F906F5F906F5F906F5F906F5F906F5F906F5F906F5F906F5F
                      906F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFF}
                    OnClick = BtnMaximizarClick
                  end
                  object BtnMeio: TSpeedButton
                    Left = 0
                    Top = -1
                    Width = 18
                    Height = 17
                    Hint = 'Dividir'
                    Glyph.Data = {
                      E6010000424DE60100000000000036000000280000000C0000000C0000000100
                      180000000000B0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFCFC8D8D8D757575FFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8E8E8E7C7C7C838383A3
                      A3A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8E8E8E787878A5A5A5
                      ABABAB919191B0B0B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF909090757575A3A3
                      A39F9F9FA6A6A6B6B6B69F9F9FC1C1C1FFFFFFFFFFFFFFFFFF909090737373A1
                      A1A19C9C9C9E9E9EA5A5A5B2B2B2BDBDBDABABABCBCBCBFFFFFF929292707070
                      9E9E9EA2A2A2A9A9A9B0B0B0B7B7B7BCBCBCC2C2C2C4C4C4A4A4A4CFCFCF5454
                      545D5D5D6363636D6D6D7575758080808989899393939B9B9BA2A2A2A6A6A6AA
                      AAAAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                      FFFFFFFFFFFFFFFFFFFF}
                    OnClick = BtnMeioClick
                  end
                end
              end
              object cxSplitterResultado: TcxSplitter
                Left = 1
                Top = 73
                Width = 804
                Height = 5
                AlignSplitter = salTop
                MinSize = 20
                Control = PanelTabelaDinamica
              end
            end
          end
        end
        object TabSheetSql: TTabSheet
          Caption = 'Sql'
          ImageIndex = 3
          object MemoSqlGerado: TMemo
            Left = 0
            Top = 0
            Width = 808
            Height = 447
            Align = alClient
            Lines.Strings = (
              '')
            TabOrder = 0
          end
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 816
        Height = 28
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 1
        DesignSize = (
          816
          28)
        object Label5: TLabel
          Left = 16
          Top = 7
          Width = 65
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Visualiza'#231#227'o :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object BtnCarregaFiltro: TSpeedButton
          Left = 724
          Top = 2
          Width = 22
          Height = 26
          Anchors = [akRight, akBottom]
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            20000000000000040000000000000000000000000000000000005A81A7FF4781
            90FF45818DFF45818DFF45818DFF3F8185FF3F8185FF3C7F81FF3C7F81FF3A7C
            81FF3A7C81FF3A7C81FF818EA9FF0000000000000000000000005C81AAFF5A81
            A7FF6DA9D9FF4BCDF1FF3FB5E9FF3FB5E9FF3FB5E9FF3DB2E9FF3EA7DFFF3CA5
            DFFF3F9DD7FF3C94D1FF50818BFF0000000000000000000000005E81ACFF62B5
            E4FF5A81A7FF9CF6FFFF5AEFFFFF5AEFFFFF53E5FFFF53E5FFFF4BDAFFFF47D5
            FFFF44D0FFFF3DB2E9FF4B83B3FF7A818BFF00000000000000006081AFFF74D9
            FAFF6C84AEFF81CEEAFF9CF6FFFF5AEFFFFF5AEFFFFF53E5FFFF53E5FFFF4BDA
            FFFF47D5FFFF44D0FFFF3CA5DFFF50818BFF00000000000000006182B0FF80E1
            FBFF69B7E6FF6C84AEFFC0F9FFFF7EF5FFFF5AEFFFFF5AEFFFFF53E5FFFF4BDA
            FFFF4BDAFFFF47D5FFFF42CCFDFF5A8197FF818EA9FF000000006182B0FF81E3
            FBFF75E3FDFF7F91B8FF81CCE8FF98F9FFFF5AEFFFFF5AEFFFFF56EAFFFF53E5
            FFFF4BDAFFFF4BDAFFFF47D5FFFF3CA5DFFF4E8187FF000000006182B0FF81E3
            FBFF81EFFFFF7EB5E0FF6C84AEFFB7FCFFFFC0F9FFFFC0F9FFFFC0F9FFFFC0F9
            FFFFBDF6FFFFBDF6FFFFAEF1FFFF9EECFFFF3FAFE7FF4D8187FF678AB8FF81E9
            FBFF81F4FFFF81EEFFFF819EC1FF819CBFFF819CBFFF8198BCFF8198BCFF8195
            B9FF8191B5FF8191B5FF7484ACFF6381A3FF4F8199FF478190FF678AB8FF81E9
            FBFF81F4FFFF81F4FFFF81E3FBFF75E3FDFF58D6FDFF47D5FFFF42CCFDFF42CC
            FDFF42CCFDFF42CCFDFF5A8197FF000000000000000000000000678AB8FF81F1
            FDFF86FAFFFF86FAFFFF81F2FFFF81EDFFFF81E3FBFF5E81ACFF5A81A7FF5A81
            A7FF5A81A7FF5581A1FF6F81A2FF000000000000000000000000678AB8FF81CE
            F1FFB7FCFFFF98F9FFFF9CF6FFFF8FF2FFFF5E81ACFF00000000000000000000
            000000000000000000000000000000000000000000000000000000000000678A
            B8FF678AB8FF6182B0FF6182B0FF6182B0FF0000000000000000000000000000
            00000000000000000000818165FF818165FF818165FF00000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000818165FF818165FF00000000000000000000
            000000000000000000000000000000000000000000000000000081816BFF0000
            00000000000000000000888178FF0000000081816BFF00000000000000000000
            0000000000000000000000000000000000000000000000000000000000008881
            78FF888178FF9E8181FF00000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          OnClick = BtnCarregaFiltroClick
        end
        object BtnNovoFiltro: TSpeedButton
          Left = 752
          Top = 3
          Width = 21
          Height = 25
          Anchors = [akRight, akBottom]
          Glyph.Data = {
            76010000424D760100000000000036000000280000000A0000000A0000000100
            18000000000040010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFF01B31801B31801B31801B318FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFF01B31800D21E00D21E01B318FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFF01B31800D93B00D93B01B318FFFFFFFFFFFFFFFFFF000001B31801B318
            01B31801B31800DF5900DF5901B31801B31801B31801B318000001B31800E676
            00E67600E67600E67600E67600E67600E67600E67601B318000001B31800EC94
            00EC9400EC9400EC9400EC9400EC9400EC9400EC9401B318000001B31801B318
            01B31801B31800F2B200F2B201B31801B31801B31801B3180000FFFFFFFFFFFF
            FFFFFF01B31800F9CF00F9CF01B318FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFF01B31800FFEC00FFEC01B318FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
            FFFFFF01B31801B31801B31801B318FFFFFFFFFFFFFFFFFF0000}
          OnClick = BtnNovoFiltroClick
          ExplicitLeft = 547
        end
        object BtnDeleteConfiguracao: TSpeedButton
          Left = 777
          Top = 3
          Width = 21
          Height = 25
          Anchors = [akRight, akBottom]
          Glyph.Data = {
            E6010000424DE60100000000000036000000280000000C0000000C0000000100
            180000000000B0010000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            EAF0FE95B2FC608CFB5584FA5584FA608CFB95B2FCEAF0FEFFFFFFFFFFFFFFFF
            FFDFE8FE608CFB5584FA5584FA5584FA5584FA5584FA5584FA608CFBDFE8FEFF
            FFFFEAF0FE608CFB5584FA5584FA5584FA5584FA5584FA5584FA5584FA5584FA
            608CFBEAF0FE95B2FC5584FA5584FA5584FA5584FA5584FA5584FA5584FA5584
            FA5584FA5584FA95B2FC608CFB5584FA5584FA5584FA5584FA5584FA5584FA55
            84FA5584FA5584FA5584FA608CFB5584FA5584FA5584FAFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF5584FA5584FA5584FA5584FA5584FA5584FAFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF5584FA5584FA5584FA608CFB5584FA5584FA55
            84FA5584FA5584FA5584FA5584FA5584FA5584FA5584FA608CFB95B2FC5584FA
            5584FA5584FA5584FA5584FA5584FA5584FA5584FA5584FA5584FA95B2FCEAF0
            FE608CFB5584FA5584FA5584FA5584FA5584FA5584FA5584FA5584FA608CFBEA
            F0FEFFFFFFDFE8FE608CFB5584FA5584FA5584FA5584FA5584FA5584FA608CFB
            DFE8FEFFFFFFFFFFFFFFFFFFEAF0FE95B2FC608CFB5584FA5584FA608CFB95B2
            FCEAF0FEFFFFFFFFFFFF}
          OnClick = BtnDeleteConfiguracaoClick
          ExplicitLeft = 572
        end
        object cbxConfiguracoes: TDBLookupComboBox
          Left = 88
          Top = 4
          Width = 625
          Height = 22
          Anchors = [akLeft, akRight, akBottom]
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          KeyField = 'ID'
          ListField = 'Descricao'
          ListSource = DsVisualizacoes
          ParentFont = False
          TabOrder = 0
          OnClick = cbxConfiguracoesClick
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 506
        Width = 816
        Height = 29
        Align = alBottom
        TabOrder = 2
        DesignSize = (
          816
          29)
        object LabelCount: TLabel
          Left = 102
          Top = 8
          Width = 54
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'LabelCount'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ExplicitTop = 9
        end
        object LbTime: TLabel
          Left = 466
          Top = 6
          Width = 42
          Height = 13
          Anchors = [akRight, akBottom]
          Caption = '00:00:00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object VOLTAR_PARAMETROS: TBitBtn
          Left = 1
          Top = 1
          Width = 75
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Voltar'
          Glyph.Data = {
            AE030000424DAE03000000000000AE0200002800000010000000100000000100
            08000000000000010000120B0000120B00009E0000009E00000000000000FFFF
            FF00FF00FF00FCFEFC0001460300014503000143030001420300013402000133
            02000130020002510400024C0400029E0A00029D0A00014D0400014A04000141
            030003A00B00039D0A00039C0B00026A06000269060003960A00038C0A00037B
            080003780800025205000357060003A70C0003A60C0003A50C0003A10C0003A0
            0C00039F0C00039E0C00039E0F00039D0C00027E090004A30D00049E0D00036B
            0A000365090007A0100006780E00044F090006680D0016AA2000E9F8EA0005A0
            130006A71600034F090007A4150006620F000874120041BD4B0048C0520075D0
            7D0082D58900ADE5B200AFE5B400B1E6B60007A5180009AF1C0009A41C00066B
            11001399230041BD4E00D5F2D8000AAB1F000A991F000BA42000F3FBF4000DAB
            280021A336000CA627000FB02D000EA729000D822300138C2A001DA4350041BF
            570041BF5800B4E7BD000EA92D000FAA2E000FAA300010AC300010A9310011A3
            300041C05B0041BF5B00F7FCF80011AB340012AA340038B454004BBF670017B6
            41001B9D3D002BA649003EBF5E004CBD690056C57300F4FCF600FAFEFB0013AC
            3C0023BC4F002DB8530042B8630046BC6600B7E9C500F0FBF30017A341006ACC
            880016AF480018B54A001CB14D001EB751001DB24F001FB44E0021B151002FBC
            5D004FC675001CB24F0020B4520022B655002ABA5C002CBA5C002CBA5D0030BB
            600038BD67003EBD690050C77A0054C57A0070D3920082D9A00044C6740049C7
            790066CF8C0068D08E008EDCAB0095DEB000A4E3BC00ABE6C100BAEACC00E2F7
            EA00F4FCF70078D99F0083DDA70098E1B5009AE1B60090E0B100AAE7C500C5F0
            D800A7E7C400BDEED400D0F4E300FCFFFE0002020202020A110B0B0609020202
            020202020205051A14222225260F0F0202020202332A271E120D22211F1E1608
            0202022D414534280E13232323211D150C02022D574940243830442F2323221D
            0C021C4E6154313767013A2B2323231F19071C70735D43480339232323232320
            17072E7875866F015C6E533B3B3C3D21221036837E9001019D01010101010121
            221B2C85887F8E016887645A5B52513E25042C65947D768D01917A5D56554B32
            1804024A988B72748C01926B584D473F2902024A66998A7C7B8D8F77695E4C46
            2902020242719C9684828081796A593502020202026060959B9A979389626202
            02020202020202505F6D6C634F0202020202}
          TabOrder = 0
          OnClick = VOLTAR_PARAMETROSClick
        end
        object BtnExcelcxGridTarefa: TBitBtn
          Left = 644
          Top = 0
          Width = 77
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Exportar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E000000000000000000002E7749266E43
            357B532367443070531B594137725D205B4725624E23634D195B3E004622256E
            460351220F612D0A5C2739734A73AC856BA17C679C7B61927664947C58867072
            A08D5A887552836D53896C558E6D48855F4283565394660B501E5F7D5A7D9A79
            E8FFE4E5FEE2F3FFF0C7DDC5E7FAE5C9DCC7D8EBD6D6ECD4E1FAE0DAF6D8B7D6
            B5D6F8D34C71492E562C6F8568778D70D1E7CAF6FFEDD0E3C8E2F3D8F8FFEEE6
            F7DCDEEFD4E5F9DCD6ECCFCEE6C6ECFFE5CEECC96889642E4F2A49715595BDA1
            E4FFEEDFFFE6D7FCDAE4FFE7D5FBD7CDF3CF8FB690365F39244D2726522B2150
            2AC9FAD44A7B552356304E7E6481B296CBFBDE5082602C5D371C4B2432633719
            4A1C265A2B6B9F704C81556BA1762C643BB0E9C256916B29634057876F86B69C
            DDFFF0CEFFDE6C9E766DA0745789595386548FC49273A8765D946319502375AD
            84C0F9D357916E17533162927A7AAA90D9FFECD5FFE3D4FFDE75A97A4679477E
            B27D5D945D4A804B20582570A7785C946BBEF7D1589170215C3D6D9B8487B69C
            DFFFF0DAFFE6C7F6CF5081539ED19F699D686397614379441D5522BDF4C5C5FD
            D4C1FAD45A93722E674867957E94C3A9D6FFE7DCFFEA61906996C79B7BAD7D6F
            A270518452639664497D4D24592DC6FBD3CCFFDD5B93701E57367CA98F99C6AB
            D6FFE5588564AFDBB681AE8785B388578658507F5175A678649569396B412A5F
            37BAF1CA578D6851896676997EB1D4B9EAFFEE80A28368896789AA886A8A67EC
            FFEAE1FFDE648963648963668D675A8560D0FCD77DA98424532D95A78AB7C9AC
            EAF9DDFAFFEDF9FFECECF9DFFDFFEEE9F4DAFDFFEED1DFC3F1FFE4DBEDCEF1FF
            E5D3EBC98FA9854F6B47ABC3A1B9D0B0F6FFEDF6FFECEDFDE5FAFFF1FAFFF2FA
            FFF2EAF6E2F8FFF1EDFFE7F2FFEBE4FCDCE8FFE088A78056784F659971A7DAB4
            A8D8B495C4A4B1DCC190B7A193BAA590B6A488AE9C85AE9990BDA276A7876B9F
            7A7CB489639E71306E3E85C89B78BA9071B0896AA785659C8176AC955287735E
            92805F93813D7560528C703C7C593C7D563E86582F784635804C}
          TabOrder = 1
          OnClick = BtnExcelcxGridTarefaClick
        end
        object PnFont: TPanel
          Left = 283
          Top = 0
          Width = 177
          Height = 25
          Anchors = [akLeft, akTop, akRight, akBottom]
          AutoSize = True
          DockSite = True
          TabOrder = 2
          DesignSize = (
            177
            25)
          object Label3: TLabel
            Left = 73
            Top = 4
            Width = 23
            Height = 13
            Anchors = [akLeft, akBottom]
            Caption = 'Size:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ExplicitTop = 5
          end
          object Button4: TButton
            Left = 1
            Top = 1
            Width = 33
            Height = 23
            Caption = 'N'
            DragCursor = crHandPoint
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = BtNegritoClick
          end
          object Button3: TButton
            Left = 34
            Top = 1
            Width = 33
            Height = 23
            Caption = 'I'
            DragCursor = crHandPoint
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = BtItalicoClick
          end
          object cbTamFonteGrafico: TComboBox
            Left = 100
            Top = 3
            Width = 76
            Height = 21
            TabOrder = 2
            OnClick = cbTamFonteGraficoClick
            Items.Strings = (
              '8'
              '10'
              '12'
              '14'
              '16'
              '18'
              '20'
              '')
          end
        end
        object BtnSalvaImg: TBitBtn
          Left = 173
          Top = 0
          Width = 89
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Salvar Img'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000303030776262
            62B1626262B1626262B1626262B1626262B1626262B1626262B1626262B16262
            62B1626262B1626262B1626262B1626262B1626262B12B2B2B7A6C6C6CAE6C94
            81FF468165FF468468FF468368FF468769FF468869FF478B6BFF478B6CFF5F9A
            82FF7DAE9AFF519579FF619D85FF609981FF6D9F8AFF636363B16C6C6CAE397A
            5DFF025B33FF025D36FF026035FF026237FF026236FF026336FF08673BFF488E
            6EFF378361FF4E9275FF428A6DFF498E71FF47886CFF636363B16D6D6DAE3A8B
            69FF037041FF037242FF037344FF037746FF047846FF047847FF087847FF4B98
            75FF1B784DFF197247FF418766FF549075FF5E957CFF646464B16F6F6FAE3B9E
            76FF048D56FF058F59FF059059FF058E57FF058E57FF058B55FF1C8C67FF3A95
            7FFF4A9683FF2B7F66FF217B54FF218256FF50997AFF656565B16F6F6FAE3EB4
            87FF08A669FF08A96BFF08A86BFF09A469FF0AA268FF09A267FF10A46DFF8DBA
            D9FF6D92B0FF6E90A7FF328570FF068751FF3D9A75FF666666B1717171AE42BB
            8DFF0DB274FF10B878FF12BC7BFF12B879FF11B475FF11B174FF15B478FF94C1
            E2FF7298B5FF546671FF26A67AFF0DA66AFF43B086FF676767B1727272AE84C0
            9EFF67B98AFF76C596FF88CEA7FF97CEA8FF82C89FFF80C9A3FF85CCA5FFA0BF
            BEFF769CB8FF383735FFD9DCAAFFD8CF86FFD6D39EFF686868B1737373AEF4E0
            C0FFF8DBAAFFF9DDADFFF9E1B6FFFBEDD6FFFBF0DDFFFBEEDAFFFBF1E0FFDCDD
            D7FF7B909EFF5B5347FFF9D393FFF8D08DFFF6D9A7FF696969B1747474AEF2CB
            92FFF8D9AAFFF9DFB8FFFBECD6FFFEFEFDFFFEF7ECFFFDF4E5FFFCEFD4FFFEF1
            D3FFFAD9A2FFF6D5A5FFF1CE9CFFECBF84FFE9C495FF6A6A6AB1757575AEF2CE
            9AFFFAE3C3FFFCEEDBFFF8D9AEFFFBEEDBFFFCF1DFFFF6CA89FFF5C27BFFF5BF
            74FFF3AF55FFF9D29AFFFEF5E1FFF9E1BCFFF4E2C6FF6B6B6BB1757575AEF0D0
            A9FFF2D3ABFFF4DDBEFFF4E0C3FFF6E8D6FFF8F3ECFFF6E8D3FFF1CA99FFF1CA
            99FFF2CB9AFFF2CB99FFF6E5CBFFF7E9D2FFF5E8D5FF6C6C6CB12C2C2C605252
            528F5252528F5252528F5252528F5252528F5252528F5252528F5252528F5252
            528F5252528F5252528F5252528F5252528F5252528F26262661000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 3
          Visible = False
          OnClick = BtnSalvaImgClick
        end
        object CbxFormatoNativo: TCheckBox
          Left = 539
          Top = 4
          Width = 99
          Height = 17
          Anchors = [akRight, akBottom]
          Caption = 'Formato Nativo'
          TabOrder = 4
        end
      end
    end
  end
  object BtnFechar: TBitBtn
    Left = 737
    Top = 533
    Width = 75
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = 'Fechar'
    Glyph.Data = {
      B6020000424DB602000000000000B60100002800000010000000100000000100
      08000000000000010000120B0000120B0000600000006000000000000000FFFF
      FF00FF00FF00FCD1D3004E1E1F00C54D4E00C9525300C24F5000D4585900C954
      5500CF575800CB555600D75C5D00D55C5D00D05A5B00CF595A00B74F5200B24D
      4E00B64F5000D55E5F00BD535600D75F6000DD636400C2575A00C6595B00E267
      6800DD656600DA636400E3686900DE666700EB6D6E00E96C6D00F2737400F073
      7400EE727300F7777900D1656600F0757600F6797A00F77A7B00FE7F8000FB7E
      7F00FF818200FC7F8000DA6E6F00FF828300FE818200FF838400E5767700E073
      7400E2757600FF868700FF888900CF6E7000CB6C6D00CC6E7000FE8B8C00EB81
      8200E67E7F009C565700FB9A9C00F8AAAB00F7B5B600FAD3D400A64B4B00A94D
      4D00F8787900D76B6B00CF6E6E00824B4B00FAEBC500FCEFC700FFF2CC00FCFB
      CF00FCFBD100FFFFD300FFFFD400FFFFD500FFFFD700E6FCC700A5D8970050D1
      6F0026B149002AB44D001BBB490023B54A002DC7580042C966000CBC410010BB
      430013C1480013BC450016BD480016BC48001CBF4C001EBC4C00020202020202
      0245040202020202020202020202454540410402020202020202020245451207
      05110445454545454502020245080B09061004383C3D3E3E45020202450C0E0F
      0A1404555A5C583E45020202451615130D1704535E5F5B3E45020202451C1A1B
      1D1804525D54593E45020202451E193A3F3704505157563E4502020245201F39
      033504484E4C4F3E4502020245422522212404474D4B4E3E4502020245282726
      234304474D4B4D3E45020202452F2B29282C04474D4B4D3E4502020245342D2A
      2D3104474D4B4D3E450202024545322E333004464A494A3E450202020202453B
      3644044545454545450202020202020245450402020202020202}
    TabOrder = 1
    OnClick = BtnFecharClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 566
    Width = 824
    Height = 14
    Panels = <>
    SimplePanel = True
  end
  object DsConsulta: TDataSource
    AutoEdit = False
    DataSet = QryConsulta
    Left = 184
    Top = 431
  end
  object cxPivotGridChartConnection: TcxPivotGridChartConnection
    GridChartView = cxGridGraficoChartView
    PivotGrid = DBPivotGrid
    OnGetSeriesDisplayText = cxPivotGridChartConnectionGetSeriesDisplayText
    Left = 72
    Top = 104
  end
  object DsVisualizacoes: TDataSource
    DataSet = QryVisualizacoes
    Left = 671
    Top = 17
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.xls'
    Title = 'Definir o Caminho e o Nome do Arquivo para Exporta'#231#227'o'
    Left = 443
    Top = 104
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 532
    Top = 104
  end
  object cxStyleFontes: TcxStyleRepository
    Left = 264
    Top = 282
    PixelsPerInch = 96
    object FontSizeStyle: TcxStyle
    end
    object cxStyleTitulo: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold, fsUnderline]
    end
  end
  object QryVisualizacoes: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT * FROM'
      'cons.Visualizacoes'
      'WHERE Consulta =:codConsulta')
    Left = 584
    Top = 16
    ParamData = <
      item
        Name = 'CODCONSULTA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QryVisualizacoesID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryVisualizacoesConsulta: TIntegerField
      FieldName = 'Consulta'
      Origin = 'Consulta'
    end
    object QryVisualizacoesDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 1024
    end
    object QryVisualizacoesArquivo: TBlobField
      FieldName = 'Arquivo'
      Origin = 'Arquivo'
      Size = 2147483647
    end
    object QryVisualizacoesDataHora: TSQLTimeStampField
      FieldName = 'DataHora'
      Origin = 'DataHora'
    end
  end
  object QryConsulta: TFDQuery
    Connection = ConSqlServer.FDConnection
    Left = 72
    Top = 432
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 227
    Top = 104
    PixelsPerInch = 96
    object cxStyleLinhaPar: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 12961221
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10066329
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyleLinhaImpar: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 5491711
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
    end
    object cxStyleGroup: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object cxStyleHeader: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
    end
    object cxGridTableViewStyleSheet1: TcxGridTableViewStyleSheet
      Styles.ContentEven = cxStyleLinhaImpar
      Styles.ContentOdd = cxStyleLinhaPar
      Styles.Group = cxStyleGroup
      Styles.Header = cxStyleHeader
      BuiltIn = True
    end
  end
end
