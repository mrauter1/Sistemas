inherited PedidoView: TPedidoView
  ClientHeight = 271
  ClientWidth = 524
  ExplicitWidth = 530
  ExplicitHeight = 299
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelControles: TPanel
    Width = 524
    ExplicitWidth = 524
    inherited BtnSair: TBitBtn
      Left = 428
      ExplicitLeft = 428
    end
  end
  inherited PanelClient: TPanel
    Width = 524
    Height = 211
    ExplicitWidth = 524
    ExplicitHeight = 211
    object Label2: TLabel [2]
      Left = 190
      Top = 12
      Width = 31
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nome:'
      FocusControl = DBDescricao
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    inherited PageControl: TPageControl
      Top = 37
      Width = 522
      Height = 173
      ExplicitTop = 37
      ExplicitWidth = 522
      ExplicitHeight = 173
      inherited TabDados: TTabSheet
        ExplicitWidth = 514
        ExplicitHeight = 163
        object Label3: TLabel [0]
          Left = 31
          Top = 8
          Width = 48
          Height = 13
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel [1]
          Left = 31
          Top = 54
          Width = 57
          Height = 13
          Alignment = taRightJustify
          Caption = 'Cod. Cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DBText1: TDBText [2]
          Left = 117
          Top = 74
          Width = 312
          Height = 17
          DataField = 'NOMECLIENTE'
          DataSource = PedidoCtrl.DataSource
        end
        object SpeedButton1: TSpeedButton [3]
          Left = 89
          Top = 73
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
          OnClick = SpeedButton1Click
        end
        inherited BtnIncluir: TButton
          Left = 169
          Top = 132
          ExplicitLeft = 169
          ExplicitTop = 132
        end
        inherited BtnAlterar: TButton
          Left = 250
          Top = 132
          ExplicitLeft = 250
          ExplicitTop = 132
        end
        inherited BtnExcluir: TButton
          Left = 331
          Top = 132
          ExplicitLeft = 331
          ExplicitTop = 132
        end
        inherited BtnCancela: TButton
          Left = 423
          Top = 132
          ExplicitLeft = 423
          ExplicitTop = 132
        end
        object DBEdit3: TDBEdit
          Left = 31
          Top = 27
          Width = 282
          Height = 21
          DataField = 'NOME'
          DataSource = PedidoCtrl.DataSource
          TabOrder = 4
        end
        object DBEdit1: TDBEdit
          Left = 31
          Top = 73
          Width = 59
          Height = 21
          DataField = 'CODCLIENTE'
          DataSource = PedidoCtrl.DataSource
          TabOrder = 5
        end
        object BtnProdutos: TButton
          Left = 8
          Top = 132
          Width = 76
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Produtos'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnClick = BtnProdutosClick
        end
      end
    end
    object DBDescricao: TDBEdit
      Left = 227
      Top = 9
      Width = 278
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Ctl3D = True
      DataField = 'Nome'
      DataSource = PedidoCtrl.DataSource
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited StatusBar: TStatusBar
    Top = 252
    Width = 524
    ExplicitTop = 252
    ExplicitWidth = 524
  end
  inherited View: TCadView
    OnInsere = ViewInsere
  end
end
