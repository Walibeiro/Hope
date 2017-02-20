unit Hope.CommandLine.Compiler;

interface

uses
  System.SysUtils, dwsUtils, dwsComp, dwsCompiler, dwsExprs, dwsJSCodeGen,
  dwsJSLibModule, dwsCodeGen, Hope.CommandLine.Arguments,
  Hope.Compiler.Base, Hope.Compiler.CommandLine;

type
  THopeCommandLineProcessor = class(TRefCountedObject)
  private
    FArguments: THopeCommandLineArguments;
    FCompiler: THopeCommandLineCompiler;

    FOutputName: string;

    procedure ParseArguments;

    procedure WriteArgumentHelp;
    procedure WriteUsage(ErrorMessage: string = '');
    function ValidateArguments: Boolean;
  public
    constructor Create(Arguments: THopeCommandLineArguments);
    destructor Destroy; override;

    procedure CompileScript;
    procedure CompileProject;

    property Arguments: THopeCommandLineArguments read FArguments;
  end;

implementation

uses
  dwsErrors, dwsXPlatform, Hope.Project;

{ THopeCommandLineProcessor }

constructor THopeCommandLineProcessor.Create(Arguments: THopeCommandLineArguments);
begin
  inherited Create;

  FCompiler := THopeCommandLineCompiler.Create;

  FArguments := Arguments;

  if FArguments.HasOption('h') or FArguments.HasOption('help') then
  begin
    WriteUsage;
    WriteArgumentHelp;
    Exit;
  end;

  if not ValidateArguments then
    Exit;

  if LowerCase(ExtractFileExt(Arguments.Filename[0])) = '.pas' then
    CompileScript
  else
  if LowerCase(ExtractFileExt(Arguments.Filename[0])) = '.hproj' then
    CompileProject
  else
  begin
    WriteUsage('Unknown extension');
  end;
end;

destructor THopeCommandLineProcessor.Destroy;
begin
  FCompiler.Free;

  inherited;
end;

function THopeCommandLineProcessor.ValidateArguments: Boolean;
var
  Index: Integer;
begin
  Result := True;
  if FArguments.FileNameCount = 0 then
  begin
    WriteUsage('No files specified');

    Exit(False);
  end;

  for Index := 0 to FArguments.FileNameCount - 1 do
    if not FileExists(FArguments.FileName[Index]) then
    begin
      WriteLn('File ' + FArguments.FileName[Index] + ' does not exist');

      Exit(False);
    end;
end;

procedure THopeCommandLineProcessor.ParseArguments;
begin
  Arguments.GetOptionValue('OutputName', FOutputName);
end;

procedure THopeCommandLineProcessor.WriteArgumentHelp;
begin
  WriteLn('  /OutputName=<fileName>                   Output file name');
  WriteLn('');
  WriteLn('  /Assertions=<bool>                       Enable/disable assertions');
  WriteLn('  /HintsLevel=none|normal|strict|pedantic  Hints level');
  WriteLn('  /Closures=<bool>                         Enable/disable closures');
  WriteLn('  /Optimizations=<bool>                    Enable/disable optimizations');
  WriteLn('  /Defines=<string>                        Specifies conditional defines');
  WriteLn('');
  WriteLn('  /CheckRange=<bool>                       Enable/disable range checks');
  WriteLn('  /CheckInstance=<bool>                    Enable/disable instance checks');
  WriteLn('  /CheckLoopStep=<bool>                    Enable/disable loop step checks');
  WriteLn('  /InlineMagic=<bool>                      Enable/disable inline magic');
  WriteLn('  /Obfuscation=<bool>                      Enable/disable range checks');
  WriteLn('  /SourceLocations=<bool>                  Enable/disable source locations');
  WriteLn('  /SmartLink=<bool>                        Enable/disable smart linking');
  WriteLn('  /DeVirtualization=<bool>                 Enable/disable devirtualization');
  WriteLn('  /RTTI=<bool>                             Enable/disable RTTI');
  WriteLn('  /IgnorePublished=<bool>                  Ignore published implementation');
  WriteLn('  /Verbosity=none|normal|verbose           Verbosity level');
  WriteLn('  /MainBody=<string>                       Main body identifier');
end;

procedure THopeCommandLineProcessor.WriteUsage(ErrorMessage: string = '');
begin
  WriteLn('HOPE command-line compiler');
  WriteLn('');
  WriteLn('Syntax: hcc [options] filename [filenames] [options]');
  if ErrorMessage <> '' then
  begin
    WriteLn('');
    WriteLn('Error: ' + ErrorMessage);
  end;
  WriteLn('');
  WriteArgumentHelp;
end;

procedure THopeCommandLineProcessor.CompileProject;
var
  Index: Integer;
  Project: THopeProject;
begin
  for Index := 0 to Arguments.FileNameCount - 1 do
  begin
    Project := THopeProject.Create;
    try
      Project.LoadFromFile(FArguments.FileName[Index]);

      FCompiler.CompileProject(Project);
    finally
      Project.Free;
    end;
  end;
end;

procedure THopeCommandLineProcessor.CompileScript;
var
  Prog: IdwsProgram;
  CodePas, CodeJS: string;
  OutputName: string;
  Index: Integer;
begin
  // create DWS compiler
  FCompiler.DelphiWebScript.Config.CompilerOptions := [coAssertions, coOptimize,
    coAllowClosures];

  // create JS code generator
  FCompiler.CodeGen.Options := [cgoNoRangeChecks, cgoNoCheckInstantiated,
    cgoNoCheckLoopStep, cgoNoConditions, cgoNoInlineMagics, cgoDeVirtualize,
    cgoNoRTTI, cgoNoFinalizations, cgoIgnorePublishedInImplementation];
  FCompiler.CodeGen.Verbosity := cgovNone;
  TdwsJsCodeGen(FCompiler.CodeGen).MainBodyName := '';

  OutputName := FOutputName;
  for Index := 0 to Arguments.FileNameCount - 1 do
  begin
    CodePas := LoadTextFromFile(Arguments.Filename[Index]);
    Prog := FCompiler.DelphiWebScript.Compile(CodePas);

    if Prog.Msgs.HasErrors then
    begin
      Writeln(Prog.Msgs.AsInfo);
      Exit;
    end;

    FCompiler.CodeGen.Clear;
    FCompiler.CodeGen.CompileProgram(Prog);
    CodeJS := FCompiler.CodeGen.CompiledOutput(Prog);

    // eventually adapt output name
    if FOutputName = '' then
      OutputName := Arguments.Filename[Index] + '.js';

    SaveTextToUTF8File(OutputName, CodeJS);
  end;
end;

end.
