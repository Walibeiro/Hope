unit Hope.DataModule.Common;

{$I Hope.inc}

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls,

  SynEdit, SynEditTypes,SynEditPlugins, SynMacroRecorder, SynCompletionProposal,
  SynEditRegexSearch, SynEditHighlighter, SynHighlighterMulti,
  SynEditMiscClasses, SynEditSearch, SynHighlighterCSS, SynHighlighterHtml,
  SynHighlighterJSON, SynHighlighterJScript, SynHighlighterDWS,

  Hope.Common.History, Hope.Common.Paths, Hope.Common.MonitoredBuffer,
  Hope.Common.Preferences, Hope.Compiler.Internal, Hope.Compiler.Background,
  Hope.Common.IDE;

type
  TMacroAction = (maRecord, maStop, maPlay);

  TDataModuleCommon = class(TDataModule)
    SynCodeSuggestions: TSynCompletionProposal;
    SynCSS: TSynCssSyn;
    SynDWS: TSynDWSSyn;
    SynEditRegexSearch: TSynEditRegexSearch;
    SynEditSearch: TSynEditSearch;
    SynHTML: TSynHTMLSyn;
    SynJS: TSynJScriptSyn;
    SynJSON: TSynJSONSyn;
    SynMacroRecorder: TSynMacroRecorder;
    SynMultiCSS: TSynMultiSyn;
    SynMultiHTML: TSynMultiSyn;
    SynObjectPascal: TSynMultiSyn;
    SynParameters: TSynCompletionProposal;
    procedure SynMacroRecorderStateChange(Sender: TObject);
    procedure SynParametersClose(Sender: TObject);
    procedure SynParametersShow(Sender: TObject);
    procedure SynParametersExecute(Kind: SynCompletionType; Sender: TObject;
      var CurrentInput: string; var x, y: Integer; var CanExecute: Boolean);
    procedure SynCodeSuggestionsExecute(Kind: SynCompletionType;
      Sender: TObject; var CurrentInput: string; var x, y: Integer;
      var CanExecute: Boolean);
    procedure SynCodeSuggestionsShow(Sender: TObject);
  private
    FHistory: THopeHistory;
    FPositions: THopePositions;
    FPaths: THopePaths;
    FPreferences: THopePreferences;
    FMonitoredBuffer: TMonitoredBuffer;
    FInternalCompiler: THopeInternalCompiler;
    FBackgroundCompiler: THopeBackgroundCompilerThread;
    procedure FileModifiedHandler(Sender: TObject; const FileName: TFileName);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    function GetText(FileName: TFileName): string; inline;
    function GetUnit(UnitName: string): string; inline;

    procedure AddProjectToHistory(FileName: string);
    procedure AddUnitToHistory(FileName: string);
    procedure RemoveProjectFromHistory(FileName: string);
    procedure RemoveUnitFromHistory(FileName: string);

    procedure PerformMacro(Editor: TSynEdit; Action: TMacroAction);

    procedure SetupFromPreferences;

    property InternalCompiler: THopeInternalCompiler read FInternalCompiler;
    property BackgroundCompiler: THopeBackgroundCompilerThread read FBackgroundCompiler;
    property History: THopeHistory read FHistory;
    property Positions: THopePositions read FPositions;
    property Paths: THopePaths read FPaths;
    property Preferences: THopePreferences read FPreferences;
    property MonitoredBuffer: TMonitoredBuffer read FMonitoredBuffer;
  end;

var
  DataModuleCommon: TDataModuleCommon;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  Vcl.Forms, Vcl.Graphics, ceflib, dwsUtils, dwsExprs, dwsUnitSymbols,
  dwsSymbols, dwsErrors, dwsCompiler, dwsSuggestions, dwsScriptSource,
  dwsSymbolDictionary,
  Hope.Common.DWS, Hope.Common.FileUtilities, Hope.Main, Hope.Editor,
  Hope.Dialog.ReloadChangedFiles;

{ TDataModuleCommon }

procedure TDataModuleCommon.AfterConstruction;
begin
  inherited;

  FPaths := THopePaths.Create;

  FPreferences := THopePreferences.Create;
  if FileExists(FPaths.PreferenceFileName) then
    FPreferences.LoadFromFile(FPaths.PreferenceFileName);

  FHistory := THopeHistory.Create;
  if FileExists(FPaths.HistoryFileName) then
    FHistory.LoadFromFile(FPaths.HistoryFileName);

  FPositions := THopePositions.Create;
  if FileExists(FPaths.PositionsFileName) then
    FPositions.LoadFromFile(FPaths.PositionsFileName);

  FMonitoredBuffer := TMonitoredBuffer.Create;
  FMonitoredBuffer.AddPath(ExpandFileName(Paths.Root + '..\Common\APIs\'));
  FMonitoredBuffer.AddPath(ExpandFileName(Paths.Root + '..\Common\Frameworks\'));
  FMonitoredBuffer.OnModified := FileModifiedHandler;

  FInternalCompiler := THopeInternalCompiler.Create;
  FBackgroundCompiler := THopeBackgroundCompilerThread.Create;
end;

procedure TDataModuleCommon.BeforeDestruction;
begin
  // save history and preferences
  FHistory.SaveToFile(FPaths.HistoryFileName);
  FPositions.SaveToFile(FPaths.PositionsFileName);
  FPreferences.SaveToFile(FPaths.PreferenceFileName);

  FBackgroundCompiler.Free;
  FInternalCompiler.Free;
  FMonitoredBuffer.Free;
  FHistory.Free;
  FPositions.Free;
  FPreferences.Free;
  FPaths.Free;

  inherited;
end;

procedure TDataModuleCommon.FileModifiedHandler(Sender: TObject;
  const FileName: TFileName);
begin
  with TFormReloadChangedFiles.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

function TDataModuleCommon.GetText(FileName: TFileName): string;
begin
  Result := FMonitoredBuffer.Text[FileName];
end;

function TDataModuleCommon.GetUnit(UnitName: string): string;
begin
  Result := FMonitoredBuffer.GetSourceCode(UnitName);
end;

procedure TDataModuleCommon.AddProjectToHistory(FileName: string);
begin
  // add project to history and save history
  FHistory.AddProject(FileName);
  FHistory.SaveToFile(FPaths.HistoryFileName);
end;

procedure TDataModuleCommon.AddUnitToHistory(FileName: string);
begin
  // add unit to history and save history
  FHistory.AddUnit(FileName);
  FHistory.SaveToFile(FPaths.HistoryFileName);
end;

procedure TDataModuleCommon.RemoveProjectFromHistory(FileName: string);
begin
  // remove project from history and save history
  FHistory.RemoveProject(FileName);
  FHistory.SaveToFile(FPaths.HistoryFileName);
end;

procedure TDataModuleCommon.RemoveUnitFromHistory(FileName: string);
begin
  // remove unit from history and save history
  FHistory.RemoveUnit(FileName);
  FHistory.SaveToFile(FPaths.HistoryFileName);
end;

procedure TDataModuleCommon.PerformMacro(Editor: TSynEdit;
  Action: TMacroAction);
begin
  SynMacroRecorder.Editor := Editor;
  case Action of
    maRecord:
      SynMacroRecorder.RecordMacro(Editor);
    maStop:
      SynMacroRecorder.Stop;
    maPlay:
      SynMacroRecorder.PlaybackMacro(Editor);
  end;
end;

procedure TDataModuleCommon.SetupFromPreferences;
var
  Delay: Integer;
  Options: TSynCompletionOptions;
begin
  // update code suggestions
  Delay := Preferences.CodeInsight.Delay;
  SynCodeSuggestions.TimerInterval := Delay;
  Options := SynCodeSuggestions.Options;
  if Delay < 5000 then
    Include(Options, scoUseBuiltInTimer)
  else
    Exclude(Options, scoUseBuiltInTimer);
  SynCodeSuggestions.Options := Options;

  // update parameter information
  SynParameters.TimerInterval := Delay;
  Options := SynParameters.Options;
  if Delay < 5000 then
    Include(Options, scoUseBuiltInTimer)
  else
    Exclude(Options, scoUseBuiltInTimer);
  SynParameters.Options := Options;
end;

procedure TDataModuleCommon.SynCodeSuggestionsShow(Sender: TObject);
begin
  Assert(Sender is TSynBaseCompletionProposalForm);
  with TSynBaseCompletionProposalForm(Sender) do
  begin
    DoubleBuffered := True;

    if Height > 256 then
      Height := 256
  end;
end;

procedure TDataModuleCommon.SynCodeSuggestionsExecute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: string; var x, y: Integer;
  var CanExecute: Boolean);
var
  SuggestionIndex: Integer;
  Proposal: TSynCompletionProposal;
  SourceFile: TSourceFile;
  ScriptPos: TScriptPos;
  ScriptProgram: IdwsProgram;
  Suggestions: IdwsSuggestions;
  Item, AddOn: string;
  CurrentEditor: TCustomSynEdit;
  SuggestionOptions: TdwsSuggestionsOptions;
begin
  CanExecute := False;

  CurrentEditor := TSynCompletionProposal(Sender).Editor;

  // check the proposal type
  Proposal := TSynCompletionProposal(Sender);
  Proposal.InsertList.Clear;
  Proposal.ItemList.Clear;

  if Assigned(Proposal.Form) then
  begin
    Proposal.Form.DoubleBuffered := True;
    Proposal.Resizeable := True;
    Proposal.Form.Resizeable := True;
    Proposal.Form.BorderStyle := bsSizeToolWin;
  end;

  // get script program
  ScriptProgram := BackgroundCompiler.GetCompiledProgram;
  if ScriptProgram = nil then
    Exit;

  // get the compiled "program" from DWS
  SourceFile := ScriptProgram.SourceList.MainScript.SourceFile;
  ScriptPos := TScriptPos.Create(SourceFile, CurrentEditor.CaretY,
    CurrentEditor.CaretX);

  if Preferences.CodeInsight.CodeSuggestions.ShowReservedWords then
    SuggestionOptions := []
  else
    SuggestionOptions := [soNoReservedWords];

  Suggestions := TDWSSuggestions.Create(ScriptProgram, ScriptPos,
    SuggestionOptions);

  // now populate the suggestion box
  for SuggestionIndex := 0 to Suggestions.Count - 1 do
  begin
    // discard empty suggestions
    if Suggestions.Caption[SuggestionIndex] = '' then
      Continue;

    with CurrentEditor.Highlighter.KeywordAttribute do
      Item := '\color{' + ColorToString(Foreground) + '}';

    case Suggestions.Category[SuggestionIndex] of
      scUnit:
        Item := Item + 'unit';
      scType:
        Item := Item + 'type';
      scClass:
        Item := Item + 'class';
      scRecord:
        Item := Item + 'record';
      scInterface:
        Item := Item + 'interface';
      scFunction:
        Item := Item + 'function';
      scProcedure:
        Item := Item + 'procedure';
      scMethod:
        Item := Item + 'method';
      scConstructor:
        Item := Item + 'constructor';
      scDestructor:
        Item := Item + 'destructor';
      scProperty:
        Item := Item + 'property';
      scEnum:
        Item := Item + 'enum';
      scElement:
        Item := Item + 'element';
      scParameter:
        Item := Item + 'param';
      scVariable:
        Item := Item + 'var';
      scConst:
        Item := Item + 'const';
      scReservedWord:
        Item := Item + 'reserved';
    end;

    Item := Item + ' \column{}';
    with CurrentEditor.Highlighter.IdentifierAttribute do
      Item := Item + '\color{' + ColorToString(Foreground) + '}';
    Item := Item + Suggestions.Code[SuggestionIndex];
    AddOn := Suggestions.Caption[SuggestionIndex];
    Delete(AddOn, 1, Length(Suggestions.Code[SuggestionIndex]));
    Item := Item + '\style{-B}' + AddOn;
    Proposal.ItemList.Add(Item);
    Proposal.InsertList.Add(Suggestions.Code[SuggestionIndex]);
  end;

  CanExecute := True;
end;

procedure TDataModuleCommon.SynMacroRecorderStateChange(Sender: TObject);
begin
  with FormMain do
  begin
    ActionMacroStop.Enabled := SynMacroRecorder.State in [msRecording, msPlaying];
    ActionMacroPlay.Enabled := (SynMacroRecorder.State = msStopped) and not SynMacroRecorder.IsEmpty;
    ActionMacroRecord.Enabled := (SynMacroRecorder.State = msStopped);
  end;
end;

procedure TDataModuleCommon.SynParametersClose(Sender: TObject);
begin
  // info is not visible
  SynParameters.Tag := 0;
end;

procedure TDataModuleCommon.SynParametersShow(Sender: TObject);
begin
  // info is visible
  SynParameters.Tag := 1;
end;

procedure GetParametersForCursor(const AProgram: IdwsProgram; AUnitName: string;
  Pos: TBufferCoord; var ParameterInfos: TStrings; InfoPosition: Integer = 0);
var
  Overloads : TFuncSymbolList;
  ItemIndex: Integer;
  FuncSymbol: TFuncSymbol;
  SymbolDictionary: TdwsSymbolDictionary;
  Symbol, TestSymbol: TSymbol;
  SymbolPosition: TSymbolPositionList;
begin
  // make sure the string list is present
  Assert(Assigned(ParameterInfos));

  // ensure a compiled program is assigned
  if not Assigned(AProgram) then
    Exit;

  SymbolDictionary := AProgram.SymbolDictionary;
  Symbol := SymbolDictionary.FindSymbolAtPosition(Pos.Char, Pos.Line, AUnitName);

  if (Symbol is TSourceMethodSymbol) then
  begin
    // collect overloaded methods
    Overloads := CollectMethodOverloads(TSourceMethodSymbol(Symbol));
    try
      // add parameters for all overloads
      for ItemIndex := 0 to Overloads.Count - 1 do
      begin
        FuncSymbol := Overloads[ItemIndex];
        AddParametersToParameterInfo(FuncSymbol.Params, ParameterInfos, InfoPosition);
      end;
    finally
      Overloads.Free;
    end;
  end else
  if (Symbol is TFuncSymbol) then
  begin
    AddParametersToParameterInfo(TFuncSymbol(Symbol).Params, ParameterInfos, InfoPosition);

    if TFuncSymbol(Symbol).IsOverloaded then
    begin
      for SymbolPosition in SymbolDictionary do
      begin
        TestSymbol := SymbolPosition.Symbol;
        FuncSymbol := TFuncSymbol(TestSymbol);

        if (TestSymbol <> Symbol) and (TestSymbol.ClassType = Symbol.ClassType) and
          UnicodeSameText(TFuncSymbol(Symbol).Name, FuncSymbol.Name) then
          AddParametersToParameterInfo(FuncSymbol.Params, ParameterInfos, InfoPosition);
      end;
    end
  end;

  // check if no parameters at all is an option, if so: replace and move to top
  ItemIndex := ParameterInfos.IndexOf('');
  if ItemIndex >= 0 then
  begin
    ParameterInfos.Delete(ItemIndex);
    ParameterInfos.Insert(0, '"<no parameters required>"');
  end;
end;

procedure TDataModuleCommon.SynParametersExecute(Kind: SynCompletionType;
  Sender: TObject; var CurrentInput: string; var x, y: Integer;
  var CanExecute: Boolean);
var
  CompiledProject: IdwsProgram;
  CurrentLineText: string;
  Pos: TBufferCoord;
  ParameterInfo: TSynCompletionProposal;
  ParameterInfos: TStrings;
  TmpLocation, StartX, ParenCounter: Integer;
  EditorForm: TFormEditor;
begin
  CanExecute := False;

  // eventually exit if code suggestions is disabled
  if not Preferences.CodeInsight.CodeSuggestions.Enabled then
    Exit;

  ParameterInfo := TSynCompletionProposal(Sender);
  ParameterInfo.InsertList.Clear;
  ParameterInfo.ItemList.Clear;
  ParameterInfos := TStrings(ParameterInfo.ItemList);

  // get text @ current line
  with TSynCompletionProposal(Sender).Editor do
  begin
    EditorForm := FormMain.FocusedEditorForm;
    if not Assigned(EditorForm) then
      Exit;

    // get current compiled program
    CompiledProject := DataModuleCommon.BackgroundCompiler.GetCompiledProgram(SynParameters.Tag = 0);
    if not Assigned(CompiledProject) then
      Exit;

    CurrentLineText := LineText;

    //go back from the cursor and find the first open paren
    Pos := CaretXY;
    if Pos.Char > Length(CurrentLineText) then
      Pos.Char := Length(CurrentLineText)
    else
      Dec(Pos.Char);
    TmpLocation := 0;

    while (Pos.Char > 0) and not CanExecute do
    begin
      if CurrentLineText[Pos.Char] = ',' then
      begin
        Inc(TmpLocation);
        Dec(Pos.Char);
      end
      else if CurrentLineText[Pos.Char] = ')' then
      begin
        // we found a close, go till it's opening paren
        ParenCounter := 1;
        Dec(Pos.Char);
        while (Pos.Char > 0) and (ParenCounter > 0) do
        begin
          if CurrentLineText[Pos.Char] = ')' then
            Inc(ParenCounter)
          else if CurrentLineText[Pos.Char] = '(' then
            Dec(ParenCounter);
          Dec(Pos.Char);
        end;
        // eventually eat the open paren
        if Pos.Char > 0 then
          Dec(Pos.Char);
      end
      else if CurrentLineText[Pos.Char] = '(' then
      begin
        // we have a valid open paren, lets see what the word before it is
        StartX := Pos.Char;
        while (Pos.Char > 0) and not IsIdentChar(CurrentLineText[Pos.Char])do
          Dec(Pos.Char);
        if Pos.Char > 0 then
        begin
          while (Pos.Char > 0) and IsIdentChar(CurrentLineText[Pos.Char]) do
            Dec(Pos.Char);
          Inc(Pos.Char);

          GetParametersForCursor(CompiledProject,
            ExtractUnitName(EditorForm.FileName), Pos, ParameterInfos,
            TmpLocation);

          CanExecute := ParameterInfos.Count > 0;

          if not (CanExecute) then
          begin
            Pos.Char := StartX;
            Dec(Pos.Char);
          end
          else
            TSynCompletionProposal(Sender).Form.CurrentIndex := TmpLocation;
        end;
      end else Dec(Pos.Char)
    end;
  end;
end;

procedure BeforeCommandLineProcessing(const processType: ustring;
  const commandLine: ICefCommandLine);
begin
(*
  if not UseProxy then
    commandLine.AppendSwitch('--no-proxy-server');
*)
end;

procedure InitializeCEF;
begin
  CefSingleProcess := False;
  CefRemoteDebuggingPort := 9000;
  CefBrowserSubprocessPath := ExtractFilePath(ParamStr(0)) + 'DCEF3.exe';
  CefNoSandbox := True;
  CefCache := ExtractFilePath(ParamStr(0)) + 'Cache';
  {$IFDEF Debug}
  CefLogSeverity := LOGSEVERITY_ERROR;
  CefLogFile := ExtractFilePath(ParamStr(0)) + 'DCEF3.log';
  {$ENDIF}
  CefRenderProcessHandler := TCefRenderProcessHandlerOwn.Create;
  CefBrowserProcessHandler := TCefBrowserProcessHandlerOwn.Create;
  CefOnBeforeCommandLineProcessing := BeforeCommandLineProcessing;
end;

procedure FinalizeCEF;
begin
  CefRenderProcessHandler := nil;
  CefBrowserProcessHandler := nil;
  CefOnBeforeCommandLineProcessing := nil;
end;

initialization
  InitializeCEF;

finalization
  FinalizeCEF;

end.
