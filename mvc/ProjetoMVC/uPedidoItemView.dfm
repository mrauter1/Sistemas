inherited PedidoItemView: TPedidoItemView
  Caption = 'Itens do Pedido'
  ClientHeight = 389
  ClientWidth = 527
  ExplicitWidth = 533
  ExplicitHeight = 417
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelControles: TPanel
    Width = 527
    ExplicitWidth = 479
    inherited BtnSair: TBitBtn
      Left = 441
      ExplicitLeft = 393
    end
  end
  inherited PanelClient: TPanel
    Width = 527
    Height = 209
    ExplicitWidth = 479
    object Label1: TLabel [0]
      Left = 17
      Top = 12
      Width = 49
      Height = 13
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnPesquisa: TSpeedButton [1]
      Left = 125
      Top = 8
      Width = 23
      Height = 22
      Hint = 'Busca Pedidos'
      Flat = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        77777777777777777777000000000007777700333333333077770B0333333333
        07770FB03333333330770BFB0333333333070FBFB000000000000BFBFBFBFB07
        77770FBFBFBFBF0777770BFB0000000777777000777777770007777777777777
        7007777777770777070777777777700077777777777777777777}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnPesquisaClick
    end
    object DBText1: TDBText [2]
      Left = 154
      Top = 12
      Width = 279
      Height = 17
      DataField = 'NOMEPRODUTO'
      DataSource = PedidoItemControle.DataSource
    end
    inherited PanelDados: TPanel
      Width = 525
      Height = 169
      TabOrder = 1
      ExplicitWidth = 477
      object Label2: TLabel [0]
        Left = 34
        Top = 16
        Width = 66
        Height = 13
        Alignment = taRightJustify
        Caption = 'Quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel [1]
        Left = 234
        Top = 16
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = 'Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel [2]
        Left = 35
        Top = 80
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = 'Total'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited PanelBotoes: TPanel
        Left = 419
        Width = 106
        Height = 165
        TabOrder = 3
        ExplicitLeft = 371
        ExplicitWidth = 106
        inherited BtnIncluir: TButton
          Left = 11
          Top = 58
          ExplicitLeft = 11
          ExplicitTop = 17
        end
        inherited BtnAlterar: TButton
          Left = 11
          Top = 83
          ExplicitLeft = 11
          ExplicitTop = 42
        end
        inherited BtnExcluir: TButton
          Left = 11
          Top = 108
          ExplicitLeft = 11
          ExplicitTop = 67
        end
        inherited BtnCancela: TButton
          Left = 11
          Top = 133
          ExplicitLeft = 11
          ExplicitTop = 92
        end
      end
      object DBEdit3: TDBEdit
        Left = 34
        Top = 35
        Width = 113
        Height = 21
        DataField = 'QUANTIDADE'
        DataSource = PedidoItemControle.DataSource
        TabOrder = 0
      end
      object DBEdit1: TDBEdit
        Left = 234
        Top = 35
        Width = 103
        Height = 21
        DataField = 'VALOR'
        DataSource = PedidoItemControle.DataSource
        TabOrder = 1
      end
      object DBEdit2: TDBEdit
        Left = 34
        Top = 99
        Width = 113
        Height = 21
        TabStop = False
        Color = cl3DLight
        DataField = 'TOTAL'
        DataSource = PedidoItemControle.DataSource
        ReadOnly = True
        TabOrder = 2
      end
    end
    object EditCod: TEdit
      Left = 68
      Top = 9
      Width = 57
      Height = 21
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 6
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
  end
  inherited Grid: TDBGrid
    Top = 250
    Width = 527
    DataSource = PedidoItemControle.DataSource
    TabOrder = 3
    Columns = <
      item
        Expanded = False
        FieldName = 'CODPEDIDOITEM'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CODPRODUTO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODPEDIDO'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'NOMEPRODUTO'
        Width = 206
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QUANTIDADE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTAL'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Width = 77
        Visible = True
      end>
  end
  inherited StatusBar: TStatusBar
    Top = 370
    Width = 527
    ExplicitTop = 209
    ExplicitWidth = 479
  end
  inherited View: TCadView
    iIndiceEdit = EditCod
    CampoIndice = 'CODPRODUTO'
    ConfirmaAdicao = False
    CarregaRegistro = False
  end
end
