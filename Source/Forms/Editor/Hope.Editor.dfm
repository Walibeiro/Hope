object FormEditor: TFormEditor
  Left = 0
  Top = 0
  Caption = 'FormEditor'
  ClientHeight = 606
  ClientWidth = 783
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    783
    606)
  PixelsPerInch = 96
  TextHeight = 13
  object Editor: TSynEdit
    Left = 0
    Top = 0
    Width = 783
    Height = 587
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 0
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Lines.Strings = (
      'Editor')
    FontSmoothing = fsmNone
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 587
    Width = 783
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 96
      end
      item
        Width = 64
      end
      item
        Width = 50
      end>
    SizeGrip = False
  end
  object ToolBarMacro: TToolBar
    Left = 3
    Top = 590
    Width = 55
    Height = 16
    Align = alNone
    Anchors = [akLeft, akBottom]
    ButtonHeight = 19
    ButtonWidth = 18
    TabOrder = 2
    object ToolButtonPlay: TToolButton
      Left = 0
      Top = 0
      Caption = 'Play'
      ImageIndex = 0
    end
    object ToolButtonRecord: TToolButton
      Left = 18
      Top = 0
      Caption = 'ToolButtonRecord'
      ImageIndex = 1
    end
    object ToolButtonStop: TToolButton
      Left = 36
      Top = 0
      Caption = 'ToolButtonStop'
      ImageIndex = 2
    end
  end
end
