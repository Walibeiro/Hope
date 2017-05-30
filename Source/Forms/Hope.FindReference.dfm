object FormFindReference: TFormFindReference
  Left = 0
  Top = 0
  Caption = 'Symbol Usage'
  ClientHeight = 165
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object TreeViewSymbolPositions: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 680
    Height = 165
    Align = alClient
    Header.AutoSizeIndex = 1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
    IncrementalSearch = isVisibleOnly
    TabOrder = 0
    OnCompareNodes = TreeViewSymbolPositionsCompareNodes
    OnDblClick = TreeViewSymbolPositionsDblClick
    OnFreeNode = TreeViewSymbolPositionsFreeNode
    OnGetText = TreeViewSymbolPositionsGetText
    OnIncrementalSearch = TreeViewSymbolPositionsIncrementalSearch
    Columns = <
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coAllowFocus, coEditable]
        Position = 0
        Width = 81
        WideText = 'UnitName'
      end
      item
        Position = 1
        Width = 484
        WideText = 'Item'
      end
      item
        Position = 2
        Width = 96
        WideText = 'Line'
      end
      item
        Position = 3
        Width = 96
        WideText = 'Character'
      end>
  end
end
