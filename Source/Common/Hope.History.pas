unit Hope.History;

{$I Hope.inc}

interface

uses
  System.Classes,

  dwsJson;

type
  THopeHistory = class
  private
    FProjectsHistory: TStringList;
    FUnitsHistory: TStringList;
  public
    procedure AfterConstruction; override;

    procedure Load;
    procedure Save;

    property ProjectsHistory: TStringList read FProjectsHistory;
    property UnitsHistory: TStringList read FUnitsHistory;
  end;

const
  CHistoryFileName = 'History.json';

implementation

uses
  System.SysUtils,
  dwsXPlatform;

{ THopeHistory }

procedure THopeHistory.AfterConstruction;
begin
  inherited;

  FProjectsHistory := TStringList.Create;
  FUnitsHistory := TStringList.Create;
end;

procedure THopeHistory.Load;
var
  Container: TdwsJsonObject;
  Value: TdwsJsonValue;
  Index: Integer;
begin
  // check if history exists
  if not FileExists(CHistoryFileName) then
    Exit;

  // read container object from file
  Value := TdwsJSONValue.ParseFile(CHistoryFileName);
  if not (Value is TdwsJSONObject) then
    Exit;
  Container := TdwsJSONObject(Value);

  // load projects
  Value := Container.Items['Projects'];
  if Value is TdwsJSONArray then
  begin
    FProjectsHistory.Clear;

    for Index := 0 to Value.ElementCount - 1 do
      FProjectsHistory.Add(Value.Elements[Index].AsString);
  end;

  // load units
  Value := Container.Items['Units'];
  if Value is TdwsJSONArray then
  begin
    FUnitsHistory.Clear;

    for Index := 0 to Value.ElementCount - 1 do
      FUnitsHistory.Add(Value.Elements[Index].AsString);
  end;
end;

procedure THopeHistory.Save;
var
  Container: TdwsJsonObject;
  ProjectsArray, UnitsArray: TdwsJsonArray;
  Value: TdwsJsonValue;
  Index: Integer;
begin
  // create container
  Container := TdwsJsonObject.Create;

  // create projects array
  ProjectsArray := Container.AddArray('Projects');
  for Index := 0 to FProjectsHistory.Count - 1 do
    ProjectsArray.Add(FProjectsHistory[Index]);

  // create units array
  UnitsArray := Container.AddArray('Units');
  for Index := 0 to FUnitsHistory.Count - 1 do
    UnitsArray.Add(FUnitsHistory[Index]);

  SaveTextToUTF8File(CHistoryFileName, Container.ToBeautifiedString);
end;

end.

