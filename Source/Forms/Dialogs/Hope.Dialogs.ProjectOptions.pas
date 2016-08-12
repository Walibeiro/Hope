unit Hope.Dialogs.ProjectOptions;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, 
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  VirtualTrees, Hope.Dialog;

type
  TFormProjectOptions = class(TFormDialog)
    Bevel: TBevel;
    PageControl: TPageControl;
    TabSheetCompiler: TTabSheet;
    TabSheetCompilerLinker: TTabSheet;
    TabSheetProject: TTabSheet;
    TreeCategory: TVirtualStringTree;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

end.

