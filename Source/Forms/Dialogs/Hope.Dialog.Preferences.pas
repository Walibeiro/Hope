unit Hope.Dialog.Preferences;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.Actions, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.ActnList, Vcl.Samples.Spin,
  VirtualTrees, SynEdit, Hope.Dialog, Hope.DataModule;

type
  TTabSheetItem = record
    TabSheet: TTabSheet;
  end;
  PTabSheetItem = ^TTabSheetItem;

  TFormPreferences = class(TFormDialog)
    ActionLibraryPathAdd: TAction;
    ActionLibraryPathCleanUp: TAction;
    ActionLibraryPathDelete: TAction;
    ActionLibraryPathDown: TAction;
    ActionLibraryPathPick: TAction;
    ActionLibraryPathReplace: TAction;
    ActionLibraryPathUp: TAction;
    ActionList: TActionList;
    ActionLoad: TAction;
    ActionSave: TAction;
    Bevel: TBevel;
    ButtonAdd: TButton;
    ButtonCleanUp: TButton;
    ButtonDelete: TButton;
    ButtonDown: TButton;
    ButtonLoad: TButton;
    ButtonPick: TButton;
    ButtonProjectPath: TButton;
    ButtonReplace: TButton;
    ButtonSave: TButton;
    ButtonUp: TButton;
    CheckBoxAltSetsColumnMode: TCheckBox;
    CheckBoxAutoIndent: TCheckBox;
    CheckBoxAutoSizeMaxWidth: TCheckBox;
    CheckBoxBold: TCheckBox;
    CheckBoxDisableScrollArrows: TCheckBox;
    CheckBoxDragAndDropEditing: TCheckBox;
    CheckBoxEnhanceEndKey: TCheckBox;
    CheckBoxEnhanceHomeKey: TCheckBox;
    CheckBoxGroupUndo: TCheckBox;
    CheckBoxHalfPageScroll: TCheckBox;
    CheckBoxHideShowScrollbars: TCheckBox;
    CheckBoxItalic: TCheckBox;
    CheckBoxKeepCaretX: TCheckBox;
    CheckBoxRightMouseMoves: TCheckBox;
    CheckBoxScrollByOneLess: TCheckBox;
    CheckBoxScrollHintFollows: TCheckBox;
    CheckBoxScrollPastEOF: TCheckBox;
    CheckBoxScrollPastEOL: TCheckBox;
    CheckBoxShowScrollHint: TCheckBox;
    CheckBoxShowSpecialChars: TCheckBox;
    CheckBoxSmartTabDelete: TCheckBox;
    CheckBoxSmartTabs: TCheckBox;
    CheckBoxTabIndent: TCheckBox;
    CheckBoxTabsToSpaces: TCheckBox;
    CheckBoxTrimTrailingSpaces: TCheckBox;
    CheckBoxUnderlined: TCheckBox;
    CheckBoxWantTabs: TCheckBox;
    ColorBoxBackground: TColorBox;
    ColorBoxForeground: TColorBox;
    ComboBoxElement: TComboBox;
    ComboBoxInsertCaret: TComboBox;
    ComboBoxLanguage: TComboBox;
    ComboBoxOverwriteCaret: TComboBox;
    ComboBoxProjectPath: TComboBox;
    EditPath: TEdit;
    GroupBoxCaret: TGroupBox;
    GroupBoxElement: TGroupBox;
    GroupBoxLibraryPaths: TGroupBox;
    GroupBoxOptions: TGroupBox;
    GroupBoxPaths: TGroupBox;
    GroupBoxPreview: TGroupBox;
    GroupBoxSettings: TGroupBox;
    LabelBackground: TLabel;
    LabelElement: TLabel;
    LabelForeground: TLabel;
    LabelInsertCaret: TLabel;
    LabelLanguage: TLabel;
    LabelOverwriteCaret: TLabel;
    LabelProjectPath: TLabel;
    ListBoxLibraryPaths: TListBox;
    PageControl: TPageControl;
    PanelElementSettings: TPanel;
    PanelTop: TPanel;
    SynEditPreview: TSynEdit;
    TabSheetCodeInsight: TTabSheet;
    TabSheetDeployment: TTabSheet;
    TabSheetDesigner: TTabSheet;
    TabSheetEditorOptions: TTabSheet;
    TabSheetEnvironment: TTabSheet;
    TabSheetFormating: TTabSheet;
    TabSheetHighlighterOptions: TTabSheet;
    TabSheetLibraryPaths: TTabSheet;
    TabSheetRecentFiles: TTabSheet;
    TabSheetVersionControl: TTabSheet;
    TreeCategory: TVirtualStringTree;
    GroupBoxAutomaticFeatures: TGroupBox;
    LabelDelay: TLabel;
    LabelNone: TLabel;
    LabelOff: TLabel;
    LabelValue: TLabel;
    CheckBoxCodeSuggestions: TCheckBox;
    CheckBoxAutoParenthesis: TCheckBox;
    CheckBoxShowReservedWords: TCheckBox;
    CheckBoxCodeParameters: TCheckBox;
    TrackBarDelay: TTrackBar;
    CheckBoxTooltipSymbol: TCheckBox;
    CheckBoxBlockCompletion: TCheckBox;
    ComboBoxBlockCompletion: TComboBox;
    CheckBoxErrorInsight: TCheckBox;
    CheckBoxCodeTemplateCompletion: TCheckBox;
    LabelIndention: TLabel;
    SpinEditIndent: TSpinEdit;
    SpinEditIndentMax: TSpinEdit;
    LabelIndentMax: TLabel;
    GroupBoxColors: TGroupBox;
    LabelConflicts: TLabel;
    ColorBoxConflicted: TColorBox;
    Label1: TLabel;
    ColorBoxAdded: TColorBox;
    procedure TreeCategoryChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeCategoryGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure TreeCategoryGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure TreeCategoryIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure ButtonProjectPathClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrackBarDelayChange(Sender: TObject);
  private
    procedure UpdateTree;
  public
    procedure AfterConstruction; override;

    procedure Load;
    procedure Store;
  end;

implementation

uses
  System.Math, Vcl.FileCtrl, Hope.Common.Preferences;

{$R *.dfm}

{ TFormPreferences }

procedure TFormPreferences.AfterConstruction;
begin
  inherited;

  TreeCategory.NodeDataSize := SizeOf(TTabSheetItem);

  UpdateTree;
end;

procedure TFormPreferences.ButtonProjectPathClick(Sender: TObject);
var
  Directory: string;
begin
  inherited;

  // default to current directory
  Directory := ComboBoxProjectPath.Text;
  if Directory = '' then
    Directory := DataModuleCommon.Paths.Root;

  // show select directory dialog
  if SelectDirectory('Default Project Path', '', Directory) then
    ComboBoxProjectPath.Text := Directory;
end;

procedure TFormPreferences.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    Store;
end;

function DelayToTrackbar(Value: Integer): Integer;
begin
  if Value <= 100 then
    Result := Value div 10
  else if Value <= 1000 then
    Result := 9 + (Value div 100)
  else
    Result := 17 + (Value div 500);
end;

function TrackBarToDelay(Value: Integer): Integer;
begin
  if Value < 10 then
    Result := 10 * Value
  else if Value < 20 then
    Result := 100 + 100 * (Value - 10)
  else
    Result := 1500 + 500 * (Value - 20);
end;

procedure TFormPreferences.TrackBarDelayChange(Sender: TObject);
begin
  if TrackBarDelay.Position = 0 then
    LabelValue.Caption := 'Invoked immediately'
  else
  if TrackBarDelay.Position = TrackBarDelay.Max then
    LabelValue.Caption := 'Never invoked automatically'
  else
    LabelValue.Caption := IntToStr(TrackBarToDelay(TrackBarDelay.Position)) + 'ms';
end;

procedure TFormPreferences.TreeCategoryChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  NodeData: PTabSheetItem;
begin
  if Assigned(Node) then
  begin
    NodeData := Sender.GetNodeData(Node);
    PageControl.ActivePage := NodeData^.TabSheet;
  end;
end;

procedure TFormPreferences.TreeCategoryGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  NodeData: PTabSheetItem;
begin
  if Kind in [ikNormal, ikSelected] then
  begin
    NodeData := Sender.GetNodeData(Node);
    ImageIndex := NodeData^.TabSheet.ImageIndex;
  end;
end;

procedure TFormPreferences.TreeCategoryGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeData: PTabSheetItem;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData^.TabSheet.Caption;
end;

procedure TFormPreferences.TreeCategoryIncrementalSearch(
  Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string;
  var Result: Integer);
var
  NodeData: PTabSheetItem;
  S: array [0 .. 1] of string;
begin
  NodeData := Sender.GetNodeData(Node);
  S[0] := LowerCase(SearchText);
  S[1] := LowerCase(NodeData^.TabSheet.Caption);

  Result := StrLIComp(PChar(S[0]), PChar(S[1]), Min(Length(S[0]), Length(S[1])));
end;

procedure TFormPreferences.UpdateTree;

  function Add(TabSheet: TTabSheet; Parent: PVirtualNode = nil): PVirtualNode;
  var
    NodeData: PTabSheetItem;
  begin
    if Parent = nil then
      Parent := TreeCategory.RootNode;
    Result := TreeCategory.AddChild(Parent);
    NodeData := TreeCategory.GetNodeData(Result);
    NodeData^.TabSheet := TabSheet;
  end;

var
  ParentNode: PVirtualNode;
  Index: Integer;
begin
  TreeCategory.BeginUpdate;
  try
    TreeCategory.Clear;

    ParentNode := Add(TabSheetEnvironment);
    Add(TabSheetRecentFiles, ParentNode);
    Add(TabSheetLibraryPaths, ParentNode);
    Add(TabSheetDeployment, ParentNode);
    Add(TabSheetDesigner, ParentNode);
    TreeCategory.Expanded[ParentNode] := True;

    ParentNode := Add(TabSheetEditorOptions);
    Add(TabSheetHighlighterOptions, ParentNode);
    Add(TabSheetCodeInsight, ParentNode);
    TreeCategory.Expanded[ParentNode] := True;
  finally
    TreeCategory.EndUpdate;
  end;

  // disable tabs
  for Index := 0 to PageControl.PageCount - 1 do
    PageControl.Pages[Index].TabVisible := False;
end;

procedure TFormPreferences.Load;
var
  Preferences: THopePreferences;
begin
  Preferences := DataModuleCommon.Preferences;

  ComboBoxProjectPath.Text := Preferences.Environment.DefaultProjectPath;

  CheckBoxAltSetsColumnMode.Checked := Preferences.Editor.AltSetsColumnMode;
  CheckBoxAutoIndent.Checked := Preferences.Editor.AutoIndent;
  CheckBoxAutoSizeMaxWidth.Checked := Preferences.Editor.AutoSizeMaxScrollWidth;
  CheckBoxDisableScrollArrows.Checked := Preferences.Editor.DisableScrollArrows;
  CheckBoxDragAndDropEditing.Checked := Preferences.Editor.DragDropEditing;
//  CheckBoxDropFiles.Checked := Preferences.Editor.DropFiles;
  CheckBoxEnhanceHomeKey.Checked := Preferences.Editor.EnhanceHomeKey;
  CheckBoxEnhanceEndKey.Checked := Preferences.Editor.EnhanceEndKey;
  CheckBoxGroupUndo.Checked := Preferences.Editor.GroupUndo;
  CheckBoxHalfPageScroll.Checked := Preferences.Editor.HalfPageScroll;
  CheckBoxHideShowScrollbars.Checked := Preferences.Editor.HideShowScrollbars;
  CheckBoxKeepCaretX.Checked := Preferences.Editor.KeepCaretX;
//  CheckBoxNoCaret.Checked := Preferences.Editor.NoCaret;
//  CheckBoxNoSelection.Checked := Preferences.Editor.NoSelection;
  CheckBoxRightMouseMoves.Checked := Preferences.Editor.RightMouseMovesCursor;
  CheckBoxScrollByOneLess.Checked := Preferences.Editor.ScrollByOneLess;
  CheckBoxScrollHintFollows.Checked := Preferences.Editor.ScrollHintFollows;
  CheckBoxScrollPastEof.Checked := Preferences.Editor.ScrollPastEof;
  CheckBoxScrollPastEol.Checked := Preferences.Editor.ScrollPastEol;
  CheckBoxShowScrollHint.Checked := Preferences.Editor.ShowScrollHint;
  CheckBoxShowSpecialChars.Checked := Preferences.Editor.ShowSpecialChars;
  CheckBoxSmartTabDelete.Checked := Preferences.Editor.SmartTabDelete;
  CheckBoxSmartTabs.Checked := Preferences.Editor.SmartTabs;
//  CheckBoxSpecialLineDefaultFg.Checked := Preferences.Editor.SpecialLineDefaultFg;
  CheckBoxTabIndent.Checked := Preferences.Editor.TabIndent;
  CheckBoxTabsToSpaces.Checked := Preferences.Editor.TabsToSpaces;
  CheckBoxTrimTrailingSpaces.Checked := Preferences.Editor.TrimTrailingSpace;

  CheckBoxCodeSuggestions.Checked := Preferences.CodeInsight.CodeSuggestions.Enabled;
  CheckBoxAutoParenthesis.Checked := Preferences.CodeInsight.CodeSuggestions.AutoParenthesis;
  CheckBoxShowReservedWords.Checked := Preferences.CodeInsight.CodeSuggestions.ShowReservedWords;
  CheckBoxCodeParameters.Checked := Preferences.CodeInsight.CodeParametes;
  CheckBoxTooltipSymbol.Checked := Preferences.CodeInsight.TooltipSymbolInsight;
  CheckBoxBlockCompletion.Checked := Preferences.CodeInsight.BlockCompletion;
  CheckBoxErrorInsight.Checked := Preferences.CodeInsight.ErrorInsight;
  TrackBarDelay.Position := DelayToTrackbar(Preferences.CodeInsight.Delay);
  CheckBoxCodeTemplateCompletion.Checked := Preferences.CodeInsight.CodeTemplateCompletion;

  SpinEditIndent.Value := Preferences.Formating.Indention;

  ColorBoxConflicted.Color := Preferences.Versioning.Colors.Conflicted;
  ColorBoxAdded.Color := Preferences.Versioning.Colors.Added;
end;

procedure TFormPreferences.Store;
var
  Preferences: THopePreferences;
begin
  Preferences := DataModuleCommon.Preferences;

  Preferences.Environment.DefaultProjectPath := ComboBoxProjectPath.Text;

  Preferences.Editor.AltSetsColumnMode := CheckBoxAltSetsColumnMode.Checked;
  Preferences.Editor.AutoIndent := CheckBoxAutoIndent.Checked;
  Preferences.Editor.AutoSizeMaxScrollWidth := CheckBoxAutoSizeMaxWidth.Checked;
  Preferences.Editor.DisableScrollArrows := CheckBoxDisableScrollArrows.Checked;
  Preferences.Editor.DragDropEditing := CheckBoxDragAndDropEditing.Checked;
//  Preferences.Editor.DropFiles := CheckBoxDropFiles.Checked;
  Preferences.Editor.EnhanceHomeKey := CheckBoxEnhanceHomeKey.Checked;
  Preferences.Editor.EnhanceEndKey := CheckBoxEnhanceEndKey.Checked;
  Preferences.Editor.GroupUndo := CheckBoxGroupUndo.Checked;
  Preferences.Editor.HalfPageScroll := CheckBoxHalfPageScroll.Checked;
  Preferences.Editor.HideShowScrollbars := CheckBoxHideShowScrollbars.Checked;
  Preferences.Editor.KeepCaretX := CheckBoxKeepCaretX.Checked;
//  Preferences.Editor.NoCaret := CheckBoxNoCaret.Checked;
//  Preferences.Editor.NoSelection := CheckBoxNoSelection.Checked;
  Preferences.Editor.RightMouseMovesCursor := CheckBoxRightMouseMoves.Checked;
  Preferences.Editor.ScrollByOneLess := CheckBoxScrollByOneLess.Checked;
  Preferences.Editor.ScrollHintFollows := CheckBoxScrollHintFollows.Checked;
  Preferences.Editor.ScrollPastEof := CheckBoxScrollPastEof.Checked;
  Preferences.Editor.ScrollPastEol := CheckBoxScrollPastEol.Checked;
  Preferences.Editor.ShowScrollHint := CheckBoxShowScrollHint.Checked;
  Preferences.Editor.ShowSpecialChars := CheckBoxShowSpecialChars.Checked;
  Preferences.Editor.SmartTabDelete := CheckBoxSmartTabDelete.Checked;
  Preferences.Editor.SmartTabs := CheckBoxSmartTabs.Checked;
//  Preferences.Editor.SpecialLineDefaultFg := CheckBoxSpecialLineDefaultFg.Checked;
  Preferences.Editor.TabIndent := CheckBoxTabIndent.Checked;
  Preferences.Editor.TabsToSpaces := CheckBoxTabsToSpaces.Checked;
  Preferences.Editor.TrimTrailingSpace := CheckBoxTrimTrailingSpaces.Checked;

  Preferences.CodeInsight.CodeSuggestions.Enabled := CheckBoxCodeSuggestions.Checked;
  Preferences.CodeInsight.CodeSuggestions.AutoParenthesis := CheckBoxAutoParenthesis.Checked;
  Preferences.CodeInsight.CodeSuggestions.ShowReservedWords := CheckBoxShowReservedWords.Checked;
  Preferences.CodeInsight.CodeParametes := CheckBoxCodeParameters.Checked;
  Preferences.CodeInsight.TooltipSymbolInsight := CheckBoxTooltipSymbol.Checked;
  Preferences.CodeInsight.BlockCompletion := CheckBoxBlockCompletion.Checked;
  Preferences.CodeInsight.ErrorInsight := CheckBoxErrorInsight.Checked;
  Preferences.CodeInsight.Delay := TrackBarToDelay(TrackBarDelay.Position);
  Preferences.CodeInsight.CodeTemplateCompletion := CheckBoxCodeTemplateCompletion.Checked;

  Preferences.Formating.Indention := SpinEditIndent.Value;

  Preferences.Versioning.Colors.Conflicted := ColorBoxConflicted.Color;
  Preferences.Versioning.Colors.Added := ColorBoxAdded.Color;
end;

end.
