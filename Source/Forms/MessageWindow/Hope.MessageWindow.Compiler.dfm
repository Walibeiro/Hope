inherited FormCompilerMessages: TFormCompilerMessages
  Caption = 'Compiler Messages'
  ClientHeight = 140
  ClientWidth = 687
  Font.Height = -12
  Font.Name = 'Segoe UI'
  PixelsPerInch = 96
  TextHeight = 15
  inherited TreeMessages: TVirtualStringTree
    Width = 687
    Height = 140
    TreeOptions.PaintOptions = [toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnCompareNodes = TreeMessagesCompareNodes
    OnDblClick = TreeMessagesDblClick
    OnFreeNode = TreeMessagesFreeNode
    OnGetText = TreeMessagesGetText
    OnPaintText = TreeMessagesPaintText
    OnGetImageIndex = TreeMessagesGetImageIndex
  end
end
