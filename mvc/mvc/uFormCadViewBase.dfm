inherited FormCadViewBase: TFormCadViewBase
  Caption = 'FormCadViewBase'
  ClientHeight = 207
  ClientWidth = 494
  ExplicitWidth = 510
  ExplicitHeight = 245
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel [0]
    Left = 0
    Top = 0
    Width = 494
    Height = 57
    Align = alTop
    TabOrder = 0
    object BtnAdd: TButton
      Left = 16
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Adicionar'
      Enabled = False
      TabOrder = 0
    end
    object BtnEdit: TButton
      Left = 105
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Editar'
      Enabled = False
      TabOrder = 1
    end
    object BtnCancel: TButton
      Left = 311
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      Enabled = False
      TabOrder = 2
    end
    object BtnPost: TButton
      Left = 400
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      Enabled = False
      TabOrder = 3
    end
    object BtnDel: TButton
      Left = 194
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Deletar'
      Enabled = False
      TabOrder = 4
    end
  end
  inherited View: TCadView
    BtnAdd = BtnAdd
    BtnEdit = BtnEdit
    BtnCancel = BtnCancel
    BtnConfirm = BtnPost
    BtnDel = BtnDel
    Left = 272
    Top = 8
  end
end
