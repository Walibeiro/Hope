unit Hope.Editor;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ToolWin, SynEdit, Hope.DataModule,
  Hope.Project.Local;

type
  TStatusBar = class(Vcl.ComCtrls.TStatusBar)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TFormEditor = class(TForm)
    Editor: TSynEdit;
    StatusBar: TStatusBar;
    ToolBarMacro: TToolBar;
    ToolButtonPlay: TToolButton;
    ToolButtonRecord: TToolButton;
    ToolButtonStop: TToolButton;
    procedure EditorGutterPaint(Sender: TObject; aLine, X, Y: Integer);
    procedure EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure EditorChange(Sender: TObject);
  private
    FFileName: TFileName;
    FShortFileName: TFileName;
    FExtension: string;
    FNeedsSync: Boolean;
    procedure SetFileName(const Value: TFileName);
    procedure FileNameChanged;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    procedure AfterConstruction; override;

    procedure EditorToBuffer;
    procedure BufferToEditor; overload;
    procedure BufferToEditor(Text: string); overload;

    property FileName: TFileName read FFileName write SetFileName;
  end;

implementation

uses
  dwsUtils, dwsXPlatform, Hope.Main;

{$R *.dfm}

{ TStatusBar }

constructor TStatusBar.Create(AOwner: TComponent);
begin
  inherited;

  ControlStyle := ControlStyle + [csAcceptsControls];
end;


{ TFormEditor }

procedure TFormEditor.AfterConstruction;
begin
  inherited;

  ToolBarMacro.Parent := StatusBar;
  ToolBarMacro.Height := 16;
  ToolBarMacro.ButtonWidth := 16;
  ToolBarMacro.ButtonHeight := 14;
  ToolBarMacro.Left := 1;
  ToolBarMacro.Top := 3;
  ToolBarMacro.Images := DataModuleCommon.ImageList12;
end;

procedure TFormEditor.EditorChange(Sender: TObject);
begin
  DataModuleCommon.BackgroundCompiler.Invalidate;
end;

procedure TFormEditor.EditorGutterPaint(Sender: TObject; aLine, X, Y: Integer);
var
  StrLineNumber: string;
  LineNumberRect: TRect;
  GutterWidth, Offset: Integer;
  OldFont: TFont;
begin
  with TSynEdit(Sender), Canvas do
  begin
    Brush.Style := bsClear;
    GutterWidth := Gutter.Width - 5;
    if (ALine = 1) or (ALine = CaretY) or ((ALine mod 10) = 0) then
    begin
      StrLineNumber := IntToStr(ALine);
      LineNumberRect := Rect(x, y, GutterWidth, y + LineHeight);
      OldFont := TFont.Create;
      try
        OldFont.Assign(Canvas.Font);
        Canvas.Font := Gutter.Font;
        Canvas.TextRect(LineNumberRect, StrLineNumber, [tfVerticalCenter,
          tfSingleLine, tfRight]);
        Canvas.Font := OldFont;
      finally
        OldFont.Free;
      end;
    end
    else
    begin
      Canvas.Pen.Color := Gutter.Font.Color;
      if (ALine mod 5) = 0 then
        Offset := 5
      else
        Offset := 2;
      Inc(y, LineHeight div 2);
      Canvas.MoveTo(GutterWidth - Offset, y);
      Canvas.LineTo(GutterWidth, y);
    end;
  end;
end;

procedure TFormEditor.EditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if [scCaretX, scCaretY] * Changes <> [] then
  begin
    StatusBar.Panels[1].Text := Format('%d : %d', [TSynEdit(Sender).CaretX,
      TSynEdit(Sender).CaretY]);
  end;
end;

procedure TFormEditor.FileNameChanged;
begin
  if FileExists(FileName) then
    Editor.Text := DataModuleCommon.GetText(FileName);

  FShortFileName := ExtractFileName(FileName);
  if StrEndsWith(LowerCase(FShortFileName), '.pas') then
  begin
    FExtension := '.pas';
    Delete(FShortFileName, Length(FShortFileName) - 3, 4);
    Editor.Highlighter := DataModuleCommon.SynObjectPascal;
  end
  else
  if StrEndsWith(LowerCase(FShortFileName), '.hpr') then
  begin
    FExtension := '.hpr';
    Delete(FShortFileName, Length(FShortFileName) - 3, 4);
    Editor.Highlighter := DataModuleCommon.SynObjectPascal;
  end;

  Caption := FShortFileName;
end;

procedure TFormEditor.AssignTo(Dest: TPersistent);
var
  Bookmark: THopeBookmark;
  Index, X, Y: Integer;
begin
  if Dest is THopeOpenedFile then
  begin
    THopeOpenedFile(Dest).FileName := FileName;
    THopeOpenedFile(Dest).TopLine := Editor.TopLine;
    THopeOpenedFile(Dest).Line := Editor.CaretXY.Line;
    THopeOpenedFile(Dest).Character := Editor.CaretXY.Char;
    for Index := 0 to 9 do
      if Editor.GetBookMark(Index, X, Y) then
        THopeOpenedFile(Dest).Bookmarks.Add(THopeBookmark.Create(Index, X, Y));
  end
  else
    inherited;
end;

procedure TFormEditor.BufferToEditor(Text: string);
begin
  Editor.Text := Text;
  FNeedsSync := False;
end;

procedure TFormEditor.BufferToEditor;
begin
  Editor.Text := DataModuleCommon.MonitoredBuffer[FileName];
  FNeedsSync := False;
end;

procedure TFormEditor.EditorToBuffer;
begin
  if FNeedsSync then
  begin
    FNeedsSync := False;
    DataModuleCommon.MonitoredBuffer[FileName] := Editor.Text;;
  end;
end;

procedure TFormEditor.SetFileName(const Value: TFileName);
begin
  if FFileName <> Value then
  begin
    FFileName := Value;
    FileNameChanged;
  end;
end;

end.
