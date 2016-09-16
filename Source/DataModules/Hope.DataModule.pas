unit Hope.DataModule;

{$I Hope.inc}

interface

uses
  System.SysUtils, System.Classes, Vcl.ImgList, Vcl.Controls,

  SynEditPlugins, SynMacroRecorder, SynCompletionProposal,
  SynEditRegexSearch, SynEditHighlighter, SynHighlighterMulti,
  SynEditMiscClasses, SynEditSearch, SynHighlighterCSS, SynHighlighterHtml,
  SynHighlighterJSON, SynHighlighterJScript, SynHighlighterDWS,

  Hope.History, Hope.Paths, Hope.Common.MonitoredBuffer,
  Hope.Common.Preferences;

type
  TDataModuleCommon = class(TDataModule)
    SynEditSearch: TSynEditSearch;
    SynObjectPascal: TSynMultiSyn;
    SynEditRegexSearch: TSynEditRegexSearch;
    SynMacroRecorder: TSynMacroRecorder;
    SynDWSSyn: TSynDWSSyn;
    SynJScriptSyn: TSynJScriptSyn;
    SynJSONSyn: TSynJSONSyn;
    SynHTMLSyn: TSynHTMLSyn;
    SynCssSyn: TSynCssSyn;
    ImageList16: TImageList;
    ImageList12: TImageList;
    SynCodeSuggestions: TSynCompletionProposal;
    SynParameters: TSynCompletionProposal;
    SynMultiCSS: TSynMultiSyn;
    SynMultiHTML: TSynMultiSyn;
    procedure SynMacroRecorderStateChange(Sender: TObject);
  private
    FHistory: THopeHistory;
    FPaths: THopePaths;
    FPreferences: THopePreferences;
    FMonitoredBuffer: TMonitoredBuffer;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    function GetText(FileName: TFileName): string;

    property History: THopeHistory read FHistory;
    property Paths: THopePaths read FPaths;
    property MonitoredBuffer: TMonitoredBuffer read FMonitoredBuffer;
  end;

var
  DataModuleCommon: TDataModuleCommon;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  ceflib, Hope.Main;

{ TDataModuleCommon }

procedure TDataModuleCommon.AfterConstruction;
begin
  inherited;

  FPaths := THopePaths.Create;

  FHistory := THopeHistory.Create;
  FHistory.Load;

  FMonitoredBuffer := TMonitoredBuffer.Create;
  FMonitoredBuffer.AddPath(ExpandFileName(Paths.Root + '..\Common\APIs\'));
end;

procedure TDataModuleCommon.BeforeDestruction;
begin
  FHistory.Save;

  FMonitoredBuffer.Free;
  FHistory.Free;

  inherited;
end;

function TDataModuleCommon.GetText(FileName: TFileName): string;
begin
  Result := FMonitoredBuffer.GetText(FileName);
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
