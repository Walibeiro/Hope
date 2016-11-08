unit Hope.EditorList;

interface

uses
  System.Classes, System.SysUtils, System.Contnrs, Hope.Editor;

type
  EEditorList = class(Exception);

  TEditorList = class
  private
    FList: TObjectList;
    function GetCount: Integer;
    function GetEditor(Index: Integer): TFormEditor;
  public
    constructor Create;
    destructor Destroy; override;

    function Add(Editor: TFormEditor): Integer;
    procedure Delete(Index: Integer);

    function GetEditorForFileName(FileName: TFileName): TFormEditor;

    property Editor[Index: Integer]: TFormEditor read GetEditor; default;
    property Count: Integer read GetCount;
  end;

implementation

uses
  dwsUtils;

{ TEditorList }

constructor TEditorList.Create;
begin
  inherited;

  FList := TObjectList.Create(True);
end;

destructor TEditorList.Destroy;
begin
  FList.Free;

  inherited;
end;

function TEditorList.Add(Editor: TFormEditor): Integer;
begin
  Assert(Editor is TFormEditor);
  Result := FList.Add(Editor);
end;

procedure TEditorList.Delete(Index: Integer);
begin
  FList.Delete(Index);
end;

function TEditorList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TEditorList.GetEditor(Index: Integer): TFormEditor;
begin
  if (Index < 0) or (Index >= FList.Count) then
    raise EEditorList.CreateFmt('Index exceeded bounds (%d)', [Index]);

  Result := TFormEditor(FList[Index]);
end;

function TEditorList.GetEditorForFileName(FileName: TFileName): TFormEditor;
var
  Index: Integer;
begin
  Result := nil;
  for Index := 0 to FList.Count - 1 do
    if UnicodeSameText(TFormEditor(FList[Index]).FileName, FileName) then
      Exit(TFormEditor(FList[Index]));
end;

end.

