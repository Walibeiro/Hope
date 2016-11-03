unit Hope.Common.Paths;

{$I Hope.inc}

interface

uses
  System.SysUtils;

type
  THopePaths = class
  private
    FRootPath: string;
    function GetHistoryFileName: TFileName;
    function GetPositionsFileName: TFileName;
    function GetPreferenceFileName: TFileName;
    function GetWelcomePage: string;
  public
    procedure AfterConstruction; override;

    property Root: string read FRootPath;
    property WelcomePage: string read GetWelcomePage;
    property HistoryFileName: TFileName read GetHistoryFileName;
    property PositionsFileName: TFileName read GetPositionsFileName;
    property PreferenceFileName: TFileName read GetPreferenceFileName;
  end;

implementation

{ THopePaths }

procedure THopePaths.AfterConstruction;
begin
  inherited;

  FRootPath := ExtractFilePath(ParamStr(0));
end;

function THopePaths.GetPositionsFileName: TFileName;
begin
  Result := FRootPath + '..\Common\Positions.json';
end;

function THopePaths.GetHistoryFileName: TFileName;
begin
  Result := FRootPath + '..\Common\History.json';
end;

function THopePaths.GetPreferenceFileName: TFileName;
begin
  Result := FRootPath + '..\Common\Preferences.json';
end;

function THopePaths.GetWelcomePage: string;
begin
  Result := FRootPath + '..\Common\Welcome Page\';
end;

end.

