object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'HOPE - Integrated Object Pascal Development Envirionment'
  ClientHeight = 538
  ClientWidth = 897
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu: TMainMenu
    Left = 104
    Top = 104
    object MenuItemFile: TMenuItem
      Caption = '&File'
      object MenuItemFileNew: TMenuItem
        Caption = 'New...'
      end
      object MenuItemFileOpen: TMenuItem
        Action = ActionFileOpen
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MenuItemFileSaveAs: TMenuItem
        Action = ActionFileSaveAs
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MenuItemFileExit: TMenuItem
        Action = ActionFileExit
      end
    end
    object MenuItemEdit: TMenuItem
      Caption = '&Edit'
      object MenuItemEditUndo: TMenuItem
        Action = ActionEditUndo
      end
      object MenuItemEditRedo: TMenuItem
        Action = ActionEditRedo
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object MenuItemEditCut: TMenuItem
        Action = ActionEditCut
      end
      object MenuItemEditCopy: TMenuItem
        Action = ActionEditCopy
      end
      object MenuItemEditPaste: TMenuItem
        Action = ActionEditPaste
      end
      object MenuItemEditDelete: TMenuItem
        Action = ActionEditDelete
      end
      object MenuItemEditSelectAll: TMenuItem
        Action = ActionEditSelectAll
      end
      object N4: TMenuItem
        Caption = '-'
      end
    end
    object MenuItemSearch: TMenuItem
      Caption = '&Search'
      object MenuItemEditSearchFind: TMenuItem
        Action = ActionSearchFind
      end
      object MenuItemEditSearchFindNext: TMenuItem
        Action = ActionSearchFindNext
      end
      object MenuItemEditSearchReplace: TMenuItem
        Action = ActionSearchReplace
      end
    end
    object MenuItemView: TMenuItem
      Caption = '&View'
    end
    object MenuItemRefactor: TMenuItem
      Caption = '&Refactor'
    end
    object MenuItemProject: TMenuItem
      Caption = '&Project'
    end
    object MenuItemStart: TMenuItem
      Caption = '&Start'
    end
    object MenuItemTools: TMenuItem
      Caption = '&Tools'
    end
    object MenuItemHelp: TMenuItem
      Caption = '&Help'
    end
  end
  object ActionList: TActionList
    Left = 176
    Top = 104
    object ActionFileOpen: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
    end
    object ActionFileSaveAs: TFileSaveAs
      Category = 'File'
      Caption = 'Save &As...'
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 30
    end
    object ActionFileExit: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 43
    end
    object ActionSearchFind: TSearchFind
      Category = 'Search'
      Caption = '&Find...'
      Hint = 'Find|Finds the specified text'
      ImageIndex = 34
      ShortCut = 16454
    end
    object ActionSearchFindNext: TSearchFindNext
      Category = 'Search'
      Caption = 'Find &Next'
      Hint = 'Find Next|Repeats the last find'
      ImageIndex = 33
      ShortCut = 114
    end
    object ActionSearchReplace: TSearchReplace
      Category = 'Search'
      Caption = '&Replace'
      Hint = 'Replace|Replaces specific text with different text'
      ImageIndex = 32
    end
    object ActionSearchFindFirst: TSearchFindFirst
      Category = 'Search'
      Caption = 'F&ind First'
      Hint = 'Find First|Finds the first occurance of specified text'
    end
    object ActionEditCut: TJvEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object ActionEditCopy: TJvEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object ActionEditPaste: TJvEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object ActionEditSelectAll: TJvEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
    object ActionEditUndo: TJvEditUndo
      Category = 'Edit'
      Caption = '&Undo'
      Hint = 'Undo|Reverts the last action'
      ImageIndex = 3
      ShortCut = 16474
    end
    object ActionEditDelete: TJvEditDelete
      Category = 'Edit'
      Caption = '&Delete'
      Hint = 'Delete|Erases the selection'
      ImageIndex = 5
      ShortCut = 46
    end
    object ActionEditRedo: TAction
      Category = 'Edit'
      Caption = '&Redo'
      Hint = 'Redo|Reverts the last action'
    end
    object ActionHelpAbout: TAction
      Category = 'Help'
      Caption = 'About'
    end
  end
  object DockServer: TJvDockServer
    LeftSplitterStyle.Cursor = crHSplit
    LeftSplitterStyle.ParentColor = False
    RightSplitterStyle.Cursor = crHSplit
    RightSplitterStyle.ParentColor = False
    TopSplitterStyle.Cursor = crVSplit
    TopSplitterStyle.ParentColor = False
    BottomSplitterStyle.Cursor = crVSplit
    BottomSplitterStyle.ParentColor = False
    Left = 264
    Top = 104
  end
end
