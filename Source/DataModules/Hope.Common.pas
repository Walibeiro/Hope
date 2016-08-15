unit Hope.Common;

{$I Hope.inc}

interface

uses
  System.SysUtils, System.Classes,
  JvComponentBase, JvDockTree, JvDockControlForm, JvDockDelphiStyle,

  SynEditPlugins, SynMacroRecorder,
  SynEditRegexSearch, SynEditHighlighter, SynHighlighterMulti,
  SynEditMiscClasses, SynEditSearch, SynHighlighterCSS, SynHighlighterHtml,
  SynHighlighterJSON, SynHighlighterJScript, SynHighlighterDWS,

  Hope.History, Hope.Paths, Vcl.ImgList, Vcl.Controls;

type
  TDataModuleCommon = class(TDataModule)
    DockDelphiStyle: TJvDockDelphiStyle;
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
    ImageList1: TImageList;
  private
    FHistory: THopeHistory;
    FPaths: THopePaths;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property History: THopeHistory read FHistory;
    property Paths: THopePaths read FPaths;
  end;

var
  DataModuleCommon: TDataModuleCommon;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  ceflib;

{ TDataModuleCommon }

procedure TDataModuleCommon.AfterConstruction;
begin
  inherited;

  FPaths := THopePaths.Create;

  FHistory := THopeHistory.Create;
  FHistory.Load;
end;

procedure TDataModuleCommon.BeforeDestruction;
begin
  FHistory.Save;

  inherited;
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
