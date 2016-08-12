object FormDialog: TFormDialog
  Left = 0
  Top = 0
  Caption = 'Dialog'
  ClientHeight = 423
  ClientWidth = 854
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    854
    423)
  PixelsPerInch = 96
  TextHeight = 15
  object ButtonOK: TButton
    Left = 611
    Top = 389
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object ButtonCancel: TButton
    Left = 691
    Top = 389
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ButtonHelp: TButton
    Left = 771
    Top = 389
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 2
    OnClick = ButtonHelpClick
  end
end
