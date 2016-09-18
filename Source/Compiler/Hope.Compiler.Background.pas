unit Hope.Compiler.Background;

{$I Hope.inc}

interface

uses
  System.Classes, System.SysUtils, System.SyncObjs, dwsUtils, dwsComp,
  dwsCompiler, dwsExprs, dwsErrors, dwsFunctions, Hope.Project,
  Hope.Compiler.Base;

type
  THopeCompilationEvent = procedure(Sender: TObject; Prog: IdwsProgram) of object;

  THopeBackgroundCompiler = class(THopeBaseCompiler)
  private
    FOnCompilation: THopeCompilationEvent;

    function GetMainScript(Project: THopeProject): string;
  protected
    procedure OnIncludeEventHandler(const ScriptName: string;
      var ScriptSource: string); override;
    function OnNeedUnitEventHandler(const UnitName: string;
      var UnitSource: string) : IdwsUnit; override;
  public
    function CompileProject(Project: THopeProject): IdwsProgram;

    property OnCompilation: THopeCompilationEvent read FOnCompilation write FOnCompilation;
  end;

  THopeBackgroundCompilerThread = class(TThread)
  strict private
    FCompiler: THopeBackgroundCompiler;
    FRecentProgram: IDWSProgram;
    FTimeOut: Integer;
    FNeedsCompilation: Boolean;

    FImmediateCompilation: TEvent;
    FValidCompilation: TLightweightEvent;

    {$IFDEF DEBUG}
    procedure Log(Text: string); inline;
    {$ENDIF}
  private
    FActive: Boolean;
    procedure CompilationDone;
    procedure PerformCompilation;
    function WaitUntilComplete(TimeOut: Integer = 5000): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Execute; override;

    procedure Invalidate;
    procedure Abort;

    function GetCompiledProgram(WaitForMostRecent: Boolean = True): IdwsProgram;

    property TimeOut: Integer read FTimeOut write FTimeOut;
    property Active: Boolean read FActive write FActive;
  end;


implementation

uses
  System.Math, dwsXPlatform, dwsExprList, Hope.Common.Constants, Hope.Main,
  Hope.DataModule, Hope.Common.MonitoredBuffer;

{ THopeBackgroundCompiler }

function THopeBackgroundCompiler.GetMainScript(Project: THopeProject): string;
begin
  Result := DataModuleCommon.GetText(Project.MainScript.FileName);
end;

procedure THopeBackgroundCompiler.OnIncludeEventHandler(const ScriptName: string;
  var ScriptSource: string);
begin
  ScriptSource := DataModuleCommon.GetText(ScriptName);
end;

function THopeBackgroundCompiler.OnNeedUnitEventHandler(const UnitName: string;
  var UnitSource: string): IdwsUnit;
begin
  UnitSource := DataModuleCommon.GetUnit(UnitName);
end;

function THopeBackgroundCompiler.CompileProject(Project: THopeProject): IdwsProgram;
var
  Prog: IdwsProgram;
begin
  Prog := DelphiWebScript.Compile(GetMainScript(Project));
end;


{ THopeBackgroundCompilerThread }

constructor THopeBackgroundCompilerThread.Create;
begin
  inherited Create(True);

  // setup compiler
  FCompiler := THopeBackgroundCompiler.Create;

  FImmediateCompilation := TEvent.Create;
  FValidCompilation := TLightweightEvent.Create;
end;

destructor THopeBackgroundCompilerThread.Destroy;
begin
  FValidCompilation.Free;
  FImmediateCompilation.Free;

  FCompiler.Free;

  inherited;
end;

procedure THopeBackgroundCompilerThread.Invalidate;
begin
  // abort pending compilations
  FCompiler.Abort;

  // invalidate compilation
  FValidCompilation.ResetEvent;

  // set FNeedsCompilation to True (except if thread is terminated)
  FNeedsCompilation := not Terminated;

  // resume thread
  if FActive then
    Suspended := False;

  {$IFDEF DEBUG}
  Log('Invalidate');
  {$ENDIF}
end;


{$IFDEF DEBUG}
procedure THopeBackgroundCompilerThread.Log(Text: string);
begin
  OutputDebugString('Background Compilation: ' + Text);
end;
{$ENDIF}

procedure THopeBackgroundCompilerThread.PerformCompilation;
var
  CompiledProgram: IdwsProgram;
begin
  CompiledProgram := FCompiler.CompileProject(FormMain.Projects.ActiveProject);

  {$IFDEF DEBUG}
  if Assigned(CompiledProgram) and CompiledProgram.Msgs.HasErrors then
    Log(CompiledProgram.Msgs.AsInfo);
  {$ENDIF}

  FRecentProgram := CompiledProgram;
end;

procedure THopeBackgroundCompilerThread.Execute;
var
  Tick: Cardinal;
  TimeOut: Integer;
const
  CPostCompilationDelay = 5;
begin
  NameThreadForDebugging('Hope Background Compiler');

  while not Terminated do
  begin
    TimeOut := FTimeOut;

    // check if compilation is needed at all
    if not FNeedsCompilation then
    begin
      Suspended := not (FNeedsCompilation or Terminated);
      Continue;
    end;

    FNeedsCompilation := False;

    {$IFDEF DEBUG}
    Log('Start');
    {$ENDIF}

    Tick := GetTickCount;
    try
      PerformCompilation;
    except
      {$IFDEF DEBUG} Log('Compilation failed!'); {$ENDIF}
    end;

    {$IFDEF DEBUG} Log('Complete'); {$ENDIF}

    // check if source code has changed meanwhile, if not set valid event
    if not FNeedsCompilation then
      FValidCompilation.SetEvent;

    // give the main thread a chance to proceed all immediate operations
    Sleep(CPostCompilationDelay);

    if not (FNeedsCompilation or Terminated) then
      Synchronize(CompilationDone);

    TimeOut := TimeOut - Integer(GetTickCount - Tick) - CPostCompilationDelay;

    // check if thread is terminated
    if Terminated then
      Exit;

    {$IFDEF DEBUG} Log('Wait for Interval'); {$ENDIF}

    if FActive then
    begin
      FImmediateCompilation.ResetEvent;
      FImmediateCompilation.WaitFor(TimeOut);
    end;

    Suspended := not (FNeedsCompilation or Terminated);
  end;
end;

function THopeBackgroundCompilerThread.WaitUntilComplete(TimeOut: Integer): Boolean;
begin
  {$IFDEF DEBUG} Log('Wait until...'); {$ENDIF}

  // check if thread is terminated
  if Terminated then
    Exit(False);

  // trigger immediate compilation (if imminent)
  if FNeedsCompilation then
  begin
    FImmediateCompilation.SetEvent;

    // ensure the thread is running to check whether a compilation is required
    Suspended := False;

    // now wait for a timeout or a signal, that the program is valid
    if FValidCompilation.WaitFor(TimeOut) <> wrSignaled then
    begin
      {$IFDEF DEBUG} Log('...TIMEOUT!'); {$ENDIF}
      Exit(False);
    end;
  end;

  {$IFDEF DEBUG}
  Log('.. complete');
  {$ENDIF}

  Result := True;
end;

function THopeBackgroundCompilerThread.GetCompiledProgram(
  WaitForMostRecent: Boolean = True): IdwsProgram;
begin
  if WaitForMostRecent then
    WaitUntilComplete;

  Result := FRecentProgram;
end;

procedure THopeBackgroundCompilerThread.Abort;
begin
  FCompiler.Abort;
end;

procedure THopeBackgroundCompilerThread.CompilationDone;
begin
  FormMain.UpdateUnitMap(FRecentProgram);
end;

end.
