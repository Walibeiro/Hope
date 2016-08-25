unit Hope.Compiler;

{$I Hope.inc}

interface

uses
  dwsUtils, dwsComp, dwsCompiler, dwsExprs, dwsJSCodeGen, dwsJSLibModule,
  dwsCodeGen, Hope.Project;

type
  THopeCompiler = class
  private
    FDelphiWebScript: TDelphiWebScript;
    FCodeGen: TdwsJSCodeGen;
    FJSLib: TdwsJSLibModule;
  public
    constructor Create;
    destructor Destroy; override;

    function CompileScript(Script: string): IdwsProgram;
  end;

implementation

uses
  dwsXPlatform, dwsErrors, dwsExprList;

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

function THopeCompiler.CompileScript(Script: string): IdwsProgram;
var
  Prog: IdwsProgram;
  CodePas, CodeJS: string;
begin
  Prog := FDelphiWebScript.Compile(CodePas);

  if Prog.Msgs.HasErrors then
  begin
    Writeln(Prog.Msgs.AsInfo);
    Exit;
  end;

  FCodeGen.Clear;
  FCodeGen.CompileProgram(Prog);
  CodeJS := FCodeGen.CompiledOutput(Prog);
end;

end.

