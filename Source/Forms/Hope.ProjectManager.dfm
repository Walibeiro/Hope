object FormProjectManager: TFormProjectManager
  Left = 0
  Top = 0
  Caption = 'Project Manager'
  ClientHeight = 541
  ClientWidth = 236
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 236
    Height = 29
    Caption = 'ToolBar'
    TabOrder = 0
  end
  object TreeProject: TVirtualStringTree
    Left = 0
    Top = 29
    Width = 236
    Height = 512
    Align = alClient
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    TabOrder = 1
    Columns = <>
  end
end
