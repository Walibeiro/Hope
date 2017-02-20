program HCC;

{$APPTYPE CONSOLE}
{$IFDEF FPC}
  {$H-}
{$ELSE}
  {$WEAKLINKRTTI ON}
  {$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$ENDIF}

{$R '..\Submodules\dwscript\Libraries\JSCodeGen\dwsJSRTL.res' '..\Submodules\dwscript\Libraries\JSCodeGen\dwsJSRTL.rc'}

{$R *.res}

uses
  SysUtils,
  Hope.Buffer in 'Buffer\Hope.Buffer.pas',
  Hope.Buffer.List in 'Buffer\Hope.Buffer.List.pas',
  Hope.CommandLine.Arguments in 'Command-Line\Hope.CommandLine.Arguments.pas',
  Hope.CommandLine.Compiler in 'Command-Line\Hope.CommandLine.Compiler.pas',
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

begin
  try
    THopeCommandLineProcessor.Create(THopeCommandLineArguments.Create);

    {$IFDEF DEBUG}
    ReadLn;
    {$ENDIF}
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
