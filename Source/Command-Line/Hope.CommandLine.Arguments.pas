unit Hope.CommandLine.Arguments;

interface

uses
  System.SysUtils, dwsUtils;

type
  TNameValuePair = record
    Name, Value: string;
  end;

  EHopeCommandLineArguments = class(Exception);

  THopeCommandLineArguments = class(TRefCountedObject)
  private
    FFileNames: array of string;
    FOptions: array of TNameValuePair;
    procedure AddFile(FileName: string);
    procedure AddOption(Item: string);
    function GetOption(Index: Integer): TNameValuePair;
    function GetOptionCount: Integer;
    function GetFileNames(Index: Integer): string;
    function GetFileNameCount: Integer;
  public
    constructor Create;

    function HasOption(Name: string): Boolean;
    function GetOptionValue(Name: string; out Value: string): Boolean;

    property FileName[Index: Integer]: string read GetFileNames;
    property FileNameCount: Integer read GetFileNameCount;

    property Option[Index: Integer]: TNameValuePair read GetOption;
    property OptionCount: Integer read GetOptionCount;
  end;

implementation

resourcestring
  RStrIndexOutOfBounds = 'Index out of bounds (%d)';


{ THopeCommandLineArguments }

constructor THopeCommandLineArguments.Create;
var
  Index: Integer;
  Item: string;
begin
  for Index := 0 to ParamCount - 1 do
  begin
    Item := ParamStr(Index + 1);
    if (Item[1] = '-') or (Item[1] = '/') then
    begin
      // remove '-' or '/'
      Delete(Item, 1, 1);
      AddOption(Item);
    end
    else
      AddFile(Item);
  end;
end;

function StripText(Text: string): string; inline;
begin
  Result := LowerCase(Trim(Text));
end;

procedure THopeCommandLineArguments.AddFile(FileName: string);
var
  ItemIndex: Integer;
begin
  ItemIndex := Length(FFilenames);
  SetLength(FFilenames, ItemIndex + 1);
end;

procedure THopeCommandLineArguments.AddOption(Item: string);
var
  ItemIndex: Integer;
  EqualPos: Integer;
begin
  ItemIndex := Length(FOptions);
  SetLength(FOptions, ItemIndex + 1);
  EqualPos := Pos('=', Item);
  if EqualPos >= 0 then
  begin
    FOptions[ItemIndex].Name := StripText(Copy(Item, 1, EqualPos - 1));
    FOptions[ItemIndex].Value := StripText(Copy(Item, EqualPos + 1, Length(Item) - EqualPos + 2));
  end
  else
    FOptions[ItemIndex].Name := StripText(Item);
end;

function THopeCommandLineArguments.GetFileNameCount: Integer;
begin
  Result := Length(FFileNames);
end;

function THopeCommandLineArguments.GetFileNames(Index: Integer): string;
begin
  if (Index < Low(FFileNames)) or (Index > High(FFileNames)) then
    raise EHopeCommandLineArguments.CreateFmt(RStrIndexOutOfBounds, [Index]);

  Result := FFileNames[Index];
end;

function THopeCommandLineArguments.GetOption(Index: Integer): TNameValuePair;
begin
  if (Index < Low(FOptions)) or (Index > High(FOptions)) then
    raise EHopeCommandLineArguments.CreateFmt(RStrIndexOutOfBounds, [Index]);

  Result := FOptions[Index];
end;

function THopeCommandLineArguments.GetOptionCount: Integer;
begin
  Result := Length(FOptions);
end;

function THopeCommandLineArguments.GetOptionValue(Name: string; out Value: string): Boolean;
var
  Index: Integer;
begin
  Result := False;
  Name := LowerCase(Name);
  for Index := Low(FOptions) to High(FOptions) do
    if Name = FOptions[Index].Name then
      Exit(True);
end;

function THopeCommandLineArguments.HasOption(Name: string): Boolean;
var
  Index: Integer;
begin
  Result := False;
  Name := LowerCase(Name);
  for Index := Low(FOptions) to High(FOptions) do
    if Name = FOptions[Index].Name then
      Exit(True);
end;

end.

