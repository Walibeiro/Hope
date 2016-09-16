unit Hope.Paths;

{$I Hope.inc}

interface

type
  THopePaths = class
  private
    FRootPath: string;
    function GetHistory: string;
    function GetWelcomePage: string;
  public
    procedure AfterConstruction; override;

    property Root: string read FRootPath;
    property WelcomePage: string read GetWelcomePage;
    property History: string read GetHistory;
  end;

implementation

uses
  System.SysUtils;

{ THopePaths }

procedure THopePaths.AfterConstruction;
begin
  inherited;

  FRootPath := ExtractFilePath(ParamStr(0));
end;

function THopePaths.GetHistory: string;
begin
  Result := FRootPath + '..\Common\History.json';
end;

function THopePaths.GetWelcomePage: string;
begin
  Result := FRootPath + '..\Common\Welcome Page\';
end;

end.

