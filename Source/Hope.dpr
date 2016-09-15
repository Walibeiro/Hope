program Hope;

uses
  Vcl.Forms,
  Hope.About in 'Forms\Hope.About.pas' {FormAbout},
  Hope.AsciiChart in 'Forms\Hope.AsciiChart.pas' {FormAsciiChart},
  Hope.ColorPicker in 'Forms\Hope.ColorPicker.pas' {FormColorPicker},
  Hope.Common.JSON in 'Common\Hope.Common.JSON.pas',
  Hope.Common.MimeTypes in 'Common\Hope.Common.MimeTypes.pas',
  Hope.Compiler in 'Compiler\Hope.Compiler.pas',
  Hope.DataModule in 'DataModules\Hope.DataModule.pas' {DataModuleCommon: TDataModule},
  Hope.Dialog in 'Forms\Dialogs\Hope.Dialog.pas' {FormDialog},
  Hope.Dialog.FindClass in 'Forms\Dialogs\Hope.Dialog.FindClass.pas' {FormFindClass},
  Hope.Dialogs.CodeTemplates in 'Forms\Dialogs\Hope.Dialogs.CodeTemplates.pas' {FormCodeTemplates},
  Hope.Dialogs.FindInFiles in 'Forms\Dialogs\Hope.Dialogs.FindInFiles.pas' {FormFindInFiles},
  Hope.Dialogs.FindReplace in 'Forms\Dialogs\Hope.Dialogs.FindReplace.pas' {FormFind},
  Hope.Dialogs.GotoLineNumber in 'Forms\Dialogs\Hope.Dialogs.GotoLineNumber.pas' {FormGotoLineNumber},
  Hope.Dialogs.NewMore in 'Forms\Dialogs\Hope.Dialogs.NewMore.pas' {FormObjectGallery},
  Hope.Dialogs.Preferences in 'Forms\Dialogs\Hope.Dialogs.Preferences.pas' {FormPreferences},
  Hope.Dialogs.ProjectOptions in 'Forms\Dialogs\Hope.Dialogs.ProjectOptions.pas' {FormProjectOptions},
  Hope.Docking.Form in 'Forms\Docking\Hope.Docking.Form.pas' {FormDockable},
  Hope.Docking.Host in 'Forms\Docking\Hope.Docking.Host.pas' {FormDockHost},
  Hope.DockingUtils in 'Utils\Hope.DockingUtils.pas',
  Hope.Editor in 'Forms\Editor\Hope.Editor.pas' {FormEditor},
  Hope.History in 'History\Hope.History.pas',
  Hope.Main in 'Forms\Hope.Main.pas' {FormMain},
  Hope.MessageWindow in 'Forms\MessageWindow\Hope.MessageWindow.pas' {FormMessageWindow},
  Hope.MessageWindow.Compiler in 'Forms\MessageWindow\Hope.MessageWindow.Compiler.pas' {FormCompilerMessages},
  Hope.MessageWindow.FindInFiles in 'Forms\MessageWindow\Hope.MessageWindow.FindInFiles.pas' {FormMessagesFindInFiles},
  Hope.MessageWindow.Output in 'Forms\MessageWindow\Hope.MessageWindow.Output.pas' {FormOutputMessages},
  Hope.Paths in 'Hope.Paths.pas',
  Hope.Project in 'Project\Hope.Project.pas',
  Hope.Project.Files in 'Project\Hope.Project.Files.pas',
  Hope.Project.List in 'Project\Hope.Project.List.pas',
  Hope.Project.Options in 'Project\Hope.Project.Options.pas',
  Hope.ProjectManager in 'Forms\Hope.ProjectManager.pas' {FormProjectManager},
  Hope.UnicodeExplorer in 'Forms\Hope.UnicodeExplorer.pas' {FormUnicodeExplorer},
  Hope.UnitManager in 'Forms\Hope.UnitManager.pas' {FormUnitManager},
  Hope.WelcomePage in 'Forms\Hope.WelcomePage.pas' {FormWelcomePage},
  Hope.EditorList in 'Utils\Hope.EditorList.pas',
  Hope.Buffer in 'Buffer\Hope.Buffer.pas',
  Hope.Common.FileUtilities in 'Common\Hope.Common.FileUtilities.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleCommon, DataModuleCommon);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.

