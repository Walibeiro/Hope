unit Hope.Project.Interfaces;

interface

{$I Hope.inc}

uses
  System.SysUtils;

type
  IProjectInterface = interface
    procedure Clear;
    function GetRootPath: string;
  end;

  IProjectListInterface = interface
    procedure Clear;
  end;

implementation

end.
