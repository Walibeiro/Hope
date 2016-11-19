unit Hope.Dialog.NewMore;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, 
  Hope.Dialog, Vcl.StdCtrls, VirtualTrees;

type
  TGalleryItem = record
    FileName: TFileName;
    ImageIndex: Integer;
  end;
  PGalleryItem = ^TGalleryItem;

  TFormObjectGallery = class(TFormDialog)
    TreeItems: TVirtualStringTree;
    procedure TreeItemsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure TreeItemsIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure TreeItemsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeItemsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
  private
    { Private-Deklarationen }
  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses
  Hope.DataModule.ImageLists, System.Math;

{ TFormObjectGallery }

procedure TFormObjectGallery.AfterConstruction;
begin
  inherited;

  TreeItems.Images := DataModuleImageLists.ImageList16;
  TreeItems.StateImages := DataModuleImageLists.ImageList16;
end;

procedure TFormObjectGallery.TreeItemsFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  NodeData: PGalleryItem;
begin
  NodeData := Sender.GetNodeData(Node);
  Finalize(NodeData^.FileName);
end;

procedure TFormObjectGallery.TreeItemsGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  NodeData: PGalleryItem;
begin
  if Kind in [ikNormal, ikSelected] then
  begin
    NodeData := Sender.GetNodeData(Node);
    ImageIndex := NodeData^.ImageIndex;
  end;
end;

procedure TFormObjectGallery.TreeItemsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeData: PGalleryItem;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData^.FileName;
end;

procedure TFormObjectGallery.TreeItemsIncrementalSearch(
  Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string;
  var Result: Integer);
var
  NodeData: PGalleryItem;
  S: array [0 .. 1] of string;
begin
  NodeData := Sender.GetNodeData(Node);
  S[0] := LowerCase(SearchText);
  S[1] := LowerCase(NodeData^.FileName);

  Result := StrLIComp(PChar(S[0]), PChar(S[1]), Min(Length(S[0]), Length(S[1])));
end;

end.
