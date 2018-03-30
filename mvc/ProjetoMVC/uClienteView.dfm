inherited ClienteView: TClienteView
  Caption = 'ClienteView'
  ClientHeight = 242
  ExplicitHeight = 270
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelClient: TPanel
    Height = 182
    ExplicitHeight = 182
    inherited PageControl1: TPageControl
      Top = 36
      ExplicitTop = 36
      inherited TabSheet1: TTabSheet
        ExplicitLeft = 8
        ExplicitTop = 5
        object Label4: TLabel [0]
          Left = 46
          Top = 9
          Width = 46
          Height = 13
          Caption = 'Descri'#231#227'o'
          FocusControl = DBEdit2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel [1]
          Left = 46
          Top = 55
          Width = 33
          Height = 13
          Caption = 'Cidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        inherited BtnIncluir: TButton
          Top = 107
          ExplicitTop = 107
        end
        inherited BtnAlterar: TButton
          Top = 107
          ExplicitTop = 107
        end
        inherited BtnExcluir: TButton
          Top = 107
          ExplicitTop = 107
        end
        inherited BtnCancela: TButton
          Top = 107
          ExplicitTop = 107
        end
        object DBEdit2: TDBEdit
          Left = 46
          Top = 28
          Width = 376
          Height = 21
          DataField = 'NOME'
          DataSource = ClienteControle.DataSource
          TabOrder = 4
        end
        object DBEdit3: TDBEdit
          Left = 46
          Top = 74
          Width = 376
          Height = 21
          DataField = 'CIDADE'
          DataSource = ClienteControle.DataSource
          TabOrder = 5
        end
      end
    end
  end
  inherited StatusBar: TStatusBar
    Top = 223
    ExplicitTop = 223
  end
end
