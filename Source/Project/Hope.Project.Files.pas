unit Hope.Project.Files;

interface

{$I Hope.inc}

uses
  System.SysUtils, System.Contnrs;

type
  THopeProjectFile = class
  private
    FFileName: TFileName;
    FExtension: string;
    procedure SetFileName(const Value: TFileName);
  public
    procedure AfterConstruction; override;

    property Extension: string read FExtension;
    property FileName: TFileName read FFileName write SetFileName;
  end;

  THopeProjectFiles = class
  private
    FList: TObjectList;
    function GetCount: Integer;
  public
    procedure AfterConstruction; override;

    property Count: Integer read GetCount;
  end;

implementation

{ THopeProjectFile }

procedure THopeProjectFile.AfterConstruction;
begin
  inherited;

end;

procedure THopeProjectFile.SetFileName(const Value: TFileName);
begin
  if FFileName <> Value then
  begin
    FFileName := Value;
    FExtension := LowerCase(ExtractFileExt(FileName));
  end;
end;


{ THopeProjectFiles }

procedure THopeProjectFiles.AfterConstruction;
begin
  inherited;
  FList := TObjectList.Create(True);
end;

function THopeProjectFiles.GetCount: Integer;
begin
  Result := FList.Count;
end;

end.

