unit Hope.MessageWindow.Compiler;

interface

{$I Hope.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  VirtualTrees, dwsErrors, dwsStrings, Hope.MessageWindow;

type
  TLocateDirection = (ldForward, ldBackward);

  TCompilerMessageItem = record
  type
    TCompilerMessageType = (tmInfo, tmHint, tmWarning, tmError);
  public
    MessageText: string;
    MessageType: TCompilerMessageType;
    Line: Integer;
    Col: Integer;
    SourceName: string;
  end;
  PCompilerMessageItem = ^TCompilerMessageItem;

  TFormCompilerMessages = class(TFormMessageWindow)
    procedure TreeMessagesDblClick(Sender: TObject);
    procedure TreeMessagesCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure TreeMessagesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure TreeMessagesFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure TreeMessagesGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure TreeMessagesPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
  private
    FLastTreeNode: PVirtualNode;
  public
    procedure AfterConstruction; override;

    procedure Clear; override;

    procedure LocateFirstError;
    procedure LocateError(Direction: TLocateDirection);
    procedure LocateNode(MessageItem: TCompilerMessageItem);

    function GetMessageTypeForLine(SourceName: string; Line: Integer;
      out State: TCompilerMessageItem.TCompilerMessageType): Boolean;

    procedure LogMessages(const MessageList: TdwsMessageList);
    procedure LogMessage(const AText: string; Update: Boolean);
  end;

implementation

{$R *.dfm}

uses
  Vcl.ClipBrd, dwsUtils, Hope.Main, Hope.DataModule.Common, Hope.Editor;

{ TFormCompilerMessages }

procedure TFormCompilerMessages.AfterConstruction;
begin
  inherited;

  TreeMessages.Indent := 4;
  TreeMessages.NodeDataSize := SizeOf(TCompilerMessageItem);
end;

procedure TFormCompilerMessages.Clear;
begin
  FLastTreeNode := nil;
  inherited Clear;
end;

function TFormCompilerMessages.GetMessageTypeForLine(SourceName: string;
  Line: Integer; out State: TCompilerMessageItem.TCompilerMessageType): Boolean;
var
  Node: PVirtualNode;
  NodeData: PCompilerMessageItem;
begin
  Result := False;
  if SourceName = FormMain.Projects.ActiveProject.Name then
    SourceName := SYS_MainModule;

  for Node in TreeMessages.Nodes do
  begin
    NodeData := TreeMessages.GetNodeData(Node);
    if UnicodeSameText(SourceName, NodeData.SourceName) and (NodeData.Line = Line) then
    begin
      State := NodeData.MessageType;
      Exit(True);
    end;
  end;
end;

procedure TFormCompilerMessages.LocateFirstError;
var
  Node: PVirtualNode;
  NodeData: PCompilerMessageItem;
begin
  // check if root contains any childs at all
  if TreeMessages.ChildCount[TreeMessages.RootNode] = 0 then
    Exit;

  // scan node by node for an error
  for Node in TreeMessages.Nodes do
  begin
    NodeData := TreeMessages.GetNodeData(Node);
    if NodeData.MessageType = tmError then
    begin
      TreeMessages.FocusedNode := Node;
      LocateNode(NodeData^);
      Exit;
    end;
  end;
end;

procedure TFormCompilerMessages.LocateNode(MessageItem: TCompilerMessageItem);
var
  FormEditor: TFormEditor;
begin
  FormEditor := FormMain.FocusUnitEditor(MessageItem.SourceName);
  if not Assigned(FormEditor) then
    Exit;

  FormEditor.Editor.GotoLineAndCenter(MessageItem.Line);
  FormEditor.Editor.CaretX := MessageItem.Col;
end;

procedure TFormCompilerMessages.LocateError(Direction: TLocateDirection);
var
  CurrentNode: PVirtualNode;
  NodeData: PCompilerMessageItem;
begin
  CurrentNode := TreeMessages.FocusedNode;
  if not Assigned(CurrentNode) then
    Exit;

  repeat
    // get node data
    NodeData := TreeMessages.GetNodeData(CurrentNode);

    if NodeData.MessageType = tmError then
    begin
      TreeMessages.FocusedNode := CurrentNode;
      LocateNode(NodeData^);
      Exit;
    end;

    // advance node
    if Direction = ldForward then
      CurrentNode := CurrentNode.NextSibling
    else
      CurrentNode := CurrentNode.PrevSibling;

  until not Assigned(CurrentNode);

  // defocus
  TreeMessages.FocusedNode := nil;
end;

procedure TFormCompilerMessages.LogMessages(
  const MessageList: TdwsMessageList);
var
  Index: Integer;
  NewNode: PVirtualNode;
  NodeData: PCompilerMessageItem;
  MessageItem: TdwsMessage;
begin
  TreeMessages.BeginUpdate;
  try
    for Index := 0 to MessageList.Count - 1 do
    begin
      if not Assigned(FLastTreeNode) then
        FLastTreeNode := TreeMessages.RootNode;
      NewNode := TreeMessages.AddChild(FLastTreeNode);
      NodeData := TreeMessages.GetNodeData(NewNode);
      MessageItem := MessageList[Index];
      NodeData.MessageText := MessageItem.AsInfo;
      if MessageItem is TScriptMessage then
      begin
        NodeData.Line := TScriptMessage(MessageItem).Line;
        NodeData.Col := TScriptMessage(MessageItem).Col;
        NodeData.SourceName := TScriptMessage(MessageItem).SourceName;
        if MessageItem is THintMessage then
          NodeData.MessageType := tmHint
        else
        if MessageItem is TWarningMessage then
          NodeData.MessageType := tmWarning
        else
        if MessageItem is TErrorMessage then
          NodeData.MessageType := tmError;
      end
      else
      begin
        NodeData.MessageType := tmInfo;
        NodeData.Line := -1;
        NodeData.Col := -1;
      end;
      TreeMessages.ValidateNode(NewNode, False);
      TreeMessages.Sort(FLastTreeNode, 0, sdAscending);
      TreeMessages.Expanded[FLastTreeNode] := True;
    end;
  finally
    TreeMessages.EndUpdate;
  end;
end;

procedure TFormCompilerMessages.LogMessage(const AText: string;
  Update: Boolean);
var
  NodeData: PCompilerMessageItem;
begin
  TreeMessages.BeginUpdate;
  try
    // update or add a new item
    if not Update then
      FLastTreeNode := TreeMessages.AddChild(TreeMessages.RootNode);

    // get items data and update text
    NodeData := TreeMessages.GetNodeData(FLastTreeNode);
    NodeData.MessageText := AText;

    // validate data (used to ensure finalization works correctly)
    TreeMessages.ValidateNode(FLastTreeNode, False);
  finally
    TreeMessages.EndUpdate;
  end;

  TreeMessages.Repaint;
end;

procedure TFormCompilerMessages.TreeMessagesCompareNodes(
  Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
var
  NodeData: array [0..1] of PCompilerMessageItem;
begin
  NodeData[0] := Sender.GetNodeData(Node1);
  NodeData[1] := Sender.GetNodeData(Node2);

  if NodeData[0].MessageType = tmError then
  begin
    Result := 0;
    Exit;
  end;

  if NodeData[0].MessageType < NodeData[1].MessageType then
    Result := 1
  else
    Result := 0;
end;

procedure TFormCompilerMessages.TreeMessagesDblClick(Sender: TObject);
var
  FocusedNode: PVirtualNode;
  NodeData: PCompilerMessageItem;
begin
  Assert(TreeMessages is TBaseVirtualTree);

  FocusedNode := TBaseVirtualTree(TreeMessages).FocusedNode;
  if Assigned(FocusedNode) then
  begin
    NodeData := TBaseVirtualTree(TreeMessages).GetNodeData(FocusedNode);
    LocateNode(NodeData^);
  end;
end;

procedure TFormCompilerMessages.TreeMessagesFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  NodeData: PCompilerMessageItem;
begin
  NodeData := Sender.GetNodeData(Node);
  Finalize(NodeData^);
end;

procedure TFormCompilerMessages.TreeMessagesGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  NodeData: PCompilerMessageItem;
begin
  if not (Kind in [ikNormal, ikSelected]) then
    Exit;

  NodeData := Sender.GetNodeData(Node);
  case NodeData.MessageType of
    tmHint:
      ImageIndex := 24;
    tmWarning:
      ImageIndex := 24;
    tmError:
      ImageIndex := 25;
  end;
end;

procedure TFormCompilerMessages.TreeMessagesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeData: PCompilerMessageItem;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData^.MessageText;
end;

procedure TFormCompilerMessages.TreeMessagesPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  NodeData: PCompilerMessageItem;
begin
  NodeData := Sender.GetNodeData(Node);
  case NodeData.MessageType of
    tmHint:
      TargetCanvas.Font.Style := [fsItalic];
    tmError:
      TargetCanvas.Font.Style := [fsBold];
    else
      TargetCanvas.Font.Style := [];
  end;
end;

end.
