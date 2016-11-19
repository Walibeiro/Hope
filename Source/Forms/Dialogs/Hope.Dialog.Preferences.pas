unit Hope.Dialog.Preferences;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  System.Actions, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.ActnList, Vcl.Samples.Spin,
  VirtualTrees, SynEdit, SynHighlighterHtml, SynHighlighterCSS,
  SynHighlighterJSON, SynHighlighterJScript, SynEditHighlighter,
  SynHighlighterDWS, SynEditKeyCmds, SynHighlighterMulti, Hope.Dialog,
  Hope.Common.Preferences;

type
  TTabSheetItem = record
    TabSheet: TTabSheet;
  end;
  PTabSheetItem = ^TTabSheetItem;

  THistoryItem = record
    FileName: TFileName;
  end;
  PHistoryItem = ^THistoryItem;

  THighlightLine = (hlHint, hlWarning, hlError);

  TFormPreferences = class(TFormDialog)
    ActionClear: TAction;
    ActionDelete: TAction;
    ActionDeleteNonexistingFiles: TAction;
    ActionLibraryPathAdd: TAction;
    ActionLibraryPathCleanUp: TAction;
    ActionLibraryPathDelete: TAction;
    ActionLibraryPathDown: TAction;
    ActionLibraryPathPick: TAction;
    ActionLibraryPathReplace: TAction;
    ActionLibraryPathUp: TAction;
    ActionList: TActionList;
    ActionLoad: TAction;
    ActionSave: TAction;
    Bevel: TBevel;
    Button1: TButton;
    ButtonAdd: TButton;
    ButtonCleanUp: TButton;
    ButtonClear: TButton;
    ButtonDelete: TButton;
    ButtonDown: TButton;
    ButtonLoad: TButton;
    ButtonPick: TButton;
    ButtonProjectPath: TButton;
    ButtonRemoveInvalid: TButton;
    ButtonReplace: TButton;
    ButtonSave: TButton;
    ButtonUp: TButton;
    CheckBoxAltSetsColumnMode: TCheckBox;
    CheckBoxAutoIndent: TCheckBox;
    CheckBoxAutoParenthesis: TCheckBox;
    CheckBoxAutoSizeMaxWidth: TCheckBox;
    CheckBoxBlockCompletion: TCheckBox;
    CheckBoxBold: TCheckBox;
    CheckBoxCodeParameters: TCheckBox;
    CheckBoxCodeSuggestions: TCheckBox;
    CheckBoxCodeTemplateCompletion: TCheckBox;
    CheckBoxDisableScrollArrows: TCheckBox;
    CheckBoxDragAndDropEditing: TCheckBox;
    CheckBoxEnhanceEndKey: TCheckBox;
    CheckBoxEnhanceHomeKey: TCheckBox;
    CheckBoxErrorInsight: TCheckBox;
    CheckBoxGroupUndo: TCheckBox;
    CheckBoxHalfPageScroll: TCheckBox;
    CheckBoxHideShowScrollbars: TCheckBox;
    CheckBoxItalic: TCheckBox;
    CheckBoxKeepCaretX: TCheckBox;
    CheckBoxRightMouseMoves: TCheckBox;
    CheckBoxScrollByOneLess: TCheckBox;
    CheckBoxScrollHintFollows: TCheckBox;
    CheckBoxScrollPastEOF: TCheckBox;
    CheckBoxScrollPastEOL: TCheckBox;
    CheckBoxShowReservedWords: TCheckBox;
    CheckBoxShowScrollHint: TCheckBox;
    CheckBoxShowSpecialChars: TCheckBox;
    CheckBoxSmartTabDelete: TCheckBox;
    CheckBoxSmartTabs: TCheckBox;
    CheckBoxTabIndent: TCheckBox;
    CheckBoxTabsToSpaces: TCheckBox;
    CheckBoxTooltipSymbol: TCheckBox;
    CheckBoxTrimTrailingSpaces: TCheckBox;
    CheckBoxUnderlined: TCheckBox;
    CheckBoxWantTabs: TCheckBox;
    ColorBoxAdded: TColorBox;
    ColorBoxBackground: TColorBox;
    ColorBoxConflicted: TColorBox;
    ColorBoxForeground: TColorBox;
    ComboBoxBlockCompletion: TComboBox;
    ComboBoxElement: TComboBox;
    ComboBoxInsertCaret: TComboBox;
    ComboBoxLanguage: TComboBox;
    ComboBoxOverwriteCaret: TComboBox;
    ComboBoxProjectPath: TComboBox;
    EditorPreview: TSynEdit;
    EditPath: TEdit;
    GroupBoxAutomaticFeatures: TGroupBox;
    GroupBoxCapacity: TGroupBox;
    GroupBoxCaret: TGroupBox;
    GroupBoxColors: TGroupBox;
    GroupBoxElement: TGroupBox;
    GroupBoxItems: TGroupBox;
    GroupBoxLibraryPaths: TGroupBox;
    GroupBoxOptions: TGroupBox;
    GroupBoxPaths: TGroupBox;
    GroupBoxPreview: TGroupBox;
    GroupBoxSettings: TGroupBox;
    LabelAdded: TLabel;
    LabelBackground: TLabel;
    LabelConflicts: TLabel;
    LabelDelay: TLabel;
    LabelElement: TLabel;
    LabelForeground: TLabel;
    LabelIndention: TLabel;
    LabelIndentMax: TLabel;
    LabelInsertCaret: TLabel;
    LabelLanguage: TLabel;
    LabelNone: TLabel;
    LabelOff: TLabel;
    LabelOverwriteCaret: TLabel;
    LabelProjectCount: TLabel;
    LabelProjectPath: TLabel;
    LabelUnitCount: TLabel;
    LabelValue: TLabel;
    ListBoxLibraryPaths: TListBox;
    PageControl: TPageControl;
    PanelElementSettings: TPanel;
    PanelTop: TPanel;
    SpinEditIndent: TSpinEdit;
    SpinEditIndentMax: TSpinEdit;
    SpinEditProjectCount: TSpinEdit;
    SpinEditUnitCOunt: TSpinEdit;
    SynCSS: TSynCssSyn;
    SynDWS: TSynDWSSyn;
    SynHTML: TSynHTMLSyn;
    SynJS: TSynJScriptSyn;
    SynJSON: TSynJSONSyn;
    SynMultiCSS: TSynMultiSyn;
    SynMultiHTML: TSynMultiSyn;
    SynPascal: TSynMultiSyn;
    TabSheetCodeInsight: TTabSheet;
    TabSheetDeployment: TTabSheet;
    TabSheetDesigner: TTabSheet;
    TabSheetEditorOptions: TTabSheet;
    TabSheetEnvironment: TTabSheet;
    TabSheetFormating: TTabSheet;
    TabSheetHighlighterOptions: TTabSheet;
    TabSheetLibraryPaths: TTabSheet;
    TabSheetRecentFiles: TTabSheet;
    TabSheetVersionControl: TTabSheet;
    TrackBarDelay: TTrackBar;
    TreeCategory: TVirtualStringTree;
    TreeItems: TVirtualStringTree;
    TabSheetAppearance: TTabSheet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActionClearExecute(Sender: TObject);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure ActionLoadExecute(Sender: TObject);
    procedure ActionSaveExecute(Sender: TObject);
    procedure ButtonProjectPathClick(Sender: TObject);
    procedure CheckBoxBoldClick(Sender: TObject);
    procedure CheckBoxItalicClick(Sender: TObject);
    procedure CheckBoxUnderlinedClick(Sender: TObject);
    procedure ColorBoxBackgroundChange(Sender: TObject);
    procedure ColorBoxForegroundChange(Sender: TObject);
    procedure ComboBoxElementChange(Sender: TObject);
    procedure ComboBoxLanguageChange(Sender: TObject);
    procedure EditorPreviewChange(Sender: TObject);
    procedure EditorPreviewClick(Sender: TObject);
    procedure EditorPreviewCommandProcessed(Sender: TObject;
      var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
    procedure EditorPreviewGutterPaint(Sender: TObject; aLine, X, Y: Integer);
    procedure EditorPreviewSpecialLineColors(Sender: TObject; Line: Integer;
      var Special: Boolean; var FG, BG: TColor);
    procedure TrackBarDelayChange(Sender: TObject);
    procedure TreeCategoryChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeCategoryGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure TreeCategoryGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure TreeCategoryIncrementalSearch(Sender: TBaseVirtualTree;
      Node: PVirtualNode; const SearchText: string; var Result: Integer);
    procedure TreeItemsCollapsing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      var Allowed: Boolean);
    procedure TreeItemsDrawText(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
    procedure TreeItemsFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure TreeItemsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure ColorBoxForegroundGetColors(Sender: TCustomColorBox;
      Items: TStrings);
  private
    FProjectsNode: PVirtualNode;
    FUnitsNode: PVirtualNode;
    FHighlightLine: array [THighlightLine] of Integer;
    FCurrentFontAttributes: TSynHighlighterAttributes;
    FHint: TSynHighlighterAttributes;
    FWarning: TSynHighlighterAttributes;
    FError: TSynHighlighterAttributes;
    FLink: TSynHighlighterAttributes;
    FMarker: TSynHighlighterAttributes;
    FEditorAttributeCount: Integer;
    procedure UpdateTree;
    procedure UpdateElements;

    procedure HighlightDWS;
    procedure HighlightJS;
    procedure HighlightJSON;
    procedure HighlightHTML;
    procedure HighlightCSS;

    procedure EditorPreviewCaretPositionChanged;

    procedure LoadHighlighters(Highlighter: THopePreferencesHighlighter);
    procedure SaveHighlighters(Highlighter: THopePreferencesHighlighter);
    procedure LoadHighlightersFromFile(FileName: TFileName);
    procedure SaveHighlightersToFile(FileName: TFileName);
    procedure UpdateHistoryItems;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure Load;
    procedure Save;
  end;

implementation

uses
  System.Math, Vcl.FileCtrl, Hope.DataModule.ImageLists, Hope.DataModule.Common;

{$R *.dfm}

{ TFormPreferences }

procedure TFormPreferences.AfterConstruction;
begin
  inherited;

  TreeCategory.NodeDataSize := SizeOf(TTabSheetItem);
  TreeItems.NodeDataSize := SizeOf(THistoryItem);

  FHint := TSynHighlighterAttributes.Create('Hint', 'Compiler Hint');
  FHint.Background := $FFFFC0;
  FWarning := TSynHighlighterAttributes.Create('Warning', 'Compiler Warning');
  FWarning.Background := $B0FFFF;
  FError := TSynHighlighterAttributes.Create('Error', 'Compiler Error');
  FError.Background := $B0B0FF;
  FLink := TSynHighlighterAttributes.Create('Link', 'Link');
  FLink.Foreground := clBlue;
  FLink.Style := [fsUnderline];
  FMarker := TSynHighlighterAttributes.Create('Marker', 'Marker');
  FMarker.Background := clYellow;
  FMarker.Foreground := clBlack;

  UpdateTree;
  UpdateElements;
  UpdateHistoryItems;
  HighlightDWS;
end;

procedure TFormPreferences.BeforeDestruction;
begin
  FMarker.Free;
  FLink.Free;
  FError.Free;
  FWarning.Free;
  FHint.Free;

  inherited;
end;

procedure TFormPreferences.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
    Save;
end;

procedure TFormPreferences.ButtonProjectPathClick(Sender: TObject);
var
  Directory: string;
begin
  inherited;

  // default to current directory
  Directory := ComboBoxProjectPath.Text;
  if Directory = '' then
    Directory := DataModuleCommon.Paths.Root;

  // show select directory dialog
  if SelectDirectory('Default Project Path', '', Directory) then
    ComboBoxProjectPath.Text := Directory;
end;

procedure TFormPreferences.CheckBoxBoldClick(Sender: TObject);
begin
  // check if a font attribute is assigned at all
  if not Assigned(FCurrentFontAttributes) then
    Exit;

  if CheckBoxBold.Checked then
    FCurrentFontAttributes.Style := FCurrentFontAttributes.Style + [fsBold]
  else
    FCurrentFontAttributes.Style := FCurrentFontAttributes.Style - [fsBold];
end;

procedure TFormPreferences.CheckBoxItalicClick(Sender: TObject);
begin
  // check if a font attribute is assigned at all
  if not Assigned(FCurrentFontAttributes) then
    Exit;

  if CheckBoxItalic.Checked then
    FCurrentFontAttributes.Style := FCurrentFontAttributes.Style + [fsItalic]
  else
    FCurrentFontAttributes.Style := FCurrentFontAttributes.Style - [fsItalic];
end;

procedure TFormPreferences.CheckBoxUnderlinedClick(Sender: TObject);
begin
  // check if a font attribute is assigned at all
  if not Assigned(FCurrentFontAttributes) then
    Exit;

  if CheckBoxUnderlined.Checked then
    FCurrentFontAttributes.Style := FCurrentFontAttributes.Style + [fsUnderline]
  else
    FCurrentFontAttributes.Style := FCurrentFontAttributes.Style - [fsUnderline];
end;

procedure TFormPreferences.ColorBoxBackgroundChange(Sender: TObject);
begin
  // check if a font attribute is assigned at all
  if not Assigned(FCurrentFontAttributes) then
    Exit;

  FCurrentFontAttributes.Background := ColorBoxBackground.Selected;
end;

procedure TFormPreferences.ColorBoxForegroundChange(Sender: TObject);
begin
  // check if a font attribute is assigned at all
  if not Assigned(FCurrentFontAttributes) then
    Exit;

  FCurrentFontAttributes.Foreground := ColorBoxForeground.Selected;
end;

procedure TFormPreferences.ColorBoxForegroundGetColors(Sender: TCustomColorBox;
  Items: TStrings);
begin
  Items.AddObject('clWebSnow', TObject(clWebSnow));
  Items.AddObject('clWebFloralWhite', TObject(clWebFloralWhite));
  Items.AddObject('clWebLavenderBlush', TObject(clWebLavenderBlush));
  Items.AddObject('clWebOldLace', TObject(clWebOldLace));
  Items.AddObject('clWebIvory', TObject(clWebIvory));
  Items.AddObject('clWebCornSilk', TObject(clWebCornSilk));
  Items.AddObject('clWebBeige', TObject(clWebBeige));
  Items.AddObject('clWebAntiqueWhite', TObject(clWebAntiqueWhite));
  Items.AddObject('clWebWheat', TObject(clWebWheat));
  Items.AddObject('clWebAliceBlue', TObject(clWebAliceBlue));
  Items.AddObject('clWebGhostWhite', TObject(clWebGhostWhite));
  Items.AddObject('clWebLavender', TObject(clWebLavender));
  Items.AddObject('clWebSeashell', TObject(clWebSeashell));
  Items.AddObject('clWebLightYellow', TObject(clWebLightYellow));
  Items.AddObject('clWebPapayaWhip', TObject(clWebPapayaWhip));
  Items.AddObject('clWebNavajoWhite', TObject(clWebNavajoWhite));
  Items.AddObject('clWebMoccasin', TObject(clWebMoccasin));
  Items.AddObject('clWebBurlywood', TObject(clWebBurlywood));
  Items.AddObject('clWebAzure', TObject(clWebAzure));
  Items.AddObject('clWebMintcream', TObject(clWebMintcream));
  Items.AddObject('clWebHoneydew', TObject(clWebHoneydew));
  Items.AddObject('clWebLinen', TObject(clWebLinen));
  Items.AddObject('clWebLemonChiffon', TObject(clWebLemonChiffon));
  Items.AddObject('clWebBlanchedAlmond', TObject(clWebBlanchedAlmond));
  Items.AddObject('clWebBisque', TObject(clWebBisque));
  Items.AddObject('clWebPeachPuff', TObject(clWebPeachPuff));
  Items.AddObject('clWebTan', TObject(clWebTan));
  Items.AddObject('clWebYellow', TObject(clWebYellow));
  Items.AddObject('clWebDarkOrange', TObject(clWebDarkOrange));
  Items.AddObject('clWebRed', TObject(clWebRed));
  Items.AddObject('clWebDarkRed', TObject(clWebDarkRed));
  Items.AddObject('clWebMaroon', TObject(clWebMaroon));
  Items.AddObject('clWebIndianRed', TObject(clWebIndianRed));
  Items.AddObject('clWebSalmon', TObject(clWebSalmon));
  Items.AddObject('clWebCoral', TObject(clWebCoral));
  Items.AddObject('clWebGold', TObject(clWebGold));
  Items.AddObject('clWebTomato', TObject(clWebTomato));
  Items.AddObject('clWebCrimson', TObject(clWebCrimson));
  Items.AddObject('clWebBrown', TObject(clWebBrown));
  Items.AddObject('clWebChocolate', TObject(clWebChocolate));
  Items.AddObject('clWebSandyBrown', TObject(clWebSandyBrown));
  Items.AddObject('clWebLightSalmon', TObject(clWebLightSalmon));
  Items.AddObject('clWebLightCoral', TObject(clWebLightCoral));
  Items.AddObject('clWebOrange', TObject(clWebOrange));
  Items.AddObject('clWebOrangeRed', TObject(clWebOrangeRed));
  Items.AddObject('clWebFirebrick', TObject(clWebFirebrick));
  Items.AddObject('clWebSaddleBrown', TObject(clWebSaddleBrown));
  Items.AddObject('clWebSienna', TObject(clWebSienna));
  Items.AddObject('clWebPeru', TObject(clWebPeru));
  Items.AddObject('clWebDarkSalmon', TObject(clWebDarkSalmon));
  Items.AddObject('clWebRosyBrown', TObject(clWebRosyBrown));
  Items.AddObject('clWebPaleGoldenrod', TObject(clWebPaleGoldenrod));
  Items.AddObject('clWebLightGoldenrodYellow', TObject(clWebLightGoldenrodYellow));
  Items.AddObject('clWebOlive', TObject(clWebOlive));
  Items.AddObject('clWebForestGreen', TObject(clWebForestGreen));
  Items.AddObject('clWebGreenYellow', TObject(clWebGreenYellow));
  Items.AddObject('clWebChartreuse', TObject(clWebChartreuse));
  Items.AddObject('clWebLightGreen', TObject(clWebLightGreen));
  Items.AddObject('clWebAquamarine', TObject(clWebAquamarine));
  Items.AddObject('clWebSeaGreen', TObject(clWebSeaGreen));
  Items.AddObject('clWebGoldenRod', TObject(clWebGoldenRod));
  Items.AddObject('clWebKhaki', TObject(clWebKhaki));
  Items.AddObject('clWebOliveDrab', TObject(clWebOliveDrab));
  Items.AddObject('clWebGreen', TObject(clWebGreen));
  Items.AddObject('clWebYellowGreen', TObject(clWebYellowGreen));
  Items.AddObject('clWebLawnGreen', TObject(clWebLawnGreen));
  Items.AddObject('clWebPaleGreen', TObject(clWebPaleGreen));
  Items.AddObject('clWebMediumAquamarine', TObject(clWebMediumAquamarine));
  Items.AddObject('clWebMediumSeaGreen', TObject(clWebMediumSeaGreen));
  Items.AddObject('clWebDarkGoldenRod', TObject(clWebDarkGoldenRod));
  Items.AddObject('clWebDarkKhaki', TObject(clWebDarkKhaki));
  Items.AddObject('clWebDarkOliveGreen', TObject(clWebDarkOliveGreen));
  Items.AddObject('clWebDarkgreen', TObject(clWebDarkgreen));
  Items.AddObject('clWebLimeGreen', TObject(clWebLimeGreen));
  Items.AddObject('clWebLime', TObject(clWebLime));
  Items.AddObject('clWebSpringGreen', TObject(clWebSpringGreen));
  Items.AddObject('clWebMediumSpringGreen', TObject(clWebMediumSpringGreen));
  Items.AddObject('clWebDarkSeaGreen', TObject(clWebDarkSeaGreen));
  Items.AddObject('clWebLightSeaGreen', TObject(clWebLightSeaGreen));
  Items.AddObject('clWebPaleTurquoise', TObject(clWebPaleTurquoise));
  Items.AddObject('clWebLightCyan', TObject(clWebLightCyan));
  Items.AddObject('clWebLightBlue', TObject(clWebLightBlue));
  Items.AddObject('clWebLightSkyBlue', TObject(clWebLightSkyBlue));
  Items.AddObject('clWebCornFlowerBlue', TObject(clWebCornFlowerBlue));
  Items.AddObject('clWebDarkBlue', TObject(clWebDarkBlue));
  Items.AddObject('clWebIndigo', TObject(clWebIndigo));
  Items.AddObject('clWebMediumTurquoise', TObject(clWebMediumTurquoise));
  Items.AddObject('clWebTurquoise', TObject(clWebTurquoise));
  Items.AddObject('clWebCyan', TObject(clWebCyan));
  Items.AddObject('clWebAqua', TObject(clWebAqua));
  Items.AddObject('clWebPowderBlue', TObject(clWebPowderBlue));
  Items.AddObject('clWebSkyBlue', TObject(clWebSkyBlue));
  Items.AddObject('clWebRoyalBlue', TObject(clWebRoyalBlue));
  Items.AddObject('clWebMediumBlue', TObject(clWebMediumBlue));
  Items.AddObject('clWebMidnightBlue', TObject(clWebMidnightBlue));
  Items.AddObject('clWebDarkTurquoise', TObject(clWebDarkTurquoise));
  Items.AddObject('clWebCadetBlue', TObject(clWebCadetBlue));
  Items.AddObject('clWebDarkCyan', TObject(clWebDarkCyan));
  Items.AddObject('clWebTeal', TObject(clWebTeal));
  Items.AddObject('clWebDeepskyBlue', TObject(clWebDeepskyBlue));
  Items.AddObject('clWebDodgerBlue', TObject(clWebDodgerBlue));
  Items.AddObject('clWebBlue', TObject(clWebBlue));
  Items.AddObject('clWebNavy', TObject(clWebNavy));
  Items.AddObject('clWebDarkViolet', TObject(clWebDarkViolet));
  Items.AddObject('clWebDarkOrchid', TObject(clWebDarkOrchid));
  Items.AddObject('clWebMagenta', TObject(clWebMagenta));
  Items.AddObject('clWebFuchsia', TObject(clWebFuchsia));
  Items.AddObject('clWebDarkMagenta', TObject(clWebDarkMagenta));
  Items.AddObject('clWebMediumVioletRed', TObject(clWebMediumVioletRed));
  Items.AddObject('clWebPaleVioletRed', TObject(clWebPaleVioletRed));
  Items.AddObject('clWebBlueViolet', TObject(clWebBlueViolet));
  Items.AddObject('clWebMediumOrchid', TObject(clWebMediumOrchid));
  Items.AddObject('clWebMediumPurple', TObject(clWebMediumPurple));
  Items.AddObject('clWebPurple', TObject(clWebPurple));
  Items.AddObject('clWebDeepPink', TObject(clWebDeepPink));
  Items.AddObject('clWebLightPink', TObject(clWebLightPink));
  Items.AddObject('clWebViolet', TObject(clWebViolet));
  Items.AddObject('clWebOrchid', TObject(clWebOrchid));
  Items.AddObject('clWebPlum', TObject(clWebPlum));
  Items.AddObject('clWebThistle', TObject(clWebThistle));
  Items.AddObject('clWebHotPink', TObject(clWebHotPink));
  Items.AddObject('clWebPink', TObject(clWebPink));
  Items.AddObject('clWebLightSteelBlue', TObject(clWebLightSteelBlue));
  Items.AddObject('clWebMediumSlateBlue', TObject(clWebMediumSlateBlue));
  Items.AddObject('clWebLightSlateGray', TObject(clWebLightSlateGray));
  Items.AddObject('clWebWhite', TObject(clWebWhite));
  Items.AddObject('clWebLightgrey', TObject(clWebLightgrey));
  Items.AddObject('clWebGray', TObject(clWebGray));
  Items.AddObject('clWebSteelBlue', TObject(clWebSteelBlue));
  Items.AddObject('clWebSlateBlue', TObject(clWebSlateBlue));
  Items.AddObject('clWebSlateGray', TObject(clWebSlateGray));
  Items.AddObject('clWebWhiteSmoke', TObject(clWebWhiteSmoke));
  Items.AddObject('clWebSilver', TObject(clWebSilver));
  Items.AddObject('clWebDimGray', TObject(clWebDimGray));
  Items.AddObject('clWebMistyRose', TObject(clWebMistyRose));
  Items.AddObject('clWebDarkSlateBlue', TObject(clWebDarkSlateBlue));
  Items.AddObject('clWebDarkSlategray', TObject(clWebDarkSlategray));
  Items.AddObject('clWebGainsboro', TObject(clWebGainsboro));
  Items.AddObject('clWebDarkGray', TObject(clWebDarkGray));
  Items.AddObject('clWebBlack', TObject(clWebBlack));
end;

procedure TFormPreferences.ComboBoxElementChange(Sender: TObject);
begin
  // check if an element has been selected
  GroupBoxSettings.Visible := ComboBoxElement.ItemIndex >= 0;
  if ComboBoxElement.ItemIndex < 0 then
    Exit;

  if ComboBoxElement.ItemIndex < FEditorAttributeCount then
    FCurrentFontAttributes := EditorPreview.Highlighter.Attribute[ComboBoxElement.ItemIndex]
  else
    case ComboBoxElement.ItemIndex - FEditorAttributeCount of
      0:
        FCurrentFontAttributes := FHint;
      1:
        FCurrentFontAttributes := FWarning;
      2:
        FCurrentFontAttributes := FError;
      3:
        FCurrentFontAttributes := FLink;
      4:
        FCurrentFontAttributes := FMarker;
    end;

  // check if a font attribute has been assigned
  if not Assigned(FCurrentFontAttributes) then
    Exit;

  ColorBoxForeground.Selected := FCurrentFontAttributes.Foreground;
  ColorBoxBackground.Selected := FCurrentFontAttributes.Background;
  CheckBoxBold.Checked := (fsBold in FCurrentFontAttributes.Style);
  CheckBoxItalic.Checked := (fsItalic in FCurrentFontAttributes.Style);
  CheckBoxUnderlined.Checked := (fsUnderline in FCurrentFontAttributes.Style);
end;

procedure TFormPreferences.ComboBoxLanguageChange(Sender: TObject);
begin
  case TComboBox(Sender).ItemIndex of
    0:
      HighlightDWS;
    1:
      HighlightJS;
    2:
      HighlightJSON;
    3:
      HighlightHTML;
    4:
      HighlightCSS;
  end;

  UpdateElements;
end;

procedure TFormPreferences.EditorPreviewClick(Sender: TObject);
begin
  EditorPreviewCaretPositionChanged;
end;

procedure TFormPreferences.EditorPreviewCommandProcessed(Sender: TObject;
  var Command: TSynEditorCommand; var AChar: Char; Data: Pointer);
begin
  if Command in [ecLeft..ecGotoXY] then
    EditorPreviewCaretPositionChanged;
end;

procedure TFormPreferences.EditorPreviewGutterPaint(Sender: TObject; aLine, X,
  Y: Integer);
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

procedure TFormPreferences.EditorPreviewCaretPositionChanged;
var
  Token: string;
  Attribute: TSynHighlighterAttributes;
begin
  if EditorPreview.GetHighlighterAttriAtRowCol(EditorPreview.CaretXY, Token,
    Attribute) and Assigned(Attribute) then
    ComboBoxElement.ItemIndex :=
      ComboBoxElement.Items.IndexOf(Attribute.FriendlyName)
  else
  if EditorPreview.CaretY = FHighlightLine[hlHint] then
    ComboBoxElement.ItemIndex := FEditorAttributeCount + 0
  else
  if EditorPreview.CaretY = FHighlightLine[hlWarning] then
    ComboBoxElement.ItemIndex := FEditorAttributeCount + 1
  else
  if EditorPreview.CaretY = FHighlightLine[hlError] then
    ComboBoxElement.ItemIndex := FEditorAttributeCount + 2;

  ComboBoxElementChange(nil);
end;

procedure TFormPreferences.EditorPreviewChange(Sender: TObject);
begin
  EditorPreviewCaretPositionChanged;
end;

procedure TFormPreferences.EditorPreviewSpecialLineColors(Sender: TObject;
  Line: Integer; var Special: Boolean; var FG, BG: TColor);
var
  Index: THighlightLine;
  HighlighterAttributes: TSynHighlighterAttributes;
begin
  Special := False;
  HighlighterAttributes := nil;
  for Index := Low(FHighlightLine) to High(FHighlightLine) do
    if Line = FHighlightLine[Index] then
    begin
      case Index of
        hlHint:
          HighlighterAttributes := FHint;
        hlWarning:
          HighlighterAttributes := FWarning;
        hlError:
          HighlighterAttributes := FError;
      end;
    end;

  // eventually highlight attributes
  if not Assigned(HighlighterAttributes) then
    Exit;

  if HighlighterAttributes.Foreground <> clNone then
  begin
    FG := HighlighterAttributes.Foreground;
    Special := True;
  end;
  if HighlighterAttributes.Background <> clNone then
  begin
    BG := HighlighterAttributes.Background;
    Special := True;
  end
end;

procedure TFormPreferences.ActionClearExecute(Sender: TObject);
begin
  TreeItems.BeginUpdate;
  try
    TreeItems.Clear;
  finally
    TreeItems.EndUpdate;
  end;
end;

procedure TFormPreferences.ActionDeleteExecute(Sender: TObject);
var
  Node: PVirtualNode;
begin
  for Node in TreeItems.SelectedNodes do
    TreeItems.DeleteNode(Node);
end;

procedure TFormPreferences.UpdateHistoryItems;
var
  Index: Integer;
  NodeItem: PVirtualNode;
  NodeData: PHistoryItem;
begin
  TreeItems.BeginUpdate;
  try
    TreeItems.Clear;

    FProjectsNode := TreeItems.AddChild(TreeItems.RootNode);
    NodeData := TreeItems.GetNodeData(FProjectsNode);
    NodeData^.FileName := 'Projects';
    for Index := 0 to DataModuleCommon.History.ProjectsHistory.Count - 1 do
    begin
      NodeItem := TreeItems.AddChild(FProjectsNode);
      NodeData := TreeItems.GetNodeData(NodeItem);
      NodeData^.FileName := DataModuleCommon.History.ProjectsHistory[Index];
    end;
    TreeItems.Expanded[FProjectsNode] := True;

    FUnitsNode := TreeItems.AddChild(TreeItems.RootNode);
    NodeData := TreeItems.GetNodeData(FUnitsNode);
    NodeData^.FileName := 'Units';
    for Index := 0 to DataModuleCommon.History.UnitsHistory.Count - 1 do
    begin
      NodeItem := TreeItems.AddChild(FUnitsNode);
      NodeData := TreeItems.GetNodeData(NodeItem);
      NodeData^.FileName := DataModuleCommon.History.UnitsHistory[Index];
    end;
    TreeItems.Expanded[FUnitsNode] := True;
  finally
    TreeItems.EndUpdate;
  end;
end;

procedure TFormPreferences.ActionLoadExecute(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
  try
    DefaultExt := '.highlighter.json';
    Filter := 'Highlighters JSON (*.json)|*.highlighter.json';
    if Execute then
      SaveHighlightersToFile(FileName);
  finally
    Free;
  end;
end;

procedure TFormPreferences.ActionSaveExecute(Sender: TObject);
begin
  with TSaveDialog.Create(Self) do
  try
    DefaultExt := '.highlighter.json';
    Filter := 'Highlighters JSON (*.json)|*.highlighter.json';
    if Execute then
      LoadHighlightersFromFile(FileName)
  finally
    Free;
  end;
end;

procedure TFormPreferences.LoadHighlightersFromFile(FileName: TFileName);
var
  Highlighter: THopePreferencesHighlighter;
begin
  Highlighter := THopePreferencesHighlighter.Create;
  try
    Highlighter.LoadFromFile(FileName);
    LoadHighlighters(Highlighter);
  finally
    Highlighter.Free;
  end;
end;

procedure TFormPreferences.SaveHighlightersToFile(FileName: TFileName);
var
  Highlighter: THopePreferencesHighlighter;
begin
  Highlighter := THopePreferencesHighlighter.Create;
  try
    SaveHighlighters(Highlighter);
    Highlighter.SaveToFile(FileName);
  finally
    Highlighter.Free;
  end;
end;

procedure TFormPreferences.HighlightCSS;
begin
  EditorPreview.Highlighter := SynMultiCSS;
  EditorPreview.Lines.Text := EditorPreview.Highlighter.SampleSource;
end;

procedure TFormPreferences.HighlightDWS;
begin
  EditorPreview.Highlighter := SynPascal;

  EditorPreview.Lines.Text :=
    '{$DEFINE FOO}' + #10 +
    'function Foo(Bar: Integer): Float;' + #10 +
    'var Index: Integer; // Hint: unused variable' + #10 +
    'begin' + #10 +
    '  // some bogus calculations' + #10 +
    '  asm @Bar += 4 end;' + #10 +
    '  Result := Sqrt(Bar + 1.2) - Bar + 3 + $A;' + #10#10 +
    '  PrintLn(''Calculation:'' + #10 + ''Done!'')' + #10 +
    '  Exit;' + #10 +
    '  PrintLn(''Warning: Unreachable line!'');' + #10 +
    '  Error: Invalid Code!' + #10 +
    'end;';

  FHighlightLine[hlHint] := 2;
  FHighlightLine[hlWarning] := 10;
  FHighlightLine[hlError] := 11;
end;

procedure TFormPreferences.HighlightHTML;
begin
  EditorPreview.Highlighter := SynMultiHTML;

  EditorPreview.Lines.Text :=
    '<!DOCTYPE html>' + #10 +
    '<html lang="en">' + #10 +
    '  <head>' + #10 +
    '    <meta charset="utf-8">' + #10 +
    '    <title>title</title>' + #10 +
    '    <link rel="stylesheet" href="style.css">' + #10 +
    '    <script src="script.js"></script>' + #10 +
    '  </head>' + #10 +
    '  <body>' + #10 +
    '    <!-- page content -->' + #10 +
    '  </body>' + #10 +
    '</html>';
end;

procedure TFormPreferences.HighlightJS;
begin
  EditorPreview.Highlighter := SynJS;

  EditorPreview.Lines.Text := EditorPreview.Highlighter.SampleSource;
end;

procedure TFormPreferences.HighlightJSON;
begin
  EditorPreview.Highlighter := SynJSON;

  EditorPreview.Lines.Text := EditorPreview.Highlighter.SampleSource;
end;

function DelayToTrackbar(Value: Integer): Integer;
begin
  if Value <= 100 then
    Result := Value div 10
  else if Value <= 1000 then
    Result := 9 + (Value div 100)
  else
    Result := 17 + (Value div 500);
end;

function TrackBarToDelay(Value: Integer): Integer;
begin
  if Value < 10 then
    Result := 10 * Value
  else if Value < 20 then
    Result := 100 + 100 * (Value - 10)
  else
    Result := 1500 + 500 * (Value - 20);
end;

procedure TFormPreferences.TrackBarDelayChange(Sender: TObject);
begin
  if TrackBarDelay.Position = 0 then
    LabelValue.Caption := 'Invoked immediately'
  else
  if TrackBarDelay.Position = TrackBarDelay.Max then
    LabelValue.Caption := 'Never invoked automatically'
  else
    LabelValue.Caption := IntToStr(TrackBarToDelay(TrackBarDelay.Position)) + 'ms';
end;

procedure TFormPreferences.TreeCategoryChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  NodeData: PTabSheetItem;
begin
  if Assigned(Node) then
  begin
    NodeData := Sender.GetNodeData(Node);
    PageControl.ActivePage := NodeData^.TabSheet;
  end;
end;

procedure TFormPreferences.TreeCategoryGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  NodeData: PTabSheetItem;
begin
  if Kind in [ikNormal, ikSelected] then
  begin
    NodeData := Sender.GetNodeData(Node);
    ImageIndex := NodeData^.TabSheet.ImageIndex;
  end;
end;

procedure TFormPreferences.TreeCategoryGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeData: PTabSheetItem;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData^.TabSheet.Caption;
end;

procedure TFormPreferences.TreeCategoryIncrementalSearch(
  Sender: TBaseVirtualTree; Node: PVirtualNode; const SearchText: string;
  var Result: Integer);
var
  NodeData: PTabSheetItem;
  S: array [0 .. 1] of string;
begin
  NodeData := Sender.GetNodeData(Node);
  S[0] := LowerCase(SearchText);
  S[1] := LowerCase(NodeData^.TabSheet.Caption);

  Result := StrLIComp(PChar(S[0]), PChar(S[1]), Min(Length(S[0]), Length(S[1])));
end;

procedure TFormPreferences.TreeItemsCollapsing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var Allowed: Boolean);
begin
  Allowed := False;
end;

procedure TFormPreferences.TreeItemsDrawText(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
var
  NodeData: PHistoryItem;
const
  CColors: array [Boolean] of TColor = (clGrayText, clWindowText);
begin
  NodeData := Sender.GetNodeData(Node);
  if (Node.Parent = FProjectsNode) or (Node.Parent = FUnitsNode) then
  begin
    TargetCanvas.Font.Color := CColors[FileExists(NodeData^.FileName)];
    if Sender.Selected[Node] then
      TargetCanvas.Font.Color := clHighlightText;
  end
  else
    TargetCanvas.Font.Style := [fsBold];
end;

procedure TFormPreferences.TreeItemsFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  NodeData: PHistoryItem;
begin
  NodeData := Sender.GetNodeData(Node);
  Finalize(NodeData^.FileName);
end;

procedure TFormPreferences.TreeItemsGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeData: PHistoryItem;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData^.FileName;
end;

procedure TFormPreferences.UpdateElements;
var
  Index: Integer;
begin
  ComboBoxElement.Clear;
  for Index := 0 to EditorPreview.Highlighter.AttrCount - 1 do
    ComboBoxElement.Items.Add(EditorPreview.Highlighter.Attribute[Index].FriendlyName);
  FEditorAttributeCount := ComboBoxElement.Items.Count;
  ComboBoxElement.Items.Add(FHint.FriendlyName);
  ComboBoxElement.Items.Add(FWarning.FriendlyName);
  ComboBoxElement.Items.Add(FError.FriendlyName);
  ComboBoxElement.Items.Add(FLink.FriendlyName);
  ComboBoxElement.Items.Add(FMarker.FriendlyName);
end;

procedure TFormPreferences.UpdateTree;

  function Add(TabSheet: TTabSheet; Parent: PVirtualNode = nil): PVirtualNode;
  var
    NodeData: PTabSheetItem;
  begin
    if Parent = nil then
      Parent := TreeCategory.RootNode;
    Result := TreeCategory.AddChild(Parent);
    NodeData := TreeCategory.GetNodeData(Result);
    NodeData^.TabSheet := TabSheet;
  end;

var
  ParentNode: PVirtualNode;
  Index: Integer;
begin
  TreeCategory.BeginUpdate;
  try
    TreeCategory.Clear;

    ParentNode := Add(TabSheetEnvironment);
    Add(TabSheetRecentFiles, ParentNode);
    Add(TabSheetLibraryPaths, ParentNode);
    Add(TabSheetDeployment, ParentNode);
    Add(TabSheetDesigner, ParentNode);
    TreeCategory.Expanded[ParentNode] := True;

    ParentNode := Add(TabSheetEditorOptions);
    Add(TabSheetHighlighterOptions, ParentNode);
    Add(TabSheetCodeInsight, ParentNode);
    TreeCategory.Expanded[ParentNode] := True;
  finally
    TreeCategory.EndUpdate;
  end;

  // disable tabs
  for Index := 0 to PageControl.PageCount - 1 do
    PageControl.Pages[Index].TabVisible := False;
end;

procedure LoadHighlighterAttributes(
  Source: THopePreferencesFontAttributes;
  Dest: TSynHighlighterAttributes);
begin
  Dest.Background := Source.Background;
  Dest.Foreground := Source.Foreground;
  Dest.Style := Source.Style;
end;

procedure SaveHighlighterAttributes(
  Source: TSynHighlighterAttributes;
  Dest: THopePreferencesFontAttributes);
begin
  Dest.Background := Source.Background;
  Dest.Foreground := Source.Foreground;
  Dest.Style := Source.Style;
end;

procedure TFormPreferences.LoadHighlighters(
  Highlighter: THopePreferencesHighlighter);
begin
  LoadHighlighterAttributes(Highlighter.LinkAttributes, FLink);
  LoadHighlighterAttributes(Highlighter.HintAttributes, FHint);
  LoadHighlighterAttributes(Highlighter.WarningAttributes, FWarning);
  LoadHighlighterAttributes(Highlighter.ErrorAttributes, FError);

  with Highlighter.HighlighterPascal do
  begin
    LoadHighlighterAttributes(AsmAttributes, SynDWS.AsmAttri);
    LoadHighlighterAttributes(CharAttributes, SynDWS.CharAttri);
    LoadHighlighterAttributes(CommentAttributes, SynDWS.CommentAttri);
    LoadHighlighterAttributes(DirectiveAttributes, SynDWS.DirectiveAttri);
    LoadHighlighterAttributes(FloatAttributes, SynDWS.FloatAttri);
    LoadHighlighterAttributes(HexAttributes, SynDWS.HexAttri);
    LoadHighlighterAttributes(IdentifierAttributes, SynDWS.IdentifierAttri);
    LoadHighlighterAttributes(KeywordAttributes, SynDWS.KeyAttri);
    LoadHighlighterAttributes(NumberAttributes, SynDWS.NumberAttri);
    LoadHighlighterAttributes(SpaceAttributes, SynDWS.SpaceAttri);
    LoadHighlighterAttributes(StringAttributes, SynDWS.StringAttri);
    LoadHighlighterAttributes(SymbolAttributes, SynDWS.SymbolAttri);
  end;

  with Highlighter.HighlighterJS do
  begin
    LoadHighlighterAttributes(CommentAttributes, SynJS.CommentAttri);
    LoadHighlighterAttributes(EventAttributes, SynJS.CommentAttri);
    LoadHighlighterAttributes(IdentifierAttributes, SynJS.IdentifierAttri);
    LoadHighlighterAttributes(KeywordAttributes, SynJS.KeyAttri);
    LoadHighlighterAttributes(NonReservedKeywordAttributes, SynJS.NonReservedKeyAttri);
    LoadHighlighterAttributes(NumberAttributes, SynJS.NumberAttri);
    LoadHighlighterAttributes(SpaceAttributes, SynJS.SpaceAttri);
    LoadHighlighterAttributes(StringAttributes, SynJS.StringAttri);
    LoadHighlighterAttributes(SymbolAttributes, SynJS.SymbolAttri);
  end;

  with Highlighter.HighlighterJSON do
  begin
    LoadHighlighterAttributes(AttributeAttributes, SynJSON.AttributeAttri);
    LoadHighlighterAttributes(ReservedAttributes, SynJSON.ReservedAttri);
    LoadHighlighterAttributes(NumberAttributes, SynJSON.NumberAttri);
    LoadHighlighterAttributes(ValueAttributes, SynJSON.ValueAttri);
    LoadHighlighterAttributes(SpaceAttributes, SynJSON.SpaceAttri);
    LoadHighlighterAttributes(SymbolAttributes, SynJSON.SymbolAttri);
  end;

  with Highlighter.HighlighterHTML do
  begin
    LoadHighlighterAttributes(AndAttributes, SynHTML.AndAttri);
    LoadHighlighterAttributes(SpaceAttributes, SynHTML.CommentAttri);
    LoadHighlighterAttributes(IdentifierAttributes, SynHTML.IdentifierAttri);
    LoadHighlighterAttributes(KeywordAttributes, SynHTML.KeyAttri);
    LoadHighlighterAttributes(SpaceAttributes, SynHTML.SpaceAttri);
    LoadHighlighterAttributes(SymbolAttributes, SynHTML.SymbolAttri);
    LoadHighlighterAttributes(TextAttributes, SynHTML.TextAttri);
    LoadHighlighterAttributes(UndefinedKeyAttributes, SynHTML.UndefKeyAttri);
    LoadHighlighterAttributes(ValueAttributes, SynHTML.ValueAttri);
  end;

  with Highlighter.HighlighterCSS do
  begin
    LoadHighlighterAttributes(AtRuleAttributes, SynCSS.AtRuleAttri);
    LoadHighlighterAttributes(ColorAttributes, SynCSS.ColorAttri);
    LoadHighlighterAttributes(CommentAttributes, SynCSS.CommentAttri);
    LoadHighlighterAttributes(NumberAttributes, SynCSS.NumberAttri);
    LoadHighlighterAttributes(PropertyAttributes, SynCSS.PropertyAttri);
    LoadHighlighterAttributes(SelectorAttributes, SynCSS.SelectorAttri);
    LoadHighlighterAttributes(SpaceAttributes, SynCSS.SpaceAttri);
    LoadHighlighterAttributes(StringAttributes, SynCSS.StringAttri);
    LoadHighlighterAttributes(SymbolAttributes, SynCSS.SymbolAttri);
    LoadHighlighterAttributes(TextAttributes, SynCSS.TextAttri);
    LoadHighlighterAttributes(UndefPropertyAttributes, SynCSS.UndefPropertyAttri);
    LoadHighlighterAttributes(ValueAttributes, SynCSS.ValueAttri);
  end;
end;

procedure TFormPreferences.SaveHighlighters(Highlighter: THopePreferencesHighlighter);
begin
  SaveHighlighterAttributes(FLink, Highlighter.LinkAttributes);
  SaveHighlighterAttributes(FHint, Highlighter.HintAttributes);
  SaveHighlighterAttributes(FWarning, Highlighter.WarningAttributes);
  SaveHighlighterAttributes(FError, Highlighter.ErrorAttributes);

  with Highlighter.HighlighterPascal do
  begin
    SaveHighlighterAttributes(SynDWS.AsmAttri, AsmAttributes);
    SaveHighlighterAttributes(SynDWS.CharAttri, CharAttributes);
    SaveHighlighterAttributes(SynDWS.CommentAttri, CommentAttributes);
    SaveHighlighterAttributes(SynDWS.DirectiveAttri, DirectiveAttributes);
    SaveHighlighterAttributes(SynDWS.FloatAttri, FloatAttributes);
    SaveHighlighterAttributes(SynDWS.HexAttri, HexAttributes);
    SaveHighlighterAttributes(SynDWS.IdentifierAttri, IdentifierAttributes);
    SaveHighlighterAttributes(SynDWS.KeyAttri, KeywordAttributes);
    SaveHighlighterAttributes(SynDWS.NumberAttri, NumberAttributes);
    SaveHighlighterAttributes(SynDWS.SpaceAttri, SpaceAttributes);
    SaveHighlighterAttributes(SynDWS.StringAttri, StringAttributes);
    SaveHighlighterAttributes(SynDWS.SymbolAttri, SymbolAttributes);
  end;

  with Highlighter.HighlighterJS do
  begin
    SaveHighlighterAttributes(SynJS.CommentAttri, CommentAttributes);
    SaveHighlighterAttributes(SynJS.CommentAttri, EventAttributes);
    SaveHighlighterAttributes(SynJS.IdentifierAttri, IdentifierAttributes);
    SaveHighlighterAttributes(SynJS.KeyAttri, KeywordAttributes);
    SaveHighlighterAttributes(SynJS.NonReservedKeyAttri, NonReservedKeywordAttributes);
    SaveHighlighterAttributes(SynJS.NumberAttri, NumberAttributes);
    SaveHighlighterAttributes(SynJS.SpaceAttri, SpaceAttributes);
    SaveHighlighterAttributes(SynJS.StringAttri, StringAttributes);
    SaveHighlighterAttributes(SynJS.SymbolAttri, SymbolAttributes);
  end;

  with Highlighter.HighlighterJSON do
  begin
    SaveHighlighterAttributes(SynJSON.AttributeAttri, AttributeAttributes);
    SaveHighlighterAttributes(SynJSON.ReservedAttri, ReservedAttributes);
    SaveHighlighterAttributes(SynJSON.NumberAttri, NumberAttributes);
    SaveHighlighterAttributes(SynJSON.ValueAttri, ValueAttributes);
    SaveHighlighterAttributes(SynJSON.SpaceAttri, SpaceAttributes);
    SaveHighlighterAttributes(SynJSON.SymbolAttri, SymbolAttributes);
  end;

  with Highlighter.HighlighterHTML do
  begin
    SaveHighlighterAttributes(SynHTML.AndAttri, AndAttributes);
    SaveHighlighterAttributes(SynHTML.CommentAttri, SpaceAttributes);
    SaveHighlighterAttributes(SynHTML.IdentifierAttri, IdentifierAttributes);
    SaveHighlighterAttributes(SynHTML.KeyAttri, KeywordAttributes);
    SaveHighlighterAttributes(SynHTML.SpaceAttri, SpaceAttributes);
    SaveHighlighterAttributes(SynHTML.SymbolAttri, SymbolAttributes);
    SaveHighlighterAttributes(SynHTML.TextAttri, TextAttributes);
    SaveHighlighterAttributes(SynHTML.UndefKeyAttri, UndefinedKeyAttributes);
    SaveHighlighterAttributes(SynHTML.ValueAttri, ValueAttributes);
  end;

  with Highlighter.HighlighterCSS do
  begin
    SaveHighlighterAttributes(SynCSS.AtRuleAttri, AtRuleAttributes);
    SaveHighlighterAttributes(SynCSS.ColorAttri, ColorAttributes);
    SaveHighlighterAttributes(SynCSS.CommentAttri, CommentAttributes);
    SaveHighlighterAttributes(SynCSS.NumberAttri, NumberAttributes);
    SaveHighlighterAttributes(SynCSS.PropertyAttri, PropertyAttributes);
    SaveHighlighterAttributes(SynCSS.SelectorAttri, SelectorAttributes);
    SaveHighlighterAttributes(SynCSS.SpaceAttri, SpaceAttributes);
    SaveHighlighterAttributes(SynCSS.StringAttri, StringAttributes);
    SaveHighlighterAttributes(SynCSS.SymbolAttri, SymbolAttributes);
    SaveHighlighterAttributes(SynCSS.TextAttri, TextAttributes);
    SaveHighlighterAttributes(SynCSS.UndefPropertyAttri, UndefPropertyAttributes);
    SaveHighlighterAttributes(SynCSS.ValueAttri, ValueAttributes);
  end;
end;

procedure TFormPreferences.Load;
var
  Preferences: THopePreferences;
begin
  Preferences := DataModuleCommon.Preferences;

  ComboBoxProjectPath.Text := Preferences.Environment.DefaultProjectPath;

  CheckBoxAltSetsColumnMode.Checked := Preferences.Editor.AltSetsColumnMode;
  CheckBoxAutoIndent.Checked := Preferences.Editor.AutoIndent;
  CheckBoxAutoSizeMaxWidth.Checked := Preferences.Editor.AutoSizeMaxScrollWidth;
  CheckBoxDisableScrollArrows.Checked := Preferences.Editor.DisableScrollArrows;
  CheckBoxDragAndDropEditing.Checked := Preferences.Editor.DragDropEditing;
//  CheckBoxDropFiles.Checked := Preferences.Editor.DropFiles;
  CheckBoxEnhanceHomeKey.Checked := Preferences.Editor.EnhanceHomeKey;
  CheckBoxEnhanceEndKey.Checked := Preferences.Editor.EnhanceEndKey;
  CheckBoxGroupUndo.Checked := Preferences.Editor.GroupUndo;
  CheckBoxHalfPageScroll.Checked := Preferences.Editor.HalfPageScroll;
  CheckBoxHideShowScrollbars.Checked := Preferences.Editor.HideShowScrollbars;
  CheckBoxKeepCaretX.Checked := Preferences.Editor.KeepCaretX;
//  CheckBoxNoCaret.Checked := Preferences.Editor.NoCaret;
//  CheckBoxNoSelection.Checked := Preferences.Editor.NoSelection;
  CheckBoxRightMouseMoves.Checked := Preferences.Editor.RightMouseMovesCursor;
  CheckBoxScrollByOneLess.Checked := Preferences.Editor.ScrollByOneLess;
  CheckBoxScrollHintFollows.Checked := Preferences.Editor.ScrollHintFollows;
  CheckBoxScrollPastEof.Checked := Preferences.Editor.ScrollPastEof;
  CheckBoxScrollPastEol.Checked := Preferences.Editor.ScrollPastEol;
  CheckBoxShowScrollHint.Checked := Preferences.Editor.ShowScrollHint;
  CheckBoxShowSpecialChars.Checked := Preferences.Editor.ShowSpecialChars;
  CheckBoxSmartTabDelete.Checked := Preferences.Editor.SmartTabDelete;
  CheckBoxSmartTabs.Checked := Preferences.Editor.SmartTabs;
//  CheckBoxSpecialLineDefaultFg.Checked := Preferences.Editor.SpecialLineDefaultFg;
  CheckBoxTabIndent.Checked := Preferences.Editor.TabIndent;
  CheckBoxTabsToSpaces.Checked := Preferences.Editor.TabsToSpaces;
  CheckBoxTrimTrailingSpaces.Checked := Preferences.Editor.TrimTrailingSpace;

  CheckBoxCodeSuggestions.Checked := Preferences.CodeInsight.CodeSuggestions.Enabled;
  CheckBoxAutoParenthesis.Checked := Preferences.CodeInsight.CodeSuggestions.AutoParenthesis;
  CheckBoxShowReservedWords.Checked := Preferences.CodeInsight.CodeSuggestions.ShowReservedWords;
  CheckBoxCodeParameters.Checked := Preferences.CodeInsight.CodeParametes;
  CheckBoxTooltipSymbol.Checked := Preferences.CodeInsight.TooltipSymbolInsight;
  CheckBoxBlockCompletion.Checked := Preferences.CodeInsight.BlockCompletion;
  CheckBoxErrorInsight.Checked := Preferences.CodeInsight.ErrorInsight;
  TrackBarDelay.Position := DelayToTrackbar(Preferences.CodeInsight.Delay);
  CheckBoxCodeTemplateCompletion.Checked := Preferences.CodeInsight.CodeTemplateCompletion;

  SpinEditIndent.Value := Preferences.Formating.Indention;

  ColorBoxConflicted.Color := Preferences.Versioning.Colors.Conflicted;
  ColorBoxAdded.Color := Preferences.Versioning.Colors.Added;

  LoadHighlighters(Preferences.Highlighter);
end;

procedure TFormPreferences.Save;
var
  Preferences: THopePreferences;
begin
  Preferences := DataModuleCommon.Preferences;

  Preferences.Environment.DefaultProjectPath := ComboBoxProjectPath.Text;

  Preferences.Editor.AltSetsColumnMode := CheckBoxAltSetsColumnMode.Checked;
  Preferences.Editor.AutoIndent := CheckBoxAutoIndent.Checked;
  Preferences.Editor.AutoSizeMaxScrollWidth := CheckBoxAutoSizeMaxWidth.Checked;
  Preferences.Editor.DisableScrollArrows := CheckBoxDisableScrollArrows.Checked;
  Preferences.Editor.DragDropEditing := CheckBoxDragAndDropEditing.Checked;
//  Preferences.Editor.DropFiles := CheckBoxDropFiles.Checked;
  Preferences.Editor.EnhanceHomeKey := CheckBoxEnhanceHomeKey.Checked;
  Preferences.Editor.EnhanceEndKey := CheckBoxEnhanceEndKey.Checked;
  Preferences.Editor.GroupUndo := CheckBoxGroupUndo.Checked;
  Preferences.Editor.HalfPageScroll := CheckBoxHalfPageScroll.Checked;
  Preferences.Editor.HideShowScrollbars := CheckBoxHideShowScrollbars.Checked;
  Preferences.Editor.KeepCaretX := CheckBoxKeepCaretX.Checked;
//  Preferences.Editor.NoCaret := CheckBoxNoCaret.Checked;
//  Preferences.Editor.NoSelection := CheckBoxNoSelection.Checked;
  Preferences.Editor.RightMouseMovesCursor := CheckBoxRightMouseMoves.Checked;
  Preferences.Editor.ScrollByOneLess := CheckBoxScrollByOneLess.Checked;
  Preferences.Editor.ScrollHintFollows := CheckBoxScrollHintFollows.Checked;
  Preferences.Editor.ScrollPastEof := CheckBoxScrollPastEof.Checked;
  Preferences.Editor.ScrollPastEol := CheckBoxScrollPastEol.Checked;
  Preferences.Editor.ShowScrollHint := CheckBoxShowScrollHint.Checked;
  Preferences.Editor.ShowSpecialChars := CheckBoxShowSpecialChars.Checked;
  Preferences.Editor.SmartTabDelete := CheckBoxSmartTabDelete.Checked;
  Preferences.Editor.SmartTabs := CheckBoxSmartTabs.Checked;
//  Preferences.Editor.SpecialLineDefaultFg := CheckBoxSpecialLineDefaultFg.Checked;
  Preferences.Editor.TabIndent := CheckBoxTabIndent.Checked;
  Preferences.Editor.TabsToSpaces := CheckBoxTabsToSpaces.Checked;
  Preferences.Editor.TrimTrailingSpace := CheckBoxTrimTrailingSpaces.Checked;

  Preferences.CodeInsight.CodeSuggestions.Enabled := CheckBoxCodeSuggestions.Checked;
  Preferences.CodeInsight.CodeSuggestions.AutoParenthesis := CheckBoxAutoParenthesis.Checked;
  Preferences.CodeInsight.CodeSuggestions.ShowReservedWords := CheckBoxShowReservedWords.Checked;
  Preferences.CodeInsight.CodeParametes := CheckBoxCodeParameters.Checked;
  Preferences.CodeInsight.TooltipSymbolInsight := CheckBoxTooltipSymbol.Checked;
  Preferences.CodeInsight.BlockCompletion := CheckBoxBlockCompletion.Checked;
  Preferences.CodeInsight.ErrorInsight := CheckBoxErrorInsight.Checked;
  Preferences.CodeInsight.Delay := TrackBarToDelay(TrackBarDelay.Position);
  Preferences.CodeInsight.CodeTemplateCompletion := CheckBoxCodeTemplateCompletion.Checked;

  Preferences.Formating.Indention := SpinEditIndent.Value;

  Preferences.Versioning.Colors.Conflicted := ColorBoxConflicted.Color;
  Preferences.Versioning.Colors.Added := ColorBoxAdded.Color;

  SaveHighlighters(Preferences.Highlighter);
end;

end.
