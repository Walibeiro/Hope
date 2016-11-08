inherited FormGotoLineNumber: TFormGotoLineNumber
  BorderStyle = bsDialog
  Caption = 'Goto Line Number'
  ClientHeight = 102
  ClientWidth = 253
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  inherited ButtonOK: TButton
    Left = 8
    Top = 69
  end
  inherited ButtonCancel: TButton
    Left = 89
    Top = 69
  end
  inherited ButtonHelp: TButton
    Left = 170
    Top = 69
  end
  object GroupBoxLineNumber: TGroupBox
    Left = 8
    Top = 0
    Width = 237
    Height = 58
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    DesignSize = (
      237
      58)
    object LabelNewLineNumber: TLabel
      Left = 16
      Top = 24
      Width = 99
      Height = 15
      Caption = 'New Line Number:'
    end
    object ComboBoxLineNumber: TComboBox
      Left = 128
      Top = 21
      Width = 101
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
end
