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

  THopePreferencesFontAttributes = class(THopeJsonBase)
  strict private
    FBackground: TColor;
    FForeground: TColor;
    FStyle: TFontStyles;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure SetColors(Foreground, Background: TColor);
    procedure SetValues(Foreground, Background: TColor; Style: TFontStyles);

    property Background: TColor read FBackground write FBackground;
    property Foreground: TColor read FForeground write FForeground;
    property Style: TFontStyles read FStyle write FStyle;
  end;

  THopePreferencesHighlighterCustom = class(THopeJsonBase)
  strict private
    FSymbolAttributes: THopePreferencesFontAttributes;
    FSpaceAttributes: THopePreferencesFontAttributes;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property SpaceAttributes: THopePreferencesFontAttributes read FSpaceAttributes;
    property SymbolAttributes: THopePreferencesFontAttributes read FSymbolAttributes;
  end;

  THopePreferencesHighlighterPascal = class(THopePreferencesHighlighterCustom)
  strict private
    FAsmAttributes: THopePreferencesFontAttributes;
    FCharAttributes: THopePreferencesFontAttributes;
    FCommentAttributes: THopePreferencesFontAttributes;
    FDirectiveAttributes: THopePreferencesFontAttributes;
    FFloatAttributes: THopePreferencesFontAttributes;
    FHexAttributes: THopePreferencesFontAttributes;
    FIdentifierAttributes: THopePreferencesFontAttributes;
    FKeywordAttributes: THopePreferencesFontAttributes;
    FNumberAttributes: THopePreferencesFontAttributes;
    FStringAttributes: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property AsmAttributes: THopePreferencesFontAttributes read FAsmAttributes;
    property CharAttributes: THopePreferencesFontAttributes read FCharAttributes;
    property CommentAttributes: THopePreferencesFontAttributes read FCommentAttributes;
    property DirectiveAttributes: THopePreferencesFontAttributes read FDirectiveAttributes;
    property FloatAttributes: THopePreferencesFontAttributes read FFloatAttributes;
    property HexAttributes: THopePreferencesFontAttributes read FHexAttributes;
    property IdentifierAttributes: THopePreferencesFontAttributes read FIdentifierAttributes;
    property KeywordAttributes: THopePreferencesFontAttributes read FKeywordAttributes;
    property NumberAttributes: THopePreferencesFontAttributes read FNumberAttributes;
    property StringAttributes: THopePreferencesFontAttributes read FStringAttributes;
  end;

  THopePreferencesHighlighterJS = class(THopePreferencesHighlighterCustom)
  strict private
    FCommentAttributes: THopePreferencesFontAttributes;
    FEventAttributes: THopePreferencesFontAttributes;
    FIdentifierAttributes: THopePreferencesFontAttributes;
    FKeywordAttributes: THopePreferencesFontAttributes;
    FNonReservedKeywordAttributes: THopePreferencesFontAttributes;
    FNumberAttributes: THopePreferencesFontAttributes;
    FStringAttributes: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property CommentAttributes: THopePreferencesFontAttributes read FCommentAttributes;
    property EventAttributes: THopePreferencesFontAttributes read FEventAttributes;
    property IdentifierAttributes: THopePreferencesFontAttributes read FIdentifierAttributes;
    property KeywordAttributes: THopePreferencesFontAttributes read FKeywordAttributes;
    property NonReservedKeywordAttributes: THopePreferencesFontAttributes read FNonReservedKeywordAttributes;
    property NumberAttributes: THopePreferencesFontAttributes read FNumberAttributes;
    property StringAttributes: THopePreferencesFontAttributes read FStringAttributes;
  end;

  THopePreferencesHighlighterJson = class(THopePreferencesHighlighterCustom)
  strict private
    FAttributeAttributes: THopePreferencesFontAttributes;
    FNumberAttributes: THopePreferencesFontAttributes;
    FReservedAttributes: THopePreferencesFontAttributes;
    FValueAttributes: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property AttributeAttributes: THopePreferencesFontAttributes read FAttributeAttributes;
    property ReservedAttributes: THopePreferencesFontAttributes read FReservedAttributes;
    property NumberAttributes: THopePreferencesFontAttributes read FNumberAttributes;
    property ValueAttributes: THopePreferencesFontAttributes read FValueAttributes;
  end;

  THopePreferencesHighlighterHTML = class(THopePreferencesHighlighterCustom)
  strict private
    FAndAttributes: THopePreferencesFontAttributes;
    FCommentAttributes: THopePreferencesFontAttributes;
    FIdentifierAttributes: THopePreferencesFontAttributes;
    FKeywordAttributes: THopePreferencesFontAttributes;
    FTextAttributes: THopePreferencesFontAttributes;
    FUndefinedKeyAttributes: THopePreferencesFontAttributes;
    FValueAttributes: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property AndAttributes: THopePreferencesFontAttributes read FAndAttributes;
    property CommentAttributes: THopePreferencesFontAttributes read FCommentAttributes;
    property IdentifierAttributes: THopePreferencesFontAttributes read FIdentifierAttributes;
    property KeywordAttributes: THopePreferencesFontAttributes read FKeywordAttributes;
    property TextAttributes: THopePreferencesFontAttributes read FTextAttributes;
    property UndefinedKeyAttributes: THopePreferencesFontAttributes read FUndefinedKeyAttributes;
    property ValueAttributes: THopePreferencesFontAttributes read FValueAttributes;
  end;

  THopePreferencesHighlighterCSS = class(THopePreferencesHighlighterCustom)
  strict private
    FAtRuleAttributes: THopePreferencesFontAttributes;
    FColorAttributes: THopePreferencesFontAttributes;
    FCommentAttributes: THopePreferencesFontAttributes;
    FNumberAttributes: THopePreferencesFontAttributes;
    FPropertyAttributes: THopePreferencesFontAttributes;
    FSelectorAttributes: THopePreferencesFontAttributes;
    FStringAttributes: THopePreferencesFontAttributes;
    FTextAttributes: THopePreferencesFontAttributes;
    FUndefPropertyAttributes: THopePreferencesFontAttributes;
    FValueAttributes: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property AtRuleAttributes: THopePreferencesFontAttributes read FAtRuleAttributes;
    property ColorAttributes: THopePreferencesFontAttributes read FColorAttributes;
    property CommentAttributes: THopePreferencesFontAttributes read FCommentAttributes;
    property NumberAttributes: THopePreferencesFontAttributes read FNumberAttributes;
    property PropertyAttributes: THopePreferencesFontAttributes read FPropertyAttributes;
    property SelectorAttributes: THopePreferencesFontAttributes read FSelectorAttributes;
    property StringAttributes: THopePreferencesFontAttributes read FStringAttributes;
    property TextAttributes: THopePreferencesFontAttributes read FTextAttributes;
    property UndefPropertyAttributes: THopePreferencesFontAttributes read FUndefPropertyAttributes;
    property ValueAttributes: THopePreferencesFontAttributes read FValueAttributes;
  end;

  THopePreferencesHighlighter = class(THopeJsonBase)
  strict private
    FErrorAttributes: THopePreferencesFontAttributes;
    FHighlighterCSS: THopePreferencesHighlighterCSS;
    FHighlighterHTML: THopePreferencesHighlighterHTML;
    FHighlighterJS: THopePreferencesHighlighterJS;
    FHighlighterJSON: THopePreferencesHighlighterJson;
    FHighlighterPascal: THopePreferencesHighlighterPascal;
    FHintAttributes: THopePreferencesFontAttributes;
    FLinkAttributes: THopePreferencesFontAttributes;
    FMarkerAttributes: THopePreferencesFontAttributes;
    FSearchWordAttributes: THopePreferencesFontAttributes;
    FWarningAttributes: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property ErrorAttributes: THopePreferencesFontAttributes read FErrorAttributes write FErrorAttributes;
    property HighlighterCSS: THopePreferencesHighlighterCSS read FHighlighterCSS;
    property HighlighterHTML: THopePreferencesHighlighterHTML read FHighlighterHTML;
    property HighlighterJS: THopePreferencesHighlighterJS read FHighlighterJS;
    property HighlighterJSON: THopePreferencesHighlighterJson read FHighlighterJSON;
    property HighlighterPascal: THopePreferencesHighlighterPascal read FHighlighterPascal;
    property HintAttributes: THopePreferencesFontAttributes read FHintAttributes write FHintAttributes;
    property LinkAttributes: THopePreferencesFontAttributes read FLinkAttributes write FLinkAttributes;
    property MarkerAttributes: THopePreferencesFontAttributes read FMarkerAttributes write FMarkerAttributes;
    property SearchWordAttributes: THopePreferencesFontAttributes read FSearchWordAttributes write FSearchWordAttributes;
    property WarningAttributes: THopePreferencesFontAttributes read FWarningAttributes write FWarningAttributes;
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

  TFindInFilesScope = (fsProjectFiles, fsEditorFiles, fsProjectGroup,
    fsSpecificDirectory);

  THopePreferencesFindInFiles = class(THopeJsonBase)
  private
    FCaseSensitive: Boolean;
    FRegularExpressions: Boolean;
    FWholeWordsOnly: Boolean;
    FScope: TFindInFilesScope;
    FConfirmReplace: Boolean;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;

    property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive;
    property RegularExpressions: Boolean read FRegularExpressions write FRegularExpressions;
    property WholeWordsOnly: Boolean read FWholeWordsOnly write FWholeWordsOnly;
    property ConfirmReplace: Boolean read FConfirmReplace write FConfirmReplace;
    property Scope: TFindInFilesScope read FScope write FScope;
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
    FDelay: Integer;
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
    property Delay: Integer read FDelay write FDelay;
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
    FFindInFiles: THopePreferencesFindInFiles;
    FSearch: THopePreferencesSearch;
    FEditor: THopePreferencesEditor;
    FHighlighter: THopePreferencesHighlighter;
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
    property FindInFiles: THopePreferencesFindInFiles read FFindInFiles;
    property Editor: THopePreferencesEditor read FEditor;
    property Highlighter: THopePreferencesHighlighter read FHighlighter;
    property Recent: THopePreferencesRecent read FRecent;
    property CodeInsight: THopePreferencesCodeInsight read FCodeInsight;
    property Versioning: THopePreferencesVersioning read FVersioning;
    property Formating: THopePreferencesFormating read FFormating;
  end;

implementation

uses
  System.UIConsts, System.TypInfo, VCL.Graphics;

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


{ THopePreferencesFontAttributes }

class function THopePreferencesFontAttributes.GetPreferredName: string;
begin
  Result := 'FontAttributes';
end;

procedure THopePreferencesFontAttributes.SetColors(Foreground, Background: TColor);
begin
  FBackground := Background;
  FForeground := Foreground;
end;

procedure THopePreferencesFontAttributes.SetValues(Foreground, Background: TColor;
  Style: TFontStyles);
begin
  FBackground := Background;
  FForeground := Foreground;
  FStyle := Style;
end;

procedure THopePreferencesFontAttributes.ReadJson(const JsonValue: TdwsJsonObject);
begin
  Background := StringToColor(JsonValue.GetValue('Background', ColorToString(clBlack)));
  Foreground := StringToColor(JsonValue.GetValue('Foreground', ColorToString(clWhite)));
  Byte(FStyle) := StringToSet(PTypeInfo(TypeInfo(TFontStyles)), JsonValue.GetValue('Style', ''));
end;

procedure THopePreferencesFontAttributes.WriteJson(const JsonValue: TdwsJsonObject);
begin
  JsonValue.AddValue('Background', ColorToString(Background));
  JsonValue.AddValue('Foreground', ColorToString(Foreground));
  JsonValue.AddValue('Style', SetToString(PTypeInfo(TypeInfo(TFontStyles)), Byte(Style)));
end;


{ THopePreferencesHighlighterCustom }

procedure THopePreferencesHighlighterCustom.AfterConstruction;
begin
  inherited;

  FSpaceAttributes := THopePreferencesFontAttributes.Create;
  FSymbolAttributes := THopePreferencesFontAttributes.Create;
end;

procedure THopePreferencesHighlighterCustom.BeforeDestruction;
begin
  inherited;

  FSpaceAttributes.Free;
  FSymbolAttributes.Free;
end;


{ THopePreferencesHighlighterPascal }

procedure THopePreferencesHighlighterPascal.AfterConstruction;
begin
  inherited;

  FAsmAttributes := THopePreferencesFontAttributes.Create;
  FCharAttributes := THopePreferencesFontAttributes.Create;
  FCommentAttributes := THopePreferencesFontAttributes.Create;
  FDirectiveAttributes := THopePreferencesFontAttributes.Create;
  FFloatAttributes := THopePreferencesFontAttributes.Create;
  FHexAttributes := THopePreferencesFontAttributes.Create;
  FIdentifierAttributes := THopePreferencesFontAttributes.Create;
  FKeywordAttributes := THopePreferencesFontAttributes.Create;
  FNumberAttributes := THopePreferencesFontAttributes.Create;
  FStringAttributes := THopePreferencesFontAttributes.Create;
end;

procedure THopePreferencesHighlighterPascal.BeforeDestruction;
begin
  FStringAttributes.Free;
  FNumberAttributes.Free;
  FKeywordAttributes.Free;
  FIdentifierAttributes.Free;
  FHexAttributes.Free;
  FFloatAttributes.Free;
  FDirectiveAttributes.Free;
  FCommentAttributes.Free;
  FCharAttributes.Free;
  FAsmAttributes.Free;

  inherited;
end;

class function THopePreferencesHighlighterPascal.GetPreferredName: string;
begin
  Result := 'Pascal';
end;

procedure THopePreferencesHighlighterPascal.ReadJson(const JsonValue: TdwsJsonObject);
begin
  AsmAttributes.LoadFromJson('Asm', JsonValue, True);
  CharAttributes.LoadFromJson('Char', JsonValue, True);
  CommentAttributes.LoadFromJson('Comment', JsonValue, True);
  DirectiveAttributes.LoadFromJson('Directive', JsonValue, True);
  FloatAttributes.LoadFromJson('Float', JsonValue, True);
  HexAttributes.LoadFromJson('Hex', JsonValue, True);
  IdentifierAttributes.LoadFromJson('Identifier', JsonValue, True);
  KeywordAttributes.LoadFromJson('Keyword', JsonValue, True);
  NumberAttributes.LoadFromJson('Number', JsonValue, True);
  SpaceAttributes.LoadFromJson('Space', JsonValue, True);
  StringAttributes.LoadFromJson('String', JsonValue, True);
  SymbolAttributes.LoadFromJson('Symbol', JsonValue, True);
end;

procedure THopePreferencesHighlighterPascal.WriteJson(const JsonValue: TdwsJsonObject);
begin
  AsmAttributes.SaveToJson('Asm', JsonValue);
  CharAttributes.SaveToJson('Char', JsonValue);
  CommentAttributes.SaveToJson('Comment', JsonValue);
  DirectiveAttributes.SaveToJson('Directive', JsonValue);
  FloatAttributes.SaveToJson('Float', JsonValue);
  HexAttributes.SaveToJson('Hex', JsonValue);
  IdentifierAttributes.SaveToJson('Identifier', JsonValue);
  KeywordAttributes.SaveToJson('Keyword', JsonValue);
  NumberAttributes.SaveToJson('Number', JsonValue);
  SpaceAttributes.SaveToJson('Space', JsonValue);
  StringAttributes.SaveToJson('String', JsonValue);
  SymbolAttributes.SaveToJson('Symbol', JsonValue);
end;


{ THopePreferencesHighlighterJS }

procedure THopePreferencesHighlighterJS.AfterConstruction;
begin
  inherited;

  FIdentifierAttributes := THopePreferencesFontAttributes.Create;
  FKeywordAttributes := THopePreferencesFontAttributes.Create;
  FCommentAttributes := THopePreferencesFontAttributes.Create;
  FEventAttributes := THopePreferencesFontAttributes.Create;
  FNonReservedKeywordAttributes := THopePreferencesFontAttributes.Create;
  FStringAttributes := THopePreferencesFontAttributes.Create;
  FNumberAttributes := THopePreferencesFontAttributes.Create;
end;

procedure THopePreferencesHighlighterJS.BeforeDestruction;
begin
  FNumberAttributes.Free;
  FStringAttributes.Free;
  FNonReservedKeywordAttributes.Free;
  FEventAttributes.Free;
  FCommentAttributes.Free;
  FKeywordAttributes.Free;
  FIdentifierAttributes.Free;

  inherited;
end;

class function THopePreferencesHighlighterJS.GetPreferredName: string;
begin
  Result := 'JS';
end;

procedure THopePreferencesHighlighterJS.ReadJson(const JsonValue: TdwsJsonObject);
begin
  CommentAttributes.LoadFromJson('Comment', JsonValue, True);
  EventAttributes.LoadFromJson('Event', JsonValue, True);
  IdentifierAttributes.LoadFromJson('Identifier', JsonValue, True);
  KeywordAttributes.LoadFromJson('Keyword', JsonValue, True);
  NonReservedKeywordAttributes.LoadFromJson('NonReservedKeyword', JsonValue, True);
  NumberAttributes.LoadFromJson('Number', JsonValue, True);
  SpaceAttributes.LoadFromJson('Space', JsonValue, True);
  StringAttributes.LoadFromJson('String', JsonValue, True);
  SymbolAttributes.LoadFromJson('Symbol', JsonValue, True);
end;

procedure THopePreferencesHighlighterJS.WriteJson(const JsonValue: TdwsJsonObject);
begin
  CommentAttributes.SaveToJson('Comment', JsonValue);
  EventAttributes.SaveToJson('Event', JsonValue);
  IdentifierAttributes.SaveToJson('Identifier', JsonValue);
  KeywordAttributes.SaveToJson('Keyword', JsonValue);
  NonReservedKeywordAttributes.SaveToJson('NonReservedKeyword', JsonValue);
  NumberAttributes.SaveToJson('Number', JsonValue);
  SpaceAttributes.SaveToJson('Space', JsonValue);
  StringAttributes.SaveToJson('String', JsonValue);
  SymbolAttributes.SaveToJson('Symbol', JsonValue);
end;


{ THopePreferencesHighlighterJson }

procedure THopePreferencesHighlighterJson.AfterConstruction;
begin
  inherited;

  FAttributeAttributes := THopePreferencesFontAttributes.Create;
  FReservedAttributes := THopePreferencesFontAttributes.Create;
  FNumberAttributes := THopePreferencesFontAttributes.Create;
  FValueAttributes := THopePreferencesFontAttributes.Create;
end;

procedure THopePreferencesHighlighterJson.BeforeDestruction;
begin
  FValueAttributes.Free;
  FNumberAttributes.Free;
  FReservedAttributes.Free;
  FAttributeAttributes.Free;

  inherited;
end;

class function THopePreferencesHighlighterJson.GetPreferredName: string;
begin
  Result := 'JSON';
end;

procedure THopePreferencesHighlighterJson.ReadJson(const JsonValue: TdwsJsonObject);
begin
  AttributeAttributes.LoadFromJson('Attribute', JsonValue, True);
  ReservedAttributes.LoadFromJson('Reserved', JsonValue, True);
  NumberAttributes.LoadFromJson('Number', JsonValue, True);
  SpaceAttributes.LoadFromJson('Space', JsonValue, True);
  SymbolAttributes.LoadFromJson('Symbol', JsonValue, True);
  ValueAttributes.LoadFromJson('Value', JsonValue, True);
end;

procedure THopePreferencesHighlighterJson.WriteJson(const JsonValue: TdwsJsonObject);
begin
  AttributeAttributes.SaveToJson('Attribute', JsonValue);
  ReservedAttributes.SaveToJson('Reserved', JsonValue);
  NumberAttributes.SaveToJson('Number', JsonValue);
  SpaceAttributes.SaveToJson('Space', JsonValue);
  SymbolAttributes.SaveToJson('Symbol', JsonValue);
  ValueAttributes.SaveToJson('Value', JsonValue);
end;


{ THopePreferencesHighlighterHTML }

procedure THopePreferencesHighlighterHTML.AfterConstruction;
begin
  inherited;

  FAndAttributes := THopePreferencesFontAttributes.Create;
  FCommentAttributes := THopePreferencesFontAttributes.Create;
  FIdentifierAttributes := THopePreferencesFontAttributes.Create;
  FKeywordAttributes := THopePreferencesFontAttributes.Create;
  FTextAttributes := THopePreferencesFontAttributes.Create;
  FUndefinedKeyAttributes := THopePreferencesFontAttributes.Create;
  FValueAttributes := THopePreferencesFontAttributes.Create;
end;

procedure THopePreferencesHighlighterHTML.BeforeDestruction;
begin
  FValueAttributes.Free;
  FUndefinedKeyAttributes.Free;
  FTextAttributes.Free;
  FKeywordAttributes.Free;
  FIdentifierAttributes.Free;
  FCommentAttributes.Free;
  FAndAttributes.Free;

  inherited;
end;

class function THopePreferencesHighlighterHTML.GetPreferredName: string;
begin
  Result := 'HTML';
end;

procedure THopePreferencesHighlighterHTML.ReadJson(const JsonValue: TdwsJsonObject);
begin
  AndAttributes.LoadFromJson('And', JsonValue, True);
  CommentAttributes.LoadFromJson('Comment', JsonValue, True);
  IdentifierAttributes.LoadFromJson('Identifier', JsonValue, True);
  KeywordAttributes.LoadFromJson('Keyword', JsonValue, True);
  SpaceAttributes.LoadFromJson('Space', JsonValue, True);
  SymbolAttributes.LoadFromJson('Symbol', JsonValue, True);
  TextAttributes.LoadFromJson('Text', JsonValue, True);
  UndefinedKeyAttributes.LoadFromJson('UndefKey', JsonValue, True);
  ValueAttributes.LoadFromJson('Value', JsonValue, True);
end;

procedure THopePreferencesHighlighterHTML.WriteJson(const JsonValue: TdwsJsonObject);
begin
  AndAttributes.SaveToJson('And', JsonValue);
  CommentAttributes.SaveToJson('Comment', JsonValue);
  IdentifierAttributes.SaveToJson('Identifier', JsonValue);
  KeywordAttributes.SaveToJson('Keyword', JsonValue);
  SpaceAttributes.SaveToJson('Space', JsonValue);
  SymbolAttributes.SaveToJson('Symbol', JsonValue);
  TextAttributes.SaveToJson('Text', JsonValue);
  UndefinedKeyAttributes.SaveToJson('UndefKey', JsonValue);
  ValueAttributes.SaveToJson('Value', JsonValue);
end;


{ THopePreferencesHighlighterCSS }

procedure THopePreferencesHighlighterCSS.AfterConstruction;
begin
  inherited;

  FAtRuleAttributes := THopePreferencesFontAttributes.Create;
  FColorAttributes := THopePreferencesFontAttributes.Create;
  FCommentAttributes := THopePreferencesFontAttributes.Create;
  FNumberAttributes := THopePreferencesFontAttributes.Create;
  FPropertyAttributes := THopePreferencesFontAttributes.Create;
  FSelectorAttributes := THopePreferencesFontAttributes.Create;
  FStringAttributes := THopePreferencesFontAttributes.Create;
  FTextAttributes := THopePreferencesFontAttributes.Create;
  FUndefPropertyAttributes := THopePreferencesFontAttributes.Create;
  FValueAttributes := THopePreferencesFontAttributes.Create;
end;

procedure THopePreferencesHighlighterCSS.BeforeDestruction;
begin
  FValueAttributes.Free;
  FUndefPropertyAttributes.Free;
  FTextAttributes.Free;
  FStringAttributes.Free;
  FSelectorAttributes.Free;
  FPropertyAttributes.Free;
  FNumberAttributes.Free;
  FCommentAttributes.Free;
  FColorAttributes.Free;
  FAtRuleAttributes.Free;

  inherited;
end;

class function THopePreferencesHighlighterCSS.GetPreferredName: string;
begin
  Result := 'CSS';
end;

procedure THopePreferencesHighlighterCSS.ReadJson(const JsonValue: TdwsJsonObject);
begin
  AtRuleAttributes.LoadFromJson('AtRule', JsonValue, True);
  ColorAttributes.LoadFromJson('Color', JsonValue, True);
  CommentAttributes.LoadFromJson('Comment', JsonValue, True);
  NumberAttributes.LoadFromJson('Number', JsonValue, True);
  PropertyAttributes.LoadFromJson('Property', JsonValue, True);
  SelectorAttributes.LoadFromJson('Selector', JsonValue, True);
  SpaceAttributes.LoadFromJson('Space', JsonValue, True);
  StringAttributes.LoadFromJson('String', JsonValue, True);
  SymbolAttributes.LoadFromJson('Symbol', JsonValue, True);
  TextAttributes.LoadFromJson('Text', JsonValue, True);
  UndefPropertyAttributes.LoadFromJson('UndefProperty', JsonValue, True);
  ValueAttributes.LoadFromJson('Value', JsonValue, True);
end;

procedure THopePreferencesHighlighterCSS.WriteJson(const JsonValue: TdwsJsonObject);
begin
  AtRuleAttributes.SaveToJson('AtRule', JsonValue);
  ColorAttributes.SaveToJson('Color', JsonValue);
  CommentAttributes.SaveToJson('Comment', JsonValue);
  NumberAttributes.SaveToJson('Number', JsonValue);
  PropertyAttributes.SaveToJson('Property', JsonValue);
  SelectorAttributes.SaveToJson('Selector', JsonValue);
  SpaceAttributes.SaveToJson('Space', JsonValue);
  StringAttributes.SaveToJson('String', JsonValue);
  SymbolAttributes.SaveToJson('Symbol', JsonValue);
  TextAttributes.SaveToJson('Text', JsonValue);
  UndefPropertyAttributes.SaveToJson('UndefProperty', JsonValue);
  ValueAttributes.SaveToJson('Value', JsonValue);
end;


{ THopePreferencesHighlighter }

procedure THopePreferencesHighlighter.AfterConstruction;
begin
  inherited;

  // create attributes
  FErrorAttributes := THopePreferencesFontAttributes.Create;
  FHintAttributes := THopePreferencesFontAttributes.Create;
  FLinkAttributes := THopePreferencesFontAttributes.Create;
  FMarkerAttributes := THopePreferencesFontAttributes.Create;
  FSearchWordAttributes := THopePreferencesFontAttributes.Create;
  FWarningAttributes := THopePreferencesFontAttributes.Create;

  // create highlighter
  FHighlighterCSS := THopePreferencesHighlighterCSS.Create;
  FHighlighterHTML := THopePreferencesHighlighterHTML.Create;
  FHighlighterJS := THopePreferencesHighlighterJS.Create;
  FHighlighterJSON := THopePreferencesHighlighterJson.Create;
  FHighlighterPascal := THopePreferencesHighlighterPascal.Create;

  // preset colors
  FHintAttributes.SetColors(clNone, $00FFE0D0);
  FWarningAttributes.SetColors(clNone, $00C0FFFF);
  FErrorAttributes.SetColors(clNone, $00C0C0FF);
  FSearchWordAttributes.SetColors(clNone, $0080B0FF);
  FLinkAttributes.SetColors(clBlue, clNone);
  FLinkAttributes.Style := [fsUnderline];
  FMarkerAttributes.SetColors(clBlack, clYellow);
end;

procedure THopePreferencesHighlighter.BeforeDestruction;
begin
  // free highlighter
  FHighlighterPascal.Free;
  FHighlighterJSON.Free;
  FHighlighterJS.Free;
  FHighlighterHTML.Free;
  FHighlighterCSS.Free;

  // free attributes
  FWarningAttributes.Free;
  FSearchWordAttributes.Free;
  FMarkerAttributes.Free;
  FLinkAttributes.Free;
  FHintAttributes.Free;
  FErrorAttributes.Free;

  inherited Destroy;
end;

class function THopePreferencesHighlighter.GetPreferredName: string;
begin
  Result := 'Highlighter';
end;

procedure THopePreferencesHighlighter.ReadJson(const JsonValue: TdwsJsonObject);
begin
  // read highlighter settings
  HighlighterPascal.LoadFromJson(JsonValue, True);
  HighlighterJS.LoadFromJson(JsonValue, True);
  HighlighterJSON.LoadFromJson(JsonValue, True);
  HighlighterHTML.LoadFromJson(JsonValue, True);
  HighlighterCSS.LoadFromJson(JsonValue, True);

  // read other attributes
  HintAttributes.LoadFromJson('Hint', JsonValue, True);
  WarningAttributes.LoadFromJson('Warning', JsonValue, True);
  ErrorAttributes.LoadFromJson('Error', JsonValue, True);
  LinkAttributes.LoadFromJson('Link', JsonValue, True);
  SearchWordAttributes.LoadFromJson('SearchWord', JsonValue, True);
  MarkerAttributes.LoadFromJson('Marker', JsonValue, True);
end;

procedure THopePreferencesHighlighter.WriteJson(const JsonValue: TdwsJsonObject);
begin
  // write highlighter settings
  HighlighterPascal.SaveToJson(JsonValue);
  HighlighterJS.SaveToJson(JsonValue);
  HighlighterJSON.SaveToJson(JsonValue);
  HighlighterHTML.SaveToJson(JsonValue);
  HighlighterCSS.SaveToJson(JsonValue);

  // write other attributes
  HintAttributes.SaveToJson('Hint', JsonValue);
  WarningAttributes.SaveToJson('Warning', JsonValue);
  ErrorAttributes.SaveToJson('Error', JsonValue);
  LinkAttributes.SaveToJson('Link', JsonValue);
  SearchWordAttributes.SaveToJson('SearchWord', JsonValue);
  MarkerAttributes.SaveToJson('Marker', JsonValue);
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


{ THopePreferencesFindInFiles }

procedure THopePreferencesFindInFiles.AfterConstruction;
begin
  inherited;

  FCaseSensitive := False;
  FRegularExpressions := False;
  FWholeWordsOnly := False;
  FConfirmReplace := False;
end;

class function THopePreferencesFindInFiles.GetPreferredName: string;
begin
  Result := 'FindInFiles';
end;

procedure THopePreferencesFindInFiles.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FCaseSensitive := JsonValue.GetValue('CaseSensitive', FCaseSensitive);
  FRegularExpressions := JsonValue.GetValue('RegularExpressions', FRegularExpressions);
  FWholeWordsOnly := JsonValue.GetValue('WholeWordsOnly', FWholeWordsOnly);
  FConfirmReplace := JsonValue.GetValue('ConfirmReplace', FConfirmReplace);
  FScope := TFindInFilesScope(JsonValue.GetValue('Scope', Integer(FScope)));
end;

procedure THopePreferencesFindInFiles.WriteJson(
  const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('CaseSensitive', FCaseSensitive);
  JsonValue.AddValue('RegularExpressions', FRegularExpressions);
  JsonValue.AddValue('WholeWordsOnly', FWholeWordsOnly);
  JsonValue.AddValue('ConfirmReplace', FConfirmReplace);
  JsonValue.AddValue('Scope', Integer(FScope));
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
  FDelay := 1000;

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
  FDelay := JsonValue.GetValue('Delay', FDelay);

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
  JsonValue.AddValue('Delay', FDelay);

  FCodeSuggestions.SaveToJson(JsonValue);
end;


{ THopePreferencesVersioningColors }

procedure THopePreferencesVersioningColors.AfterConstruction;
begin
  inherited;

  FConflicted := clRed;
  FAdded := clNavy;
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
  FFindInFiles := THopePreferencesFindInFiles.Create;
  FEditor := THopePreferencesEditor.Create;
  FHighlighter := THopePreferencesHighlighter.Create;
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
  FHighlighter.Free;
  FEditor.Free;
  FFindInFiles.Free;
  FSearch.Free;
  FEnvironment.Free;

  inherited;
end;

procedure THopePreferences.ReadJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

  FEnvironment.LoadFromJson(JsonValue, True);
  FSearch.LoadFromJson(JsonValue, True);
  FFindInFiles.LoadFromJson(JsonValue, True);
  FRecent.LoadFromJson(JsonValue, True);
  FEditor.LoadFromJson(JsonValue, True);
  FHighlighter.LoadFromJson(JsonValue, True);
  FCodeInsight.LoadFromJson(JsonValue, True);
  FVersioning.LoadFromJson(JsonValue, True);
  FFormating.LoadFromJson(JsonValue, True);
end;

procedure THopePreferences.WriteJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

  FEnvironment.SaveToJson(JsonValue);
  FSearch.SaveToJson(JsonValue);
  FFindInFiles.SaveToJson(JsonValue);
  FRecent.SaveToJson(JsonValue);
  FEditor.SaveToJson(JsonValue);
  FHighlighter.SaveToJson(JsonValue);
  FCodeInsight.SaveToJson(JsonValue);
  FVersioning.SaveToJson(JsonValue);
  FFormating.SaveToJson(JsonValue);
end;


end.
