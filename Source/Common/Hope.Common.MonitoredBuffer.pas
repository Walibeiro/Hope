unit Hope.Common.MonitoredBuffer;

interface

{$I Hope.inc}

uses
  System.Classes, System.SysUtils, Hope.Buffer, Hope.Buffer.List,
  Hope.Common.DirectoryMonitor;

type
  TMonitoredBuffer = class
  private
    FBuffferList: THopeBufferList;
    FDirectoryMonitor: TDirectoryMonitor;

    function GetText(FileName: TFileName): string;
    procedure SetText(FileName: TFileName; const Text: string);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure AddPath(Path: TFileName);

    function GetSourceCode(UnitName: string): string;

    property BuffferList: THopeBufferList read FBuffferList;
    property DirectoryMonitor: TDirectoryMonitor read FDirectoryMonitor;
    property Text[FileName: TFileName]: string read GetText write SetText; default;
  end;

implementation

uses
  dwsUtils, dwsXPlatform;

{ TMonitoredBuffer }

procedure TMonitoredBuffer.AfterConstruction;
begin
  inherited;

  // create buffer list and directory monitor
  FBuffferList := THopeBufferList.Create;
  FDirectoryMonitor := TDirectoryMonitor.Create;
end;

procedure TMonitoredBuffer.BeforeDestruction;
begin
  // free buffer list and directory monitor
  FDirectoryMonitor.Free;
  FBuffferList.Free;

  inherited;
end;

function TMonitoredBuffer.GetText(FileName: TFileName): string;
var
  Index: Integer;
begin
  // get index of file name (if buffered)
  Index := FBuffferList.IndexOf(FileName);

  // eventually return buffered text
  if Index >= 0 then
    Exit(FBuffferList[Index].Text);

  // load text from the hard disk in case it is not buffered;
  Result := LoadTextFromFile(FileName);
end;

procedure TMonitoredBuffer.SetText(FileName: TFileName;
  const Text: string);
var
  Index: Integer;
begin
  // get index of file name (if buffered)
  Index := FBuffferList.IndexOf(FileName);

  // eventually return buffered text
  if Index >= 0 then
    FBuffferList[Index].Text := Text;
end;

function TMonitoredBuffer.GetSourceCode(UnitName: string): string;
var
  Index: Integer;
begin
  Result := '';

  // get index of unit name (if buffered)
  Index := FBuffferList.IndexOfUnit(UnitName);

  // eventually return buffered text
  if Index >= 0 then
    Exit(FBuffferList[Index].Text);
end;

procedure TMonitoredBuffer.AddPath(Path: TFileName);
var
  FileList: TStringList;
  Index: Integer;
begin
  FileList := TStringList.Create;
  try
    // collect all files in the specified path
    for Index := 0 to FDirectoryMonitor.Extensions.Count - 1 do
      CollectFiles(Path, '*' + FDirectoryMonitor.Extensions[Index], FileList, True);

    // add files to buffer list
    for Index := 0 to FileList.Count - 1 do
      FBuffferList.Add(FileList[Index]);
  finally
    FileList.Free;
  end;

  // begin monitoring path
  FDirectoryMonitor.BeginMonitor(Path);
end;

end.

