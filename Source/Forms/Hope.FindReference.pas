unit Hope.FindReference;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, VirtualTrees, dwsSymbolDictionary;

type
  TFindReferenceItem = record
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

procedure TFormFindReference.TreeViewSymbolPositionsDblClick(Sender: TObject);
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

procedure TFormFindReference.TreeViewSymbolPositionsFreeNode(
  Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  NodeData: TSymbolPosition;
begin
  NodeData := Sender.GetNodeData(Node);
  Finalize(NodeData^);
end;

procedure TFormFindReference.TreeViewSymbolPositionsGetText(
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

procedure TFormFindReference.TreeViewSymbolPositionsIncrementalSearch(
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

