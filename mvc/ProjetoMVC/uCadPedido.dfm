inherited CadPedido: TCadPedido
  Left = 286
  Top = 213
  Caption = 'CadPedido'
  ClientHeight = 265
  ExplicitHeight = 303
  PixelsPerInch = 96
  TextHeight = 13
  object panel2: TPanel [1]
    Left = 0
    Top = 57
    Width = 494
    Height = 208
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 173
    object Label1: TLabel
      Left = 46
      Top = 64
      Width = 27
      Height = 13
      Caption = 'Nome'
      FocusControl = DBEditNome
    end
    object Label2: TLabel
      Left = 46
      Top = 104
      Width = 33
      Height = 13
      Caption = 'Cliente'
      FocusControl = DBEditCliente
    end
    object Label3: TLabel
      Left = 46
      Top = 16
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object DBText1: TDBText
      Left = 186
      Top = 122
      Width = 289
      Height = 17
      DataField = 'NOME'
      DataSource = PedidoCtrl.DataSourceCliente
    end
    object AbreClienteBtn: TSpeedButton
      Left = 160
      Top = 120
      Width = 23
      Height = 21
      Glyph.Data = {
        E6000000424DE60000000000000076000000280000000E0000000E0000000100
        0400000000007000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33003333333333333300300000000333330000B7B7B7B03333000B0B7B7B7B03
        33000BB0B7B7B7B033000FBB0000000033000BFB0B0B0B0333000FBFBFBFB003
        33000BFBFBF00033330030BFBF03333333003800008333333300333333333333
        33003333333333333300}
      OnClick = AbreClienteBtnClick
    end
    object BtnConsulta: TSpeedButton
      Left = 160
      Top = 35
      Width = 23
      Height = 21
      Glyph.Data = {
        E6000000424DE60000000000000076000000280000000E0000000E0000000100
        0400000000007000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33003333333333333300300000000333330000B7B7B7B03333000B0B7B7B7B03
        33000BB0B7B7B7B033000FBB0000000033000BFB0B0B0B0333000FBFBFBFB003
        33000BFBFBF00033330030BFBF03333333003800008333333300333333333333
        33003333333333333300}
    end
    object DBEditNome: TDBEdit
      Left = 46
      Top = 80
      Width = 394
      Height = 21
      DataField = 'NOME'
      DataSource = PedidoCtrl.DataSource
      TabOrder = 1
    end
    object DBEditCliente: TDBEdit
      Left = 46
      Top = 120
      Width = 115
      Height = 21
      DataField = 'CODCLIENTE'
      DataSource = PedidoCtrl.DataSource
      TabOrder = 2
    end
    object EditCod: TEdit
      Left = 46
      Top = 35
      Width = 115
      Height = 21
      TabOrder = 0
    end
  end
  inherited View: TCadView
    BeforeMudaEstado = ViewBeforeMudaEstado
    BtnConsulta = BtnConsulta
    iIndiceEdit = EditCod
    CampoIndice = 'COD'
    Left = 264
    Top = 24
  end
end
