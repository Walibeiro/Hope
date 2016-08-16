program HCC;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Hope.CommandLine.Arguments in 'Command-Line\Hope.CommandLine.Arguments.pas',
  Hope.CommandLine.Compiler in 'Command-Line\Hope.CommandLine.Compiler.pas';

begin
  try
    THopeCommandLineCompiler.Create(THopeCommandLineArguments.Create);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
