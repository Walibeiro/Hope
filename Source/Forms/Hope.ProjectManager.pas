unit Hope.ProjectManager;

interface

{$I Hope.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls,
  VirtualTrees, Hope.Docking.Form;

type
  TFormProjectManager = class(TFormDockable)
    ToolBar: TToolBar;
    TreeProject: TVirtualStringTree;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    procedure FormStartDock(Sender: TObject; var DragObject: TDragDockObject);
  private
    { Private-Deklarationen }
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  Hope.Common, Hope.Main;

{$R *.dfm}

{ TFormProjectManager }

procedure TFormProjectManager.AfterConstruction;
begin
  inherited;
end;

procedure TFormProjectManager.FormStartDock(Sender: TObject;
  var DragObject: TDragDockObject);
begin
  DragObject := TDragDockObjectEx.Create(Self);
  DragObject.Brush.Color := clAqua; // this will display a red outline
end;

end.

