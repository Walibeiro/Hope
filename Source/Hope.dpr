program Hope;

uses
  Vcl.Forms,
  Hope.Main in 'Forms\Hope.Main.pas' {FormMain},
  Hope.Common in 'DataModules\Hope.Common.pas' {DataModuleCommon: TDataModule},
  Hope.About in 'Forms\Hope.About.pas' {FormAbout},
  Hope.FindInFiles in 'Forms\Hope.FindInFiles.pas' {FormFindInFiles},
  Hope.FindReplace in 'Forms\Hope.FindReplace.pas' {FormFind},
  Hope.Project in 'Project\Hope.Project.pas',
  Hope.Compiler in 'Compiler\Hope.Compiler.pas',
  Hope.ProjectList in 'Project\Hope.ProjectList.pas',
  Hope.MessageWindow.Compiler in 'Forms\Hope.MessageWindow.Compiler.pas' {FormCompilerMessages},
  Hope.MessageWindow.Output in 'Forms\Hope.MessageWindow.Output.pas' {FormOutputMessages},
  Hope.MessageWindow.FindInFiles in 'Forms\Hope.MessageWindow.FindInFiles.pas' {FormMessagesFindInFiles},
  Hope.ProjectManager in 'Forms\Hope.ProjectManager.pas' {FormProjectManager},
  Hope.UnitManager in 'Forms\Hope.UnitManager.pas' {FormUnitManager},
  Hope.WelcomePage in 'Forms\Hope.WelcomePage.pas' {FormWelcomePage},
  Hope.ProjectOptions in 'Forms\Hope.ProjectOptions.pas' {FormProjectOptions},
  Hope.Preferences in 'Forms\Hope.Preferences.pas' {FormPreferences},
  Hope.GotoLineNumber in 'Forms\Hope.GotoLineNumber.pas' {FormGotoLineNumber};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDataModuleCommon, DataModuleCommon);
  Application.Run;
end.

