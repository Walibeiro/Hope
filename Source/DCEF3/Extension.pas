unit Extension;

interface

uses
  ceflib;

type
  TCustomRenderProcessHandler = class(TCefRenderProcessHandlerOwn)
  protected
    procedure OnWebKitInitialized; override;
  end;

  TApplicationExtension = class
    class procedure NewProject;
    class procedure OpenProject;
    class procedure LoadProject(const FileName: string);
    class procedure CloseProject;
  end;

implementation

procedure TCustomRenderProcessHandler.OnWebKitInitialized;
begin
  TCefRTTIExtension.Register('Hope', TApplicationExtension);
end;

{ THostExtension }

class procedure TApplicationExtension.LoadProject(const FileName: string);
var
  ProcessMessage: ICefProcessMessage;
begin
  ProcessMessage := TCefProcessMessageRef.New('LoadProject');
  ProcessMessage.ArgumentList.SetString(0, FileName);
  TCefv8ContextRef.Current.Browser.SendProcessMessage(PID_BROWSER, ProcessMessage);
end;

class procedure TApplicationExtension.NewProject;
begin
  TCefv8ContextRef.Current.Browser.SendProcessMessage(PID_BROWSER,
    TCefProcessMessageRef.New('NewProject'));
end;

class procedure TApplicationExtension.OpenProject;
begin
  TCefv8ContextRef.Current.Browser.SendProcessMessage(PID_BROWSER,
    TCefProcessMessageRef.New('OpenProject'));
end;

class procedure TApplicationExtension.CloseProject;
begin
  TCefv8ContextRef.Current.Browser.SendProcessMessage(PID_BROWSER,
    TCefProcessMessageRef.New('CloseProject'));
end;

initialization
  CefRemoteDebuggingPort := 9000;
  CefRenderProcessHandler := TCustomRenderProcessHandler.Create;
  CefBrowserProcessHandler := TCefBrowserProcessHandlerOwn.Create;
end.
