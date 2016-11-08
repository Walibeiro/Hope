unit Hope.Project.IDE;

interface

{$I Hope.inc}

uses
  System.SysUtils, Hope.Project, Hope.Project.List,
  Hope.Project.Local;

type
  THopeProjectIDE = class(THopeProject)
  private
    FLocal: THopeLocal;
    procedure UpdateLocalFile;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure LoadFromFile(const FileName: TFileName); override;
    procedure SaveToFile(const FileName: TFileName); override;
  end;

  THopeProjectListIDE = class(THopeProjectList)
  private
    function GetActiveProject: THopeProjectIDE;
  protected
    class function GetProjectClass: THopeProjectClass; override;
  public
    property ActiveProjectIDE: THopeProjectIDE read GetActiveProject;
  end;

implementation

uses
  Hope.Main;

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

procedure THopeProjectIDE.LoadFromFile(const FileName: TFileName);
var
  LocalFile: TFileName;
begin
  inherited;

  LocalFile := ChangeFileExt(FileName, '.hloc');
  if FileExists(LocalFile) then
    FLocal.LoadFromFile(LocalFile);
end;

procedure THopeProjectIDE.UpdateLocalFile;
begin

end;

procedure THopeProjectIDE.SaveToFile(const FileName: TFileName);
var
  LocalFile: TFileName;
begin
  inherited;

  UpdateLocalFile;

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

end.

