object FormRelatoriosPersonalizados: TFormRelatoriosPersonalizados
  Left = 0
  Top = 110
  Caption = 'Relat'#243'rios Personalizados'
  ClientHeight = 533
  ClientWidth = 710
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
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    710
    533)
  PixelsPerInch = 96
  TextHeight = 13
  object PanelConsulta: TPanel
    Left = 0
    Top = 0
    Width = 710
    Height = 533
    Align = alClient
    TabOrder = 0
    object PanelInfo: TPanel
      Left = 1
      Top = 1
      Width = 708
      Height = 488
      Align = alClient
      TabOrder = 0
      object Panel2: TPanel
        Left = 1
        Top = 1
        Width = 706
        Height = 40
        Align = alTop
        TabOrder = 1
        object Label1: TLabel
          Left = 143
          Top = 10
          Width = 66
          Height = 13
          Alignment = taRightJustify
          Caption = 'Nome Interno'
        end
        object Label2: TLabel
          Left = 22
          Top = 10
          Width = 11
          Height = 13
          Alignment = taRightJustify
          Caption = 'ID'
        end
        object EditNome: TDBEdit
          Left = 215
          Top = 8
          Width = 234
          Height = 21
          DataField = 'Nome'
          DataSource = DsConsultas
          TabOrder = 0
        end
        object EdtID: TDBEdit
          Left = 39
          Top = 8
          Width = 66
          Height = 21
          Color = cl3DLight
          DataField = 'ID'
          DataSource = DsConsultas
          ReadOnly = True
          TabOrder = 1
        end
      end
      object PageControl: TPageControl
        Left = 1
        Top = 41
        Width = 706
        Height = 446
        ActivePage = TabCadastro
        Align = alClient
        MultiLine = True
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnChange = PageControlChange
        object TabCadastro: TTabSheet
          Caption = 'Cadastro'
          DesignSize = (
            698
            418)
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
          object Label4: TLabel
            Left = 15
            Top = 211
            Width = 14
            Height = 13
            Caption = 'Sql'
          end
          object Label5: TLabel
            Left = 448
            Top = 131
            Width = 76
            Height = 13
            Alignment = taRightJustify
            Anchors = [akRight]
            Caption = 'Fonte de Dados'
            ExplicitLeft = 399
          end
          object Label6: TLabel
            Left = 54
            Top = 162
            Width = 99
            Height = 13
            Caption = 'Visualiza'#231#227'o Padr'#227'o:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object EdtDescricao: TDBEdit
            Left = 54
            Top = 3
            Width = 611
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            DataField = 'Descricao'
            DataSource = DsConsultas
            TabOrder = 0
          end
          object DBMemo1: TDBMemo
            Left = 54
            Top = 45
            Width = 611
            Height = 61
            Anchors = [akLeft, akTop, akRight]
            DataField = 'InfoExtendida'
            DataSource = DsConsultas
            TabOrder = 1
          end
          object DBRadioGroup1: TDBRadioGroup
            Left = 54
            Top = 112
            Width = 376
            Height = 41
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Tipo'
            Columns = 3
            DataField = 'Tipo'
            DataSource = DsConsultas
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
          object DBMemoSql: TDBMemo
            Left = 15
            Top = 230
            Width = 665
            Height = 177
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataField = 'Sql'
            DataSource = DsConsultas
            TabOrder = 3
          end
          object cxDBImageComboBox1: TcxDBImageComboBox
            Left = 530
            Top = 127
            Anchors = [akTop, akRight]
            DataBinding.DataField = 'FonteDados'
            DataBinding.DataSource = DsConsultas
            Properties.ImageAlign = iaRight
            Properties.Items = <
              item
                Description = 'Sql Server'
                ImageIndex = 0
                Value = 1
              end
              item
                Description = 'Firebird'
                Value = 2
              end>
            TabOrder = 4
            Width = 135
          end
          object cbxConfiguracoes: TDBLookupComboBox
            Left = 54
            Top = 179
            Width = 293
            Height = 22
            Anchors = [akLeft, akTop, akRight]
            Color = clWhite
            DataField = 'ConfigPadrao'
            DataSource = DsConsultas
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            KeyField = 'ID'
            ListField = 'Descricao'
            ListSource = DsVisualizacoes
            ParentFont = False
            TabOrder = 5
          end
          object DBRadioPaginaPadrao: TDBRadioGroup
            Left = 378
            Top = 162
            Width = 287
            Height = 41
            Anchors = [akTop, akRight]
            Caption = 'P'#225'gina Padr'#227'o'
            Columns = 3
            DataField = 'VisualizacaoPadrao'
            DataSource = DsConsultas
            Items.Strings = (
              'Tabela'
              'Pivot'
              'Gr'#225'fico')
            TabOrder = 6
            Values.Strings = (
              '0'
              '1'
              '2')
          end
        end
        object TabParametros: TTabSheet
          Caption = 'Par'#226'metros'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 649
          ExplicitHeight = 0
          object cxGridParams: TcxGrid
            Left = 0
            Top = 0
            Width = 698
            Height = 418
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 649
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
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 649
          ExplicitHeight = 0
          object cxGridCampos: TcxGrid
            Left = 0
            Top = 0
            Width = 698
            Height = 225
            Align = alTop
            TabOrder = 0
            ExplicitWidth = 649
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
                Width = 49
              end
              object cxGridDBTableView1Formatacao: TcxGridDBColumn
                DataBinding.FieldName = 'Formatacao'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Alignment.Horz = taLeftJustify
                Properties.ImageAlign = iaRight
                Properties.Items = <
                  item
                    Description = 'Texto'
                    ImageIndex = 0
                    Value = 0
                  end
                  item
                    Description = 'Moeda'
                    Value = 1
                  end
                  item
                    Description = 'Porcentagem'
                    Value = 2
                  end>
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
            Width = 698
            Height = 193
            Align = alClient
            TabOrder = 1
            ExplicitWidth = 649
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
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
            end
            object cxGridLevel2: TcxGridLevel
              GridView = cxGridConsultaView
            end
          end
        end
      end
    end
    object PanelControles: TPanel
      Left = 1
      Top = 489
      Width = 708
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
    Left = 520
    Top = 495
    Width = 98
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Definir Campos'
    TabOrder = 1
  end
  object DsConsultas: TDataSource
    DataSet = DmGeradorConsultas.QryConsultas
    Left = 531
    Top = 56
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
  object QryVisualizacoes: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT * FROM'
      'cons.Visualizacoes'
      'WHERE Consulta =:codConsulta')
    Left = 360
    Top = 232
    ParamData = <
      item
        Name = 'CODCONSULTA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QryVisualizacoesID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryVisualizacoesConsulta: TIntegerField
      FieldName = 'Consulta'
      Origin = 'Consulta'
    end
    object QryVisualizacoesDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 1024
    end
    object QryVisualizacoesArquivo: TBlobField
      FieldName = 'Arquivo'
      Origin = 'Arquivo'
      Size = 2147483647
    end
    object QryVisualizacoesDataHora: TSQLTimeStampField
      FieldName = 'DataHora'
      Origin = 'DataHora'
    end
  end
  object DsVisualizacoes: TDataSource
    DataSet = QryVisualizacoes
    Left = 466
    Top = 233
  end
end
