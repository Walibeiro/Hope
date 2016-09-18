unit Hope.Compiler.Base;

{$I Hope.inc}

interface

uses
  System.SysUtils, dwsUtils, dwsComp, dwsCompiler, dwsExprs, dwsJSCodeGen,
  dwsJSLibModule, dwsCodeGen, dwsErrors, dwsFunctions, Hope.Project;

type
  THopeBaseCompiler = class
  private
    FDelphiWebScript: TDelphiWebScript;
    FCodeGen: TdwsJSCodeGen;
    FJSLib: TdwsJSLibModule;
  protected
    procedure OnIncludeEventHandler(const ScriptName: string;
      var ScriptSource: string); virtual; abstract;
    function OnNeedUnitEventHandler(const UnitName: string;
      var UnitSource: string) : IdwsUnit; virtual; abstract;

    property DelphiWebScript: TDelphiWebScript read FDelphiWebScript;
    property CodeGen: TdwsJSCodeGen read FCodeGen;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Abort; inline;
  end;

implementation

uses
  dwsXPlatform, dwsExprList, Hope.Common.Constants;

{ THopeBaseCompiler }

constructor THopeBaseCompiler.Create;
begin
  // create DWS compiler
  FDelphiWebScript := TDelphiWebScript.Create(nil);
  FDelphiWebScript.Config.CompilerOptions := [coAssertions, coAllowClosures];
  DelphiWebScript.OnNeedUnit := OnNeedUnitEventHandler;
  DelphiWebScript.OnInclude := OnIncludeEventHandler;

  // create JS lib modume
  FJSLib := TdwsJSLibModule.Create(nil);
  FJSLib.Script := FDelphiWebScript;

  FCodeGen := TdwsJSCodeGen.Create;
  FCodeGen.Options := [cgoNoRangeChecks, cgoNoCheckInstantiated,
    cgoNoCheckLoopStep, cgoNoConditions, cgoNoInlineMagics, cgoDeVirtualize,
    cgoNoRTTI, cgoNoFinalizations, cgoIgnorePublishedInImplementation];
  FCodeGen.Verbosity := cgovNone;
  FCodeGen.MainBodyName := '';
end;

destructor THopeBaseCompiler.Destroy;
begin
  FDelphiWebScript.Free;
  FJSLib.Free;
  FCodeGen.Free;

  inherited;
end;

procedure THopeBaseCompiler.Abort;
begin
  FDelphiWebScript.AbortCompilation;
end;

end.
