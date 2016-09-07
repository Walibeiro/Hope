unit Hope.Common.JSON;

interface

{$I Hope.inc}

uses
  System.SysUtils, System.StrUtils, System.Classes, System.Contnrs,
  System.Generics.Collections, dwsJson;

type
  EHopeJsonException = class(Exception);

  THopeJsonBase = class(TInterfacedPersistent, IStreamPersist)
  protected
    class function GetPreferredName: string; virtual;

    procedure ReadJson(const JsonValue: TdwsJsonObject); virtual; abstract;
    procedure WriteJson(const JsonValue: TdwsJsonObject); virtual; abstract;

    procedure AssignTo(Dest: TPersistent); override;

    procedure LoadFromContainer(Text: string); virtual;
  public
    procedure LoadFromFile(const FileName: TFileName); virtual;
    procedure SaveToFile(const FileName: TFileName); virtual;

    procedure LoadFromStream(Stream: TStream); virtual;
    procedure SaveToStream(Stream: TStream); virtual;

    procedure LoadFromString(const Text: string); virtual;
    function SaveToString: string; virtual;

    procedure LoadFromJson(const RootNode: TdwsJsonObject; Optional: Boolean = False); overload; virtual;
    procedure LoadFromJson(const Name: string; const RootNode: TdwsJsonObject; Optional: Boolean = False); overload; virtual;

    procedure SaveToJson(const Root: TdwsJsonObject); overload; virtual;
    procedure SaveToJson(const Name: string; const Root: TdwsJsonObject); overload; virtual;

    property PreferredName: string read GetPreferredName;
  end;

  TdwsJSONObjectHelper = class helper for TdwsJSONObject
    function GetValue(Name: string; DefaultValue: Integer): Integer; overload;
    function GetValue(Name: string; DefaultValue: Double): Double; overload;
    function GetValue(Name: string; DefaultValue: Boolean): Boolean; overload;
    function GetValue(Name: string; DefaultValue: string): string; overload;
    function GetArray(Name: string; out JsonArray: TdwsJSONArray): Boolean; overload;
    function GetObject(Name: string; out JsonObject: TdwsJSONObject): Boolean; overload;
  end;

implementation

uses
  System.AnsiStrings, dwsUtils, dwsXPlatform;

resourcestring
  RStrJsonWriteErrorJsonValueNil = 'Failed to write Json element, item node was nil.';
  RStrJsonReadErrorJsonValueNil = 'Failed to read Json element, item node was nil.';
  RStrJsonReadErrorContainer = 'Failed to read container element!';
  RStrJsonReadErrorTag = 'Failed to read Json element, expected tag %s';
  RStrFailedToWriteJson = 'Failed to write Json element: %s';


{ TdwsJSONObjectHelper }

function TdwsJSONObjectHelper.GetValue(Name: string; DefaultValue: Integer): Integer;
var
  Value: TdwsJsonValue;
begin
  Value := Self.Items[Name];
  if Value is TdwsJsonImmediate then
    Result := TdwsJsonImmediate(Value).AsInteger
  else
    Result :=  DefaultValue;
end;

function TdwsJSONObjectHelper.GetValue(Name: string; DefaultValue: Double): Double;
var
  Value: TdwsJsonValue;
begin
  Value := Self.Items[Name];
  if Value is TdwsJsonImmediate then
    Result := TdwsJsonImmediate(Value).AsNumber
  else
    Result :=  DefaultValue;
end;

function TdwsJSONObjectHelper.GetValue(Name: string; DefaultValue: Boolean): Boolean;
var
  Value: TdwsJsonValue;
begin
  Value := Self.Items[Name];
  if Value is TdwsJsonImmediate then
    Result := TdwsJsonImmediate(Value).AsBoolean
  else
    Result :=  DefaultValue;
end;

function TdwsJSONObjectHelper.GetValue(Name: string; DefaultValue: string): string;
var
  Value: TdwsJsonValue;
begin
  Value := Self.Items[Name];
  if Value is TdwsJsonImmediate then
    Result := TdwsJsonImmediate(Value).AsString
  else
    Result :=  DefaultValue;
end;

function TdwsJSONObjectHelper.GetArray(Name: string; out JsonArray: TdwsJSONArray): Boolean;
var
  Value: TdwsJsonValue;
begin
  Value := Self.Items[Name];
  Result := Value is TdwsJsonArray;
  if Result then
    JsonArray := TdwsJsonArray(Value)
end;

function TdwsJSONObjectHelper.GetObject(Name: string;
  out JsonObject: TdwsJSONObject): Boolean;
var
  Value: TdwsJsonValue;
begin
  Value := Self.Items[Name];
  Result := Value is TdwsJsonObject;
  if Result then
    JsonObject := TdwsJsonObject(Value)
end;


{ THopeJsonBase }

procedure THopeJsonBase.AssignTo(Dest: TPersistent);
var
  MemoryStream: TMemoryStream;
begin
  if Dest.ClassType = ClassType then
  begin
    MemoryStream := TMemoryStream.Create;
    try
      // store to stream
      SaveToStream(MemoryStream);

      // load from stream
      MemoryStream.Position := 0;
      THopeJsonBase(Dest).LoadFromStream(MemoryStream);
    finally
      MemoryStream.Free;
    end;
  end
  else
    inherited;
end;

class function THopeJsonBase.GetPreferredName: string;
begin
  Result := ''
end;

procedure THopeJsonBase.LoadFromFile(const FileName: TFileName);
var
  Text: string;
begin
  Text := LoadTextFromFile(Filename);
  LoadFromContainer(Text);
end;

procedure THopeJsonBase.SaveToFile(const FileName: TFileName);
var
  Root: TdwsJsonObject;
  Text: string;
begin
  Root := TdwsJsonObject.Create;
  try
    WriteJson(Root);
    Text := '"HOPE" : ' + Root.ToBeautifiedString;
    SaveTextToUTF8File(FileName, Text);
  finally
    FreeAndNil(Root);
  end;
end;

procedure THopeJsonBase.LoadFromStream(Stream: TStream);
var
  Text: string;
begin
  Text := LoadTextFromStream(Stream);
  LoadFromContainer(Text);
end;

procedure THopeJsonBase.SaveToStream(Stream: TStream);
var
  Root: TdwsJsonObject;
  Text: string;
  StringStream: TStringStream;
begin
  Root := TdwsJsonObject.Create;
  try
    WriteJson(Root);
    Text := {'"HOPE" : ' +} Root.ToBeautifiedString;
    StringStream := TStringStream.Create(Text);
    try
      Stream.CopyFrom(StringStream, StringStream.Size);
    finally
      StringStream.Free;
    end;
  finally
    FreeAndNil(Root);
  end;
end;

procedure THopeJsonBase.LoadFromString(const Text: string);
var
  Root: TdwsJsonValue;
begin
  Root := TdwsJsonValue.ParseString(Text);

  if not (Root is TdwsJsonObject) then
    raise EHopeJsonException.Create(RStrJsonReadErrorJsonValueNil);

  ReadJson(TdwsJsonObject(Root));
end;

function THopeJsonBase.SaveToString: string;
var
  Root: TdwsJsonObject;
begin
  Root := TdwsJsonObject.Create;
  try
    WriteJson(Root);
    Result := Root.ToString;
  finally
    FreeAndNil(Root);
  end;
end;

procedure THopeJsonBase.LoadFromJson(const Name: string;
  const RootNode: TdwsJsonObject; Optional: Boolean);
var
  JsonValue: TdwsJsonValue;
begin
  // ensure the root node is not nil
  if not Assigned(RootNode) then
    raise EHopeJsonException.Create(RStrJsonReadErrorJsonValueNil);

  // select element node (and either raise error or exit if not found)
  JsonValue := RootNode.Items[Name];
  if not (JsonValue is TdwsJsonObject) then
    if Optional then
      Exit
    else
      raise EHopeJsonException.CreateFmt(RStrJsonReadErrorTag, [Name]);

  // now read content
  ReadJson(TdwsJsonObject(JsonValue));
end;

procedure THopeJsonBase.LoadFromJson(const RootNode: TdwsJsonObject;
  Optional: Boolean = False);
begin
  LoadFromJson(PreferredName, RootNode, Optional);
end;

procedure THopeJsonBase.LoadFromContainer(Text: string);
var
  Value: TdwsJsonValue;
begin
(*
  if not StrBeginsWith(Text, '"HOPE" : ') then
    raise EHopeJsonException.Create(RStrJsonReadErrorContainer);

  Delete(Text, 1, 10);
*)

  Value := TdwsJSONValue.ParseString(Text);
  try
    // now load inner JSON data
    ReadJson(TdwsJsonObject(Value));
  finally
    FreeAndNil(Value);
  end;
end;

procedure THopeJsonBase.SaveToJson(const Name: string; const Root: TdwsJsonObject);
begin
  WriteJson(Root.AddObject(Name));
end;

procedure THopeJsonBase.SaveToJson(const Root: TdwsJsonObject);
begin
  SaveToJson(PreferredName, Root);
end;

end.
