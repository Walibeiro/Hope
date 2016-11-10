unit Hope.Dialog.ReloadChangedFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.StdCtrls;

type
  TFormReloadChanges = class(TForm)
    ButtonCancel: TButton;
    ButtonReload: TButton;
    TreeFiles: TVirtualStringTree;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormReloadChanges: TFormReloadChanges;

implementation

{$R *.dfm}

end.

