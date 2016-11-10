unit Hope.Dialog.FindInFiles;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Hope.Dialog;

type
  TFormFindInFiles = class(TFormDialog)
    ButtonSelectDirectory: TButton;
    CheckBoxCaseSensitivity: TCheckBox;
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
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure Load;
    procedure Store;
  end;

implementation

{$R *.dfm}

uses
  Hope.DataModule;

{ TFormFindInFiles }

procedure TFormFindInFiles.AfterConstruction;
begin
  inherited;

  Load;
end;

procedure TFormFindInFiles.BeforeDestruction;
begin
  inherited;

  Store;
end;

procedure TFormFindInFiles.Load;
begin
  CheckBoxCaseSensitivity.Checked := DataModuleCommon.Preferences.FindInFiles.CaseSensitive;
  CheckBoxWholeWords.Checked := DataModuleCommon.Preferences.FindInFiles.WholeWordsOnly;
  CheckBoxRegularExpression.Checked := DataModuleCommon.Preferences.FindInFiles.RegularExpressions;
  CheckBoxConfirmReplace.Checked := DataModuleCommon.Preferences.FindInFiles.ConfirmReplace;
end;

procedure TFormFindInFiles.Store;
begin
  DataModuleCommon.Preferences.FindInFiles.CaseSensitive := CheckBoxCaseSensitivity.Checked;
  DataModuleCommon.Preferences.FindInFiles.WholeWordsOnly := CheckBoxWholeWords.Checked;
  DataModuleCommon.Preferences.FindInFiles.RegularExpressions := CheckBoxRegularExpression.Checked;
  DataModuleCommon.Preferences.FindInFiles.ConfirmReplace := CheckBoxConfirmReplace.Checked;
end;

end.

