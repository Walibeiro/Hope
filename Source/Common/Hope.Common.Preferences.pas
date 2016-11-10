unit Hope.Common.Preferences;

interface

{$I Hope.inc}

uses
  System.Classes, System.UITypes, dwsJSON, Hope.Common.JSON;

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

  THopePreferencesSearch = class(THopeJsonBase)
  private
    FRecentSearch: TStringList;
    FRecentReplace: TStringList;
    FRecentGotoLine: TStringList;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property RecentSearch: TStringList read FRecentSearch;
    property RecentReplace: TStringList read FRecentReplace;
    property RecentGotoLine: TStringList read FRecentGotoLine;
  end;

  THopePreferencesRecent = class(THopeJsonBase)
  private
    FProjectCount: Integer;
    FUnitCount: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property ProjectCount: Integer read FProjectCount write FProjectCount;
    property UnitCount: Integer read FUnitCount write FUnitCount;
  end;

  THopePreferencesCodeSuggestions = class(THopeJsonBase)
  private
    FEnabled: Boolean;
    FShowReservedWords: Boolean;
    FAutoParenthesis: Boolean;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property Enabled: Boolean read FEnabled write FEnabled;
    property AutoParenthesis: Boolean read FAutoParenthesis write FAutoParenthesis;
    property ShowReservedWords: Boolean read FShowReservedWords write FShowReservedWords;
  end;

  THopePreferencesCodeInsight = class(THopeJsonBase)
  private
    FErrorInsight: Boolean;
    FCodeParametes: Boolean;
    FTooltipSymbolInsight: Boolean;
    FCodeTemplateCompletion: Boolean;
    FBlockCompletion: Boolean;
    FCodeSuggestions: THopePreferencesCodeSuggestions;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property CodeParametes: Boolean read FCodeParametes write FCodeParametes;
    property TooltipSymbolInsight: Boolean read FTooltipSymbolInsight write FTooltipSymbolInsight;
    property BlockCompletion: Boolean read FBlockCompletion write FBlockCompletion;
    property ErrorInsight: Boolean read FErrorInsight write FErrorInsight;
    property CodeTemplateCompletion: Boolean read FCodeTemplateCompletion write FCodeTemplateCompletion;
    property CodeSuggestions: THopePreferencesCodeSuggestions read FCodeSuggestions;
  end;

  THopePreferencesVersioningColors = class(THopeJsonBase)
  private
    FConflicted: TColor;
    FAdded: TColor;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property Conflicted: TColor read FConflicted write FConflicted;
    property Added: TColor read FAdded write FAdded;
  end;

  THopePreferencesVersioning = class(THopeJsonBase)
  private
    FColors: THopePreferencesVersioningColors;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Colors: THopePreferencesVersioningColors read FColors;
  end;

  THopePreferencesFormating = class(THopeJsonBase)
  private
    FIndention: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property Indention: Integer read FIndention write FIndention;
  end;

  THopePreferences = class(THopeJsonBase)
  private
    FEnvironment: THopePreferencesEnvironment;
    FSearch: THopePreferencesSearch;
    FEditor: THopePreferencesEditor;
    FRecent: THopePreferencesRecent;
    FCodeInsight: THopePreferencesCodeInsight;
    FVersioning: THopePreferencesVersioning;
    FFormating: THopePreferencesFormating;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Environment: THopePreferencesEnvironment read FEnvironment;
    property Search: THopePreferencesSearch read FSearch;
    property Editor: THopePreferencesEditor read FEditor;
    property Recent: THopePreferencesRecent read FRecent;
    property CodeInsight: THopePreferencesCodeInsight read FCodeInsight;
    property Versioning: THopePreferencesVersioning read FVersioning;
    property Formating: THopePreferencesFormating read FFormating;
  end;

implementation

{ THopePreferencesSearch }

procedure THopePreferencesSearch.AfterConstruction;
begin
  inherited;

  FRecentSearch := TStringList.Create;
  FRecentReplace := TStringList.Create;
  FRecentGotoLine := TStringList.Create;
end;

procedure THopePreferencesSearch.BeforeDestruction;
begin
  FRecentGotoLine.Free;
  FRecentReplace.Free;
  FRecentSearch.Free;
end;

class function THopePreferencesSearch.GetPreferredName: string;
begin
  Result := 'Search';
end;

procedure THopePreferencesSearch.ReadJson(const JsonValue: TdwsJSONObject);
var
  Index: Integer;
  JsonArray: TdwsJSONArray;
begin
  if JsonValue.GetArray('Search', JsonArray) then
  begin
    FRecentSearch.Clear;
    for Index := 0 to FRecentSearch.Count - 1 do
      FRecentSearch.Add(JsonArray.Elements[Index].AsString)
  end;

  if JsonValue.GetArray('Replace', JsonArray) then
  begin
    FRecentReplace.Clear;
    for Index := 0 to FRecentSearch.Count - 1 do
      FRecentReplace.Add(JsonArray.Elements[Index].AsString)
  end;
end;

procedure THopePreferencesSearch.WriteJson(const JsonValue: TdwsJSONObject);
var
  Index: Integer;
  JsonArray: TdwsJSONArray;
begin
  JsonArray := JsonValue.AddArray('Search');
  for Index := 0 to FRecentSearch.Count - 1 do
    JsonArray.Add(FRecentSearch[Index]);

  JsonArray := JsonValue.AddArray('Replace');
  for Index := 0 to FRecentReplace.Count - 1 do
    JsonArray.Add(FRecentReplace[Index]);
end;


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


{ THopePreferencesRecent }

procedure THopePreferencesRecent.AfterConstruction;
begin
  inherited;
  FProjectCount := 10;
  FUnitCount := 10;
end;

class function THopePreferencesRecent.GetPreferredName: string;
begin
  Result := 'Recent';
end;

procedure THopePreferencesRecent.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FProjectCount := JsonValue.GetValue('Projects', FProjectCount);
  FUnitCount := JsonValue.GetValue('Units', FUnitCount);
end;

procedure THopePreferencesRecent.WriteJson(const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('Projects', FProjectCount);
  JsonValue.AddValue('Units', FUnitCount);
end;


{ THopePreferencesCodeSuggestions }

procedure THopePreferencesCodeSuggestions.AfterConstruction;
begin
  inherited;

  FEnabled := True;
  FAutoParenthesis := True;
  FShowReservedWords := False;
end;

class function THopePreferencesCodeSuggestions.GetPreferredName: string;
begin
  Result := 'CodeSuggestions';
end;

procedure THopePreferencesCodeSuggestions.ReadJson(
  const JsonValue: TdwsJSONObject);
begin
  FEnabled := JsonValue.GetValue('Enabled', FEnabled);
  FAutoParenthesis := JsonValue.GetValue('AutoParenthesis', FAutoParenthesis);
  FShowReservedWords := JsonValue.GetValue('ShowReservedWords', FShowReservedWords);
end;

procedure THopePreferencesCodeSuggestions.WriteJson(
  const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('Enabled', FEnabled);
  JsonValue.AddValue('AutoParenthesis', FAutoParenthesis);
  JsonValue.AddValue('ShowReservedWords', FShowReservedWords);
end;


{ THopePreferencesCodeInsight }

procedure THopePreferencesCodeInsight.AfterConstruction;
begin
  inherited;

  FErrorInsight := False;
  FCodeParametes := False;
  FTooltipSymbolInsight := False;
  FCodeTemplateCompletion := False;
  FBlockCompletion := False;
  FCodeSuggestions := THopePreferencesCodeSuggestions.Create;
end;

procedure THopePreferencesCodeInsight.BeforeDestruction;
begin
  inherited;

  FCodeSuggestions.Free;
end;

class function THopePreferencesCodeInsight.GetPreferredName: string;
begin
  Result := 'CodeInsight';
end;

procedure THopePreferencesCodeInsight.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FErrorInsight := JsonValue.GetValue('ErrorInsight', FErrorInsight);
  FCodeParametes := JsonValue.GetValue('CodeParametes', FCodeParametes);
  FTooltipSymbolInsight := JsonValue.GetValue('TooltipSymbolInsight', FTooltipSymbolInsight);
  FCodeTemplateCompletion := JsonValue.GetValue('CodeTemplateCompletion', FCodeTemplateCompletion);
  FBlockCompletion := JsonValue.GetValue('BlockCompletion', FBlockCompletion);

  FCodeSuggestions.WriteJson(JsonValue);
end;

procedure THopePreferencesCodeInsight.WriteJson(
  const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('ErrorInsight', FErrorInsight);
  JsonValue.AddValue('CodeParametes', FCodeParametes);
  JsonValue.AddValue('TooltipSymbolInsight', FTooltipSymbolInsight);
  JsonValue.AddValue('CodeTemplateCompletion', FCodeTemplateCompletion);
  JsonValue.AddValue('BlockCompletion', FBlockCompletion);

  FCodeSuggestions.SaveToJson(JsonValue);
end;


{ THopePreferencesVersioningColors }

procedure THopePreferencesVersioningColors.AfterConstruction;
begin
  inherited;

  FConflicted := TColorRec.Red;
  FAdded := TColorRec.Navy;
end;

class function THopePreferencesVersioningColors.GetPreferredName: string;
begin
  Result := 'Colors';
end;

procedure THopePreferencesVersioningColors.ReadJson(
  const JsonValue: TdwsJSONObject);
begin
  FConflicted := JsonValue.GetValue('Conflicted', FConflicted);
  FAdded := JsonValue.GetValue('Added', FAdded);
end;

procedure THopePreferencesVersioningColors.WriteJson(
  const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('Conflicted', FConflicted);
  JsonValue.AddValue('Added', FAdded);
end;


{ THopePreferencesVersioning }

procedure THopePreferencesVersioning.AfterConstruction;
begin
  inherited;

  FColors := THopePreferencesVersioningColors.Create;
end;

procedure THopePreferencesVersioning.BeforeDestruction;
begin
  inherited;

  FColors.Free;
end;

class function THopePreferencesVersioning.GetPreferredName: string;
begin
  Result := 'Versioning';
end;

procedure THopePreferencesVersioning.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FColors.LoadFromJson(JsonValue, True);
end;

procedure THopePreferencesVersioning.WriteJson(const JsonValue: TdwsJSONObject);
begin
  FColors.SaveToJson(JsonValue);
end;


{ THopePreferencesFormating }

procedure THopePreferencesFormating.AfterConstruction;
begin
  inherited;

  FIndention := 2;
end;

class function THopePreferencesFormating.GetPreferredName: string;
begin
  Result := 'Formating';
end;

procedure THopePreferencesFormating.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FIndention := JsonValue.GetValue('Indent', FIndention);
end;

procedure THopePreferencesFormating.WriteJson(const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('Indent');
end;


{ THopePreferences }

procedure THopePreferences.AfterConstruction;
begin
  inherited;

  FEnvironment := THopePreferencesEnvironment.Create;
  FSearch := THopePreferencesSearch.Create;
  FEditor := THopePreferencesEditor.Create;
  FRecent := THopePreferencesRecent.Create;
  FCodeInsight := THopePreferencesCodeInsight.Create;
  FVersioning := THopePreferencesVersioning.Create;
  FFormating := THopePreferencesFormating.Create;
end;

procedure THopePreferences.BeforeDestruction;
begin
  FFormating.Free;
  FVersioning.Free;
  FCodeInsight.Free;
  FRecent.Free;
  FEditor.Free;
  FSearch.Free;
  FEnvironment.Free;

  inherited;
end;

procedure THopePreferences.ReadJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

  FEnvironment.LoadFromJson(JsonValue, True);
  FSearch.LoadFromJson(JsonValue, True);
  FRecent.LoadFromJson(JsonValue, True);
  FEditor.LoadFromJson(JsonValue, True);
  FCodeInsight.LoadFromJson(JsonValue, True);
  FVersioning.LoadFromJson(JsonValue, True);
  FFormating.LoadFromJson(JsonValue, True);
end;

procedure THopePreferences.WriteJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

  FEnvironment.SaveToJson(JsonValue);
  FSearch.SaveToJson(JsonValue);
  FRecent.SaveToJson(JsonValue);
  FEditor.SaveToJson(JsonValue);
  FCodeInsight.SaveToJson(JsonValue);
  FVersioning.SaveToJson(JsonValue);
  FFormating.SaveToJson(JsonValue);
end;


end.
