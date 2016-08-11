unit Hope.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  Vcl.ActnList, Vcl.Menus, JvStdEditActions, ActnList, StdActns, ExtActns,
  Classes, Menus;

type
  TFormMain = class(TForm)
    ActionEditCopy: TJvEditCopy;
    ActionEditCut: TJvEditCut;
    ActionEditDelete: TJvEditDelete;
    ActionEditPaste: TJvEditPaste;
    ActionEditRedo: TAction;
    ActionEditSelectAll: TJvEditSelectAll;
    ActionEditUndo: TJvEditUndo;
    ActionFileExit: TFileExit;
    ActionFileOpen: TFileOpen;
    ActionFileRun: TFileRun;
    ActionFileSaveAs: TFileSaveAs;
    ActionHelpAbout: TAction;
    ActionList: TActionList;
    ActionSearchFind: TSearchFind;
    ActionSearchFindFirst: TSearchFindFirst;
    ActionSearchFindNext: TSearchFindNext;
    ActionSearchReplace: TSearchReplace;
    MainMenu: TMainMenu;
    MenuItemEdit: TMenuItem;
    MenuItemEditCopy: TMenuItem;
    MenuItemEditCut: TMenuItem;
    MenuItemEditDelete: TMenuItem;
    MenuItemEditPaste: TMenuItem;
    MenuItemEditSelectAll: TMenuItem;
    MenuItemEditUndo: TMenuItem;
    MenuItemFile: TMenuItem;
    MenuItemFileExit: TMenuItem;
    MenuItemFileNew: TMenuItem;
    MenuItemFileOpen: TMenuItem;
    MenuItemFileSaveAs: TMenuItem;
    MenuItemHelp: TMenuItem;
    MenuItemProject: TMenuItem;
    MenuItemRefactor: TMenuItem;
    MenuItemSearch: TMenuItem;
    MenuItemStart: TMenuItem;
    MenuItemTools: TMenuItem;
    MenuItemView: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

end.

