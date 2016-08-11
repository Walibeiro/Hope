program Hope;

uses
  Vcl.Forms,
  Hope.Main in 'Forms\Hope.Main.pas' {FormMain},
  Hope.Common in 'DataModules\Hope.Common.pas' {DataModuleCommon: TDataModule},
  Hope.About in 'Forms\Hope.About.pas' {FormAbout},
  Hope.FindInFiles in 'Forms\Hope.FindInFiles.pas' {FormFindInFiles};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDataModuleCommon, DataModuleCommon);
  Application.Run;
end.

