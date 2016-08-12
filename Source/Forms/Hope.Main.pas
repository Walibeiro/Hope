unit Hope.Main;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  Vcl.ActnList, Vcl.Menus, Vcl.StdActns,
  JvStdEditActions, JvDockTree, JvDockControlForm, JvDockDelphiStyle,
  JvComponentBase,
  Hope.Common, Hope.WelcomePage;

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
    ActionFileNewCSS: TAction;
    ActionFileNewCSS1: TMenuItem;
    ActionFileNewMore: TAction;
    ActionFileNewProject: TAction;
    ActionFileNewUnit: TAction;
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
    ActionProjectMetrics: TAction;
    ActionProjectOptions: TAction;
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
    ActionToolsCodeTemplates: TAction;
    ActionToolsColorPicker: TAction;
    ActionToolsPreferences: TAction;
    ActionToolsUnicodeExplorer: TAction;
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
    MenuItemFileNewMore: TMenuItem;
    MenuItemFileNewProject: TMenuItem;
    MenuItemFileNewUnit: TMenuItem;
    MenuItemFileOpen: TMenuItem;
    MenuItemFileOpenProject: TMenuItem;
    MenuItemFileOpenRecent: TMenuItem;
    MenuItemFileSave: TMenuItem;
    MenuItemFileSaveAs: TMenuItem;
    MenuItemFileSaveProject: TMenuItem;
    MenuItemFileSaveProjectAs: TMenuItem;
    MenuItemHelp: TMenuItem;
    MenuItemHelpAbout: TMenuItem;
    MenuItemPackages: TMenuItem;
    MenuItemProject: TMenuItem;
    MenuItemProjectAddToProject: TMenuItem;
    MenuItemProjectBuild: TMenuItem;
    MenuItemProjectBuildAll: TMenuItem;
    MenuItemProjectCompile: TMenuItem;
    MenuItemProjectCompileAll: TMenuItem;
    MenuItemProjectDeleteFromProject: TMenuItem;
    MenuItemProjectMetrics: TMenuItem;
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
    N14: TMenuItem;
    N15: TMenuItem;
    procedure ActionHelpAboutExecute(Sender: TObject);
    procedure ActionProjectOptionsExecute(Sender: TObject);
    procedure ActionSearchFindInFilesExecute(Sender: TObject);
    procedure ActionToolsCodeTemplatesExecute(Sender: TObject);
    procedure ActionToolsColorPickerExecute(Sender: TObject);
    procedure ActionToolsPreferencesExecute(Sender: TObject);
    procedure ActionToolsUnicodeExplorerExecute(Sender: TObject);
  private
    FWelcomePage: TFormWelcomePage;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure LoadProject(ProjectName: string);
  end;

var
  FormMain: TFormMain;

implementation

uses
  Hope.About, Hope.Dialogs.FindInFiles, Hope.Dialogs.ProjectOptions,
  Hope.Dialogs.Preferences, Hope.ColorPicker, Hope.UnicodeExplorer,
  Hope.Dialogs.CodeTemplates;

{$R *.dfm}

{ TFormMain }

procedure TFormMain.AfterConstruction;
begin
  inherited;

  DockServer.DockStyle := DataModuleCommon.JvDockDelphiStyle;
  FWelcomePage := TFormWelcomePage.Create(nil);
  FWelcomePage.Show;
  FWelcomePage.Update;
end;

procedure TFormMain.BeforeDestruction;
begin
  FWelcomePage.Free;
  inherited;
end;

procedure TFormMain.LoadProject(ProjectName: string);
begin

end;

procedure TFormMain.ActionHelpAboutExecute(Sender: TObject);
begin
  with TFormAbout.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionProjectOptionsExecute(Sender: TObject);
begin
  with TFormProjectOptions.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionSearchFindInFilesExecute(Sender: TObject);
begin
  with TFormFindInFiles.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionToolsCodeTemplatesExecute(Sender: TObject);
begin
  with TFormCodeTemplates.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionToolsColorPickerExecute(Sender: TObject);
begin
  with TFormColorPicker.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionToolsPreferencesExecute(Sender: TObject);
begin
  with TFormPreferences.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionToolsUnicodeExplorerExecute(Sender: TObject);
begin
  with TFormUnicodeExplorer.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

end.

