unit Hope.MessageWindow;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.Menus,
  Hope.DockingForm;

type
  TFormMessageWindow = class(TFormDockable)
    TreeMessages: TVirtualStringTree;
    PopupMenu: TPopupMenu;
    MenuItemClearMessages: TMenuItem;
    MenuItemCopyMessageToClipboard: TMenuItem;
    MenuItemCopyMessagesToClipboard: TMenuItem;
    MenuItemSaveMessagesToFile: TMenuItem;
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  Hope.Common;

{$R *.dfm}

{ TFormMessageWindow }

procedure TFormMessageWindow.AfterConstruction;
begin
  inherited;
end;

end.
