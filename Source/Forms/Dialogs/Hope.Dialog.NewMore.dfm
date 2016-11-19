inherited FormObjectGallery: TFormObjectGallery
  Caption = 'Gallery'
  ClientHeight = 511
  ClientWidth = 473
  PixelsPerInch = 96
  TextHeight = 15
  inherited ButtonOK: TButton
    Left = 228
    Top = 478
  end
  inherited ButtonCancel: TButton
    Left = 309
    Top = 478
  end
  inherited ButtonHelp: TButton
    Left = 390
    Top = 478
  end
  object TreeItems: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 457
    Height = 464
    Anchors = [akLeft, akTop, akRight, akBottom]
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
    OnFreeNode = TreeItemsFreeNode
    OnGetText = TreeItemsGetText
    OnGetImageIndex = TreeItemsGetImageIndex
    OnIncrementalSearch = TreeItemsIncrementalSearch
    Columns = <>
  end
end
