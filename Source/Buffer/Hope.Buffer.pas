unit Hope.Buffer;

interface

{$I Hope.inc}

uses
  System.SysUtils;

type
  THopeBuffer = class
  private
    FFileName: TFileName;
    FUnitNameHash: Cardinal;
    FText: string;
    FModified: Boolean;
    procedure SetText(const Value: string);
    procedure SetFileName(const Value: TFileName);
  protected
    procedure FileNameChanged;
  public
    procedure Reload;

    property Text: string read FText write SetText;
    property FileName: TFileName read FFileName write SetFileName;
    property UnitNameHash: Cardinal read FUnitNameHash;
    property Modified: Boolean read FModified;
  end;

implementation

uses
  dwsUtils, dwsXPlatform, Hope.Common.FileUtilities;

{ THopeBuffer }

procedure THopeBuffer.SetFileName(const Value: TFileName);
begin
  if FFileName <> Value then
  begin
    FFileName := Value;
    FileNameChanged;
  end;
end;

procedure THopeBuffer.SetText(const Value: String);
begin
  FText := Value;
  FModified := True;
end;

procedure THopeBuffer.FileNameChanged;
begin
  // calculate a hash of the unit name (for faster indexing)
  FUnitNameHash := CalculateUnitHash(FFileName);

  // reload file content
  Reload;
end;

procedure THopeBuffer.Reload;
begin
  FText := LoadTextFromFile(FFileName);
  FModified := False;
end;

end.
