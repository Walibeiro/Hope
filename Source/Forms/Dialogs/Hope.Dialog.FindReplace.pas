unit Hope.Dialog.FindReplace;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  SynEdit, SynEditTypes, Hope.Dialog, Hope.Datamodule.Common;

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
    procedure ButtonCancelClick(Sender: TObject);
  private
    FLastOptions: TSynSearchOptions;
    procedure SetupOptions(Editor: TSynEdit);
  public
    procedure AfterConstruction; override;

    procedure AddSearchItem;
    procedure AddReplaceItem;

    procedure PerformSearch;
    procedure PerformReplace(ReplaceAll: Boolean = False);
    procedure PerformNext;
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

procedure TFormFindReplace.PerformNext;
var
  Editor: TSynEdit;
begin
  Editor := FormMain.FocusedEditor;
  if not Assigned(Editor) then
    Exit;

  Editor.SearchReplace(ComboBoxSearchText.Text, ComboBoxReplaceText.Text, FLastOptions);
end;

procedure TFormFindReplace.SetupOptions(Editor: TSynEdit);
begin
  if CheckBoxCaseSensitivity.Checked then
    Include(FLastOptions, ssoMatchCase)
  else
    Exclude(FLastOptions, ssoMatchCase);
  if CheckBoxWholeWordOnly.Checked then
    Include(FLastOptions, ssoWholeWord)
  else
    Exclude(FLastOptions, ssoWholeWord);
  if RadioButtonBackward.Checked then
    Include(FLastOptions, ssoBackwards)
  else
    Exclude(FLastOptions, ssoBackwards);
  if RadioButtonEntireScope.Checked then
    Include(FLastOptions, ssoEntireScope)
  else
    Exclude(FLastOptions, ssoEntireScope);
  if RadioButtonSelectedText.Checked then
    Include(FLastOptions, ssoSelectedOnly)
  else
    Exclude(FLastOptions, ssoSelectedOnly);
  if CheckBoxPromptEachReplace.Checked then
    Include(FLastOptions, ssoPrompt)
  else
    Exclude(FLastOptions, ssoPrompt);

  // setup search engine (normal or regex)
  if CheckBoxRegularExpressions.Checked then
    Editor.SearchEngine := DataModuleCommon.SynEditRegexSearch
  else
    Editor.SearchEngine := DataModuleCommon.SynEditSearch
end;

procedure TFormFindReplace.PerformReplace(ReplaceAll: Boolean);
var
  Editor: TSynEdit;
begin
  Editor := FormMain.FocusedEditor;
  if not Assigned(Editor) then
    Exit;

  SetupOptions(Editor);

  Include(FLastOptions, ssoReplace);
  if ReplaceAll then
    Include(FLastOptions, ssoReplaceAll)
  else
    Exclude(FLastOptions, ssoReplaceAll);

  AddSearchItem;
  AddReplaceItem;

  Editor.SearchReplace(ComboBoxSearchText.Text, ComboBoxReplaceText.Text, FLastOptions);
end;

procedure TFormFindReplace.PerformSearch;
var
  Editor: TSynEdit;
begin
  Editor := FormMain.FocusedEditor;
  if not Assigned(Editor) then
    Exit;

  SetupOptions(Editor);

  Exclude(FLastOptions, ssoReplace);

  AddSearchItem;

  Editor.SearchReplace(ComboBoxSearchText.Text, ComboBoxReplaceText.Text, FLastOptions);
end;

procedure TFormFindReplace.ButtonCancelClick(Sender: TObject);
begin
  if not (fsModal in FormState) then
    Close;
end;

procedure TFormFindReplace.ButtonOKClick(Sender: TObject);
begin
  if CheckBoxReplace.Checked then
    PerformReplace
  else
    PerformSearch;

  if not (fsModal in FormState) then
    Close;
end;

procedure TFormFindReplace.ButtonReplaceAllClick(Sender: TObject);
begin
  PerformReplace(True);
end;

end.
