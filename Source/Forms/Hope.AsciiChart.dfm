object FormAsciiChart: TFormAsciiChart
  Left = 0
  Top = 0
  Caption = 'ASCII Chart'
  ClientHeight = 348
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 15
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 540
    Height = 23
    AutoSize = True
    ButtonHeight = 23
    ButtonWidth = 33
    DrawingStyle = dsGradient
    ShowCaptions = True
    TabOrder = 0
    Transparent = False
    Wrapable = False
    OnResize = ToolBarResize
    object ButtonCharLow: TToolButton
      Left = 0
      Top = 0
      Action = ActionCharLow
      Caption = '&Low'
      Grouped = True
    end
    object ButtonCharHigh: TToolButton
      Left = 33
      Top = 0
      Action = ActionCharHigh
      Caption = '&High'
      Grouped = True
    end
    object Separator1: TToolButton
      Left = 66
      Top = 0
      Width = 8
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ButtonCharDec: TToolButton
      Left = 74
      Top = 0
      Action = ActionCharDec
      Caption = 'Dec'
      Grouped = True
    end
    object ButtonCharHex: TToolButton
      Left = 107
      Top = 0
      Action = ActionCharHex
      Caption = 'Hex'
      Grouped = True
    end
    object Separator2: TToolButton
      Left = 140
      Top = 0
      Width = 8
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ComboBoxFontName: TComboBox
      Left = 148
      Top = 0
      Width = 116
      Height = 23
      Hint = 'Character Font'
      Style = csDropDownList
      DropDownCount = 20
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = ComboBoxFontNameChange
      OnEnter = ComboBoxFontNameEnter
    end
    object EditFontSize: TEdit
      Left = 264
      Top = 0
      Width = 25
      Height = 23
      MaxLength = 2
      TabOrder = 1
      Text = '9'
      OnChange = EditFontSizeChange
    end
    object ButtonsFontSize: TUpDown
      Left = 289
      Top = 0
      Width = 15
      Height = 23
      Associate = EditFontSize
      Min = 6
      Max = 20
      Position = 9
      TabOrder = 2
    end
    object EditChars: TEdit
      Left = 319
      Top = 0
      Width = 157
      Height = 23
      TabOrder = 3
    end
  end
  object Actions: TActionList
    Left = 128
    Top = 40
    object ActionCharLow: TAction
      Category = 'HighLow'
      Caption = 'Show Characters &0-127'
      Checked = True
      GroupIndex = 2
      ImageIndex = 3
      OnExecute = ActionCharLowExecute
      OnUpdate = ActionCharLowUpdate
    end
    object ActionCharHigh: TAction
      Category = 'HighLow'
      Caption = 'Show Characters &128-255'
      GroupIndex = 2
      ImageIndex = 2
      OnExecute = ActionCharHighExecute
      OnUpdate = ActionCharHighUpdate
    end
    object ActionCharDec: TAction
      Category = 'HexDec'
      Caption = 'Character Values as &Decimal'
      Checked = True
      GroupIndex = 1
      ImageIndex = 0
      OnExecute = ActionCharDecExecute
      OnUpdate = ActionCharDecUpdate
    end
    object ActionCharHex: TAction
      Category = 'HexDec'
      Caption = 'Character Values as &Hexadecimal'
      GroupIndex = 1
      ImageIndex = 1
      OnExecute = ActionCharHexExecute
      OnUpdate = ActionCharHexUpdate
    end
    object ActionFontSize8: TAction
      Category = 'FontSize'
      Caption = 'Font Size: 8'
      OnExecute = ActionFontSize8Execute
      OnUpdate = ActionFontSizeUpdate
    end
    object ActionFontSize10: TAction
      Category = 'FontSize'
      Caption = 'Font Size: 10'
      OnExecute = ActionFontSize10Execute
      OnUpdate = ActionFontSizeUpdate
    end
    object ActionFontSize12: TAction
      Category = 'FontSize'
      Caption = 'Font Size: 12'
      OnExecute = ActionFontSize12Execute
      OnUpdate = ActionFontSizeUpdate
    end
  end
  object PopupMenuContext: TPopupMenu
    AutoPopup = False
    Left = 40
    Top = 40
    object MenuItemShowLowCharacters: TMenuItem
      Action = ActionCharLow
      GroupIndex = 1
      RadioItem = True
    end
    object MenuItemShowHighCharacters: TMenuItem
      Action = ActionCharHigh
      GroupIndex = 1
      RadioItem = True
    end
    object MenuItemSeparator1: TMenuItem
      Caption = '-'
      GroupIndex = 1
    end
    object MenuItemCharAsDec: TMenuItem
      Action = ActionCharDec
      GroupIndex = 2
      RadioItem = True
    end
    object MenuItemCharAsHex: TMenuItem
      Action = ActionCharHex
      GroupIndex = 2
      RadioItem = True
    end
    object MenuItemSeparator2: TMenuItem
      Caption = '-'
      GroupIndex = 2
    end
    object MenuItemFontSize8: TMenuItem
      Tag = 8
      Action = ActionFontSize8
      GroupIndex = 3
      RadioItem = True
    end
    object MenuItemFontSize10: TMenuItem
      Tag = 10
      Action = ActionFontSize10
      GroupIndex = 3
      RadioItem = True
    end
    object MenuItemFontSize12: TMenuItem
      Tag = 12
      Action = ActionFontSize12
      GroupIndex = 3
      RadioItem = True
    end
  end
end
