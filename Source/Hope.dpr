program Hope;

uses
  Vcl.Forms,
  Hope.Main in 'Forms\Hope.Main.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.

