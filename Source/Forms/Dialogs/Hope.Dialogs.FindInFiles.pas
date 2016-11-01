unit Hope.Dialogs.FindInFiles;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Hope.Dialog;

type
  TFormFindInFiles = class(TFormDialog)
    ButtonSelectDirectory: TButton;
    CheckBoxCaseInsensitivity: TCheckBox;
    CheckBoxConfirmReplace: TCheckBox;
    CheckBoxGroupFiles: TCheckBox;
    CheckBoxRegularExpression: TCheckBox;
    CheckBoxReplaceText: TCheckBox;
    CheckBoxSeparateRegister: TCheckBox;
    CheckboxSubdirectories: TCheckBox;
    CheckBoxWholeWords: TCheckBox;
    ComboBoxDirectory: TComboBox;
    ComboBoxFileType: TComboBox;
    ComboBoxReplaceText: TComboBox;
    ComboBoxSearchText: TComboBox;
    GroupBoxOutput: TGroupBox;
    GroupBoxScope: TGroupBox;
    GroupBoxSearchContext: TGroupBox;
    GroupBoxText: TGroupBox;
    LabelDirectory: TLabel;
    LabelFileType: TLabel;
    LabelSearchText: TLabel;
    RadioButtonDirectory: TRadioButton;
    RadioButtonEditorFiles: TRadioButton;
    RadioButtonProjectFiles: TRadioButton;
    RadioButtonProjectGroups: TRadioButton;
  end;

implementation

{$R *.dfm}

end.

