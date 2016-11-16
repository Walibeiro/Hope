unit Hope.Dialog.ProjectOptions;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Samples.Spin,
  VirtualTrees, Hope.Dialog, Hope.DataModule, Hope.Project,
  Hope.Project.Options;

type
  TTabSheetItem = record
    TabSheet: TTabSheet;
  end;
  PTabSheetItem = ^TTabSheetItem;

  TFormProjectOptions = class(TFormDialog)
    Bevel: TBevel;
    ButtonFileName: TButton;
    ButtonPath: TButton;
    CheckBoxAssertions: TCheckBox;
    CheckBoxAutoIncrement: TCheckBox;
    CheckBoxConditionChecks: TCheckBox;
    CheckBoxDevirtualize: TCheckBox;
    CheckBoxEditorMode: TCheckBox;
    CheckBoxEmitFinalization: TCheckBox;
    CheckBoxEmitRTTI: TCheckBox;
    CheckBoxEmitSourceLocation: TCheckBox;
    CheckBoxIgnorePublished: TCheckBox;
    CheckBoxInlineMagic: TCheckBox;
    CheckBoxInstanceChecks: TCheckBox;
    CheckBoxLoopChecks: TCheckBox;
    CheckBoxObfuscation: TCheckBox;
    CheckBoxOptimizations: TCheckBox;
    CheckBoxOptimizeForSize: TCheckBox;
    CheckBoxRangeChecks: TCheckBox;
    CheckBoxSmartLinking: TCheckBox;
    ComboBoxHintLevel: TComboBox;
    ComboBoxVerbosity: TComboBox;
    EditAuthorEmail: TEdit;
    EditAuthorName: TEdit;
    EditAuthorWebsite: TEdit;
    EditConditionalDefines: TEdit;
    EditMainBodyName: TEdit;
    EditOutputFilename: TEdit;
    EditOutputPath: TEdit;
    EditProjectName: TEdit;
    GroupBoxAuthor: TGroupBox;
    GroupBoxChecks: TGroupBox;
    GroupBoxCompilerOptions: TGroupBox;
    GroupBoxConditionalDefines: TGroupBox;
    GroupBoxInformation: TGroupBox;
    GroupBoxOutput: TGroupBox;
    GroupBoxVersion: TGroupBox;
    LabelAuthorName: TLabel;
    LabelDescription: TLabel;
    LabelEmail: TLabel;
    LabelFullVersionNumber: TLabel;
    LabelFullVersionNumberValue: TLabel;
    LabelHintLevel: TLabel;
    LabelIndentSize: TLabel;
    LabelMainBodyName: TLabel;
    LabelName: TLabel;
    LabelOutputFilename: TLabel;
    LabelOutputPath: TLabel;
    LabelVerbosity: TLabel;
    LabelVersionBuild: TLabel;
    LabelVersionMajor: TLabel;
    LabelVersionMinor: TLabel;
    LabelVersionRelease: TLabel;
    LabelWebsite: TLabel;
    MemoDescription: TMemo;
    PageControl: TPageControl;
    SpinEditIndentSize: TSpinEdit;
    SpinEditVersionBuild: TSpinEdit;
    SpinEditVersionMajor: TSpinEdit;
    SpinEditVersionMinor: TSpinEdit;
    SpinEditVersionRelease: TSpinEdit;
    TabSheetCodeGenJS: TTabSheet;
    TabSheetCompiler: TTabSheet;
    TabSheetCompilerOutput: TTabSheet;
    TabSheetExecution: TTabSheet;
    TabSheetFilter: TTabSheet;
    TabSheetIcon: TTabSheet;
    TabSheetProject: TTabSheet;
    TabSheetVersion: TTabSheet;
    TreeCategory: TVirtualStringTree;
    procedure ButtonPathClick(Sender: TObject);
    procedure ButtonFileNameClick(Sender: TObject);
    procedure SpinEditVersionMajorChange(Sender: TObject);
    procedure SpinEditVersionMinorChange(Sender: TObject);
    procedure SpinEditVersionReleaseChange(Sender: TObject);
    procedure SpinEditVersionBuildChange(Sender: TObject);
    procedure TreeCategoryGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure TreeCategoryGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure TreeCategoryIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure TreeCategoryChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
  private
    procedure UpdateTree;
    procedure UpdateFullVersionInformation;
    procedure LoadOptions(Options: THopeProjectOptions);
    procedure SaveOptions(Options: THopeProjectOptions);
  public
    procedure AfterConstruction; override;

    class function CreateAndShow(const Project: THopeProject): Boolean;

    procedure LoadFromProject(Project: THopeProject);
    procedure SaveToProject(Project: THopeProject);
  end;

implementation

uses
  System.Math, Vcl.FileCtrl;

{$R *.dfm}

{ TFormProjectOptions }

class function TFormProjectOptions.CreateAndShow(const Project: THopeProject): Boolean;
begin
  Result := False;

  // show project options dialog
  with TFormProjectOptions.Create(nil) do
  try
    LoadFromProject(Project);

    Result := (ShowModal = mrOk);

    if Result then
      SaveToProject(Project);
  finally
    Free;
  end;
end;

procedure TFormProjectOptions.AfterConstruction;
begin
  inherited;

  TreeCategory.NodeDataSize := SizeOf(TTabSheetItem);

  UpdateTree;
end;

procedure TFormProjectOptions.ButtonFileNameClick(Sender: TObject);
begin
  with TSaveDialog.Create(Self) do
  try
    DefaultExt := '.js';
    Filter := 'JavaScript (*.js)|*.js';
  finally
    Free;
  end;
end;

procedure TFormProjectOptions.ButtonPathClick(Sender: TObject);
var
  Directory: string;
begin
  // show dialog to specify output path
  Directory := EditOutputPath.Text;
  if SelectDirectory('Output Path', Directory, Directory, []) then
    EditOutputPath.Text := Directory;
end;

procedure TFormProjectOptions.TreeCategoryChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  NodeData: PTabSheetItem;
begin
  // change active page according to the currently selected tree item
  if Assigned(Node) then
  begin
    NodeData := Sender.GetNodeData(Node);
    PageControl.ActivePage := NodeData^.TabSheet;
  end;
end;

procedure TFormProjectOptions.TreeCategoryGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  NodeData: PTabSheetItem;
begin
  if Kind in [ikNormal, ikSelected] then
  begin
    NodeData := Sender.GetNodeData(Node);
    ImageIndex := NodeData^.TabSheet.ImageIndex;
  end;
end;

procedure TFormProjectOptions.TreeCategoryGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeData: PTabSheetItem;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData^.TabSheet.Caption;
end;

procedure TFormProjectOptions.TreeCategoryIncrementalSearch(
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

procedure TFormProjectOptions.UpdateTree;

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
  SubNode: PVirtualNode;
  Index: Integer;
begin
  TreeCategory.BeginUpdate;
  try
    TreeCategory.Clear;

    Add(TabSheetProject);
    Add(TabSheetVersion);
    ParentNode := Add(TabSheetCompiler);
    Add(TabSheetCodeGenJS, ParentNode);
    Add(TabSheetCompilerOutput, ParentNode);
    TreeCategory.Expanded[ParentNode] := True;

    Add(TabSheetExecution);
  finally
    TreeCategory.EndUpdate;
  end;

  // disable tabs
  for Index := 0 to PageControl.PageCount - 1 do
    PageControl.Pages[Index].TabVisible := False;
end;

procedure TFormProjectOptions.SpinEditVersionBuildChange(Sender: TObject);
begin
  UpdateFullVersionInformation;
end;

procedure TFormProjectOptions.SpinEditVersionMajorChange(Sender: TObject);
begin
  UpdateFullVersionInformation;
end;

procedure TFormProjectOptions.SpinEditVersionMinorChange(Sender: TObject);
begin
  UpdateFullVersionInformation;
end;

procedure TFormProjectOptions.SpinEditVersionReleaseChange(Sender: TObject);
begin
  UpdateFullVersionInformation;
end;

procedure TFormProjectOptions.UpdateFullVersionInformation;
begin
  LabelFullVersionNumberValue.Caption :=
    SpinEditVersionMajor.Text + '.' +
    SpinEditVersionMinor.Text + '.' +
    SpinEditVersionRelease.Text + '.' +
    SpinEditVersionBuild.Text;
end;

procedure TFormProjectOptions.LoadOptions(Options: THopeProjectOptions);
begin
  // project information
  EditProjectName.Text := Options.Information.Name;
  MemoDescription.Text := Options.Information.Description;
  EditAuthorName.Text := Options.Information.Author.Name;
  EditAuthorEmail.Text := Options.Information.Author.Email;
  EditAuthorWebsite.Text := Options.Information.Author.Website;

  // version
  SpinEditVersionMajor.Text := IntToStr(Options.Version.Major);
  SpinEditVersionMinor.Text := IntToStr(Options.Version.Minor);
  SpinEditVersionRelease.Text := IntToStr(Options.Version.Release);
  SpinEditVersionBuild.Text := IntToStr(Options.Version.Build);
  CheckBoxAutoIncrement.Checked := Options.Version.AutoIncrement;

  // compiler options
  CheckBoxAssertions.Checked := Options.CompilerOptions.Assertions;
  CheckBoxOptimizations.Checked := Options.CompilerOptions.Optimizations;
  ComboBoxHintLevel.ItemIndex := Options.CompilerOptions.HintsLevel;

  // JS codegen options
  CheckBoxRangeChecks.Checked := Options.CodeGenOptions.RangeChecks;
  CheckBoxInstanceChecks.Checked := Options.CodeGenOptions.InstanceChecks;
  CheckBoxLoopChecks.Checked := Options.CodeGenOptions.LoopChecks;
  CheckBoxConditionChecks.Checked := Options.CodeGenOptions.ConditionChecks;
  CheckBoxInlineMagic.Checked := Options.CodeGenOptions.InlineMagics;
  CheckBoxObfuscation.Checked := Options.CodeGenOptions.Obfuscation;
  CheckBoxEmitSourceLocation.Checked := Options.CodeGenOptions.EmitSourceLocation;
  CheckBoxOptimizeForSize.Checked := Options.CodeGenOptions.OptimizeForSize;
  CheckBoxSmartLinking.Checked := Options.CodeGenOptions.SmartLinking;
  CheckBoxDevirtualize.Checked := Options.CodeGenOptions.Devirtualize;
  CheckBoxEmitRTTI.Checked := Options.CodeGenOptions.EmitRTTI;
  CheckBoxEmitFinalization.Checked := Options.CodeGenOptions.EmitFinalization;
  CheckBoxIgnorePublished.Checked := Options.CodeGenOptions.IgnorePublishedInImplementation;
  EditMainBodyName.Text := Options.CodeGenOptions.MainBody;
  SpinEditIndentSize.Value := Options.CodeGenOptions.IndentSize;
  ComboBoxVerbosity.ItemIndex := Options.CodeGenOptions.Verbosity;

  // Filter
  CheckBoxEditorMode.Checked := Options.FilterOptions.EditorMode;
end;

procedure TFormProjectOptions.SaveOptions(Options: THopeProjectOptions);
begin
  // project information
  Options.Information.Name := EditProjectName.Text;
  Options.Information.Description := MemoDescription.Text;
  Options.Information.Author.Name := EditAuthorName.Text;
  Options.Information.Author.Email := EditAuthorEmail.Text;
  Options.Information.Author.Website := EditAuthorWebsite.Text;

  // version
  Options.Version.Major := StrToInt(SpinEditVersionMajor.Text);
  Options.Version.Minor := StrToInt(SpinEditVersionMinor.Text);
  Options.Version.Release := StrToInt(SpinEditVersionRelease.Text);
  Options.Version.Build := StrToInt(SpinEditVersionBuild.Text);
  Options.Version.AutoIncrement := CheckBoxAutoIncrement.Checked;

  // compiler options
  Options.CompilerOptions.Assertions := CheckBoxAssertions.Checked;
  Options.CompilerOptions.Optimizations := CheckBoxOptimizations.Checked;
  Options.CompilerOptions.HintsLevel := ComboBoxHintLevel.ItemIndex;

  // JS codegen options
  Options.CodeGenOptions.RangeChecks := CheckBoxRangeChecks.Checked;
  Options.CodeGenOptions.InstanceChecks := CheckBoxInstanceChecks.Checked;
  Options.CodeGenOptions.LoopChecks := CheckBoxLoopChecks.Checked;
  Options.CodeGenOptions.ConditionChecks := CheckBoxConditionChecks.Checked;
  Options.CodeGenOptions.InlineMagics := CheckBoxInlineMagic.Checked;
  Options.CodeGenOptions.Obfuscation := CheckBoxObfuscation.Checked;
  Options.CodeGenOptions.EmitSourceLocation := CheckBoxEmitSourceLocation.Checked;
  Options.CodeGenOptions.OptimizeForSize := CheckBoxOptimizeForSize.Checked;
  Options.CodeGenOptions.SmartLinking := CheckBoxSmartLinking.Checked;
  Options.CodeGenOptions.Devirtualize := CheckBoxDevirtualize.Checked;
  Options.CodeGenOptions.EmitRTTI := CheckBoxEmitRTTI.Checked;
  Options.CodeGenOptions.EmitFinalization := CheckBoxEmitFinalization.Checked;
  Options.CodeGenOptions.IgnorePublishedInImplementation := CheckBoxIgnorePublished.Checked;
  Options.CodeGenOptions.MainBody := EditMainBodyName.Text;
  Options.CodeGenOptions.IndentSize := SpinEditIndentSize.Value;
  Options.CodeGenOptions.Verbosity := ComboBoxVerbosity.ItemIndex;

  // Filter
  Options.FilterOptions.EditorMode := CheckBoxEditorMode.Checked;
end;

procedure TFormProjectOptions.LoadFromProject(Project: THopeProject);
begin
(*
  EditProjectName.Text := Project.Name;
  MemoDescription.Text := Project.Description;
  EditAuthorEmail.Text := Project.Author;
  EditAuthorName.Text := Project.Au;
*)

  LoadOptions(Project.Options);
end;

procedure TFormProjectOptions.SaveToProject(Project: THopeProject);
begin
(*
  Project.Name := EditProjectName.Text;
  Project.Description := MemoDescription.Text;
*)

  SaveOptions(Project.Options);
end;

end.
