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
    FConditionalDefines: string;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property Assertions: Boolean read FAssertions write FAssertions;
    property ConditionalDefines: string read FConditionalDefines write FConditionalDefines;
    property Optimizations: Boolean read FOptimizations write FOptimizations;
    property HintsLevel: Integer read FHintsLevel write FHintsLevel;
  end;

  THopeCodeGenJavaScriptOptions = class(THopeJsonBase)
  private
    FObfuscation: Boolean;
    FRangeChecks: Boolean;
    FInstanceChecks: Boolean;
    FConditionChecks: Boolean;
    FLoopChecks: Boolean;
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
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property Obfuscation: Boolean read FObfuscation write FObfuscation;
    property RangeChecks: Boolean read FRangeChecks write FRangeChecks;
    property InstanceChecks: Boolean read FInstanceChecks write FInstanceChecks;
    property ConditionChecks: Boolean read FConditionChecks write FConditionChecks;
    property LoopChecks: Boolean read FLoopChecks write FLoopChecks;
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
    FCodeGenOptions: THopeCodeGenJavaScriptOptions;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property CompilerOptions: THopeCompilerOptions read FCompilerOptions;
    property CodeGenOptions: THopeCodeGenJavaScriptOptions read FCodeGenOptions;
  end;

implementation

{ THopeCompilerOptions }

procedure THopeCompilerOptions.AfterConstruction;
begin
  inherited;

  FAssertions := True;
  FOptimizations := True;
  FConditionalDefines := '';
  FHintsLevel := 0;
end;

class function THopeCompilerOptions.GetPreferredName: string;
begin
  Result := 'CompilerOptions';
end;

procedure THopeCompilerOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  FAssertions := JsonValue.GetValue('Assertions', FAssertions);
  FConditionalDefines := JsonValue.GetValue('ConditionalDefines', FConditionalDefines);
  FOptimizations := JsonValue.GetValue('Optimizations', FOptimizations);
  FHintsLevel := JsonValue.GetValue('HintsLevel', FHintsLevel);
end;

procedure THopeCompilerOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('Assertions', FAssertions);
  JsonValue.AddValue('ConditionalDefines', FConditionalDefines);
  JsonValue.AddValue('Optimizations', FOptimizations);
  JsonValue.AddValue('HintsLevel', FHintsLevel);
end;


{ THopeCodeGenJavaScriptOptions }

procedure THopeCodeGenJavaScriptOptions.AfterConstruction;
begin
  inherited;

  FObfuscation := False;
  FRangeChecks := False;
  FInstanceChecks := False;
  FConditionChecks := False;
  FLoopChecks := False;
  FInlineMagics := True;
  FIgnorePublishedInImplementation := True;
  FEmitSourceLocation := False;
  FEmitRTTI := False;
  FDevirtualize := True;
  FMainBody := '';
  FCodePacking := False;
  FSmartLinking := True;
  FVerbosity := 1;
end;

class function THopeCodeGenJavaScriptOptions.GetPreferredName: string;
begin
  Result := 'CodeGenOptions';
end;

procedure THopeCodeGenJavaScriptOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  FObfuscation := JsonValue.GetValue('Obfuscation', FObfuscation);
  FRangeChecks := JsonValue.GetValue('RangeChecks', FRangeChecks);
  FInstanceChecks := JsonValue.GetValue('InstanceChecks', FInstanceChecks);
  FConditionChecks := JsonValue.GetValue('ConditionChecks', FConditionChecks);
  FLoopChecks := JsonValue.GetValue('LoopChecks', FLoopChecks);
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

procedure THopeCodeGenJavaScriptOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('Obfuscation', FObfuscation);
  JsonValue.AddValue('RangeChecks', FRangeChecks);
  JsonValue.AddValue('InstanceChecks', FInstanceChecks);
  JsonValue.AddValue('ConditionChecks', FConditionChecks);
  JsonValue.AddValue('LoopChecks', FLoopChecks);
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
  FCodeGenOptions := THopeCodeGenJavaScriptOptions.Create;
end;

procedure THopeProjectOptions.BeforeDestruction;
begin
  FCompilerOptions.Free;
  FCodeGenOptions.Free;

  inherited;
end;

class function THopeProjectOptions.GetPreferredName: string;
begin
  Result := 'Options';
end;

procedure THopeProjectOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

  FCompilerOptions.LoadFromJson(JsonValue, True);
  FCodeGenOptions.LoadFromJson(JsonValue, True);
end;

procedure THopeProjectOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

  FCompilerOptions.SaveToJson(JsonValue);
  FCodeGenOptions.SaveToJson(JsonValue);
end;

end.
