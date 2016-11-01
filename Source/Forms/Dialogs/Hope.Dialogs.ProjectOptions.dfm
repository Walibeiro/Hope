inherited FormProjectOptions: TFormProjectOptions
  Caption = 'Project Options'
  ClientHeight = 520
  ClientWidth = 791
  DesignSize = (
    791
    520)
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
    Images = DataModuleCommon.ImageList16
    StateImages = DataModuleCommon.ImageList16
    TabOrder = 3
    OnChange = TreeCategoryChange
    OnGetText = TreeCategoryGetText
    OnGetImageIndex = TreeCategoryGetImageIndex
    OnIncrementalSearch = TreeCategoryIncrementalSearch
    Columns = <>
  end
  object PageControl: TPageControl
    Left = 247
    Top = 8
    Width = 536
    Height = 471
    ActivePage = TabSheetProject
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = tsButtons
    TabOrder = 4
    object TabSheetProject: TTabSheet
      Caption = 'Project'
      object GroupBoxAuthor: TGroupBox
        Left = 0
        Top = 196
        Width = 528
        Height = 133
        Align = alTop
        Caption = 'Author'
        TabOrder = 0
        object LabelAuthorName: TLabel
          Left = 14
          Top = 30
          Width = 35
          Height = 15
          Caption = 'Name:'
        end
        object LabelEmail: TLabel
          Left = 14
          Top = 59
          Width = 32
          Height = 15
          Caption = 'Email:'
        end
        object LabelWebsite: TLabel
          Left = 14
          Top = 88
          Width = 45
          Height = 15
          Caption = 'Website:'
        end
        object EditAuthorEmail: TEdit
          Left = 96
          Top = 56
          Width = 417
          Height = 23
          TabOrder = 0
        end
        object EditAuthorName: TEdit
          Left = 96
          Top = 27
          Width = 417
          Height = 23
          TabOrder = 1
        end
        object EditAuthorWebsite: TEdit
          Left = 96
          Top = 85
          Width = 417
          Height = 23
          TabOrder = 2
        end
      end
      object GroupBoxInformation: TGroupBox
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 528
        Height = 188
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 8
        Align = alTop
        Caption = 'Project Information'
        TabOrder = 1
        object LabelName: TLabel
          Left = 14
          Top = 30
          Width = 35
          Height = 15
          Caption = 'Name:'
        end
        object LabelDescription: TLabel
          Left = 14
          Top = 59
          Width = 63
          Height = 15
          Caption = 'Description:'
        end
        object MemoDescription: TMemo
          Left = 96
          Top = 56
          Width = 417
          Height = 121
          TabOrder = 0
        end
        object EditProjectName: TEdit
          Left = 96
          Top = 27
          Width = 417
          Height = 23
          TabOrder = 1
        end
      end
    end
    object TabSheetCompiler: TTabSheet
      Caption = 'Compiler'
      ImageIndex = 1
    end
    object TabSheetCompilerLinker: TTabSheet
      Caption = 'Linker'
      ImageIndex = 2
    end
    object TabSheetExecution: TTabSheet
      Caption = 'Execution'
      ImageIndex = 3
    end
    object TabSheetFilter: TTabSheet
      Caption = 'Filter'
      ImageIndex = 4
    end
    object TabSheetIcon: TTabSheet
      Caption = 'Icon'
      ImageIndex = 5
    end
    object TabSheetVersion: TTabSheet
      Caption = 'Version'
      ImageIndex = 6
    end
  end
end
