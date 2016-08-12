unit Hope.MessageWindow.FindInFiles;

interface

{$I Hope.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Menus, VirtualTrees, Hope.MessageWindow;

type
  TFormMessagesFindInFiles = class(TFormMessageWindow)
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

end.

