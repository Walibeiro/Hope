inherited FormPreferences: TFormPreferences
  Caption = 'Preferences'
  ClientHeight = 533
  ClientWidth = 742
  Constraints.MinHeight = 560
  Constraints.MinWidth = 750
  OnClose = FormClose
  DesignSize = (
    742
    533)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel: TBevel [0]
    Left = 251
    Top = 492
    Width = 483
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  inherited ButtonOK: TButton
    Left = 497
    Top = 500
  end
  inherited ButtonCancel: TButton
    Left = 578
    Top = 500
  end
  inherited ButtonHelp: TButton
    Left = 659
    Top = 500
  end
  object TreeCategory: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 233
    Height = 486
    Anchors = [akLeft, akTop, akBottom]
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    Images = DataModuleImageLists.ImageList16
    StateImages = DataModuleImageLists.ImageList16
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
    Width = 487
    Height = 484
    ActivePage = TabSheetAppearance
    Anchors = [akLeft, akTop, akRight, akBottom]
    Images = DataModuleImageLists.ImageList16
    MultiLine = True
    Style = tsButtons
    TabOrder = 4
    object TabSheetEnvironment: TTabSheet
      Caption = 'Environment Options'
      ImageIndex = 35
      object GroupBoxPaths: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 473
        Height = 118
        Align = alTop
        Caption = 'Paths'
        TabOrder = 0
        DesignSize = (
          473
          118)
        object LabelProjectPath: TLabel
          Left = 16
          Top = 27
          Width = 108
          Height = 15
          Caption = 'Default Project Path:'
        end
        object ComboBoxProjectPath: TComboBox
          Left = 160
          Top = 24
          Width = 273
          Height = 23
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object ButtonProjectPath: TButton
          Left = 439
          Top = 24
          Width = 23
          Height = 23
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 1
          OnClick = ButtonProjectPathClick
        end
      end
    end
    object TabSheetDesigner: TTabSheet
      Caption = 'Designer'
      ImageIndex = 35
    end
    object TabSheetRecentFiles: TTabSheet
      Caption = 'Recent Files'
      ImageIndex = 35
      object GroupBoxCapacity: TGroupBox
        Left = 0
        Top = 0
        Width = 479
        Height = 69
        Align = alTop
        Caption = 'Capacity'
        TabOrder = 0
        DesignSize = (
          479
          69)
        object LabelProjectCount: TLabel
          Left = 16
          Top = 32
          Width = 106
          Height = 15
          Caption = 'Number of Projects:'
        end
        object LabelUnitCount: TLabel
          Left = 296
          Top = 32
          Width = 85
          Height = 15
          Anchors = [akTop, akRight]
          Caption = 'Number of files:'
        end
        object SpinEditProjectCount: TSpinEdit
          Left = 136
          Top = 29
          Width = 65
          Height = 24
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 10
        end
        object SpinEditUnitCOunt: TSpinEdit
          Left = 395
          Top = 29
          Width = 65
          Height = 24
          Anchors = [akTop, akRight]
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 10
        end
      end
      object GroupBoxItems: TGroupBox
        Left = 0
        Top = 69
        Width = 479
        Height = 330
        Align = alClient
        Caption = 'Recent Items'
        TabOrder = 1
        DesignSize = (
          479
          330)
        object ButtonRemoveInvalid: TButton
          Left = 16
          Top = 289
          Width = 161
          Height = 25
          Action = ActionDeleteNonexistingFiles
          Anchors = [akLeft, akBottom]
          TabOrder = 0
        end
        object Button1: TButton
          Left = 286
          Top = 289
          Width = 84
          Height = 25
          Action = ActionDelete
          Anchors = [akRight, akBottom]
          TabOrder = 1
        end
        object ButtonClear: TButton
          Left = 376
          Top = 289
          Width = 84
          Height = 25
          Action = ActionClear
          Anchors = [akRight, akBottom]
          TabOrder = 2
        end
        object TreeItems: TVirtualStringTree
          Left = 16
          Top = 21
          Width = 444
          Height = 262
          Anchors = [akLeft, akTop, akRight, akBottom]
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'Tahoma'
          Header.Font.Style = []
          Header.MainColumn = -1
          Indent = 0
          TabOrder = 3
          TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
          TreeOptions.PaintOptions = [toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toFullRowSelect]
          OnCollapsing = TreeItemsCollapsing
          OnDrawText = TreeItemsDrawText
          OnFreeNode = TreeItemsFreeNode
          OnGetText = TreeItemsGetText
          Columns = <>
        end
      end
    end
    object TabSheetLibraryPaths: TTabSheet
      Caption = 'Paths'
      ImageIndex = 35
      object GroupBoxLibraryPaths: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 473
        Height = 393
        Align = alClient
        Caption = 'Library Paths'
        TabOrder = 0
        DesignSize = (
          473
          393)
        object ListBoxLibraryPaths: TListBox
          Left = 16
          Top = 24
          Width = 411
          Height = 299
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 15
          TabOrder = 0
        end
        object ButtonReplace: TButton
          Left = 16
          Top = 359
          Width = 65
          Height = 25
          Action = ActionLibraryPathReplace
          Anchors = [akLeft, akBottom]
          TabOrder = 1
        end
        object ButtonAdd: TButton
          Left = 87
          Top = 359
          Width = 65
          Height = 25
          Action = ActionLibraryPathAdd
          Anchors = [akLeft, akBottom]
          ImageAlignment = iaBottom
          TabOrder = 2
        end
        object ButtonDelete: TButton
          Left = 158
          Top = 359
          Width = 65
          Height = 25
          Action = ActionLibraryPathDelete
          Anchors = [akLeft, akBottom]
          TabOrder = 3
        end
        object ButtonCleanUp: TButton
          Left = 232
          Top = 359
          Width = 226
          Height = 25
          Action = ActionLibraryPathCleanUp
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 4
        end
        object ButtonPick: TButton
          Left = 433
          Top = 328
          Width = 25
          Height = 25
          Action = ActionLibraryPathPick
          Anchors = [akRight, akBottom]
          TabOrder = 5
        end
        object EditPath: TEdit
          Left = 16
          Top = 329
          Width = 411
          Height = 23
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 6
        end
        object ButtonUp: TButton
          Left = 432
          Top = 144
          Width = 25
          Height = 25
          Action = ActionLibraryPathUp
          Anchors = [akRight]
          ImageAlignment = iaCenter
          TabOrder = 7
        end
        object ButtonDown: TButton
          Left = 432
          Top = 182
          Width = 25
          Height = 25
          Action = ActionLibraryPathDown
          Anchors = [akRight]
          ImageAlignment = iaCenter
          TabOrder = 8
        end
      end
    end
    object TabSheetEditorOptions: TTabSheet
      Caption = 'Editor Options'
      ImageIndex = 35
      object GroupBoxOptions: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 473
        Height = 254
        Align = alTop
        Caption = 'Options'
        TabOrder = 0
        DesignSize = (
          473
          254)
        object CheckBoxAutoIndent: TCheckBox
          Left = 9
          Top = 19
          Width = 191
          Height = 17
          Hint = 
            'Will indent the caret on new lines with the same amount of leadi' +
            'ng white space as the preceding line'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Auto indent'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object CheckBoxDragAndDropEditing: TCheckBox
          Left = 9
          Top = 57
          Width = 191
          Height = 17
          Hint = 
            'Allows you to select a block of text and drag it within the docu' +
            'ment to another location'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Drag and drop editing'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object CheckBoxAutoSizeMaxWidth: TCheckBox
          Left = 9
          Top = 38
          Width = 191
          Height = 17
          Hint = 'Allows the editor accept OLE file drops'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Auto size scroll width'
          TabOrder = 1
        end
        object CheckBoxHalfPageScroll: TCheckBox
          Left = 256
          Top = 19
          Width = 191
          Height = 17
          Hint = 
            'When scrolling with page-up and page-down commands, only scroll ' +
            'a half page at a time'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Half page scroll'
          TabOrder = 12
        end
        object CheckBoxEnhanceEndKey: TCheckBox
          Left = 9
          Top = 190
          Width = 191
          Height = 17
          Hint = 'Makes it so the caret is never visible'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Enhance End Key'
          Checked = True
          State = cbChecked
          TabOrder = 9
        end
        object CheckBoxScrollByOneLess: TCheckBox
          Left = 256
          Top = 38
          Width = 191
          Height = 17
          Hint = 'Forces scrolling to be one less'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Scroll by one less'
          TabOrder = 13
        end
        object CheckBoxScrollPastEOF: TCheckBox
          Left = 256
          Top = 57
          Width = 191
          Height = 17
          Hint = 'Allows the cursor to go past the end of file marker'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Scroll past end of file'
          Checked = True
          State = cbChecked
          TabOrder = 14
        end
        object CheckBoxScrollPastEOL: TCheckBox
          Left = 256
          Top = 76
          Width = 191
          Height = 17
          Hint = 
            'Allows the cursor to go past the last character into the white s' +
            'pace at the end of a line'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Scroll past end of line'
          Checked = True
          State = cbChecked
          TabOrder = 15
        end
        object CheckBoxShowScrollHint: TCheckBox
          Left = 256
          Top = 95
          Width = 191
          Height = 17
          Hint = 
            'Shows a hint of the visible line numbers when scrolling vertical' +
            'ly'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Show scroll hint'
          Checked = True
          State = cbChecked
          TabOrder = 16
        end
        object CheckBoxSmartTabs: TCheckBox
          Left = 9
          Top = 133
          Width = 191
          Height = 17
          Hint = 
            'When tabbing, the cursor will go to the next non-white space cha' +
            'racter of the previous line'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Smart tabs'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
        object CheckBoxTabsToSpaces: TCheckBox
          Left = 256
          Top = 152
          Width = 191
          Height = 17
          Hint = 'Converts a tab character to the number of spaces in Tab Width'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Tabs to spaces'
          Checked = True
          State = cbChecked
          TabOrder = 18
        end
        object CheckBoxTrimTrailingSpaces: TCheckBox
          Left = 256
          Top = 171
          Width = 191
          Height = 17
          Hint = 'Spaces at the end of lines will be trimmed and not saved'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Trim trailing spaces'
          Checked = True
          State = cbChecked
          TabOrder = 19
        end
        object CheckBoxWantTabs: TCheckBox
          Left = 9
          Top = 114
          Width = 191
          Height = 17
          Hint = 
            'Let the editor accept tab characters instead of going to the nex' +
            't control'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Want tabs'
          TabOrder = 5
        end
        object CheckBoxAltSetsColumnMode: TCheckBox
          Left = 9
          Top = 76
          Width = 191
          Height = 17
          Hint = 
            'Holding down the Alt Key will put the selection mode into column' +
            'ar format'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Alt sets column mode'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object CheckBoxKeepCaretX: TCheckBox
          Left = 9
          Top = 95
          Width = 191
          Height = 17
          Hint = 
            'When moving through lines the X position will always stay the sa' +
            'me'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Maintain caret column'
          TabOrder = 4
        end
        object CheckBoxScrollHintFollows: TCheckBox
          Left = 256
          Top = 114
          Width = 191
          Height = 17
          Hint = 'The scroll hint follows the mouse when scrolling vertically'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Scroll hint follows mouse'
          TabOrder = 17
        end
        object CheckBoxGroupUndo: TCheckBox
          Left = 257
          Top = 190
          Width = 191
          Height = 17
          Hint = 
            'When undoing/redoing actions, handle all continous changes of th' +
            'e same kind in one call instead undoing/redoing each command sep' +
            'arately'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Group undo'
          Checked = True
          State = cbChecked
          TabOrder = 20
        end
        object CheckBoxSmartTabDelete: TCheckBox
          Left = 9
          Top = 152
          Width = 191
          Height = 17
          Hint = 'similar to Smart Tabs, but when you delete characters'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Smart tab delete'
          Checked = True
          State = cbChecked
          TabOrder = 7
        end
        object CheckBoxRightMouseMoves: TCheckBox
          Left = 257
          Top = 209
          Width = 191
          Height = 17
          Hint = 
            'When clicking with the right mouse for a popup menu, move the cu' +
            'rsor to that location'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Right mouse moves cursor'
          Checked = True
          State = cbChecked
          TabOrder = 21
        end
        object CheckBoxEnhanceHomeKey: TCheckBox
          Left = 9
          Top = 171
          Width = 191
          Height = 17
          Hint = 'enhances home key positioning, similar to visual studio'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Enhance Home Key'
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
        object CheckBoxHideShowScrollbars: TCheckBox
          Left = 9
          Top = 209
          Width = 191
          Height = 17
          Hint = 
            'if enabled, then the scrollbars will only show when necessary.  ' +
            'If you have ScrollPastEOL, then it the horizontal bar will alway' +
            's be there (it uses MaxLength instead)'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Hide scrollbars as necessary'
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
        object CheckBoxDisableScrollArrows: TCheckBox
          Left = 9
          Top = 228
          Width = 191
          Height = 17
          Hint = 
            'Disables the scroll bar arrow buttons when you can'#39't scroll in t' +
            'hat direction any more'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Disable scroll arrows'
          Checked = True
          State = cbChecked
          TabOrder = 11
        end
        object CheckBoxShowSpecialChars: TCheckBox
          Left = 257
          Top = 228
          Width = 192
          Height = 17
          Hint = 'Shows linebreaks, spaces and tabs using special symbols'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Show special chars'
          TabOrder = 22
        end
        object CheckBoxTabIndent: TCheckBox
          Left = 256
          Top = 133
          Width = 191
          Height = 17
          Hint = 'Use tab to indent the code'
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Tab indent'
          Checked = True
          State = cbChecked
          TabOrder = 23
        end
      end
      object GroupBoxCaret: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 263
        Width = 473
        Height = 81
        Align = alTop
        Caption = 'Caret'
        TabOrder = 1
        object LabelInsertCaret: TLabel
          Left = 16
          Top = 21
          Width = 61
          Height = 15
          Caption = 'Insert caret:'
        end
        object LabelOverwriteCaret: TLabel
          Left = 16
          Top = 49
          Width = 83
          Height = 15
          Caption = 'Overwrite caret:'
        end
        object ComboBoxInsertCaret: TComboBox
          Left = 120
          Top = 18
          Width = 186
          Height = 23
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = 'Vertical Line'
          Items.Strings = (
            'Vertical Line'
            'Vertical Line 2'
            'Horizontal Line'
            'Half Block'
            'Block')
        end
        object ComboBoxOverwriteCaret: TComboBox
          Left = 120
          Top = 46
          Width = 186
          Height = 23
          Style = csDropDownList
          ItemIndex = 4
          TabOrder = 1
          Text = 'Block'
          Items.Strings = (
            'Vertical Line'
            'Vertical Line 2'
            'Horizontal Line'
            'Half Block'
            'Block')
        end
      end
    end
    object TabSheetHighlighterOptions: TTabSheet
      Caption = 'Highlighter Options'
      ImageIndex = 35
      object GroupBoxPreview: TGroupBox
        AlignWithMargins = True
        Left = 4
        Top = 151
        Width = 471
        Height = 244
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        Caption = 'Preview'
        TabOrder = 0
        object EditorPreview: TSynEdit
          AlignWithMargins = True
          Left = 10
          Top = 25
          Width = 451
          Height = 209
          Margins.Left = 8
          Margins.Top = 8
          Margins.Right = 8
          Margins.Bottom = 8
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          TabOrder = 0
          OnClick = EditorPreviewClick
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Highlighter = SynDWS
          Lines.Strings = (
            '{$DEFINE FOO}'
            'function Foo(Bar: Integer): Float;'
            'var Index: Integer; // Hint: unused variable'
            'begin'
            '  // some bogus calculations'
            '  asm @Bar += 4 end;'
            '  Result := Sqrt(Bar + 1.2) - Bar + 3 + $A;'
            ''
            '  PrintLn('#39'Calculation:'#39' + #10 + '#39'Done!'#39')'
            '  Exit;'
            '  PrintLn('#39'Warning: Unreachable line!'#39');'
            '  Error: Invalid Code!'
            'end;')
          ScrollBars = ssVertical
          OnChange = EditorPreviewChange
          OnCommandProcessed = EditorPreviewCommandProcessed
          OnGutterPaint = EditorPreviewGutterPaint
          OnSpecialLineColors = EditorPreviewSpecialLineColors
          FontSmoothing = fsmNone
        end
      end
      object PanelTop: TPanel
        Left = 0
        Top = 0
        Width = 479
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 1
        object LabelLanguage: TLabel
          Left = 4
          Top = 7
          Width = 55
          Height = 15
          Caption = 'Language:'
        end
        object ComboBoxLanguage: TComboBox
          Left = 80
          Top = 4
          Width = 145
          Height = 23
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = 'DWScript Pascal'
          OnChange = ComboBoxLanguageChange
          Items.Strings = (
            'DWScript Pascal'
            'JavaScript'
            'JSON'
            'HTML'
            'CSS')
        end
        object ButtonLoad: TButton
          Left = 316
          Top = 3
          Width = 78
          Height = 25
          Action = ActionLoad
          ImageMargins.Left = 4
          TabOrder = 1
        end
        object ButtonSave: TButton
          Left = 400
          Top = 3
          Width = 78
          Height = 25
          Action = ActionSave
          ImageMargins.Left = 4
          TabOrder = 2
        end
      end
      object PanelElementSettings: TPanel
        Left = 0
        Top = 33
        Width = 479
        Height = 114
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object GroupBoxSettings: TGroupBox
          AlignWithMargins = True
          Left = 240
          Top = 3
          Width = 236
          Height = 108
          Align = alRight
          Caption = 'Settings'
          TabOrder = 0
          object LabelForeground: TLabel
            Left = 16
            Top = 27
            Width = 65
            Height = 15
            Caption = 'Foreground:'
          end
          object LabelBackground: TLabel
            Left = 16
            Top = 55
            Width = 67
            Height = 15
            Caption = 'Background:'
          end
          object ColorBoxForeground: TColorBox
            Left = 96
            Top = 24
            Width = 129
            Height = 22
            Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbCustomColor, cbCustomColors]
            TabOrder = 0
            OnChange = ColorBoxForegroundChange
            OnGetColors = ColorBoxForegroundGetColors
          end
          object ColorBoxBackground: TColorBox
            Left = 96
            Top = 52
            Width = 129
            Height = 22
            Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbCustomColor, cbCustomColors]
            TabOrder = 1
            OnChange = ColorBoxBackgroundChange
          end
          object CheckBoxBold: TCheckBox
            Left = 16
            Top = 80
            Width = 49
            Height = 17
            Caption = 'Bold'
            TabOrder = 2
            OnClick = CheckBoxBoldClick
          end
          object CheckBoxItalic: TCheckBox
            Left = 80
            Top = 80
            Width = 49
            Height = 17
            Caption = 'Italic'
            TabOrder = 3
            OnClick = CheckBoxItalicClick
          end
          object CheckBoxUnderlined: TCheckBox
            Left = 144
            Top = 80
            Width = 81
            Height = 17
            Caption = 'Underlined'
            TabOrder = 4
            OnClick = CheckBoxUnderlinedClick
          end
        end
        object GroupBoxElement: TGroupBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 229
          Height = 106
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          Caption = 'Element'
          TabOrder = 1
          object LabelElement: TLabel
            AlignWithMargins = True
            Left = 10
            Top = 56
            Width = 209
            Height = 40
            Margins.Left = 8
            Margins.Top = 0
            Margins.Right = 8
            Margins.Bottom = 8
            Align = alClient
            Caption = 
              'Pick the desired element directly from the source code example b' +
              'elow...'
            WordWrap = True
          end
          object ComboBoxElement: TComboBox
            AlignWithMargins = True
            Left = 10
            Top = 25
            Width = 209
            Height = 23
            Margins.Left = 8
            Margins.Top = 8
            Margins.Right = 8
            Margins.Bottom = 8
            Align = alTop
            Style = csDropDownList
            TabOrder = 0
            OnChange = ComboBoxElementChange
          end
        end
      end
    end
    object TabSheetDeployment: TTabSheet
      Caption = 'Deployment'
      ImageIndex = 35
    end
    object TabSheetCodeInsight: TTabSheet
      Caption = 'Code Insight'
      ImageIndex = 35
      object GroupBoxAutomaticFeatures: TGroupBox
        Left = 0
        Top = 0
        Width = 479
        Height = 280
        Align = alTop
        Caption = 'Automatic features'
        TabOrder = 0
        DesignSize = (
          479
          280)
        object LabelDelay: TLabel
          Left = 24
          Top = 184
          Width = 32
          Height = 15
          Anchors = [akLeft, akBottom]
          Caption = '&Delay:'
        end
        object LabelNone: TLabel
          Left = 24
          Top = 241
          Width = 29
          Height = 15
          Anchors = [akLeft, akBottom]
          Caption = 'None'
        end
        object LabelOff: TLabel
          Left = 438
          Top = 241
          Width = 17
          Height = 15
          Anchors = [akRight, akBottom]
          Caption = 'Off'
        end
        object LabelValue: TLabel
          Left = 234
          Top = 237
          Width = 3
          Height = 15
          Alignment = taCenter
          Anchors = [akTop]
        end
        object CheckBoxCodeSuggestions: TCheckBox
          Left = 24
          Top = 32
          Width = 161
          Height = 17
          Caption = 'Code suggestions'
          TabOrder = 0
        end
        object CheckBoxAutoParenthesis: TCheckBox
          Left = 48
          Top = 55
          Width = 137
          Height = 17
          Caption = 'Auto parenthesis'
          TabOrder = 1
        end
        object CheckBoxShowReservedWords: TCheckBox
          Left = 48
          Top = 78
          Width = 137
          Height = 17
          Caption = 'Show reserved words'
          TabOrder = 2
        end
        object CheckBoxCodeParameters: TCheckBox
          Left = 24
          Top = 108
          Width = 161
          Height = 17
          Caption = 'Code parameters'
          TabOrder = 3
        end
        object TrackBarDelay: TTrackBar
          Left = 24
          Top = 206
          Width = 433
          Height = 25
          Anchors = [akLeft, akRight, akBottom]
          Max = 28
          ShowSelRange = False
          TabOrder = 4
          OnChange = TrackBarDelayChange
        end
        object CheckBoxTooltipSymbol: TCheckBox
          Left = 24
          Top = 131
          Width = 161
          Height = 17
          Caption = 'Tooltip symbol insight'
          TabOrder = 5
        end
        object CheckBoxBlockCompletion: TCheckBox
          Left = 288
          Top = 32
          Width = 169
          Height = 17
          Caption = 'Block completion'
          TabOrder = 6
        end
        object ComboBoxBlockCompletion: TComboBox
          Left = 312
          Top = 55
          Width = 153
          Height = 23
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 7
          Text = 'Without new line'
          Items.Strings = (
            'Without new line'
            'With new line'
            'New blocks only')
        end
        object CheckBoxErrorInsight: TCheckBox
          Left = 288
          Top = 108
          Width = 169
          Height = 17
          Caption = 'Error insight'
          TabOrder = 8
        end
        object CheckBoxCodeTemplateCompletion: TCheckBox
          Left = 288
          Top = 131
          Width = 169
          Height = 17
          Caption = 'Code template completion'
          TabOrder = 9
        end
      end
    end
    object TabSheetVersionControl: TTabSheet
      Caption = 'Version Control'
      ImageIndex = 35
      object GroupBoxColors: TGroupBox
        Left = 0
        Top = 0
        Width = 479
        Height = 169
        Align = alTop
        Caption = 'Colors'
        TabOrder = 0
        object LabelConflicts: TLabel
          Left = 16
          Top = 24
          Width = 50
          Height = 15
          Caption = 'Conflicts:'
        end
        object LabelAdded: TLabel
          Left = 16
          Top = 52
          Width = 38
          Height = 15
          Caption = 'Added:'
        end
        object ColorBoxConflicted: TColorBox
          Left = 112
          Top = 21
          Width = 89
          Height = 22
          DefaultColorColor = clRed
          Selected = clRed
          TabOrder = 0
        end
        object ColorBoxAdded: TColorBox
          Left = 112
          Top = 49
          Width = 89
          Height = 22
          DefaultColorColor = clNavy
          Selected = clNavy
          TabOrder = 1
        end
      end
    end
    object TabSheetFormating: TTabSheet
      Caption = 'Formating'
      ImageIndex = 35
      object LabelIndention: TLabel
        Left = 11
        Top = 16
        Width = 110
        Height = 15
        Caption = 'Continuation indent:'
      end
      object LabelIndentMax: TLabel
        Left = 11
        Top = 46
        Width = 149
        Height = 15
        Caption = 'Do not indent after position:'
      end
      object SpinEditIndent: TSpinEdit
        Left = 176
        Top = 13
        Width = 65
        Height = 24
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 2
      end
      object SpinEditIndentMax: TSpinEdit
        Left = 176
        Top = 43
        Width = 65
        Height = 24
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 40
      end
    end
    object TabSheetAppearance: TTabSheet
      Caption = 'Appearance'
      ImageIndex = 35
    end
  end
  object ActionList: TActionList
    Left = 48
    Top = 40
    object ActionLibraryPathAdd: TAction
      Category = 'Library Path'
      Caption = '&Add'
      ImageIndex = 51
    end
    object ActionLibraryPathReplace: TAction
      Category = 'Library Path'
      Caption = '&Replace'
    end
    object ActionLibraryPathDelete: TAction
      Category = 'Library Path'
      Caption = '&Delete'
      ImageIndex = 52
    end
    object ActionLibraryPathCleanUp: TAction
      Category = 'Library Path'
      Caption = 'Remove &invalid paths'
    end
    object ActionLibraryPathPick: TAction
      Category = 'Library Path'
      Caption = '...'
    end
    object ActionLibraryPathUp: TAction
      Category = 'Library Path'
      Caption = 'Up'
      ImageIndex = 54
    end
    object ActionLibraryPathDown: TAction
      Category = 'Library Path'
      Caption = 'Down'
      ImageIndex = 53
    end
    object ActionLoad: TAction
      Category = 'Highlighter'
      Caption = 'Load...'
      ImageIndex = 1
      OnExecute = ActionLoadExecute
    end
    object ActionSave: TAction
      Category = 'Highlighter'
      Caption = 'Save...'
      ImageIndex = 3
      OnExecute = ActionSaveExecute
    end
    object ActionDeleteNonexistingFiles: TAction
      Category = 'Recent Files'
      Caption = 'Delete None&xisting Files'
    end
    object ActionDelete: TAction
      Category = 'Recent Files'
      Caption = '&Delete'
      OnExecute = ActionDeleteExecute
    end
    object ActionClear: TAction
      Category = 'Recent Files'
      Caption = '&Clear'
      OnExecute = ActionClearExecute
    end
  end
  object SynDWS: TSynDWSSyn
    DefaultFilter = 'DWScript Files (*.dws;*.pas;*.inc)|*.dws;*.pas;*.inc'
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 24
    Top = 480
  end
  object SynJS: TSynJScriptSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 72
    Top = 480
  end
  object SynJSON: TSynJSONSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 120
    Top = 480
  end
  object SynCSS: TSynCssSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 216
    Top = 480
  end
  object SynHTML: TSynHTMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 168
    Top = 480
  end
  object SynPascal: TSynMultiSyn
    DefaultFilter = 'DWScript Files (*.dws;*.pas;*.inc)|*.dws;*.pas;*.inc'
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.DefaultExtension = '.dws'
    Options.Title = 'Object Pascal Syntax Highlighter'
    Options.Visible = False
    Schemes = <
      item
        StartExpr = 'asm'
        EndExpr = 'end;'
        Highlighter = SynJS
        SchemeName = 'Assembler'
      end>
    DefaultHighlighter = SynDWS
    DefaultLanguageName = 'DWScript'
    Left = 272
    Top = 480
  end
  object SynMultiCSS: TSynMultiSyn
    DefaultFilter = 'CSS Files (*.css)|*.css'
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.DefaultExtension = '.css'
    Options.Title = 'CSS Syntax Highlighter'
    Options.Visible = False
    Schemes = <
      item
        CaseSensitive = False
        StartExpr = '</?pas'
        EndExpr = '/?>'
        Highlighter = SynPascal
        SchemeName = 'Object Pascal'
      end
      item
        CaseSensitive = False
        StartExpr = '</?pas='
        EndExpr = '/?>'
        Highlighter = SynPascal
        SchemeName = 'Object Pascal (direct)'
      end>
    DefaultHighlighter = SynCSS
    DefaultLanguageName = 'CSS'
    Left = 336
    Top = 480
  end
  object SynMultiHTML: TSynMultiSyn
    DefaultFilter = 'HTML files (*.html;*,htm)|*.html;*.htm'
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.DefaultExtension = '.html'
    Options.Title = 'HTML Highlighter'
    Options.Visible = False
    Schemes = <
      item
        CaseSensitive = False
        StartExpr = '</?pas'
        EndExpr = '/?>'
        Highlighter = SynPascal
        SchemeName = 'Object Pascal'
      end
      item
        CaseSensitive = False
        StartExpr = '</?pas='
        EndExpr = '/?>'
        Highlighter = SynPascal
        SchemeName = 'Object Pascal (direct)'
      end
      item
        StartExpr = '<script(.*?)>'
        EndExpr = '</style>'
        Highlighter = SynMultiCSS
        SchemeName = 'CSS'
      end
      item
        StartExpr = '<script(.*?)>'
        EndExpr = '</script>'
        Highlighter = SynJS
        SchemeName = 'JavaScript'
      end>
    DefaultHighlighter = SynHTML
    DefaultLanguageName = 'HTML'
    Left = 400
    Top = 480
  end
end
