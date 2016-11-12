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

  THopePreferencesHighlighterPascal = class(THopeJsonBase)
  strict private
    FAsmAttr: THopePreferencesFontAttributes;
    FCharAttr: THopePreferencesFontAttributes;
    FCommentAttr: THopePreferencesFontAttributes;
    FDirectiveAttr: THopePreferencesFontAttributes;
    FFloatAttr: THopePreferencesFontAttributes;
    FHexAttr: THopePreferencesFontAttributes;
    FIdentifierAttr: THopePreferencesFontAttributes;
    FKeywordAttr: THopePreferencesFontAttributes;
    FNumberAttr: THopePreferencesFontAttributes;
    FSpaceAttr: THopePreferencesFontAttributes;
    FStringAttr: THopePreferencesFontAttributes;
    FSymbolAttr: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property AsmAttr: THopePreferencesFontAttributes read FAsmAttr;
    property CharAttr: THopePreferencesFontAttributes read FCharAttr;
    property CommentAttr: THopePreferencesFontAttributes read FCommentAttr;
    property DirectiveAttr: THopePreferencesFontAttributes read FDirectiveAttr;
    property FloatAttr: THopePreferencesFontAttributes read FFloatAttr;
    property HexAttr: THopePreferencesFontAttributes read FHexAttr;
    property IdentifierAttr: THopePreferencesFontAttributes read FIdentifierAttr;
    property KeywordAttr: THopePreferencesFontAttributes read FKeywordAttr;
    property NumberAttr: THopePreferencesFontAttributes read FNumberAttr;
    property SpaceAttr: THopePreferencesFontAttributes read FSpaceAttr;
    property StringAttr: THopePreferencesFontAttributes read FStringAttr;
    property SymbolAttr: THopePreferencesFontAttributes read FSymbolAttr;
  end;

  THopePreferencesHighlighterJS = class(THopeJsonBase)
  strict private
    FCommentAttr: THopePreferencesFontAttributes;
    FEventAttr: THopePreferencesFontAttributes;
    FIdentifierAttr: THopePreferencesFontAttributes;
    FKeywordAttr: THopePreferencesFontAttributes;
    FNonReservedKeyAttr: THopePreferencesFontAttributes;
    FNumberAttr: THopePreferencesFontAttributes;
    FSpaceAttr: THopePreferencesFontAttributes;
    FStringAttr: THopePreferencesFontAttributes;
    FSymbolAttr: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property CommentAttr: THopePreferencesFontAttributes read FCommentAttr;
    property EventAttr: THopePreferencesFontAttributes read FEventAttr;
    property IdentifierAttr: THopePreferencesFontAttributes read FIdentifierAttr;
    property KeywordAttr: THopePreferencesFontAttributes read FKeywordAttr;
    property NonReservedKeyAttr: THopePreferencesFontAttributes read FNonReservedKeyAttr;
    property NumberAttr: THopePreferencesFontAttributes read FNumberAttr;
    property SpaceAttr: THopePreferencesFontAttributes read FSpaceAttr;
    property StringAttr: THopePreferencesFontAttributes read FStringAttr;
    property SymbolAttr: THopePreferencesFontAttributes read FSymbolAttr;
  end;

  THopePreferencesHighlighterJson = class(THopeJsonBase)
  strict private
    FAttributeAttr: THopePreferencesFontAttributes;
    FNumberAttr: THopePreferencesFontAttributes;
    FReservedAttr: THopePreferencesFontAttributes;
    FSpaceAttr: THopePreferencesFontAttributes;
    FSymbolAttr: THopePreferencesFontAttributes;
    FValueAttr: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property AttributeAttr: THopePreferencesFontAttributes read FAttributeAttr;
    property ReservedAttr: THopePreferencesFontAttributes read FReservedAttr;
    property NumberAttr: THopePreferencesFontAttributes read FNumberAttr;
    property SpaceAttr: THopePreferencesFontAttributes read FSpaceAttr;
    property SymbolAttr: THopePreferencesFontAttributes read FSymbolAttr;
    property ValueAttr: THopePreferencesFontAttributes read FValueAttr;
  end;

  THopePreferencesHighlighterHTML = class(THopeJsonBase)
  strict private
    FAndAttr: THopePreferencesFontAttributes;
    FCommentAttr: THopePreferencesFontAttributes;
    FIdentifierAttr: THopePreferencesFontAttributes;
    FKeywordAttr: THopePreferencesFontAttributes;
    FSpaceAttr: THopePreferencesFontAttributes;
    FSymbolAttr: THopePreferencesFontAttributes;
    FTextAttr: THopePreferencesFontAttributes;
    FUndefKeyAttr: THopePreferencesFontAttributes;
    FValueAttr: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property AndAttr: THopePreferencesFontAttributes read FAndAttr;
    property CommentAttr: THopePreferencesFontAttributes read FCommentAttr;
    property IdentifierAttr: THopePreferencesFontAttributes read FIdentifierAttr;
    property KeywordAttr: THopePreferencesFontAttributes read FKeywordAttr;
    property SpaceAttr: THopePreferencesFontAttributes read FSpaceAttr;
    property SymbolAttr: THopePreferencesFontAttributes read FSymbolAttr;
    property TextAttr: THopePreferencesFontAttributes read FTextAttr;
    property UndefKeyAttr: THopePreferencesFontAttributes read FUndefKeyAttr;
    property ValueAttr: THopePreferencesFontAttributes read FValueAttr;
  end;

  THopePreferencesHighlighterCSS = class(THopeJsonBase)
  strict private
    FAtRuleAttr: THopePreferencesFontAttributes;
    FColorAttr: THopePreferencesFontAttributes;
    FCommentAttr: THopePreferencesFontAttributes;
    FKeywordAttr: THopePreferencesFontAttributes;
    FNumberAttr: THopePreferencesFontAttributes;
    FPropertyAttr: THopePreferencesFontAttributes;
    FSelectorAttr: THopePreferencesFontAttributes;
    FSpaceAttr: THopePreferencesFontAttributes;
    FStringAttr: THopePreferencesFontAttributes;
    FSymbolAttr: THopePreferencesFontAttributes;
    FTextAttr: THopePreferencesFontAttributes;
    FUndefPropertyAttr: THopePreferencesFontAttributes;
    FValueAttr: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property AtRuleAttr: THopePreferencesFontAttributes read FAtRuleAttr;
    property ColorAttr: THopePreferencesFontAttributes read FColorAttr;
    property CommentAttr: THopePreferencesFontAttributes read FCommentAttr;
    property KeywordAttr: THopePreferencesFontAttributes read FKeywordAttr;
    property NumberAttr: THopePreferencesFontAttributes read FNumberAttr;
    property PropertyAttr: THopePreferencesFontAttributes read FPropertyAttr;
    property SelectorAttr: THopePreferencesFontAttributes read FSelectorAttr;
    property SpaceAttr: THopePreferencesFontAttributes read FSpaceAttr;
    property StringAttr: THopePreferencesFontAttributes read FStringAttr;
    property SymbolAttr: THopePreferencesFontAttributes read FSymbolAttr;
    property TextAttr: THopePreferencesFontAttributes read FTextAttr;
    property UndefPropertyAttr: THopePreferencesFontAttributes read FUndefPropertyAttr;
    property ValueAttr: THopePreferencesFontAttributes read FValueAttr;
  end;

  THopePreferencesHighlighter = class(THopeJsonBase)
  strict private
    FCommentAttr: THopePreferencesFontAttributes;
    FErrorAttr: THopePreferencesFontAttributes;
    FErrorWordAttr: THopePreferencesFontAttributes;
    FFontAttr: THopePreferencesFontAttributes;
    FHighlighterCSS: THopePreferencesHighlighterCSS;
    FHighlighterHTML: THopePreferencesHighlighterHTML;
    FHighlighterJS: THopePreferencesHighlighterJS;
    FHighlighterJSON: THopePreferencesHighlighterJson;
    FHighlighterPascal: THopePreferencesHighlighterPascal;
    FHintAttr: THopePreferencesFontAttributes;
    FHintWordAttr: THopePreferencesFontAttributes;
    FIdentifierAttr: THopePreferencesFontAttributes;
    FKeywordAttr: THopePreferencesFontAttributes;
    FLinkAttr: THopePreferencesFontAttributes;
    FMarkerAttr: THopePreferencesFontAttributes;
    FSearchWordAttr: THopePreferencesFontAttributes;
    FStringAttr: THopePreferencesFontAttributes;
    FSymbolAttr: THopePreferencesFontAttributes;
    FWarningAttr: THopePreferencesFontAttributes;
    FWarningWordAttr: THopePreferencesFontAttributes;
    FWhitespaceAttr: THopePreferencesFontAttributes;
  protected
    procedure ReadJson(const JsonValue: TdwsJsonObject); override;
    procedure WriteJson(const JsonValue: TdwsJsonObject); override;
    class function GetPreferredName: string; override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property CommentAttr: THopePreferencesFontAttributes read FCommentAttr write FCommentAttr;
    property ErrorAttr: THopePreferencesFontAttributes read FErrorAttr write FErrorAttr;
    property ErrorWordAttr: THopePreferencesFontAttributes read FErrorWordAttr write FErrorWordAttr;
    property FontAttr: THopePreferencesFontAttributes read FFontAttr write FFontAttr;
    property HighlighterCSS: THopePreferencesHighlighterCSS read FHighlighterCSS;
    property HighlighterHTML: THopePreferencesHighlighterHTML read FHighlighterHTML;
    property HighlighterJS: THopePreferencesHighlighterJS read FHighlighterJS;
    property HighlighterJSON: THopePreferencesHighlighterJson read FHighlighterJSON;
    property HighlighterPascal: THopePreferencesHighlighterPascal read FHighlighterPascal;
    property HintAttr: THopePreferencesFontAttributes read FHintAttr write FHintAttr;
    property HintWordAttr: THopePreferencesFontAttributes read FHintWordAttr write FHintWordAttr;
    property IdentifierAttr: THopePreferencesFontAttributes read FIdentifierAttr write FIdentifierAttr;
    property KeywordAttr: THopePreferencesFontAttributes read FKeywordAttr write FKeywordAttr;
    property LinkAttr: THopePreferencesFontAttributes read FLinkAttr write FLinkAttr;
    property MarkerAttr: THopePreferencesFontAttributes read FMarkerAttr write FMarkerAttr;
    property SearchWordAttr: THopePreferencesFontAttributes read FSearchWordAttr write FSearchWordAttr;
    property StringAttr: THopePreferencesFontAttributes read FStringAttr write FStringAttr;
    property SymbolAttr: THopePreferencesFontAttributes read FSymbolAttr write FSymbolAttr;
    property WarningAttr: THopePreferencesFontAttributes read FWarningAttr write FWarningAttr;
    property WarningWordAttr: THopePreferencesFontAttributes read FWarningWordAttr write FWarningWordAttr;
    property WhitespaceAttr: THopePreferencesFontAttributes read FWhitespaceAttr write FWhitespaceAttr;
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


{ THopePreferencesHighlighterPascal }

procedure THopePreferencesHighlighterPascal.AfterConstruction;
begin
  inherited;

  FAsmAttr := THopePreferencesFontAttributes.Create;
  FCharAttr := THopePreferencesFontAttributes.Create;
  FCommentAttr := THopePreferencesFontAttributes.Create;
  FDirectiveAttr := THopePreferencesFontAttributes.Create;
  FFloatAttr := THopePreferencesFontAttributes.Create;
  FHexAttr := THopePreferencesFontAttributes.Create;
  FIdentifierAttr := THopePreferencesFontAttributes.Create;
  FKeywordAttr := THopePreferencesFontAttributes.Create;
  FNumberAttr := THopePreferencesFontAttributes.Create;
  FSpaceAttr := THopePreferencesFontAttributes.Create;
  FStringAttr := THopePreferencesFontAttributes.Create;
  FSymbolAttr := THopePreferencesFontAttributes.Create;
end;

procedure THopePreferencesHighlighterPascal.BeforeDestruction;
begin
  FAsmAttr.Free;
  FCharAttr.Free;
  FCommentAttr.Free;
  FDirectiveAttr.Free;
  FFloatAttr.Free;
  FHexAttr.Free;
  FIdentifierAttr.Free;
  FKeywordAttr.Free;
  FNumberAttr.Free;
  FSpaceAttr.Free;
  FStringAttr.Free;
  FSymbolAttr.Free;

  inherited;
end;

class function THopePreferencesHighlighterPascal.GetPreferredName: string;
begin
  Result := 'Pascal';
end;

procedure THopePreferencesHighlighterPascal.ReadJson(const JsonValue: TdwsJsonObject);
begin
  AsmAttr.LoadFromJson('Asm', JsonValue, True);
  CharAttr.LoadFromJson('Char', JsonValue, True);
  CommentAttr.LoadFromJson('Comment', JsonValue, True);
  DirectiveAttr.LoadFromJson('Directive', JsonValue, True);
  FloatAttr.LoadFromJson('Float', JsonValue, True);
  HexAttr.LoadFromJson('Hex', JsonValue, True);
  IdentifierAttr.LoadFromJson('Identifier', JsonValue, True);
  KeywordAttr.LoadFromJson('Keyword', JsonValue, True);
  NumberAttr.LoadFromJson('Number', JsonValue, True);
  SpaceAttr.LoadFromJson('Space', JsonValue, True);
  StringAttr.LoadFromJson('String', JsonValue, True);
  SymbolAttr.LoadFromJson('Symbol', JsonValue, True);
end;

procedure THopePreferencesHighlighterPascal.WriteJson(const JsonValue: TdwsJsonObject);
begin
  AsmAttr.SaveToJson('Asm', JsonValue);
  CharAttr.SaveToJson('Char', JsonValue);
  CommentAttr.SaveToJson('Comment', JsonValue);
  DirectiveAttr.SaveToJson('Directive', JsonValue);
  FloatAttr.SaveToJson('Float', JsonValue);
  HexAttr.SaveToJson('Hex', JsonValue);
  IdentifierAttr.SaveToJson('Identifier', JsonValue);
  KeywordAttr.SaveToJson('Keyword', JsonValue);
  NumberAttr.SaveToJson('Number', JsonValue);
  SpaceAttr.SaveToJson('Space', JsonValue);
  StringAttr.SaveToJson('String', JsonValue);
  SymbolAttr.SaveToJson('Symbol', JsonValue);
end;


{ THopePreferencesHighlighterJS }

procedure THopePreferencesHighlighterJS.AfterConstruction;
begin
  inherited;

  FIdentifierAttr := THopePreferencesFontAttributes.Create;
  FKeywordAttr := THopePreferencesFontAttributes.Create;
  FCommentAttr := THopePreferencesFontAttributes.Create;
  FEventAttr := THopePreferencesFontAttributes.Create;
  FNonReservedKeyAttr := THopePreferencesFontAttributes.Create;
  FStringAttr := THopePreferencesFontAttributes.Create;
  FSymbolAttr := THopePreferencesFontAttributes.Create;
  FNumberAttr := THopePreferencesFontAttributes.Create;
  FSpaceAttr := THopePreferencesFontAttributes.Create;
end;

procedure THopePreferencesHighlighterJS.BeforeDestruction;
begin
  FSpaceAttr.Free;
  FNumberAttr.Free;
  FSymbolAttr.Free;
  FStringAttr.Free;
  FNonReservedKeyAttr.Free;
  FEventAttr.Free;
  FCommentAttr.Free;
  FKeywordAttr.Free;
  FIdentifierAttr.Free;

  inherited;
end;

class function THopePreferencesHighlighterJS.GetPreferredName: string;
begin
  Result := 'JS';
end;

procedure THopePreferencesHighlighterJS.ReadJson(const JsonValue: TdwsJsonObject);
begin
  CommentAttr.LoadFromJson('Comment', JsonValue, True);
  EventAttr.LoadFromJson('Event', JsonValue, True);
  IdentifierAttr.LoadFromJson('Identifier', JsonValue, True);
  KeywordAttr.LoadFromJson('Keyword', JsonValue, True);
  NonReservedKeyAttr.LoadFromJson('NonReservedKeyword', JsonValue, True);
  NumberAttr.LoadFromJson('Number', JsonValue, True);
  SpaceAttr.LoadFromJson('Space', JsonValue, True);
  StringAttr.LoadFromJson('String', JsonValue, True);
  SymbolAttr.LoadFromJson('Symbol', JsonValue, True);
end;

procedure THopePreferencesHighlighterJS.WriteJson(const JsonValue: TdwsJsonObject);
begin
  CommentAttr.SaveToJson('Comment', JsonValue);
  EventAttr.SaveToJson('Event', JsonValue);
  IdentifierAttr.SaveToJson('Identifier', JsonValue);
  KeywordAttr.SaveToJson('Keyword', JsonValue);
  NonReservedKeyAttr.SaveToJson('NonReservedKeyword', JsonValue);
  NumberAttr.SaveToJson('Number', JsonValue);
  SpaceAttr.SaveToJson('Space', JsonValue);
  StringAttr.SaveToJson('String', JsonValue);
  SymbolAttr.SaveToJson('Symbol', JsonValue);
end;


{ THopePreferencesHighlighterJson }

procedure THopePreferencesHighlighterJson.AfterConstruction;
begin
  inherited;

  FAttributeAttr := THopePreferencesFontAttributes.Create;
  FReservedAttr := THopePreferencesFontAttributes.Create;
  FNumberAttr := THopePreferencesFontAttributes.Create;
  FSpaceAttr := THopePreferencesFontAttributes.Create;
  FSymbolAttr := THopePreferencesFontAttributes.Create;
  FValueAttr := THopePreferencesFontAttributes.Create;
end;

procedure THopePreferencesHighlighterJson.BeforeDestruction;
begin
  FValueAttr.Free;
  FSymbolAttr.Free;
  FSpaceAttr.Free;
  FNumberAttr.Free;
  FReservedAttr.Free;
  FAttributeAttr.Free;

  inherited;
end;

class function THopePreferencesHighlighterJson.GetPreferredName: string;
begin
  Result := 'JSON';
end;

procedure THopePreferencesHighlighterJson.ReadJson(const JsonValue: TdwsJsonObject);
begin
  AttributeAttr.LoadFromJson('Attribute', JsonValue, True);
  ReservedAttr.LoadFromJson('Reserved', JsonValue, True);
  NumberAttr.LoadFromJson('Number', JsonValue, True);
  SpaceAttr.LoadFromJson('Space', JsonValue, True);
  SymbolAttr.LoadFromJson('Symbol', JsonValue, True);
  ValueAttr.LoadFromJson('Value', JsonValue, True);
end;

procedure THopePreferencesHighlighterJson.WriteJson(const JsonValue: TdwsJsonObject);
begin
  AttributeAttr.SaveToJson('Attribute', JsonValue);
  ReservedAttr.SaveToJson('Reserved', JsonValue);
  NumberAttr.SaveToJson('Number', JsonValue);
  SpaceAttr.SaveToJson('Space', JsonValue);
  SymbolAttr.SaveToJson('Symbol', JsonValue);
  ValueAttr.SaveToJson('Value', JsonValue);
end;


{ THopePreferencesHighlighterHTML }

procedure THopePreferencesHighlighterHTML.AfterConstruction;
begin
  inherited;

  FAndAttr := THopePreferencesFontAttributes.Create;
  FCommentAttr := THopePreferencesFontAttributes.Create;
  FIdentifierAttr := THopePreferencesFontAttributes.Create;
  FKeywordAttr := THopePreferencesFontAttributes.Create;
  FSpaceAttr := THopePreferencesFontAttributes.Create;
  FSymbolAttr := THopePreferencesFontAttributes.Create;
  FTextAttr := THopePreferencesFontAttributes.Create;
  FUndefKeyAttr := THopePreferencesFontAttributes.Create;
  FValueAttr := THopePreferencesFontAttributes.Create;
end;

procedure THopePreferencesHighlighterHTML.BeforeDestruction;
begin
  FValueAttr.Free;
  FUndefKeyAttr.Free;
  FTextAttr.Free;
  FSymbolAttr.Free;
  FSpaceAttr.Free;
  FKeywordAttr.Free;
  FIdentifierAttr.Free;
  FCommentAttr.Free;
  FAndAttr.Free;

  inherited;
end;

class function THopePreferencesHighlighterHTML.GetPreferredName: string;
begin
  Result := 'HTML';
end;

procedure THopePreferencesHighlighterHTML.ReadJson(const JsonValue: TdwsJsonObject);
begin
  AndAttr.LoadFromJson('And', JsonValue, True);
  CommentAttr.LoadFromJson('Comment', JsonValue, True);
  IdentifierAttr.LoadFromJson('Identifier', JsonValue, True);
  KeywordAttr.LoadFromJson('Keyword', JsonValue, True);
  SpaceAttr.LoadFromJson('Space', JsonValue, True);
  SymbolAttr.LoadFromJson('Symbol', JsonValue, True);
  TextAttr.LoadFromJson('Text', JsonValue, True);
  UndefKeyAttr.LoadFromJson('UndefKey', JsonValue, True);
  ValueAttr.LoadFromJson('Value', JsonValue, True);
end;

procedure THopePreferencesHighlighterHTML.WriteJson(const JsonValue: TdwsJsonObject);
begin
  AndAttr.SaveToJson('And', JsonValue);
  CommentAttr.SaveToJson('Comment', JsonValue);
  IdentifierAttr.SaveToJson('Identifier', JsonValue);
  KeywordAttr.SaveToJson('Keyword', JsonValue);
  SpaceAttr.SaveToJson('Space', JsonValue);
  SymbolAttr.SaveToJson('Symbol', JsonValue);
  TextAttr.SaveToJson('Text', JsonValue);
  UndefKeyAttr.SaveToJson('UndefKey', JsonValue);
  ValueAttr.SaveToJson('Value', JsonValue);
end;


{ THopePreferencesHighlighterCSS }

procedure THopePreferencesHighlighterCSS.AfterConstruction;
begin
  inherited;

  FAtRuleAttr := THopePreferencesFontAttributes.Create;
  FColorAttr := THopePreferencesFontAttributes.Create;
  FCommentAttr := THopePreferencesFontAttributes.Create;
  FKeywordAttr := THopePreferencesFontAttributes.Create;
  FNumberAttr := THopePreferencesFontAttributes.Create;
  FPropertyAttr := THopePreferencesFontAttributes.Create;
  FSelectorAttr := THopePreferencesFontAttributes.Create;
  FSpaceAttr := THopePreferencesFontAttributes.Create;
  FStringAttr := THopePreferencesFontAttributes.Create;
  FSymbolAttr := THopePreferencesFontAttributes.Create;
  FTextAttr := THopePreferencesFontAttributes.Create;
  FUndefPropertyAttr := THopePreferencesFontAttributes.Create;
  FValueAttr := THopePreferencesFontAttributes.Create;
end;

procedure THopePreferencesHighlighterCSS.BeforeDestruction;
begin
  FValueAttr.Free;
  FUndefPropertyAttr.Free;
  FTextAttr.Free;
  FSymbolAttr.Free;
  FStringAttr.Free;
  FSpaceAttr.Free;
  FSelectorAttr.Free;
  FPropertyAttr.Free;
  FNumberAttr.Free;
  FKeywordAttr.Free;
  FCommentAttr.Free;
  FColorAttr.Free;
  FAtRuleAttr.Free;

  inherited;
end;

class function THopePreferencesHighlighterCSS.GetPreferredName: string;
begin
  Result := 'CSS';
end;

procedure THopePreferencesHighlighterCSS.ReadJson(const JsonValue: TdwsJsonObject);
begin
  AtRuleAttr.LoadFromJson('AtRule', JsonValue, True);
  ColorAttr.LoadFromJson('Color', JsonValue, True);
  CommentAttr.LoadFromJson('Comment', JsonValue, True);
  KeywordAttr.LoadFromJson('Keyword', JsonValue, True);
  NumberAttr.LoadFromJson('Number', JsonValue, True);
  PropertyAttr.LoadFromJson('Property', JsonValue, True);
  SelectorAttr.LoadFromJson('Selector', JsonValue, True);
  SpaceAttr.LoadFromJson('Space', JsonValue, True);
  StringAttr.LoadFromJson('String', JsonValue, True);
  SymbolAttr.LoadFromJson('Symbol', JsonValue, True);
  TextAttr.LoadFromJson('Text', JsonValue, True);
  UndefPropertyAttr.LoadFromJson('UndefProperty', JsonValue, True);
  ValueAttr.LoadFromJson('Value', JsonValue, True);
end;

procedure THopePreferencesHighlighterCSS.WriteJson(const JsonValue: TdwsJsonObject);
begin
  AtRuleAttr.SaveToJson('AtRule', JsonValue);
  ColorAttr.SaveToJson('Color', JsonValue);
  CommentAttr.SaveToJson('Comment', JsonValue);
  KeywordAttr.SaveToJson('Keyword', JsonValue);
  NumberAttr.SaveToJson('Number', JsonValue);
  PropertyAttr.SaveToJson('Property', JsonValue);
  SelectorAttr.SaveToJson('Selector', JsonValue);
  SpaceAttr.SaveToJson('Space', JsonValue);
  StringAttr.SaveToJson('String', JsonValue);
  SymbolAttr.SaveToJson('Symbol', JsonValue);
  TextAttr.SaveToJson('Text', JsonValue);
  UndefPropertyAttr.SaveToJson('UndefProperty', JsonValue);
  ValueAttr.SaveToJson('Value', JsonValue);
end;


{ THopePreferencesHighlighter }

procedure THopePreferencesHighlighter.AfterConstruction;
begin
  inherited;

  // create attributes
  FCommentAttr := THopePreferencesFontAttributes.Create;
  FErrorAttr := THopePreferencesFontAttributes.Create;
  FErrorWordAttr := THopePreferencesFontAttributes.Create;
  FFontAttr := THopePreferencesFontAttributes.Create;
  FHintAttr := THopePreferencesFontAttributes.Create;
  FHintWordAttr := THopePreferencesFontAttributes.Create;
  FIdentifierAttr := THopePreferencesFontAttributes.Create;
  FKeywordAttr := THopePreferencesFontAttributes.Create;
  FLinkAttr := THopePreferencesFontAttributes.Create;
  FMarkerAttr := THopePreferencesFontAttributes.Create;
  FSearchWordAttr := THopePreferencesFontAttributes.Create;
  FStringAttr := THopePreferencesFontAttributes.Create;
  FSymbolAttr := THopePreferencesFontAttributes.Create;
  FWarningAttr := THopePreferencesFontAttributes.Create;
  FWarningWordAttr := THopePreferencesFontAttributes.Create;
  FWhitespaceAttr := THopePreferencesFontAttributes.Create;

  // create highlighter
  FHighlighterCSS := THopePreferencesHighlighterCSS.Create;
  FHighlighterHTML := THopePreferencesHighlighterHTML.Create;
  FHighlighterJS := THopePreferencesHighlighterJS.Create;
  FHighlighterJSON := THopePreferencesHighlighterJson.Create;
  FHighlighterPascal := THopePreferencesHighlighterPascal.Create;

  // preset colors
  FHintAttr.SetColors(clNone, $00FFD8C0);
  FHintWordAttr.SetColors(clNone, $00FFC080);
  FWarningAttr.SetColors(clNone, $00C0FFFF);
  FWarningWordAttr.SetColors(clNone, $0080FFFF);
  FErrorAttr.SetColors(clNone, $00C0C0FF);
  FErrorWordAttr.SetColors(clNone, $008080FF);
  FSearchWordAttr.SetColors(clNone, $0078AAFF);
  FLinkAttr.SetColors(clBlue, clNone);
  FLinkAttr.Style := [fsUnderline];
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
  FWhitespaceAttr.Free;
  FWarningWordAttr.Free;
  FWarningAttr.Free;
  FSymbolAttr.Free;
  FStringAttr.Free;
  FSearchWordAttr.Free;
  FMarkerAttr.Free;
  FLinkAttr.Free;
  FKeywordAttr.Free;
  FIdentifierAttr.Free;
  FHintWordAttr.Free;
  FHintAttr.Free;
  FFontAttr.Free;
  FErrorWordAttr.Free;
  FErrorAttr.Free;
  FCommentAttr.Free;

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
  CommentAttr.LoadFromJson('Comment', JsonValue, True);
  FontAttr.LoadFromJson('Font', JsonValue, True);
  IdentifierAttr.LoadFromJson('Identifier', JsonValue, True);
  KeywordAttr.LoadFromJson('Keyword', JsonValue, True);
  HintAttr.LoadFromJson('Hint', JsonValue, True);
  HintWordAttr.LoadFromJson('HintWord', JsonValue, True);
  WarningAttr.LoadFromJson('Warning', JsonValue, True);
  WarningWordAttr.LoadFromJson('WarningWord', JsonValue, True);
  ErrorAttr.LoadFromJson('Error', JsonValue, True);
  ErrorWordAttr.LoadFromJson('ErrorWord', JsonValue, True);
  LinkAttr.LoadFromJson('Link', JsonValue, True);
  MarkerAttr.LoadFromJson('Marker', JsonValue, True);
  StringAttr.LoadFromJson('String', JsonValue, True);
  SymbolAttr.LoadFromJson('Symbol', JsonValue, True);
  WhitespaceAttr.LoadFromJson('Whitespace', JsonValue, True);
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
  CommentAttr.SaveToJson('Comment', JsonValue);
  FontAttr.SaveToJson('Font', JsonValue);
  IdentifierAttr.SaveToJson('Identifier', JsonValue);
  KeywordAttr.SaveToJson('Keyword', JsonValue);
  HintAttr.SaveToJson('Hint', JsonValue);
  HintWordAttr.SaveToJson('HintWord', JsonValue);
  WarningAttr.SaveToJson('Warning', JsonValue);
  WarningWordAttr.SaveToJson('WarningWord', JsonValue);
  ErrorAttr.SaveToJson('Error', JsonValue);
  ErrorWordAttr.SaveToJson('ErrorWord', JsonValue);
  LinkAttr.SaveToJson('Link', JsonValue);
  MarkerAttr.SaveToJson('Marker', JsonValue);
  StringAttr.SaveToJson('String', JsonValue);
  SymbolAttr.SaveToJson('Symbol', JsonValue);
  WhitespaceAttr.SaveToJson('Whitespace', JsonValue);
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
