unit Hope.DockingHost;

interface

uses
  System.SysUtils, System.Classes, System.Types, WinApi.Windows,
  WinApi.Messages, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Tabs, Vcl.ExtCtrls, Hope.DockingForm;

type
  TFormDockHost = class(TFormDockable)
    PanelDock: TPanel;
    TabSet: TTabSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PanelDockDrop(Sender: TObject; Source: TDragDockObject;
      X, Y: Integer);
    procedure PanelUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure PanelDockOver(Sender: TObject; Source: TDragDockObject;
      X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure FormGetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure TabSetChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure TabSetMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FLastPosition: TPoint;
    FSqrDistance: Single;
    procedure DoFloat(AControl: TControl);
    procedure SetIsPaged(const Value: Boolean);
    function GetIsPaged: Boolean;
  public
    property IsPaged: Boolean read GetIsPaged write SetIsPaged;
  end;

implementation

uses
  Hope.DockingUtils;

{$R *.dfm}

{ TFormDockHost }

procedure TFormDockHost.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if PanelDock.DockClientCount = 1 then
  begin
    DoFloat(PanelDock.DockClients[0]);
    Action := caFree;
  end
  else
    Action := caHide;
end;

procedure TFormDockHost.DoFloat(AControl: TControl);
var
  ARect: TRect;
begin
  // float the control with its original size.
  ARect.TopLeft := AControl.ClientToScreen(Point(0, 0));
  ARect.BottomRight := AControl.ClientToScreen(Point(AControl.UndockWidth,
    AControl.UndockHeight));
  AControl.ManualFloat(ARect);
end;

procedure TFormDockHost.PanelDockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
var
  Index: Integer;
  R: TRect;
begin
  TabSet.Tabs.Clear;
  for Index := 0 to PanelDock.DockClientCount - 1 do
    TabSet.Tabs.Add(TFormDockable(PanelDock.DockClients[Index]).Caption);

  if IsPaged then
    TabSet.TabIndex := TabSet.Tabs.Count - 1;

  // eventually force DockManager to redraw it's clients.
  if PanelDock.UseDockManager then
    PanelDock.DockManager.ResetBounds(True)
  else
    Source.Control.Align := alClient;
end;

procedure TFormDockHost.PanelUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
  // only 2 dock clients means the host must be destroyed and
  // the remaining window undocked to its old position and size.
  // (Recall that OnUnDock gets called before the undocking actually occurs)
  if Client is TFormDockable then
    TFormDockable(Client).DockSite := True;

  if (PanelDock.DockClientCount = 2) and (NewTarget <> Self) then
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
end;

procedure TFormDockHost.SetIsPaged(const Value: Boolean);
begin
  TabSet.Visible := Value;
  PanelDock.UseDockManager := not Value;
end;

procedure TFormDockHost.TabSetChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
  Index: Integer;
begin
  for Index := 0 to PanelDock.DockClientCount - 1 do
  begin
    PanelDock.DockClients[Index].Visible := Index = NewTab;
    if Index = NewTab then
      Caption := TFormDockable(PanelDock.DockClients[Index]).Caption;
  end;
end;

procedure TFormDockHost.TabSetMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
(*
  if TabSet.TabIndex >= -1 then
    PanelDock.DockClients[TabSet.TabIndex].BeginDrag(False, 5);
*)
end;

function TFormDockHost.GetIsPaged: Boolean;
begin
  Result := TabSet.Visible;
end;

procedure TFormDockHost.PanelDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept := Source.Control is TFormDockable;
end;

procedure TFormDockHost.FormGetSiteInfo(Sender: TObject;
  DockClient: TControl; var InfluenceRect: TRect; MousePos: TPoint;
  var CanDock: Boolean);
begin
  CanDock := DockClient is TFormDockable;
end;

end.
