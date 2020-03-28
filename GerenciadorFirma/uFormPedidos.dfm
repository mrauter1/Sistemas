object FormPedidos: TFormPedidos
  Left = 0
  Top = 0
  Caption = 'Pedidos'
  ClientHeight = 408
  ClientWidth = 1037
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 0
    Width = 1037
    Height = 377
    Align = alClient
    TabOrder = 0
    object cxGridDBTableView: TcxGridDBTableView
      PopupMenu = PopupMenu1
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = cxGridDBTableViewCODPEDIDO
        end
        item
          Kind = skSum
          Column = cxGridDBTableViewQUANTIDADE
        end
        item
          Kind = skSum
          Column = cxGridDBTableViewQUANTPENDENTE
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellAutoHeight = True
      OptionsView.HeaderAutoHeight = True
      Styles.OnGetContentStyle = cxGridDBTableViewStylesGetContentStyle
      Styles.StyleSheet = FormGlobal.cxGridTableViewStyleSheet1
      object cxGridDBTableViewCODPEDIDO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPEDIDO'
        Width = 52
      end
      object cxGridDBTableViewDIASPARAENTREGA: TcxGridDBColumn
        Caption = 'Dia entrega'
        DataBinding.FieldName = 'DIASPARAENTREGA'
        Visible = False
        OnGetDataText = cxGridDBTableViewDIASPARAENTREGAGetDataText
        GroupIndex = 1
        Width = 51
      end
      object cxGridDBTableViewSITUACAO: TcxGridDBColumn
        DataBinding.FieldName = 'SITUACAO'
        OnGetDisplayText = cxGridDBTableViewSITUACAOGetDisplayText
        Width = 53
      end
      object cxGridDBTableViewNOMETRANSPORTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMETRANSPORTE'
        Visible = False
        GroupIndex = 0
        Width = 182
      end
      object cxGridDBTableViewCODCLIENTE: TcxGridDBColumn
        DataBinding.FieldName = 'CODCLIENTE'
        Width = 47
      end
      object cxGridDBTableViewNOMECLIENTE: TcxGridDBColumn
        DataBinding.FieldName = 'NOMECLIENTE'
        Width = 122
      end
      object cxGridDBTableViewCODPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'CODPRODUTO'
        Width = 51
      end
      object cxGridDBTableViewNOMEPRODUTO: TcxGridDBColumn
        DataBinding.FieldName = 'NOMEPRODUTO'
        Width = 175
      end
      object cxGridDBTableViewQUANTIDADE: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTIDADE'
        Width = 56
      end
      object cxGridDBTableViewQUANTPENDENTE: TcxGridDBColumn
        DataBinding.FieldName = 'QUANTPENDENTE'
        Width = 59
      end
      object cxGridDBTableViewESTOQUEATUAL: TcxGridDBColumn
        DataBinding.FieldName = 'ESTOQUEATUAL'
        Width = 63
      end
      object cxGridDBTableViewEMFALTA: TcxGridDBColumn
        DataBinding.FieldName = 'EMFALTA'
        Width = 39
      end
      object cxGridDBTableViewFALTAHOJE: TcxGridDBColumn
        DataBinding.FieldName = 'FALTAHOJE'
        Width = 71
      end
      object cxGridDBTableViewFALTAAMANHA: TcxGridDBColumn
        DataBinding.FieldName = 'FALTAAMANHA'
        Width = 76
      end
      object cxGridDBTableViewDataEntrega: TcxGridDBColumn
        DataBinding.FieldName = 'DataEntrega'
        Width = 75
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 377
    Width = 1037
    Height = 31
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 1
    DesignSize = (
      1037
      31)
    object BtnAtualiza: TButton
      Left = 492
      Top = 6
      Width = 88
      Height = 25
      Anchors = [akBottom]
      Caption = 'Atualiza'
      TabOrder = 0
      OnClick = BtnAtualizaClick
    end
    object BtnOpcoes: TBitBtn
      Left = 5
      Top = 1
      Width = 26
      Height = 27
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BtnOpcoesClick
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = Pedidos.QryPedidos
    Left = 304
    Top = 128
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 472
    Top = 80
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
  object PopupMenu1: TPopupMenu
    Left = 680
    Top = 192
    object AbrirConfigPro: TMenuItem
      Caption = 'Configura'#231#227'o do Produto'
      OnClick = AbrirConfigProClick
    end
    object AbrirDetalhePro: TMenuItem
      Caption = 'Detalhamento do Produto'
      OnClick = AbrirDetalheProClick
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
  object Timer1: TTimer
    Interval = 120000
    OnTimer = Timer1Timer
    Left = 130
    Top = 112
  end
end
