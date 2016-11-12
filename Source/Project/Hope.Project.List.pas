unit Hope.Project.List;

interface

{$I Hope.inc}

uses
  System.Contnrs, System.Classes, System.SysUtils, dwsJson, Hope.Common.JSON,
  Hope.Project, Hope.Project.Interfaces;

type
  EHopeProjectList = class(Exception);

  THopeProjectList = class(THopeJsonBase, IProjectListInterface)
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
    class function GetProjectClass: THopeProjectClass; virtual;

    property ProjectClass: THopeProjectClass read GetProjectClass;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure Clear;

    procedure AddProject(Project: THopeProject);
    procedure RemoveProject(Project: THopeProject);

    function IsProjectLoaded(ProjectFileName: TFileName): Boolean;
    function LoadProject(ProjectFileName: TFileName): Boolean;

    property Count: Integer read GetProjectCount;
    property Project[Index: Integer]: THopeProject read GetProject; default;
    property ActiveProject: THopeProject read FActiveProject write SetActiveProject;
    property OnActiveProjectChanged: TNotifyEvent read FOnActiveProjectChanged;
  end;

implementation

uses
  System.Types, dwsUtils;

{ THopeProjectList }

procedure THopeProjectList.AfterConstruction;
begin
  inherited;

  // create object list
  FProjects := TObjectList.Create(True);
end;

procedure THopeProjectList.BeforeDestruction;
begin
  FProjects.Free;

  inherited;
end;

procedure THopeProjectList.Clear;
begin
  FProjects.Clear;
end;

function THopeProjectList.GetProject(Index: Integer): THopeProject;
begin
  if (Index < 0) or (Index >= FProjects.Count) then
    raise Exception.CreateFmt('Index out of bounds (%d)', [Index]);

  Result := THopeProject(FProjects[Index]);
end;

class function THopeProjectList.GetProjectClass: THopeProjectClass;
begin
  Result := THopeProject;
end;

function THopeProjectList.GetProjectCount: Integer;
begin
  Result := FProjects.Count;
end;

function THopeProjectList.IsProjectLoaded(ProjectFileName: TFileName): Boolean;
var
  Index: Integer;
begin
  Result := False;

  // scan all projects in this list
  for Index := 0 to FProjects.Count - 1 do
    if UnicodeSameText(ProjectFileName, THopeProject(FProjects[Index]).FileName) then
      Exit(True);
end;

function THopeProjectList.LoadProject(ProjectFileName: TFileName): Boolean;
var
  Project: THopeProject;
begin
  // check if project is already present
  if IsProjectLoaded(ProjectFileName) then
    Exit(False);

  // create and load project
  Project := ProjectClass.Create;
  Project.LoadFromFile(ProjectFileName);

  // add project to the project list
  AddProject(Project);
  Result := True;
end;

procedure THopeProjectList.AddProject(Project: THopeProject);
begin
  // add project to the project list
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
