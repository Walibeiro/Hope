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
  private
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  Hope.DataModule, Hope.Main, System.Math;

{$R *.dfm}

{ TFormProjectManager }

procedure TFormProjectManager.AfterConstruction;
begin
  inherited;
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
begin
  // eventually expand or collapse focussed tree
  if Assigned(TreeProject.FocusedNode) then
  begin
    Node := TreeProject.FocusedNode;
    NodeData := PProjectNodeData(TreeProject.GetNodeData(Node));
    if not Assigned(NodeData.ProjectFile) then
    begin
      TreeProject.Expanded[Node] := not TreeProject.Expanded[Node];
      Exit;
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

end.

