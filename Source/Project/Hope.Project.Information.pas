unit Hope.Project.Information;

interface

{$I Hope.inc}

uses
  Classes, dwsJson, Hope.Common.JSON;

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
    FKeywords: TStringList;
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
    property Keywords: TStringList read FKeywords;
  end;

  THopeProjectVersion = class(THopeJsonBase)
  private
    FMajor: Integer;
    FMinor: Integer;
    FRelease: Integer;
    FBuild: Integer;
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
  FKeywords := TStringList.Create;
end;

procedure THopeProjectInformation.BeforeDestruction;
begin
  inherited;

  FKeywords.Free;
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
  JsonValue.GetStringList('Keywords', FKeywords);
end;

procedure THopeProjectInformation.WriteJson(const JsonValue: TdwsJsonObject);
var
  Index: Integer;
  KeywordArray: TdwsJSONArray;
begin
  JsonValue.AddValue('Name', FName);
  JsonValue.AddValue('Description', FDescription);
  FAuthor.SaveToJson(JsonValue);
  if FKeywords.Count > 0 then
  begin
    KeywordArray := JsonValue.AddArray('Keywords');
    for Index := 0 to FKeywords.Count - 1 do
      KeywordArray.Add(FKeywords[Index]);
  end;
end;


{ THopeProjectVersion }

procedure THopeProjectVersion.AfterConstruction;
begin
  inherited;

  FMajor := 0;
  FMinor := 0;
  FRelease := 0;
  FBuild := 0;
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
end;

procedure THopeProjectVersion.WriteJson(
  const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('Major', FMajor);
  JsonValue.AddValue('Minor', FMinor);
  JsonValue.AddValue('Release', FRelease);
  JsonValue.AddValue('Build', FBuild);
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

  if FFileName <> '' then
    JsonValue.AddValue('FileName', FFileName);
end;

end.
