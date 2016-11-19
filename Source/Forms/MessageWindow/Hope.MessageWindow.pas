unit Hope.MessageWindow;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.Menus,
  Hope.Docking.Form;

type
  TFormMessageWindow = class(TFormDockable)
    MenuItemClearMessages: TMenuItem;
    MenuItemCopy: TMenuItem;
    MenuItemSaveMessagesToFile: TMenuItem;
    MenuItemSelectAll: TMenuItem;
    N1: TMenuItem;
    PopupMenu: TPopupMenu;
    TreeMessages: TVirtualStringTree;
    procedure MenuItemClearMessagesClick(Sender: TObject);
    procedure MenuItemSaveMessagesToFileClick(Sender: TObject);
    procedure MenuItemCopyClick(Sender: TObject);
    procedure MenuItemSelectAllClick(Sender: TObject);
  public
    procedure AfterConstruction; override;
    procedure Clear; virtual;
    procedure SaveToFile(FileName: TFileName); virtual;
  end;

implementation

{$R *.dfm}

uses
  Hope.DataModule.ImageLists;

{ TFormMessageWindow }

procedure TFormMessageWindow.AfterConstruction;
begin
  inherited;

  TreeMessages.Images := DataModuleImageLists.ImageList16;
  TreeMessages.StateImages := DataModuleImageLists.ImageList16;
end;

procedure TFormMessageWindow.Clear;
begin
  TreeMessages.BeginUpdate;
  try
    TreeMessages.Clear;
  finally
    TreeMessages.EndUpdate;
  end;

  TreeMessages.Repaint;
end;

procedure TFormMessageWindow.SaveToFile(FileName: TFileName);
var
  StringList: TStringList;
  Node: PVirtualNode;
  Text: string;
begin
  StringList := TStringList.Create;
  try
    for Node in TreeMessages.Nodes do
      if Assigned(TreeMessages.OnGetText) then
      begin
        // get visible text
        TreeMessages.OnGetText(TreeMessages, Node, 0, ttNormal, Text);

        // add to string list
        StringList.Add(Text);
      end;
    StringList.SaveToFile(FileName);
  finally
    StringList.Free;
  end;
end;

procedure TFormMessageWindow.MenuItemClearMessagesClick(Sender: TObject);
begin
  Clear;
end;

procedure TFormMessageWindow.MenuItemSaveMessagesToFileClick(Sender: TObject);
begin
  with TSaveDialog.Create(nil) do
  try
    if Execute then
      SaveToFile(FileName);
  finally
    Free;
  end;
end;

procedure TFormMessageWindow.MenuItemCopyClick(Sender: TObject);
begin
  TreeMessages.CopyToClipboard;
end;

procedure TFormMessageWindow.MenuItemSelectAllClick(Sender: TObject);
begin
  TreeMessages.SelectAll(True);
end;

end.
