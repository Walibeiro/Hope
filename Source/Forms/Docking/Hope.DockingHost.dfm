inherited FormDockHost: TFormDockHost
  Left = 373
  Top = 291
  Caption = 'Dock Host'
  ClientHeight = 303
  ClientWidth = 590
  OnDockDrop = PanelDockDrop
  OnDockOver = PanelDockOver
  OnGetSiteInfo = FormGetSiteInfo
  OnUnDock = PanelUnDock
  PixelsPerInch = 96
  TextHeight = 13
  object PanelDock: TPanel
    Left = 0
    Top = 0
    Width = 590
    Height = 279
    Align = alClient
    BevelOuter = bvNone
    UseDockManager = False
    DockSite = True
    DragKind = dkDock
    DragMode = dmAutomatic
    TabOrder = 0
    OnDockDrop = PanelDockDrop
    OnDockOver = PanelDockOver
    OnUnDock = PanelUnDock
  end
  object TabSet: TTabSet
    Left = 0
    Top = 279
    Width = 590
    Height = 24
    Align = alBottom
    DragKind = dkDock
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Style = tsModernTabs
    OnChange = TabSetChange
    OnMouseDown = TabSetMouseDown
  end
end
