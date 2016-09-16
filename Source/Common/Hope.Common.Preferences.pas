unit Hope.Common.Preferences;

interface

{$I Hope.inc}

uses
  dwsJSON, Hope.Common.JSON;

type
  THopePreferencesEnvironment = class(THopeJsonBase)
  private
    FDefaultProjectPath: string;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    property DefaultProjectPath: string read FDefaultProjectPath write FDefaultProjectPath;
  end;

  THopePreferences = class(THopeJsonBase)
  private
    FEnvironment: THopePreferencesEnvironment;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Environment: THopePreferencesEnvironment read FEnvironment write FEnvironment;
  end;

implementation

{ THopePreferencesEnvironment }

class function THopePreferencesEnvironment.GetPreferredName: string;
begin
  Result := 'Environment';
end;

procedure THopePreferencesEnvironment.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FDefaultProjectPath := JsonValue.GetValue('Default Project Path', FDefaultProjectPath);
end;

procedure THopePreferencesEnvironment.WriteJson(
  const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('Default Project Path', FDefaultProjectPath);
end;


{ THopePreferences }

procedure THopePreferences.AfterConstruction;
begin
  inherited;

  FEnvironment := THopePreferencesEnvironment.Create;
end;

procedure THopePreferences.BeforeDestruction;
begin
  FEnvironment.Free;

  inherited;
end;

procedure THopePreferences.ReadJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

  FEnvironment.LoadFromJson(JsonValue, True);
end;

procedure THopePreferences.WriteJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

  FEnvironment.SaveToJson(JsonValue);
end;

end.

