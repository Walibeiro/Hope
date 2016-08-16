unit Hope.AsciiChart;

interface

{$I Hope.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus,
  Vcl.Samples.Spin, Vcl.ToolWin, Vcl.ComCtrls, Vcl.Buttons, Vcl.ActnList,
  System.Actions;

type
  TCharacterButton = class(TSpeedButton)
  private
    FShowHex: Boolean;
  protected
    procedure Paint; override;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    constructor Create(AOwner: TComponent); override;

    property ShowHex: Boolean read FShowHex write FShowHex;
  end;

  TFormAsciiChart = class(TForm)
    ActionCharDec: TAction;
    ActionCharHex: TAction;
    ActionCharHigh: TAction;
    ActionCharLow: TAction;
    ActionFontSize10: TAction;
    ActionFontSize12: TAction;
    ActionFontSize8: TAction;
    Actions: TActionList;
    ButtonCharDec: TToolButton;
    ButtonCharHex: TToolButton;
    ButtonCharHigh: TToolButton;
    ButtonCharLow: TToolButton;
    ButtonsFontSize: TUpDown;
    ComboBoxFontName: TComboBox;
    EditChars: TEdit;
    EditFontSize: TEdit;
    MenuItemCharAsDec: TMenuItem;
    MenuItemCharAsHex: TMenuItem;
    MenuItemFontSize10: TMenuItem;
    MenuItemFontSize12: TMenuItem;
    MenuItemFontSize8: TMenuItem;
    MenuItemSeparator1: TMenuItem;
    MenuItemSeparator2: TMenuItem;
    MenuItemShowHighCharacters: TMenuItem;
    MenuItemShowLowCharacters: TMenuItem;
    PopupMenuContext: TPopupMenu;
    Separator1: TToolButton;
    Separator2: TToolButton;
    ToolBar: TToolBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure ActionFontSize8Execute(Sender: TObject);
    procedure ActionFontSize10Execute(Sender: TObject);
    procedure ActionFontSize12Execute(Sender: TObject);
    procedure ActionCharDecExecute(Sender: TObject);
    procedure ActionCharHexExecute(Sender: TObject);
    procedure ActionCharLowExecute(Sender: TObject);
    procedure ActionCharHighExecute(Sender: TObject);
    procedure ActionFontSizeUpdate(Sender: TObject);
    procedure ActionCharDecUpdate(Sender: TObject);
    procedure ActionCharHexUpdate(Sender: TObject);
    procedure ActionCharLowUpdate(Sender: TObject);
    procedure ActionCharHighUpdate(Sender: TObject);
    procedure ToolBarResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure EditFontSizeChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboBoxFontNameEnter(Sender: TObject);
    procedure ComboBoxFontNameChange(Sender: TObject);
  private
    FDisplayFontSize: Integer;
    FShowHex: Boolean;
    FStartCharacter: Integer;
    FFontName: string;
    FButtonArray: array [0..7, 0..15] of TCharacterButton;
    procedure SetDisplayFontSize(const Size: Integer);
    procedure SetStartCharacter(const Value: Integer);
    procedure SetShowHex(const Value: Boolean);
    procedure UpdateButtons;
    procedure GetFonts;
  end;

implementation

{$R *.dfm}

const
  CMinimumDisplayFontSize = 4;
  CMaximumDisplayFontSize = 150;

{ TCharacterButton }

constructor TCharacterButton.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOpaque];
end;

procedure TCharacterButton.Paint;
var
  Text: string;
begin
  Canvas.Lock;
  try
    inherited;

    if ShowHex then
      Text := IntToHex(Tag, 2)
    else
      Text := IntToStr(Tag);

    with Canvas do
    begin
      Font.Name := 'Tahoma';  // do not localize
      Font.Size := 9;
      Font.Color := clGrayText;
      Font.Color := clGray;
      TextOut(4, (Height - TextHeight(Text)) div 2, Text);
    end;
  finally
    Canvas.Unlock;
  end;
end;

procedure TCharacterButton.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;


{ TFormAsciiChart }

procedure TFormAsciiChart.FormCreate(Sender: TObject);
var
  X, Y: Integer;
begin
  FDisplayFontSize := 10;
  FFontName := 'Segoe UI';
  FShowHex := False;
  FStartCharacter := 0;

  for X := 0 to 7 do
    for Y := 0 to 15 do
    begin
      FButtonArray[X, Y] := TCharacterButton.Create(Self);
      FButtonArray[X, Y].Width := ClientWidth div 8;
      FButtonArray[X, Y].Height := (ClientHeight - ToolBar.Height - 2) div 16;
      FButtonArray[X, Y].Parent := Self;
      FButtonArray[X, Y].Left := X * FButtonArray[X, Y].Width;
      FButtonArray[X, Y].Top := ToolBar.Height + 2 + Y * FButtonArray[X, Y].Height;
      FButtonArray[X, Y].OnClick := ButtonClick;
      FButtonArray[X, Y].Font.Name := FFontName;
      FButtonArray[X, Y].Font.Size := FDisplayFontSize;
      FButtonArray[X, Y].ShowHex := FShowHex;
    end;

  GetFonts;
  ButtonsFontSize.Max := CMaximumDisplayFontSize;
  ButtonsFontSize.Min := CMinimumDisplayFontSize;
  ComboBoxFontName.ItemIndex := ComboBoxFontName.Items.IndexOf(FFontName);
  UpdateButtons;
end;

procedure TFormAsciiChart.FormDestroy(Sender: TObject);
var
  X, Y: Integer;
begin
  for X := 0 to 7 do
    for Y := 0 to 15 do
      FButtonArray[X, Y].Free;
end;

procedure TFormAsciiChart.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Key := 0;
    Close;
  end;
end;

procedure TFormAsciiChart.FormResize(Sender: TObject);
var
  X, Y: Integer;
begin
  for X := 0 to 7 do
    for Y := 0 to 15 do
    begin
      FButtonArray[X, Y].Width := ClientWidth div 8;
      FButtonArray[X, Y].Height := (ClientHeight - ToolBar.Height - 2) div 16;
      FButtonArray[X, Y].Left := X * FButtonArray[X, Y].Width;
      FButtonArray[X, Y].Top := ToolBar.Height + 2 + Y * FButtonArray[X, Y].Height;
    end;
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
                       FontType: Integer; Data: Pointer): Integer; stdcall;
var
  S: TStrings;
  Temp: string;
begin
  S := TStrings(Data);
  Assert(Assigned(S));

  Temp := LogFont.lfFaceName;
  if (S.Count = 0) or not SameText(S[S.Count - 1], Temp) then
    S.Add(Temp);
  Result := 1;
end;

procedure TFormAsciiChart.GetFonts;
var
  DC: HDC;
  LFont: TLogFont;
begin
  FillChar(LFont, SizeOf(LFont), 0);
  LFont.lfCharset := DEFAULT_CHARSET;

  DC := GetDC(0);
  try
    EnumFontFamiliesEx(DC, LFont, @EnumFontsProc, Longint(ComboBoxFontName.Items), 0);
  finally
    ReleaseDC(0, DC);
  end;

  ComboBoxFontName.Sorted := True;
end;

procedure TFormAsciiChart.SetDisplayFontSize(const Size: Integer);
begin
  if Size <> FDisplayFontSize then
  begin
    FDisplayFontSize := Size;
    EditFontSize.Text := IntToStr(Size);
    UpdateButtons;
  end;
end;

procedure TFormAsciiChart.SetShowHex(const Value: Boolean);
begin
  if Value <> FShowHex then
  begin
    FShowHex := Value;
    UpdateButtons;
  end;
end;

procedure TFormAsciiChart.SetStartCharacter(const Value: Integer);
begin
  if Value <> FStartCharacter then
  begin
    FStartCharacter := Value;
    UpdateButtons;
  end;
end;

procedure TFormAsciiChart.ToolBarResize(Sender: TObject);
begin
  EditChars.Width := (Sender as TControl).ClientWidth - EditChars.Left;
end;

procedure TFormAsciiChart.UpdateButtons;
const
  CHintLow: array [0..31] of string =
    ('Null', 'Start of Header', 'Start of Text', 'End of Text',
    'End of Transmission', 'Enquiry', 'Acknowledge', 'Bell',
    'Backspace', 'Horizontal Tab', 'Linefeed', 'Vertical Tab',
    'Form Feed', 'Carriage Return', 'Shift Out', 'Shift in',
    'Data Link Escape', 'Device Control 1 (XON resume)', 'Device Control 2',
    'Device Control 3 (XOFF pause)', 'Device Control 4', 'Negative Acknowledge',
    'Synchronous Idle', 'End Transmission Block', 'Cancel', 'End of Medium',
    'Substitute', 'Escape', 'File Separator', 'Group Separator',
    'Record Separator', 'Unit Separator');
const
  CCaptionLow: array [0..31] of string = ('NUL', 'SOH', 'STX', 'ETX', 'EOT',
    'ENQ', 'ACK', 'BEL', 'BS', 'TAB', 'LF', 'VT', 'FF', 'CR', 'SO', 'SI',
    'DLE', 'DC1', 'DC2', 'DC3', 'DC4', 'NAK', 'SYN', 'ETB', 'CAN', 'EM',
    'SUB', 'ESC', 'FS', 'GS', 'RS', 'US');
var
  X, Y, CharIndex: Integer;
begin
  LockWindowUpdate(Self.Handle);
  for X := 0 to 7 do
    for Y := 0 to 15 do
    begin
      CharIndex := FStartCharacter + X * 16 + Y;
      FButtonArray[X, Y].Tag := CharIndex;
      if (FStartCharacter = 0) and (CharIndex < 32) then
      begin
        FButtonArray[X, Y].Hint := CHintLow[CharIndex];
        FButtonArray[X, Y].Caption := CCaptionLow[CharIndex];
      end
      else
      begin
        FButtonArray[X, Y].Hint := 'Character: ' + Char(CharIndex);
        FButtonArray[X, Y].Caption := Char(CharIndex);
      end;

      FButtonArray[X, Y].Font.Name := FFontName;
      FButtonArray[X, Y].Font.Size := FDisplayFontSize;
      FButtonArray[X, Y].ShowHex := FShowHex;
      FButtonArray[X, Y].Invalidate;
    end;
  LockWindowUpdate(0);
end;

procedure TFormAsciiChart.ActionFontSize8Execute(Sender: TObject);
begin
  SetDisplayFontSize(8);
end;

procedure TFormAsciiChart.ActionFontSizeUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked := False;
  case FDisplayFontSize of
    8:
      if Sender = ActionFontSize8 then
        (Sender as TAction).Checked := True;
    10:
      if Sender = ActionFontSize10 then
        (Sender as TAction).Checked := True;
    12:
      if Sender = ActionFontSize12 then
        (Sender as TAction).Checked := True;
  end;
end;

procedure TFormAsciiChart.ActionCharHighExecute(Sender: TObject);
begin
  SetStartCharacter(128);
end;

procedure TFormAsciiChart.ActionCharHighUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked := (FStartCharacter = 128);
end;

procedure TFormAsciiChart.ActionCharLowExecute(Sender: TObject);
begin
  SetStartCharacter(0);
end;

procedure TFormAsciiChart.ActionCharLowUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked := (FStartCharacter = 0);
end;

procedure TFormAsciiChart.ActionCharDecExecute(Sender: TObject);
begin
  SetShowHex(False);
end;

procedure TFormAsciiChart.ActionCharDecUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked := not FShowHex;
end;

procedure TFormAsciiChart.ActionCharHexExecute(Sender: TObject);
begin
  SetShowHex(True);
end;

procedure TFormAsciiChart.ActionCharHexUpdate(Sender: TObject);
begin
  (Sender as TAction).Checked := FShowHex;
end;

procedure TFormAsciiChart.ActionFontSize10Execute(Sender: TObject);
begin
  SetDisplayFontSize(10);
end;

procedure TFormAsciiChart.ActionFontSize12Execute(Sender: TObject);
begin
  SetDisplayFontSize(12);
end;

procedure TFormAsciiChart.ButtonClick(Sender: TObject);
begin
  EditChars.SelText := Char(TComponent(Sender).Tag);
end;

procedure TFormAsciiChart.ComboBoxFontNameChange(Sender: TObject);
begin
  FFontName := ComboBoxFontName.Text;
  EditChars.Font.Name := FFontName;
  UpdateButtons;
end;

procedure TFormAsciiChart.ComboBoxFontNameEnter(Sender: TObject);
begin
  ComboBoxFontName.Perform(CB_SETDROPPEDWIDTH, 175, 0);
end;

procedure TFormAsciiChart.EditFontSizeChange(Sender: TObject);
var
  NewFontSize: Integer;
begin
  NewFontSize := StrToIntDef(EditFontSize.Text, FDisplayFontSize);

  if (NewFontSize < CMinimumDisplayFontSize) or
     (NewFontSize > CMaximumDisplayFontSize) or
     (NewFontSize = FDisplayFontSize) then
    Exit;

  FDisplayFontSize := NewFontSize;
  UpdateButtons;
end;

end.
