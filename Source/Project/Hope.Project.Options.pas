unit Hope.Project.Options;

interface

{$I Hope.inc}

uses
  dwsJson, Hope.Common.JSON;

type
  THopeVersionOptions = class(THopeJsonBase)
  private
    FAutoIncrement: Boolean;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property AutoIncrement: Boolean read FAutoIncrement write FAutoIncrement;
  end;

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
    FRangeChecks: Boolean;
    FInstanceChecks: Boolean;
    FLoopChecks: Boolean;
    FConditionChecks: Boolean;
    FInlineMagics: Boolean;
    FObfuscation: Boolean;
    FEmitSourceLocation: Boolean;
    FOptimizeForSize: Boolean;
    FSmartLinking: Boolean;
    FDevirtualize: Boolean;
    FEmitRTTI: Boolean;
    FEmitFinalization: Boolean;
    FIgnorePublishedInImplementation: Boolean;
    FMainBody: string;
    FIndentSize: Integer;
    FVerbosity: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property RangeChecks: Boolean read FRangeChecks write FRangeChecks;
    property InstanceChecks: Boolean read FInstanceChecks write FInstanceChecks;
    property LoopChecks: Boolean read FLoopChecks write FLoopChecks;
    property ConditionChecks: Boolean read FConditionChecks write FConditionChecks;
    property InlineMagics: Boolean read FInlineMagics write FInlineMagics;
    property Obfuscation: Boolean read FObfuscation write FObfuscation;
    property EmitSourceLocation: Boolean read FEmitSourceLocation write FEmitSourceLocation;
    property OptimizeForSize: Boolean read FOptimizeForSize write FOptimizeForSize;
    property SmartLinking: Boolean read FSmartLinking write FSmartLinking;
    property Devirtualize: Boolean read FDevirtualize write FDevirtualize;
    property EmitRTTI: Boolean read FEmitRTTI write FEmitRTTI;
    property EmitFinalization: Boolean read FEmitFinalization write FEmitFinalization;
    property IgnorePublishedInImplementation: Boolean read FIgnorePublishedInImplementation write FIgnorePublishedInImplementation;
    property MainBody: string read FMainBody write FMainBody;
    property IndentSize: Integer read FIndentSize write FIndentSize;
    property Verbosity: Integer read FVerbosity write FVerbosity;
  end;

  THopeDwsFilterOptions = class(THopeJsonBase)
  private
    FEditorMode: Boolean;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property EditorMode: Boolean read FEditorMode write FEditorMode;
  end;

  TCustomHopeOutputOptions = class(THopeJsonBase)
  private
    FFileName: string;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
  public
    property FileName: string read FFileName write FFileName;
  end;

  THopeOutputHtmlOptions = class(TCustomHopeOutputOptions)
  protected
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
  end;

  THopeOutputCssOptions = class(TCustomHopeOutputOptions)
  protected
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
  end;

  THopeOutputOptions = class(TCustomHopeOutputOptions)
  private
    FPath: string;
    FHtmlOutput: THopeOutputHtmlOptions;
    FCssOutput: THopeOutputCssOptions;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Path: string read FPath write FPath;
    property HtmlOutput: THopeOutputHtmlOptions read FHtmlOutput;
    property CssOutput: THopeOutputCssOptions read FCssOutput;
  end;

  THopeProjectExecutionOptions = class(THopeJsonBase)
  private
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
  end;

  THopeProjectOptions = class(THopeJsonBase)
  private
    FCompilerOptions: THopeCompilerOptions;
    FCodeGenOptions: THopeCodeGenJavaScriptOptions;
    FFilterOptions: THopeDwsFilterOptions;
    FOutput: THopeOutputOptions;
    FExecution: THopeProjectExecutionOptions;
    FVersion: THopeVersionOptions;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property CompilerOptions: THopeCompilerOptions read FCompilerOptions;
    property CodeGenOptions: THopeCodeGenJavaScriptOptions read FCodeGenOptions;
    property FilterOptions: THopeDwsFilterOptions read FFilterOptions;
    property Output: THopeOutputOptions read FOutput;
    property Execution: THopeProjectExecutionOptions read FExecution;
    property Version: THopeVersionOptions read FVersion;
  end;

implementation


{ THopeVersionOptions }

procedure THopeVersionOptions.AfterConstruction;
begin
  inherited;

  FAutoIncrement := False;
end;

class function THopeVersionOptions.GetPreferredName: string;
begin
  Result := 'Version';
end;

procedure THopeVersionOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  FAutoIncrement := JsonValue.GetValue('AutoIncrement', FAutoIncrement);
end;

procedure THopeVersionOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('AutoIncrement', FAutoIncrement);
end;


{ THopeCompilerOptions }

procedure THopeCompilerOptions.AfterConstruction;
begin
  inherited;

  FAssertions := True;
  FOptimizations := True;
  FConditionalDefines := '';
  FHintsLevel := 1;
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

  FRangeChecks := False;
  FInstanceChecks := False;
  FLoopChecks := False;
  FConditionChecks := False;
  FInlineMagics := True;
  FObfuscation := False;
  FEmitSourceLocation := False;
  FOptimizeForSize := False;
  FSmartLinking := True;
  FDevirtualize := True;
  FEmitRTTI := False;
  FEmitFinalization := True;
  FIgnorePublishedInImplementation := True;

  FMainBody := '';
  FIndentSize := 2;
  FVerbosity := 1;
end;

class function THopeCodeGenJavaScriptOptions.GetPreferredName: string;
begin
  Result := 'CodeGenOptions';
end;

procedure THopeCodeGenJavaScriptOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  FRangeChecks := JsonValue.GetValue('RangeChecks', FRangeChecks);
  FInstanceChecks := JsonValue.GetValue('InstanceChecks', FInstanceChecks);
  FLoopChecks := JsonValue.GetValue('LoopChecks', FLoopChecks);
  FConditionChecks := JsonValue.GetValue('ConditionChecks', FConditionChecks);
  FInlineMagics := JsonValue.GetValue('InlineMagics', FInlineMagics);
  FObfuscation := JsonValue.GetValue('Obfuscation', FObfuscation);
  FEmitSourceLocation := JsonValue.GetValue('EmitSourceLocation', FEmitSourceLocation);
  FOptimizeForSize := JsonValue.GetValue('OptimizeForSize', FOptimizeForSize);
  FSmartLinking := JsonValue.GetValue('SmartLinking', FSmartLinking);
  FDevirtualize := JsonValue.GetValue('Devirtualize', FDevirtualize);
  FEmitRTTI := JsonValue.GetValue('EmitRTTI', FEmitRTTI);
  FEmitFinalization := JsonValue.GetValue('EmitFinalization', FEmitFinalization);
  FIgnorePublishedInImplementation := JsonValue.GetValue('IgnorePublishedInImplementation', FIgnorePublishedInImplementation);
  FMainBody := JsonValue.GetValue('MainBody', FMainBody);
  FIndentSize := JsonValue.GetValue('IndentSize', FIndentSize);
  FVerbosity := JsonValue.GetValue('Verbosity', FVerbosity);
end;

procedure THopeCodeGenJavaScriptOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('RangeChecks', FRangeChecks);
  JsonValue.AddValue('InstanceChecks', FInstanceChecks);
  JsonValue.AddValue('LoopChecks', FLoopChecks);
  JsonValue.AddValue('ConditionChecks', FConditionChecks);
  JsonValue.AddValue('InlineMagics', FInlineMagics);
  JsonValue.AddValue('Obfuscation', FObfuscation);
  JsonValue.AddValue('EmitSourceLocation', FEmitSourceLocation);
  JsonValue.AddValue('OptimizeForSize', FOptimizeForSize);
  JsonValue.AddValue('SmartLinking', FSmartLinking);
  JsonValue.AddValue('Devirtualize', FDevirtualize);
  JsonValue.AddValue('EmitRTTI', FEmitRTTI);
  JsonValue.AddValue('EmitFinalization', FEmitFinalization);
  JsonValue.AddValue('IgnorePublishedInImplementation', FIgnorePublishedInImplementation);
  JsonValue.AddValue('MainBody', FMainBody);
  JsonValue.AddValue('IndentSize', FIndentSize);
  JsonValue.AddValue('Verbosity', FVerbosity);
end;


{ THopeDwsFilterOptions }

procedure THopeDwsFilterOptions.AfterConstruction;
begin
  inherited;

  FEditorMode := False;
end;

class function THopeDwsFilterOptions.GetPreferredName: string;
begin
  Result := 'Filter';
end;

procedure THopeDwsFilterOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  FEditorMode := JsonValue.GetValue('EditorMode', FEditorMode);
end;

procedure THopeDwsFilterOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('EditorMode', FEditorMode);
end;


{ TCustomHopeOutputOptions }

procedure TCustomHopeOutputOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  FFilename := JsonValue.GetValue('Filename', FFilename);
end;

procedure TCustomHopeOutputOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('Filename', FFilename);
end;


{ THopeOutputOptions }

procedure THopeOutputOptions.AfterConstruction;
begin
  inherited;

  FHtmlOutput := THopeOutputHtmlOptions.Create;
  FCssOutput  := THopeOutputCssOptions.Create;

  FPath := '..\Output\';
  FFileName := 'main.js';
end;

procedure THopeOutputOptions.BeforeDestruction;
begin
  FHtmlOutput.Free;
  FCssOutput.Free;

  inherited;
end;

class function THopeOutputOptions.GetPreferredName: string;
begin
  Result := 'Output';
end;

procedure THopeOutputOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  inherited ReadJson(JsonValue);

  FPath := JsonValue.GetValue('Path', FPath);

  FHtmlOutput.LoadFromJson(JsonValue, True);
  FCssOutput.LoadFromJson(JsonValue, True);
end;

procedure THopeOutputOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  inherited WriteJson(JsonValue);

  JsonValue.AddValue('Path', FPath);

  FHtmlOutput.SaveToJson(JsonValue);
  FCssOutput.SaveToJson(JsonValue);
end;


{ THopeOutputHtmlOptions }

procedure THopeOutputHtmlOptions.AfterConstruction;
begin
  inherited;

  FileName := 'index.html';
end;

class function THopeOutputHtmlOptions.GetPreferredName: string;
begin
  Result := 'HTML';
end;


{ THopeOutputCssOptions }

procedure THopeOutputCssOptions.AfterConstruction;
begin
  inherited;

  FFileName := 'main.css';
end;

class function THopeOutputCssOptions.GetPreferredName: string;
begin
  Result := 'CSS';
end;


{ THopeProjectExecutionOptions }

procedure THopeProjectExecutionOptions.AfterConstruction;
begin
  inherited;

end;

class function THopeProjectExecutionOptions.GetPreferredName: string;
begin
  Result := 'Execution';
end;

procedure THopeProjectExecutionOptions.ReadJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

end;

procedure THopeProjectExecutionOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

end;


{ THopeProjectOptions }

procedure THopeProjectOptions.AfterConstruction;
begin
  inherited;

  FCompilerOptions := THopeCompilerOptions.Create;
  FCodeGenOptions := THopeCodeGenJavaScriptOptions.Create;
  FFilterOptions := THopeDwsFilterOptions.Create;
  FOutput := THopeOutputOptions.Create;
  FExecution := THopeProjectExecutionOptions.Create;
  FVersion := THopeVersionOptions.Create;
end;

procedure THopeProjectOptions.BeforeDestruction;
begin
  FVersion.Free;
  FCompilerOptions.Free;
  FCodeGenOptions.Free;
  FFilterOptions.Free;
  FOutput.Free;
  FExecution.Free;

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
  FFilterOptions.LoadFromJson(JsonValue, True);
  FOutput.LoadFromJson(JsonValue, True);
  FExecution.LoadFromJson(JsonValue, True);
end;

procedure THopeProjectOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

  FCompilerOptions.SaveToJson(JsonValue);
  FCodeGenOptions.SaveToJson(JsonValue);
  FFilterOptions.SaveToJson(JsonValue);
  FOutput.SaveToJson(JsonValue);
  FExecution.SaveToJson(JsonValue);
end;

end.
