unit Hope.Editor;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ToolWin,
  SynEdit, Hope.DataModule;

type
  TFormEditor = class(TForm)
    Editor: TSynEdit;
    StatusBar: TStatusBar;
    ToolBarMacro: TToolBar;
    ToolButtonPlay: TToolButton;
    ToolButtonRecord: TToolButton;
    ToolButtonStop: TToolButton;
  private

  public
    { Public-Deklarationen }
  end;

implementation

{$R *.dfm}

end.
