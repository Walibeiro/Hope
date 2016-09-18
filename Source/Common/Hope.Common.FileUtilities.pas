unit Hope.Common.FileUtilities;

interface

uses
  System.SysUtils, System.Classes;

function ExtractUnitName(const FileName: TFileName): string;
function CalculateUnitHash(const FileName: TFileName): Cardinal;
procedure CollectFiles(const Directory: string;
  Extensions: array of String; FileList: TStrings;
  RecurseSubdirectories: Boolean = False);

implementation

uses
  WinApi.Windows, dwsUtils, dwsXPlatform;

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

type
  TFindDataRec = record
    Handle : THandle;
    Data : TWin32FindData;
  end;

procedure CollectFiles(const Directory: string;
  Extensions: array of String; FileList: TStrings;
  RecurseSubdirectories: Boolean = False);
var
  SearchRec: TFindDataRec;
  InfoLevel: TFindexInfoLevels;
  FileName: String;
begin
  if ((Win32MajorVersion shl 8) or Win32MinorVersion) >= $601 then
    InfoLevel := TFindexInfoLevels(1)
  else
    InfoLevel := FindExInfoStandard;

  FileName := Directory + '*';
  SearchRec.Handle := FindFirstFileEx(PChar(Pointer(FileName)), InfoLevel,
    @SearchRec.Data, FINDEX_SEARCH_OPS.FindExSearchNameMatch, nil, 0);

  if SearchRec.Handle<>INVALID_HANDLE_VALUE then
  begin
    repeat
      if (SearchRec.Data.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
      begin
          // check file against mask
          FileName:=SearchRec.Data.cFileName;
          FileList.Add(FileName);
          // todo: mask
      end
      else
      if RecurseSubdirectories then
      begin
        // dive in subdirectory
        if SearchRec.Data.cFileName[0]='.' then
        begin
          if SearchRec.Data.cFileName[1]='.' then
            if SearchRec.Data.cFileName[2]=#0 then Continue else
          else
            if SearchRec.Data.cFileName[1]=#0 then continue;
        end;

        FileName := SearchRec.Data.cFileName;
        FileName := Directory + FileName + PathDelim;
        CollectFiles(FileName, Extensions, FileList, True);
       end;
    until not FindNextFile(SearchRec.Handle, SearchRec.Data);
    FindClose(SearchRec.Handle);
  end;
end;

end.
