unit Hope.Dialogs.FindReplace;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  SynEdit, SynEditTypes, Hope.Dialog, Hope.Datamodule;

type
  TFormFindReplace = class(TFormDialog)
    ButtonPresetReplace: TButton;
    ButtonPresetSearch: TButton;
    ButtonReplaceAll: TButton;
    CheckBoxCaseSensitivity: TCheckBox;
    CheckBoxPromptEachReplace: TCheckBox;
    CheckBoxRegularExpressions: TCheckBox;
    CheckBoxReplace: TCheckBox;
    CheckBoxTransparency: TCheckBox;
    CheckBoxWholeWordOnly: TCheckBox;
    ComboBoxReplaceText: TComboBox;
    ComboBoxSearchText: TComboBox;
    GroupBoxDirection: TGroupBox;
    GroupBoxScope: TGroupBox;
    GroupBoxSearchOptions: TGroupBox;
    LabelSearch: TLabel;
    RadioButtonBackward: TRadioButton;
    RadioButtonEntireScope: TRadioButton;
    RadioButtonForward: TRadioButton;
    RadioButtonGlobal: TRadioButton;
    RadioButtonSelectedText: TRadioButton;
    procedure CheckBoxReplaceClick(Sender: TObject);
    procedure ButtonReplaceAllClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  public
    procedure AfterConstruction; override;

    procedure AddSearchItem;
    procedure AddReplaceItem;

    procedure PerformSearch;
    procedure PerformReplace(ReplaceAll: Boolean = False);
  end;

implementation

uses
  Hope.Main;

{$R *.dfm}

{ TFormFindReplace }

procedure TFormFindReplace.AfterConstruction;
begin
  inherited;

  ComboBoxSearchText.Items.Assign(DataModuleCommon.Preferences.Search.RecentSearch);
  ComboBoxReplaceText.Items.Assign(DataModuleCommon.Preferences.Search.RecentSearch);
end;

procedure TFormFindReplace.CheckBoxReplaceClick(Sender: TObject);
begin
  ButtonReplaceAll.Visible := True;
end;

procedure TFormFindReplace.AddReplaceItem;
var
  Index: Integer;
begin
  Index := ComboBoxReplaceText.Items.IndexOf(ComboBoxReplaceText.Text);
  if Index >= 0 then
  begin
    ComboBoxReplaceText.Items.Move(Index, 0);
    ComboBoxReplaceText.ItemIndex := 0;
  end
  else
    ComboBoxReplaceText.Items.Insert(0, ComboBoxReplaceText.Text);

  DataModuleCommon.Preferences.Search.RecentReplace.Assign(ComboBoxReplaceText.Items);
end;

procedure TFormFindReplace.AddSearchItem;
var
  Index: Integer;
begin
  Index := ComboBoxSearchText.Items.IndexOf(ComboBoxSearchText.Text);
  if Index >= 0 then
  begin
    ComboBoxSearchText.Items.Move(Index, 0);
    ComboBoxSearchText.ItemIndex := 0;
  end
  else
    ComboBoxSearchText.Items.Insert(0, ComboBoxSearchText.Text);

  DataModuleCommon.Preferences.Search.RecentSearch.Assign(ComboBoxSearchText.Items);
end;

procedure TFormFindReplace.PerformReplace(ReplaceAll: Boolean);
var
  Editor: TSynEdit;
  Options: TSynSearchOptions;
begin
  Editor := FormMain.FocusedEditor;
  if not Assigned(Editor) then
    Exit;

  Options := [];

  if CheckBoxCaseSensitivity.Checked then
    Include(Options, ssoMatchCase)
  else
    Exclude(Options, ssoMatchCase);
  if CheckBoxWholeWordOnly.Checked then
    Include(Options, ssoWholeWord)
  else
    Exclude(Options, ssoWholeWord);
  if RadioButtonBackward.Checked then
    Include(Options, ssoBackwards)
  else
    Exclude(Options, ssoBackwards);
  if RadioButtonEntireScope.Checked then
    Include(Options, ssoEntireScope)
  else
    Exclude(Options, ssoEntireScope);
  if RadioButtonSelectedText.Checked then
    Include(Options, ssoSelectedOnly)
  else
    Exclude(Options, ssoSelectedOnly);
  if CheckBoxPromptEachReplace.Checked then
    Include(Options, ssoPrompt)
  else
    Exclude(Options, ssoPrompt);

  Include(Options, ssoReplace);
  if ReplaceAll then
    Include(Options, ssoReplaceAll)
  else
    Exclude(Options, ssoReplaceAll);

  AddSearchItem;
  AddReplaceItem;

  Editor.SearchReplace(ComboBoxSearchText.Text, ComboBoxReplaceText.Text, Options);
end;

procedure TFormFindReplace.PerformSearch;
var
  Editor: TSynEdit;
  Options: TSynSearchOptions;
begin
  Editor := FormMain.FocusedEditor;
  if not Assigned(Editor) then
    Exit;

  Options := [];

  if CheckBoxCaseSensitivity.Checked then
    Include(Options, ssoMatchCase)
  else
    Exclude(Options, ssoMatchCase);
  if CheckBoxWholeWordOnly.Checked then
    Include(Options, ssoWholeWord)
  else
    Exclude(Options, ssoWholeWord);
  if RadioButtonBackward.Checked then
    Include(Options, ssoBackwards)
  else
    Exclude(Options, ssoBackwards);
  if RadioButtonEntireScope.Checked then
    Include(Options, ssoEntireScope)
  else
    Exclude(Options, ssoEntireScope);
  if RadioButtonSelectedText.Checked then
    Include(Options, ssoSelectedOnly)
  else
    Exclude(Options, ssoSelectedOnly);
  if CheckBoxPromptEachReplace.Checked then
    Include(Options, ssoPrompt)
  else
    Exclude(Options, ssoPrompt);

  Exclude(Options, ssoReplace);

  AddSearchItem;

  Editor.SearchReplace(ComboBoxSearchText.Text, ComboBoxReplaceText.Text, Options);
end;

procedure TFormFindReplace.ButtonOKClick(Sender: TObject);
begin
  if CheckBoxReplace.Checked then
    PerformSearch
  else
    PerformReplace;
end;

procedure TFormFindReplace.ButtonReplaceAllClick(Sender: TObject);
begin
  PerformReplace(True);
end;

end.
