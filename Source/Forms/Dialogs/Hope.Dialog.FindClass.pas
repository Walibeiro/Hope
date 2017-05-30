unit Hope.Dialog.FindClass;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Hope.Dialog, dwsSymbols, VirtualTrees;

type
  PFindClassesItem = ^TFindClassesItem;
  TFindClassesItem = record
    Symbol: TCompositeTypeSymbol;
  end;

  TFormFindClass = class(TFormDialog)
    EditSearch: TEdit;
    LabelClasses: TLabel;
    LabelSearch: TLabel;
    TreeClasses: TVirtualStringTree;
    procedure EditSearchChange(Sender: TObject);
    procedure TreeClassesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure TreeClassesFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeClassesCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure TreeClassesIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: string; var Result: Integer);
  public
    procedure AfterConstruction; override;

    procedure UpdateClasses;
  end;

implementation

{$R *.dfm}

uses
  System.Math, dwsExprs, dwsSymbolDictionary,
  Hope.DataModule.ImageLists, Hope.DataModule.Common;

{ TFormFindClass }

procedure TFormFindClass.AfterConstruction;
begin
  inherited;

  TreeClasses.Images := DataModuleImageLists.ImageList16;
  TreeClasses.StateImages := DataModuleImageLists.ImageList16;
  TreeClasses.NodeDataSize := SizeOf(TFindClassesItem);

  UpdateClasses;
end;

procedure TFormFindClass.EditSearchChange(Sender: TObject);
var
  Node: PVirtualNode;
  NodeData: PFindClassesItem;
  SearchText: string;
begin
  SearchText := LowerCase(EditSearch.Text);
  TreeClasses.BeginUpdate;
  try
    Node := TreeClasses.GetLast;
    while Node <> nil do
    begin
      NodeData := TreeClasses.GetNodeData(Node);
      TreeClasses.IsVisible[Node] := (SearchText = '') or
        (Pos(SearchText, LowerCase(NodeData^.Symbol.Name)) > 0);

      Node := TreeClasses.GetPrevious(Node);
    end;
  finally
    TreeClasses.EndUpdate;
  end;
end;

procedure TFormFindClass.TreeClassesCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  NodeData: array [0 .. 1] of PFindClassesItem;
begin
  NodeData[0] := Sender.GetNodeData(Node1);
  NodeData[1] := Sender.GetNodeData(Node2);

  Result := CompareText(NodeData[0]^.Symbol.Name, NodeData[1]^.Symbol.Name);
end;

procedure TFormFindClass.TreeClassesFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  NodeData: PFindClassesItem;
begin
  NodeData := Sender.GetNodeData(Node);
  Finalize(NodeData^);
end;

procedure TFormFindClass.TreeClassesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeData: PFindClassesItem;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData^.Symbol.Name;
end;

procedure TFormFindClass.TreeClassesIncrementalSearch(Sender: TBaseVirtualTree;
  Node: PVirtualNode; const SearchText: string; var Result: Integer);
var
  NodeData: PFindClassesItem;
  S: array [0 .. 1] of string;
begin
  NodeData := Sender.GetNodeData(Node);
  S[0] := LowerCase(SearchText);
  S[1] := LowerCase(NodeData^.Symbol.Name);

  Result := StrLIComp(PChar(S[0]), PChar(S[1]), Min(Length(S[0]), Length(S[1])));
end;

procedure TFormFindClass.UpdateClasses;
var
  CurrentProgram: IdwsProgram;
  SymbolPositionList: TSymbolPositionList;
  ClassNode: PVirtualNode;
  NodeData: PFindClassesItem;
begin
  // get script program
  CurrentProgram := DataModuleCommon.BackgroundCompiler.GetCompiledProgram;
  if CurrentProgram = nil then
    Exit;

  TreeClasses.BeginUpdate;
  TreeClasses.Clear;
  try
    // find current symbol
    for SymbolPositionList in CurrentProgram.SymbolDictionary do
      if SymbolPositionList.Symbol is TCompositeTypeSymbol then
      begin
        ClassNode := TreeClasses.AddChild(TreeClasses.RootNode);
        NodeData := TreeClasses.GetNodeData(ClassNode);
        NodeData.Symbol := TCompositeTypeSymbol(SymbolPositionList.Symbol);
      end;
  finally
    TreeClasses.EndUpdate;
  end;
end;

end.

