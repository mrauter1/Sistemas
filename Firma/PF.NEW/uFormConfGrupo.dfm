object FormConfGrupo: TFormConfGrupo
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Lista'
  ClientHeight = 361
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 320
    Width = 589
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitWidth = 495
    object BtnOk: TBitBtn
      Left = 152
      Top = 6
      Width = 145
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 287
    Width = 589
    Height = 33
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 495
    DesignSize = (
      589
      33)
    object EditComprov: TEdit
      Left = 17
      Top = 4
      Width = 390
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      ExplicitWidth = 296
    end
    object BtnAdd: TButton
      Left = 413
      Top = 2
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Adicionar'
      TabOrder = 1
      OnClick = BtnAddClick
      ExplicitLeft = 319
    end
    object BtnDel: TButton
      Left = 500
      Top = 2
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Deletar'
      TabOrder = 2
      OnClick = BtnDelClick
      ExplicitLeft = 406
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 589
    Height = 287
    Align = alClient
    DataSource = DmDados.DS_ConfGrupo
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CodGrupoSub'
        ReadOnly = True
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NomeSubGrupo'
        ReadOnly = True
        Width = 169
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CodPF'
        Width = 97
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Concentracao'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Densidade'
        Width = 78
        Visible = True
      end>
  end
end
