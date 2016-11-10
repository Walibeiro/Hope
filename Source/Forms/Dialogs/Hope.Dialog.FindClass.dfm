inherited FormFindClass: TFormFindClass
  Caption = 'Find Class'
  ClientHeight = 303
  ClientWidth = 273
  PixelsPerInch = 96
  TextHeight = 15
  object LabelSearch: TLabel [0]
    Left = 8
    Top = 11
    Width = 38
    Height = 15
    Caption = 'Search:'
  end
  object LabelClasses: TLabel [1]
    Left = 8
    Top = 38
    Width = 78
    Height = 15
    Caption = 'Found Classes:'
  end
  inherited ButtonOK: TButton
    Left = 30
    Top = 269
  end
  inherited ButtonCancel: TButton
    Left = 110
    Top = 269
  end
  inherited ButtonHelp: TButton
    Left = 190
    Top = 269
  end
  object EditSearch: TEdit
    Left = 72
    Top = 8
    Width = 193
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    OnChange = EditSearchChange
  end
  object TreeClasses: TVirtualStringTree
    Left = 8
    Top = 56
    Width = 257
    Height = 207
    Anchors = [akLeft, akTop, akRight, akBottom]
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    TabOrder = 4
    Columns = <>
  end
end
