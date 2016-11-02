unit Hope.Dialogs.ProjectOptions;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, 
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  VirtualTrees, Hope.Dialog, Hope.DataModule, Hope.Project.Options,
  Vcl.Samples.Spin;

type
  TTabSheetItem = record
    TabSheet: TTabSheet;
  end;
  PTabSheetItem = ^TTabSheetItem;

  TFormProjectOptions = class(TFormDialog)
    Bevel: TBevel;
    PageControl: TPageControl;
    TabSheetCompiler: TTabSheet;
    TabSheetCompilerLinker: TTabSheet;
    TabSheetExecution: TTabSheet;
    TabSheetFilter: TTabSheet;
    TabSheetIcon: TTabSheet;
    TabSheetProject: TTabSheet;
    TabSheetVersion: TTabSheet;
    TreeCategory: TVirtualStringTree;
    GroupBoxAuthor: TGroupBox;
    LabelAuthorName: TLabel;
    EditAuthorEmail: TEdit;
    EditAuthorName: TEdit;
    LabelEmail: TLabel;
    GroupBoxInformation: TGroupBox;
    MemoDescription: TMemo;
    EditProjectName: TEdit;
    LabelName: TLabel;
    LabelDescription: TLabel;
    LabelWebsite: TLabel;
    EditAuthorWebsite: TEdit;
    GroupBox1: TGroupBox;
    LabelVersionMajor: TLabel;
    SpinEditVersionMajor: TSpinEdit;
    SpinEditVersionMinor: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    SpinEditVersionRelease: TSpinEdit;
    SpinEditVersionBuild: TSpinEdit;
    Label3: TLabel;
    CheckBoxAutoIncrement: TCheckBox;
    LabelFullVersionNumber: TLabel;
    LabelFullVersionNumberValue: TLabel;
    CheckBoxAssertions: TCheckBox;
    CheckBoxOptimizations: TCheckBox;
    ComboBoxHintLevel: TComboBox;
    LabelHintLevel: TLabel;
    TabSheetCodeGenJS: TTabSheet;
    CheckBoxObfuscation: TCheckBox;
    CheckBoxInlineMagic: TCheckBox;
    CheckBoxIgnorePublished: TCheckBox;
    GroupBoxChecks: TGroupBox;
    CheckBoxRangeChecks: TCheckBox;
    CheckBoxInstanceChecks: TCheckBox;
    CheckBoxConditionChecks: TCheckBox;
    CheckBoxLoopChecks: TCheckBox;
    CheckBoxDevirtualize: TCheckBox;
    CheckBoxEmitRTTI: TCheckBox;
    CheckBoxEmitSourceLocation: TCheckBox;
    CheckBoxOptimizeForSize: TCheckBox;
    CheckBoxSmartLinking: TCheckBox;
    EditMainBodyName: TEdit;
    LabelMainBodyName: TLabel;
    LabelVerbosity: TLabel;
    ComboBoxVerbosity: TComboBox;
    LabelIndentSize: TLabel;
    SpinEditIndentSize: TSpinEdit;
    CheckBoxEmitFinalization: TCheckBox;
    procedure TreeCategoryGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure TreeCategoryGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure TreeCategoryIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure TreeCategoryChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure SpinEditVersionMajorChange(Sender: TObject);
    procedure SpinEditVersionMinorChange(Sender: TObject);
    procedure SpinEditVersionReleaseChange(Sender: TObject);
    procedure SpinEditVersionBuildChange(Sender: TObject);
  private
    procedure UpdateTree;
    procedure UpdateFullVersionInformation;
  public
    procedure AfterConstruction; override;

    class procedure CreateAndShow(Options: THopeProjectOptions);

    procedure Load(Options: THopeProjectOptions);
    procedure Store(Options: THopeProjectOptions);
  end;

implementation

uses
  System.Math, Vcl.FileCtrl;

{$R *.dfm}

{ TFormProjectOptions }

class procedure TFormProjectOptions.CreateAndShow(Options: THopeProjectOptions);
begin
  // show project options dialog
  with TFormProjectOptions.Create(nil) do
  try
    ShowModal;

    Load(Options);
  finally
    Free;
  end;
end;

procedure TFormProjectOptions.AfterConstruction;
begin
  inherited;

  UpdateTree;
end;

procedure TFormProjectOptions.TreeCategoryChange(Sender: TBaseVirtualTree;
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
    Add(TabSheetCompilerLinker, ParentNode);
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

procedure TFormProjectOptions.Load(Options: THopeProjectOptions);
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
  CheckBoxRangeChecks := Options.CodeGenOptions.RangeChecks;
  CheckBoxInstanceChecks := Options.CodeGenOptions.InstanceChecks;
  CheckBoxLoopChecks := Options.CodeGenOptions.LoopChecks;
  CheckBoxConditionChecks := Options.CodeGenOptions.ConditionChecks;
  CheckBoxInlineMagic := Options.CodeGenOptions.InlineMagics;
  CheckBoxObfuscation := Options.CodeGenOptions.Obfuscation;
  CheckBoxEmitSourceLocation := Options.CodeGenOptions.EmitSourceLocation;
  CheckBoxOptimizeForSize := Options.CodeGenOptions.OptimizeForSize;
  CheckBoxSmartLinking := Options.CodeGenOptions.SmartLinking;
  CheckBoxDevirtualize := Options.CodeGenOptions.Devirtualize;
  CheckBoxEmitRTTI := Options.CodeGenOptions.EmitRTTI;
  CheckBoxEmitFinalization := Options.CodeGenOptions.EmitFinalization;
  CheckBoxIgnorePublished := Options.CodeGenOptions.IgnorePublishedInImplementation;
  EditMainBodyName.Text := Options.CodeGenOptions.MainBody;
  SpinEditIndentSize.Value := Options.CodeGenOptions.IndentSize;
  ComboBoxVerbosity.ItemIndex := Options.CodeGenOptions.Verbosity;
end;

procedure TFormProjectOptions.Store(Options: THopeProjectOptions);
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
  Options.CodeGenOptions.RangeChecks := CheckBoxRangeChecks;
  Options.CodeGenOptions.InstanceChecks := CheckBoxInstanceChecks;
  Options.CodeGenOptions.LoopChecks := CheckBoxLoopChecks;
  Options.CodeGenOptions.ConditionChecks := CheckBoxConditionChecks;
  Options.CodeGenOptions.InlineMagics := CheckBoxInlineMagic;
  Options.CodeGenOptions.Obfuscation := CheckBoxObfuscation;
  Options.CodeGenOptions.EmitSourceLocation := CheckBoxEmitSourceLocation;
  Options.CodeGenOptions.OptimizeForSize := CheckBoxOptimizeForSize;
  Options.CodeGenOptions.SmartLinking := CheckBoxSmartLinking;
  Options.CodeGenOptions.Devirtualize := CheckBoxDevirtualize;
  Options.CodeGenOptions.EmitRTTI := CheckBoxEmitRTTI;
  Options.CodeGenOptions.EmitFinalization := CheckBoxEmitFinalization;
  Options.CodeGenOptions.IgnorePublishedInImplementation := CheckBoxIgnorePublished;
  Options.CodeGenOptions.MainBody := EditMainBodyName.Text;
  Options.CodeGenOptions.IndentSize := SpinEditIndentSize.Value;
  Options.CodeGenOptions.Verbosity := ComboBoxVerbosity.ItemIndex;
end;

end.
