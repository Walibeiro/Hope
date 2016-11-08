unit Hope.Project.Local;

interface

{$I Hope.inc}

uses
  System.SysUtils, System.Classes, System.Contnrs, dwsJSON, Hope.Common.JSON;

type
  THopeBookmark = class(THopeJsonBase)
  private
    FID: Integer;
    FLine: Integer;
    FCharacter: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    constructor Create; overload;
    constructor Create(const ID, Line, Character: Integer); overload;

    property ID: Integer read FID write FID;
    property Line: Integer read FLine write FLine;
    property Character: Integer read FCharacter write FCharacter;
  end;

  THopeOpenedFile = class(THopeJsonBase)
  private
    FFileName: TFileName;
    FLine: Integer;
    FCharacter: Integer;
    FTopLine: Integer;
    FBookmarks: TObjectList;
    function GetBookmark(Index: Integer): THopeBookmark;
    function GetBookmarkCount: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property FileName: TFileName read FFileName write FFileName;
    property Line: Integer read FLine write FLine;
    property Character: Integer read FCharacter write FCharacter;
    property TopLine: Integer read FTopLine write FTopLine;

    property Bookmarks: TObjectList read FBookmarks;
    property Bookmark[Index: Integer]: THopeBookmark read GetBookmark;
    property BookmarkCount: Integer read GetBookmarkCount;
  end;

  THopeLocal = class(THopeJsonBase)
  private
    FOpenedFiles: TObjectList;
    FActiveFileName: TFileName;
    function GetCount: Integer;
    function GetOpenedFile(Index: Integer): THopeOpenedFile;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property OpenedFiles: TObjectList read FOpenedFiles;
    property OpenedFile[Index: Integer]: THopeOpenedFile read GetOpenedFile;
    property ActiveFileName: TFileName read FActiveFileName write FActiveFileName;
    property Count: Integer read GetCount;
  end;

implementation


{ THopeBookmark }

constructor THopeBookmark.Create;
begin
  inherited Create;

  FID := -1;
end;

constructor THopeBookmark.Create(const ID, Line, Character: Integer);
begin
  inherited Create;

  FID := ID;
  FLine := Line;
  FCharacter := Character;
end;

class function THopeBookmark.GetPreferredName: string;
begin
  Result := 'Bookmark';
end;

procedure THopeBookmark.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FID := JsonValue.GetValue('ID', FID);
  FLine := JsonValue.GetValue('Line', FLine);
  FCharacter := JsonValue.GetValue('Character', FCharacter);
end;

procedure THopeBookmark.WriteJson(const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('ID', FID);
  JsonValue.AddValue('Line', FLine);
  JsonValue.AddValue('Character', FCharacter);
end;


{ THopeOpenedFile }

procedure THopeOpenedFile.AfterConstruction;
begin
  inherited;

  FBookmarks := TObjectList.Create(True);
end;

procedure THopeOpenedFile.BeforeDestruction;
begin
  inherited;

  FBookmarks.Free;
end;

class function THopeOpenedFile.GetPreferredName: string;
begin
  Result := 'File';
end;

function THopeOpenedFile.GetBookmark(Index: Integer): THopeBookmark;
begin
  if (Index < 0) or (Index >= FBookmarks.Count) then
    raise Exception.CreateFmt('Index out of bounds (%d)', [Index]);

  Result := THopeBookmark(FBookmarks.Items[Index]);
end;

function THopeOpenedFile.GetBookmarkCount: Integer;
begin
  Result := FBookmarks.Count;
end;

procedure THopeOpenedFile.ReadJson(const JsonValue: TdwsJSONObject);
var
  BookmarksArray: TdwsJSONArray;
  Index: Integer;
  Bookmark: THopeBookmark;
begin
  FFileName := JsonValue.GetValue('Name', FFileName);
  FLine := JsonValue.GetValue('Line', FLine);
  FCharacter := JsonValue.GetValue('Character', FCharacter);

  FBookmarks.Clear;
  if JsonValue.GetArray('Bookmarks', BookmarksArray) then
    for Index := 0 to BookmarksArray.ElementCount - 1 do
    begin
      Bookmark := THopeBookmark.Create;
      Assert(BookmarksArray.Elements[Index] is TdwsJSONObject);
      Bookmark.ReadJson(TdwsJSONObject(BookmarksArray.Elements[Index]));
      FBookmarks.Add(Bookmark);
    end;
end;

procedure THopeOpenedFile.WriteJson(const JsonValue: TdwsJSONObject);
var
  BookmarksArray: TdwsJSONArray;
  Index: Integer;
  Bookmark: TdwsJSONObject;
begin
  JsonValue.AddValue('Name', FFileName);
  JsonValue.AddValue('Line', FLine);
  JsonValue.AddValue('Character', FCharacter);

  BookmarksArray := JsonValue.AddArray('Bookmarks');
  for Index := 0 to FBookmarks.Count - 1 do
  begin
    Bookmark := BookmarksArray.AddObject;
    THopeBookmark(FBookmarks[Index]).WriteJson(Bookmark);
  end;
end;


{ THopeLocal }

procedure THopeLocal.AfterConstruction;
begin
  inherited;

  FOpenedFiles := TObjectList.Create(True);
end;

procedure THopeLocal.BeforeDestruction;
begin
  inherited;

  FOpenedFiles.Free;
end;

function THopeLocal.GetCount: Integer;
begin
  Result := FOpenedFiles.Count;
end;

function THopeLocal.GetOpenedFile(Index: Integer): THopeOpenedFile;
begin
  if (Index < 0) or (Index >= FOpenedFiles.Count) then
    raise Exception.CreateFmt('Index out of bounds (%d)', [Index]);

  Result := THopeOpenedFile(FOpenedFiles.Items[Index]);
end;

procedure THopeLocal.ReadJson(const JsonValue: TdwsJSONObject);
var
  FilesArray: TdwsJSONArray;
  Index: Integer;
  OpenedFile: THopeOpenedFile;
begin
  FOpenedFiles.Clear;
  if JsonValue.GetArray('Files', FilesArray) then
    for Index := 0 to FilesArray.ElementCount - 1 do
    begin
      OpenedFile := THopeOpenedFile.Create;
      Assert(FilesArray.Elements[Index] is TdwsJSONObject);
      OpenedFile.ReadJson(TdwsJSONObject(FilesArray.Elements[Index]));
      FOpenedFiles.Add(OpenedFile);
    end;
  FActiveFileName := JsonValue.GetValue('ActiveFile', FActiveFileName);
end;

procedure THopeLocal.WriteJson(const JsonValue: TdwsJSONObject);
var
  FilesArray: TdwsJSONArray;
  Index: Integer;
  OpenedFile: TdwsJSONObject;
begin
  FilesArray := JsonValue.AddArray('Files');
  for Index := 0 to FOpenedFiles.Count - 1 do
  begin
    OpenedFile := FilesArray.AddObject;
    THopeOpenedFile(FOpenedFiles[Index]).WriteJson(OpenedFile);
  end;
  JsonValue.AddValue('ActiveFile', FActiveFileName);
end;

end.
