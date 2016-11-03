unit Hope.Common.History;

{$I Hope.inc}

interface

uses
  System.Classes, dwsJson, Hope.Common.JSON;

type
  THopeHistory = class(THopeJsonBase)
  private
    FProjectsHistory: TStringList;
    FUnitsHistory: TStringList;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
  public
    procedure AfterConstruction; override;

    procedure AddProject(FileName: string);
    procedure AddUnit(FileName: string);

    property ProjectsHistory: TStringList read FProjectsHistory;
    property UnitsHistory: TStringList read FUnitsHistory;
  end;

implementation

uses
  System.SysUtils,
  dwsXPlatform;

{ THopeHistory }

procedure THopeHistory.AfterConstruction;
begin
  inherited;

  // create lists (not case sensitive)
  FProjectsHistory := TStringList.Create;
  FProjectsHistory.CaseSensitive := False;
  FUnitsHistory := TStringList.Create;
  FUnitsHistory.CaseSensitive := False;
end;

procedure THopeHistory.AddProject(FileName: string);
var
  Index: Integer;
begin
  Index := FProjectsHistory.IndexOf(FileName);

  if Index < 0 then
    FProjectsHistory.Add(FileName)
  else
    FProjectsHistory.Move(Index, 0);
end;

procedure THopeHistory.AddUnit(FileName: string);
var
  Index: Integer;
begin
  Index := FUnitsHistory.IndexOf(FileName);

  if Index < 0 then
    FUnitsHistory.Add(FileName)
  else
    FUnitsHistory.Move(Index, 0);
end;

procedure THopeHistory.ReadJson(const JsonValue: TdwsJSONObject);
var
  Value: TdwsJsonValue;
  Index: Integer;
begin
  // load projects
  Value := JsonValue.Items['Projects'];
  if Value is TdwsJSONArray then
  begin
    FProjectsHistory.Clear;

    for Index := 0 to Value.ElementCount - 1 do
      FProjectsHistory.Add(Value.Elements[Index].AsString);
  end;

  // load units
  Value := JsonValue.Items['Units'];
  if Value is TdwsJSONArray then
  begin
    FUnitsHistory.Clear;

    for Index := 0 to Value.ElementCount - 1 do
      FUnitsHistory.Add(Value.Elements[Index].AsString);
  end;
end;

procedure THopeHistory.WriteJson(const JsonValue: TdwsJSONObject);
var
  ProjectsArray, UnitsArray: TdwsJsonArray;
  Index: Integer;
begin
  // create projects array
  ProjectsArray := JsonValue.AddArray('Projects');
  for Index := 0 to FProjectsHistory.Count - 1 do
    ProjectsArray.Add(FProjectsHistory[Index]);

  // create units array
  UnitsArray := JsonValue.AddArray('Units');
  for Index := 0 to FUnitsHistory.Count - 1 do
    UnitsArray.Add(FUnitsHistory[Index]);
end;

end.

