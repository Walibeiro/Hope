inherited FormProjectOptions: TFormProjectOptions
  Caption = 'Project Options'
  ClientHeight = 520
  ClientWidth = 791
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel: TBevel [0]
    Left = 251
    Top = 479
    Width = 532
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  inherited ButtonOK: TButton
    Left = 546
    Top = 487
  end
  inherited ButtonCancel: TButton
    Left = 627
    Top = 487
  end
  inherited ButtonHelp: TButton
    Left = 708
    Top = 487
  end
  object TreeCategory: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 233
    Height = 473
    Anchors = [akLeft, akTop, akBottom]
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    TabOrder = 3
    Columns = <>
  end
  object PageControl: TPageControl
    Left = 247
    Top = 8
    Width = 536
    Height = 471
    ActivePage = TabSheetCompiler
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = tsButtons
    TabOrder = 4
    object TabSheetProject: TTabSheet
      Caption = 'Project'
    end
    object TabSheetCompiler: TTabSheet
      Caption = 'Compiler'
      ImageIndex = 1
    end
    object TabSheetCompilerLinker: TTabSheet
      Caption = 'Linker'
      ImageIndex = 2
    end
  end
end
