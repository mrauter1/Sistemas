inherited DadosViewBase: TDadosViewBase
  Left = 268
  Top = 266
  Caption = 'DadosViewBase'
  ClientHeight = 222
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitHeight = 260
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 483
    Height = 57
    Align = alTop
    TabOrder = 0
    object BtnAdd: TButton
      Left = 16
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 0
      OnClick = BtnAddClick
    end
    object BtnEdit: TButton
      Left = 105
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Editar'
      TabOrder = 1
      OnClick = BtnEditClick
    end
    object BtnCancel: TButton
      Left = 311
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = BtnCancelClick
    end
    object BtnPost: TButton
      Left = 400
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 3
      OnClick = BtnPostClick
    end
    object BtnDel: TButton
      Left = 194
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Deletar'
      TabOrder = 4
      OnClick = BtnDelClick
    end
  end
end
