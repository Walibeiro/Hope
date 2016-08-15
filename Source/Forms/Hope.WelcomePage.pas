unit Hope.WelcomePage;

interface

{$I Hope.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ceflib, cefvcl,
  dwsHTTPSysServer, dwsUtils, dwsWebEnvironment, dwsXPlatform,
  dwsWebServerHelpers, dwsWebUtils;

type
  TFormWelcomePage = class(TForm)
    Chromium: TChromium;
    procedure ChromiumBeforeResourceLoad(Sender: TObject;
      const browser: ICefBrowser; const frame: ICefFrame;
      const request: ICefRequest; const callback: ICefRequestCallback;
      out Result: TCefReturnValue);
    procedure ChromiumLoadEnd(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; httpStatusCode: Integer);
    procedure ChromiumProcessMessageReceived(Sender: TObject;
      const browser: ICefBrowser; sourceProcess: TCefProcessId;
      const message: ICefProcessMessage; out Result: Boolean);
    procedure FormStartDock(Sender: TObject; var DragObject: TDragDockObject);
  private
    FMimeTypeCache: TMIMETypeCache;
    FServer: THttpApi2Server;
    procedure RequestHandler(Request: TWebRequest; Response: TWebResponse);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure Update;
  end;

implementation

{$R *.dfm}

uses
  Hope.Main, Hope.Common;

{ TFormWelcomePage }

procedure TFormWelcomePage.AfterConstruction;
var
  Info: THttpSys2UrlInfo;
begin
  inherited;

  FMimeTypeCache := TMIMETypeCache.Create;

  // create and configure server
  FServer := THttpApi2Server.Create(False);
  Info.DomainName := '';
  Info.RelativeURI := '';
  Info.HTTPS := False;
  Info.Port := 8092;
  FServer.AddUrl(Info);
  FServer.OnRequest := RequestHandler;
end;

procedure TFormWelcomePage.BeforeDestruction;
begin
  FreeAndNil(FMimeTypeCache);
  FreeAndNil(FServer);

  inherited;
end;

procedure TFormWelcomePage.ChromiumBeforeResourceLoad(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame;
  const request: ICefRequest; const callback: ICefRequestCallback;
  out Result: TCefReturnValue);
var
  u: TUrlParts;
begin
  // redirect home to google
  if CefParseUrl(request.Url, u) then
    if (u.host = 'home') then
    begin
      u.host := 'http://localhost:8092/index.html';
      request.Url := CefCreateUrl(u);
    end;
end;

procedure TFormWelcomePage.ChromiumLoadEnd(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
var
  HistoryList: TStringList;
  RecentIndex: Integer;
  JSCall: string;
begin
  if not Chromium.Visible then
    Exit;

  HistoryList := DataModuleCommon.History.ProjectsHistory;
  if (Chromium.Browser <> nil) and (HistoryList.Count > 0) then
  begin
    JSCall := 'UpdateRecentFiles(["' + HistoryList[0] + '"';
    for RecentIndex := 1 to HistoryList.Count - 1 do
      JSCall := JSCall + ', "' + HistoryList[RecentIndex] + '"';
    JSCall := JSCall + ']);';
    JSCall := StringReplace(JSCall, '\', '\\', [rfReplaceAll]);

    frame.ExecuteJavaScript(JSCall, 'about:blank', 0);
  end;
end;

procedure TFormWelcomePage.ChromiumProcessMessageReceived(Sender: TObject;
  const browser: ICefBrowser; sourceProcess: TCefProcessId;
  const message: ICefProcessMessage; out Result: Boolean);
begin
  if (message.Name = 'NewProject') then
  begin
    FormMain.ActionFileNewProject.Execute;
    Result := True;
  end else
  if (message.Name = 'OpenProject') then
  begin
    FormMain.ActionFileOpenProject.Execute;
    Result := True;
  end else
  if (message.Name = 'LoadProject') then
  begin
    FormMain.LoadProject(message.ArgumentList.GetString(0));
    Result := True;
  end else
    Result := False;
end;

procedure TFormWelcomePage.FormStartDock(Sender: TObject;
  var DragObject: TDragDockObject);
begin
  DragObject := TDragDockObjectEx.Create(Self);
  DragObject.Brush.Color := clAqua; // this will display a red outline
end;

procedure TFormWelcomePage.RequestHandler(Request: TWebRequest;
  Response: TWebResponse);
var
  FileName: TFileName;
  FS: TFileStream;
  WriteOnlyStream: TWriteOnlyBlockStream;
  RootPath: String;
begin
  FileName := Request.URL;
  Delete(FileName, 1, 1);
  FileName := StringReplace(FileName, '/', '\', [rfReplaceAll]);

  Response.Headers.Add('Access-Control-Allow-Origin: *');
  Response.ContentType := FMimeTypeCache.MIMEType(FileName);
  Response.ContentEncoding := 'utf-8';

  // get root path for the welcome page
  RootPath := DataModuleCommon.Paths.WelcomePage;

  // load content
  if Pos('text', Response.ContentType) > 0 then
    Response.ContentData := ScriptStringToRawByteString(LoadTextFromFile(RootPath + FileName))
  else
  begin
    FS := TFileStream.Create(RootPath + FileName, fmOpenRead or fmShareDenyNone);
    try
      WriteOnlyStream := TWriteOnlyBlockStream.Create;
      try
        WriteOnlyStream.CopyFrom(FS, FS.Size);
        Response.ContentData := WriteOnlyStream.ToRawBytes;
      finally
        WriteOnlyStream.Free;
      end;
    finally
      FS.Free;
    end;
  end;
end;

procedure TFormWelcomePage.Update;
begin
  if Chromium.Visible then
    Chromium.Load('http://localhost:8092/index.html');
end;

end.
