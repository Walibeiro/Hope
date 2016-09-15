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
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure AddPath(Path: TFileName);

    function GetText(FileName: TFileName): string;

    property BuffferList: THopeBufferList read FBuffferList;
    property DirectoryMonitor: TDirectoryMonitor read FDirectoryMonitor;
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
  Index := FBuffferList.IndexOf(FileName);

  if Index >= 0 then
    Exit(FBuffferList[Index].Text);

  FBuffferList[Index].Text := LoadTextFromFile(FileName);
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

