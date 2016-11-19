unit Hope.UnitManager;

interface

{$I Hope.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees,
  Vcl.ToolWin, Vcl.ComCtrls, Hope.Docking.Form;

type
  TFormUnitManager = class(TFormDockable)
    ToolBar: TToolBar;
    TreeUnitStructure: TVirtualStringTree;
  private
    { Private-Deklarationen }
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  Hope.Main, Hope.DataModule.ImageLists;

{$R *.dfm}

{ TFormUnitManager }

procedure TFormUnitManager.AfterConstruction;
begin
  inherited;

  TreeUnitStructure.Images := DataModuleImageLists.ImageList16;
  TreeUnitStructure.StateImages := DataModuleImageLists.ImageList16;
end;

end.

