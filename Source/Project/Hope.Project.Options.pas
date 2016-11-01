unit Hope.Project.Options;

interface

{$I Hope.inc}

uses
  dwsJson, Hope.Common.JSON;

type
  THopeProjectAuthor = class(THopeJsonBase)
  private
    FName: string;
    FEmail: string;
    FWebsite: string;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property Name: string read FName write FName;
    property Email: string read FEmail write FEmail;
    property Website: string read FWebsite write FWebsite;
  end;

  THopeProjectInformation = class(THopeJsonBase)
  private
    FName: string;
    FDescription: string;
    FAuthor: THopeProjectAuthor;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Name: string read FName write FName;
    property Description: string read FDescription write FDescription;
    property Author: THopeProjectAuthor read FAuthor write FAuthor;
  end;

  THopeProjectVersion = class(THopeJsonBase)
  private
    FMajor: Integer;
    FMinor: Integer;
    FRelease: Integer;
    FBuild: Integer;
    FAutoIncrement: Boolean;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property Major: Integer read FMajor write FMajor;
    property Minor: Integer read FMinor write FMinor;
    property Release: Integer read FRelease write FRelease;
    property Build: Integer read FBuild write FBuild;
    property AutoIncrement: Boolean read FAutoIncrement write FAutoIncrement;
  end;

  THopeProjectIcon = class(THopeJsonBase)
  private
    FFileName: string;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property FileName: string read FFileName write FFileName;
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

  THopeProjectExecution = class(THopeJsonBase)
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
    FInformation: THopeProjectInformation;
    FVersion: THopeProjectVersion;
    FIcon: THopeProjectIcon;
    FCompilerOptions: THopeCompilerOptions;
    FCodeGenOptions: THopeCodeGenJavaScriptOptions;
    FExecution: THopeProjectExecution;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Information: THopeProjectInformation read FInformation;
    property Version: THopeProjectVersion read FVersion;
    property Icon: THopeProjectIcon read FIcon;
    property CompilerOptions: THopeCompilerOptions read FCompilerOptions;
    property CodeGenOptions: THopeCodeGenJavaScriptOptions read FCodeGenOptions;
    property Execution: THopeProjectExecution read FExecution;
  end;

implementation


{ THopeProjectAuthor }

procedure THopeProjectAuthor.AfterConstruction;
begin
  inherited;

  FName := '';
  FEmail := '';
  FWebsite := ''
end;

class function THopeProjectAuthor.GetPreferredName: string;
begin
  Result := 'Author';
end;

procedure THopeProjectAuthor.ReadJson(
  const JsonValue: TdwsJsonObject);
begin
  FName := JsonValue.GetValue('Name', FName);
  FEmail := JsonValue.GetValue('Email', FEmail);
  FWebsite := JsonValue.GetValue('Website', FWebsite);
end;

procedure THopeProjectAuthor.WriteJson(
  const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('Name', FName);
  JsonValue.AddValue('Email', FEmail);
  JsonValue.AddValue('Website', FWebsite);
end;


{ THopeProjectInformation }

procedure THopeProjectInformation.AfterConstruction;
begin
  inherited;

  FName := '';
  FDescription := '';
  FAuthor := THopeProjectAuthor.Create;
end;

procedure THopeProjectInformation.BeforeDestruction;
begin
  inherited;

  FAuthor.Free;
end;

class function THopeProjectInformation.GetPreferredName: string;
begin
  Result := 'Project';
end;

procedure THopeProjectInformation.ReadJson(const JsonValue: TdwsJsonObject);
begin
  FName := JsonValue.GetValue('Name', FName);
  FDescription := JsonValue.GetValue('Description', FDescription);
  FAuthor.LoadFromJson(JsonValue, True);
end;

procedure THopeProjectInformation.WriteJson(const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('Name', FName);
  JsonValue.AddValue('Description', FDescription);
  FAuthor.SaveToJson(JsonValue);
end;


{ THopeProjectVersion }

procedure THopeProjectVersion.AfterConstruction;
begin
  inherited;

  FMajor := 0;
  FMinor := 0;
  FRelease := 0;
  FBuild := 0;
  FAutoIncrement := False;
end;

class function THopeProjectVersion.GetPreferredName: string;
begin
  Result := 'Version';
end;

procedure THopeProjectVersion.ReadJson(
  const JsonValue: TdwsJsonObject);
begin
  FMajor := JsonValue.GetValue('Major', FMajor);
  FMinor := JsonValue.GetValue('Minor', FMinor);
  FRelease := JsonValue.GetValue('Release', FRelease);
  FBuild := JsonValue.GetValue('Build', FBuild);
  FAutoIncrement := JsonValue.GetValue('AutoIncrement', FAutoIncrement);
end;

procedure THopeProjectVersion.WriteJson(
  const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('Major', FMajor);
  JsonValue.AddValue('Minor', FMinor);
  JsonValue.AddValue('Release', FRelease);
  JsonValue.AddValue('Build', FBuild);
  JsonValue.AddValue('AutoIncrement', FAutoIncrement);
end;


{ THopeProjectIcon }

procedure THopeProjectIcon.AfterConstruction;
begin
  inherited;

  FFileName := '';
end;

class function THopeProjectIcon.GetPreferredName: string;
begin
  Result := 'Icon';
end;

procedure THopeProjectIcon.ReadJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

  FFileName := JsonValue.GetValue('FileName', FFileName);
end;

procedure THopeProjectIcon.WriteJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

  JsonValue.AddValue('FileName', FFileName);
end;


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


{ THopeProjectExecution }

procedure THopeProjectExecution.AfterConstruction;
begin
  inherited;

end;

class function THopeProjectExecution.GetPreferredName: string;
begin
  Result := 'Execution';
end;

procedure THopeProjectExecution.ReadJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

end;

procedure THopeProjectExecution.WriteJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

end;


{ THopeProjectOptions }

procedure THopeProjectOptions.AfterConstruction;
begin
  inherited;

  FInformation := THopeProjectInformation.Create;
  FVersion := THopeProjectVersion.Create;
  FIcon := THopeProjectIcon.Create;
  FCompilerOptions := THopeCompilerOptions.Create;
  FCodeGenOptions := THopeCodeGenJavaScriptOptions.Create;
  FExecution := THopeProjectExecution.Create;
end;

procedure THopeProjectOptions.BeforeDestruction;
begin
  FInformation.Free;
  FVersion.Free;
  FIcon.Free;
  FCompilerOptions.Free;
  FCodeGenOptions.Free;
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

  FInformation.LoadFromJson(JsonValue, True);
  FVersion.LoadFromJson(JsonValue, True);
  FIcon.LoadFromJson(JsonValue, True);
  FCompilerOptions.LoadFromJson(JsonValue, True);
  FCodeGenOptions.LoadFromJson(JsonValue, True);
  FExecution.LoadFromJson(JsonValue, True);
end;

procedure THopeProjectOptions.WriteJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

  FInformation.SaveToJson(JsonValue);
  FVersion.SaveToJson(JsonValue);
  FIcon.SaveToJson(JsonValue);
  FCompilerOptions.SaveToJson(JsonValue);
  FCodeGenOptions.SaveToJson(JsonValue);
  FExecution.SaveToJson(JsonValue);
end;


end.
