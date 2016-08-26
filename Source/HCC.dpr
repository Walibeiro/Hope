program HCC;

{$APPTYPE CONSOLE}
{$IFDEF FPC}
  {$H-}
{$ELSE}
  {$WEAKLINKRTTI ON}
  {$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$ENDIF}

{$IFDEF FPC}
  {$R '..\Libraries\JSCodeGen\dwsJSRTL.res' '..\Libraries\JSCodeGen\dwsJSRTL.rc'}
{$ENDIF}

{$R *.res}

uses
  SysUtils,
  Hope.CommandLine.Arguments in 'Command-Line\Hope.CommandLine.Arguments.pas',
  Hope.CommandLine.Compiler in 'Command-Line\Hope.CommandLine.Compiler.pas',
  Hope.Compiler in 'Compiler\Hope.Compiler.pas',
  Hope.Common.JSON in 'Common\Hope.Common.JSON.pas',
  Hope.Project.List in 'Project\Hope.Project.List.pas',
  Hope.Project.Options in 'Project\Hope.Project.Options.pas',
  Hope.Project in 'Project\Hope.Project.pas',
  Hope.Project.Files in 'Project\Hope.Project.Files.pas';

begin
  try
    THopeCommandLineCompiler.Create(THopeCommandLineArguments.Create);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
