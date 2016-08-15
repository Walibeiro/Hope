unit Hope.Docking.Form;

interface

uses
  System.SysUtils, System.Classes, System.Types, WinApi.Windows,
  WinApi.Messages, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormDockable = class(TForm)
    procedure FormDockOver(Sender: TObject; Source: TDragDockObject;
      X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormStartDock(Sender: TObject; var DragObject: TDragDockObject);
  private
    FUndockedLeft: Integer;
    FUndockedTop: Integer;
    FFloatOnCloseDock: Boolean;
    function ComputeDockingRect(var DockRect: TRect; MousePos: TPoint): TAlign;
    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
    procedure WMNCLButtonDown(var Msg: TMessage); message WM_NCLBUTTONDOWN;
  public
    property UndockedLeft: Integer read FUndockedLeft;
    property UndockedTop: Integer read FUndockedTop;
    property FloatOnCloseDock: Boolean read FFloatOnCloseDock write FFloatOnCloseDock;
  end;

implementation

{$R *.dfm}

uses
  VCL.ComCtrls,
  Hope.DockingUtils, Hope.Docking.Host, Hope.Main;

{ TFormDockable }

procedure TFormDockable.FormDockOver(Sender: TObject; Source: TDragDockObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  ARect: TRect;
begin
  Accept := (Source.Control is TFormDockable);

  // Draw dock preview depending on where the cursor is relative to our client area
  if Accept and (ComputeDockingRect(ARect, Point(X, Y)) <> alNone) then
  begin
    ComputeDockingRect(ARect, Point(X, Y));
    Source.DockRect := ARect;
  end;
end;

function TFormDockable.ComputeDockingRect(var DockRect: TRect; MousePos: TPoint): TAlign;
var
  DockTopRect,
  DockLeftRect,
  DockBottomRect,
  DockRightRect,
  DockCenterRect: TRect;
begin
  Result := alNone;

  // divide form up into docking zones
  DockLeftRect.TopLeft := Point(0, 0);
  DockLeftRect.BottomRight := Point(ClientWidth div 5, ClientHeight);

  DockTopRect.TopLeft := Point(ClientWidth div 5, 0);
  DockTopRect.BottomRight := Point(4 * ClientWidth div 5, ClientHeight div 5);

  DockRightRect.TopLeft := Point(4 * ClientWidth div 5, 0);
  DockRightRect.BottomRight := Point(ClientWidth, ClientHeight);

  DockBottomRect.TopLeft := Point(ClientWidth div 5, 4 * ClientHeight div 5);
  DockBottomRect.BottomRight := Point(4 * ClientWidth div 5, ClientHeight);

  DockCenterRect.TopLeft := Point(ClientWidth div 5, ClientHeight div 5);
  DockCenterRect.BottomRight := Point(4 * ClientWidth div 5, 4 * ClientHeight div 5);

  // find out where the mouse cursor is, to decide where to draw dock preview.
  if PtInRect(DockLeftRect, MousePos) then
  begin
    Result := alLeft;
    DockRect := DockLeftRect;
    DockRect.Right := ClientWidth div 2;
  end
  else
  if PtInRect(DockTopRect, MousePos) then
  begin
    Result := alTop;
    DockRect := DockTopRect;
    DockRect.Left := 0;
    DockRect.Right := ClientWidth;
    DockRect.Bottom := ClientHeight div 2;
  end
  else
  if PtInRect(DockRightRect, MousePos) then
  begin
    Result := alRight;
    DockRect := DockRightRect;
    DockRect.Left := ClientWidth div 2;
  end
  else
  if PtInRect(DockBottomRect, MousePos) then
  begin
    Result := alBottom;
    DockRect := DockBottomRect;
    DockRect.Left := 0;
    DockRect.Right := ClientWidth;
    DockRect.Top := ClientHeight div 2;
  end
  else
  if PtInRect(DockCenterRect, MousePos) then
  begin
    Result := alClient;
    DockRect := DockCenterRect;
  end;
  if Result = alNone then Exit;

  // DockRect is in screen coordinates.
  DockRect.TopLeft := ClientToScreen(DockRect.TopLeft);
  DockRect.BottomRight := ClientToScreen(DockRect.BottomRight);
end;

procedure TFormDockable.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if HostDockSite is TPanel then
    if (HostDockSite.Owner is TFormDockHost) then
    begin
      // if we're the last visible form on a conjoined form, hide the form
      if HostDockSite.VisibleDockClientCount <= 1 then
        TFormDockHost(HostDockSite.Owner).Hide;
    end
    else;
      FormMain.ShowDockPanel(HostDockSite as TPanel, False, nil);

  Action := caHide;
end;

procedure TFormDockable.CMDockClient(var Message: TCMDockClient);
var
  ARect: TRect;
  DockType: TAlign;
  Host: TFormDockHost;
  Pt: TPoint;
begin
  if Message.DockSource.Control is TFormDockable then
  begin
    // Find out how to dock (Using a TAlign as the result of ComputeDockingRect)
    Pt.X := Message.MousePos.X;
    Pt.Y := Message.MousePos.Y;
    DockType := ComputeDockingRect(ARect, Pt);

    Host := TFormDockHost.Create(Application);
    Host.IsPaged := DockType = alClient;
    Host.BoundsRect := Self.BoundsRect;
    Self.ManualDock(Host.PanelDock, nil, alNone);
    Self.DockSite := False;
    Message.DockSource.Control.ManualDock(Host.PanelDock, nil, DockType);
    TFormDockable(Message.DockSource.Control).DockSite := False;
    Host.IsPaged := DockType = alClient;
    Host.Visible := True;
  end;
end;

procedure TFormDockable.FormStartDock(Sender: TObject;
  var DragObject: TDragDockObject);
begin
  // create a customized DragDropObject
  DragObject := TTransparentDragDockObject.Create(Self);
end;

procedure TFormDockable.WMNCLButtonDown(var Msg: TMessage);
begin
  inherited;

  // This event happen when mouse click in caption
  // save initial window position
  FUndockedLeft := Left;
  FUndockedTop := Top;
end;

end.
