unit Hope.Project;

interface

{$I Hope.inc}

uses
  System.SysUtils, dwsJson, Hope.Common.JSON, Hope.Project.Interfaces,
  Hope.Project.Files, Hope.Project.Options;

type
  EHopeProject = class(Exception);

  THopeProject = class(THopeJsonBase, IProjectInterface)
  private
    FName: string;
    FCreateDateTime: TDateTime;
    FModifiedDateTime: TDateTime;
    FAuthor: string;
    FCompany: string;
    FDescription: string;
    FKeywords: string;
    FOptions: THopeProjectOptions;
    FUrl: string;
    FFileName: TFileName;
    FFiles: THopeProjectFiles;
    FMainScript: THopeProjectFile;
    function GetRootPath: string;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
  public
    procedure AfterConstruction; override;

    procedure LoadFromFile(const FileName: TFileName); override;
    procedure SaveToFile(const FileName: TFileName); override;

    procedure Clear;

    property RootPath: string read GetRootPath;
    property FileName: TFileName read FFileName;

    property Name: string read FName write FName;
    property CreateDateTime: TDateTime read FCreateDateTime write FCreateDateTime;
    property ModifiedDateTime: TDateTime read FModifiedDateTime write FModifiedDateTime;
    property Author: string read FAuthor write FAuthor;
    property Company: string read FCompany write FCompany;
    property Description: string read FDescription write FDescription;
    property Keywords: string read FKeywords write FKeywords;
    property Url: string read FUrl write FUrl;
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

  FOptions := THopeProjectOptions.Create;
  FFiles := THopeProjectFiles.Create;
  FMainScript := THopeProjectFile.Create;
end;

procedure THopeProject.Clear;
begin
  FCreateDateTime := Now;
  FModifiedDateTime := Now;
  FFiles.Clear;
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

procedure THopeProject.ReadJson(const JsonValue: TdwsJsonObject);
var
  FormatSetting: TFormatSettings;
begin
  Clear;

  FormatSetting := TFormatSettings.Create('en-US');

  FName := JsonValue.GetValue('Name', FName);
(*
  FCreateDateTime := StrToDateTime(JsonValue.GetValue('Create', DateTimeToStr(FCreateDateTime, FormatSetting)), FormatSetting);
  FModifiedDateTime := StrToDateTime(JsonValue.GetValue('Modified', DateTimeToStr(FModifiedDateTime, FormatSetting)), FormatSetting);
*)
  FAuthor := JsonValue.GetValue('Author', FAuthor);
  FCompany := JsonValue.GetValue('Company', FCompany);
  FDescription := JsonValue.GetValue('Description', FDescription);
  FKeywords := JsonValue.GetValue('Keywords', FKeywords);
  FUrl := JsonValue.GetValue('Url', FUrl);

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

  JsonValue.AddValue('Name', FName);
  JsonValue.AddValue('Create', DateTimeToStr(FCreateDateTime, FormatSetting));
  JsonValue.AddValue('Modified', DateTimeToStr(FModifiedDateTime, FormatSetting));
  JsonValue.AddValue('Author', FAuthor);
  JsonValue.AddValue('Company', FCompany);
  JsonValue.AddValue('Description', FDescription);
  JsonValue.AddValue('Keywords', FKeywords);
  JsonValue.AddValue('Url', FUrl);

  FOptions.SaveToJson(JsonValue);

  // project files
  JsonValue.AddValue('MainScript', FMainScript.FileName);
  FFiles.SaveToJson(JsonValue);
end;

end.

