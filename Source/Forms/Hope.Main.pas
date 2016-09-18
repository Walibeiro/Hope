unit Hope.Main;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.Types, System.Actions, System.SyncObjs, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.Menus, Vcl.StdActns, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Tabs, SynEdit, dwsErrors, dwsExprs,
  Hope.DataModule, Hope.WelcomePage, Hope.ProjectManager, Hope.UnitManager,
  Hope.MessageWindow.Compiler, Hope.MessageWindow.Output, Hope.Docking.Host,
  Hope.Project, Hope.Project.List, Hope.Editor, Hope.EditorList,
  Hope.Compiler.Internal;

type
  TFormMain = class(TForm)
    ActionEditCopy: TEditCopy;
    ActionEditCut: TEditCut;
    ActionEditDelete: TEditDelete;
    ActionEditPaste: TEditPaste;
    ActionEditRedo: TAction;
    ActionEditSelectAll: TEditSelectAll;
    ActionEditUndo: TEditUndo;
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
    ActionMacroPlay: TAction;
    ActionMacroRecord: TAction;
    ActionMacroStop: TAction;
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
    ActionToolsAsciiChart: TAction;
    ActionToolsCodeTemplates: TAction;
    ActionToolsColorPicker: TAction;
    ActionToolsPreferences: TAction;
    ActionToolsUnicodeExplorer: TAction;
    ActionViewClassExplorer: TAction;
    ActionViewFileBrowser: TAction;
    ActionViewUnits: TAction;
    ActionViewWelcomePage: TAction;
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
    MenuItemToolsAsciiChart: TMenuItem;
    MenuItemToolsCodeTemplates: TMenuItem;
    MenuItemToolsColorPicker: TMenuItem;
    MenuItemToolsPreferences: TMenuItem;
    MenuItemToolsUnicodeExplorer: TMenuItem;
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
    PanelBottom: TPanel;
    PanelLeft: TPanel;
    PanelMain: TPanel;
    PanelRight: TPanel;
    PanelTabs: TPanel;
    SplitterBottom: TSplitter;
    SplitterLeft: TSplitter;
    SplitterRight: TSplitter;
    TabSet: TTabSet;
    procedure FormShow(Sender: TObject);
    procedure FormDockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure FormGetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure ActionFileCloseProjectExecute(Sender: TObject);
    procedure ActionFileNewProjectExecute(Sender: TObject);
    procedure ActionFileOpenProjectAccept(Sender: TObject);
    procedure ActionHelpAboutExecute(Sender: TObject);
    procedure ActionMacroPlayExecute(Sender: TObject);
    procedure ActionMacroRecordExecute(Sender: TObject);
    procedure ActionMacroStopExecute(Sender: TObject);
    procedure ActionProjectOptionsExecute(Sender: TObject);
    procedure ActionSearchFindInFilesExecute(Sender: TObject);
    procedure ActionToolsAsciiChartExecute(Sender: TObject);
    procedure ActionToolsCodeTemplatesExecute(Sender: TObject);
    procedure ActionToolsColorPickerExecute(Sender: TObject);
    procedure ActionToolsPreferencesExecute(Sender: TObject);
    procedure ActionToolsUnicodeExplorerExecute(Sender: TObject);
    procedure PanelUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure PanelTabsDockDrop(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer);
    procedure TabSetChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ActionProjectSyntaxCheckExecute(Sender: TObject);
    procedure ActionProjectCompileExecute(Sender: TObject);
    procedure ActionProjectBuildExecute(Sender: TObject);
  private
    FWelcomePage: TFormWelcomePage;

    FProjects: THopeProjectList;
    FEditors: TEditorList;
    FFocusedEditorForm: TFormEditor;
    FFocusedEditor: TSynEdit;

    FUnitManager: TFormUnitManager;
    FProjectManager: TFormProjectManager;
    FCompilerMessages: TFormCompilerMessages;
    FOutputMessages: TFormOutputMessages;

    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
    function ComputeDockingRect(var DockRect: TRect; MousePos: TPoint): TAlign;

    procedure TabChanged;

    procedure RegisterNewTab(Form: TForm; Focus: Boolean = True);
    procedure RegisterNewEditor(FileName: TFileName);
    procedure FocusTab(Form: TForm);
    function GetCompiler: THopeInternalCompiler; inline;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure LoadProject(ProjectFileName: TFileName);

    procedure ShowDockPanel(APanel: TPanel; MakeVisible: Boolean; Client: TControl);

    procedure FocusEditor(FileName: TFileName);

    procedure UpdateUnitMap(CompiledProgran: IdwsProgram);

    procedure LogCompilerMessages(Messages: TdwsMessageList);

    property Projects: THopeProjectList read FProjects;
    property FocusedEditor: TSynEdit read FFocusedEditor;
    property Compiler: THopeInternalCompiler read GetCompiler;
  end;

var
  FormMain: TFormMain;

implementation

uses
  dwsUtils,
  Hope.About, Hope.AsciiChart, Hope.ColorPicker, Hope.Dialogs.CodeTemplates,
  Hope.Dialogs.FindInFiles, Hope.Dialogs.Preferences,
  Hope.Dialogs.ProjectOptions, Hope.Docking.Form, Hope.UnicodeExplorer;

{$R *.dfm}

{ TFormMain }

procedure TFormMain.AfterConstruction;
begin
  inherited;

  FEditors := TEditorList.Create;
  FProjects := THopeProjectList.Create;

  FWelcomePage := TFormWelcomePage.Create(nil);
  FUnitManager := TFormUnitManager.Create(nil);
  FProjectManager := TFormProjectManager.Create(nil);
  FCompilerMessages := TFormCompilerMessages.Create(nil);
  FOutputMessages := TFormOutputMessages.Create(nil);
end;

procedure TFormMain.BeforeDestruction;
begin
(*
  FOutputMessages.Free;
  FCompilerMessages.Free;
*)
  FProjectManager.Free;
  FUnitManager.Free;
  FWelcomePage.Free;

  FProjects.Free;
  FEditors.Free;

  inherited;
end;

procedure TFormMain.CMDockClient(var Message: TCMDockClient);
var
  ARect: TRect;
  DockType: TAlign;
  Pt: TPoint;
begin
  if Message.DockSource.Control is TFormDockable then
  begin
    Pt.X := Message.MousePos.X;
    Pt.Y := Message.MousePos.Y;
    DockType := ComputeDockingRect(ARect, Pt);

    case DockType of
      alLeft:
        begin
          ShowDockPanel(PanelLeft, True, Message.DockSource.Control);
          Message.DockSource.Control.ManualDock(PanelLeft, nil, alClient);
        end;
      alRight:
        begin
          ShowDockPanel(PanelRight, True, Message.DockSource.Control);
          Message.DockSource.Control.ManualDock(PanelRight, nil, alClient);
        end;
      alBottom:
        begin
          ShowDockPanel(PanelBottom, True, Message.DockSource.Control);
          Message.DockSource.Control.ManualDock(PanelBottom, nil, alClient);
        end;
    end;
  end;
end;

function TFormMain.ComputeDockingRect(var DockRect: TRect; MousePos: TPoint): TAlign;
var
  DockLeftRect, DockRightRect, DockBottomRect: TRect;
begin
  Result := alNone;

  // divide form up into docking zones
  DockLeftRect.TopLeft := Point(0, 0);
  DockLeftRect.BottomRight := Point(ClientWidth div 5, ClientHeight);

  DockRightRect.TopLeft := Point(4 * ClientWidth div 5, 0);
  DockRightRect.BottomRight := Point(ClientWidth, ClientHeight);

  DockBottomRect.TopLeft := Point(ClientWidth div 5, 4 * ClientHeight div 5);
  DockBottomRect.BottomRight := Point(4 * ClientWidth div 5, ClientHeight);

  // locate the mouse position in the docking zone
  if PtInRect(DockLeftRect, MousePos) then
  begin
    Result := alLeft;
    DockRect := DockLeftRect;
    DockRect.Right := ClientWidth div 3;
  end
  else
  if PtInRect(DockRightRect, MousePos) then
  begin
    Result := alRight;
    DockRect := DockRightRect;
    DockRect.Left := 2 * ClientWidth div 3;
  end
  else
  if PtInRect(DockBottomRect, MousePos) then
  begin
    Result := alBottom;
    DockRect := DockBottomRect;
    DockRect.Left := 0;
    DockRect.Right := ClientWidth;
    DockRect.Top := 2 * ClientHeight div 3;
  end;

  // check if a docking area has been determined
  if Result = alNone then Exit;

  // DockRect is in screen coordinates.
  DockRect.TopLeft := ClientToScreen(DockRect.TopLeft);
  DockRect.BottomRight := ClientToScreen(DockRect.BottomRight);
end;

procedure TFormMain.FormDockOver(Sender: TObject; Source: TDragDockObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  ARect: TRect;
begin
  Accept := (Source.Control is TFormDockable);

  // Draw dock preview depending on where the cursor is relative to our client area
  if Accept and (ComputeDockingRect(ARect, Point(X, Y)) <> alNone) then
  begin
    ComputeDockingRect(ARect, Point(X, Y));
    Source.DockRect := ARect;
  end;
end;

procedure TFormMain.FormGetSiteInfo(Sender: TObject; DockClient: TControl;
  var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
  // if CanDock is true, the panel will not automatically draw the preview rect.
  CanDock := (DockClient is TFormDockable);
end;

procedure TFormMain.FormShow(Sender: TObject);
var
  Host: TFormDockHost;
begin
  // dock unit manager on the left
  FUnitManager.ManualDock(PanelLeft);
  ShowDockPanel(PanelLeft, True, FUnitManager);

  // dock unit manager on the right
  FProjectManager.ManualDock(PanelRight);
  ShowDockPanel(PanelRight, True, FProjectManager);

  // create docking host for messages (and dock on the bottom)
  Host := TFormDockHost.Create(Application);
  Host.IsPaged := True;
  Host.BoundsRect := Self.BoundsRect;
  FCompilerMessages.ManualDock(Host.PanelDock, nil, alClient);
  FCompilerMessages.DockSite := False;
  FOutputMessages.ManualDock(Host.PanelDock, nil, alClient);
  FOutputMessages.DockSite := False;
  Host.IsPaged := True;
  Host.ManualDock(PanelBottom);
  ShowDockPanel(PanelBottom, True, Host);
  Host.TabSet.TabIndex := 0;

  RegisterNewTab(FWelcomePage);
  FWelcomePage.ReloadUrl;
  // FWelcomePage.Chromium.ShowDevTools;

  FFocusedEditorForm := nil;
  FFocusedEditor := nil;
end;

function TFormMain.GetCompiler: THopeInternalCompiler;
begin
  Result := DataModuleCommon.InternalCompiler;
end;

procedure TFormMain.LoadProject(ProjectFileName: TFileName);
begin
  // abort any scheduled background compilation
  DataModuleCommon.BackgroundCompiler.Abort;

  // load project (if possible)
  if FProjects.LoadProject(ProjectFileName) then
  begin
    // update project manager
    FProjectManager.UpdateNodes;
    FProjectManager.TreeProject.Enabled := True;

    DataModuleCommon.MonitoredBuffer.AddPath(FProjects.ActiveProject.RootPath);

    DataModuleCommon.BackgroundCompiler.Invalidate;
  end;
end;

procedure TFormMain.LogCompilerMessages(Messages: TdwsMessageList);
begin
  FCompilerMessages.LogMessages(Messages);
end;

procedure TFormMain.PanelTabsDockDrop(Sender: TObject; Source: TDragDockObject;
  X, Y: Integer);
begin
  if PanelTabs.DockSite and PanelTabs.UseDockManager then
    PanelTabs.DockManager.ResetBounds(True)
  else
    Source.Control.Align := alClient;
end;

procedure TFormMain.RegisterNewEditor(FileName: TFileName);
var
  Editor: TFormEditor;
begin
  Editor := TFormEditor.Create(nil);
  Editor.FileName := FileName;

  FEditors.Add(Editor);

  RegisterNewTab(Editor);
end;

procedure TFormMain.RegisterNewTab(Form: TForm; Focus: Boolean = True);
begin
  Form.ManualDock(PanelTabs);
  TabSet.TabIndex := TabSet.Tabs.Add(Form.Caption);
  Form.Show;
end;

procedure TFormMain.PanelUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
  // OnUnDock gets called BEFORE the client is undocked, in order to optionally
  // disallow the undock. DockClientCount is never 0 when called from this event.
  if (Sender as TPanel).DockClientCount = 1 then
    ShowDockPanel(Sender as TPanel, False, nil);
end;

procedure TFormMain.ShowDockPanel(APanel: TPanel; MakeVisible: Boolean;
  Client: TControl);
begin
  if not MakeVisible and (APanel.VisibleDockClientCount > 1) then
    Exit;

  if APanel = PanelLeft then
  begin
    SplitterLeft.Visible := MakeVisible;
    APanel.Visible := MakeVisible;
    if MakeVisible then
    begin
      APanel.Width := ClientWidth div 4;
      SplitterLeft.Left := APanel.Width + SplitterLeft.Width;
    end;
  end
  else
  if APanel = PanelRight then
  begin
    SplitterRight.Visible := MakeVisible;
    APanel.Visible := MakeVisible;
    if MakeVisible then
    begin
      APanel.Width := ClientWidth div 4;
      SplitterRight.Left := APanel.Left - SplitterRight.Width;
    end;
  end
  else
  if APanel = PanelBottom then
  begin
    SplitterBottom.Visible := MakeVisible;
    APanel.Visible := MakeVisible;
    if MakeVisible then
    begin
      APanel.Height := ClientWidth div 5;
      SplitterRight.Top := ClientHeight - APanel.Height - SplitterBottom.Width;
    end;
  end;

  if MakeVisible and (Client <> nil) then
    Client.Show;
end;

procedure TFormMain.FocusEditor(FileName: TFileName);
var
  Index: Integer;
begin
  for Index := 0 to FEditors.Count - 1 do
    if UnicodeSameText(FileName, FEditors[Index].FileName) then
    begin
      FocusTab(FEditors[Index]);
      Exit;
    end;

  RegisterNewEditor(FileName);
end;

procedure TFormMain.FocusTab(Form: TForm);
var
  Index: Integer;
begin
  // assign editor form
  if Form is TFormEditor then
    FFocusedEditorForm := TFormEditor(Form)
  else
    FFocusedEditorForm := nil;

  // now assign editor
  if Assigned(FFocusedEditorForm) then
    FFocusedEditor := FFocusedEditorForm.Editor
  else
    FFocusedEditor := nil;

  TabSet.OnChange := nil;
  try
    for Index := 0 to FEditors.Count - 1 do
    begin
      FEditors[Index].Visible := FEditors[Index] = FFocusedEditorForm;

      if FEditors[Index] = FFocusedEditorForm then
        TabSet.TabIndex := Index + 1;
    end;
  finally
    TabSet.OnChange := TabSetChange;
  end;

  if Assigned(FFocusedEditor) then
    FFocusedEditor.SetFocus;
end;

procedure TFormMain.TabChanged;
begin

end;

procedure TFormMain.TabSetChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
  Index: Integer;
  Control: TControl;
begin
  Control := nil;

  // locate active control
  for Index := 0 to PanelTabs.DockClientCount - 1 do
    if Index = NewTab then
    begin
      Control := PanelTabs.DockClients[Index];
      Break;
    end;

  // check if control is assigned at all
  if not (Control is TForm) then
    Exit;

  // make control visible
  Control.Visible := True;

  // focus tab
  FocusTab(TForm(Control));
  TabChanged;

  // locate active control
  for Index := 0 to PanelTabs.DockClientCount - 1 do
    PanelTabs.DockClients[Index].Visible := Index = NewTab;
end;

procedure TFormMain.UpdateUnitMap(CompiledProgran: IdwsProgram);
begin
  // yet todo
end;

procedure TFormMain.ActionToolsAsciiChartExecute(Sender: TObject);
begin
  with TFormAsciiChart.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionFileCloseProjectExecute(Sender: TObject);
begin
  // abort any scheduled background compilation
  DataModuleCommon.BackgroundCompiler.Abort;

  // now remove project from projects list
  FProjects.RemoveProject(FProjects.ActiveProject);
end;

procedure TFormMain.ActionFileNewProjectExecute(Sender: TObject);
begin
  //NewProject;
end;

procedure TFormMain.ActionFileOpenProjectAccept(Sender: TObject);
begin
  LoadProject(ActionFileOpenProject.Dialog.FileName);
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

procedure TFormMain.ActionMacroPlayExecute(Sender: TObject);
begin
  // play editor macro
  DataModuleCommon.PerformMacro(FFocusedEditor, maPlay);
end;

procedure TFormMain.ActionMacroRecordExecute(Sender: TObject);
begin
  // record editor macro
  DataModuleCommon.PerformMacro(FFocusedEditor, maRecord);
end;

procedure TFormMain.ActionMacroStopExecute(Sender: TObject);
begin
  // stop editor macro
  DataModuleCommon.PerformMacro(FFocusedEditor, maStop);
end;

procedure TFormMain.ActionProjectSyntaxCheckExecute(Sender: TObject);
begin
  Compiler.SyntaxCheck(Projects.ActiveProject);
end;

procedure TFormMain.ActionProjectCompileExecute(Sender: TObject);
begin
  // eventually sync focused editor
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.EditorToBuffer;

  // compile project
  Compiler.CompileProject(Projects.ActiveProject);
end;

procedure TFormMain.ActionProjectBuildExecute(Sender: TObject);
begin
  // build project
  Compiler.BuildProject(Projects.ActiveProject);
end;

procedure TFormMain.ActionProjectOptionsExecute(Sender: TObject);
begin
  // show project options dialog
  with TFormProjectOptions.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionSearchFindInFilesExecute(Sender: TObject);
begin
  // show 'find in files' dialog
  with TFormFindInFiles.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionToolsCodeTemplatesExecute(Sender: TObject);
begin
  // show 'code templates' dialog
  with TFormCodeTemplates.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionToolsColorPickerExecute(Sender: TObject);
begin
  // show 'color picker' dialog
  with TFormColorPicker.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionToolsPreferencesExecute(Sender: TObject);
begin
  // show preferences dialog
  with TFormPreferences.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionToolsUnicodeExplorerExecute(Sender: TObject);
begin
  // show unicode explorer dialog
  with TFormUnicodeExplorer.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

end.
