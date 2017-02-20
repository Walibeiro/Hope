unit Hope.Compiler.Base;

{$I Hope.inc}

interface

uses
  System.SysUtils, dwsUtils, dwsComp, dwsCompiler, dwsExprs, dwsErrors,
  dwsFunctions, dwsCodeGen, Hope.Project;

type
  THopeBaseCompiler = class
  private
    FDelphiWebScript: TDelphiWebScript;
  protected
    FCodeGen: TdwsCodeGen;
    FCodeGenLib: TdwsCustomLangageExtension;

    procedure InstanciateCodeGen; virtual; abstract;
    procedure OnIncludeEventHandler(const ScriptName: string;
      var ScriptSource: string); virtual; abstract;
    function OnNeedUnitEventHandler(const UnitName: string;
      var UnitSource: string) : IdwsUnit; virtual; abstract;

    property DelphiWebScript: TDelphiWebScript read FDelphiWebScript;
    property CodeGen: TdwsCodeGen read FCodeGen;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Abort; inline;
  end;

implementation

uses
  dwsXPlatform, dwsExprList, dwsJSCodeGen, dwsJSLibModule, Hope.Common.Constants;

{ THopeBaseCompiler }

constructor THopeBaseCompiler.Create;
begin
  // create DWS compiler
  FDelphiWebScript := TDelphiWebScript.Create(nil);
  FDelphiWebScript.Config.CompilerOptions := [coAssertions, coAllowClosures];
  DelphiWebScript.OnNeedUnit := OnNeedUnitEventHandler;
  DelphiWebScript.OnInclude := OnIncludeEventHandler;

  InstanciateCodeGen;
end;

destructor THopeBaseCompiler.Destroy;
begin
  FDelphiWebScript.Free;
  FCodeGenLib.Free;
  FCodeGen.Free;

  inherited;
end;

procedure THopeBaseCompiler.Abort;
begin
  FDelphiWebScript.AbortCompilation;
end;

end.
