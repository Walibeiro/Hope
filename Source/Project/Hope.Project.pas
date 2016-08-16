unit Hope.Project;

interface

{$I Hope.inc}

uses
  dwsJson, Hope.Common.JSON, Hope.Project.Files, Hope.Project.Options;

type
  THopeProject = class(THopeJsonBase)
  private
    FName: string;
    FCreate: TDateTime;
    FModified: TDateTime;
    FAuthor: string;
    FCompany: string;
    FDescription: string;
    FKeywords: string;
    FOptions: THopeProjectOptions;
    FUrl: string;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
  public
    procedure AfterConstruction; override;

    property Name: string read FName write FName;
    property Create: TDateTime read FCreate write FCreate;
    property Modified: TDateTime read FModified write FModified;
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
  FOptions := THopeProjectOptions.Create;
//  FFiles := THopeProjectFiles.Create;
end;

procedure THopeProject.ReadJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

end;

procedure THopeProject.WriteJson(const JsonValue: TdwsJsonObject);
begin
  inherited;

end;

end.

