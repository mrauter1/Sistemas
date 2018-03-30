inherited ProdutoView: TProdutoView
  Caption = 'ProdutoView'
  ClientHeight = 261
  ExplicitHeight = 289
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelClient: TPanel
    Height = 201
    ExplicitHeight = 201
    inherited PageControl: TPageControl
      Top = 37
      Height = 163
      ActivePage = TabSheet2
      ExplicitTop = 37
      ExplicitHeight = 163
      inherited TabDados: TTabSheet
        Caption = 'Dados'
        TabVisible = True
        ExplicitTop = 24
        object Label4: TLabel [0]
          Left = 46
          Top = 6
          Width = 27
          Height = 13
          Caption = 'Nome'
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
          Top = 51
          Width = 24
          Height = 13
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object DBEdit2: TDBEdit
          Left = 46
          Top = 25
          Width = 376
          Height = 21
          DataField = 'NOME'
          DataSource = ProdutoControle.DataSource
          TabOrder = 4
        end
        object DBEdit3: TDBEdit
          Left = 46
          Top = 70
          Width = 91
          Height = 21
          DataField = 'VALOR'
          DataSource = ProdutoControle.DataSource
          TabOrder = 5
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Movimentos do produto'
        ImageIndex = 1
        object DBGrid1: TDBGrid
          Left = 0
          Top = 0
          Width = 534
          Height = 135
          Align = alClient
          DataSource = ProdutoControle.DataSourcePedidoItem
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'CODPEDIDOITEM'
              Width = 45
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CODPRODUTO'
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'CODPEDIDO'
              Width = 51
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOMEPRODUTO'
              Width = 190
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QUANTIDADE'
              Width = 72
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
              Width = 65
              Visible = True
            end>
        end
      end
    end
  end
  inherited StatusBar: TStatusBar
    Top = 242
    ExplicitTop = 242
  end
end
