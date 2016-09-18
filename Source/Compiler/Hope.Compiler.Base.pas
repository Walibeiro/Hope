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
    property DelphiWebScript: TDelphiWebScript read FDelphiWebScript;
    property CodeGen: TdwsJSCodeGen read FCodeGen;
  public
    constructor Create;
    destructor Destroy; override;
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

end.
