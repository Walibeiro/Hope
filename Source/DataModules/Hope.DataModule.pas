unit Hope.DataModule;

{$I Hope.inc}

interface

uses
  System.SysUtils, System.Classes, Vcl.ImgList, Vcl.Controls,

  SynEdit, SynEditPlugins, SynMacroRecorder, SynCompletionProposal,
  SynEditRegexSearch, SynEditHighlighter, SynHighlighterMulti,
  SynEditMiscClasses, SynEditSearch, SynHighlighterCSS, SynHighlighterHtml,
  SynHighlighterJSON, SynHighlighterJScript, SynHighlighterDWS,

  Hope.Common.History, Hope.Common.Paths, Hope.Common.MonitoredBuffer,
  Hope.Common.Preferences, Hope.Compiler.Internal, Hope.Compiler.Background,
  Hope.Common.IDE;

type
  TMacroAction = (maRecord, maStop, maPlay);

  TDataModuleCommon = class(TDataModule)
    ImageList12: TImageList;
    ImageList16: TImageList;
    SynCodeSuggestions: TSynCompletionProposal;
    SynCssSyn: TSynCssSyn;
    SynDWSSyn: TSynDWSSyn;
    SynEditRegexSearch: TSynEditRegexSearch;
    SynEditSearch: TSynEditSearch;
    SynHTMLSyn: TSynHTMLSyn;
    SynJScriptSyn: TSynJScriptSyn;
    SynJSONSyn: TSynJSONSyn;
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
  private
    FHistory: THopeHistory;
    FPositions: THopePositions;
    FPaths: THopePaths;
    FPreferences: THopePreferences;
    FMonitoredBuffer: TMonitoredBuffer;
    FInternalCompiler: THopeInternalCompiler;
    FBackgroundCompiler: THopeBackgroundCompilerThread;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    function GetText(FileName: TFileName): string; inline;
    function GetUnit(UnitName: string): string; inline;

    procedure AddProjectToHistory(FileName: string);
    procedure AddUnitToHistory(FileName: string);

    procedure PerformMacro(Editor: TSynEdit; Action: TMacroAction);

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
  ceflib, dwsUtils, dwsExprs, dwsUnitSymbols, dwsSymbols, dwsErrors,
  dwsCompiler, Hope.Common.DWS, Hope.Common.FileUtilities,
  Hope.Main, Hope.Editor;

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

  inherited;
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
      for ItemIndex := 0 to SymbolDictionary.Count - 1 do
      begin
        TestSymbol := SymbolDictionary.Items[ItemIndex].Symbol;
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
