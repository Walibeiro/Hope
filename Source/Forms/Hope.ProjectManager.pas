unit Hope.ProjectManager;

interface

{$I Hope.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls,
  VirtualTrees, Hope.Docking.Form, Hope.Project, Hope.Project.Files;

type
  PProjectNodeData = ^TProjectNodeData;
  TProjectNodeData = record
    Caption: string;
    Project: THopeProject;
    ProjectFile: THopeProjectFile;
    IsProject: Boolean;
  end;

  TFormProjectManager = class(TFormDockable)
    ToolBar: TToolBar;
    TreeProject: TVirtualStringTree;
    ToolButtonActiveProject: TToolButton;
    ToolButtonAddNewProject: TToolButton;
    ToolButtonRemoveProject: TToolButton;
    ToolButtonView: TToolButton;
    ToolButtonSplitter: TToolButton;
    procedure TreeProjectCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure TreeProjectDblClick(Sender: TObject);
    procedure TreeProjectFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeProjectGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure TreeProjectIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure TreeProjectNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: string);
    procedure TreeProjectEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure TreeProjectGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
  public
    procedure AfterConstruction; override;
    procedure UpdateNodes;
  end;

implementation

uses
  Hope.Main, Hope.DataModule.ImageLists, System.Math;

{$R *.dfm}

{ TFormProjectManager }

procedure TFormProjectManager.AfterConstruction;
begin
  inherited;

  // Configure project tree
  TreeProject.NodeDataSize := SizeOf(TProjectNodeData);
  TreeProject.RootNodeCount := 0;
  TreeProject.DefaultNodeHeight := 20;
  TreeProject.Enabled := False;
  TreeProject.Images := DataModuleImageLists.ImageList16;
  TreeProject.StateImages := DataModuleImageLists.ImageList16;
end;

procedure TFormProjectManager.TreeProjectCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  NodeData: array [0 .. 1] of PProjectNodeData;
begin
  NodeData[0] := Sender.GetNodeData(Node1);
  NodeData[1] := Sender.GetNodeData(Node2);

  if not (assigned(NodeData[0].ProjectFile) and assigned(NodeData[1].ProjectFile)) then
    Result := CompareText(NodeData[0].Caption, NodeData[1].Caption)
  else case Column of
    0:
    begin
      Result := CompareText(NodeData[0].ProjectFile.Extension, NodeData[1].ProjectFile.Extension);
      if Result = 0 then
        Result := CompareText(NodeData[0].Caption, NodeData[1].Caption);
    end;
  end;
end;

procedure TFormProjectManager.TreeProjectDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  NodeData: PProjectNodeData;
  FileName: string;
begin
  // eventually expand or collapse focussed tree
  if Assigned(TreeProject.FocusedNode) then
  begin
    Node := TreeProject.FocusedNode;
    NodeData := PProjectNodeData(TreeProject.GetNodeData(Node));
    if Assigned(NodeData.ProjectFile) then
    begin
      FileName := NodeData.ProjectFile.FileName;
      if IsRelativePath(ExtractFilePath(FileName)) then
        FileName := NodeData.Project.RootPath + FileName;

      FormMain.FocusEditor(FileName);
    end;
  end;
end;

procedure TFormProjectManager.TreeProjectEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  NodeData: PProjectNodeData;
begin
  // check if a node is present at all
  if Node = nil then
    Exit;

  // get node data and check for project file
  NodeData := Sender.GetNodeData(Node);
  Allowed := Assigned(NodeData^.ProjectFile);
end;

procedure TFormProjectManager.TreeProjectFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  NodeData: PProjectNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  Finalize(NodeData^);
end;

procedure TFormProjectManager.TreeProjectGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  NodeData: PProjectNodeData;
begin
  if Kind in [ikNormal, ikSelected] then
  begin
    NodeData := Sender.GetNodeData(Node);
    if not Assigned(NodeData^.Project) then
      ImageIndex := 50
    else
    if NodeData^.IsProject then
      ImageIndex := 1
    else
      ImageIndex := 44;
  end;
end;

procedure TFormProjectManager.TreeProjectGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeData: PProjectNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData^.Caption;
end;

procedure TFormProjectManager.TreeProjectIncrementalSearch(
  Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string;
  var Result: Integer);
var
  NodeData: PProjectNodeData;
  S: array [0 .. 1] of string;
begin
  NodeData := Sender.GetNodeData(Node);
  S[0] := LowerCase(SearchText);
  S[1] := LowerCase(NodeData.Caption);

  Result := StrLIComp(PChar(S[0]), PChar(S[1]), Min(Length(S[0]), Length(S[1])));
end;

procedure TFormProjectManager.TreeProjectNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: string);
var
  NodeData: PProjectNodeData;
begin
  // check for blank name
  NewText := Trim(NewText);
  if NewText = '' then
    Exit;

  // get node data
  NodeData := Sender.GetNodeData(Node);

  // TODO: rename project file "NodeData^.ProjectFile" to "NewText"

  // update caption
  NodeData^.Caption := NewText;
end;

procedure TFormProjectManager.UpdateNodes;
var
  NodeData: PProjectNodeData;
  ProjectNode, CurrentNode: PVirtualNode;
  ProjectIndex, FileIndex: Integer;
  Project: THopeProject;
begin
  TreeProject.BeginUpdate;
  try
    // clear existing items
    TreeProject.Clear;
    TreeProject.RootNodeCount := 1;

    // check for an active project
    if not Assigned(FormMain.Projects.ActiveProject) then
      Exit;

    NodeData := TreeProject.GetNodeData(TreeProject.TopNode);
    NodeData^.Caption := 'ProjectGroup';

    for ProjectIndex := 0 to FormMain.Projects.Count - 1 do
    begin
      Project := FormMain.Projects[ProjectIndex];

      ProjectNode := TreeProject.AddChild(TreeProject.TopNode);
      NodeData := TreeProject.GetNodeData(ProjectNode);
      NodeData^.Project := Project;
      NodeData^.ProjectFile := Project.MainScript;
      NodeData^.Caption := Project.Name;
      NodeData^.IsProject := True;

      for FileIndex := 0 to Project.Files.Count - 1 do
      begin
        CurrentNode := TreeProject.AddChild(ProjectNode);
        NodeData := TreeProject.GetNodeData(CurrentNode);
        NodeData^.Project := Project;
        NodeData^.ProjectFile := Project.Files[FileIndex];
        NodeData^.Caption := ExtractFileName(Project.Files[FileIndex].FileName);
        NodeData^.IsProject := False;
      end;
    end;

    // expand tree
    TreeProject.FullExpand(TreeProject.TopNode);
  finally
    TreeProject.EndUpdate;
  end;
end;

end.

