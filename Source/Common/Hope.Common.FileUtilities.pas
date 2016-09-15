unit Hope.Common.FileUtilities;

interface

uses
  System.SysUtils;

function ExtractUnitName(const FileName: TFileName): string;
function CalculateUnitHash(const FileName: TFileName): Cardinal;

implementation

uses
  dwsUtils;

function ExtractUnitName(const FileName: TFileName): string;
begin
  Result := ExtractFileName(FileName);
  if StrEndsWith(Result, '.pas') then
    Delete(Result, Length(Result) - 3, 4);
end;

function CalculateUnitHash(const FileName: TFileName): Cardinal;
var
  FileUnitName: string;
begin
  FileUnitName := ExtractUnitName(FileName);
  Result := SimpleLowerCaseStringHash(FileUnitName);
end;

end.
