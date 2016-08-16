unit Hope.Project.Options;

interface

{$I Hope.inc}

uses
  dwsJson, Hope.Common.JSON;

type
  THopeCompilerOptions = class(THopeJsonBase)
  private
    FAssertions: Boolean;
    FOptimizations: Boolean;
    FHintsLevel: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;

    property Assertions: Boolean read FAssertions write FAssertions;
    property Optimizations: Boolean read FOptimizations write FOptimizations;
    property HintsLevel: Integer read FHintsLevel write FHintsLevel;
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

    property CompilerOptions: THopeCompilerOptions read FCompilerOptions;
    property CodeGenOptions: THopeCodeGenOptions read FCodeGenOptions;
  end;

implementation

{ THopeCompilerOptions }

procedure THopeCompilerOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  FAssertions := JsonValue.GetValue('Assertions', FAssertions);
  FOptimizations := JsonValue.GetValue('Optimizations', FOptimizations);
  FHintsLevel := JsonValue.GetValue('HintsLevel', FHintsLevel);
end;

procedure THopeCompilerOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('Assertions', FAssertions);
  JsonValue.AddValue('Optimizations', FOptimizations);
  JsonValue.AddValue('HintsLevel', FHintsLevel);
end;


{ THopeCodeGenOptions }

procedure THopeCodeGenOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  FObfuscation := JsonValue.GetValue('Obfuscation', FObfuscation);
  FRangeChecking := JsonValue.GetValue('RangeChecking', FRangeChecking);
  FInstanceChecking := JsonValue.GetValue('InstanceChecking', FInstanceChecking);
  FConditionChecking := JsonValue.GetValue('ConditionChecking', FConditionChecking);
  FLoopChecking := JsonValue.GetValue('LoopChecking', FLoopChecking);
  FInlineMagics := JsonValue.GetValue('InlineMagics', FInlineMagics);
  FIgnorePublishedInImplementation := JsonValue.GetValue('IgnorePublishedInImplementation', FIgnorePublishedInImplementation);
  FEmitSourceLocation := JsonValue.GetValue('EmitSourceLocation', FEmitSourceLocation);
  FEmitRTTI := JsonValue.GetValue('EmitRTTI', FEmitRTTI);
  FDevirtualize := JsonValue.GetValue('Devirtualize', FDevirtualize);
  FMainBody := JsonValue.GetValue('MainBody', FMainBody);
  FCodePacking := JsonValue.GetValue('CodePacking', FCodePacking);
  FSmartLinking := JsonValue.GetValue('SmartLinking', FSmartLinking);
  FVerbosity := JsonValue.GetValue('Verbosity', FVerbosity);
end;

procedure THopeCodeGenOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('Obfuscation', FObfuscation);
  JsonValue.AddValue('RangeChecking', FRangeChecking);
  JsonValue.AddValue('InstanceChecking', FInstanceChecking);
  JsonValue.AddValue('ConditionChecking', FConditionChecking);
  JsonValue.AddValue('LoopChecking', FLoopChecking);
  JsonValue.AddValue('InlineMagics', FInlineMagics);
  JsonValue.AddValue('IgnorePublishedInImplementation', FIgnorePublishedInImplementation);
  JsonValue.AddValue('EmitSourceLocation', FEmitSourceLocation);
  JsonValue.AddValue('EmitRTTI', FEmitRTTI);
  JsonValue.AddValue('Devirtualize', FDevirtualize);
  JsonValue.AddValue('MainBody', FMainBody);
  JsonValue.AddValue('CodePacking', FCodePacking);
  JsonValue.AddValue('SmartLinking', FSmartLinking);
  JsonValue.AddValue('Verbosity', FVerbosity);
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
