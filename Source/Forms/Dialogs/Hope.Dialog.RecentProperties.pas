unit Hope.Dialog.RecentProperties;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Samples.Spin,
  Hope.Dialog, VirtualTrees, System.Actions, Vcl.ActnList, Vcl.Menus;

type
  THistoryItem = record
    FileName: TFileName;
  end;
  PHistoryItem = ^THistoryItem;

  TFormRecentProperties = class(TFormDialog)
    ActionClear: TAction;
    ActionDelete: TAction;
    ActionList: TActionList;
    ActionRemoveInvalid: TAction;
    ButtonClear: TButton;
    ButtonDelete: TButton;
    ButtonRemoveInvalid: TButton;
    GroupBoxCapacity: TGroupBox;
    GroupBoxItems: TGroupBox;
    LabelProjectCount: TLabel;
    LabelUnitCount: TLabel;
    MenuItemClear: TMenuItem;
    MenuItemDelete: TMenuItem;
    PopupMenu: TPopupMenu;
    SpinEditProjectCount: TSpinEdit;
    SpinEditUnitCOunt: TSpinEdit;
    TreeItems: TVirtualStringTree;
    procedure TreeItemsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure TreeItemsDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
    procedure TreeItemsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeItemsCollapsing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var Allowed: Boolean);
  private
    FProjectsNode: PVirtualNode;
    FUnitsNode: PVirtualNode;
    procedure UpdateHistoryItems;
  public
    procedure AfterConstruction; override;

    class procedure CreateAndShow;
  end;

implementation

{$R *.dfm}

uses
  Hope.DataModule;

{ TFormRecentProperties }

procedure TFormRecentProperties.AfterConstruction;
begin
  inherited;

  TreeItems.NodeDataSize := SizeOf(THistoryItem);

  UpdateHistoryItems;
end;

procedure TFormRecentProperties.UpdateHistoryItems;
var
  Index: Integer;
  NodeItem: PVirtualNode;
  NodeData: PHistoryItem;
begin
  TreeItems.BeginUpdate;
  try
    TreeItems.Clear;

    FProjectsNode := TreeItems.AddChild(TreeItems.RootNode);
    NodeData := TreeItems.GetNodeData(FProjectsNode);
    NodeData^.FileName := 'Projects';
    for Index := 0 to DataModuleCommon.History.ProjectsHistory.Count - 1 do
    begin
      NodeItem := TreeItems.AddChild(FProjectsNode);
      NodeData := TreeItems.GetNodeData(NodeItem);
      NodeData^.FileName := DataModuleCommon.History.ProjectsHistory[Index];
    end;
    TreeItems.Expanded[FProjectsNode] := True;

    FUnitsNode := TreeItems.AddChild(TreeItems.RootNode);
    NodeData := TreeItems.GetNodeData(FUnitsNode);
    NodeData^.FileName := 'Units';
    for Index := 0 to DataModuleCommon.History.UnitsHistory.Count - 1 do
    begin
      NodeItem := TreeItems.AddChild(FUnitsNode);
      NodeData := TreeItems.GetNodeData(NodeItem);
      NodeData^.FileName := DataModuleCommon.History.UnitsHistory[Index];
    end;
    TreeItems.Expanded[FUnitsNode] := True;
  finally
    TreeItems.EndUpdate;
  end;
end;

class procedure TFormRecentProperties.CreateAndShow;
begin
  // show project options dialog
  with TFormRecentProperties.Create(nil) do
  try
    SpinEditProjectCount.Value := DataModuleCommon.Preferences.Recent.ProjectCount;
    SpinEditUnitCount.Value := DataModuleCommon.Preferences.Recent.UnitCount;

    if (ShowModal = mrOk) then
    begin
      DataModuleCommon.Preferences.Recent.ProjectCount := SpinEditProjectCount.Value;
      DataModuleCommon.Preferences.Recent.UnitCount := SpinEditUnitCount.Value;
    end;

  finally
    Free;
  end;
end;

procedure TFormRecentProperties.TreeItemsCollapsing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var Allowed: Boolean);
begin
  Allowed := False;
end;

procedure TFormRecentProperties.TreeItemsDrawText(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
var
  NodeData: PHistoryItem;
const
  CColors: array [Boolean] of TColor = (clGrayText, clWindowText);
begin
  NodeData := Sender.GetNodeData(Node);
  if (Node.Parent = FProjectsNode) or (Node.Parent = FUnitsNode) then
  begin
    TargetCanvas.Font.Color := CColors[FileExists(NodeData^.FileName)];
    if Sender.Selected[Node] then
      TargetCanvas.Font.Color := clHighlightText;
  end
  else
    TargetCanvas.Font.Style := [fsBold];
end;

procedure TFormRecentProperties.TreeItemsFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  NodeData: PHistoryItem;
begin
  NodeData := Sender.GetNodeData(Node);
  Finalize(NodeData^.FileName);
end;

procedure TFormRecentProperties.TreeItemsGetText(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  NodeData: PHistoryItem;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData^.FileName;
end;

procedure TFormRecentProperties.ActionClearExecute(Sender: TObject);
begin
  TreeItems.BeginUpdate;
  try
    TreeItems.Clear;
  finally
    TreeItems.EndUpdate;
  end;
end;

procedure TFormRecentProperties.ActionDeleteExecute(Sender: TObject);
var
  Node: PVirtualNode;
begin
  for Node in TreeItems.SelectedNodes do
    TreeItems.DeleteNode(Node);
end;

end.
