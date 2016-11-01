unit Hope.Dialogs.ProjectOptions;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, 
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  VirtualTrees, Hope.Dialog, Hope.DataModule, Hope.Project.Options;

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
  public
    procedure AfterConstruction; override;

    procedure Load(ProjectOptions: THopeProjectOptions);
    procedure Store(ProjectOptions: THopeProjectOptions);
  end;

implementation

uses
  System.Math, Vcl.FileCtrl;

{$R *.dfm}

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

    ParentNode := Add(TabSheetCompiler);
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

procedure TFormProjectOptions.Load(ProjectOptions: THopeProjectOptions);
begin
  EditProjectName.Text := ProjectOptions.Information.Name;
  MemoDescription.Text := ProjectOptions.Information.Description;
  EditAuthorName.Text := ProjectOptions.Information.Author.Name;
  EditAuthorEmail.Text := ProjectOptions.Information.Author.Email;
  EditAuthorWebsite.Text := ProjectOptions.Information.Author.Website;
end;

procedure TFormProjectOptions.Store(ProjectOptions: THopeProjectOptions);
begin
  ProjectOptions.Information.Name := EditProjectName.Text;
  ProjectOptions.Information.Description := MemoDescription.Text;
  ProjectOptions.Information.Author.Name := EditAuthorName.Text;
  ProjectOptions.Information.Author.Email := EditAuthorEmail.Text;
  ProjectOptions.Information.Author.Website := EditAuthorWebsite.Text;
end;

end.
