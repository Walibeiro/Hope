unit Hope.Common.Preferences;

interface

{$I Hope.inc}

uses
  dwsJSON, Hope.Common.JSON;

type
  THopePreferencesEditor = class(THopeJsonBase)
  private
    FAltSetsColumnMode: Boolean;
    FAutoIndent: Boolean;
    FAutoSizeMaxScrollWidth: Boolean;
    FDisableScrollArrows: Boolean;
    FDragDropEditing: Boolean;
    FDropFiles: Boolean;
    FEnhanceHomeKey: Boolean;
    FEnhanceEndKey: Boolean;
    FGroupUndo: Boolean;
    FHalfPageScroll: Boolean;
    FHideShowScrollbars: Boolean;
    FKeepCaretX: Boolean;
    FNoCaret: Boolean;
    FNoSelection: Boolean;
    FRightMouseMovesCursor: Boolean;
    FScrollByOneLess: Boolean;
    FScrollHintFollows: Boolean;
    FScrollPastEof: Boolean;
    FScrollPastEol: Boolean;
    FShowScrollHint: Boolean;
    FShowSpecialChars: Boolean;
    FSmartTabDelete: Boolean;
    FSmartTabs: Boolean;
    FSpecialLineDefaultFg: Boolean;
    FTabIndent: Boolean;
    FTabsToSpaces: Boolean;
    FTrimTrailingSpace: Boolean;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    property AltSetsColumnMode: Boolean read FAltSetsColumnMode write FAltSetsColumnMode;
    property AutoIndent: Boolean read FAutoIndent write FAutoIndent;
    property AutoSizeMaxScrollWidth: Boolean read FAutoSizeMaxScrollWidth write FAutoSizeMaxScrollWidth;
    property DisableScrollArrows: Boolean read FDisableScrollArrows write FDisableScrollArrows;
    property DragDropEditing: Boolean read FDragDropEditing write FDragDropEditing;
    property DropFiles: Boolean read FDropFiles write FDropFiles;
    property EnhanceHomeKey: Boolean read FEnhanceHomeKey write FEnhanceHomeKey;
    property EnhanceEndKey: Boolean read FEnhanceEndKey write FEnhanceEndKey;
    property GroupUndo: Boolean read FGroupUndo write FGroupUndo;
    property HalfPageScroll: Boolean read FHalfPageScroll write FHalfPageScroll;
    property HideShowScrollbars: Boolean read FHideShowScrollbars write FHideShowScrollbars;
    property KeepCaretX: Boolean read FKeepCaretX write FKeepCaretX;
    property NoCaret: Boolean read FNoCaret write FNoCaret;
    property NoSelection: Boolean read FNoSelection write FNoSelection;
    property RightMouseMovesCursor: Boolean read FRightMouseMovesCursor write FRightMouseMovesCursor;
    property ScrollByOneLess: Boolean read FScrollByOneLess write FScrollByOneLess;
    property ScrollHintFollows: Boolean read FScrollHintFollows write FScrollHintFollows;
    property ScrollPastEof: Boolean read FScrollPastEof write FScrollPastEof;
    property ScrollPastEol: Boolean read FScrollPastEol write FScrollPastEol;
    property ShowScrollHint: Boolean read FShowScrollHint write FShowScrollHint;
    property ShowSpecialChars: Boolean read FShowSpecialChars write FShowSpecialChars;
    property SmartTabDelete: Boolean read FSmartTabDelete write FSmartTabDelete;
    property SmartTabs: Boolean read FSmartTabs write FSmartTabs;
    property SpecialLineDefaultFg: Boolean read FSpecialLineDefaultFg write FSpecialLineDefaultFg;
    property TabIndent: Boolean read FTabIndent write FTabIndent;
    property TabsToSpaces: Boolean read FTabsToSpaces write FTabsToSpaces;
    property TrimTrailingSpace: Boolean read FTrimTrailingSpace write FTrimTrailingSpace;
  end;

  THopePreferencesEnvironment = class(THopeJsonBase)
  private
    FDefaultProjectPath: string;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    property DefaultProjectPath: string read FDefaultProjectPath write FDefaultProjectPath;
  end;

  THopePreferences = class(THopeJsonBase)
  private
    FEnvironment: THopePreferencesEnvironment;
    FEditor: THopePreferencesEditor;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Environment: THopePreferencesEnvironment read FEnvironment;
    property Editor: THopePreferencesEditor read FEditor;
  end;

implementation

{ THopePreferencesEditor }

class function THopePreferencesEditor.GetPreferredName: string;
begin
  Result := 'Editor';
end;

procedure THopePreferencesEditor.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FAltSetsColumnMode := JsonValue.GetValue('AltSetsColumnMode', FAltSetsColumnMode);
  FAutoIndent := JsonValue.GetValue('AutoIndent', FAutoIndent);
  FAutoSizeMaxScrollWidth := JsonValue.GetValue('AutoSizeMaxScrollWidth', FAutoSizeMaxScrollWidth);
  FDisableScrollArrows := JsonValue.GetValue('DisableScrollArrows', FDisableScrollArrows);
  FDragDropEditing := JsonValue.GetValue('DragDropEditing', FDragDropEditing);
  FDropFiles := JsonValue.GetValue('DropFiles', FDropFiles);
  FEnhanceHomeKey := JsonValue.GetValue('EnhanceHomeKey', FEnhanceHomeKey);
  FEnhanceEndKey := JsonValue.GetValue('EnhanceEndKey', FEnhanceEndKey);
  FGroupUndo := JsonValue.GetValue('GroupUndo', FGroupUndo);
  FHalfPageScroll := JsonValue.GetValue('HalfPageScroll', FHalfPageScroll);
  FHideShowScrollbars := JsonValue.GetValue('HideShowScrollbars', FHideShowScrollbars);
  FKeepCaretX := JsonValue.GetValue('KeepCaretX', FKeepCaretX);
  FNoCaret := JsonValue.GetValue('NoCaret', FNoCaret);
  FNoSelection := JsonValue.GetValue('NoSelection', FNoSelection);
  FRightMouseMovesCursor := JsonValue.GetValue('RightMouseMovesCursor', FRightMouseMovesCursor);
  FScrollByOneLess := JsonValue.GetValue('ScrollByOneLess', FScrollByOneLess);
  FScrollHintFollows := JsonValue.GetValue('ScrollHintFollows', FScrollHintFollows);
  FScrollPastEof := JsonValue.GetValue('ScrollPastEof', FScrollPastEof);
  FScrollPastEol := JsonValue.GetValue('ScrollPastEol', FScrollPastEol);
  FShowScrollHint := JsonValue.GetValue('ShowScrollHint', FShowScrollHint);
  FShowSpecialChars := JsonValue.GetValue('ShowSpecialChars', FShowSpecialChars);
  FSmartTabDelete := JsonValue.GetValue('SmartTabDelete', FSmartTabDelete);
  FSmartTabs := JsonValue.GetValue('SmartTabs', FSmartTabs);
  FSpecialLineDefaultFg := JsonValue.GetValue('SpecialLineDefaultFg', FSpecialLineDefaultFg);
  FTabIndent := JsonValue.GetValue('TabIndent', FTabIndent);
  FTabsToSpaces := JsonValue.GetValue('TabsToSpaces', FTabsToSpaces);
  FTrimTrailingSpace := JsonValue.GetValue('TrimTrailingSpace', FTrimTrailingSpace);
end;

procedure THopePreferencesEditor.WriteJson(const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('AltSetsColumnMode', FAltSetsColumnMode);
  JsonValue.AddValue('AutoIndent', FAutoIndent);
  JsonValue.AddValue('AutoSizeMaxScrollWidth', FAutoSizeMaxScrollWidth);
  JsonValue.AddValue('DisableScrollArrows', FDisableScrollArrows);
  JsonValue.AddValue('DragDropEditing', FDragDropEditing);
  JsonValue.AddValue('DropFiles', FDropFiles);
  JsonValue.AddValue('EnhanceHomeKey', FEnhanceHomeKey);
  JsonValue.AddValue('EnhanceEndKey', FEnhanceEndKey);
  JsonValue.AddValue('GroupUndo', FGroupUndo);
  JsonValue.AddValue('HalfPageScroll', FHalfPageScroll);
  JsonValue.AddValue('HideShowScrollbars', FHideShowScrollbars);
  JsonValue.AddValue('KeepCaretX', FKeepCaretX);
  JsonValue.AddValue('NoCaret', FNoCaret);
  JsonValue.AddValue('NoSelection', FNoSelection);
  JsonValue.AddValue('RightMouseMovesCursor', FRightMouseMovesCursor);
  JsonValue.AddValue('ScrollByOneLess', FScrollByOneLess);
  JsonValue.AddValue('ScrollHintFollows', FScrollHintFollows);
  JsonValue.AddValue('ScrollPastEof', FScrollPastEof);
  JsonValue.AddValue('ScrollPastEol', FScrollPastEol);
  JsonValue.AddValue('ShowScrollHint', FShowScrollHint);
  JsonValue.AddValue('ShowSpecialChars', FShowSpecialChars);
  JsonValue.AddValue('SmartTabDelete', FSmartTabDelete);
  JsonValue.AddValue('SmartTabs', FSmartTabs);
  JsonValue.AddValue('SpecialLineDefaultFg', FSpecialLineDefaultFg);
  JsonValue.AddValue('TabIndent', FTabIndent);
  JsonValue.AddValue('TabsToSpaces', FTabsToSpaces);
  JsonValue.AddValue('TrimTrailingSpace', FTrimTrailingSpace);
end;


{ THopePreferencesEnvironment }

class function THopePreferencesEnvironment.GetPreferredName: string;
begin
  Result := 'Environment';
end;

procedure THopePreferencesEnvironment.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FDefaultProjectPath := JsonValue.GetValue('Default Project Path', FDefaultProjectPath);
end;

procedure THopePreferencesEnvironment.WriteJson(
  const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('Default Project Path', FDefaultProjectPath);
end;


{ THopePreferences }

procedure THopePreferences.AfterConstruction;
begin
  inherited;

  FEnvironment := THopePreferencesEnvironment.Create;
  FEditor := THopePreferencesEditor.Create;
end;

procedure THopePreferences.BeforeDestruction;
begin
  FEditor.Free;
  FEnvironment.Free;

  inherited;
end;

procedure THopePreferences.ReadJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

  FEnvironment.LoadFromJson(JsonValue, True);
  FEditor.LoadFromJson(JsonValue, True);
end;

procedure THopePreferences.WriteJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

  FEnvironment.SaveToJson(JsonValue);
  FEditor.SaveToJson(JsonValue);
end;

end.
