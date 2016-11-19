object FormReloadChangedFiles: TFormReloadChangedFiles
  Left = 0
  Top = 0
  Caption = 'Reload changed files'
  ClientHeight = 333
  ClientWidth = 653
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    653
    333)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonCancel: TButton
    Left = 570
    Top = 300
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 0
  end
  object ButtonReload: TButton
    Left = 489
    Top = 300
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Reload'
    Default = True
    TabOrder = 1
  end
  object TreeFiles: TVirtualStringTree
    Left = 8
    Top = 8
    Width = 637
    Height = 286
    Anchors = [akLeft, akTop, akRight, akBottom]
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    TabOrder = 2
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
    TreeOptions.PaintOptions = [toShowRoot, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnFreeNode = TreeFilesFreeNode
    OnGetText = TreeFilesGetText
    Columns = <>
  end
end
