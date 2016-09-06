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
    Height = 584
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 0
    BorderStyle = bsNone
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    OnGutterPaint = EditorGutterPaint
    OnStatusChange = EditorStatusChange
    FontSmoothing = fsmNone
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 584
    Width = 783
    Height = 22
    DoubleBuffered = True
    Panels = <
      item
        Width = 59
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
    ParentDoubleBuffered = False
    SizeGrip = False
  end
  object ToolBarMacro: TToolBar
    Left = 1
    Top = 587
    Width = 57
    Height = 19
    Align = alNone
    Anchors = [akLeft, akBottom]
    ButtonHeight = 19
    ButtonWidth = 19
    Images = DataModuleCommon.ImageList12
    TabOrder = 2
    object ToolButtonPlay: TToolButton
      Left = 0
      Top = 0
      Action = FormMain.ActionMacroPlay
    end
    object ToolButtonRecord: TToolButton
      Left = 19
      Top = 0
      Action = FormMain.ActionMacroRecord
    end
    object ToolButtonStop: TToolButton
      Left = 38
      Top = 0
      Action = FormMain.ActionMacroStop
    end
  end
end
