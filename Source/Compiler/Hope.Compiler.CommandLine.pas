unit Hope.Compiler.CommandLine;

{$I Hope.inc}

interface

uses
  System.SysUtils, dwsExprs, dwsFunctions,
  Hope.Project, Hope.Project.Options, Hope.Compiler.Base,
  Hope.Common.MonitoredBuffer;

type
  THopeCompilationEvent = procedure(Sender: TObject; CompiledProgram: IdwsProgram) of object;

  THopeCommandLineCompiler = class(THopeBaseCompiler)
  private
    FOnCompilation: THopeCompilationEvent;
    FMonitoredBuffer: TMonitoredBuffer;

    function GetMainScript(Project: THopeProject): string;
  protected
    procedure InstanciateCodeGen; override;
    procedure OnIncludeEventHandler(const ScriptName: string;
      var ScriptSource: string); override;
    function OnNeedUnitEventHandler(const UnitName: string;
      var UnitSource: string) : IdwsUnit; override;

    procedure SetupCompiler(Project: THopeProject);
    procedure SetupCompilerOptions(Options: THopeProjectOptions);
  public
    procedure AfterConstruction; override;

    function SyntaxCheck(Project: THopeProject): Boolean;
    function CompileProject(Project: THopeProject): IdwsProgram;
    procedure BuildProject(Project: THopeProject);

    procedure AddLibraryPath(Path: TFileName);
    procedure ClearLibraryPaths;

    property DelphiWebScript;
    property CodeGen;
    property MonitoredBuffer: TMonitoredBuffer read FMonitoredBuffer;

    property OnCompilation: THopeCompilationEvent read FOnCompilation write FOnCompilation;
  end;

implementation

uses
  dwsXPlatform, dwsUtils, dwsCompiler, dwsCompilerContext, dwsErrors,
  dwsJSLibModule, dwsCodeGen, dwsJSCodeGen, Hope.Common.Constants;


{ THopeCommandLineCompiler }

procedure THopeCommandLineCompiler.AfterConstruction;
begin
  inherited;

  FMonitoredBuffer := TMonitoredBuffer.Create;
end;

function THopeCommandLineCompiler.GetMainScript(Project: THopeProject): string;
var
  MainSourceFile: TFileName;
begin
  // get main source file name
  MainSourceFile := Project.MainScript.FileName;

  // eventually resolve relative file
  if IsRelativePath(MainSourceFile) then
    MainSourceFile := ExpandFileName(Project.RootPath + MainSourceFile);

  // load text file
  if FileExists(MainSourceFile) then
    Result := LoadTextFromFile(MainSourceFile);
end;

procedure THopeCommandLineCompiler.OnIncludeEventHandler(const ScriptName: string;
  var ScriptSource: string);
begin
  ScriptSource := FMonitoredBuffer.GetSourceCode(ScriptName);
end;

function THopeCommandLineCompiler.OnNeedUnitEventHandler(const UnitName: string;
  var UnitSource: string): IdwsUnit;
begin
  UnitSource := FMonitoredBuffer.GetSourceCode(UnitName);
end;

procedure THopeCommandLineCompiler.InstanciateCodeGen;
begin
  // create JS lib module (needed for JS asm sections)
  FCodeGenLib := TdwsJSLibModule.Create(nil);
  FCodeGenLib.Script := DelphiWebScript;

  // create JS code gen
  FCodeGen := TdwsJSCodeGen.Create;
  FCodeGen.Options := [cgoNoRangeChecks, cgoNoCheckInstantiated,
    cgoNoCheckLoopStep, cgoNoConditions, cgoNoInlineMagics, cgoDeVirtualize,
    cgoNoRTTI, cgoNoFinalizations, cgoIgnorePublishedInImplementation];
  FCodeGen.Verbosity := cgovNone;
  TdwsJSCodeGen(FCodeGen).MainBodyName := '';
end;

procedure THopeCommandLineCompiler.AddLibraryPath(Path: TFileName);
begin
  if Path <> '' then
    FMonitoredBuffer.AddPath(Path);
end;

procedure THopeCommandLineCompiler.ClearLibraryPaths;
begin
  FMonitoredBuffer.Clear;
end;

procedure THopeCommandLineCompiler.SetupCompiler(Project: THopeProject);
begin
  FMonitoredBuffer.AddPath(Project.RootPath);

  SetupCompilerOptions(Project.Options);
end;

procedure THopeCommandLineCompiler.SetupCompilerOptions(Options: THopeProjectOptions);
var
  CompilerOptions: TCompilerOptions;
  CodeGenOptions: TdwsCodeGenOptions;
begin
  CompilerOptions := DelphiWebScript.Config.CompilerOptions;

  if Options.CompilerOptions.Assertions then
    Include(CompilerOptions, coAssertions)
  else
    Exclude(CompilerOptions, coAssertions);

  if Options.CompilerOptions.Optimizations then
    Include(CompilerOptions, coOptimize)
  else
    Exclude(CompilerOptions, coOptimize);

  DelphiWebScript.Config.CompilerOptions := CompilerOptions;
  DelphiWebScript.Config.HintsLevel := TdwsHintsLevel(Options.CompilerOptions.HintsLevel);
  DelphiWebScript.Config.Conditionals.Text := Options.CompilerOptions.ConditionalDefines;

  CodeGenOptions := CodeGen.Options;

  if Options.CodeGenOptions.RangeChecks then
    Exclude(CodeGenOptions, cgoNoRangeChecks)
  else
    Include(CodeGenOptions, cgoNoRangeChecks);
  if Options.CodeGenOptions.InstanceChecks then
    Exclude(CodeGenOptions, cgoNoCheckInstantiated)
  else
    Include(CodeGenOptions, cgoNoCheckInstantiated);
  if Options.CodeGenOptions.LoopChecks then
    Exclude(CodeGenOptions, cgoNoCheckLoopStep)
  else
    Include(CodeGenOptions, cgoNoCheckLoopStep);
  if Options.CodeGenOptions.InstanceChecks then
    Exclude(CodeGenOptions, cgoNoConditions)
  else
    Include(CodeGenOptions, cgoNoConditions);
  if Options.CodeGenOptions.InlineMagics then
    Exclude(CodeGenOptions, cgoNoInlineMagics)
  else
    Include(CodeGenOptions, cgoNoInlineMagics);
  if Options.CodeGenOptions.Obfuscation then
    Include(CodeGenOptions, cgoObfuscate)
  else
    Exclude(CodeGenOptions, cgoObfuscate);
  if Options.CodeGenOptions.EmitSourceLocation then
    Exclude(CodeGenOptions, cgoNoSourceLocations)
  else
    Include(CodeGenOptions, cgoNoSourceLocations);
  if Options.CodeGenOptions.OptimizeForSize then
    Include(CodeGenOptions, cgoOptimizeForSize)
  else
    Exclude(CodeGenOptions, cgoOptimizeForSize);
  if Options.CodeGenOptions.SmartLinking then
    Include(CodeGenOptions, cgoSmartLink)
  else
    Exclude(CodeGenOptions, cgoSmartLink);
  if Options.CodeGenOptions.Devirtualize then
    Include(CodeGenOptions, cgoDeVirtualize)
  else
    Exclude(CodeGenOptions, cgoDeVirtualize);
  if Options.CodeGenOptions.EmitRTTI then
    Exclude(CodeGenOptions, cgoNoRTTI)
  else
    Include(CodeGenOptions, cgoNoRTTI);
  if Options.CodeGenOptions.EmitFinalization then
    Exclude(CodeGenOptions, cgoNoFinalizations)
  else
    Include(CodeGenOptions, cgoNoFinalizations);
  if Options.CodeGenOptions.IgnorePublishedInImplementation then
    Include(CodeGenOptions, cgoIgnorePublishedInImplementation)
  else
    Exclude(CodeGenOptions, cgoIgnorePublishedInImplementation);

  CodeGen.Options := CodeGenOptions;
end;

function THopeCommandLineCompiler.SyntaxCheck(Project: THopeProject): Boolean;
var
  CompiledProgram: IdwsProgram;
begin
  SetupCompiler(Project);

  WriteLn('Compiling ' + Project.Name + '...');

  CompiledProgram := DelphiWebScript.Compile(GetMainScript(Project));

  // log compiler messages
  if CompiledProgram.Msgs.Count > 0 then
    WriteLn(CompiledProgram.Msgs.AsInfo);

  Result := not CompiledProgram.Msgs.HasErrors;
end;

function THopeCommandLineCompiler.CompileProject(Project: THopeProject): IdwsProgram;
var
  CompiledProgram: IdwsProgram;
  CodeJS: string;
  OutputFileName: string;
begin
  SetupCompiler(Project);

  WriteLn('Compiling ' + Project.Name + '...');

  CompiledProgram := DelphiWebScript.Compile(GetMainScript(Project));

  // log compiler messages
  if CompiledProgram.Msgs.Count > 0 then
    WriteLn(CompiledProgram.Msgs.AsInfo);

  // exit in case of errors
  if CompiledProgram.Msgs.HasErrors then
    Exit;

  // fire compilation event
  if Assigned(FOnCompilation) then
    FOnCompilation(Self, CompiledProgram);

  if Project.Options.Output.FileName <> '' then
  begin
    OutputFileName := Project.RootPath + Project.Options.Output.Path +
      Project.Options.Output.FileName;
    OutputFileName := ExpandFileName(OutputFileName);

    WriteLn('Generating Code...');

    CodeGen.Clear;
    CodeGen.CompileProgram(CompiledProgram);
    CodeJS := CodeGen.CompiledOutput(CompiledProgram);

    ForceDirectories(ExtractFileDir(OutputFileName));
    SaveTextToUTF8File(OutputFileName, CodeJS);
  end;
end;

procedure THopeCommandLineCompiler.BuildProject(Project: THopeProject);
var
  CompiledProgram: IdwsProgram;
  CodeJS: string;
  OutputFileName: string;
begin
  SetupCompiler(Project);

  WriteLn('Compiling ' + Project.Name + '...');

  CompiledProgram := DelphiWebScript.Compile(GetMainScript(Project));

  // log compiler messages
  if CompiledProgram.Msgs.Count > 0 then
    WriteLn(CompiledProgram.Msgs.AsInfo);

  // exit in case of errors
  if CompiledProgram.Msgs.HasErrors then
    Exit;

  // fire compilation event
  if Assigned(FOnCompilation) then
    FOnCompilation(Self, CompiledProgram);

  if Project.Options.Output.FileName <> '' then
  begin
    OutputFileName := Project.RootPath + Project.Options.Output.Path +
      Project.Options.Output.FileName;
    OutputFileName := ExpandFileName(OutputFileName);

    WriteLn('Generating Code...');

    CodeGen.Clear;
    CodeGen.CompileProgram(CompiledProgram);
    CodeJS := CodeGen.CompiledOutput(CompiledProgram);

    SaveTextToUTF8File(OutputFileName, CodeJS);
  end;
end;

end.
