unit Hope.CommandLine.Compiler;

interface

uses
  System.SysUtils, dwsUtils, dwsComp, dwsCompiler, dwsExprs, dwsJSCodeGen,
  dwsJSLibModule, dwsCodeGen, Hope.CommandLine.Arguments;

type
  THopeCommandLineCompiler = class(TRefCountedObject)
  private
    FArguments: THopeCommandLineArguments;
    FDelphiWebScript: TDelphiWebScript;
    FCodeGen: TdwsJSCodeGen;
    FJSLib: TdwsJSLibModule;

    FOutputName: string;

    procedure ParseArguments;

    procedure WriteArgumentHelp;
    procedure WriteUsage(ErrorMessage: string = '');
  public
    constructor Create(Arguments: THopeCommandLineArguments);

    procedure CompileScript;
    procedure CompileProject;

    property Arguments: THopeCommandLineArguments read FArguments;
  end;

implementation

uses
  dwsErrors, dwsXPlatform;

{ THopeCommandLineCompiler }

constructor THopeCommandLineCompiler.Create(Arguments: THopeCommandLineArguments);
begin
  FArguments := Arguments;

  if FArguments.HasOption('h') or FArguments.HasOption('help') then
  begin
    WriteUsage;
    WriteArgumentHelp;
    Exit;
  end;

  if FArguments.FileNameCount = 0 then
  begin
    WriteUsage('No files specified');

    Exit;
  end;

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

procedure THopeCommandLineCompiler.ParseArguments;
begin
  Arguments.GetOptionValue('OutputName', FOutputName);
end;

procedure THopeCommandLineCompiler.WriteArgumentHelp;
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

procedure THopeCommandLineCompiler.WriteUsage(ErrorMessage: string = '');
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

procedure THopeCommandLineCompiler.CompileProject;
begin

end;

procedure THopeCommandLineCompiler.CompileScript;
var
  Prog: IdwsProgram;
  CodePas, CodeJS: string;
  OutputName: string;
  Index: Integer;
begin
  // create DWS compiler
  FDelphiWebScript := TDelphiWebScript.Create(nil);
  FDelphiWebScript.Config.CompilerOptions := [coAssertions, coOptimize,
    coAllowClosures];

  // create JS lib modume
  FJSLib := TdwsJSLibModule.Create(nil);
  FJSLib.Script := FDelphiWebScript;

  // create JS code generator
  FCodeGen := TdwsJSCodeGen.Create;
  FCodeGen.Options := [cgoNoRangeChecks, cgoNoCheckInstantiated,
    cgoNoCheckLoopStep, cgoNoConditions, cgoNoInlineMagics, cgoDeVirtualize,
    cgoNoRTTI, cgoNoFinalizations, cgoIgnorePublishedInImplementation];
  FCodeGen.Verbosity := cgovNone;
  FCodeGen.MainBodyName := '';

  OutputName := FOutputName;
  for Index := 0 to Arguments.FileNameCount - 1 do
  begin
    CodePas := LoadTextFromFile(Arguments.Filename[Index]);
    Prog := FDelphiWebScript.Compile(CodePas);

    if Prog.Msgs.HasErrors then
    begin
      Writeln(Prog.Msgs.AsInfo);
      Exit;
    end;

    FCodeGen.Clear;
    FCodeGen.CompileProgram(Prog);
    CodeJS := FCodeGen.CompiledOutput(Prog);

    // eventually adapt output name
    if FOutputName = '' then
      OutputName := Arguments.Filename[Index] + '.js';

    SaveTextToUTF8File(OutputName, CodeJS);
  end;
end;

end.
