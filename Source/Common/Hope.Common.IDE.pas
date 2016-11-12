unit Hope.Common.IDE;

{$I Hope.inc}

interface

uses
  System.Classes, Vcl.Forms, dwsJson, Hope.Common.JSON;

type
  THopeCustomPosition = class(THopeJsonBase)
  private
    FLeft: Integer;
    FTop: Integer;
    FWidth: Integer;
    FHeight: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
  public
    procedure AfterConstruction; override;

    procedure SavePosition(Form: TForm);
    procedure LoadPosition(Form: TForm);
  end;

  THopePositionMain = class(THopeCustomPosition)
  protected
    class function GetPreferredName: string; override;
  end;

  THopePositions = class(THopeJsonBase)
  private
    FMain: THopePositionMain;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Main: THopePositionMain read FMain;
  end;

implementation

uses
  System.SysUtils,
  dwsXPlatform;

{ THopeCustomPosition }

procedure THopeCustomPosition.AfterConstruction;
begin
  inherited;

  FLeft := 0;
  FTop := 0;
  FWidth := 800;
  FHeight := 600;
end;

procedure THopeCustomPosition.LoadPosition(Form: TForm);
begin
  Form.SetBounds(FLeft, FTop, FWidth, FHeight);
end;

procedure THopeCustomPosition.SavePosition(Form: TForm);
begin
  FLeft := Form.Left;
  FTop := Form.Top;
  FWidth := Form.Width;
  FHeight := Form.Height;
end;

procedure THopeCustomPosition.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FLeft := JsonValue.GetValue('Left', FLeft);
  FTop := JsonValue.GetValue('Top', FTop);
  FWidth := JsonValue.GetValue('Width', FWidth);
  FHeight := JsonValue.GetValue('Height', FHeight);
end;

procedure THopeCustomPosition.WriteJson(const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('Left', FLeft);
  JsonValue.AddValue('Top', FTop);
  JsonValue.AddValue('Width', FWidth);
  JsonValue.AddValue('Height', FHeight);
end;


{ THopePositionMain }

class function THopePositionMain.GetPreferredName: string;
begin
  Result := 'Main';
end;


{ THopePositions }

procedure THopePositions.AfterConstruction;
begin
  inherited;

  FMain := THopePositionMain.Create;
end;

procedure THopePositions.BeforeDestruction;
begin
  FMain.Free;

  inherited;
end;

procedure THopePositions.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FMain.LoadFromJson(JsonValue, True);
end;

procedure THopePositions.WriteJson(const JsonValue: TdwsJSONObject);
begin
  FMain.SaveToJson(JsonValue);
end;

end.
