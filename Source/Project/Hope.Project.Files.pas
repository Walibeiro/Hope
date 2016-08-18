unit Hope.Project.Files;

interface

{$I Hope.inc}

uses
  System.SysUtils;

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

end.

