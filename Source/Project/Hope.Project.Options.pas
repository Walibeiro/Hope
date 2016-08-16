unit Hope.Project.Options;

interface

{$I Hope.inc}

uses
  dwsJson, Hope.Common.JSON;

type
  THopeCompilerOptions = class(THopeJsonBase)
  private
    FAssertions: Boolean;
    FOptimize: Boolean;
    FHintsLevel: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
  end;

  THopeCodeGenOptions = class(THopeJsonBase)
  private
    FObfuscation: Boolean;
    FRangeChecking: Boolean;
    FInstanceChecking: Boolean;
    FConditionChecking: Boolean;
    FLoopChecking: Boolean;
    FInlineMagics: Boolean;
    FIgnorePublishedInImplementation: Boolean;
    FEmitSourceLocation: Boolean;
    FEmitRTTI: Boolean;
    FDevirtualize: Boolean;
    FMainBody: string;
    FCodePacking: Boolean;
    FSmartLinking: Boolean;
    FVerbosity: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
  public
    property Obfuscation: Boolean read FObfuscation write FObfuscation;
    property RangeChecking: Boolean read FRangeChecking write FRangeChecking;
    property InstanceChecking: Boolean read FInstanceChecking write FInstanceChecking;
    property ConditionChecking: Boolean read FConditionChecking write FConditionChecking;
    property LoopChecking: Boolean read FLoopChecking write FLoopChecking;
    property InlineMagics: Boolean read FInlineMagics write FInlineMagics;
    property IgnorePublishedInImplementation: Boolean read FIgnorePublishedInImplementation write FIgnorePublishedInImplementation;
    property EmitSourceLocation: Boolean read FEmitSourceLocation write FEmitSourceLocation;
    property EmitRTTI: Boolean read FEmitRTTI write FEmitRTTI;
    property Devirtualize: Boolean read FDevirtualize write FDevirtualize;
    property MainBody: string read FMainBody write FMainBody;
    property CodePacking: Boolean read FCodePacking write FCodePacking;
    property SmartLinking: Boolean read FSmartLinking write FSmartLinking;
    property Verbosity: Integer read FVerbosity write FVerbosity;
  end;

  THopeProjectOptions = class(THopeJsonBase)
  private
    FCompilerOptions: THopeCompilerOptions;
    FCodeGenOptions: THopeCodeGenOptions;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
  public
    procedure AfterConstruction; override;
  end;

implementation

{ THopeCompilerOptions }

procedure THopeCompilerOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

end;

procedure THopeCompilerOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

end;


{ THopeCodeGenOptions }

procedure THopeCodeGenOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

end;

procedure THopeCodeGenOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

end;


{ THopeProjectOptions }

procedure THopeProjectOptions.AfterConstruction;
begin
  inherited;
  FCompilerOptions := THopeCompilerOptions.Create;
end;

procedure THopeProjectOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

  FCompilerOptions.LoadFromJson(JsonValue);
end;

procedure THopeProjectOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

  FCompilerOptions.SaveToJson(JsonValue);
end;

end.
