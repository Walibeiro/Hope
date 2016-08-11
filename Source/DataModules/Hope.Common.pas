unit Hope.Common;

interface

uses
  System.SysUtils, System.Classes, JvComponentBase, JvDockTree,
  JvDockControlForm, JvDockDelphiStyle, SynEditPlugins, SynMacroRecorder,
  SynEditRegexSearch, SynEditHighlighter, SynHighlighterMulti,
  SynEditMiscClasses, SynEditSearch, SynHighlighterCSS, SynHighlighterHtml,
  SynHighlighterJSON, SynHighlighterJScript, SynHighlighterDWS;

type
  TDataModuleCommon = class(TDataModule)
    JvDockDelphiStyle: TJvDockDelphiStyle;
    SynEditSearch: TSynEditSearch;
    SynObjectPascal: TSynMultiSyn;
    SynEditRegexSearch: TSynEditRegexSearch;
    SynMacroRecorder: TSynMacroRecorder;
    SynDWSSyn: TSynDWSSyn;
    SynJScriptSyn: TSynJScriptSyn;
    SynJSONSyn: TSynJSONSyn;
    SynHTMLSyn: TSynHTMLSyn;
    SynCssSyn: TSynCssSyn;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  DataModuleCommon: TDataModuleCommon;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

