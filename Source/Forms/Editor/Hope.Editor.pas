unit Hope.Editor;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ToolWin,
  SynEdit, SynEditTypes, SynEditKeyCmds, Hope.DataModule, Hope.Project.Local,
  Vcl.Menus;

type
  TStatusBar = class(Vcl.ComCtrls.TStatusBar)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  IEditorService = interface
    procedure InvokeCodeSuggestions;
    procedure InvokeParameterInformation;
    procedure GotoInterface;
    procedure GotoImplementation;
    procedure OpenFileAtCursor;
    procedure CompleteClassAtCursor;
    procedure ToggleComment;
    procedure FormatSource;
    procedure MoveLines(MoveUp: Boolean);
    procedure SetupEditorFromPreferences;
  end;

  TFormEditor = class(TForm, IEditorService)
    Editor: TSynEdit;
    FindDeclaration1: TMenuItem;
    MenuItemClearBookmarks: TMenuItem;
    MenuItemClosePage: TMenuItem;
    MenuItemCompleteClassatCursor: TMenuItem;
    MenuItemCopy: TMenuItem;
    MenuItemCut: TMenuItem;
    MenuItemFind: TMenuItem;
    MenuItemFormatSource: TMenuItem;
    MenuItemGotoBookmark0: TMenuItem;
    MenuItemGotoBookmark1: TMenuItem;
    MenuItemGotoBookmark2: TMenuItem;
    MenuItemGotoBookmark3: TMenuItem;
    MenuItemGotoBookmark4: TMenuItem;
    MenuItemGotoBookmark5: TMenuItem;
    MenuItemGotoBookmark6: TMenuItem;
    MenuItemGotoBookmark7: TMenuItem;
    MenuItemGotoBookmark8: TMenuItem;
    MenuItemGotoBookmark9: TMenuItem;
    MenuItemGotoBookmarks: TMenuItem;
    MenuItemOpenFileAtCursor: TMenuItem;
    MenuItemPaste: TMenuItem;
    MenuItemToggleBookmark0: TMenuItem;
    MenuItemToggleBookmark1: TMenuItem;
    MenuItemToggleBookmark2: TMenuItem;
    MenuItemToggleBookmark3: TMenuItem;
    MenuItemToggleBookmark4: TMenuItem;
    MenuItemToggleBookmark5: TMenuItem;
    MenuItemToggleBookmark6: TMenuItem;
    MenuItemToggleBookmark7: TMenuItem;
    MenuItemToggleBookmark8: TMenuItem;
    MenuItemToggleBookmark9: TMenuItem;
    MenuItemToggleBookmarks: TMenuItem;
    MenuItemToggleComment: TMenuItem;
    MenuItemTopicSearch: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    PopupMenu: TPopupMenu;
    StatusBar: TStatusBar;
    ToolBarMacro: TToolBar;
    ToolButtonPlay: TToolButton;
    ToolButtonRecord: TToolButton;
    ToolButtonStop: TToolButton;
    EditorMiniMap: TSynEdit;
    SplitterMiniMap: TSplitter;
    procedure EditorGutterPaint(Sender: TObject; aLine, X, Y: Integer);
    procedure EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure EditorChange(Sender: TObject);
    procedure EditorProcessUserCommand(Sender: TObject;
      var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
    procedure EditorEnter(Sender: TObject);
    procedure EditorClick(Sender: TObject);
    procedure MenuItemGotoBookmarkClick(Sender: TObject);
    procedure MenuItemToggleBookmarkClick(Sender: TObject);
    procedure MenuItemClearBookmarksClick(Sender: TObject);
    procedure EditorMiniMapSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure EditorMiniMapEnter(Sender: TObject);
    procedure EditorMiniMapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FFileName: TFileName;
    FShortFileName: TFileName;
    FExtension: string;
    FNeedsSync: Boolean;
    FMiniMapVisible: Boolean;
    function GetDottedWordAtCursor: string;
    procedure SetFileName(const Value: TFileName);
    procedure SetMiniMapVisible(const Value: Boolean);
    procedure FileNameChanged;
    procedure AddCustomEditorKeystrokes;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure MiniMapVisibleChanged;
  public
    procedure AfterConstruction; override;
    procedure Assign(Source: TPersistent); override;

    procedure EditorToBuffer;
    procedure BufferToEditor; overload;
    procedure BufferToEditor(Text: string); overload;

    procedure InvokeCodeSuggestions;
    procedure InvokeParameterInformation;
    procedure GotoInterface;
    procedure GotoImplementation;
    procedure OpenFileAtCursor;
    procedure CompleteClassAtCursor;
    procedure ToggleComment;
    procedure FormatSource;
    procedure MoveLines(MoveUp: Boolean);
    procedure SetupEditorFromPreferences;

    property FileName: TFileName read FFileName write SetFileName;
    property MiniMapVisible: Boolean read FMiniMapVisible write SetMiniMapVisible;
  end;

implementation

uses
  System.Contnrs, System.Math, dwsExprs, dwsSymbols, dwsTokenizer, dwsUtils,
  dwsXPlatform, Hope.Main, Hope.Common.FileUtilities,
  Hope.Common.MonitoredBuffer, Hope.Common.Preferences;

{$R *.dfm}

{ TStatusBar }

constructor TStatusBar.Create(AOwner: TComponent);
begin
  inherited;

  ControlStyle := ControlStyle + [csAcceptsControls];
end;


{ TFormEditor }

procedure TFormEditor.AfterConstruction;
begin
  inherited;

  ToolBarMacro.Parent := StatusBar;
  ToolBarMacro.Height := 16;
  ToolBarMacro.ButtonWidth := 16;
  ToolBarMacro.ButtonHeight := 14;
  ToolBarMacro.Left := 1;
  ToolBarMacro.Top := 3;
  ToolBarMacro.Images := DataModuleCommon.ImageList12;

  AddCustomEditorKeystrokes;
  SetupEditorFromPreferences;
end;

procedure TFormEditor.EditorChange(Sender: TObject);
begin
  FNeedsSync := True;
  DataModuleCommon.BackgroundCompiler.Invalidate;
end;

procedure TFormEditor.EditorClick(Sender: TObject);
var
  ShiftState: TShiftState;
begin
  ShiftState := KeyboardStateToShiftState;
  if (ssCtrl in ShiftState) then
    // goto definition
end;

procedure TFormEditor.EditorEnter(Sender: TObject);
begin
  DataModuleCommon.SynCodeSuggestions.Editor := Editor;
  DataModuleCommon.SynParameters.Editor := Editor;
end;

procedure TFormEditor.EditorGutterPaint(Sender: TObject; aLine, X, Y: Integer);
var
  StrLineNumber: string;
  LineNumberRect: TRect;
  GutterWidth, Offset: Integer;
  OldFont: TFont;
begin
  with TSynEdit(Sender), Canvas do
  begin
    Brush.Style := bsClear;
    GutterWidth := Gutter.Width - 5;
    if (ALine = 1) or (ALine = CaretY) or ((ALine mod 10) = 0) then
    begin
      StrLineNumber := IntToStr(ALine);
      LineNumberRect := Rect(x, y, GutterWidth, y + LineHeight);
      OldFont := TFont.Create;
      try
        OldFont.Assign(Canvas.Font);
        Canvas.Font := Gutter.Font;
        Canvas.TextRect(LineNumberRect, StrLineNumber, [tfVerticalCenter,
          tfSingleLine, tfRight]);
        Canvas.Font := OldFont;
      finally
        OldFont.Free;
      end;
    end
    else
    begin
      Canvas.Pen.Color := Gutter.Font.Color;
      if (ALine mod 5) = 0 then
        Offset := 5
      else
        Offset := 2;
      Inc(y, LineHeight div 2);
      Canvas.MoveTo(GutterWidth - Offset, y);
      Canvas.LineTo(GutterWidth, y);
    end;
  end;
end;

procedure TFormEditor.EditorMiniMapEnter(Sender: TObject);
begin
  Editor.SetFocus;
end;

procedure TFormEditor.EditorMiniMapMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DisplayCoord: TDisplayCoord;
begin
  DisplayCoord := EditorMiniMap.PixelsToNearestRowColumn(X, Y);
  Editor.CaretXY := Editor.DisplayToBufferPos(DisplayCoord);
  Editor.TopLine := Max(1, DisplayCoord.Row - (Editor.LinesInWindow div 2));
  Editor.Invalidate;
end;

procedure TFormEditor.EditorMiniMapSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
var
  CurrentMarks: TSynEditMarkList;
  MarkIndex: Integer;
begin
  CurrentMarks := Editor.Marks;
  for MarkIndex := 0 to CurrentMarks.Count - 1 do
  begin
    Special := (CurrentMarks[MarkIndex].Visible = True) and
      (Line = CurrentMarks[MarkIndex].Line);
    if Special then
    begin
      BG := $008080C0;
      Exit;
    end
  end;

  Special := (Cardinal(Line - Editor.TopLine) <=
    Cardinal(Editor.LinesInWindow));
  BG := Editor.ActiveLineColor;
end;

procedure TFormEditor.EditorProcessUserCommand(Sender: TObject;
  var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
begin
  inherited;

  case Command of
    ecUserFirst:
      begin
        FormMain.ActionEditorCodeSuggestions.Execute;
        AChar := #0;
      end;
    ecUserFirst + 1:
      begin
        FormMain.ActionEditorParameterInfo.Execute;
        AChar := #0;
      end;
    ecUserFirst + 2:
      begin
        FormMain.ActionEditorGotoInterface.Execute;
        AChar := #0;
      end;
    ecUserFirst + 3:
      begin
        FormMain.ActionEditorGotoImplementation.Execute;
        AChar := #0;
      end;
    ecUserFirst + 4:
      begin
        FormMain.ActionEditorMoveUp.Execute;
        AChar := #0;
      end;
    ecUserFirst + 5:
      begin
        FormMain.ActionEditorMoveDown.Execute;
        AChar := #0;
      end;
  end;
end;

procedure TFormEditor.EditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if [scCaretX, scCaretY] * Changes <> [] then
  begin
    StatusBar.Panels[1].Text := Format('%d : %d', [TSynEdit(Sender).CaretX,
      TSynEdit(Sender).CaretY]);
  end;
end;

procedure TFormEditor.FileNameChanged;
begin
  if FileExists(FileName) then
    Editor.Text := DataModuleCommon.GetText(FileName);

  FShortFileName := ExtractFileName(FileName);
  if StrEndsWith(LowerCase(FShortFileName), '.pas') then
  begin
    FExtension := '.pas';
    Delete(FShortFileName, Length(FShortFileName) - 3, 4);
    Editor.Highlighter := DataModuleCommon.SynObjectPascal;
  end
  else
  if StrEndsWith(LowerCase(FShortFileName), '.hpr') then
  begin
    FExtension := '.hpr';
    Delete(FShortFileName, Length(FShortFileName) - 3, 4);
    Editor.Highlighter := DataModuleCommon.SynObjectPascal;
  end;

  Caption := FShortFileName;
end;

procedure TFormEditor.FormatSource;
begin

end;

procedure TFormEditor.AddCustomEditorKeystrokes;

  procedure AddKeystroke(ACommand: TSynEditorCommand; AKey: Word; AShift: TShiftState);
  begin
    with Editor.Keystrokes.Add do
    begin
      Command := ACommand;
      Key := AKey;
      Shift := AShift;
    end;
  end;

begin
  AddKeystroke(ecUserFirst    , VK_SPACE, [ssCTRL]);
  AddKeystroke(ecUserFirst + 1, VK_SPACE, [ssCTRL, ssShift]);
  AddKeystroke(ecUserFirst + 2, VK_UP, [ssCTRL, ssShift]);
  AddKeystroke(ecUserFirst + 3, VK_DOWN, [ssCTRL, ssShift]);
  AddKeystroke(ecUserFirst + 4, VK_UP, [ssAlt, ssShift]);
  AddKeystroke(ecUserFirst + 5, VK_DOWN, [ssAlt, ssShift]);
end;

procedure TFormEditor.Assign(Source: TPersistent);
var
  Bookmark: THopeBookmark;
  Index: Integer;
begin
  if Source is THopeOpenedFile then
  begin
    FileName := THopeOpenedFile(Source).FileName;
    Editor.TopLine := THopeOpenedFile(Source).TopLine;
    Editor.CaretXY := BufferCoord(
      THopeOpenedFile(Source).Character,
      THopeOpenedFile(Source).Line);
    for Index := 0 to THopeOpenedFile(Source).BookmarkCount - 1 do
    begin
      Bookmark := THopeOpenedFile(Source).Bookmark[Index];
      Editor.SetBookMark(Bookmark.ID, Bookmark.Character, Bookmark.Line);
    end;
  end
  else
    inherited;
end;

procedure TFormEditor.AssignTo(Dest: TPersistent);
var
  Index, X, Y: Integer;
begin
  if Dest is THopeOpenedFile then
  begin
    THopeOpenedFile(Dest).FileName := FileName;
    THopeOpenedFile(Dest).TopLine := Editor.TopLine;
    THopeOpenedFile(Dest).Line := Editor.CaretXY.Line;
    THopeOpenedFile(Dest).Character := Editor.CaretXY.Char;
    for Index := 0 to 9 do
      if Editor.GetBookMark(Index, X, Y) then
        THopeOpenedFile(Dest).Bookmarks.Add(THopeBookmark.Create(Index, Y, X));
  end
  else
    inherited;
end;

procedure TFormEditor.BufferToEditor(Text: string);
begin
  Editor.Text := Text;
  FNeedsSync := False;
end;

procedure TFormEditor.CompleteClassAtCursor;
begin

end;

procedure TFormEditor.BufferToEditor;
begin
  Editor.Text := DataModuleCommon.MonitoredBuffer[FileName];
  FNeedsSync := False;
end;

procedure TFormEditor.EditorToBuffer;
begin
  if FNeedsSync then
  begin
    FNeedsSync := False;
    DataModuleCommon.MonitoredBuffer[FileName] := Editor.Text;
  end;
end;

procedure TFormEditor.GotoImplementation;
var
  CurrentProgram: IdwsProgram;
  Symbol: TSymbol;
  SymbolPosition: TSymbolPosition;
begin
  // get the current program
  CurrentProgram := DataModuleCommon.BackgroundCompiler.GetCompiledProgram;
  if not Assigned(CurrentProgram) then
    Exit;

  // find current symbol
  Symbol := CurrentProgram.SymbolDictionary.FindSymbolAtPosition(Editor.CaretX, Editor.CaretY,
    ExtractUnitName(FileName));

  // find according implementation symbol
  SymbolPosition := CurrentProgram.SymbolDictionary.FindSymbolUsage(Symbol, suImplementation);
  if Assigned(SymbolPosition) then
  begin
    Editor.CaretXY := BufferCoord(
      SymbolPosition.ScriptPos.Col,
      SymbolPosition.ScriptPos.Line);
  end;
end;

procedure TFormEditor.GotoInterface;
var
  CurrentProgram: IdwsProgram;
  Symbol: TSymbol;
  SymbolPosition: TSymbolPosition;
  Index: Integer;
const
  CUsages: array [0..1] of TSymbolUsage = (suForward, suDeclaration);
begin
  // get the current program
  CurrentProgram := DataModuleCommon.BackgroundCompiler.GetCompiledProgram;
  if not Assigned(CurrentProgram) then
    Exit;

  // find current symbol
  Symbol := CurrentProgram.SymbolDictionary.FindSymbolAtPosition(Editor.CaretX, Editor.CaretY,
    ExtractUnitName(FileName));

  // find according implementation symbol
  for Index := Low(CUsages) to High(CUsages) do
  begin
    SymbolPosition := CurrentProgram.SymbolDictionary.FindSymbolUsage(Symbol, CUsages[Index]);
    if Assigned(SymbolPosition) then
    begin
      Editor.CaretXY := BufferCoord(
        SymbolPosition.ScriptPos.Col,
        SymbolPosition.ScriptPos.Line);
      Exit;
    end;
  end
end;

procedure TFormEditor.InvokeCodeSuggestions;
begin
  DataModuleCommon.SynCodeSuggestions.Editor := Editor;
  DataModuleCommon.SynCodeSuggestions.ActivateCompletion;
end;

procedure TFormEditor.InvokeParameterInformation;
begin
  DataModuleCommon.SynParameters.Editor := Editor;
  DataModuleCommon.SynParameters.ActivateCompletion;
end;

procedure TFormEditor.MenuItemClearBookmarksClick(Sender: TObject);
var
  Bookmark: Integer;
begin
  for Bookmark := 0 to 9 do
    Editor.ClearBookMark(Bookmark);
end;

procedure TFormEditor.MenuItemGotoBookmarkClick(Sender: TObject);
begin
  Editor.GotoBookMark(TComponent(Sender).Tag);
end;

procedure TFormEditor.MenuItemToggleBookmarkClick(Sender: TObject);
var
  X, Y: Integer;
begin
  if Editor.GetBookMark(TComponent(Sender).Tag, X, Y) then
    Editor.ClearBookMark(TComponent(Sender).Tag)
  else
    Editor.SetBookMark(TComponent(Sender).Tag, Editor.CaretX, Editor.CaretY);
end;

procedure TFormEditor.MiniMapVisibleChanged;
begin
  SplitterMiniMap.Visible := True;
  EditorMiniMap.Visible := True;
end;

procedure TFormEditor.MoveLines(MoveUp: Boolean);
var
  LineStr: string;
begin
  Editor.BeginUpdate;
  try
    if MoveUp then
    begin
      // get line before/after block
      LineStr := Editor.Lines[Editor.BlockBegin.Line - 2];

      Editor.Lines.Delete(Editor.BlockBegin.Line - 2);
      Editor.Lines.Insert(Editor.BlockEnd.Line - 1, LineStr);
    end
    else
    begin
      // get line before/after block
      LineStr := Editor.Lines[Editor.BlockEnd.Line];

      Editor.Lines.Delete(Editor.BlockEnd.Line);
      Editor.Lines.Insert(Editor.BlockBegin.Line - 1, LineStr);
    end;
  finally
    Editor.EndUpdate;
  end;
end;

function TFormEditor.GetDottedWordAtCursor: string;

  function CharIsDottedWord(AChar: WideChar): Boolean;
  begin
    Result := Editor.IsIdentChar(AChar) or (AChar = '.');
  end;

var
  Line: UnicodeString;
  Start, Stop: Integer;
begin
// the code below is based on the function TCustomSynEdit.GetWordAtRowCol(...)
  Result := '';
  if (Editor.CaretY >= 1) and (Editor.CaretY <= Editor.Lines.Count) then
  begin
    Line := Editor.Lines[Editor.CaretY - 1];
    if (Length(Line) > 0) and
       ((Editor.CaretX >= 1) and (Editor.CaretX <= High(Line))) and
       Editor.IsIdentChar(Line[Editor.CaretX]) then
    begin
       Start := Editor.CaretX;
       while (Start > 1) and CharIsDottedWord(Line[Start - 1]) do
          Dec(Start);

       Stop := Editor.CaretX + 1;
       while (Stop <= Length(Line)) and CharIsDottedWord(Line[Stop]) do
          Inc(Stop);

       Result := Copy(Line, Start, Stop - Start);
    end;
  end;
end;

procedure TFormEditor.OpenFileAtCursor;
var
  DottedWordAtCursor: UnicodeString;
  FileName: TFileName;
begin
  DottedWordAtCursor := GetDottedWordAtCursor;

  if Length(DottedWordAtCursor) = 0 then
    Exit;

  FileName := DataModuleCommon.MonitoredBuffer.GetFileName(DottedWordAtCursor);
  if Length(FileName) > 0 then
    FormMain.FocusEditor(FileName);
end;

procedure TFormEditor.SetupEditorFromPreferences;
var
  Options: TSynEditorOptions;

  procedure SwitchSet(Value: Boolean; Option: TSynEditorOption);
  begin
    if Value then
      Include(Options, Option)
    else
      Exclude(Options, Option);
  end;

var
  EditorPreferences: THopePreferencesEditor;
begin
  EditorPreferences := DataModuleCommon.Preferences.Editor;

  Options := Editor.Options;

  SwitchSet(EditorPreferences.AltSetsColumnMode, eoAltSetsColumnMode);
  SwitchSet(EditorPreferences.AutoIndent, eoAutoIndent);
  SwitchSet(EditorPreferences.AutoSizeMaxScrollWidth, eoAutoSizeMaxScrollWidth);
  SwitchSet(EditorPreferences.DisableScrollArrows, eoDisableScrollArrows);
  SwitchSet(EditorPreferences.DragDropEditing, eoDragDropEditing);
  SwitchSet(EditorPreferences.DropFiles, eoDropFiles);
  SwitchSet(EditorPreferences.EnhanceHomeKey, eoEnhanceHomeKey);
  SwitchSet(EditorPreferences.EnhanceHomeKey, eoEnhanceEndKey);
  SwitchSet(EditorPreferences.GroupUndo, eoGroupUndo);
  SwitchSet(EditorPreferences.HalfPageScroll, eoHalfPageScroll);
  SwitchSet(EditorPreferences.HideShowScrollbars, eoHideShowScrollbars);
  SwitchSet(EditorPreferences.KeepCaretX, eoKeepCaretX);
  SwitchSet(EditorPreferences.NoCaret, eoNoCaret);
  SwitchSet(EditorPreferences.NoSelection, eoNoSelection);
  SwitchSet(EditorPreferences.RightMouseMovesCursor, eoRightMouseMovesCursor);
  SwitchSet(EditorPreferences.ScrollByOneLess, eoScrollByOneLess);
  SwitchSet(EditorPreferences.ScrollHintFollows, eoScrollHintFollows);
  SwitchSet(EditorPreferences.ScrollPastEof, eoScrollPastEof);
  SwitchSet(EditorPreferences.ScrollPastEol, eoScrollPastEol);
  SwitchSet(EditorPreferences.ShowScrollHint, eoShowScrollHint);
  SwitchSet(EditorPreferences.ShowSpecialChars, eoShowSpecialChars);
  SwitchSet(EditorPreferences.SmartTabDelete, eoSmartTabDelete);
  SwitchSet(EditorPreferences.SmartTabs, eoSmartTabs);
  SwitchSet(EditorPreferences.SpecialLineDefaultFg, eoSpecialLineDefaultFg);
  SwitchSet(EditorPreferences.TabIndent, eoTabIndent);
  SwitchSet(EditorPreferences.TabsToSpaces, eoTabsToSpaces);
  SwitchSet(EditorPreferences.TrimTrailingSpace, eoTrimTrailingSpaces);

  Editor.Options := Options;
end;

procedure TFormEditor.ToggleComment;

  function IsCommented(Line: string; out Pos: Integer): Boolean;
  begin
    Pos := 0;
    while Pos < Length(Line) do
      if Editor.IsWhiteChar(Line[Pos + 1]) then
        Inc(Pos)
      else
        Break;
    Result := (Pos < Length(Line) - 1) and
      (Line[Pos + 1] = '/') and (Line[Pos + 2] = '/');
  end;

  function NeedsCommenting: Boolean;
  var
    Index: Integer;
    Line: string;
    Start: Integer;
    CommentedLines: Integer;
  begin
    CommentedLines := 0;
    for Index := Editor.BlockBegin.Line to Editor.BlockEnd.Line do
    begin
      Line := Editor.Lines[Index - 1];
      if IsCommented(Line, Start) then
        Inc(CommentedLines);
    end;
    Result := Max(1, Editor.BlockEnd.Line - Editor.BlockBegin.Line) <> CommentedLines;
  end;

var
  Index: Integer;
  Line: string;
  Start: Integer;
  CommentLines: Boolean;
begin
  CommentLines := NeedsCommenting;

  Editor.BeginUpdate;
  try
    if CommentLines then
      for Index := Editor.BlockBegin.Line to Editor.BlockEnd.Line do
        Editor.Lines[Index - 1] := '//' + Editor.Lines[Index - 1]
    else
      for Index := Editor.BlockBegin.Line to Editor.BlockEnd.Line do
      begin
        Line := Editor.Lines[Index - 1];
        IsCommented(Line, Start);
        Delete(Line, Start + 1, 2);
        Editor.Lines[Index - 1] := Line;
      end;

    Editor.CaretY := Editor.CaretY + 1;
  finally
    Editor.EndUpdate;
  end;

  EditorChange(Self);
end;

procedure TFormEditor.SetFileName(const Value: TFileName);
begin
  if FFileName <> Value then
  begin
    FFileName := Value;
    FileNameChanged;
  end;
end;

procedure TFormEditor.SetMiniMapVisible(const Value: Boolean);
begin
  if FMiniMapVisible <> Value then
  begin
    FMiniMapVisible := Value;
    MiniMapVisibleChanged;
  end;
end;

end.
