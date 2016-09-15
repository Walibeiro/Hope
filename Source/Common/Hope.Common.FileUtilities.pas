unit Hope.Common.FileUtilities;

interface

uses
  System.SysUtils;

function ExtractUnitName(FileName: TFileName): string;

implementation

uses
  dwsUtils;

function ExtractUnitName(FileName: TFileName): string;
begin
  Result := ExtractFileName(FileName);
  if StrEndsWith(Result, '.pas') then
    Delete(Result, Length(Result) - 3, 4);
end;

end.

