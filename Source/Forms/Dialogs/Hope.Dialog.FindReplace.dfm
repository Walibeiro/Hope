inherited FormFindReplace: TFormFindReplace
  Caption = 'Find'
  ClientHeight = 232
  ClientWidth = 512
  DesignSize = (
    512
    232)
  PixelsPerInch = 96
  TextHeight = 15
  object LabelSearch: TLabel [0]
    Left = 8
    Top = 11
    Width = 38
    Height = 15
    Caption = 'Search:'
    FocusControl = ComboBoxSearchText
  end
  inherited ButtonOK: TButton
    Left = 267
    Top = 199
    TabOrder = 10
    OnClick = ButtonOKClick
  end
  inherited ButtonCancel: TButton
    Left = 348
    Top = 199
    TabOrder = 11
    OnClick = ButtonCancelClick
  end
  inherited ButtonHelp: TButton
    Left = 429
    Top = 199
    TabOrder = 12
  end
  object ComboBoxSearchText: TComboBox
    Left = 88
    Top = 8
    Width = 387
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object ComboBoxReplaceText: TComboBox
    Left = 88
    Top = 37
    Width = 387
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object ButtonPresetSearch: TButton
    Left = 481
    Top = 8
    Width = 23
    Height = 23
    Anchors = [akTop, akRight]
    Caption = '?'
    TabOrder = 1
  end
  object ButtonPresetReplace: TButton
    Left = 481
    Top = 37
    Width = 23
    Height = 23
    Anchors = [akTop, akRight]
    Caption = '?'
    TabOrder = 3
  end
  object GroupBoxSearchOptions: TGroupBox
    Left = 8
    Top = 72
    Width = 193
    Height = 121
    Caption = 'Search Options'
    TabOrder = 5
    DesignSize = (
      193
      121)
    object CheckBoxCaseSensitivity: TCheckBox
      Left = 16
      Top = 24
      Width = 160
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Case Sensiti&ve'
      TabOrder = 0
    end
    object CheckBoxWholeWordOnly: TCheckBox
      Left = 16
      Top = 47
      Width = 160
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Whole Words Only'
      TabOrder = 1
    end
    object CheckBoxPromptEachReplace: TCheckBox
      Left = 16
      Top = 70
      Width = 160
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Promt Each Replace'
      TabOrder = 2
    end
    object CheckBoxRegularExpressions: TCheckBox
      Left = 16
      Top = 93
      Width = 160
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Regular E&xpressions'
      TabOrder = 3
    end
  end
  object GroupBoxDirection: TGroupBox
    Left = 207
    Top = 72
    Width = 146
    Height = 121
    Caption = 'Direction'
    TabOrder = 6
    DesignSize = (
      146
      121)
    object RadioButtonBackward: TRadioButton
      Left = 16
      Top = 47
      Width = 113
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Backward'
      TabOrder = 0
    end
    object RadioButtonEntireScope: TRadioButton
      Left = 16
      Top = 70
      Width = 113
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Entire Scope'
      TabOrder = 1
    end
    object RadioButtonForward: TRadioButton
      Left = 17
      Top = 24
      Width = 113
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Forward'
      TabOrder = 2
    end
  end
  object GroupBoxScope: TGroupBox
    Left = 359
    Top = 72
    Width = 146
    Height = 121
    Caption = 'Scope'
    TabOrder = 7
    DesignSize = (
      146
      121)
    object RadioButtonGlobal: TRadioButton
      Left = 16
      Top = 24
      Width = 113
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Global'
      TabOrder = 0
    end
    object RadioButtonSelectedText: TRadioButton
      Left = 16
      Top = 47
      Width = 113
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Caption = '&Selected Text'
      TabOrder = 1
    end
  end
  object CheckBoxTransparency: TCheckBox
    Left = 24
    Top = 203
    Width = 105
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = '&Transparency'
    TabOrder = 8
  end
  object CheckBoxReplace: TCheckBox
    Left = 8
    Top = 40
    Width = 65
    Height = 17
    Caption = 'Replace:'
    TabOrder = 4
    OnClick = CheckBoxReplaceClick
  end
  object ButtonReplaceAll: TButton
    Left = 168
    Top = 199
    Width = 93
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Replace All'
    ModalResult = 1
    TabOrder = 9
    Visible = False
    OnClick = ButtonReplaceAllClick
  end
end
