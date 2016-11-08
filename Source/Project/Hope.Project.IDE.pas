unit Hope.Project.IDE;

interface

{$I Hope.inc}

uses
  System.SysUtils, System.Classes, System.Contnrs, Hope.Project,
  Hope.Project.List, Hope.Project.Local;

type
  THopeProjectIDE = class(THopeProject)
  private
    FLocal: THopeLocal;
    procedure LoadFromLocalFile;
    procedure SaveToLocalFile;
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
  Hope.Main, Hope.Editor, SynEditTypes;

{ THopeProjectIDE }

procedure THopeProjectIDE.AfterConstruction;
begin
  inherited;

  FLocal := THopeLocal.Create;
end;

procedure THopeProjectIDE.BeforeDestruction;
begin
  inherited;

  FLocal.Free;
end;

procedure THopeProjectIDE.LoadFromLocalFile;
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

procedure THopeProjectIDE.SaveToLocalFile;
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
begin
  inherited;

  LocalFile := ChangeFileExt(FileName, '.hloc');
  if FileExists(LocalFile) then
  begin
    FLocal.LoadFromFile(LocalFile);

    LoadFromLocalFile;
  end;
end;

procedure THopeProjectIDE.SaveLocalFile;
var
  LocalFile: TFileName;
begin
  SaveToLocalFile;
  LocalFile := ChangeFileExt(FileName, '.hloc');
  FLocal.SaveToFile(LocalFile);
end;

procedure THopeProjectIDE.SaveToFile(const FileName: TFileName);
var
  LocalFile: TFileName;
begin
  inherited;

  SaveToLocalFile;

  LocalFile := ChangeFileExt(FileName, '.hloc');
  FLocal.SaveToFile(LocalFile);
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
