object FormSymbolUsage: TFormSymbolUsage
  Left = 0
  Top = 0
  Caption = 'Symbol Usage'
  ClientHeight = 168
  ClientWidth = 503
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
    Width = 503
    Height = 168
    Align = alClient
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
    TabOrder = 0
    OnCompareNodes = TreeViewSymbolPositionsCompareNodes
    OnDblClick = TreeViewSymbolPositionsDblClick
    OnFreeNode = TreeViewSymbolPositionsFreeNode
    OnGetText = TreeViewSymbolPositionsGetText
    OnIncrementalSearch = TreeViewSymbolPositionsIncrementalSearch
    Columns = <
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coSmartResize, coAllowFocus, coEditable]
        Position = 0
        Width = 307
        WideText = 'Source Unit'
      end
      item
        Position = 1
        Width = 96
        WideText = 'Line'
      end
      item
        Position = 2
        Width = 96
        WideText = 'Character'
      end>
  end
end
