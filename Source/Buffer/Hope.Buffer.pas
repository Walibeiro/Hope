unit Hope.Buffer;

interface

uses
  System.SysUtils;

type
  THopeBuffer = class
  private
    FFileName: TFileName;
    FUnitNameHash: Cardinal;
    FText: string;
    procedure SetText(const Value: string);
    procedure SetFileName(const Value: TFileName);
  protected
    procedure FileNameChanged;
  public
    property Text: string read FText write SetText;
    property FileName: TFileName read FFileName write SetFileName;
    property UnitNameHash: Cardinal read FUnitNameHash;
  end;

implementation

uses
  dwsUtils, Hope.Common.FileUtilities;

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
end;

procedure THopeBuffer.FileNameChanged;
var
  FileUnitName: string;
begin
  FileUnitName := ExtractUnitName(FFileName);
  FUnitNameHash := SimpleLowerCaseStringHash(FileUnitName);
end;

end.
