program HCC;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Hope.CommandLine.Arguments in 'Command-Line\Hope.CommandLine.Arguments.pas',
  Hope.CommandLine.Compiler in 'Command-Line\Hope.CommandLine.Compiler.pas',
  Hope.Project.Files in 'Project\Hope.Project.Files.pas',
  Hope.Project.Options in 'Project\Hope.Project.Options.pas',
  Hope.Project in 'Project\Hope.Project.pas',
  Hope.Compiler in 'Compiler\Hope.Compiler.pas',
  Hope.Common.JSON in 'Common\Hope.Common.JSON.pas';

begin
  try
    THopeCommandLineCompiler.Create(THopeCommandLineArguments.Create);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
