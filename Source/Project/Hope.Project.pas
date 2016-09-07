unit Hope.Project;

interface

{$I Hope.inc}

uses
  System.SysUtils, dwsJson, Hope.Common.JSON, Hope.Project.Files,
  Hope.Project.Options;

type
  THopeProject = class(THopeJsonBase)
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
    FFileName: string;
    FFiles: THopeProjectFiles;
    function GetRootPath: string;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
  public
    procedure AfterConstruction; override;

    procedure LoadFromFile(const FileName: TFileName); override;
    procedure SaveToFile(const FileName: TFileName); override;

    property RootPath: string read GetRootPath;

    property Name: string read FName write FName;
    property CreateDateTime: TDateTime read FCreateDateTime write FCreateDateTime;
    property ModifiedDateTime: TDateTime read FModifiedDateTime write FModifiedDateTime;
    property Author: string read FAuthor write FAuthor;
    property Company: string read FCompany write FCompany;
    property Description: string read FDescription write FDescription;
    property Keywords: string read FKeywords write FKeywords;
    property Url: string read FUrl write FUrl;
    property Options: THopeProjectOptions read FOptions;
  end;

implementation


{ THopeProject }

procedure THopeProject.AfterConstruction;
begin
  inherited;

  FCreateDateTime := Now;
  FModifiedDateTime := Now;

  FOptions := THopeProjectOptions.Create;
  FFiles := THopeProjectFiles.Create;
end;

function THopeProject.GetRootPath: string;
begin
  Result := '';
  if FFileName <> '' then
    Result := ExtractFilePath(FFileName);
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
  FormatSetting := TFormatSettings.Create('en-US');

  FName := JsonValue.GetValue('Name', FName);
  FCreateDateTime := StrToDateTime(JsonValue.GetValue('Create', DateTimeToStr(FCreateDateTime, FormatSetting)), FormatSetting);
  FModifiedDateTime := StrToDateTime(JsonValue.GetValue('Modified', DateTimeToStr(FModifiedDateTime, FormatSetting)), FormatSetting);
  FAuthor := JsonValue.GetValue('Author', FAuthor);
  FCompany := JsonValue.GetValue('Company', FCompany);
  FDescription := JsonValue.GetValue('Description', FDescription);
  FKeywords := JsonValue.GetValue('Keywords', FKeywords);
  FUrl := JsonValue.GetValue('Url', FUrl);

  FOptions.LoadFromJson(JsonValue);
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
end;

end.

