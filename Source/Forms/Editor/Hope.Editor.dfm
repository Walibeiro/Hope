object FormEditor: TFormEditor
  Left = 0
  Top = 0
  Caption = 'Editor'
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
    PopupMenu = FormMain.PopupMenu
    TabOrder = 0
    OnClick = EditorClick
    OnEnter = EditorEnter
    BorderStyle = bsNone
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    SearchEngine = DataModuleCommon.SynEditSearch
    OnChange = EditorChange
    OnGutterPaint = EditorGutterPaint
    OnProcessUserCommand = EditorProcessUserCommand
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
  object PopupMenu: TPopupMenu
    Left = 384
    Top = 304
    object MenuItemClosePage: TMenuItem
      Action = FormMain.ActionPageClosePage
    end
    object MenuItemOpenFileAtCursor: TMenuItem
      Action = FormMain.ActionEditorOpenFileAtCursor
    end
    object MenuItemTopicSearch: TMenuItem
      Action = FormMain.ActionEditorTopicSearch
    end
    object MenuItemCompleteClassatCursor: TMenuItem
      Action = FormMain.ActionEditorCompleteClassAtCursor
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuItemCut: TMenuItem
      Action = FormMain.ActionEditCut
    end
    object MenuItemCopy: TMenuItem
      Action = FormMain.ActionEditCopy
    end
    object MenuItemPaste: TMenuItem
      Action = FormMain.ActionEditPaste
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MenuItemToggleBookmarks: TMenuItem
      Caption = 'Toggle Boo&kmarks'
      object MenuItemToggleBookmark0: TMenuItem
        Caption = 'Bookmark 0'
        OnClick = MenuItemToggleBookmarkClick
      end
      object MenuItemToggleBookmark1: TMenuItem
        Tag = 1
        Caption = 'Bookmark 1'
      end
      object MenuItemToggleBookmark2: TMenuItem
        Tag = 2
        Caption = 'Bookmark 2'
      end
      object MenuItemToggleBookmark3: TMenuItem
        Tag = 3
        Caption = 'Bookmark 3'
      end
      object MenuItemToggleBookmark4: TMenuItem
        Tag = 4
        Caption = 'Bookmark 4'
      end
      object MenuItemToggleBookmark5: TMenuItem
        Tag = 5
        Caption = 'Bookmark 5'
      end
      object MenuItemToggleBookmark6: TMenuItem
        Tag = 6
        Caption = 'Bookmark 6'
      end
      object MenuItemToggleBookmark7: TMenuItem
        Tag = 7
        Caption = 'Bookmark 7'
      end
      object MenuItemToggleBookmark8: TMenuItem
        Tag = 8
        Caption = 'Bookmark 8'
      end
      object MenuItemToggleBookmark9: TMenuItem
        Tag = 9
        Caption = 'Bookmark 9'
      end
    end
    object MenuItemGotoBookmarks: TMenuItem
      Caption = '&Goto Bookmarks'
      object MenuItemGotoBookmark0: TMenuItem
        Caption = 'Bookmark 0'
        OnClick = MenuItemGotoBookmarkClick
      end
      object MenuItemGotoBookmark1: TMenuItem
        Tag = 1
        Caption = 'Bookmark 1'
        OnClick = MenuItemGotoBookmarkClick
      end
      object MenuItemGotoBookmark2: TMenuItem
        Tag = 2
        Caption = 'Bookmark 2'
        OnClick = MenuItemGotoBookmarkClick
      end
      object MenuItemGotoBookmark3: TMenuItem
        Tag = 3
        Caption = 'Bookmark 3'
        OnClick = MenuItemGotoBookmarkClick
      end
      object MenuItemGotoBookmark4: TMenuItem
        Tag = 4
        Caption = 'Bookmark 4'
        OnClick = MenuItemGotoBookmarkClick
      end
      object MenuItemGotoBookmark5: TMenuItem
        Tag = 5
        Caption = 'Bookmark 5'
        OnClick = MenuItemGotoBookmarkClick
      end
      object MenuItemGotoBookmark6: TMenuItem
        Tag = 6
        Caption = 'Bookmark 6'
        OnClick = MenuItemGotoBookmarkClick
      end
      object MenuItemGotoBookmark7: TMenuItem
        Tag = 7
        Caption = 'Bookmark 7'
        OnClick = MenuItemGotoBookmarkClick
      end
      object MenuItemGotoBookmark8: TMenuItem
        Tag = 8
        Caption = 'Bookmark 8'
        OnClick = MenuItemGotoBookmarkClick
      end
      object MenuItemGotoBookmark9: TMenuItem
        Tag = 9
        Caption = 'Bookmark 9'
        OnClick = MenuItemGotoBookmarkClick
      end
    end
    object MenuItemClearBookmarks: TMenuItem
      Caption = 'Clear &Bookmarks'
      OnClick = MenuItemClearBookmarksClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object MenuItemToggleComment: TMenuItem
      Action = FormMain.ActionEditorToggleComment
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object MenuItemFormatSource: TMenuItem
      Action = FormMain.ActionEditorFormatSource
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object MenuItemFind: TMenuItem
      Caption = 'Find'
      object FindDeclaration1: TMenuItem
        Action = FormMain.ActionEditorFindDeclaration
      end
    end
  end
end
