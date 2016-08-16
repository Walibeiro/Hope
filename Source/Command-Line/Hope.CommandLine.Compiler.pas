unit Hope.CommandLine.Compiler;

interface

uses
  dwsUtils, dwsComp, dwsCompiler, dwsExprs, dwsJSCodeGen, dwsJSLibModule,
  dwsCodeGen, Hope.CommandLine.Arguments;

type
  THopeCommandLineCompiler = class(TRefCountedObject)
  private
    FArguments: THopeCommandLineArguments;
    FDelphiWebScript: TDelphiWebScript;
    FCodeGen: TdwsJSCodeGen;
    FJSLib: TdwsJSLibModule;
  public
    constructor Create(Arguments: THopeCommandLineArguments);

    property Arguments: THopeCommandLineArguments read FArguments;
  end;

implementation

uses
  dwsXPlatform;

{ THopeCommandLineCompiler }

constructor THopeCommandLineCompiler.Create(Arguments: THopeCommandLineArguments);
var
  Prog: IdwsProgram;
  CodePas, CodeJS: string;
begin
  FArguments := Arguments;

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

  CodePas := LoadTextFromFile(Arguments.InputFilename);
  Prog := FDelphiWebScript.Compile(CodePas);

  if Prog.Msgs.HasErrors then
  begin
    Writeln(Prog.Msgs.AsInfo);
    Exit;
  end;

  FCodeGen.Clear;
  FCodeGen.CompileProgram(Prog);
  CodeJS := FCodeGen.CompiledOutput(Prog);

  SaveTextToUTF8File(Arguments.OutputFilename, CodeJS);
end;

end.
