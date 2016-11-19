object DataModuleCommon: TDataModuleCommon
  OldCreateOrder = False
  Height = 442
  Width = 547
  object SynEditSearch: TSynEditSearch
    Left = 48
    Top = 72
  end
  object SynObjectPascal: TSynMultiSyn
    DefaultFilter = 'DWScript Files (*.dws;*.pas;*.inc)|*.dws;*.pas;*.inc'
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.DefaultExtension = '.dws'
    Options.Title = 'Object Pascal Syntax Highlighter'
    Options.Visible = False
    Schemes = <
      item
        StartExpr = 'asm'
        EndExpr = 'end;'
        Highlighter = SynJS
        SchemeName = 'Assembler'
      end>
    DefaultHighlighter = SynDWS
    DefaultLanguageName = 'DWScript'
    Left = 160
    Top = 264
  end
  object SynEditRegexSearch: TSynEditRegexSearch
    Left = 48
    Top = 120
  end
  object SynMacroRecorder: TSynMacroRecorder
    RecordShortCut = 24658
    PlaybackShortCut = 24656
    OnStateChange = SynMacroRecorderStateChange
    Left = 48
    Top = 168
  end
  object SynDWS: TSynDWSSyn
    DefaultFilter = 'DWScript Files (*.dws;*.pas;*.inc)|*.dws;*.pas;*.inc'
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 160
    Top = 24
  end
  object SynJS: TSynJScriptSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 160
    Top = 72
  end
  object SynJSON: TSynJSONSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 160
    Top = 120
  end
  object SynHTML: TSynHTMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 160
    Top = 216
  end
  object SynCSS: TSynCssSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 160
    Top = 168
  end
  object SynCodeSuggestions: TSynCompletionProposal
    Options = [scoLimitToMatchedText, scoTitleIsCentered, scoUseInsertList, scoUsePrettyText, scoUseBuiltInTimer, scoEndCharCompletion, scoCompleteWithEnter]
    EndOfTokenChr = '()[]. '
    TriggerChars = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        ColumnWidth = 50
      end
      item
        ColumnWidth = 196
        DefaultFontStyle = [fsBold]
      end>
    Resizeable = False
    ItemHeight = 16
    OnExecute = SynCodeSuggestionsExecute
    OnShow = SynCodeSuggestionsShow
    ShortCut = 0
    TimerInterval = 500
    Left = 264
    Top = 72
  end
  object SynParameters: TSynCompletionProposal
    DefaultType = ctParams
    Options = [scoLimitToMatchedText, scoUsePrettyText, scoUseBuiltInTimer]
    ClBackground = clInfoBk
    Width = 262
    EndOfTokenChr = '()[].,; '
    TriggerChars = '('
    Title = 'Parameter Information'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <>
    OnClose = SynParametersClose
    OnExecute = SynParametersExecute
    OnShow = SynParametersShow
    ShortCut = 24608
    TimerInterval = 500
    Left = 264
    Top = 24
  end
  object SynMultiCSS: TSynMultiSyn
    DefaultFilter = 'CSS Files (*.css)|*.css'
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.DefaultExtension = '.css'
    Options.Title = 'CSS Syntax Highlighter'
    Options.Visible = False
    Schemes = <
      item
        CaseSensitive = False
        StartExpr = '</?pas'
        EndExpr = '/?>'
        Highlighter = SynObjectPascal
        SchemeName = 'Object Pascal'
      end
      item
        CaseSensitive = False
        StartExpr = '</?pas='
        EndExpr = '/?>'
        Highlighter = SynObjectPascal
        SchemeName = 'Object Pascal (direct)'
      end>
    DefaultHighlighter = SynCSS
    DefaultLanguageName = 'CSS'
    Left = 160
    Top = 312
  end
  object SynMultiHTML: TSynMultiSyn
    DefaultFilter = 'HTML files (*.html;*,htm)|*.html;*.htm'
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.DefaultExtension = '.html'
    Options.Title = 'HTML Highlighter'
    Options.Visible = False
    Schemes = <
      item
        CaseSensitive = False
        StartExpr = '</?pas'
        EndExpr = '/?>'
        Highlighter = SynObjectPascal
        SchemeName = 'Object Pascal'
      end
      item
        CaseSensitive = False
        StartExpr = '</?pas='
        EndExpr = '/?>'
        Highlighter = SynObjectPascal
        SchemeName = 'Object Pascal (direct)'
      end
      item
        StartExpr = '<script(.*?)>'
        EndExpr = '</style>'
        Highlighter = SynMultiCSS
        SchemeName = 'CSS'
      end
      item
        StartExpr = '<script(.*?)>'
        EndExpr = '</script>'
        Highlighter = SynJS
        SchemeName = 'JavaScript'
      end>
    DefaultHighlighter = SynHTML
    DefaultLanguageName = 'HTML'
    Left = 160
    Top = 360
  end
end
