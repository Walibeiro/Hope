unit Hope.Project;

interface

{$I Hope.inc}

uses
  System.SysUtils, dwsJson, Hope.Common.JSON, Hope.Project.Interfaces,
  Hope.Project.Files, Hope.Project.Information, Hope.Project.Options;

type
  EHopeProject = class(Exception);

  THopeProject = class(THopeJsonBase, IProjectInterface)
  private
    FCreateDateTime: TDateTime;
    FModifiedDateTime: TDateTime;
    FInformation: THopeProjectInformation;
    FVersion: THopeProjectVersion;
    FIcon: THopeProjectIcon;
    FOptions: THopeProjectOptions;
    FFileName: TFileName;
    FFiles: THopeProjectFiles;
    FMainScript: THopeProjectFile;
    function GetRootPath: string;
    function GetName: string;
    procedure SetName(const Value: string);
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure LoadFromFile(const FileName: TFileName); override;
    procedure SaveToFile(const FileName: TFileName); override;

    procedure Clear;

    property RootPath: string read GetRootPath;
    property FileName: TFileName read FFileName;

    property Name: string read GetName write SetName;
    property Information: THopeProjectInformation read FInformation;
    property Version: THopeProjectVersion read FVersion;
    property Icon: THopeProjectIcon read FIcon;
    property Options: THopeProjectOptions read FOptions;
    property MainScript: THopeProjectFile read FMainScript;
    property Files: THopeProjectFiles read FFiles;
  end;
  THopeProjectClass = class of THopeProject;

implementation


{ THopeProject }

procedure THopeProject.AfterConstruction;
begin
  inherited;

  FInformation := THopeProjectInformation.Create;
  FVersion := THopeProjectVersion.Create;
  FIcon := THopeProjectIcon.Create;
  FOptions := THopeProjectOptions.Create;
  FFiles := THopeProjectFiles.Create(Self);
  FMainScript := THopeProjectFile.Create;
end;

procedure THopeProject.BeforeDestruction;
begin
  FMainScript.Free;
  FFiles.Free;
  FOptions.Free;
  FIcon.Free;
  FVersion.Free;
  FInformation.Free;

  inherited;
end;

procedure THopeProject.Clear;
begin
  FCreateDateTime := Now;
  FModifiedDateTime := Now;
  FFiles.Clear;
end;

function THopeProject.GetName: string;
begin
  Result := FInformation.Name;
end;

function THopeProject.GetRootPath: string;
begin
  Result := '';
  if FFileName <> '' then
    Result := ExtractFilePath(FFileName);

  if IsRelativePath(Result) then
    Result := ExpandFileName(ExtractFilePath(ParamStr(0)) + Result);
end;

procedure THopeProject.LoadFromFile(const FileName: TFileName);
begin
  FFileName := FileName;
  inherited;
end;

procedure THopeProject.SaveToFile(const FileName: TFileName);
begin
  FFileName := FileName;
  inherited;
end;

procedure THopeProject.SetName(const Value: string);
begin
  FInformation.Name := Value;
end;

procedure THopeProject.ReadJson(const JsonValue: TdwsJsonObject);
var
  FormatSetting: TFormatSettings;
begin
  Clear;

  FormatSetting := TFormatSettings.Create('en-US');

  FInformation.LoadFromJson(JsonValue, True);
  FVersion.LoadFromJson(JsonValue, True);
  FIcon.LoadFromJson(JsonValue, True);
  FOptions.LoadFromJson(JsonValue);

  // project files
  if not Assigned(JsonValue.Items['MainScript']) then
    raise EHopeProject.Create('MainScript is not specified');
  FMainScript.FileName := JsonValue.GetValue('MainScript', '');
  FFiles.LoadFromJson(JsonValue);
end;

procedure THopeProject.WriteJson(const JsonValue: TdwsJsonObject);
var
  FormatSetting: TFormatSettings;
begin
  FormatSetting := TFormatSettings.Create('en-US');

  FInformation.SaveToJson(JsonValue);
  FVersion.SaveToJson(JsonValue);
  FIcon.SaveToJson(JsonValue);
  FOptions.SaveToJson(JsonValue);

  // project files
  JsonValue.AddValue('MainScript', FMainScript.FileName);
  FFiles.SaveToJson(JsonValue);
end;

end.

