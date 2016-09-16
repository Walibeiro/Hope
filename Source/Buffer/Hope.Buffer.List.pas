unit Hope.Buffer.List;

interface

{$I Hope.inc}

// TODO: change implementation to something like used in TNameObjectHash

uses
  System.Contnrs, System.SysUtils, dwsUtils, Hope.Buffer;

type
  THopeBufferList = class
  private
    FList: TObjectList;
    function GetCount: Integer;
    function GetItem(Index: Integer): THopeBuffer;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure Add(FileName: TFileName);
    procedure Remove(FileName: TFileName);
    function Contains(FileName: TFileName): Boolean;
    function IndexOf(FileName: TFileName): Integer;
    function IndexOfUnit(UnitName: string): Integer;

    property Items[Index: Integer]: THopeBuffer read GetItem; default;
    property Count: Integer read GetCount;
  end;

implementation

uses
  Hope.Common.FileUtilities;

{ THopeBufferList }

procedure THopeBufferList.AfterConstruction;
begin
  inherited;

  FList := TObjectList.Create(True);
end;

procedure THopeBufferList.BeforeDestruction;
begin
  FList.Free;

  inherited;
end;

function THopeBufferList.Contains(FileName: TFileName): Boolean;
begin
  Result := IndexOf(FileName) > -1;
end;

function THopeBufferList.IndexOf(FileName: TFileName): Integer;
var
  Index: Integer;
begin
  Result := -1;
  for Index := 0 to FList.Count - 1 do
    if UnicodeSameText(THopeBuffer(FList[Index]).FileName, FileName) then
      Exit(Index);
end;

function THopeBufferList.IndexOfUnit(UnitName: string): Integer;
var
  Index: Integer;
  UnitNameHash: Cardinal;
  FileUnitName: string;
begin
  Result := -1;

  // calculate unit hash for current file
  UnitNameHash := CalculateUnitHash(UnitName);

  for Index := 0 to FList.Count - 1 do
    if UnitNameHash = THopeBuffer(FList[Index]).UnitNameHash then
    begin
      FileUnitName := ExtractUnitName(THopeBuffer(FList[Index]).FileName);
      if UnicodeSameText(UnitName, THopeBuffer(FList[Index]).FileName) then
        Exit(Index);
    end;
end;

procedure THopeBufferList.Add(FileName: TFileName);
var
  Buffer: THopeBuffer;
begin
  Buffer := THopeBuffer.Create;
  Buffer.FileName := FileName;

  FList.Add(Buffer);
end;

procedure THopeBufferList.Remove(FileName: TFileName);
var
  Index: Integer;
begin
  Index := IndexOf(FileName);
  FList.Delete(Index);
end;

function THopeBufferList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function THopeBufferList.GetItem(Index: Integer): THopeBuffer;
begin
  if (Index < 0) or (Index >= FList.Count) then
    raise Exception.CreateFmt('Index out of bounds (%d)', [Index]);

  Result := THopeBuffer(FList[Index]);
end;

end.
