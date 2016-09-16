inherited FormPreferences: TFormPreferences
  Caption = 'Preferences'
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
    ActivePage = TabSheetEnvironment
    Anchors = [akLeft, akTop, akRight, akBottom]
    Images = DataModuleCommon.ImageList16
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
        Width = 522
        Height = 118
        Align = alTop
        Caption = 'Paths'
        TabOrder = 0
        DesignSize = (
          522
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
          Width = 322
          Height = 23
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
        end
        object ButtonProjectPath: TButton
          Left = 488
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
    end
    object TabSheetLibraryPaths: TTabSheet
      Caption = 'Paths'
      ImageIndex = 35
      object GroupBoxLibraryPaths: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 522
        Height = 380
        Align = alClient
        Caption = 'Library Paths'
        TabOrder = 0
        DesignSize = (
          522
          380)
        object ListBoxLibraryPaths: TListBox
          Left = 16
          Top = 24
          Width = 460
          Height = 286
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 15
          TabOrder = 0
        end
        object ButtonReplace: TButton
          Left = 16
          Top = 346
          Width = 65
          Height = 25
          Action = ActionLibraryPathReplace
          Anchors = [akLeft, akBottom]
          TabOrder = 1
        end
        object ButtonAdd: TButton
          Left = 87
          Top = 346
          Width = 65
          Height = 25
          Action = ActionLibraryPathAdd
          Anchors = [akLeft, akBottom]
          ImageAlignment = iaBottom
          TabOrder = 2
        end
        object ButtonDelete: TButton
          Left = 158
          Top = 346
          Width = 65
          Height = 25
          Action = ActionLibraryPathDelete
          Anchors = [akLeft, akBottom]
          TabOrder = 3
        end
        object ButtonCleanUp: TButton
          Left = 232
          Top = 346
          Width = 275
          Height = 25
          Action = ActionLibraryPathCleanUp
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 4
        end
        object ButtonPick: TButton
          Left = 482
          Top = 315
          Width = 25
          Height = 25
          Action = ActionLibraryPathPick
          Anchors = [akRight, akBottom]
          TabOrder = 5
        end
        object Edit: TEdit
          Left = 16
          Top = 316
          Width = 460
          Height = 23
          Anchors = [akLeft, akRight, akBottom]
          TabOrder = 6
        end
        object ButtonUp: TButton
          Left = 481
          Top = 139
          Width = 25
          Height = 25
          Action = ActionLibraryPathUp
          Anchors = [akRight]
          ImageAlignment = iaCenter
          TabOrder = 7
        end
        object ButtonDown: TButton
          Left = 481
          Top = 176
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
    end
    object TabSheetHighlighterOptions: TTabSheet
      Caption = 'Highlighter Options'
      ImageIndex = 35
    end
    object TabSheetDeployment: TTabSheet
      Caption = 'Deployment'
      ImageIndex = 35
    end
    object TabSheetCodeInsight: TTabSheet
      Caption = 'Code Insight'
      ImageIndex = 35
    end
    object TabSheetVersionControl: TTabSheet
      Caption = 'Version Control'
      ImageIndex = 35
    end
    object TabSheetFormating: TTabSheet
      Caption = 'Formating'
      ImageIndex = 35
    end
  end
  object ActionList: TActionList
    Images = DataModuleCommon.ImageList16
    Left = 48
    Top = 40
    object ActionLibraryPathAdd: TAction
      Caption = '&Add'
      ImageIndex = 51
    end
    object ActionLibraryPathReplace: TAction
      Caption = '&Replace'
    end
    object ActionLibraryPathDelete: TAction
      Caption = '&Delete'
      ImageIndex = 52
    end
    object ActionLibraryPathCleanUp: TAction
      Caption = 'Remove &invalid paths'
    end
    object ActionLibraryPathPick: TAction
      Caption = '...'
    end
    object ActionLibraryPathUp: TAction
      Caption = 'Up'
      ImageIndex = 54
    end
    object ActionLibraryPathDown: TAction
      Caption = 'Down'
      ImageIndex = 53
    end
  end
end
