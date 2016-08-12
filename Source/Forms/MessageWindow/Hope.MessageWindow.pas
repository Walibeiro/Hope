unit Hope.MessageWindow;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.Menus;

type
  TFormMessageWindow = class(TForm)
    TreeMessages: TVirtualStringTree;
    PopupMenu: TPopupMenu;
    MenuItemClearMessages: TMenuItem;
    MenuItemCopyMessageToClipboard: TMenuItem;
    MenuItemCopyMessagesToClipboard: TMenuItem;
    MenuItemSaveMessagesToFile: TMenuItem;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

end.

