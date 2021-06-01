object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Informa'#231#245'es de estoque e demanda'
  ClientHeight = 405
  ClientWidth = 839
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTabs: TPanel
    Left = 233
    Top = 0
    Width = 606
    Height = 386
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object ChromeTabs1: TChromeTabs
      Left = 0
      Top = 0
      Width = 606
      Height = 32
      OnActiveTabChanged = ChromeTabs1ActiveTabChanged
      OnButtonAddClick = ChromeTabs1ButtonAddClick
      OnButtonCloseTabClick = ChromeTabs1ButtonCloseTabClick
      OnNeedDragImageControl = ChromeTabs1NeedDragImageControl
      OnStateChange = ChromeTabs1StateChange
      OnTabDragStart = ChromeTabs1TabDragStart
      OnTabDragDrop = ChromeTabs1TabDragDrop
      ActiveTabIndex = -1
      Options.Display.CloseButton.Offsets.Vertical = 6
      Options.Display.CloseButton.Offsets.Horizontal = 2
      Options.Display.CloseButton.Height = 14
      Options.Display.CloseButton.Width = 14
      Options.Display.CloseButton.AutoHide = True
      Options.Display.CloseButton.Visibility = bvAll
      Options.Display.CloseButton.AutoHideWidth = 20
      Options.Display.CloseButton.CrossRadialOffset = 4
      Options.Display.AddButton.Offsets.Vertical = 10
      Options.Display.AddButton.Offsets.Horizontal = 2
      Options.Display.AddButton.Height = 14
      Options.Display.AddButton.Width = 31
      Options.Display.AddButton.ShowPlusSign = False
      Options.Display.AddButton.Visibility = avRightFloating
      Options.Display.AddButton.HorizontalOffsetFloating = -3
      Options.Display.ScrollButtonLeft.Offsets.Vertical = 10
      Options.Display.ScrollButtonLeft.Offsets.Horizontal = 1
      Options.Display.ScrollButtonLeft.Height = 15
      Options.Display.ScrollButtonLeft.Width = 15
      Options.Display.ScrollButtonRight.Offsets.Vertical = 10
      Options.Display.ScrollButtonRight.Offsets.Horizontal = 1
      Options.Display.ScrollButtonRight.Height = 15
      Options.Display.ScrollButtonRight.Width = 15
      Options.Display.TabModifiedGlow.Style = msRightToLeft
      Options.Display.TabModifiedGlow.VerticalOffset = -6
      Options.Display.TabModifiedGlow.Height = 30
      Options.Display.TabModifiedGlow.Width = 100
      Options.Display.TabModifiedGlow.AnimationPeriodMS = 4000
      Options.Display.TabModifiedGlow.EaseType = ttEaseInOutQuad
      Options.Display.TabModifiedGlow.AnimationUpdateMS = 50
      Options.Display.Tabs.SeeThroughTabs = False
      Options.Display.Tabs.TabOverlap = 15
      Options.Display.Tabs.ContentOffsetLeft = 18
      Options.Display.Tabs.ContentOffsetRight = 16
      Options.Display.Tabs.OffsetLeft = 0
      Options.Display.Tabs.OffsetTop = 4
      Options.Display.Tabs.OffsetRight = 0
      Options.Display.Tabs.OffsetBottom = 0
      Options.Display.Tabs.MinWidth = 25
      Options.Display.Tabs.MaxWidth = 200
      Options.Display.Tabs.TabWidthFromContent = False
      Options.Display.Tabs.PinnedWidth = 39
      Options.Display.Tabs.ImageOffsetLeft = 13
      Options.Display.Tabs.TextTrimType = tttFade
      Options.Display.Tabs.Orientation = toTop
      Options.Display.Tabs.BaseLineTabRegionOnly = False
      Options.Display.Tabs.WordWrap = False
      Options.Display.Tabs.TextAlignmentHorizontal = taLeftJustify
      Options.Display.Tabs.TextAlignmentVertical = taVerticalCenter
      Options.Display.Tabs.ShowImages = True
      Options.Display.Tabs.ShowPinnedTabText = False
      Options.Display.TabContainer.TransparentBackground = True
      Options.Display.TabContainer.OverlayButtons = True
      Options.Display.TabContainer.PaddingLeft = 0
      Options.Display.TabContainer.PaddingRight = 0
      Options.Display.TabMouseGlow.Offsets.Vertical = 0
      Options.Display.TabMouseGlow.Offsets.Horizontal = 0
      Options.Display.TabMouseGlow.Height = 200
      Options.Display.TabMouseGlow.Width = 200
      Options.Display.TabMouseGlow.Visible = True
      Options.Display.TabSpinners.Upload.ReverseDirection = True
      Options.Display.TabSpinners.Upload.RenderedAnimationStep = 2
      Options.Display.TabSpinners.Upload.Position.Offsets.Vertical = 0
      Options.Display.TabSpinners.Upload.Position.Offsets.Horizontal = 0
      Options.Display.TabSpinners.Upload.Position.Height = 16
      Options.Display.TabSpinners.Upload.Position.Width = 16
      Options.Display.TabSpinners.Upload.SweepAngle = 135
      Options.Display.TabSpinners.Download.ReverseDirection = False
      Options.Display.TabSpinners.Download.RenderedAnimationStep = 5
      Options.Display.TabSpinners.Download.Position.Offsets.Vertical = 0
      Options.Display.TabSpinners.Download.Position.Offsets.Horizontal = 0
      Options.Display.TabSpinners.Download.Position.Height = 16
      Options.Display.TabSpinners.Download.Position.Width = 16
      Options.Display.TabSpinners.Download.SweepAngle = 135
      Options.Display.TabSpinners.AnimationUpdateMS = 50
      Options.Display.TabSpinners.HideImagesWhenSpinnerVisible = True
      Options.DragDrop.DragType = dtBetweenContainers
      Options.DragDrop.DragOutsideImageAlpha = 220
      Options.DragDrop.DragOutsideDistancePixels = 30
      Options.DragDrop.DragStartPixels = 2
      Options.DragDrop.DragControlImageResizeFactor = 0.500000000000000000
      Options.DragDrop.DragCursor = crDefault
      Options.DragDrop.DragDisplay = ddTabAndControl
      Options.DragDrop.DragFormBorderWidth = 2
      Options.DragDrop.DragFormBorderColor = 8421504
      Options.DragDrop.ContrainDraggedTabWithinContainer = True
      Options.Animation.DefaultMovementAnimationTimeMS = 100
      Options.Animation.DefaultStyleAnimationTimeMS = 300
      Options.Animation.AnimationTimerInterval = 15
      Options.Animation.MinimumTabAnimationWidth = 40
      Options.Animation.DefaultMovementEaseType = ttLinearTween
      Options.Animation.DefaultStyleEaseType = ttLinearTween
      Options.Animation.MovementAnimations.TabAdd.UseDefaultEaseType = True
      Options.Animation.MovementAnimations.TabAdd.UseDefaultAnimationTime = True
      Options.Animation.MovementAnimations.TabAdd.EaseType = ttEaseOutExpo
      Options.Animation.MovementAnimations.TabAdd.AnimationTimeMS = 500
      Options.Animation.MovementAnimations.TabDelete.UseDefaultEaseType = True
      Options.Animation.MovementAnimations.TabDelete.UseDefaultAnimationTime = True
      Options.Animation.MovementAnimations.TabDelete.EaseType = ttEaseOutExpo
      Options.Animation.MovementAnimations.TabDelete.AnimationTimeMS = 500
      Options.Animation.MovementAnimations.TabMove.UseDefaultEaseType = False
      Options.Animation.MovementAnimations.TabMove.UseDefaultAnimationTime = False
      Options.Animation.MovementAnimations.TabMove.EaseType = ttEaseOutExpo
      Options.Animation.MovementAnimations.TabMove.AnimationTimeMS = 500
      Options.Behaviour.BackgroundDblClickMaximiseRestoreForm = True
      Options.Behaviour.BackgroundDragMovesForm = True
      Options.Behaviour.TabSmartDeleteResizing = True
      Options.Behaviour.TabSmartDeleteResizeCancelDelay = 700
      Options.Behaviour.UseBuiltInPopupMenu = True
      Options.Behaviour.TabRightClickSelect = True
      Options.Behaviour.ActivateNewTab = True
      Options.Behaviour.DebugMode = False
      Options.Behaviour.IgnoreDoubleClicksWhileAnimatingMovement = True
      Options.Scrolling.Enabled = True
      Options.Scrolling.ScrollButtons = csbRight
      Options.Scrolling.ScrollStep = 20
      Options.Scrolling.ScrollRepeatDelay = 20
      Options.Scrolling.AutoHideButtons = False
      Options.Scrolling.DragScroll = True
      Options.Scrolling.DragScrollOffset = 50
      Options.Scrolling.MouseWheelScroll = True
      Tabs = <>
      LookAndFeel.TabsContainer.StartColor = 14586466
      LookAndFeel.TabsContainer.StopColor = 13201730
      LookAndFeel.TabsContainer.StartAlpha = 255
      LookAndFeel.TabsContainer.StopAlpha = 255
      LookAndFeel.TabsContainer.OutlineColor = 14520930
      LookAndFeel.TabsContainer.OutlineAlpha = 0
      LookAndFeel.Tabs.BaseLine.Color = 11110509
      LookAndFeel.Tabs.BaseLine.Thickness = 1.000000000000000000
      LookAndFeel.Tabs.BaseLine.Alpha = 255
      LookAndFeel.Tabs.Modified.CentreColor = clWhite
      LookAndFeel.Tabs.Modified.OutsideColor = clWhite
      LookAndFeel.Tabs.Modified.CentreAlpha = 130
      LookAndFeel.Tabs.Modified.OutsideAlpha = 0
      LookAndFeel.Tabs.DefaultFont.Name = 'Segoe UI'
      LookAndFeel.Tabs.DefaultFont.Color = clBlack
      LookAndFeel.Tabs.DefaultFont.Size = 9
      LookAndFeel.Tabs.DefaultFont.Alpha = 255
      LookAndFeel.Tabs.DefaultFont.TextRenderingMode = TextRenderingHintClearTypeGridFit
      LookAndFeel.Tabs.MouseGlow.CentreColor = clWhite
      LookAndFeel.Tabs.MouseGlow.OutsideColor = clWhite
      LookAndFeel.Tabs.MouseGlow.CentreAlpha = 120
      LookAndFeel.Tabs.MouseGlow.OutsideAlpha = 0
      LookAndFeel.Tabs.Spinners.Upload.Color = 12759975
      LookAndFeel.Tabs.Spinners.Upload.Thickness = 2.500000000000000000
      LookAndFeel.Tabs.Spinners.Upload.Alpha = 255
      LookAndFeel.Tabs.Spinners.Download.Color = 14388040
      LookAndFeel.Tabs.Spinners.Download.Thickness = 2.500000000000000000
      LookAndFeel.Tabs.Spinners.Download.Alpha = 255
      LookAndFeel.Tabs.Active.Font.Name = 'Segoe UI'
      LookAndFeel.Tabs.Active.Font.Color = clOlive
      LookAndFeel.Tabs.Active.Font.Size = 9
      LookAndFeel.Tabs.Active.Font.Alpha = 100
      LookAndFeel.Tabs.Active.Font.TextRenderingMode = TextRenderingHintClearTypeGridFit
      LookAndFeel.Tabs.Active.Font.UseDefaultFont = True
      LookAndFeel.Tabs.Active.Style.StartColor = clWhite
      LookAndFeel.Tabs.Active.Style.StopColor = 16316920
      LookAndFeel.Tabs.Active.Style.StartAlpha = 255
      LookAndFeel.Tabs.Active.Style.StopAlpha = 255
      LookAndFeel.Tabs.Active.Style.OutlineColor = 10189918
      LookAndFeel.Tabs.Active.Style.OutlineSize = 1.000000000000000000
      LookAndFeel.Tabs.Active.Style.OutlineAlpha = 255
      LookAndFeel.Tabs.NotActive.Font.Name = 'Segoe UI'
      LookAndFeel.Tabs.NotActive.Font.Color = 4603477
      LookAndFeel.Tabs.NotActive.Font.Size = 9
      LookAndFeel.Tabs.NotActive.Font.Alpha = 215
      LookAndFeel.Tabs.NotActive.Font.TextRenderingMode = TextRenderingHintClearTypeGridFit
      LookAndFeel.Tabs.NotActive.Font.UseDefaultFont = False
      LookAndFeel.Tabs.NotActive.Style.StartColor = 15194573
      LookAndFeel.Tabs.NotActive.Style.StopColor = 15194573
      LookAndFeel.Tabs.NotActive.Style.StartAlpha = 210
      LookAndFeel.Tabs.NotActive.Style.StopAlpha = 210
      LookAndFeel.Tabs.NotActive.Style.OutlineColor = 13546390
      LookAndFeel.Tabs.NotActive.Style.OutlineSize = 1.000000000000000000
      LookAndFeel.Tabs.NotActive.Style.OutlineAlpha = 215
      LookAndFeel.Tabs.Hot.Font.Name = 'Segoe UI'
      LookAndFeel.Tabs.Hot.Font.Color = 4210752
      LookAndFeel.Tabs.Hot.Font.Size = 9
      LookAndFeel.Tabs.Hot.Font.Alpha = 215
      LookAndFeel.Tabs.Hot.Font.TextRenderingMode = TextRenderingHintClearTypeGridFit
      LookAndFeel.Tabs.Hot.Font.UseDefaultFont = False
      LookAndFeel.Tabs.Hot.Style.StartColor = 15721176
      LookAndFeel.Tabs.Hot.Style.StopColor = 15589847
      LookAndFeel.Tabs.Hot.Style.StartAlpha = 255
      LookAndFeel.Tabs.Hot.Style.StopAlpha = 255
      LookAndFeel.Tabs.Hot.Style.OutlineColor = 12423799
      LookAndFeel.Tabs.Hot.Style.OutlineSize = 1.000000000000000000
      LookAndFeel.Tabs.Hot.Style.OutlineAlpha = 235
      LookAndFeel.CloseButton.Cross.Normal.Color = 6643031
      LookAndFeel.CloseButton.Cross.Normal.Thickness = 1.500000000000000000
      LookAndFeel.CloseButton.Cross.Normal.Alpha = 255
      LookAndFeel.CloseButton.Cross.Down.Color = 15461369
      LookAndFeel.CloseButton.Cross.Down.Thickness = 2.000000000000000000
      LookAndFeel.CloseButton.Cross.Down.Alpha = 220
      LookAndFeel.CloseButton.Cross.Hot.Color = clWhite
      LookAndFeel.CloseButton.Cross.Hot.Thickness = 2.000000000000000000
      LookAndFeel.CloseButton.Cross.Hot.Alpha = 220
      LookAndFeel.CloseButton.Circle.Normal.StartColor = clGradientActiveCaption
      LookAndFeel.CloseButton.Circle.Normal.StopColor = clNone
      LookAndFeel.CloseButton.Circle.Normal.StartAlpha = 0
      LookAndFeel.CloseButton.Circle.Normal.StopAlpha = 0
      LookAndFeel.CloseButton.Circle.Normal.OutlineColor = clGray
      LookAndFeel.CloseButton.Circle.Normal.OutlineSize = 1.000000000000000000
      LookAndFeel.CloseButton.Circle.Normal.OutlineAlpha = 0
      LookAndFeel.CloseButton.Circle.Down.StartColor = 3487169
      LookAndFeel.CloseButton.Circle.Down.StopColor = 3487169
      LookAndFeel.CloseButton.Circle.Down.StartAlpha = 255
      LookAndFeel.CloseButton.Circle.Down.StopAlpha = 255
      LookAndFeel.CloseButton.Circle.Down.OutlineColor = clGray
      LookAndFeel.CloseButton.Circle.Down.OutlineSize = 1.000000000000000000
      LookAndFeel.CloseButton.Circle.Down.OutlineAlpha = 255
      LookAndFeel.CloseButton.Circle.Hot.StartColor = 9408475
      LookAndFeel.CloseButton.Circle.Hot.StopColor = 9803748
      LookAndFeel.CloseButton.Circle.Hot.StartAlpha = 255
      LookAndFeel.CloseButton.Circle.Hot.StopAlpha = 255
      LookAndFeel.CloseButton.Circle.Hot.OutlineColor = 6054595
      LookAndFeel.CloseButton.Circle.Hot.OutlineSize = 1.000000000000000000
      LookAndFeel.CloseButton.Circle.Hot.OutlineAlpha = 255
      LookAndFeel.AddButton.Button.Normal.StartColor = 14340292
      LookAndFeel.AddButton.Button.Normal.StopColor = 14340035
      LookAndFeel.AddButton.Button.Normal.StartAlpha = 255
      LookAndFeel.AddButton.Button.Normal.StopAlpha = 255
      LookAndFeel.AddButton.Button.Normal.OutlineColor = 13088421
      LookAndFeel.AddButton.Button.Normal.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.Button.Normal.OutlineAlpha = 255
      LookAndFeel.AddButton.Button.Down.StartColor = 13417645
      LookAndFeel.AddButton.Button.Down.StopColor = 13417644
      LookAndFeel.AddButton.Button.Down.StartAlpha = 255
      LookAndFeel.AddButton.Button.Down.StopAlpha = 255
      LookAndFeel.AddButton.Button.Down.OutlineColor = 10852748
      LookAndFeel.AddButton.Button.Down.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.Button.Down.OutlineAlpha = 255
      LookAndFeel.AddButton.Button.Hot.StartColor = 15524314
      LookAndFeel.AddButton.Button.Hot.StopColor = 15524314
      LookAndFeel.AddButton.Button.Hot.StartAlpha = 255
      LookAndFeel.AddButton.Button.Hot.StopAlpha = 255
      LookAndFeel.AddButton.Button.Hot.OutlineColor = 14927787
      LookAndFeel.AddButton.Button.Hot.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.Button.Hot.OutlineAlpha = 255
      LookAndFeel.AddButton.PlusSign.Normal.StartColor = clWhite
      LookAndFeel.AddButton.PlusSign.Normal.StopColor = clWhite
      LookAndFeel.AddButton.PlusSign.Normal.StartAlpha = 255
      LookAndFeel.AddButton.PlusSign.Normal.StopAlpha = 255
      LookAndFeel.AddButton.PlusSign.Normal.OutlineColor = clGray
      LookAndFeel.AddButton.PlusSign.Normal.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.PlusSign.Normal.OutlineAlpha = 255
      LookAndFeel.AddButton.PlusSign.Down.StartColor = clWhite
      LookAndFeel.AddButton.PlusSign.Down.StopColor = clWhite
      LookAndFeel.AddButton.PlusSign.Down.StartAlpha = 255
      LookAndFeel.AddButton.PlusSign.Down.StopAlpha = 255
      LookAndFeel.AddButton.PlusSign.Down.OutlineColor = clGray
      LookAndFeel.AddButton.PlusSign.Down.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.PlusSign.Down.OutlineAlpha = 255
      LookAndFeel.AddButton.PlusSign.Hot.StartColor = clWhite
      LookAndFeel.AddButton.PlusSign.Hot.StopColor = clWhite
      LookAndFeel.AddButton.PlusSign.Hot.StartAlpha = 255
      LookAndFeel.AddButton.PlusSign.Hot.StopAlpha = 255
      LookAndFeel.AddButton.PlusSign.Hot.OutlineColor = clGray
      LookAndFeel.AddButton.PlusSign.Hot.OutlineSize = 1.000000000000000000
      LookAndFeel.AddButton.PlusSign.Hot.OutlineAlpha = 255
      LookAndFeel.ScrollButtons.Button.Normal.StartColor = 14735310
      LookAndFeel.ScrollButtons.Button.Normal.StopColor = 14274499
      LookAndFeel.ScrollButtons.Button.Normal.StartAlpha = 255
      LookAndFeel.ScrollButtons.Button.Normal.StopAlpha = 255
      LookAndFeel.ScrollButtons.Button.Normal.OutlineColor = 11507842
      LookAndFeel.ScrollButtons.Button.Normal.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Button.Normal.OutlineAlpha = 255
      LookAndFeel.ScrollButtons.Button.Down.StartColor = 13417645
      LookAndFeel.ScrollButtons.Button.Down.StopColor = 13417644
      LookAndFeel.ScrollButtons.Button.Down.StartAlpha = 255
      LookAndFeel.ScrollButtons.Button.Down.StopAlpha = 255
      LookAndFeel.ScrollButtons.Button.Down.OutlineColor = 10852748
      LookAndFeel.ScrollButtons.Button.Down.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Button.Down.OutlineAlpha = 255
      LookAndFeel.ScrollButtons.Button.Hot.StartColor = 15524314
      LookAndFeel.ScrollButtons.Button.Hot.StopColor = 15524313
      LookAndFeel.ScrollButtons.Button.Hot.StartAlpha = 255
      LookAndFeel.ScrollButtons.Button.Hot.StopAlpha = 255
      LookAndFeel.ScrollButtons.Button.Hot.OutlineColor = 14927788
      LookAndFeel.ScrollButtons.Button.Hot.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Button.Hot.OutlineAlpha = 255
      LookAndFeel.ScrollButtons.Button.Disabled.StartColor = 14340036
      LookAndFeel.ScrollButtons.Button.Disabled.StopColor = 14274499
      LookAndFeel.ScrollButtons.Button.Disabled.StartAlpha = 150
      LookAndFeel.ScrollButtons.Button.Disabled.StopAlpha = 150
      LookAndFeel.ScrollButtons.Button.Disabled.OutlineColor = 11113341
      LookAndFeel.ScrollButtons.Button.Disabled.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Button.Disabled.OutlineAlpha = 100
      LookAndFeel.ScrollButtons.Arrow.Normal.StartColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Normal.StopColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Normal.StartAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Normal.StopAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Normal.OutlineColor = clGray
      LookAndFeel.ScrollButtons.Arrow.Normal.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Arrow.Normal.OutlineAlpha = 200
      LookAndFeel.ScrollButtons.Arrow.Down.StartColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Down.StopColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Down.StartAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Down.StopAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Down.OutlineColor = clGray
      LookAndFeel.ScrollButtons.Arrow.Down.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Arrow.Down.OutlineAlpha = 200
      LookAndFeel.ScrollButtons.Arrow.Hot.StartColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Hot.StopColor = clWhite
      LookAndFeel.ScrollButtons.Arrow.Hot.StartAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Hot.StopAlpha = 255
      LookAndFeel.ScrollButtons.Arrow.Hot.OutlineColor = clGray
      LookAndFeel.ScrollButtons.Arrow.Hot.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Arrow.Hot.OutlineAlpha = 200
      LookAndFeel.ScrollButtons.Arrow.Disabled.StartColor = clSilver
      LookAndFeel.ScrollButtons.Arrow.Disabled.StopColor = clSilver
      LookAndFeel.ScrollButtons.Arrow.Disabled.StartAlpha = 150
      LookAndFeel.ScrollButtons.Arrow.Disabled.StopAlpha = 150
      LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineColor = clGray
      LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineSize = 1.000000000000000000
      LookAndFeel.ScrollButtons.Arrow.Disabled.OutlineAlpha = 200
      Align = alTop
      TabOrder = 0
    end
    object PanelMain: TPanel
      Left = 0
      Top = 32
      Width = 606
      Height = 354
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object TreeViewMenu: TdxDBTreeView
    Left = 0
    Top = 0
    Width = 225
    Height = 386
    RightClickSelect = True
    ShowNodeHint = True
    OnDragDropTreeNode = TreeViewMenuDragDropTreeNode
    DataSource = DsMenu
    KeyField = 'ID'
    ListField = 'Descricao'
    ParentField = 'IDPai'
    RootValue = Null
    SeparatedSt = ' - '
    RaiseOnError = True
    ReadOnly = True
    DragMode = dmAutomatic
    Indent = 19
    OnChange = TreeViewMenuChange
    Align = alLeft
    ParentColor = False
    Options = [trDBCanDelete, trDBConfirmDelete, trCanDBNavigate, trSmartRecordCopy, trCheckHasChildren]
    SelectedIndex = -1
    TabOrder = 1
    OnDblClick = TreeViewMenuDblClick
    OnKeyDown = TreeViewMenuKeyDown
    PopupMenu = PopupMenuTreeView
  end
  object cxSplitter1: TcxSplitter
    Left = 225
    Top = 0
    Width = 8
    Height = 386
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 386
    Width = 839
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object MainMenu: TMainMenu
    OwnerDraw = True
    Left = 178
    Top = 40
    object Utilidades1: TMenuItem
      Caption = 'Utilit'#225'rios'
      object Pedidos1: TMenuItem
        Caption = 'Pedidos'
        OnClick = Pedidos1Click
      end
      object Fila1: TMenuItem
        Caption = 'Fila de Produ'#231#227'o'
        OnClick = Fila1Click
      end
      object DetalhedosProdutos1: TMenuItem
        Caption = 'Detalhe dos Produtos'
        OnClick = DetalhedosProdutos1Click
      end
      object EmailEmbalagens1: TMenuItem
        Caption = 'Email Embalagens'
        OnClick = EmailEmbalagens1Click
      end
    end
    object Vendas1: TMenuItem
      Caption = 'Vendas'
      object MenuCicloVendas: TMenuItem
        Caption = 'Ciclos de Vendas'
        OnClick = MenuCicloVendasClick
      end
    end
    object Extras1: TMenuItem
      Caption = 'Extras'
      object Densidade1: TMenuItem
        Caption = 'Densidade'
        OnClick = Densidade1Click
      end
      object Conversor1: TMenuItem
        Caption = 'Conversor'
        OnClick = Conversor1Click
      end
      object ValidaModelos1: TMenuItem
        Caption = 'Valida Modelos'
        Visible = False
        OnClick = ValidaModelos1Click
      end
      object ExecutarSql1: TMenuItem
        Caption = 'Executar Sql'
        OnClick = ExecutarSql1Click
      end
      object CriarConsulta1: TMenuItem
        Caption = 'Gerenciar Relat'#243'rios'
        OnClick = CriarConsulta1Click
      end
    end
    object Compras1: TMenuItem
      Caption = 'Compras'
      object ComprasAgendadas1: TMenuItem
        Caption = 'Compras Agendadas'
        OnClick = ComprasAgendadas1Click
      end
      object ComprasporGrupo1: TMenuItem
        Caption = 'Compras por Grupo'
        OnClick = ComprasporGrupo1Click
      end
      object ControleLogistica1: TMenuItem
        Caption = 'Controle Logistica'
        OnClick = ControleLogistica1Click
      end
    end
    object Fretes1: TMenuItem
      Caption = 'Frete'
      object CalculadoradeFretes1: TMenuItem
        Caption = 'Calculadora de Fretes'
        OnClick = CalculadoradeFretes1Click
      end
      object ConfernciadosFretesdosMovimentos1: TMenuItem
        Caption = 'Confer'#234'ncia dos Fretes dos Movimentos'
        OnClick = ConfernciadosFretesdosMovimentos1Click
      end
      object ConfiguraCidadesdaNegociaodeFretes1: TMenuItem
        Caption = 'Configura Cidades da Negocia'#231#227'o de Fretes'
        OnClick = ConfiguraCidadesdaNegociaodeFretes1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object AtualizarDadosNegociaes1: TMenuItem
        Caption = 'Atualizar Dados Negocia'#231#245'es'
        OnClick = AtualizarDadosNegociaes1Click
      end
    end
    object Configuraes1: TMenuItem
      Caption = 'Configura'#231#245'es'
      object Feriados1: TMenuItem
        Caption = 'Feriados'
        OnClick = Feriados1Click
      end
      object MenuItemProInfo: TMenuItem
        Caption = 'Cofig. dos Produtos'
        OnClick = MenuItemProInfoClick
      end
      object DadosGruposdeProdutos1: TMenuItem
        Caption = 'Dados Grupos de Produtos'
        OnClick = DadosGruposdeProdutos1Click
      end
    end
    object Atividades1: TMenuItem
      Caption = 'Atividades'
      object CadastrodeAtividades1: TMenuItem
        Caption = 'Cadastro de Atividades'
        OnClick = CadastrodeAtividades1Click
      end
      object Agendamentos1: TMenuItem
        Caption = 'Agendamentos'
        OnClick = Agendamentos1Click
      end
    end
    object Sistema1: TMenuItem
      Caption = 'Sistema'
      object Usuriosepermisses1: TMenuItem
        Caption = 'Usu'#225'rios e permiss'#245'es'
        OnClick = Usuriosepermisses1Click
      end
      object AtualizaTodasasListasdePreo1: TMenuItem
        Caption = 'Atualiza Todas as Listas de Pre'#231'o'
        OnClick = AtualizaTodasasListasdePreo1Click
      end
    end
    object MenuLogin: TMenuItem
      Caption = 'Login'
      object trocardeusurio1: TMenuItem
        Caption = 'Trocar de usu'#225'rio'
        OnClick = trocardeusurio1Click
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
  end
  object QryConsultas: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'SELECT v.* FROM '
      'sys.views v'
      'where v.schema_id = schema_id('#39'cons'#39')')
    Left = 344
    Top = 40
    object QryConsultasname: TWideStringField
      FieldName = 'name'
      Origin = 'name'
      Required = True
      Size = 128
    end
  end
  object QryMenu: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select m.* '
      'from cons.Menu m'
      'inner join perm.usuario u on U.userid = :userid '
      
        'left join perm.Consultas c on c.ConsultaID = m.ID and c.userid =' +
        ' U.userid'
      'where '
      '  ((U.admin = 1) or (c.Permitido = 1))'
      '')
    Left = 248
    Top = 136
    ParamData = <
      item
        Name = 'USERID'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end>
    object QryMenuID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryMenuDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 255
    end
    object QryMenuIDPai: TIntegerField
      FieldName = 'IDPai'
      Origin = 'IDPai'
    end
    object QryMenuTipo: TIntegerField
      FieldName = 'Tipo'
      Origin = 'Tipo'
    end
    object QryMenuIDAcao: TIntegerField
      FieldName = 'IDAcao'
      Origin = 'IDAcao'
    end
  end
  object DsMenu: TDataSource
    DataSet = QryMenu
    Left = 176
    Top = 136
  end
  object PopupMenuTreeView: TPopupMenu
    OnPopup = PopupMenuTreeViewPopup
    Left = 80
    Top = 272
    object AbrirConsulta1: TMenuItem
      Caption = 'Abrir Consulta'
      Default = True
      OnClick = AbrirConsulta1Click
    end
    object EditarConsulta1: TMenuItem
      Caption = 'Editar Consulta'
      OnClick = EditarConsulta1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object NovoGrupo1: TMenuItem
      Caption = 'Novo Grupo'
      OnClick = NovoGrupo1Click
    end
    object NovaConsulta1: TMenuItem
      Caption = 'Nova Consulta'
      OnClick = NovaConsulta1Click
    end
    object Excluir1: TMenuItem
      Caption = 'Excluir'
      OnClick = Excluir1Click
    end
  end
  object QryPermissaoMenu: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select * '
      'from perm.Menus'
      'where userID = :userID')
    Left = 464
    Top = 40
    ParamData = <
      item
        Name = 'USERID'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
        Value = '2'
      end>
    object QryPermissaoMenuuserid: TIntegerField
      FieldName = 'userid'
      Origin = 'userid'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryPermissaoMenuMenuName: TStringField
      FieldName = 'MenuName'
      Origin = 'MenuName'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 255
    end
    object QryPermissaoMenuPermitido: TBooleanField
      FieldName = 'Permitido'
      Origin = 'Permitido'
    end
  end
  object QryUser: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'select * '
      'from perm.Usuario'
      'where userID =:userID')
    Left = 368
    Top = 152
    ParamData = <
      item
        Name = 'USERID'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
        Value = '2'
      end>
    object QryUseruserid: TFDAutoIncField
      FieldName = 'userid'
      Origin = 'userid'
      ReadOnly = True
    end
    object QryUserNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Size = 255
    end
    object QryUserSenha: TStringField
      FieldName = 'Senha'
      Origin = 'Senha'
      Size = 255
    end
    object QryUseradmin: TBooleanField
      FieldName = 'admin'
      Origin = 'admin'
    end
    object QryUserDefaultMenu: TMemoField
      FieldName = 'DefaultMenu'
      Origin = 'DefaultMenu'
      BlobType = ftMemo
      Size = 2147483647
    end
    object QryUserProducao: TBooleanField
      FieldName = 'Producao'
      Origin = 'Producao'
    end
    object QryUserDesenvolvedor: TBooleanField
      FieldName = 'Desenvolvedor'
      Origin = 'Desenvolvedor'
    end
  end
end
