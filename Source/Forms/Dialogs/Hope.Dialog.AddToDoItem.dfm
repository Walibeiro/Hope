inherited FormAddToDoItem: TFormAddToDoItem
  Caption = 'Add To-Do Item'
  ClientHeight = 272
  ClientWidth = 415
  Font.Height = -11
  Font.Name = 'Tahoma'
  DesignSize = (
    415
    272)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelText: TLabel [0]
    Left = 8
    Top = 8
    Width = 26
    Height = 13
    Caption = 'Text:'
  end
  object LabelPriority: TLabel [1]
    Left = 8
    Top = 197
    Width = 38
    Height = 12
    Anchors = [akLeft, akBottom]
    Caption = 'Priority:'
  end
  object LabelOwner: TLabel [2]
    Left = 63
    Top = 197
    Width = 36
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Owner:'
  end
  object LabelCategory: TLabel [3]
    Left = 191
    Top = 197
    Width = 49
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Category:'
  end
  inherited ButtonOK: TButton
    Left = 173
    Top = 239
    TabOrder = 4
  end
  inherited ButtonCancel: TButton
    Left = 253
    Top = 239
    TabOrder = 5
  end
  inherited ButtonHelp: TButton
    Left = 333
    Top = 239
    TabOrder = 6
  end
  object MemoItem: TMemo
    Left = 8
    Top = 24
    Width = 399
    Height = 166
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object SpinEditPriority: TSpinEdit
    Left = 8
    Top = 213
    Width = 49
    Height = 22
    Anchors = [akLeft, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object ComboBoxOwner: TComboBox
    Left = 63
    Top = 213
    Width = 122
    Height = 21
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object ComboBoxCategory: TComboBox
    Left = 191
    Top = 213
    Width = 216
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 3
  end
end
