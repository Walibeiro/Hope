unit Hope.FindReference;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, VirtualTrees, dwsSymbolDictionary;

type
  PFindReferenceItem = ^TFindReferenceItem;
  TFindReferenceItem = record
    UnitName: string;
    Text: string;
    Line: Integer;
    Char: Integer;
  end;

  TFormFindReference = class(TForm)
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

    procedure FindUsage(UnitName: string; Line, Char: Integer);
  end;

implementation

{$R *.dfm}

uses
  System.Math, dwsExprs, dwsSymbols,
  Hope.DataModule.ImageLists, Hope.Main, Hope.DataModule.Common;

{ TFormSymbolUsage }

procedure TFormFindReference.AfterConstruction;
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

procedure TFormFindReference.FindUsage(UnitName: string; Line, Char: Integer);
var
  CurrentProgram: IdwsProgram;
  Symbol: TSymbol;
  SymbolPosition: TSymbolPosition;
  Index: Integer;
const
  CUsages: array [0..1] of TSymbolUsage = (suForward, suDeclaration);
begin
  // get script program
  CurrentProgram := DataModuleCommon.BackgroundCompiler.GetCompiledProgram;
  if CurrentProgram = nil then
    Exit;

  // find current symbol
  Symbol := CurrentProgram.SymbolDictionary.FindSymbolAtPosition(
    Char, Line, UnitName);

  // find according implementation symbol
  for Index := Low(CUsages) to High(CUsages) do
  begin
    SymbolPosition := CurrentProgram.SymbolDictionary.FindSymbolUsage(Symbol, CUsages[Index]);
(*
    if Assigned(SymbolPosition) then
    begin
      Editor.CaretXY := BufferCoord(
        SymbolPosition.ScriptPos.Col,
        SymbolPosition.ScriptPos.Line);
      Exit;
    end;
*)
  end
end;

procedure TFormFindReference.TreeViewSymbolPositionsCompareNodes(
  Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
var
  NodeData: array [0 .. 1] of PFindReferenceItem;
begin
  NodeData[0] := Sender.GetNodeData(Node1);
  NodeData[1] := Sender.GetNodeData(Node2);

  case Column of
    0:
      Result := CompareText(NodeData[0].UnitName, NodeData[1].UnitName);
    1:
      Result := CompareText(NodeData[0].Text, NodeData[1].Text);
    2:
      Result := NodeData[0].Line - NodeData[1].Line;
    3:
      Result := NodeData[0].Char - NodeData[1].Char;
  end;
end;

procedure TFormFindReference.TreeViewSymbolPositionsDblClick(Sender: TObject);
var
  Node: PVirtualNode;
  NodeData: PFindReferenceItem;
  FileName: string;
begin
  // eventually expand or collapse focussed tree
  if Assigned(TreeViewSymbolPositions.FocusedNode) then
  begin
    Node := TreeViewSymbolPositions.FocusedNode;
    NodeData := PFindReferenceItem(TreeViewSymbolPositions.GetNodeData(Node));
    FormMain.FocusUnitEditor(NodeData^.UnitName, NodeData^.Line, NodeData^.Char);
  end;
end;

procedure TFormFindReference.TreeViewSymbolPositionsFreeNode(
  Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  NodeData: PFindReferenceItem;
begin
  NodeData := Sender.GetNodeData(Node);
  Finalize(NodeData^);
end;

procedure TFormFindReference.TreeViewSymbolPositionsGetText(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  NodeData: PFindReferenceItem;
begin
  NodeData := Sender.GetNodeData(Node);
  case Column of
    0:
      CellText := NodeData^.UnitName;
    1:
      CellText := NodeData^.Text;
    2:
      CellText := IntToStr(NodeData^.Line);
    3:
      CellText := IntToStr(NodeData^.Char);
  end;
end;

procedure TFormFindReference.TreeViewSymbolPositionsIncrementalSearch(
  Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string;
  var Result: Integer);
var
  NodeData: PFindReferenceItem;
  S: array [0 .. 1] of string;
begin
  NodeData := Sender.GetNodeData(Node);
  S[0] := LowerCase(SearchText);
  S[1] := LowerCase(NodeData^.Text);

  Result := StrLIComp(PChar(S[0]), PChar(S[1]), Min(Length(S[0]), Length(S[1])));
end;

end.

