object FormRelatoriosPersonalizados: TFormRelatoriosPersonalizados
  Left = 0
  Top = 110
  Caption = 'Relat'#243'rios Personalizados'
  ClientHeight = 584
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    640
    584)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 191
    Top = 10
    Width = 66
    Height = 13
    Alignment = taRightJustify
    Caption = 'Nome Interno'
  end
  object Label2: TLabel
    Left = 70
    Top = 10
    Width = 11
    Height = 13
    Alignment = taRightJustify
    Caption = 'ID'
  end
  object PanelConsulta: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 584
    Align = alClient
    TabOrder = 0
    object PanelInfo: TPanel
      Left = 1
      Top = 1
      Width = 638
      Height = 539
      Align = alClient
      TabOrder = 0
      object PageControl: TPageControl
        Left = 1
        Top = 41
        Width = 636
        Height = 497
        ActivePage = TabParametros
        Align = alClient
        MultiLine = True
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnChange = PageControlChange
        object TabCadastro: TTabSheet
          Caption = 'Cadastro'
          DesignSize = (
            628
            469)
          object LblDescricao: TLabel
            Left = 21
            Top = 6
            Width = 26
            Height = 13
            Alignment = taRightJustify
            Caption = 'T'#237'tulo'
          end
          object Label3: TLabel
            Left = 1
            Top = 45
            Width = 46
            Height = 13
            Alignment = taRightJustify
            Caption = 'Descri'#231#227'o'
          end
          object EdtDescricao: TDBEdit
            Left = 54
            Top = 3
            Width = 541
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            DataField = 'Descricao'
            DataSource = DsConsultas
            TabOrder = 0
          end
          object DBMemo1: TDBMemo
            Left = 54
            Top = 45
            Width = 541
            Height = 61
            Anchors = [akLeft, akTop, akRight]
            DataField = 'InfoExtendida'
            DataSource = DsConsultas
            TabOrder = 1
          end
          object DBRadioGroup1: TDBRadioGroup
            Left = 54
            Top = 112
            Width = 541
            Height = 41
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Tipo'
            Columns = 3
            DataField = 'Tipo'
            DataSource = DmGeradorConsultas.DsConsultas
            Items.Strings = (
              'Relat'#243'rio'
              'Evolutivo'
              'Parametriza'#231#227'o')
            TabOrder = 2
            Values.Strings = (
              '0'
              '1'
              '2')
          end
          object Panel1: TPanel
            Left = 0
            Top = 169
            Width = 628
            Height = 300
            Align = alBottom
            Caption = 'Panel1'
            TabOrder = 3
            DesignSize = (
              628
              300)
            object Label4: TLabel
              Left = 15
              Top = 0
              Width = 14
              Height = 13
              Caption = 'Sql'
            end
            object DBMemoSql: TDBMemo
              Left = 15
              Top = 17
              Width = 595
              Height = 271
              Anchors = [akLeft, akTop, akRight, akBottom]
              DataField = 'Sql'
              DataSource = DsConsultas
              TabOrder = 0
            end
          end
        end
        object TabParametros: TTabSheet
          Caption = 'Par'#226'metros'
          ImageIndex = 1
          object cxGridParams: TcxGrid
            Left = 0
            Top = 0
            Width = 628
            Height = 469
            Align = alClient
            TabOrder = 0
            object cxGridParamsDBTableView1: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              Navigator.Buttons.First.Visible = False
              Navigator.Buttons.PriorPage.Visible = False
              Navigator.Buttons.Prior.Visible = False
              Navigator.Buttons.Next.Visible = False
              Navigator.Buttons.NextPage.Visible = False
              Navigator.Buttons.Last.Visible = False
              Navigator.Buttons.Insert.Visible = False
              Navigator.Buttons.Append.Visible = True
              Navigator.Buttons.Post.Visible = False
              Navigator.Buttons.Refresh.Visible = False
              Navigator.Buttons.SaveBookmark.Visible = False
              Navigator.Buttons.GotoBookmark.Visible = False
              Navigator.Buttons.Filter.Visible = False
              Navigator.Visible = True
              FilterBox.Visible = fvNever
              DataController.DataSource = DsPara
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.Appending = True
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
              object cxGridParamsDBTableView1Nome: TcxGridDBColumn
                DataBinding.FieldName = 'Nome'
                Width = 97
              end
              object cxGridParamsDBTableView1Descricao: TcxGridDBColumn
                DataBinding.FieldName = 'Descricao'
                Width = 166
              end
              object cxGridParamsDBTableView1Tipo: TcxGridDBColumn
                DataBinding.FieldName = 'Tipo'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'ComboBox'
                    ImageIndex = 0
                    Value = 1
                  end
                  item
                    Description = 'Texto'
                    Value = 2
                  end
                  item
                    Description = 'Data'
                    Value = 3
                  end
                  item
                    Description = 'CheckListBox'
                    Value = 4
                  end>
              end
              object cxGridParamsDBTableView1Sql: TcxGridDBColumn
                DataBinding.FieldName = 'Sql'
                Width = 77
              end
              object cxGridParamsDBTableView1Ordem: TcxGridDBColumn
                DataBinding.FieldName = 'Ordem'
              end
              object cxGridParamsDBTableView1Tamanho: TcxGridDBColumn
                DataBinding.FieldName = 'Tamanho'
              end
              object cxGridParamsDBTableView1Obrigatorio: TcxGridDBColumn
                DataBinding.FieldName = 'Obrigatorio'
              end
              object cxGridParamsDBTableView1ValorPadrao: TcxGridDBColumn
                DataBinding.FieldName = 'ValorPadrao'
              end
            end
            object cxGridParamsLevel1: TcxGridLevel
              GridView = cxGridParamsDBTableView1
            end
          end
        end
        object TabCampos: TTabSheet
          Caption = 'Campos'
          ImageIndex = 2
          object cxGridCampos: TcxGrid
            Left = 0
            Top = 0
            Width = 628
            Height = 225
            Align = alTop
            TabOrder = 0
            object cxGridDBTableView1: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              Navigator.Buttons.First.Visible = False
              Navigator.Buttons.PriorPage.Visible = False
              Navigator.Buttons.Prior.Visible = False
              Navigator.Buttons.Next.Visible = False
              Navigator.Buttons.NextPage.Visible = False
              Navigator.Buttons.Last.Visible = False
              Navigator.Buttons.Insert.Visible = False
              Navigator.Buttons.Append.Visible = True
              Navigator.Buttons.Post.Visible = False
              Navigator.Buttons.Refresh.Visible = False
              Navigator.Buttons.SaveBookmark.Visible = False
              Navigator.Buttons.GotoBookmark.Visible = False
              Navigator.Buttons.Filter.Visible = False
              Navigator.Visible = True
              FilterBox.Visible = fvNever
              DataController.DataSource = DsCampos
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
              object cxGridDBTableView1NomeCampo: TcxGridDBColumn
                DataBinding.FieldName = 'NomeCampo'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.ReadOnly = True
                Width = 94
              end
              object cxGridDBTableView1Descricao: TcxGridDBColumn
                DataBinding.FieldName = 'Descricao'
                Width = 173
              end
              object cxGridDBTableView1TamanhoCampo: TcxGridDBColumn
                DataBinding.FieldName = 'TamanhoCampo'
              end
              object cxGridDBTableView1Visivel: TcxGridDBColumn
                DataBinding.FieldName = 'Visivel'
                Width = 39
              end
              object cxGridDBTableView1Monetario: TcxGridDBColumn
                DataBinding.FieldName = 'Monetario'
                Width = 60
              end
              object cxGridDBTableView1Agrupamento: TcxGridDBColumn
                DataBinding.FieldName = 'Agrupamento'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'Soma'
                    ImageIndex = 0
                    Value = 0
                  end
                  item
                    Description = 'M'#233'dia'
                    Value = 1
                  end
                  item
                    Description = 'Contagem'
                    Value = 2
                  end
                  item
                    Description = 'Max'
                    Value = 3
                  end
                  item
                    Description = 'Min'
                    Value = 4
                  end
                  item
                    Description = 'Desvio Padr'#227'o'
                    Value = 5
                  end>
                Width = 79
              end
              object cxGridDBTableView1Cor: TcxGridDBColumn
                DataBinding.FieldName = 'Cor'
                PropertiesClassName = 'TcxColorComboBoxProperties'
                Properties.CustomColors = <>
              end
            end
            object cxGridLevel1: TcxGridLevel
              GridView = cxGridDBTableView1
            end
          end
          object cxGridConsulta: TcxGrid
            Left = 0
            Top = 225
            Width = 628
            Height = 244
            Align = alClient
            TabOrder = 1
            object cxGridConsultaView: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              Navigator.Buttons.First.Visible = False
              Navigator.Buttons.PriorPage.Visible = False
              Navigator.Buttons.Prior.Visible = False
              Navigator.Buttons.Next.Visible = False
              Navigator.Buttons.NextPage.Visible = False
              Navigator.Buttons.Last.Visible = False
              Navigator.Buttons.Insert.Visible = False
              Navigator.Buttons.Append.Visible = True
              Navigator.Buttons.Post.Visible = False
              Navigator.Buttons.Refresh.Visible = False
              Navigator.Buttons.SaveBookmark.Visible = False
              Navigator.Buttons.GotoBookmark.Visible = False
              Navigator.Buttons.Filter.Visible = False
              Navigator.Visible = True
              FilterBox.Visible = fvNever
              DataController.DataSource = DsExec
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
            end
            object cxGridLevel2: TcxGridLevel
              GridView = cxGridConsultaView
            end
          end
        end
      end
      object Panel2: TPanel
        Left = 1
        Top = 1
        Width = 636
        Height = 40
        Align = alTop
        TabOrder = 1
      end
    end
    object PanelControles: TPanel
      Left = 1
      Top = 540
      Width = 638
      Height = 43
      Align = alBottom
      TabOrder = 1
      object BtnSalvar: TButton
        Left = 20
        Top = 6
        Width = 98
        Height = 25
        Caption = 'Salvar'
        TabOrder = 0
        OnClick = BtnSalvarClick
      end
      object BtnCancelar: TButton
        Left = 158
        Top = 6
        Width = 98
        Height = 25
        Caption = 'Cancelar'
        TabOrder = 1
        OnClick = BtnCancelarClick
      end
    end
  end
  object BtnDefineCampos: TButton
    Left = 450
    Top = 546
    Width = 98
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Definir Campos'
    TabOrder = 1
  end
  object EdtID: TDBEdit
    Left = 87
    Top = 7
    Width = 66
    Height = 21
    Color = cl3DLight
    DataField = 'ID'
    DataSource = DsConsultas
    ReadOnly = True
    TabOrder = 2
  end
  object EditNome: TDBEdit
    Left = 263
    Top = 7
    Width = 153
    Height = 21
    DataField = 'Nome'
    DataSource = DsConsultas
    TabOrder = 3
  end
  object DsConsultas: TDataSource
    DataSet = DmGeradorConsultas.QryConsultas
    Left = 531
    Top = 8
  end
  object DsPara: TDataSource
    AutoEdit = False
    DataSet = DmGeradorConsultas.QryParametros
    Left = 530
    Top = 123
  end
  object DsCampos: TDataSource
    DataSet = DmGeradorConsultas.QryCampos
    Left = 529
    Top = 186
  end
  object QryExec: TFDQuery
    Connection = ConSqlServer.FDConnection
    Left = 384
    Top = 312
  end
  object DsExec: TDataSource
    AutoEdit = False
    DataSet = QryExec
    Left = 496
    Top = 311
  end
end
