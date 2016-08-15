program Hope;

uses
  Vcl.Forms,
  Hope.About in 'Forms\Hope.About.pas' {FormAbout},
  Hope.ColorPicker in 'Forms\Hope.ColorPicker.pas' {FormColorPicker},
  Hope.Common in 'DataModules\Hope.Common.pas' {DataModuleCommon: TDataModule},
  Hope.Compiler in 'Compiler\Hope.Compiler.pas',
  Hope.Dialog in 'Forms\Dialogs\Hope.Dialog.pas' {FormDialog},
  Hope.Dialog.FindClass in 'Forms\Dialogs\Hope.Dialog.FindClass.pas' {FormFindClass},
  Hope.Dialogs.CodeTemplates in 'Forms\Dialogs\Hope.Dialogs.CodeTemplates.pas' {FormCodeTemplates},
  Hope.Dialogs.FindInFiles in 'Forms\Dialogs\Hope.Dialogs.FindInFiles.pas' {FormFindInFiles},
  Hope.Dialogs.FindReplace in 'Forms\Dialogs\Hope.Dialogs.FindReplace.pas' {FormFind},
  Hope.Dialogs.GotoLineNumber in 'Forms\Dialogs\Hope.Dialogs.GotoLineNumber.pas' {FormGotoLineNumber},
  Hope.Dialogs.NewMore in 'Forms\Dialogs\Hope.Dialogs.NewMore.pas' {FormObjectGallery},
  Hope.Dialogs.Preferences in 'Forms\Dialogs\Hope.Dialogs.Preferences.pas' {FormPreferences},
  Hope.Dialogs.ProjectOptions in 'Forms\Dialogs\Hope.Dialogs.ProjectOptions.pas' {FormProjectOptions},
  Hope.Editor in 'Forms\Editor\Hope.Editor.pas' {FormEditor},
  Hope.History in 'History\Hope.History.pas',
  Hope.Main in 'Forms\Hope.Main.pas' {FormMain},
  Hope.MessageWindow in 'Forms\MessageWindow\Hope.MessageWindow.pas' {FormMessageWindow},
  Hope.MessageWindow.Compiler in 'Forms\MessageWindow\Hope.MessageWindow.Compiler.pas' {FormCompilerMessages},
  Hope.MessageWindow.FindInFiles in 'Forms\MessageWindow\Hope.MessageWindow.FindInFiles.pas' {FormMessagesFindInFiles},
  Hope.MessageWindow.Output in 'Forms\MessageWindow\Hope.MessageWindow.Output.pas' {FormOutputMessages},
  Hope.Paths in 'Hope.Paths.pas',
  Hope.Project in 'Project\Hope.Project.pas',
  Hope.ProjectList in 'Project\Hope.ProjectList.pas',
  Hope.ProjectManager in 'Forms\Hope.ProjectManager.pas' {FormProjectManager},
  Hope.UnicodeExplorer in 'Forms\Hope.UnicodeExplorer.pas' {FormUnicodeExplorer},
  Hope.UnitManager in 'Forms\Hope.UnitManager.pas' {FormUnitManager},
  Hope.WelcomePage in 'Forms\Hope.WelcomePage.pas' {FormWelcomePage},
  Hope.DockingHost in 'Forms\Docking\Hope.DockingHost.pas' {FormDockHost},
  Hope.DockingForm in 'Forms\Docking\Hope.DockingForm.pas' {FormDockable},
  Hope.DockingUtils in 'Utils\Hope.DockingUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleCommon, DataModuleCommon);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.

