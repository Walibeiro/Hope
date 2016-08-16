object FormColorPicker: TFormColorPicker
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Color Picker'
  ClientHeight = 216
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  DesignSize = (
    265
    216)
  PixelsPerInch = 96
  TextHeight = 15
  object LabelRed: TLabel
    Left = 186
    Top = 43
    Width = 10
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'R:'
  end
  object LabelColor: TLabel
    Left = 182
    Top = 19
    Width = 75
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Current Color:'
  end
  object LabelGreen: TLabel
    Left = 186
    Top = 71
    Width = 11
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'G:'
  end
  object LabelBlue: TLabel
    Left = 186
    Top = 99
    Width = 10
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'B:'
  end
  object LabelWebColor: TLabel
    Left = 187
    Top = 132
    Width = 59
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Web Color:'
  end
  object SpinEditRed: TSpinEdit
    Left = 203
    Top = 40
    Width = 54
    Height = 24
    Anchors = [akTop, akRight]
    MaxValue = 255
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = SpinEditColorChange
  end
  object SpinEditGreen: TSpinEdit
    Left = 203
    Top = 68
    Width = 54
    Height = 24
    Anchors = [akTop, akRight]
    MaxValue = 255
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnChange = SpinEditColorChange
  end
  object SpinEditBlue: TSpinEdit
    Left = 203
    Top = 96
    Width = 54
    Height = 24
    Anchors = [akTop, akRight]
    MaxValue = 255
    MinValue = 0
    TabOrder = 2
    Value = 0
    OnChange = SpinEditColorChange
  end
  object EditColor: TEdit
    Left = 186
    Top = 148
    Width = 71
    Height = 23
    Alignment = taCenter
    Anchors = [akTop, akRight]
    TabOrder = 3
    Text = '#000000'
    OnChange = EditColorChange
    OnKeyPress = EditColorKeyPress
  end
  object ButtonCopy: TButton
    Left = 135
    Top = 183
    Width = 122
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Copy to clipboard'
    TabOrder = 4
    OnClick = ButtonCopyClick
  end
  object ColorPickerGTK: TColorPickerGTK
    Left = 8
    Top = 8
    Width = 161
    Height = 161
    ParentBackground = False
    SelectedColor = -16777216
    TabOrder = 5
    OnChanged = ColorPickerGTKChanged
  end
  object ButtonPickColor: TButton
    Left = 8
    Top = 183
    Width = 121
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&Pick from screen'
    TabOrder = 6
    OnClick = ButtonPickColorClick
  end
end
