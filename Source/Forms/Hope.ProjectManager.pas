unit Hope.ProjectManager;

interface

{$I Hope.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.ToolWin, Vcl.ComCtrls;

type
  TFormProjectManager = class(TForm)
    ToolBar: TToolBar;
    TreeProject: TVirtualStringTree;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

end.

