unit Hope.SymbolUsage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, VirtualTrees, dwsSymbolDictionary;

type
  TFormSymbolUsage = class(TForm)
    TreeViewSymbolPositions: TVirtualStringTree;
    procedure TreeViewSymbolPositionsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure TreeViewSymbolPositionsIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure TreeViewSymbolPositionsCompareNodes(Sender: TBaseVirtualTree;
      Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure TreeViewSymbolPositionsDblClick(Sender: TObject);
    procedure TreeViewSymbolPositionsFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses
  System.Math, Hope.DataModule.ImageLists, Hope.Main;

{ TFormSymbolUsage }

procedure TFormSymbolUsage.AfterConstruction;
begin
  inherited;

  // Configure project tree
  TreeViewSymbolPositions.NodeDataSize := SizeOf(TSymbolPositionRec);
  TreeViewSymbolPositions.RootNodeCount := 0;
  TreeViewSymbolPositions.DefaultNodeHeight := 20;
  TreeViewSymbolPositions.Enabled := False;
  TreeViewSymbolPositions.Images := DataModuleImageLists.ImageList16;
  TreeViewSymbolPositions.StateImages := DataModuleImageLists.ImageList16;
end;

procedure TFormSymbolUsage.TreeViewSymbolPositionsCompareNodes(
  Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
var
  NodeData: array [0 .. 1] of TSymbolPosition;
begin
  NodeData[0] := Sender.GetNodeData(Node1);
  NodeData[1] := Sender.GetNodeData(Node2);

  case Column of
    0:
      Result := CompareText(NodeData[0].ScriptPos.SourceFile.Name, NodeData[1].ScriptPos.SourceFile.Name);
    1:
      Result := NodeData[0].ScriptPos.Line - NodeData[1].ScriptPos.Line;
    2:
      Result := NodeData[0].ScriptPos.Col - NodeData[1].ScriptPos.Col;
  end;
end;

procedure TFormSymbolUsage.TreeViewSymbolPositionsDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  NodeData: TSymbolPosition;
  FileName: string;
begin
  // eventually expand or collapse focussed tree
  if Assigned(TreeViewSymbolPositions.FocusedNode) then
  begin
    Node := TreeViewSymbolPositions.FocusedNode;
    NodeData := TSymbolPosition(TreeViewSymbolPositions.GetNodeData(Node));
    FormMain.FocusUnitEditor(NodeData^.ScriptPos.SourceFile.Name,
      NodeData^.ScriptPos.Line, NodeData^.ScriptPos.Col);
  end;
end;

procedure TFormSymbolUsage.TreeViewSymbolPositionsFreeNode(
  Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  NodeData: TSymbolPosition;
begin
  NodeData := Sender.GetNodeData(Node);
  Finalize(NodeData^);
end;

procedure TFormSymbolUsage.TreeViewSymbolPositionsGetText(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  NodeData: TSymbolPosition;
begin
  NodeData := Sender.GetNodeData(Node);
  case Column of
    0:
      CellText := NodeData^.ScriptPos.SourceFile.Name;
    1:
      CellText := IntToStr(NodeData^.ScriptPos.Line);
    2:
      CellText := IntToStr(NodeData^.ScriptPos.Col);
  end;
end;

procedure TFormSymbolUsage.TreeViewSymbolPositionsIncrementalSearch(
  Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string;
  var Result: Integer);
var
  NodeData: TSymbolPosition;
  S: array [0 .. 1] of string;
begin
  NodeData := Sender.GetNodeData(Node);
  S[0] := LowerCase(SearchText);
  S[1] := LowerCase(NodeData^.ScriptPos.SourceFile.Name);

  Result := StrLIComp(PChar(S[0]), PChar(S[1]), Min(Length(S[0]), Length(S[1])));
end;

end.

