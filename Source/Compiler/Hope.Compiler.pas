unit Hope.Compiler;

{$I Hope.inc}

interface

uses
  dwsUtils, dwsComp, dwsCompiler, dwsExprs, dwsJSCodeGen, dwsJSLibModule,
  dwsCodeGen, dwsErrors, Hope.Project;

type
  THopeCompileErrorEvent = procedure(Sender: TObject; Messages: TdwsMessageList) of object;
  THopeCompilationEvent = procedure(Sender: TObject; Prog: IdwsProgram) of object;
  THopeGetMainScriptEvent = procedure(Sender: TObject; out Script: string) of object;

  THopeCompiler = class
  private
    FDelphiWebScript: TDelphiWebScript;
    FCodeGen: TdwsJSCodeGen;
    FJSLib: TdwsJSLibModule;

    FOnError: THopeCompileErrorEvent;
    FOnCompilation: THopeCompilationEvent;
    FOnGetMainScript: THopeGetMainScriptEvent;

    function GetMainScript(Project: THopeProject): string;
  public
    constructor Create;
    destructor Destroy; override;

    function SyntaxCheck(Project: THopeProject): Boolean;
    function CompileProject(Project: THopeProject): IdwsProgram;
    procedure BuildProject(Project: THopeProject);

    property OnError: THopeCompileErrorEvent read FOnError write FOnError;
    property OnCompilation: THopeCompilationEvent read FOnCompilation write FOnCompilation;
    property OnGetMainScript: THopeGetMainScriptEvent read FOnGetMainScript write FOnGetMainScript;
  end;

implementation

uses
  dwsXPlatform, dwsExprList;

{ THopeCompiler }

constructor THopeCompiler.Create;
begin
  // create DWS compiler
  FDelphiWebScript := TDelphiWebScript.Create(nil);
  FDelphiWebScript.Config.CompilerOptions := [coAssertions, coAllowClosures];

  // create JS lib modume
  FJSLib := TdwsJSLibModule.Create(nil);
  FJSLib.Script := FDelphiWebScript;

  FCodeGen := TdwsJSCodeGen.Create;
  FCodeGen.Options := [cgoNoRangeChecks, cgoNoCheckInstantiated,
    cgoNoCheckLoopStep, cgoNoConditions, cgoNoInlineMagics, cgoDeVirtualize,
    cgoNoRTTI, cgoNoFinalizations, cgoIgnorePublishedInImplementation];
  FCodeGen.Verbosity := cgovNone;
  FCodeGen.MainBodyName := '';
end;

destructor THopeCompiler.Destroy;
begin
  FDelphiWebScript.Free;
  FJSLib.Free;
  FCodeGen.Free;

  inherited;
end;

function THopeCompiler.GetMainScript(Project: THopeProject): string;
begin
  // get main script
  if Assigned(FOnGetMainScript) then
    FOnGetMainScript(Self, Result)
  else
    Result := LoadTextFromFile(Project.MainScript.FileName);
end;

function THopeCompiler.SyntaxCheck(Project: THopeProject): Boolean;
var
  Prog: IdwsProgram;
begin
  Prog := FDelphiWebScript.Compile(GetMainScript(Project));

  if Prog.Msgs.HasErrors then
  begin
    if Assigned(FOnError) then
      FOnError(Self, Prog.Msgs);
    Exit;
  end;

  // fire compilation event
  if Assigned(FOnCompilation) then
    FOnCompilation(Self, Prog);
end;

function THopeCompiler.CompileProject(Project: THopeProject): IdwsProgram;
var
  Prog: IdwsProgram;
  CodeJS: string;
begin
  Prog := FDelphiWebScript.Compile(GetMainScript(Project));

  if Prog.Msgs.HasErrors then
  begin
    if Assigned(FOnError) then
      FOnError(Self, Prog.Msgs);
    Exit;
  end;

  // fire compilation event
  if Assigned(FOnCompilation) then
    FOnCompilation(Self, Prog);


(*
  FCodeGen.Clear;
  FCodeGen.CompileProgram(Prog);
  CodeJS := FCodeGen.CompiledOutput(Prog);
*)
end;

procedure THopeCompiler.BuildProject(Project: THopeProject);
var
  Prog: IdwsProgram;
begin
  Prog := FDelphiWebScript.Compile(GetMainScript(Project));

  if Prog.Msgs.HasErrors then
  begin
    if Assigned(FOnError) then
      FOnError(Self, Prog.Msgs);
    Exit;
  end;

  // fire compilation event
  if Assigned(FOnCompilation) then
    FOnCompilation(Self, Prog);
end;

end.
