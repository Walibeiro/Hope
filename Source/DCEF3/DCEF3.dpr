program DCEF3;

{$SetPEFlags $0001}

{-$WEAKLINKRTTI ON}
{-$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}

{$R *.res}

uses
  Windows,
  SysUtils,
  ceflib,
  Extension in 'Extension.pas';

{
  Simple CEF3 host application to be used in multi-process mode (e.g. with
  CefSingleProcess := False). Needs to be specified in the main application
  with CefBrowserSubprocessPath := [Filename of this executable]

  This simple application has been developed by Eric Grange. If called
  standalone it only shows the version of the libcef.dll
}

function GetCEFVersion : String;
var
  Size, Handle, BufferLength: Cardinal;
  Buffer, Info: Pointer;
begin
  Result := 'unknown';
  Handle := 0;
  Size := GetFileVersionInfoSize(PChar(CefLibrary), Handle);
  if Size = 0 then
    Exit;

  GetMem(Buffer, Size);
  try
    if GetFileVersionInfo(PChar(CefLibrary), Handle, Size, Buffer) then
    begin
      if VerQueryValue(Buffer, '\', Info, BufferLength) then
        with PVSFixedFileInfo(Info)^ do
        begin
          Result := Format('%d.%d.%d.%d', [HiWord(dwFileVersionMS),
            LoWord(dwFileVersionMS), HiWord(dwFileVersionLS),
            LoWord(dwFileVersionLS)]);
        end;
    end;
  finally
    FreeMem(Buffer);
  end;
end;

const
  CTitle = 'Chromium Embedded Framework Host Process';
begin
  // multi process only
  CefSingleProcess := False;
  try
    if not CefLoadLibDefault then
      Halt;
    MessageBox(0, PChar('libcef.dll version ' + GetCEFVersion), CTitle,
      MB_ICONINFORMATION + MB_OK);
  except
    on E: Exception do
      MessageBox(0, PChar(E.Message), CTitle, MB_ICONERROR + MB_OK);
  end;
end.
