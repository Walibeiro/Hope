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
  Hope.Project.IDE, Hope.Editor, Hope.EditorList,
  Hope.Compiler.Internal, Hope.Dialog.FindReplace;

type
  TFormMain = class(TForm)
    ActionEditorCodeSuggestions: TAction;
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
    ActionFileOpenRecentProperties: TAction;
    ActionFileSave: TAction;
    ActionFileSaveAs: TFileSaveAs;
    ActionFileSaveProject: TAction;
    ActionFileSaveProjectAs: TFileSaveAs;
    ActionEditorGotoImplementation: TAction;
    ActionEditorGotoInterface: TAction;
    ActionHelpAbout: TAction;
    ActionList: TActionList;
    ActionMacroPlay: TAction;
    ActionMacroRecord: TAction;
    ActionMacroStop: TAction;
    ActionEditorMoveDown: TAction;
    ActionEditorMoveUp: TAction;
    ActionPageCloseOthers: TAction;
    ActionPageClosePage: TAction;
    ActionEditorParameterInfo: TAction;
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
    ActionSearchFind: TAction;
    ActionSearchFindClass: TAction;
    ActionSearchFindInFiles: TAction;
    ActionSearchFindNext: TAction;
    ActionSearchGotoLineNumber: TAction;
    ActionSearchReplace: TAction;
    ActionToolsAsciiChart: TAction;
    ActionToolsCodeTemplates: TAction;
    ActionToolsColorPicker: TAction;
    ActionToolsPreferences: TAction;
    ActionToolsUnicodeExplorer: TAction;
    ActionViewClassExplorer: TAction;
    ActionViewFileBrowser: TAction;
    ActionViewUnits: TAction;
    ActionViewWelcomePage: TAction;
    Closeallotherpages1: TMenuItem;
    MainMenu: TMainMenu;
    MenuFileOpenRecentProperties: TMenuItem;
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
    MenuItemPageClosePage: TMenuItem;
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
    N1: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N2: TMenuItem;
    Pages1: TMenuItem;
    PanelBottom: TPanel;
    PanelLeft: TPanel;
    PanelMain: TPanel;
    PanelRight: TPanel;
    PanelTabs: TPanel;
    PopupMenu: TPopupMenu;
    SplitterBottom: TSplitter;
    SplitterLeft: TSplitter;
    SplitterRight: TSplitter;
    TabSet: TTabSet;
    ActionEditorOpenFileAtCursor: TAction;
    ActionEditorFindDeclaration: TAction;
    ActionEditorFormatSource: TAction;
    ActionEditorFindUsage: TAction;
    ActionEditorTopicSearch: TAction;
    ActionEditorCompleteClassAtCursor: TAction;
    ActionEditorToggleComment: TAction;
    ActionEditorAddTodo: TAction;
    ActionViewMiniMap: TAction;
    N3: TMenuItem;
    ActionViewMiniMap1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure FormGetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure ActionProjectSyntaxCheckExecute(Sender: TObject);
    procedure ActionProjectCompileExecute(Sender: TObject);
    procedure ActionProjectBuildExecute(Sender: TObject);
    procedure ActionFileSaveProjectExecute(Sender: TObject);
    procedure ActionSearchFindExecute(Sender: TObject);
    procedure ActionSearchReplaceExecute(Sender: TObject);
    procedure ActionSearchFindNextExecute(Sender: TObject);
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
    procedure ActionFileOpenRecentPropertiesExecute(Sender: TObject);
    procedure ActionSearchFindClassExecute(Sender: TObject);
    procedure ActionSearchGotoLineNumberExecute(Sender: TObject);
    procedure ActionViewWelcomePageExecute(Sender: TObject);
    procedure ActionPageClosePageExecute(Sender: TObject);
    procedure ActionPageCloseOthersExecute(Sender: TObject);
    procedure ActionEditorMoveUpExecute(Sender: TObject);
    procedure ActionEditorMoveDownExecute(Sender: TObject);
    procedure ActionEditorCodeSuggestionsExecute(Sender: TObject);
    procedure ActionEditorParameterInfoExecute(Sender: TObject);
    procedure ActionEditorGotoInterfaceExecute(Sender: TObject);
    procedure ActionEditorGotoImplementationExecute(Sender: TObject);
    procedure ActionEditorOpenFileAtCursorExecute(Sender: TObject);
    procedure ActionEditorFormatSourceExecute(Sender: TObject);
    procedure ActionEditorToggleCommentExecute(Sender: TObject);
    procedure ActionEditorCompleteClassAtCursorExecute(Sender: TObject);
    procedure ActionViewMiniMapExecute(Sender: TObject);
  private
    FWelcomePage: TFormWelcomePage;

    FProjects: THopeProjectListIDE;
    FEditors: TEditorList;
    FFocusedEditorForm: TFormEditor;
    FFocusedEditor: TSynEdit;

    FUnitManager: TFormUnitManager;
    FProjectManager: TFormProjectManager;
    FCompilerMessages: TFormCompilerMessages;
    FOutputMessages: TFormOutputMessages;

    FFormFindReplace: TFormFindReplace;

    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
    function ComputeDockingRect(var DockRect: TRect; MousePos: TPoint): TAlign;

    procedure RegisterNewTab(Form: TForm; Focus: Boolean = True);
    procedure FocusTab(Form: TForm);
    function GetCompiler: THopeInternalCompiler; inline;
    procedure RecentProjectClickHandler(Sender: TObject);
    procedure RecentUnitClickHandler(Sender: TObject);
  protected
    procedure PreferencesChanged;
    procedure TabChanged;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure LoadProject(ProjectFileName: TFileName);
    procedure SaveProject; overload;
    procedure SaveProject(ProjectFileName: TFileName); overload;

    procedure ShowDockPanel(APanel: TPanel; MakeVisible: Boolean; Client: TControl);

    procedure SyncEditorToBuffer;
    procedure FocusEditor(FileName: TFileName);
    function RegisterNewEditor(FileName: TFileName): TFormEditor;

    procedure UpdateUnitMap(CompiledProgran: IdwsProgram);
    procedure UpdateRecentFiles;

    procedure LogCompilerMessages(Messages: TdwsMessageList);

    property Projects: THopeProjectListIDE read FProjects;
    property FocusedEditor: TSynEdit read FFocusedEditor;
    property FocusedEditorForm: TFormEditor read FFocusedEditorForm;
    property Compiler: THopeInternalCompiler read GetCompiler;

    property Editors: TEditorList read FEditors;
  end;

var
  FormMain: TFormMain;

implementation

uses
  dwsUtils, SynCompletionProposal,
  Hope.About, Hope.AsciiChart, Hope.ColorPicker, Hope.Common.History,
  Hope.Dialog.CodeTemplates, Hope.Dialog.FindClass, Hope.Dialog.FindInFiles,
  Hope.Dialog.GotoLineNumber, Hope.Dialog.Preferences,
  Hope.Dialog.ProjectOptions, Hope.Dialog.RecentProperties,
  Hope.Docking.Form, Hope.UnicodeExplorer;

{$R *.dfm}

{ TFormMain }

procedure TFormMain.AfterConstruction;
begin
  inherited;

  FEditors := TEditorList.Create;
  FProjects := THopeProjectListIDE.Create;

  FWelcomePage := TFormWelcomePage.Create(nil);
  FUnitManager := TFormUnitManager.Create(nil);
  FProjectManager := TFormProjectManager.Create(nil);
  FCompilerMessages := TFormCompilerMessages.Create(nil);
  FOutputMessages := TFormOutputMessages.Create(nil);

  ActionEditorToggleComment.ShortCut := scCtrl + 191;
end;

procedure TFormMain.BeforeDestruction;
begin
  FProjects.SaveLocalFiles;
(*
  FOutputMessages.Free;
  FCompilerMessages.Free;
*)
  FFormFindReplace.Free;

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

  DataModuleCommon.Positions.Main.LoadPosition(Self);

  RegisterNewTab(FWelcomePage);
  FWelcomePage.ReloadUrl;
  // FWelcomePage.Chromium.ShowDevTools;

  UpdateRecentFiles;

  ActionFileSave.Enabled := False;
  ActionFileSaveAs.Enabled := False;
  ActionFileSaveProject.Enabled := False;
  ActionFileSaveProjectAs.Enabled := False;
  ActionFileCloseProject.Enabled := False;

  FFocusedEditorForm := nil;
  FFocusedEditor := nil;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataModuleCommon.Positions.Main.SavePosition(Self);
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

    DataModuleCommon.AddProjectToHistory(ProjectFileName);

    ActionFileSaveProject.Enabled := True;
    ActionFileSaveProjectAs.Enabled := True;
    ActionFileCloseProject.Enabled := True;

    UpdateRecentFiles;
  end;
end;

procedure TFormMain.SaveProject;
var
  Project: THopeProjectIDE;
begin
  // get active project and check whether it is not nil
  Project := FProjects.ActiveProjectIDE;
  if not Assigned(Project) then
    Exit;

  Project.SaveToFile(Project.FileName);
  DataModuleCommon.AddProjectToHistory(Project.FileName);
end;

procedure TFormMain.SaveProject(ProjectFileName: TFileName);
var
  Project: THopeProjectIDE;
begin
  // get active project and check whether it is not nil
  Project := FProjects.ActiveProjectIDE;
  if not Assigned(Project) then
    Exit;

  Project.SaveToFile(ProjectFileName);
  DataModuleCommon.AddProjectToHistory(ProjectFileName);
end;

procedure TFormMain.LogCompilerMessages(Messages: TdwsMessageList);
begin
  FCompilerMessages.Clear;
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

function TFormMain.RegisterNewEditor(FileName: TFileName): TFormEditor;
begin
  Result := TFormEditor.Create(nil);
  Result.FileName := FileName;

  FEditors.Add(Result);

  RegisterNewTab(Result);
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

procedure TFormMain.PreferencesChanged;
var
  Index: Integer;
begin
  for Index := 0 to FEditors.Count - 1 do
    FEditors[Index].SetupEditorFromPreferences;

  DataModuleCommon.SetupFromPreferences;
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
  FormEditor: TFormEditor;
begin
  FormEditor := FEditors.GetEditorForFileName(FileName);
  if Assigned(FormEditor) then
    FocusTab(FormEditor)
  else
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

    // eventually focus welcome page
    if Form = FWelcomePage then
    begin
      FWelcomePage.Visible := True;
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

  SyncEditorToBuffer;

  // focus tab
  FocusTab(TForm(Control));
  TabChanged;

  // locate active control
  for Index := 0 to PanelTabs.DockClientCount - 1 do
    PanelTabs.DockClients[Index].Visible := Index = NewTab;
end;

procedure TFormMain.SyncEditorToBuffer;
begin
  // eventually sync focused editor
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.EditorToBuffer;
end;

procedure TFormMain.UpdateRecentFiles;
var
  Index: Integer;
  History: THopeHistory;
  MaxFiles: Integer;
  MenuItem: TMenuItem;
begin
  // delete all items except the last two
  while MenuItemFileOpenRecent.Count > 2 do
    MenuItemFileOpenRecent.Delete(0);

  History := DataModuleCommon.History;

  // add units
  MaxFiles := DataModuleCommon.Preferences.Recent.UnitCount;
  for Index := Min(MaxFiles, History.UnitsHistory.Count) - 1 downto 0 do
  begin
    MenuItem := TMenuItem.Create(MenuItemFileOpenRecent);
    MenuItem.Caption := History.UnitsHistory[Index];
    MenuItem.OnClick := RecentUnitClickHandler;
    MenuItem.Tag := Index;
    MenuItemFileOpenRecent.Insert(0, MenuItem);
  end;

  // add separator
  MenuItem := TMenuItem.Create(MenuItemFileOpenRecent);
  MenuItem.Caption := '-';
  MenuItemFileOpenRecent.Insert(0, MenuItem);

  MaxFiles := DataModuleCommon.Preferences.Recent.ProjectCount;
  for Index := Min(MaxFiles, History.ProjectsHistory.Count) - 1 downto 0 do
  begin
    MenuItem := TMenuItem.Create(MenuItemFileOpenRecent);
    MenuItem.Caption := History.ProjectsHistory[Index];
    MenuItem.OnClick := RecentProjectClickHandler;
    MenuItem.Tag := Index;
    MenuItemFileOpenRecent.Insert(0, MenuItem);
  end;
end;

procedure TFormMain.RecentProjectClickHandler(Sender: TObject);
begin
  Assert(Sender is TMenuItem);
  LoadProject(DataModuleCommon.History.ProjectsHistory[TMenuItem(Sender).Tag]);
end;

procedure TFormMain.RecentUnitClickHandler(Sender: TObject);
begin
  //
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

procedure TFormMain.ActionEditorCodeSuggestionsExecute(Sender: TObject);
begin
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.InvokeCodeSuggestions;
end;

procedure TFormMain.ActionFileCloseProjectExecute(Sender: TObject);
begin
  // abort any scheduled background compilation
  DataModuleCommon.BackgroundCompiler.Abort;

  // now remove project from projects list
  FProjects.RemoveProject(FProjects.ActiveProject);

  ActionFileSaveProject.Enabled := Assigned(FProjects.ActiveProject);
  ActionFileSaveProjectAs.Enabled := Assigned(FProjects.ActiveProject);
  ActionFileCloseProject.Enabled := Assigned(FProjects.ActiveProject);
end;

procedure TFormMain.ActionFileNewProjectExecute(Sender: TObject);
begin
  //NewProject;
end;

procedure TFormMain.ActionFileOpenProjectAccept(Sender: TObject);
begin
  LoadProject(ActionFileOpenProject.Dialog.FileName);
end;

procedure TFormMain.ActionFileOpenRecentPropertiesExecute(Sender: TObject);
begin
  with TFormRecentProperties.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionFileSaveProjectExecute(Sender: TObject);
begin
  SaveProject;
end;

procedure TFormMain.ActionEditorCompleteClassAtCursorExecute(Sender: TObject);
begin
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.CompleteClassAtCursor;
end;

procedure TFormMain.ActionEditorFormatSourceExecute(Sender: TObject);
begin
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.FormatSource;
end;

procedure TFormMain.ActionEditorGotoImplementationExecute(Sender: TObject);
begin
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.GotoImplementation;
end;

procedure TFormMain.ActionEditorGotoInterfaceExecute(Sender: TObject);
begin
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.GotoInterface;
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

procedure TFormMain.ActionEditorMoveDownExecute(Sender: TObject);
begin
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.MoveLines(False);
end;

procedure TFormMain.ActionEditorMoveUpExecute(Sender: TObject);
begin
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.MoveLines(True);
end;

procedure TFormMain.ActionEditorOpenFileAtCursorExecute(Sender: TObject);
begin
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.OpenFileAtCursor;
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

procedure TFormMain.ActionPageClosePageExecute(Sender: TObject);
begin
  if TabSet.TabIndex > 0 then
  begin
    Editors.Delete(TabSet.TabIndex - 1);
    TabSet.Tabs.Delete(TabSet.TabIndex);
  end;
end;

procedure TFormMain.ActionEditorParameterInfoExecute(Sender: TObject);
begin
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.InvokeParameterInformation;
end;

procedure TFormMain.ActionEditorToggleCommentExecute(Sender: TObject);
begin
  if Assigned(FFocusedEditorForm) then
    FFocusedEditorForm.ToggleComment;
end;

procedure TFormMain.ActionPageCloseOthersExecute(Sender: TObject);
var
  Index: Integer;
begin
  if TabSet.TabIndex > 0 then
  begin
    for Index := TabSet.TabIndex + 1 to TabSet.Tabs.Count - 1 do
    begin
      Editors.Delete(Index - 1);
      TabSet.Tabs.Delete(Index);
    end;
  end;
end;

procedure TFormMain.ActionProjectBuildExecute(Sender: TObject);
begin
  FOutputMessages.Clear;

  // build project
  Compiler.BuildProject(Projects.ActiveProject);
end;

procedure TFormMain.ActionProjectOptionsExecute(Sender: TObject);
var
  Project: THopeProjectIDE;
  Modified: Boolean;
begin
  // only show if an active project is available
  if not Assigned(FProjects.ActiveProject) then
    Exit;

  // local alias for active project
  Project := FProjects.ActiveProjectIDE;

  Modified := TFormProjectOptions.CreateAndShow(Project.Options);
end;

procedure TFormMain.ActionSearchFindClassExecute(Sender: TObject);
begin
  // show 'find in files' dialog
  with TFormFindClass.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionSearchFindExecute(Sender: TObject);
begin
  if not Assigned(FFormFindReplace) then
    FFormFindReplace := TFormFindReplace.Create(Self);

  FFormFindReplace.CheckBoxReplace.Checked := False;
  FFormFindReplace.Show;
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

procedure TFormMain.ActionSearchFindNextExecute(Sender: TObject);
begin
  if not Assigned(FFormFindReplace) then
    FFormFindReplace := TFormFindReplace.Create(Self);

  FFormFindReplace.PerformNext;
end;

procedure TFormMain.ActionSearchGotoLineNumberExecute(Sender: TObject);
begin
  // show 'find in files' dialog
  with TFormGotoLineNumber.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.ActionSearchReplaceExecute(Sender: TObject);
begin
  if not Assigned(FFormFindReplace) then
    FFormFindReplace := TFormFindReplace.Create(Self);

  FFormFindReplace.CheckBoxReplace.Checked := True;
  FFormFindReplace.Show;
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
    Load;
    if ShowModal = mrOk then
    begin
      PreferencesChanged;
      Store;
    end;
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

procedure TFormMain.ActionViewMiniMapExecute(Sender: TObject);
var
  Index: Integer;
begin
  for Index := 0 to FEditors.Count - 1 do
    FEditors[Index].MiniMapVisible := ActionViewMiniMap.Checked;
end;

procedure TFormMain.ActionViewWelcomePageExecute(Sender: TObject);
begin
  FocusTab(FWelcomePage);
end;

end.
