inherited FormProjectOptions: TFormProjectOptions
  Caption = 'Project Options'
  ClientHeight = 520
  ClientWidth = 791
  DesignSize = (
    791
    520)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel: TBevel [0]
    Left = 251
    Top = 479
    Width = 532
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  inherited ButtonOK: TButton
    Left = 546
    Top = 487
  end
  inherited ButtonCancel: TButton
    Left = 627
    Top = 487
  end
  inherited ButtonHelp: TButton
    Left = 708
    Top = 487
  end
  object TreeCategory: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 233
    Height = 473
    Anchors = [akLeft, akTop, akBottom]
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    Images = DataModuleCommon.ImageList16
    StateImages = DataModuleCommon.ImageList16
    TabOrder = 3
    OnChange = TreeCategoryChange
    OnGetText = TreeCategoryGetText
    OnGetImageIndex = TreeCategoryGetImageIndex
    OnIncrementalSearch = TreeCategoryIncrementalSearch
    Columns = <>
  end
  object PageControl: TPageControl
    Left = 247
    Top = 8
    Width = 536
    Height = 471
    ActivePage = TabSheetCodeGenJS
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = tsButtons
    TabOrder = 4
    object TabSheetProject: TTabSheet
      Caption = 'Project'
      object GroupBoxAuthor: TGroupBox
        Left = 0
        Top = 196
        Width = 528
        Height = 133
        Align = alTop
        Caption = 'Author'
        TabOrder = 0
        object LabelAuthorName: TLabel
          Left = 14
          Top = 30
          Width = 35
          Height = 15
          Caption = 'Name:'
        end
        object LabelEmail: TLabel
          Left = 14
          Top = 59
          Width = 32
          Height = 15
          Caption = 'Email:'
        end
        object LabelWebsite: TLabel
          Left = 14
          Top = 88
          Width = 45
          Height = 15
          Caption = 'Website:'
        end
        object EditAuthorEmail: TEdit
          Left = 96
          Top = 56
          Width = 417
          Height = 23
          TabOrder = 0
        end
        object EditAuthorName: TEdit
          Left = 96
          Top = 27
          Width = 417
          Height = 23
          TabOrder = 1
        end
        object EditAuthorWebsite: TEdit
          Left = 96
          Top = 85
          Width = 417
          Height = 23
          TabOrder = 2
        end
      end
      object GroupBoxInformation: TGroupBox
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 528
        Height = 188
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 8
        Align = alTop
        Caption = 'Project Information'
        TabOrder = 1
        object LabelName: TLabel
          Left = 14
          Top = 30
          Width = 35
          Height = 15
          Caption = 'Name:'
        end
        object LabelDescription: TLabel
          Left = 14
          Top = 59
          Width = 63
          Height = 15
          Caption = 'Description:'
        end
        object MemoDescription: TMemo
          Left = 96
          Top = 56
          Width = 417
          Height = 121
          TabOrder = 0
        end
        object EditProjectName: TEdit
          Left = 96
          Top = 27
          Width = 417
          Height = 23
          TabOrder = 1
        end
      end
    end
    object TabSheetCompiler: TTabSheet
      Caption = 'Compiler'
      ImageIndex = 1
      object LabelHintLevel: TLabel
        Left = 16
        Top = 81
        Width = 53
        Height = 15
        Caption = 'Hint Level'
      end
      object CheckBoxAssertions: TCheckBox
        Left = 16
        Top = 16
        Width = 81
        Height = 17
        Caption = 'Assertions'
        TabOrder = 0
      end
      object CheckBoxOptimizations: TCheckBox
        Left = 16
        Top = 39
        Width = 105
        Height = 17
        Caption = 'Optimizations'
        TabOrder = 1
      end
      object ComboBoxHintLevel: TComboBox
        Left = 120
        Top = 78
        Width = 145
        Height = 23
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 2
        Text = 'Normal'
        Items.Strings = (
          'Disabled'
          'Normal'
          'Strict'
          'Pedantic')
      end
    end
    object TabSheetCodeGenJS: TTabSheet
      Caption = 'JavaScript CodeGen'
      ImageIndex = 7
      object LabelMainBodyName: TLabel
        Left = 24
        Top = 238
        Width = 95
        Height = 15
        Caption = 'Main Body Name:'
      end
      object LabelVerbosity: TLabel
        Left = 24
        Top = 297
        Width = 52
        Height = 15
        Caption = 'Verbosity:'
      end
      object LabelIndentSize: TLabel
        Left = 24
        Top = 267
        Width = 57
        Height = 15
        Caption = 'Indent Size'
      end
      object CheckBoxObfuscation: TCheckBox
        Left = 24
        Top = 200
        Width = 196
        Height = 17
        Caption = 'Obfuscation'
        TabOrder = 0
      end
      object CheckBoxInlineMagic: TCheckBox
        Left = 24
        Top = 16
        Width = 196
        Height = 17
        Caption = 'Inline Magic'
        TabOrder = 1
      end
      object CheckBoxIgnorePublished: TCheckBox
        Left = 24
        Top = 108
        Width = 196
        Height = 17
        Caption = 'Ignore Published'
        TabOrder = 2
      end
      object GroupBoxChecks: TGroupBox
        Left = 304
        Top = 16
        Width = 161
        Height = 129
        Caption = 'Checks'
        TabOrder = 3
        object CheckBoxRangeChecks: TCheckBox
          Left = 19
          Top = 27
          Width = 126
          Height = 17
          Caption = 'Range Checks'
          TabOrder = 0
        end
        object CheckBoxInstanceChecks: TCheckBox
          Left = 19
          Top = 50
          Width = 126
          Height = 17
          Caption = 'Instance Checks'
          TabOrder = 1
        end
        object CheckBoxConditionChecks: TCheckBox
          Left = 19
          Top = 73
          Width = 126
          Height = 17
          Caption = 'Condition Checks'
          TabOrder = 2
        end
        object CheckBoxLoopChecks: TCheckBox
          Left = 19
          Top = 96
          Width = 126
          Height = 17
          Caption = 'Loop Checks'
          TabOrder = 3
        end
      end
      object CheckBoxDevirtualize: TCheckBox
        Left = 24
        Top = 131
        Width = 196
        Height = 17
        Caption = 'Devirtualize'
        TabOrder = 4
      end
      object CheckBoxEmitRTTI: TCheckBox
        Left = 24
        Top = 62
        Width = 196
        Height = 17
        Caption = 'Emit RTTI'
        TabOrder = 5
      end
      object CheckBoxEmitSourceLocation: TCheckBox
        Left = 24
        Top = 39
        Width = 196
        Height = 17
        Caption = 'Emit Source Location'
        TabOrder = 6
      end
      object CheckBoxOptimizeForSize: TCheckBox
        Left = 24
        Top = 177
        Width = 196
        Height = 17
        Caption = 'Optimize for Size'
        TabOrder = 7
      end
      object CheckBoxSmartLinking: TCheckBox
        Left = 24
        Top = 154
        Width = 196
        Height = 17
        Caption = 'Smart Linking'
        TabOrder = 8
      end
      object EditMainBodyName: TEdit
        Left = 149
        Top = 235
        Width = 148
        Height = 23
        TabOrder = 9
      end
      object ComboBoxVerbosity: TComboBox
        Left = 149
        Top = 294
        Width = 148
        Height = 23
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 10
        Text = 'Normal'
        Items.Strings = (
          'None'
          'Normal'
          'Verbose')
      end
      object SpinEditIndentSize: TSpinEdit
        Left = 149
        Top = 264
        Width = 52
        Height = 24
        MaxValue = 0
        MinValue = 0
        TabOrder = 11
        Value = 2
      end
      object CheckBoxEmitFinalization: TCheckBox
        Left = 24
        Top = 85
        Width = 196
        Height = 17
        Caption = 'Emit Finalization'
        TabOrder = 12
      end
    end
    object TabSheetCompilerLinker: TTabSheet
      Caption = 'Linker'
      ImageIndex = 2
    end
    object TabSheetExecution: TTabSheet
      Caption = 'Execution'
      ImageIndex = 3
    end
    object TabSheetFilter: TTabSheet
      Caption = 'Filter'
      ImageIndex = 4
    end
    object TabSheetIcon: TTabSheet
      Caption = 'Icon'
      ImageIndex = 5
    end
    object TabSheetVersion: TTabSheet
      Caption = 'Version'
      ImageIndex = 6
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 528
        Height = 105
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 8
        Align = alTop
        Caption = 'Version'
        TabOrder = 0
        object LabelVersionMajor: TLabel
          Left = 14
          Top = 30
          Width = 34
          Height = 15
          Caption = 'Major:'
        end
        object Label1: TLabel
          Left = 126
          Top = 30
          Width = 35
          Height = 15
          Caption = 'Minor:'
        end
        object Label2: TLabel
          Left = 246
          Top = 30
          Width = 42
          Height = 15
          Caption = 'Release:'
        end
        object Label3: TLabel
          Left = 374
          Top = 30
          Width = 30
          Height = 15
          Caption = 'Build:'
        end
        object LabelFullVersionNumber: TLabel
          Left = 16
          Top = 70
          Width = 111
          Height = 15
          Caption = 'Full Version Number:'
        end
        object LabelFullVersionNumberValue: TLabel
          Left = 133
          Top = 70
          Width = 33
          Height = 15
          Caption = '0.0.0.0'
        end
        object SpinEditVersionMajor: TSpinEdit
          Left = 64
          Top = 27
          Width = 49
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = SpinEditVersionMajorChange
        end
        object SpinEditVersionMinor: TSpinEdit
          Left = 176
          Top = 27
          Width = 49
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = SpinEditVersionMinorChange
        end
        object SpinEditVersionRelease: TSpinEdit
          Left = 296
          Top = 27
          Width = 49
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = SpinEditVersionReleaseChange
        end
        object SpinEditVersionBuild: TSpinEdit
          Left = 424
          Top = 27
          Width = 49
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = SpinEditVersionBuildChange
        end
        object CheckBoxAutoIncrement: TCheckBox
          Left = 312
          Top = 70
          Width = 153
          Height = 17
          Caption = 'Auto Increment Build'
          TabOrder = 4
        end
      end
    end
  end
end
