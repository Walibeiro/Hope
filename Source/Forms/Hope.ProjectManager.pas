unit Hope.ProjectManager;

interface

{$I Hope.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls,
  VirtualTrees;

type
  TFormProjectManager = class(TForm)
    ToolBar: TToolBar;
    TreeProject: TVirtualStringTree;
    procedure FormStartDock(Sender: TObject; var DragObject: TDragDockObject);
  private
    { Private-Deklarationen }
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  Hope.Common;

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

