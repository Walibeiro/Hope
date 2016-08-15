object FormWelcomePage: TFormWelcomePage
  Left = 0
  Top = 0
  Caption = 'Welcome Page'
  ClientHeight = 565
  ClientWidth = 823
  Color = clBtnFace
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnStartDock = FormStartDock
  PixelsPerInch = 96
  TextHeight = 15
  object Chromium: TChromium
    Left = 0
    Top = 0
    Width = 823
    Height = 565
    Align = alClient
    DefaultUrl = 'about:blank'
    TabOrder = 0
  end
end
