object FormConfGrupo: TFormConfGrupo
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Lista'
  ClientHeight = 328
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 287
    Width = 460
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 193
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
    Top = 254
    Width = 460
    Height = 33
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 160
    DesignSize = (
      460
      33)
    object EditComprov: TEdit
      Left = 17
      Top = 4
      Width = 261
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object BtnAdd: TButton
      Left = 284
      Top = 2
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Adicionar'
      TabOrder = 1
      OnClick = BtnAddClick
    end
    object BtnDel: TButton
      Left = 371
      Top = 2
      Width = 81
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Deletar'
      TabOrder = 2
      OnClick = BtnDelClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 460
    Height = 254
    Align = alClient
    DataSource = Dtm_PF.DS_ConfGrupo
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
        Width = 92
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NomeSubGrupo'
        ReadOnly = True
        Width = 213
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Concentracao'
        Width = 80
        Visible = True
      end>
  end
end
