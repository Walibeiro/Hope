unit Hope.ColorPicker;

interface

{$I Hope.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Clipbrd,
  Vcl.StdCtrls, Vcl.Samples.Spin,

  GR32, GR32_Image, GR32_ColorPicker;

type
  TFormColorPicker = class(TForm)
    ButtonCopy: TButton;
    ButtonPickColor: TButton;
    ColorPickerGTK: TColorPickerGTK;
    EditColor: TEdit;
    LabelBlue: TLabel;
    LabelColor: TLabel;
    LabelGreen: TLabel;
    LabelRed: TLabel;
    LabelWebColor: TLabel;
    SpinEditBlue: TSpinEdit;
    SpinEditGreen: TSpinEdit;
    SpinEditRed: TSpinEdit;
    procedure ButtonCopyClick(Sender: TObject);
    procedure SpinEditColorChange(Sender: TObject);
    procedure EditColorChange(Sender: TObject);
    procedure EditColorKeyPress(Sender: TObject; var Key: Char);
    procedure ColorPickerGTKChanged(Sender: TObject);
    procedure ButtonPickColorClick(Sender: TObject);
    procedure ScreenColorPickerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    FScreenColorPickerForm: TScreenColorPickerForm;
    procedure UpdateColor(Color: TColor32);
  end;

implementation

{$R *.dfm}

uses
  GR32_VectorUtils;

{ TFormColorPicker }

procedure TFormColorPicker.ButtonCopyClick(Sender: TObject);
begin
  Clipboard.AsText := EditColor.Text;
end;

procedure TFormColorPicker.ButtonPickColorClick(Sender: TObject);
begin
  FScreenColorPickerForm := TScreenColorPickerForm.Create(Application);
  try
    FScreenColorPickerForm.OnMouseMove := ScreenColorPickerMouseMove;
    if FScreenColorPickerForm.ShowModal = mrOk then
      UpdateColor(FScreenColorPickerForm.SelectedColor);
  finally
    FreeAndNil(FScreenColorPickerForm);
  end;
end;

procedure TFormColorPicker.ColorPickerGTKChanged(Sender: TObject);
begin
  UpdateColor(ColorPickerGTK.SelectedColor);
end;

procedure TFormColorPicker.ScreenColorPickerMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  UpdateColor(FScreenColorPickerForm.SelectedColor);
end;

procedure TFormColorPicker.EditColorChange(Sender: TObject);
var
  HexValue: string;
begin
  HexValue := StringReplace(EditColor.Text, '#', '$', []);
  UpdateColor(StrToInt(HexValue));
end;

procedure TFormColorPicker.EditColorKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['#', '0'..'9', 'a'..'f', 'A'..'F']) then
    Key := #0;
end;

procedure TFormColorPicker.SpinEditColorChange(Sender: TObject);
begin
  EditColor.OnChange := nil;
  EditColor.Text := '#' +
    IntToHex(SpinEditRed.Value, 2) +
    IntToHex(SpinEditGreen.Value, 2) +
    IntToHex(SpinEditBlue.Value, 2);
  EditColor.OnChange := EditColorChange;
end;

procedure TFormColorPicker.UpdateColor(Color: TColor32);
var
  R, G, B: Byte;
begin
  EditColor.OnChange := nil;
  SpinEditRed.OnChange := nil;
  SpinEditGreen.OnChange := nil;
  SpinEditBlue.OnChange := nil;

  Color32ToRGB(Color, R, G, B);
  ColorPickerGTK.SelectedColor := Color;

  SpinEditRed.Value := R;
  SpinEditGreen.Value := G;
  SpinEditBlue.Value := B;

  EditColor.Text := '#' + IntToHex(R, 2) + IntToHex(G, 2) + IntToHex(B, 2);
  EditColor.Color := WinColor(Color);
  if Intensity(Color) < 128 then
    EditColor.Font.Color := clWhite
  else
    EditColor.Font.Color := clBlack;

  SpinEditRed.OnChange := SpinEditColorChange;
  SpinEditGreen.OnChange := SpinEditColorChange;
  SpinEditBlue.OnChange := SpinEditColorChange;
  EditColor.OnChange := EditColorChange;
end;

end.
