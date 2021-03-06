object FormGravaEmbalagens: TFormGravaEmbalagens
  Left = 0
  Top = 0
  Caption = 'Email de embalagens para os clientes'
  ClientHeight = 529
  ClientWidth = 955
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 955
    Height = 529
    ActivePage = TabSheetAVencer
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object TabPendentes: TTabSheet
      Caption = 'Pendentes'
      object PanelBotPendentes: TPanel
        Left = 0
        Top = 459
        Width = 947
        Height = 42
        Align = alBottom
        TabOrder = 0
        object BtnSeleciona: TBitBtn
          Left = 8
          Top = 6
          Width = 49
          Height = 27
          Caption = '[V]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = BtnSelecionaClick
        end
      end
      object PanelPendentes: TPanel
        Left = 0
        Top = 65
        Width = 947
        Height = 394
        Align = alClient
        Caption = 'PanelPendentes'
        TabOrder = 1
        object cxGridEmbalagens: TcxGrid
          Left = 1
          Top = 1
          Width = 945
          Height = 392
          Align = alClient
          TabOrder = 0
          object cxGridViewClientes: TcxGridDBTableView
            PopupMenu = PopupMenu
            Navigator.Buttons.CustomButtons = <>
            OnCellClick = cxGridViewClientesCellClick
            DataController.DataSource = DsEmbalagens
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
            Styles.OnGetContentStyle = cxGridViewClientesStylesGetContentStyle
            Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
            object cxGridViewClientesSelecionado: TcxGridDBColumn
              DataBinding.FieldName = 'Selecionado'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Width = 26
            end
            object cxGridViewClientesDESCSTATUS: TcxGridDBColumn
              DataBinding.FieldName = 'DESCSTATUS'
              Width = 83
            end
            object cxGridViewClientesstatus: TcxGridDBColumn
              DataBinding.FieldName = 'status'
              Visible = False
            end
            object cxGridViewClientesCODCLIENTE: TcxGridDBColumn
              DataBinding.FieldName = 'CODCLIENTE'
              Visible = False
              Width = 59
            end
            object cxGridViewClientesRAZAOSOCIAL: TcxGridDBColumn
              DataBinding.FieldName = 'RAZAOSOCIAL'
              Width = 158
            end
            object cxGridViewClientesCIDADE: TcxGridDBColumn
              DataBinding.FieldName = 'CIDADE'
              Width = 83
            end
            object cxGridViewClientesdatacomprovante: TcxGridDBColumn
              DataBinding.FieldName = 'datacomprovante'
              Width = 73
            end
            object cxGridViewClienteschavenfpro: TcxGridDBColumn
              DataBinding.FieldName = 'chavenfpro'
              Visible = False
            end
            object cxGridViewClientesnumero: TcxGridDBColumn
              DataBinding.FieldName = 'numero'
              Width = 43
            end
            object cxGridViewClientesserie: TcxGridDBColumn
              DataBinding.FieldName = 'serie'
              Width = 33
            end
            object cxGridViewClientescodproduto: TcxGridDBColumn
              DataBinding.FieldName = 'codproduto'
              Visible = False
              Width = 49
            end
            object cxGridViewClientesapresentacao: TcxGridDBColumn
              DataBinding.FieldName = 'apresentacao'
              Width = 121
            end
            object cxGridViewClientesQuantPendente: TcxGridDBColumn
              DataBinding.FieldName = 'QuantPendente'
              Width = 68
            end
            object cxGridViewClientesQuantDevolvida: TcxGridDBColumn
              DataBinding.FieldName = 'QuantDevolvida'
              Width = 62
            end
            object cxGridViewClientesTOTPAGO: TcxGridDBColumn
              DataBinding.FieldName = 'TOTPAGO'
              Visible = False
              Width = 70
            end
            object cxGridViewClientesVALTOTAL: TcxGridDBColumn
              DataBinding.FieldName = 'VALTOTAL'
              Visible = False
              Width = 59
            end
            object cxGridViewClientesEntregaParcial: TcxGridDBColumn
              DataBinding.FieldName = 'EntregaParcial'
              Visible = False
              Width = 62
            end
            object cxGridViewClientesCHAVENF: TcxGridDBColumn
              DataBinding.FieldName = 'CHAVENF'
              Visible = False
            end
            object cxGridViewClientesVALUNIDADE: TcxGridDBColumn
              DataBinding.FieldName = 'VALUNIDADE'
              Visible = False
            end
            object cxGridViewClientesQuantAtendida: TcxGridDBColumn
              DataBinding.FieldName = 'QuantAtendida'
              Width = 57
            end
          end
          object cxGridEmbalagensDBTableView1: TcxGridDBTableView
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
          object cxGridEmbalagensDBTableView2: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            FilterBox.Visible = fvNever
            DataController.DataSource = DsEmbalagens
            DataController.DetailKeyFieldNames = 'codcliente'
            DataController.KeyFieldNames = 'codcliente'
            DataController.MasterKeyFieldNames = 'CODCLIENTE'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            OptionsView.HeaderAutoHeight = True
            object cxGridEmbalagensDBTableView2Selecionado: TcxGridDBColumn
              DataBinding.FieldName = 'Selecionado'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Width = 41
            end
            object cxGridEmbalagensDBTableView2chavenfpro: TcxGridDBColumn
              DataBinding.FieldName = 'chavenfpro'
            end
            object cxGridEmbalagensDBTableView2codcliente: TcxGridDBColumn
              DataBinding.FieldName = 'codcliente'
              Visible = False
              Options.Editing = False
            end
            object cxGridEmbalagensDBTableView2numero: TcxGridDBColumn
              DataBinding.FieldName = 'numero'
              Options.Editing = False
              Width = 62
            end
            object cxGridEmbalagensDBTableView2serie: TcxGridDBColumn
              DataBinding.FieldName = 'serie'
              Options.Editing = False
              Width = 49
            end
            object cxGridEmbalagensDBTableView2datacomprovante: TcxGridDBColumn
              Caption = 'Data Nota'
              DataBinding.FieldName = 'datacomprovante'
              Options.Editing = False
              Width = 90
            end
            object cxGridEmbalagensDBTableView2codproduto: TcxGridDBColumn
              DataBinding.FieldName = 'codproduto'
              Options.Editing = False
              Width = 62
            end
            object cxGridEmbalagensDBTableView2apresentacao: TcxGridDBColumn
              DataBinding.FieldName = 'apresentacao'
              Options.Editing = False
              Width = 196
            end
            object cxGridEmbalagensDBTableView2NOMECLIENTE: TcxGridDBColumn
              DataBinding.FieldName = 'NOMECLIENTE'
              Visible = False
              Options.Editing = False
            end
          end
          object cxGridClientesLevel: TcxGridLevel
            GridView = cxGridViewClientes
          end
        end
      end
      object PanelTopPendentes: TPanel
        Left = 0
        Top = 0
        Width = 947
        Height = 65
        Align = alTop
        TabOrder = 2
        object Label1: TLabel
          Left = 230
          Top = 41
          Width = 53
          Height = 13
          Alignment = taRightJustify
          Caption = 'Data Inicial'
        end
        object Label2: TLabel
          Left = 443
          Top = 41
          Width = 48
          Height = 13
          Alignment = taRightJustify
          Caption = 'Data Final'
        end
        object Label3: TLabel
          Left = 250
          Top = 14
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'Cliente'
        end
        object BtnAtualizar: TButton
          Left = 648
          Top = 35
          Width = 75
          Height = 25
          Caption = 'Atualizar'
          TabOrder = 0
          OnClick = BtnAtualizarClick
        end
        object DataIniPicker: TDateTimePicker
          Left = 289
          Top = 38
          Width = 112
          Height = 21
          Date = 44071.444021122680000000
          Time = 44071.444021122680000000
          TabOrder = 1
        end
        object DataFimPicker: TDateTimePicker
          Left = 497
          Top = 38
          Width = 107
          Height = 21
          Date = 44071.444021122680000000
          Time = 44071.444021122680000000
          TabOrder = 2
        end
        object CheckBoxMostrarIgnorados: TCheckBox
          Left = 16
          Top = 42
          Width = 169
          Height = 17
          Caption = 'Mostrar Embalagens Ignoradas'
          TabOrder = 3
          OnClick = CheckBoxMostrarIgnoradosClick
        end
        object EditCliente: TEdit
          Left = 289
          Top = 11
          Width = 315
          Height = 21
          TabOrder = 4
          OnKeyDown = EditClienteKeyDown
        end
        object CheckBoxMostrarEnviados: TCheckBox
          Left = 16
          Top = 15
          Width = 169
          Height = 17
          Caption = 'Mostrar Embalagens Enviadas'
          TabOrder = 5
          OnClick = CheckBoxMostrarIgnoradosClick
        end
        object BtnEnviarEmail: TButton
          Left = 744
          Top = 35
          Width = 75
          Height = 25
          Caption = 'Enviar Email'
          TabOrder = 6
          OnClick = BtnEnviarEmailClick
        end
        object BtnOpcoes: TButton
          Left = 648
          Top = 4
          Width = 75
          Height = 25
          Caption = 'Op'#231#245'es'
          TabOrder = 7
          OnClick = BtnOpcoesClick
        end
      end
    end
    object TabSheetAVencer: TTabSheet
      Caption = 'Prestes A Vencer'
      ImageIndex = 1
      object PanelTopAVencer: TPanel
        Left = 0
        Top = 0
        Width = 947
        Height = 65
        Align = alTop
        TabOrder = 0
        object Label4: TLabel
          Left = 195
          Top = 41
          Width = 96
          Height = 13
          Alignment = taRightJustify
          Caption = 'Data Vencimento de'
        end
        object Label5: TLabel
          Left = 450
          Top = 42
          Width = 16
          Height = 13
          Alignment = taRightJustify
          Caption = 'at'#233
        end
        object Label6: TLabel
          Left = 258
          Top = 14
          Width = 33
          Height = 13
          Alignment = taRightJustify
          Caption = 'Cliente'
        end
        object BtnAtualizaAVencer: TButton
          Left = 656
          Top = 35
          Width = 75
          Height = 25
          Caption = 'Atualizar'
          TabOrder = 0
          OnClick = BtnAtualizaAVencerClick
        end
        object DataIniAVencer: TDateTimePicker
          Left = 297
          Top = 38
          Width = 112
          Height = 21
          Date = 44071.444021122680000000
          Time = 44071.444021122680000000
          TabOrder = 1
        end
        object DataFimAVencer: TDateTimePicker
          Left = 505
          Top = 38
          Width = 107
          Height = 21
          Date = 44071.444021122680000000
          Time = 44071.444021122680000000
          TabOrder = 2
        end
        object CbxIgnoradasAVencer: TCheckBox
          Left = 16
          Top = 42
          Width = 169
          Height = 17
          Caption = 'Mostrar Embalagens Ignoradas'
          TabOrder = 3
          OnClick = CbxEnviadasAVencerClick
        end
        object EditAVencerCli: TEdit
          Left = 297
          Top = 11
          Width = 315
          Height = 21
          TabOrder = 4
          OnKeyDown = EditClienteKeyDown
        end
        object CbxEnviadasAVencer: TCheckBox
          Left = 16
          Top = 15
          Width = 169
          Height = 17
          Caption = 'Mostrar Embalagens Enviadas'
          TabOrder = 5
          OnClick = CbxEnviadasAVencerClick
        end
        object BtnEnviarEmailPrestesAVencer: TButton
          Left = 752
          Top = 35
          Width = 75
          Height = 25
          Caption = 'Enviar Email'
          TabOrder = 6
          OnClick = BtnEnviarEmailPrestesAVencerClick
        end
        object Button3: TButton
          Left = 656
          Top = 4
          Width = 75
          Height = 25
          Caption = 'Op'#231#245'es'
          TabOrder = 7
          OnClick = BtnOpcoesClick
        end
      end
      object PanelBotAVencer: TPanel
        Left = 0
        Top = 459
        Width = 947
        Height = 42
        Align = alBottom
        TabOrder = 1
        object BtnSelecionaAVencer: TBitBtn
          Left = 8
          Top = 6
          Width = 49
          Height = 27
          Caption = '[V]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = BtnSelecionaAVencerClick
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 65
        Width = 947
        Height = 394
        Align = alClient
        Caption = 'PanelAVencer'
        TabOrder = 2
        object cxGrid1: TcxGrid
          Left = 1
          Top = 1
          Width = 945
          Height = 392
          Align = alClient
          TabOrder = 0
          object cxGrid1DBTableView1: TcxGridDBTableView
            PopupMenu = PopupMenu
            Navigator.Buttons.CustomButtons = <>
            OnCellClick = cxGridDBTableViewAVencerCellClick
            DataController.DataSource = DSAVencer
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
            OptionsView.HeaderAutoHeight = True
            Styles.ContentEven = FormGlobal.cxStyleLinhaPar
            Styles.ContentOdd = FormGlobal.cxStyleLinhaImpar
            Styles.Group = FormGlobal.cxStyleGroup
            object cxGrid1DBTableView1Selecionado: TcxGridDBColumn
              DataBinding.FieldName = 'Selecionado'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Width = 37
            end
            object cxGrid1DBTableView1chavenfpro: TcxGridDBColumn
              DataBinding.FieldName = 'chavenfpro'
              Visible = False
            end
            object cxGrid1DBTableView1codcliente: TcxGridDBColumn
              DataBinding.FieldName = 'codcliente'
              Visible = False
            end
            object cxGrid1DBTableView1SATUSAVENCER: TcxGridDBColumn
              DataBinding.FieldName = 'SATUSAVENCER'
              Width = 61
            end
            object cxGrid1DBTableView1status: TcxGridDBColumn
              DataBinding.FieldName = 'status'
              Visible = False
            end
            object cxGrid1DBTableView1RAZAOSOCIAL: TcxGridDBColumn
              DataBinding.FieldName = 'RAZAOSOCIAL'
              Width = 109
            end
            object cxGrid1DBTableView1CIDADE: TcxGridDBColumn
              DataBinding.FieldName = 'CIDADE'
              Visible = False
            end
            object cxGrid1DBTableView1datacomprovante: TcxGridDBColumn
              DataBinding.FieldName = 'datacomprovante'
            end
            object cxGrid1DBTableView1DataVencimento: TcxGridDBColumn
              DataBinding.FieldName = 'DataVencimento'
              Width = 71
            end
            object cxGrid1DBTableView1DiasParaVencimento: TcxGridDBColumn
              DataBinding.FieldName = 'DiasParaVencimento'
              Width = 46
            end
            object cxGrid1DBTableView1numero: TcxGridDBColumn
              DataBinding.FieldName = 'numero'
              Width = 47
            end
            object cxGrid1DBTableView1serie: TcxGridDBColumn
              DataBinding.FieldName = 'serie'
              Width = 35
            end
            object cxGrid1DBTableView1codproduto: TcxGridDBColumn
              DataBinding.FieldName = 'codproduto'
              Visible = False
            end
            object cxGrid1DBTableView1apresentacao: TcxGridDBColumn
              DataBinding.FieldName = 'apresentacao'
              Width = 102
            end
            object cxGrid1DBTableView1CHAVENF: TcxGridDBColumn
              DataBinding.FieldName = 'CHAVENF'
              Visible = False
            end
            object cxGrid1DBTableView1VALTOTAL: TcxGridDBColumn
              DataBinding.FieldName = 'VALTOTAL'
              Width = 65
            end
            object cxGrid1DBTableView1ValorPendente: TcxGridDBColumn
              DataBinding.FieldName = 'ValorPendente'
              Width = 54
            end
            object cxGrid1DBTableView1QuantAtendida: TcxGridDBColumn
              DataBinding.FieldName = 'QuantAtendida'
              Width = 45
            end
            object cxGrid1DBTableView1QuantDevolvida: TcxGridDBColumn
              DataBinding.FieldName = 'QuantDevolvida'
              Width = 53
            end
            object cxGrid1DBTableView1QuantPendente: TcxGridDBColumn
              DataBinding.FieldName = 'QuantPendente'
              Width = 52
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
    end
  end
  object QryEmbalagens: TFDQuery
    AfterClose = QryEmbalagensAfterClose
    OnCalcFields = QryEmbalagensCalcFields
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT *'
      'from vwEmbalagemPendente'
      'where'
      '  DATACOMPROVANTE between :DataIni and :DataFim'
      '     /*Ignorados*/'
      '     /*Cliente*/'
      
        'ORDER BY datacomprovante desc, RAZAOSOCIAL, ValTotal desc, QUANT' +
        'ATENDIDA desc')
    Left = 40
    Top = 192
    ParamData = <
      item
        Name = 'DATAINI'
        DataType = ftDate
        ParamType = ptInput
        Value = '28/08/2020'
      end
      item
        Name = 'DATAFIM'
        DataType = ftDate
        ParamType = ptInput
        Value = '28/08/2020'
      end>
    object QryEmbalagensSelecionado: TBooleanField
      DisplayLabel = 'Sel'
      FieldKind = fkCalculated
      FieldName = 'Selecionado'
      Calculated = True
    end
    object QryEmbalagensDESCSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'DESCSTATUS'
      Origin = 'DESCSTATUS'
      ReadOnly = True
      Required = True
      Size = 11
    end
    object QryEmbalagenscodcliente: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'codcliente'
      Origin = 'codcliente'
      Required = True
      Visible = False
      FixedChar = True
      Size = 6
    end
    object QryEmbalagensstatus: TIntegerField
      FieldName = 'status'
      Origin = 'status'
    end
    object QryEmbalagensRAZAOSOCIAL: TStringField
      DisplayLabel = 'Nome Cliente'
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Visible = False
      Size = 80
    end
    object QryEmbalagensCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Visible = False
      FixedChar = True
      Size = 35
    end
    object QryEmbalagenschavenfpro: TStringField
      FieldName = 'chavenfpro'
      Origin = 'chavenfpro'
      Required = True
      FixedChar = True
      Size = 21
    end
    object QryEmbalagensSEQUENCIADOPRODUTO: TIntegerField
      FieldName = 'SEQUENCIADOPRODUTO'
      Origin = 'SEQUENCIADOPRODUTO'
    end
    object QryEmbalagensdatacomprovante: TDateField
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'datacomprovante'
      Origin = 'datacomprovante'
    end
    object QryEmbalagensnumero: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'numero'
      Origin = 'numero'
      FixedChar = True
      Size = 6
    end
    object QryEmbalagensserie: TStringField
      DisplayLabel = 'S'#233'rie'
      FieldName = 'serie'
      Origin = 'serie'
      FixedChar = True
      Size = 4
    end
    object QryEmbalagenscodproduto: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'codproduto'
      Origin = 'codproduto'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryEmbalagensapresentacao: TStringField
      DisplayLabel = 'Embalagem'
      FieldName = 'apresentacao'
      Origin = 'apresentacao'
      Size = 80
    end
    object QryEmbalagensQuantAtendida: TBCDField
      DisplayLabel = 'Qtd. Total'
      FieldName = 'QuantAtendida'
      Origin = 'QuantAtendida'
      Precision = 18
    end
    object QryEmbalagensCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Origin = 'CHAVENF'
      Required = True
      Visible = False
      FixedChar = True
      Size = 15
    end
    object QryEmbalagensTOTPAGO: TFMTBCDField
      DisplayLabel = 'Valor Devolvido'
      DisplayWidth = 19
      FieldName = 'TOTPAGO'
      Origin = 'TOTPAGO'
      ReadOnly = True
      currency = True
      Precision = 38
      Size = 2
    end
    object QryEmbalagensVALTOTAL: TBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'VALTOTAL'
      Origin = 'VALTOTAL'
      currency = True
      Precision = 18
    end
    object QryEmbalagensEntregaParcial: TStringField
      DisplayLabel = 'Entrega Parcial'
      FieldName = 'EntregaParcial'
      Origin = 'EntregaParcial'
      ReadOnly = True
      Required = True
      Size = 3
    end
    object QryEmbalagensVALUNIDADE: TFMTBCDField
      FieldName = 'VALUNIDADE'
      Visible = False
      Precision = 38
      Size = 20
    end
    object QryEmbalagensQuantDevolvida: TFMTBCDField
      DisplayLabel = 'Qtd. Devolvida'
      FieldName = 'QuantDevolvida'
      ReadOnly = True
      Precision = 38
      Size = 6
    end
    object QryEmbalagensQuantPendente: TFMTBCDField
      DisplayLabel = 'Qtd. Pendente'
      FieldName = 'QuantPendente'
      Origin = 'QuantPendente'
      ReadOnly = True
      Precision = 38
      Size = 6
    end
    object QryEmbalagensENVIADOAVENCER: TBooleanField
      FieldName = 'ENVIADOAVENCER'
      Origin = 'ENVIADOAVENCER'
      Required = True
    end
    object QryEmbalagensDataVencimento: TDateField
      FieldName = 'DataVencimento'
      Origin = 'DataVencimento'
    end
    object QryEmbalagensValorPendente: TFMTBCDField
      FieldName = 'ValorPendente'
      Origin = 'ValorPendente'
      ReadOnly = True
      Precision = 38
      Size = 6
    end
  end
  object DsEmbalagens: TDataSource
    DataSet = QryEmbalagens
    Left = 128
    Top = 192
  end
  object PopupMenu: TPopupMenu
    OnPopup = PopupMenuPopup
    Left = 488
    Top = 240
    object EmbalagensCli1: TMenuItem
      Caption = 'Abrir Embalagens do Cliente'
      OnClick = EmbalagensCli1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object IgnorarEmbalagem1: TMenuItem
      Caption = 'Ignorar Embalagem'
      OnClick = IgnorarEmbalagem1Click
    end
    object DeixardeIgnorarEmbalagem1: TMenuItem
      Caption = 'Deixar de Ignorar Embalagem'
      OnClick = DeixardeIgnorarEmbalagem1Click
    end
    object AjustarEmbalagens1: TMenuItem
      Caption = 'Ajustar Embalagens'
      OnClick = AjustarEmbalagens1Click
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 512
    Top = 8
    PixelsPerInch = 96
    object cxStyleVermelho: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 2105599
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxStyleAmarelo: TcxStyle
      AssignedValues = [svColor]
      Color = clYellow
    end
  end
  object PopupOpcoes: TPopupMenu
    Left = 328
    Top = 201
    object ConfiguarEmaildeEnvio1: TMenuItem
      Caption = 'Configuar Email de Envio'
      OnClick = ConfiguarEmaildeEnvio1Click
    end
    object ConfigurarTextodoEmail1: TMenuItem
      Caption = 'Configurar Texto do Email'
      OnClick = ConfigurarTextodoEmail1Click
    end
  end
  object DSAVencer: TDataSource
    DataSet = QryAVencer
    Left = 112
    Top = 304
  end
  object QryAVencer: TFDQuery
    OnCalcFields = QryAVencerCalcFields
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT CASE WHEN ENVIADOAVENCER=1 THEN '#39'ENVIADO'#39
      #9' WHEN ISNULL(STATUS,0) = 2 THEN '#39'IGNORADO'#39
      #9' ELSE '#39'N'#195'O ENVIADO'#39' END AS SATUSAVENCER,'
      
        '*, DateDiff(Day, getdate(), DataVencimento) as DiasParaVenciment' +
        'o'
      'from vwEmbalagemPendente'
      'where'
      '  DataVencimento between :DataIni and :DataFim'
      '     /*Ignorados*/'
      '     /*Cliente*/'
      
        'ORDER BY DataVencimento, RAZAOSOCIAL, ValTotal desc, QUANTATENDI' +
        'DA desc')
    Left = 32
    Top = 296
    ParamData = <
      item
        Name = 'DATAINI'
        DataType = ftDate
        FDDataType = dtDate
        ParamType = ptInput
        Value = '2020/10/01'
      end
      item
        Name = 'DATAFIM'
        DataType = ftDate
        FDDataType = dtDate
        ParamType = ptInput
        Value = '2020/10/27'
      end>
    object QryAVencerSelecionado: TBooleanField
      DisplayLabel = 'Sel'
      FieldKind = fkCalculated
      FieldName = 'Selecionado'
      Calculated = True
    end
    object QryAVencerchavenfpro: TStringField
      FieldName = 'chavenfpro'
      Origin = 'chavenfpro'
      Required = True
      FixedChar = True
      Size = 21
    end
    object QryAVencerSEQUENCIADOPRODUTO: TIntegerField
      FieldName = 'SEQUENCIADOPRODUTO'
      Origin = 'SEQUENCIADOPRODUTO'
    end
    object QryAVencercodcliente: TStringField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'codcliente'
      Origin = 'codcliente'
      Required = True
      Visible = False
      FixedChar = True
      Size = 6
    end
    object QryAVencerstatus: TIntegerField
      FieldName = 'status'
      Origin = 'status'
    end
    object QryAVencerRAZAOSOCIAL: TStringField
      DisplayLabel = 'Nome Cliente'
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Visible = False
      Size = 80
    end
    object QryAVencerCIDADE: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Visible = False
      FixedChar = True
      Size = 35
    end
    object QryAVencerdatacomprovante: TDateField
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'datacomprovante'
      Origin = 'datacomprovante'
    end
    object QryAVencerDataVencimento: TDateField
      DisplayLabel = 'Data Vcto.'
      FieldName = 'DataVencimento'
      Origin = 'DataVencimento'
    end
    object QryAVencernumero: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'numero'
      Origin = 'numero'
      FixedChar = True
      Size = 6
    end
    object QryAVencerserie: TStringField
      DisplayLabel = 'S'#233'rie'
      FieldName = 'serie'
      Origin = 'serie'
      FixedChar = True
      Size = 4
    end
    object QryAVencercodproduto: TStringField
      DisplayLabel = 'Cod. Produto'
      FieldName = 'codproduto'
      Origin = 'codproduto'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryAVencerapresentacao: TStringField
      DisplayLabel = 'Embalagem'
      FieldName = 'apresentacao'
      Origin = 'apresentacao'
      Size = 80
    end
    object QryAVencerQuantAtendida: TBCDField
      DisplayLabel = 'Qtd. Total'
      FieldName = 'QuantAtendida'
      Origin = 'QuantAtendida'
      Precision = 18
    end
    object QryAVencerCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Origin = 'CHAVENF'
      Required = True
      Visible = False
      FixedChar = True
      Size = 15
    end
    object QryAVencerTOTPAGO: TFMTBCDField
      DisplayLabel = 'Valor Devolvido'
      DisplayWidth = 19
      FieldName = 'TOTPAGO'
      Origin = 'TOTPAGO'
      ReadOnly = True
      currency = True
      Precision = 38
      Size = 2
    end
    object QryAVencerVALTOTAL: TBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'VALTOTAL'
      Origin = 'VALTOTAL'
      currency = True
      Precision = 18
    end
    object QryAVencerEntregaParcial: TStringField
      DisplayLabel = 'Entrega Parcial'
      FieldName = 'EntregaParcial'
      Origin = 'EntregaParcial'
      ReadOnly = True
      Required = True
      Size = 3
    end
    object QryAVencerVALUNIDADE: TFMTBCDField
      FieldName = 'VALUNIDADE'
      Visible = False
      Precision = 38
      Size = 20
    end
    object QryAVencerQuantDevolvida: TFMTBCDField
      DisplayLabel = 'Qtd. Devolvida'
      FieldName = 'QuantDevolvida'
      ReadOnly = True
      Precision = 38
      Size = 6
    end
    object QryAVencerQuantPendente: TFMTBCDField
      DisplayLabel = 'Qtd. Pendente'
      FieldName = 'QuantPendente'
      Origin = 'QuantPendente'
      ReadOnly = True
      Precision = 38
      Size = 6
    end
    object QryAVencerValorPendente: TFMTBCDField
      DisplayLabel = 'Valor Pendente'
      FieldName = 'ValorPendente'
      Origin = 'ValorPendente'
      ReadOnly = True
      currency = True
      Precision = 38
      Size = 6
    end
    object QryAVencerDiasParaVencimento: TIntegerField
      DisplayLabel = 'Dias at'#233' Vcto.'
      FieldName = 'DiasParaVencimento'
      Origin = 'DiasParaVencimento'
      ReadOnly = True
    end
    object QryAVencerENVIADOAVENCER: TBooleanField
      FieldName = 'ENVIADOAVENCER'
      Origin = 'ENVIADOAVENCER'
      Required = True
    end
    object QryAVencerSATUSAVENCER: TStringField
      DisplayLabel = 'Status'
      FieldName = 'SATUSAVENCER'
      Origin = 'SATUSAVENCER'
      ReadOnly = True
      Required = True
      Size = 11
    end
    object QryAVencerDESCSTATUS: TStringField
      FieldName = 'DESCSTATUS'
      Origin = 'DESCSTATUS'
      Required = True
      Size = 11
    end
  end
end
