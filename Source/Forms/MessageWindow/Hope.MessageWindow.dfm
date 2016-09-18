inherited FormMessageWindow: TFormMessageWindow
  Caption = 'Message Window'
  ClientHeight = 152
  ClientWidth = 784
  PixelsPerInch = 96
  TextHeight = 13
  object TreeMessages: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 784
    Height = 152
    Align = alClient
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    Images = DataModuleCommon.ImageList16
    TabOrder = 0
    Columns = <>
  end
  object PopupMenu: TPopupMenu
    Left = 56
    Top = 32
    object MenuItemClearMessages: TMenuItem
      Caption = 'Clear Messages'
      OnClick = MenuItemClearMessagesClick
    end
    object MenuItemSaveMessagesToFile: TMenuItem
      Caption = 'Save Messages To File...'
      OnClick = MenuItemSaveMessagesToFileClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuItemCopy: TMenuItem
      Caption = '&Copy'
      ShortCut = 16451
      OnClick = MenuItemCopyClick
    end
    object MenuItemSelectAll: TMenuItem
      Caption = '&Select all'
      ShortCut = 16449
      OnClick = MenuItemSelectAllClick
    end
  end
end
