unit Hope.Compiler.Internal;

{$I Hope.inc}

interface

uses
  System.SysUtils, dwsUtils, dwsComp, dwsCompiler, dwsExprs, dwsJSCodeGen,
  dwsJSLibModule, dwsCodeGen, dwsErrors, dwsFunctions, Hope.Project,
  Hope.Compiler.Base;

type
  THopeCompilationEvent = procedure(Sender: TObject; Prog: IdwsProgram) of object;

  THopeCompiler = class(THopeBaseCompiler)
  private
    FOnCompilation: THopeCompilationEvent;

    function GetMainScript(Project: THopeProject): string;
    procedure OnIncludeEventHandler(const ScriptName: string;
      var ScriptSource: string);
    function OnNeedUnitEventHandler(const UnitName: string;
      var UnitSource: string) : IdwsUnit;
  public
    constructor Create;
    destructor Destroy; override;

    function SyntaxCheck(Project: THopeProject): Boolean;
    function CompileProject(Project: THopeProject): IdwsProgram;
    procedure BuildProject(Project: THopeProject);

    property OnCompilation: THopeCompilationEvent read FOnCompilation write FOnCompilation;
  end;

implementation

uses
  dwsXPlatform, dwsExprList, Hope.Common.Constants, Hope.Main, Hope.DataModule;

{ THopeCompiler }

constructor THopeCompiler.Create;
begin
  // create DWS compiler
  DelphiWebScript.OnNeedUnit := OnNeedUnitEventHandler;
  DelphiWebScript.OnInclude := OnIncludeEventHandler;
end;

destructor THopeCompiler.Destroy;
begin
  inherited;
end;

function THopeCompiler.GetMainScript(Project: THopeProject): string;
begin
  DataModuleCommon.GetText(Project.MainScript.FileName);
end;

procedure THopeCompiler.OnIncludeEventHandler(const ScriptName: string;
  var ScriptSource: string);
begin
  ScriptSource := DataModuleCommon.GetText(ScriptName);
end;

function THopeCompiler.OnNeedUnitEventHandler(const UnitName: string;
  var UnitSource: string): IdwsUnit;
begin
  UnitSource := DataModuleCommon.GetUnit(UnitName);
end;

function THopeCompiler.SyntaxCheck(Project: THopeProject): Boolean;
var
  Prog: IdwsProgram;
begin
  Prog := DelphiWebScript.Compile(GetMainScript(Project));

  // log compiler messages
  FormMain.LogCompilerMessages(Prog.Msgs);
end;

function THopeCompiler.CompileProject(Project: THopeProject): IdwsProgram;
var
  Prog: IdwsProgram;
  CodeJS: string;
begin
  Prog := DelphiWebScript.Compile(GetMainScript(Project));

  // log compiler messages
  FormMain.LogCompilerMessages(Prog.Msgs);

  // exit in case of errors
  if Prog.Msgs.HasErrors then
    Exit;

  // fire compilation event
  if Assigned(FOnCompilation) then
    FOnCompilation(Self, Prog);


(*
  FCodeGen.Clear;
  FCodeGen.CompileProgram(Prog);
  CodeJS := FCodeGen.CompiledOutput(Prog);
*)
end;

procedure THopeCompiler.BuildProject(Project: THopeProject);
var
  Prog: IdwsProgram;
begin
  Prog := DelphiWebScript.Compile(GetMainScript(Project));

  // log compiler messages
  FormMain.LogCompilerMessages(Prog.Msgs);

  // exit in case of errors
  if Prog.Msgs.HasErrors then
    Exit;

  // fire compilation event
  if Assigned(FOnCompilation) then
    FOnCompilation(Self, Prog);
end;

end.
