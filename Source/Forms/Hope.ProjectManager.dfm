inherited FormProjectManager: TFormProjectManager
  Left = 0
  Top = 0
  Caption = 'Project Manager'
  ClientHeight = 544
  ClientWidth = 236
  Font.Height = -12
  Font.Name = 'Segoe UI'
  PixelsPerInch = 96
  TextHeight = 15
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 236
    Height = 22
    AutoSize = True
    Caption = 'ToolBar'
    TabOrder = 0
    object ToolButtonActiveProject: TToolButton
      Left = 0
      Top = 0
      Caption = 'ToolButton'
      ImageIndex = 0
      Style = tbsDropDown
    end
    object ToolButtonAddNewProject: TToolButton
      Left = 36
      Top = 0
      Caption = 'Add new project'
      ImageIndex = 1
    end
    object ToolButtonRemoveProject: TToolButton
      Left = 59
      Top = 0
      Caption = 'ToolButtonRemove'
      ImageIndex = 2
    end
    object ToolButtonView: TToolButton
      Left = 82
      Top = 0
      Caption = 'ToolButtonView'
      ImageIndex = 3
      Style = tbsDropDown
    end
    object ToolButtonSplitter: TToolButton
      Left = 118
      Top = 0
      Width = 8
      Caption = 'ToolButtonSplitter'
      ImageIndex = 4
      Style = tbsSeparator
    end
  end
  object TreeProject: TVirtualStringTree
    Left = 0
    Top = 22
    Width = 236
    Height = 522
    Align = alClient
    BorderStyle = bsNone
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    TabOrder = 1
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toWheelPanning, toEditOnClick]
    OnCompareNodes = TreeProjectCompareNodes
    OnDblClick = TreeProjectDblClick
    OnEditing = TreeProjectEditing
    OnFreeNode = TreeProjectFreeNode
    OnGetText = TreeProjectGetText
    OnGetImageIndex = TreeProjectGetImageIndex
    OnIncrementalSearch = TreeProjectIncrementalSearch
    OnNewText = TreeProjectNewText
    Columns = <>
  end
end
