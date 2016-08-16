unit Hope.CommandLine.Arguments;

interface

uses
  dwsUtils;

type
  THopeCommandLineArguments = class(TRefCountedObject)
  private
    FInputFilename: string;
    FOutputFilename: string;
  public
    constructor Create;

    property InputFilename: string read FInputFilename;
    property OutputFilename: string read FOutputFilename;
  end;

implementation


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
    end
    else
    begin
      // specify filenames
      if InputFilename = '' then
        FInputFilename := Item
      else
      if OutputFilename = '' then
        FOutputFilename := Item
    end;
  end;

  if FOutputFilename = '' then
    FOutputFilename := FInputFilename + '.js';
end;

end.

