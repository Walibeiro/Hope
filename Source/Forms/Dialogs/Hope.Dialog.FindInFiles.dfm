inherited FormFindInFiles: TFormFindInFiles
  Caption = 'Find in Files'
  ClientHeight = 425
  ClientWidth = 574
  PixelsPerInch = 96
  TextHeight = 15
  inherited ButtonOK: TButton
    Left = 329
    Top = 392
  end
  inherited ButtonCancel: TButton
    Left = 410
    Top = 392
  end
  inherited ButtonHelp: TButton
    Left = 491
    Top = 392
  end
  object GroupBoxText: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 558
    Height = 113
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 4
    Align = alTop
    Caption = 'Text'
    TabOrder = 3
    DesignSize = (
      558
      113)
    object LabelSearchText: TLabel
      Left = 16
      Top = 24
      Width = 63
      Height = 15
      Caption = '&Search Text:'
    end
    object ComboBoxSearchText: TComboBox
      Left = 136
      Top = 21
      Width = 406
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object ComboBoxReplaceText: TComboBox
      Left = 136
      Top = 48
      Width = 406
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object CheckBoxReplaceText: TCheckBox
      Left = 16
      Top = 51
      Width = 98
      Height = 13
      Margins.Bottom = 0
      Caption = '&Replace with:'
      TabOrder = 2
    end
    object CheckBoxCaseInsensitivity: TCheckBox
      Left = 16
      Top = 83
      Width = 129
      Height = 12
      Margins.Bottom = 0
      Caption = '&Case-sensitive'
      TabOrder = 3
    end
    object CheckBoxWholeWords: TCheckBox
      Left = 286
      Top = 83
      Width = 129
      Height = 12
      Margins.Bottom = 0
      Caption = 'Only Whole Words'
      TabOrder = 4
      Visible = False
    end
    object CheckBoxRegularExpression: TCheckBox
      Left = 151
      Top = 83
      Width = 129
      Height = 12
      Margins.Bottom = 0
      Caption = 'Regular Expression'
      TabOrder = 5
      Visible = False
    end
    object CheckBoxConfirmReplace: TCheckBox
      Left = 421
      Top = 83
      Width = 129
      Height = 12
      Margins.Bottom = 0
      Caption = 'Confirm Replace'
      TabOrder = 6
      Visible = False
    end
  end
  object GroupBoxSearchContext: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 201
    Width = 558
    Height = 113
    Margins.Left = 8
    Margins.Top = 4
    Margins.Right = 8
    Margins.Bottom = 4
    Align = alTop
    Caption = 'Options for directory search'
    TabOrder = 4
    DesignSize = (
      558
      113)
    object LabelDirectory: TLabel
      Left = 16
      Top = 24
      Width = 51
      Height = 15
      Caption = 'Directory:'
    end
    object LabelFileType: TLabel
      Left = 16
      Top = 51
      Width = 52
      Height = 15
      Caption = 'File Mask:'
    end
    object ComboBoxDirectory: TComboBox
      Left = 120
      Top = 21
      Width = 393
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object ComboBoxFileType: TComboBox
      Left = 120
      Top = 48
      Width = 393
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      Text = '*.pas; *.hpr; *.inc'
      Items.Strings = (
        '*.pas; *.dpr; *.inc'
        '*.pas'
        '*.txt'
        '*.dpr'
        '*.inc')
    end
    object ButtonSelectDirectory: TButton
      Left = 519
      Top = 21
      Width = 23
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 2
    end
    object CheckboxSubdirectories: TCheckBox
      Left = 16
      Top = 82
      Width = 137
      Height = 13
      Margins.Bottom = 0
      Caption = 'Include Subdirectories'
      TabOrder = 3
    end
  end
  object GroupBoxScope: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 129
    Width = 558
    Height = 64
    Margins.Left = 8
    Margins.Top = 4
    Margins.Right = 8
    Margins.Bottom = 4
    Align = alTop
    Caption = 'Scope'
    TabOrder = 5
    object RadioButtonProjectFiles: TRadioButton
      Left = 16
      Top = 32
      Width = 113
      Height = 17
      Caption = 'All Project Files'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButtonEditorFiles: TRadioButton
      Left = 151
      Top = 32
      Width = 113
      Height = 17
      Caption = 'All Editor Files'
      TabOrder = 1
    end
    object RadioButtonDirectory: TRadioButton
      Left = 418
      Top = 32
      Width = 113
      Height = 17
      Caption = 'Specific Directory'
      TabOrder = 2
    end
    object RadioButtonProjectGroups: TRadioButton
      Left = 283
      Top = 32
      Width = 113
      Height = 17
      Caption = 'All Project Groups'
      TabOrder = 3
    end
  end
  object GroupBoxOutput: TGroupBox
    AlignWithMargins = True
    Left = 8
    Top = 322
    Width = 558
    Height = 61
    Margins.Left = 8
    Margins.Top = 4
    Margins.Right = 8
    Margins.Bottom = 4
    Align = alTop
    Caption = 'Output'
    TabOrder = 6
    object CheckBoxSeparateRegister: TCheckBox
      Left = 16
      Top = 26
      Width = 177
      Height = 12
      Margins.Bottom = 0
      Caption = '&Show on separate register'
      TabOrder = 0
    end
    object CheckBoxGroupFiles: TCheckBox
      Left = 207
      Top = 26
      Width = 129
      Height = 12
      Margins.Bottom = 0
      Caption = '&Group files'
      TabOrder = 1
    end
  end
end
