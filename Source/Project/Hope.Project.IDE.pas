unit Hope.Project.IDE;

interface

{$I Hope.inc}

uses
  System.SysUtils, System.Classes, System.Contnrs, Vcl.ExtCtrls, dwsJSON,
  Hope.Project, Hope.Project.List, Hope.Project.Local, Hope.Project.Statistics;

type
  THopeProjectStatistics = class(TCustomProjectStatistics)
  strict private
    function GetTotalTime: TDateTime;
    procedure SetRunning(const Value: Boolean);
  private
    FIsRunning: Boolean;
    FRunningTimeStamp: TDateTime;
    FEditTimeStamp: TDateTime;
    FTimeStamp: TDateTime;
    FEditTimer: TTimer;

    FCurrentSession: TProjectStatisticSession;
    FSessions: TObjectList;
    function GetRunningTime: TDateTime;
    function GetEditTime: TDateTime;
    procedure FlushTimes;
    procedure EditTimeOut(Sender: TObject);
    function GetTotalLinesOfCode: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure Clear; override;

    procedure Suspend;
    procedure Resume;

    procedure LogEditing;
    procedure AdvanceBackgroundCompilations; override;
    procedure AddCompileTime(Duration: TDateTime);

    property TotalTime: TDateTime read GetTotalTime;
    property EditTime: TDateTime read GetEditTime;
    property RunningTime: TDateTime read GetRunningTime;
    property Running: Boolean read FIsRunning write SetRunning;
    property Sessions: TObjectList read FSessions;
  end;

  THopeProjectIDE = class(THopeProject)
  private
    FLocal: THopeLocal;
    FStatistics: THopeProjectStatistics;
    procedure RecallFromLocalFile;
    procedure StoreToLocalFile;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure LoadFromFile(const FileName: TFileName); override;
    procedure SaveToFile(const FileName: TFileName); override;

    procedure SaveLocalFile;
  end;

  THopeProjectListIDE = class(THopeProjectList)
  private
    function GetActiveProject: THopeProjectIDE;
  protected
    class function GetProjectClass: THopeProjectClass; override;
  public
    procedure CloseProjects;
    procedure SaveLocalFiles;

    property ActiveProjectIDE: THopeProjectIDE read GetActiveProject;
  end;

implementation

uses
  Hope.Main, Hope.Editor, Hope.Common.JSON, SynEditTypes;

{ THopeProjectStatistics }

procedure THopeProjectStatistics.AfterConstruction;
begin
  inherited;

  FTimeStamp := Now;
  FEditTimer := TTimer.Create(nil);
  FEditTimer.Enabled := False;
  FEditTimer.Interval := 2500;
  FEditTimer.OnTimer := EditTimeOut;

  FSessions := TObjectList.Create;
  FCurrentSession := TProjectStatisticSession.Create;
end;

procedure THopeProjectStatistics.BeforeDestruction;
begin
  inherited;

  FSessions.Free;
  FCurrentSession.Free;
  FEditTimer.Free;
end;

procedure THopeProjectStatistics.Clear;
begin
  inherited;
  FTimeStamp := Now;
  FIsRunning := False;

  FSessions.Clear;
end;

procedure THopeProjectStatistics.FlushTimes;
var
  Delta: Single;
  CurrentLOC: Integer;
begin
  // update total time
  Delta := Now - FTimeStamp;
  Advance(stTotal, Delta);
  FCurrentSession.Advance(stTotal, Delta);
  FTimeStamp := Now;

  // eventually update running time
  if FIsRunning then
  begin
    Delta := Now - FRunningTimeStamp;
    Advance(stRun, Delta);
    FCurrentSession.Advance(stRun, Delta);
    FRunningTimeStamp := Now;
  end;

  if FEditTimer.Enabled then
  begin
    Delta := Now - FEditTimeStamp;
    Advance(stEdit, Delta);
    FCurrentSession.Advance(stEdit, Delta);
    FEditTimeStamp := Now;
  end;

  CurrentLOC := GetTotalLinesOfCode;
  FCurrentSession.AdvanceLinesOfCode(CurrentLOC - FTotalLinesOfCode);
  FTotalLinesOfCode := CurrentLOC;
end;

function THopeProjectStatistics.GetTotalLinesOfCode: Integer;
begin
  // TODO
  Result := 0;
end;

function THopeProjectStatistics.GetEditTime: TDateTime;
begin
  if FEditTimer.Enabled then
    Result := FTimes[stEdit] + Now - FEditTimeStamp
  else
    Result := FTimes[stEdit];
end;

function THopeProjectStatistics.GetRunningTime: TDateTime;
begin
  if FIsRunning then
    Result := FTimes[stRun] + Now - FRunningTimeStamp
  else
    Result := FTimes[stRun];
end;

function THopeProjectStatistics.GetTotalTime: TDateTime;
begin
  Result := FTimes[stTotal] + Now - FTimeStamp;
end;

procedure THopeProjectStatistics.AddCompileTime(Duration: TDateTime);
begin
  FTimes[stCompile] := FTimes[stCompile] + Duration;
  FCurrentSession.Advance(stCompile, Duration);
end;

procedure THopeProjectStatistics.AdvanceBackgroundCompilations;
begin
  inherited;

  FCurrentSession.AdvanceBackgroundCompilations;
end;

procedure THopeProjectStatistics.LogEditing;
begin
  if FEditTimer.Enabled then
    FEditTimer.Enabled := False
  else
    FEditTimeStamp := Now;

  FEditTimer.Enabled := True;
end;

procedure THopeProjectStatistics.EditTimeOut(Sender: TObject);
var
  Delta: TDateTime;
begin
  // flush edit time
  Delta := Now - FEditTimeStamp;
  Advance(stEdit, Delta);
  FCurrentSession.Advance(stEdit, Delta);
  FEditTimer.Enabled := False;
end;

procedure THopeProjectStatistics.SetRunning(const Value: Boolean);
var
  Delta: TDateTime;
begin
  if FIsRunning <> Value then
  begin
    if FIsRunning then
    begin
      Delta := Now - FRunningTimeStamp;
      Advance(stRun, Delta);
      FCurrentSession.Advance(stRun, Delta);
    end;
    FIsRunning := Value;
    FRunningTimeStamp := Now
  end;
end;

procedure THopeProjectStatistics.Suspend;
begin
  FEditTimer.Enabled := False;
  FlushTimes;
end;

procedure THopeProjectStatistics.Resume;
begin
  FTimeStamp := Now;
  FRunningTimeStamp := Now;
  FEditTimeStamp := Now;
end;

procedure THopeProjectStatistics.ReadJson(const JsonValue: TdwsJSONObject);
var
  SessionsArray: TdwsJSONArray;
  Session: TProjectStatisticSession;
  Index: Integer;
begin
  inherited;

  FTimeStamp := Now;

  if JsonValue.GetArray('Sessions', SessionsArray) then
    for Index := 0 to SessionsArray.ElementCount - 1 do
    begin
      Session := TProjectStatisticSession.Create;
      Assert(SessionsArray[Index] is TdwsJSONObject);
      Session.ReadJson(TdwsJSONObject(SessionsArray[Index]));
      FSessions.Add(Session);
    end;
end;

procedure THopeProjectStatistics.WriteJson(const JsonValue: TdwsJSONObject);
var
  Index: Integer;
  Sessions: TdwsJSONArray;
begin
  FlushTimes;

  inherited;

  Sessions := JsonValue.AddArray('Sessions');
  for Index := 0 to FSessions.Count - 1 do
    TProjectStatisticSession(FSessions[Index]).WriteJson(Sessions.AddObject);
end;


{ THopeProjectIDE }

procedure THopeProjectIDE.AfterConstruction;
begin
  inherited;

  FLocal := THopeLocal.Create;
  FStatistics := THopeProjectStatistics.Create;
end;

procedure THopeProjectIDE.BeforeDestruction;
begin
  inherited;

  FStatistics.Free;
  FLocal.Free;
end;

procedure THopeProjectIDE.RecallFromLocalFile;
var
  Index: Integer;
  OpenedFile: THopeOpenedFile;
  FormEditor: TFormEditor;
begin
  for Index := 0 to FLocal.OpenedFiles.Count - 1 do
  begin
    OpenedFile := FLocal.OpenedFile[Index];

    FormEditor := FormMain.Editors.GetEditorForFileName(OpenedFile.FileName);

    if not Assigned(FormEditor) then
      FormEditor := FormMain.RegisterNewEditor(OpenedFile.FileName);

    // assign form properties from local file
    if Assigned(FormEditor) then
      FormEditor.Assign(OpenedFile);
  end;

  if FLocal.ActiveFileName <> '' then
    FormMain.FocusEditor(FLocal.ActiveFileName);
end;

procedure THopeProjectIDE.StoreToLocalFile;
var
  Index: Integer;
  OpenedFile: THopeOpenedFile;
begin
  FLocal.OpenedFiles.Clear;

  for Index := 0 to FormMain.Editors.Count - 1 do
  begin
    OpenedFile := THopeOpenedFile.Create;
    OpenedFile.Assign(FormMain.Editors[Index]);
    FLocal.OpenedFiles.Add(OpenedFile);
  end;

  if Assigned(FormMain.FocusedEditorForm) then
    FLocal.ActiveFileName := FormMain.FocusedEditorForm.FileName;
end;

procedure THopeProjectIDE.LoadFromFile(const FileName: TFileName);
var
  LocalFile: TFileName;
  StatisticsFile: TFileName;
begin
  inherited;

  LocalFile := ChangeFileExt(FileName, '.hloc');
  if FileExists(LocalFile) then
  begin
    FLocal.LoadFromFile(LocalFile);

    RecallFromLocalFile;
  end;

  StatisticsFile := ChangeFileExt(FileName, '.hstc');
  if FileExists(StatisticsFile) then
    FStatistics.LoadFromFile(StatisticsFile);
end;

procedure THopeProjectIDE.SaveLocalFile;
var
  LocalFile: TFileName;
  StatisticsFile: TFileName;
begin
  StoreToLocalFile;
  LocalFile := ChangeFileExt(FileName, '.hloc');
  FLocal.SaveToFile(LocalFile);

  StatisticsFile := ChangeFileExt(FileName, '.hstc');
  FStatistics.SaveToFile(StatisticsFile);
end;

procedure THopeProjectIDE.SaveToFile(const FileName: TFileName);
var
  LocalFile: TFileName;
  StatisticsFile: TFileName;
begin
  inherited;

  StoreToLocalFile;

  LocalFile := ChangeFileExt(FileName, '.hloc');
  FLocal.SaveToFile(LocalFile);

  StatisticsFile := ChangeFileExt(FileName, '.hstc');
  FStatistics.SaveToFile(StatisticsFile);
end;


{ THopeProjectListIDE }

function THopeProjectListIDE.GetActiveProject: THopeProjectIDE;
begin
  Result := THopeProjectIDE(ActiveProject);
end;

class function THopeProjectListIDE.GetProjectClass: THopeProjectClass;
begin
  Result := THopeProjectIDE;
end;

procedure THopeProjectListIDE.SaveLocalFiles;
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
    THopeProjectIDE(Project[Index]).SaveLocalFile;
end;

procedure THopeProjectListIDE.CloseProjects;
begin
  while Count > 0 do
    RemoveProject(Project[0]);
end;


end.
