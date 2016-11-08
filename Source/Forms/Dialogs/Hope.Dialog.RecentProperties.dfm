inherited FormRecentProperties: TFormRecentProperties
  Caption = 'Properties of Recent'
  ClientHeight = 420
  ClientWidth = 420
  PixelsPerInch = 96
  TextHeight = 15
  inherited ButtonOK: TButton
    Left = 177
    Top = 386
  end
  inherited ButtonCancel: TButton
    Left = 257
    Top = 386
  end
  inherited ButtonHelp: TButton
    Left = 337
    Top = 386
  end
  object GroupBoxCapacity: TGroupBox
    Left = 8
    Top = 8
    Width = 404
    Height = 69
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Capacity'
    TabOrder = 3
    DesignSize = (
      404
      69)
    object LabelProjectCount: TLabel
      Left = 16
      Top = 32
      Width = 74
      Height = 15
      Caption = 'Project count:'
    end
    object LabelUnitCount: TLabel
      Left = 240
      Top = 32
      Width = 59
      Height = 15
      Anchors = [akTop, akRight]
      Caption = 'Unit count:'
    end
    object SpinEditProjectCount: TSpinEdit
      Left = 112
      Top = 29
      Width = 65
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 10
    end
    object SpinEditUnitCOunt: TSpinEdit
      Left = 320
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
    Left = 8
    Top = 83
    Width = 404
    Height = 297
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Items'
    TabOrder = 4
    DesignSize = (
      404
      297)
    object ButtonRemoveInvalid: TButton
      Left = 16
      Top = 264
      Width = 161
      Height = 25
      Action = ActionRemoveInvalid
      Anchors = [akLeft, akBottom]
      TabOrder = 0
    end
    object ButtonDelete: TButton
      Left = 211
      Top = 264
      Width = 84
      Height = 25
      Action = ActionDelete
      Anchors = [akRight, akBottom]
      TabOrder = 1
    end
    object ButtonClear: TButton
      Left = 301
      Top = 264
      Width = 84
      Height = 25
      Action = ActionClear
      Anchors = [akRight, akBottom]
      TabOrder = 2
    end
  end
  object TreeItems: TVirtualStringTree
    Left = 24
    Top = 104
    Width = 369
    Height = 237
    Anchors = [akLeft, akTop, akRight, akBottom]
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    Images = DataModuleCommon.ImageList16
    PopupMenu = PopupMenu
    StateImages = DataModuleCommon.ImageList16
    TabOrder = 5
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnGetText = TreeItemsGetText
    Columns = <>
  end
  object PopupMenu: TPopupMenu
    Left = 200
    Top = 208
    object MenuItemDelete: TMenuItem
      Action = ActionDelete
    end
    object MenuItemClear: TMenuItem
      Action = ActionClear
    end
  end
  object ActionList: TActionList
    Left = 272
    Top = 208
    object ActionClear: TAction
      Caption = '&Clear'
    end
    object ActionDelete: TAction
      Caption = '&Delete'
      ShortCut = 46
    end
    object ActionRemoveInvalid: TAction
      Caption = 'Remove &Invalid'
    end
  end
end
