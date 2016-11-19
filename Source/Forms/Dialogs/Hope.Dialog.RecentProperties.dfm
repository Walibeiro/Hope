inherited FormRecentProperties: TFormRecentProperties
  Caption = 'Properties of Recent'
  ClientHeight = 420
  ClientWidth = 425
  PixelsPerInch = 96
  TextHeight = 15
  inherited ButtonOK: TButton
    Left = 182
    Top = 386
  end
  inherited ButtonCancel: TButton
    Left = 262
    Top = 386
  end
  inherited ButtonHelp: TButton
    Left = 342
    Top = 386
  end
  object GroupBoxCapacity: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 69
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Capacity'
    TabOrder = 3
    DesignSize = (
      409
      69)
    object LabelProjectCount: TLabel
      Left = 16
      Top = 32
      Width = 106
      Height = 15
      Caption = 'Number of Projects:'
    end
    object LabelUnitCount: TLabel
      Left = 226
      Top = 32
      Width = 85
      Height = 15
      Anchors = [akTop, akRight]
      Caption = 'Number of files:'
    end
    object SpinEditProjectCount: TSpinEdit
      Left = 136
      Top = 29
      Width = 65
      Height = 24
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 10
    end
    object SpinEditUnitCOunt: TSpinEdit
      Left = 325
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
    Width = 409
    Height = 297
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Recent Items'
    TabOrder = 4
    DesignSize = (
      409
      297)
    object ButtonRemoveInvalid: TButton
      Left = 16
      Top = 264
      Width = 161
      Height = 25
      Action = ActionDeleteNonExistingFiles
      Anchors = [akLeft, akBottom]
      TabOrder = 0
    end
    object ButtonDelete: TButton
      Left = 216
      Top = 264
      Width = 84
      Height = 25
      Action = ActionDelete
      Anchors = [akRight, akBottom]
      TabOrder = 1
    end
    object ButtonClear: TButton
      Left = 306
      Top = 264
      Width = 84
      Height = 25
      Action = ActionClear
      Anchors = [akRight, akBottom]
      TabOrder = 2
    end
    object TreeItems: TVirtualStringTree
      Left = 16
      Top = 21
      Width = 374
      Height = 237
      Anchors = [akLeft, akTop, akRight, akBottom]
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.MainColumn = -1
      Indent = 0
      PopupMenu = PopupMenu
      TabOrder = 3
      TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
      TreeOptions.PaintOptions = [toThemeAware, toUseBlendedImages]
      TreeOptions.SelectionOptions = [toFullRowSelect]
      OnCollapsing = TreeItemsCollapsing
      OnDrawText = TreeItemsDrawText
      OnFreeNode = TreeItemsFreeNode
      OnGetText = TreeItemsGetText
      Columns = <>
    end
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
      OnExecute = ActionClearExecute
    end
    object ActionDelete: TAction
      Caption = '&Delete'
      ShortCut = 46
      OnExecute = ActionDeleteExecute
    end
    object ActionDeleteNonExistingFiles: TAction
      Caption = 'Delete None&xisting Files'
    end
  end
end
