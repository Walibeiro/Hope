unit Hope.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  Vcl.ActnList, Vcl.Menus, Vcl.StdActns,
  JvStdEditActions, JvDockTree, JvDockControlForm, JvDockDelphiStyle,
  JvComponentBase;

type
  TFormMain = class(TForm)
    ActionEditCopy: TJvEditCopy;
    ActionEditCut: TJvEditCut;
    ActionEditDelete: TJvEditDelete;
    ActionEditPaste: TJvEditPaste;
    ActionEditRedo: TAction;
    ActionEditSelectAll: TJvEditSelectAll;
    ActionEditUndo: TJvEditUndo;
    ActionFileClose: TAction;
    ActionFileCloseProject: TAction;
    ActionFileExit: TFileExit;
    ActionFileOpen: TFileOpen;
    ActionFileOpenProject: TFileOpen;
    ActionFileOpenRecent: TAction;
    ActionFileSave: TAction;
    ActionFileSaveAs: TFileSaveAs;
    ActionFileSaveProject: TAction;
    ActionFileSaveProjectAs: TFileSaveAs;
    ActionHelpAbout: TAction;
    ActionList: TActionList;
    ActionProjectAdd: TAction;
    ActionProjectBuild: TAction;
    ActionProjectBuildAll: TAction;
    ActionProjectCompile: TAction;
    ActionProjectCompileAll: TAction;
    ActionProjectDelete: TAction;
    ActionProjectInformation: TAction;
    ActionProjectStatistics: TAction;
    ActionProjectSyntaxCheck: TAction;
    ActionRunAbort: TAction;
    ActionRunParameters: TAction;
    ActionRunRun: TAction;
    ActionSearchFind: TSearchFind;
    ActionSearchFindClass: TAction;
    ActionSearchFindFirst: TSearchFindFirst;
    ActionSearchFindInFiles: TAction;
    ActionSearchFindNext: TSearchFindNext;
    ActionSearchGotoLineNumber: TAction;
    ActionSearchReplace: TSearchReplace;
    ActionToolsASCII: TAction;
    ActionToolsCodeTemplates: TAction;
    ActionToolsColorPicker: TAction;
    ActionToolsPreferences: TAction;
    ActionViewClassExplorer: TAction;
    ActionViewFileBrowser: TAction;
    ActionViewUnits: TAction;
    ActionViewWelcomePage: TAction;
    DockServer: TJvDockServer;
    MainMenu: TMainMenu;
    MenuItemEdit: TMenuItem;
    MenuItemEditCopy: TMenuItem;
    MenuItemEditCut: TMenuItem;
    MenuItemEditDelete: TMenuItem;
    MenuItemEditPaste: TMenuItem;
    MenuItemEditRedo: TMenuItem;
    MenuItemEditSearchFind: TMenuItem;
    MenuItemEditSearchFindNext: TMenuItem;
    MenuItemEditSearchReplace: TMenuItem;
    MenuItemEditSelectAll: TMenuItem;
    MenuItemEditUndo: TMenuItem;
    MenuItemFile: TMenuItem;
    MenuItemFileClose: TMenuItem;
    MenuItemFileCloseProject: TMenuItem;
    MenuItemFileExit: TMenuItem;
    MenuItemFileNew: TMenuItem;
    MenuItemFileOpen: TMenuItem;
    MenuItemFileOpenProject: TMenuItem;
    MenuItemFileOpenRecent: TMenuItem;
    MenuItemFileSave: TMenuItem;
    MenuItemFileSaveAs: TMenuItem;
    MenuItemFileSaveProject: TMenuItem;
    MenuItemFileSaveProjectAs: TMenuItem;
    MenuItemHelp: TMenuItem;
    MenuItemPackages: TMenuItem;
    MenuItemProject: TMenuItem;
    MenuItemProjectAddToProject: TMenuItem;
    MenuItemProjectBuild: TMenuItem;
    MenuItemProjectBuildAll: TMenuItem;
    MenuItemProjectCompile: TMenuItem;
    MenuItemProjectCompileAll: TMenuItem;
    MenuItemProjectDeleteFromProject: TMenuItem;
    MenuItemProjectInformation: TMenuItem;
    MenuItemProjectOptions: TMenuItem;
    MenuItemProjectStatistics: TMenuItem;
    MenuItemProjectSyntaxCheck: TMenuItem;
    MenuItemRefactor: TMenuItem;
    MenuItemRun: TMenuItem;
    MenuItemRunAbort: TMenuItem;
    MenuItemRunParameters: TMenuItem;
    MenuItemRunRun: TMenuItem;
    MenuItemSearch: TMenuItem;
    MenuItemSearchFindClass: TMenuItem;
    MenuItemSearchFindInFiles: TMenuItem;
    MenuItemSearchGotoLineNumber: TMenuItem;
    MenuItemTools: TMenuItem;
    MenuItemToolsASCIIChart: TMenuItem;
    MenuItemToolsCodeTemplates: TMenuItem;
    MenuItemToolsColorPicker: TMenuItem;
    MenuItemToolsPreferences: TMenuItem;
    MenuItemView: TMenuItem;
    MenuItemViewClassExplorer: TMenuItem;
    MenuItemViewFileBrowser: TMenuItem;
    MenuItemViewUnits: TMenuItem;
    MenuItemViewWelcomePage: TMenuItem;
    N01: TMenuItem;
    N02: TMenuItem;
    N03: TMenuItem;
    N04: TMenuItem;
    N05: TMenuItem;
    N06: TMenuItem;
    N07: TMenuItem;
    N08: TMenuItem;
    N09: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    MenuItemFileNewProject: TMenuItem;
    N1: TMenuItem;
    ActionFileNewProject: TAction;
    ActionFileNewUnit: TAction;
    NewUnit1: TMenuItem;
    N2: TMenuItem;
    More1: TMenuItem;
    ActionFileNewMore: TAction;
    ActionFileNewCSS: TAction;
    ActionFileNewCSS1: TMenuItem;
    procedure ActionHelpAboutExecute(Sender: TObject);
    procedure ActionSearchFindInFilesExecute(Sender: TObject);
  private
  public
  end;

var
  FormMain: TFormMain;

implementation

uses
  Hope.About, Hope.Dialogs.FindInFiles;

{$R *.dfm}

procedure TFormMain.ActionHelpAboutExecute(Sender: TObject);
begin
  with TFormAbout.Create(Self) do
  try
    Show;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionSearchFindInFilesExecute(Sender: TObject);
begin
  with TFormFindInFiles.Create(Self) do
  try
    Show;
  finally
    Free;
  end;
end;

end.

