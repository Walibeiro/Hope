unit Hope.Project.List;

interface

{$I Hope.inc}

uses
  System.Contnrs, System.Classes, System.SysUtils, dwsJson, Hope.Common.JSON,
  Hope.Project;

type
  EHopeProjectList = class(Exception);

  THopeProjectList = class(THopeJsonBase)
  private
    FProjects: TObjectList;
    FActiveProject: THopeProject;
    FOnActiveProjectChanged: TNotifyEvent;
    procedure SetActiveProject(const Value: THopeProject);
    function GetProject(Index: Integer): THopeProject;
    function GetProjectCount: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure AddProject(Project: THopeProject);
    procedure RemoveProject(Project: THopeProject);

    procedure LoadProject(ProjectFileName: TFileName);

    property Count: Integer read GetProjectCount;
    property Project[Index: Integer]: THopeProject read GetProject; default;
    property ActiveProject: THopeProject read FActiveProject write SetActiveProject;
    property OnActiveProjectChanged: TNotifyEvent read FOnActiveProjectChanged;
  end;

implementation

uses
  System.Types;

{ THopeProjectList }

procedure THopeProjectList.AfterConstruction;
begin
  inherited;
  FProjects := TObjectList.Create(True);
end;

procedure THopeProjectList.BeforeDestruction;
begin
  FProjects.Free;
  inherited;
end;

function THopeProjectList.GetProject(Index: Integer): THopeProject;
begin
  if (Index < 0) or (Index >= FProjects.Count) then
    raise Exception.CreateFmt('Index out of bounds (%d)', [Index]);

  Result := THopeProject(FProjects[Index]);
end;

function THopeProjectList.GetProjectCount: Integer;
begin
  Result := FProjects.Count;
end;

procedure THopeProjectList.LoadProject(ProjectFileName: TFileName);
var
  Project: THopeProject;
begin
  Project := THopeProject.Create;
  Project.LoadFromFile(ProjectFileName);

  AddProject(Project);
end;

procedure THopeProjectList.AddProject(Project: THopeProject);
begin
  FProjects.Add(Project);

  // eventually make active project
  if not Assigned(FActiveProject) then
    ActiveProject := Project;
end;

procedure THopeProjectList.RemoveProject(Project: THopeProject);
begin
  FProjects.Remove(Project);
  if Project = ActiveProject then
  begin
    if FProjects.Count > 0 then
      ActiveProject := THopeProject(FProjects[0])
    else
      ActiveProject := nil;
  end;
end;

procedure THopeProjectList.SetActiveProject(const Value: THopeProject);
begin
  if FActiveProject <> Value then
  begin
    FActiveProject := Value;
    if Assigned(OnActiveProjectChanged) then
      OnActiveProjectChanged(Self);
  end;
end;

procedure THopeProjectList.ReadJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

end;

procedure THopeProjectList.WriteJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

end;

end.

