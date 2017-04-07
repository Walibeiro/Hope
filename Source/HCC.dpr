program HCC;

{$APPTYPE CONSOLE}
{$IFDEF FPC}
  {$H-}
{$ELSE}
  {$WEAKLINKRTTI ON}
  {$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$ENDIF}

{$R 'dwsJSRTL.res' '..\Submodules\dwscript\Libraries\JSCodeGen\dwsJSRTL.rc'}

{$R *.res}

uses
  SysUtils,
  Hope.Buffer in 'Buffer\Hope.Buffer.pas',
  Hope.Buffer.List in 'Buffer\Hope.Buffer.List.pas',
  Hope.CommandLine.Arguments in 'Command-Line\Hope.CommandLine.Arguments.pas',
  Hope.Common.Constants in 'Common\Hope.Common.Constants.pas',
  Hope.Common.DirectoryMonitor in 'Common\Hope.Common.DirectoryMonitor.pas',
  Hope.Common.FileUtilities in 'Common\Hope.Common.FileUtilities.pas',
  Hope.Common.JSON in 'Common\Hope.Common.JSON.pas',
  Hope.Common.MonitoredBuffer in 'Common\Hope.Common.MonitoredBuffer.pas',
  Hope.Compiler.Base in 'Compiler\Hope.Compiler.Base.pas',
  Hope.Compiler.CommandLine in 'Compiler\Hope.Compiler.CommandLine.pas',
  Hope.Project in 'Project\Hope.Project.pas',
  Hope.Project.Files in 'Project\Hope.Project.Files.pas',
  Hope.Project.Information in 'Project\Hope.Project.Information.pas',
  Hope.Project.Interfaces in 'Project\Hope.Project.Interfaces.pas',
  Hope.Project.List in 'Project\Hope.Project.List.pas',
  Hope.Project.Options in 'Project\Hope.Project.Options.pas';

procedure WriteArgumentHelp;
begin
  WriteLn('  /OutputName=<FileName>                   Output file name');
  WriteLn('');
  WriteLn('  /LibraryPath=<LibraryPath>               Library path');
  WriteLn('');
  WriteLn('  /Assertions=<Boolean>                    Enable/disable assertions');
  WriteLn('  /HintsLevel=none|normal|strict|pedantic  Hints level');
  WriteLn('  /Optimizations=<Boolean>                 Enable/disable optimizations');
  WriteLn('  /Defines=<String>                        Specifies conditional defines');
  WriteLn('');
  WriteLn('  /Closures=<Boolean>                      Enable/disable closures');
  WriteLn('  /CheckRange=<Boolean>                    Enable/disable range checks');
  WriteLn('  /CheckInstance=<Boolean>                 Enable/disable instance checks');
  WriteLn('  /CheckLoopStep=<Boolean>                 Enable/disable loop step checks');
  WriteLn('  /InlineMagic=<Boolean>                   Enable/disable inline magic');
  WriteLn('  /Obfuscation=<Boolean>                   Enable/disable range checks');
  WriteLn('  /SourceLocations=<Boolean>               Enable/disable source locations');
  WriteLn('  /SmartLink=<Boolean>                     Enable/disable smart linking');
  WriteLn('  /DeVirtualization=<Boolean>              Enable/disable devirtualization');
  WriteLn('  /RTTI=<Boolean>                          Enable/disable RTTI');
  WriteLn('  /IgnorePublished=<Boolean>               Ignore published implementation');
  WriteLn('  /Verbosity=none|normal|verbose           Verbosity level');
  WriteLn('  /MainBody=<String>                       Main body identifier');
end;

procedure WriteUsage(ErrorMessage: string = '');
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

type
  ECommandLineCompiler = Exception;

procedure OverwriteProjectOptions(Project: THopeProject;
  Arguments: THopeCommandLineArguments);
var
  Name, Value: String;
  Index: Integer;
  LibraryPath: String;
begin
  // scan and overwrite options
  for Index := 0 to Arguments.OptionCount - 1 do
  begin
    Name := Arguments.Option[Index].Name;

    if Name = 'librarypath' then
    begin
      // get actual library path
      LibraryPath := Arguments.Option[Index].Value;

      // check if library path exists
      if not DirectoryExists(LibraryPath) then
        ECommandLineCompiler.CreateFmt('Library path %s does not exist', [LibraryPath]);

      // add library path
      Project.Options.CompilerOptions.LibraryPaths.Add(LibraryPath);
    end
    else
    if Name = 'outputname' then
      Project.Options.Output.FileName := Arguments.Option[Index].Value
    else
    if Name = 'assertions' then
      Project.Options.CompilerOptions.Assertions := Arguments.Option[Index].ValueAsBoolean
    else
    if Name = 'optimizations' then
      Project.Options.CompilerOptions.Optimizations := Arguments.Option[Index].ValueAsBoolean
    else
    if Name = 'HintsLevel' then
    begin
      if Value = 'none' then
        Project.Options.CompilerOptions.HintsLevel := 0
      else
      if Value = 'normal' then
        Project.Options.CompilerOptions.HintsLevel := 1
      else
      if Value = 'strict' then
        Project.Options.CompilerOptions.HintsLevel := 2
      else
      if Value = 'pedantic' then
        Project.Options.CompilerOptions.HintsLevel := 3
    end;
(*
    WriteLn('  /Defines=<String>                        Specifies conditional defines');
    WriteLn('');
    WriteLn('  /CheckRange=<Boolean>                    Enable/disable range checks');
    WriteLn('  /CheckInstance=<Boolean>                 Enable/disable instance checks');
    WriteLn('  /CheckLoopStep=<Boolean>                 Enable/disable loop step checks');
    WriteLn('  /InlineMagic=<Boolean>                   Enable/disable inline magic');
    WriteLn('  /Obfuscation=<Boolean>                   Enable/disable range checks');
    WriteLn('  /SourceLocations=<Boolean>               Enable/disable source locations');
    WriteLn('  /SmartLink=<Boolean>                     Enable/disable smart linking');
    WriteLn('  /DeVirtualization=<Boolean>              Enable/disable devirtualization');
    WriteLn('  /RTTI=<Boolean>                          Enable/disable RTTI');
    WriteLn('  /IgnorePublished=<Boolean>               Ignore published implementation');
    WriteLn('  /Verbosity=none|normal|verbose           Verbosity level');
    WriteLn('  /MainBody=<String>                       Main body identifier');
*)
  end;
end;

function LocateRtlDirectory: string;
begin
  Result := ExpandFileName(ExtractFilePath(ParamStr(0)) + '..\Common\APIs');
  if DirectoryExists(Result) then
    Exit;

  Result := ExpandFileName(ExtractFilePath(ParamStr(0)) + 'APIs');
  if DirectoryExists(Result) then
    Exit;
end;

procedure Compile(Arguments: THopeCommandLineArguments);
var
  FileIndex: Integer;
  FileName: TFileName;
  FileExtension: string;
  RtlDirectory: string;
  Compiler: THopeCommandLineCompiler;
  Project: THopeProject;
begin
  Compiler := THopeCommandLineCompiler.Create;

  // check if help option is supplied
  if Arguments.HasOption('h') or Arguments.HasOption('help') then
  begin
    WriteUsage;
    Exit;
  end;

  // check if help option is supplied
  if Arguments.FileNameCount = 0 then
    raise ECommandLineCompiler.Create('No files specified');

  Compiler.AddLibraryPath(LocateRtlDirectory);

  // now compile every file name
  for FileIndex := 0 to Arguments.FileNameCount - 1 do
  begin
    FileName := Arguments.FileName[FileIndex];

    // check if all specified files do exist
    if not FileExists(FileName) then
      raise ECommandLineCompiler.CreateFmt('File %s does not exist', [FileName]);

    Project := THopeProject.Create;
    try
      // get file extension
      FileExtension := LowerCase(ExtractFileExt(FileName));

      // load or setup project
      if FileExtension = '.pas' then
      begin
        Project.Name := FileName;
        Project.MainScript.FileName := FileName;
        Project.FileName := FileName;
      end
      else
      if FileExtension = '.hproj' then
        Project.LoadFromFile(FileName)
      else
        raise ECommandLineCompiler.CreateFmt('Unknown file extension (%s) for file %s',
          [FileExtension, FileName]);

      OverwriteProjectOptions(Project, Arguments);

      Compiler.CompileProject(Project);
    finally
      Project.Free;
    end;
  end;
end;

begin
  try
    Compile(THopeCommandLineArguments.Create);
  except
    on E: ECommandLineCompiler do
      WriteUsage(E.Message);
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  {$IFDEF DEBUG}
  ReadLn;
  {$ENDIF}
end.
