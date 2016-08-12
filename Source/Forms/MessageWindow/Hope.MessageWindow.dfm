object FormMessageWindow: TFormMessageWindow
  Left = 0
  Top = 0
  Caption = 'Message Window'
  ClientHeight = 152
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
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
    TabOrder = 0
    Columns = <>
  end
  object PopupMenu: TPopupMenu
    Left = 56
    Top = 32
    object MenuItemClearMessages: TMenuItem
      Caption = 'Clear Messages'
    end
    object MenuItemCopyMessageToClipboard: TMenuItem
      Caption = 'Copy Message To Clipboard'
    end
    object MenuItemCopyMessagesToClipboard: TMenuItem
      Caption = 'Copy Messages To Clipboard'
    end
    object MenuItemSaveMessagesToFile: TMenuItem
      Caption = 'Save Messages To File...'
    end
  end
end
