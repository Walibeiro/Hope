unit Hope.Dialogs.GotoLineNumber;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, 
  Vcl.StdCtrls, SynEdit, Hope.Dialog;

type
  TFormGotoLineNumber = class(TFormDialog)
    ComboBoxLineNumber: TComboBox;
    GroupBoxLineNumber: TGroupBox;
    LabelNewLineNumber: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public


    procedure AddLineNumber(LineNumber: Integer);
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses Hope.Main, Hope.DataModule;

{ TFormGotoLineNumber }

procedure TFormGotoLineNumber.AfterConstruction;
begin
  inherited;

  ComboBoxLineNumber.Items.Assign(DataModuleCommon.Preferences.Search.RecentGotoLine);
end;

procedure TFormGotoLineNumber.AddLineNumber(LineNumber: Integer);
var
  Text: string;
  Index: Integer;
begin
  Text := IntToStr(LineNumber);

  // add line to combobox
  Index := ComboBoxLineNumber.Items.IndexOf(Text);
  if Index >= 0 then
  begin
    ComboBoxLineNumber.Items.Move(Index, 0);
    ComboBoxLineNumber.ItemIndex := 0;
  end
  else
    ComboBoxLineNumber.Items.Insert(0, Text);

  DataModuleCommon.Preferences.Search.RecentGotoLine.Assign(ComboBoxLineNumber.Items);
end;

procedure TFormGotoLineNumber.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Editor: TSynEdit;
  LineNumber: Integer;
begin
  Editor := FormMain.FocusedEditor;
  if not Assigned(Editor) then
    Exit;

  if TryStrToInt(ComboBoxLineNumber.Text, LineNumber) then
  begin
    // actually goto line
    Editor.GotoLineAndCenter(LineNumber);

    // add line number to combo box
    AddLineNumber(LineNumber);
  end;
end;

end.
