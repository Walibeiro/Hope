unit Hope.Common.DirectoryMonitor;

interface

{$I Hope.inc}

uses
  System.Contnrs, System.SysUtils, System.Classes, dwsDirectoryNotifier,
  Hope.Common.Constants;

type
  TExtensionStringList = class(TStringList)
  public
    function ToString: string; override;
  end;

  TDirectoryMonitor = class
  private
    FDirectoryNotifiers: TObjectList;
    FExtensions: TExtensionStringList;
    FOnFileChanged: TdwsFileChangedEvent;
    procedure FileChanged(Sender: TdwsFileNotifier; const FileName: string;
      ChangeAction : TFileNotificationAction);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure BeginMonitor(Path: TFileName);
    procedure EndMonitor(Path: TFileName);

    procedure Clear;

    property Extensions: TExtensionStringList read FExtensions;

    property OnFileChanged: TdwsFileChangedEvent read FOnFileChanged write FOnFileChanged;
  end;

implementation

uses
  dwsUtils;

{ TExtensionStringList }

function TExtensionStringList.ToString: string;
var
  Index: Integer;
begin
  if Count = 0 then
    Exit('');

  Result := '*' + Get(0);
  for Index := 1 to Count - 1 do
    Result := Result + ';*' + Get(Index);
end;


{ TDirectoryMonitor }

procedure TDirectoryMonitor.AfterConstruction;
begin
  inherited;

  FDirectoryNotifiers := TObjectList.Create(True);
  FExtensions := TExtensionStringList.Create;

  FExtensions.Add(CExtensionProgram);
  FExtensions.Add(CExtensionPascal);
  FExtensions.Add(CExtensionHtml);
  FExtensions.Add(CExtensionCss);
end;

procedure TDirectoryMonitor.BeforeDestruction;
begin
  FExtensions.Free;
  FDirectoryNotifiers.Free;

  inherited;
end;

procedure TDirectoryMonitor.BeginMonitor(Path: TFileName);
var
  Notifier: TdwsFileNotifier;
begin
  Notifier := TdwsFileNotifier.Create(Path, dnoDirectoryAndSubTree);
  Notifier.OnFileChanged := FileChanged;
  FDirectoryNotifiers.Add(Notifier);
end;

procedure TDirectoryMonitor.Clear;
begin
  FDirectoryNotifiers.Clear;
end;

procedure TDirectoryMonitor.EndMonitor(Path: TFileName);
var
  Index: Integer;
begin
  for Index := 0 to FDirectoryNotifiers.Count - 1 do
    if UnicodeSameText(Path, TdwsFileNotifier(FDirectoryNotifiers[Index]).Directory) then
    begin
      FDirectoryNotifiers.Delete(Index);
      Exit;
    end;
end;

procedure TDirectoryMonitor.FileChanged(Sender: TdwsFileNotifier;
  const FileName: string; ChangeAction: TFileNotificationAction);
var
  Index: Integer;
begin
  for Index := 0 to FExtensions.Count - 1 do
    if StrEndsWith(FileName, FExtensions[Index]) then
    begin
      FOnFileChanged(Sender, FileName, ChangeAction);
      Exit;
    end;
end;

end.
