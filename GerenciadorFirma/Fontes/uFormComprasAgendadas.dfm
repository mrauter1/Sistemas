object FormComprasAgendadas: TFormComprasAgendadas
  Left = 0
  Top = 0
  Caption = 'Compras Agendadas'
  ClientHeight = 317
  ClientWidth = 822
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 822
    Height = 49
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 651
    DesignSize = (
      822
      49)
    object CbxMostrarRecebidos: TCheckBox
      Left = 40
      Top = 13
      Width = 153
      Height = 17
      Caption = 'Mostrar j'#225' recebidos'
      TabOrder = 0
      OnClick = CbxMostrarRecebidosClick
    end
    object btnOK: TBitBtn
      Left = 670
      Top = 9
      Width = 150
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Adicionar Agendamento'
      Default = True
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
      ExplicitLeft = 499
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 822
    Height = 268
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 136
    ExplicitTop = 136
    ExplicitWidth = 185
    ExplicitHeight = 41
    object cxGridCompras: TcxGrid
      Left = 1
      Top = 1
      Width = 820
      Height = 266
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 558
      ExplicitHeight = 227
      object ViewCompras: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.First.Visible = False
        Navigator.Buttons.PriorPage.Visible = False
        Navigator.Buttons.Prior.Visible = False
        Navigator.Buttons.Next.Visible = False
        Navigator.Buttons.NextPage.Visible = False
        Navigator.Buttons.Last.Visible = False
        Navigator.Buttons.Insert.Visible = False
        Navigator.Buttons.Append.Visible = True
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Refresh.Visible = False
        Navigator.Buttons.SaveBookmark.Visible = False
        Navigator.Buttons.GotoBookmark.Visible = False
        Navigator.Buttons.Filter.Enabled = False
        Navigator.Buttons.Filter.Visible = False
        Navigator.Visible = True
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Appending = True
        OptionsData.CancelOnExit = False
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        object ViewComprasRecebido: TcxGridDBColumn
          DataBinding.FieldName = 'Recebido'
          Width = 57
        end
        object ViewComprasData: TcxGridDBColumn
          DataBinding.FieldName = 'Data'
          Width = 68
        end
        object ViewComprasCodGrupoSub: TcxGridDBColumn
          DataBinding.FieldName = 'CodGrupoSub'
          Visible = False
        end
        object ViewComprasQuant: TcxGridDBColumn
          DataBinding.FieldName = 'Quant'
          Width = 142
        end
        object ViewComprasPreco: TcxGridDBColumn
          DataBinding.FieldName = 'Preco'
        end
      end
      object cxGridLevel2: TcxGridLevel
        GridView = ViewCompras
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 820
      Height = 266
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 649
      object cxGrid1: TcxGrid
        Left = 1
        Top = 1
        Width = 818
        Height = 264
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 5
        object cxGridDBTableView1: TcxGridDBTableView
          PopupMenu = PopupMenu1
          OnDblClick = AlterarCompra1Click
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = False
          Navigator.Buttons.PriorPage.Visible = False
          Navigator.Buttons.Prior.Visible = False
          Navigator.Buttons.Next.Visible = False
          Navigator.Buttons.NextPage.Visible = False
          Navigator.Buttons.Last.Visible = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Visible = True
          Navigator.Buttons.Post.Visible = True
          Navigator.Buttons.Refresh.Visible = False
          Navigator.Buttons.SaveBookmark.Visible = False
          Navigator.Buttons.GotoBookmark.Visible = False
          Navigator.Buttons.Filter.Enabled = False
          Navigator.Buttons.Filter.Visible = False
          DataController.DataSource = DsComprasPrevistas
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          object cxGridDBTableView1Recebido: TcxGridDBColumn
            DataBinding.FieldName = 'Recebido'
            Width = 63
          end
          object cxGridDBTableView1CodGrupoSub: TcxGridDBColumn
            Caption = 'Grupo de Produto'
            DataBinding.FieldName = 'CodGrupoSub'
            Options.Editing = False
            Width = 130
          end
          object cxGridDBTableView1DataRecebimento: TcxGridDBColumn
            DataBinding.FieldName = 'DataRecebimento'
            Options.Editing = False
            Width = 68
          end
          object cxGridDBTableView1DataCompra: TcxGridDBColumn
            DataBinding.FieldName = 'DataCompra'
            Options.Editing = False
          end
          object cxGridDBTableView1Quant: TcxGridDBColumn
            DataBinding.FieldName = 'Quant'
            Options.Editing = False
            Width = 74
          end
          object cxGridDBTableView1Preco: TcxGridDBColumn
            DataBinding.FieldName = 'Preco'
            Options.Editing = False
            Width = 67
          end
          object cxGridDBTableView1Obs: TcxGridDBColumn
            DataBinding.FieldName = 'Obs'
            Options.Editing = False
            Width = 265
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
    end
  end
  object DsComprasPrevistas: TDataSource
    DataSet = QryComprasPrevistas
    Left = 224
    Top = 96
  end
  object QryComprasPrevistas: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT cp.* '
      'FROM log.ComprasPrevistas cp'
      'where'
      '1=1'
      '/*Recebidos*/'
      'order by DataRecebimento')
    Left = 338
    Top = 96
    object QryComprasPrevistasCodGrupoSub: TStringField
      FieldName = 'CodGrupoSub'
      Origin = 'CodGrupoSub'
      Required = True
      Visible = False
      FixedChar = True
      Size = 7
    end
    object QryComprasPrevistasQuant: TBCDField
      FieldName = 'Quant'
      Origin = 'Quant'
      Precision = 18
    end
    object QryComprasPrevistasPreco: TBCDField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'Preco'
      Origin = 'Preco'
      currency = True
      Precision = 14
    end
    object QryComprasPrevistasRecebido: TBooleanField
      FieldName = 'Recebido'
      Origin = 'Recebido'
    end
    object QryComprasPrevistasID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryComprasPrevistasDataCompra: TDateField
      DisplayLabel = 'Data Compra'
      FieldName = 'DataCompra'
      Origin = 'DataCompra'
      Required = True
    end
    object QryComprasPrevistasDataRecebimento: TDateField
      DisplayLabel = 'Data Recebimento'
      FieldName = 'DataRecebimento'
      Origin = 'DataRecebimento'
      Required = True
    end
    object QryComprasPrevistasObs: TMemoField
      DisplayLabel = 'Observa'#231#227'o'
      FieldName = 'Obs'
      Origin = 'Obs'
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 481
    Top = 114
    object AlterarCompra1: TMenuItem
      Caption = 'Alterar Compras do Grupo'
      OnClick = AlterarCompra1Click
    end
  end
end
