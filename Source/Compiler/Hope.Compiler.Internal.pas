unit Hope.Compiler.Internal;

{$I Hope.inc}

interface

uses
  System.SysUtils, dwsUtils, dwsComp, dwsCompiler, dwsExprs, dwsJSCodeGen,
  dwsJSLibModule, dwsCodeGen, dwsErrors, dwsFunctions, Hope.Project,
  Hope.Compiler.Base;

type
  THopeCompilationEvent = procedure(Sender: TObject; CompiledProgram: IdwsProgram) of object;

  THopeInternalCompiler = class(THopeBaseCompiler)
  private
    FOnCompilation: THopeCompilationEvent;

    function GetMainScript(Project: THopeProject): string;
  protected
    procedure OnIncludeEventHandler(const ScriptName: string;
      var ScriptSource: string); override;
    function OnNeedUnitEventHandler(const UnitName: string;
      var UnitSource: string) : IdwsUnit; override;
  public
    function SyntaxCheck(Project: THopeProject): Boolean;
    function CompileProject(Project: THopeProject): IdwsProgram;
    procedure BuildProject(Project: THopeProject);

    property OnCompilation: THopeCompilationEvent read FOnCompilation write FOnCompilation;
  end;

implementation

uses
  dwsXPlatform, dwsExprList, Hope.Common.Constants, Hope.Main, Hope.DataModule,
  Hope.Common.MonitoredBuffer;

{ THopeInternalCompiler }

function THopeInternalCompiler.GetMainScript(Project: THopeProject): string;
begin
  Result := DataModuleCommon.GetText(Project.RootPath + Project.MainScript.FileName);
end;

procedure THopeInternalCompiler.OnIncludeEventHandler(const ScriptName: string;
  var ScriptSource: string);
begin
  ScriptSource := DataModuleCommon.GetText(ScriptName);
end;

function THopeInternalCompiler.OnNeedUnitEventHandler(const UnitName: string;
  var UnitSource: string): IdwsUnit;
begin
  UnitSource := DataModuleCommon.GetUnit(UnitName);
end;

function THopeInternalCompiler.SyntaxCheck(Project: THopeProject): Boolean;
var
  CompiledProgram: IdwsProgram;
begin
  CompiledProgram := DelphiWebScript.Compile(GetMainScript(Project));

  // log compiler messages
  FormMain.LogCompilerMessages(CompiledProgram.Msgs);

  Result := not CompiledProgram.Msgs.HasErrors;
end;

function THopeInternalCompiler.CompileProject(Project: THopeProject): IdwsProgram;
var
  CompiledProgram: IdwsProgram;
begin
  CompiledProgram := DelphiWebScript.Compile(GetMainScript(Project));

  // log compiler messages
  FormMain.LogCompilerMessages(CompiledProgram.Msgs);

  // exit in case of errors
  if CompiledProgram.Msgs.HasErrors then
    Exit;

  // fire compilation event
  if Assigned(FOnCompilation) then
    FOnCompilation(Self, CompiledProgram);

(*
  FCodeGen.Clear;
  FCodeGen.CompileProgram(CompiledProgram);
  CodeJS := FCodeGen.CompiledOutput(CompiledProgram);
*)
end;

procedure THopeInternalCompiler.BuildProject(Project: THopeProject);
var
  CompiledProgram: IdwsProgram;
begin
  CompiledProgram := DelphiWebScript.Compile(GetMainScript(Project));

  // log compiler messages
  FormMain.LogCompilerMessages(CompiledProgram.Msgs);

  // exit in case of errors
  if CompiledProgram.Msgs.HasErrors then
    Exit;

  // fire compilation event
  if Assigned(FOnCompilation) then
    FOnCompilation(Self, CompiledProgram);
end;

end.
