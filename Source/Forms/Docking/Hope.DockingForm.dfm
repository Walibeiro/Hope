object FormDockable: TFormDockable
  Left = 117
  Top = 294
  Anchors = [akLeft]
  BorderStyle = bsSizeToolWin
  Caption = 'Dockable Form'
  ClientHeight = 215
  ClientWidth = 389
  Color = clBtnFace
  DockSite = True
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnDockOver = FormDockOver
  OnStartDock = FormStartDock
  PixelsPerInch = 96
  TextHeight = 13
end
