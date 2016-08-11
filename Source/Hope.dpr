program Hope;

uses
  Vcl.Forms,
  Hope.Main in 'Forms\Hope.Main.pas' {FormMain},
  Hope.Common in 'DataModules\Hope.Common.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.

