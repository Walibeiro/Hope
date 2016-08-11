object DataModuleCommon: TDataModuleCommon
  OldCreateOrder = False
  Height = 442
  Width = 547
  object JvDockDelphiStyle: TJvDockDelphiStyle
    Left = 47
    Top = 22
  end
  object SynEditSearch: TSynEditSearch
    Left = 48
    Top = 72
  end
  object SynObjectPascal: TSynMultiSyn
    DefaultFilter = 'DWScript Files (*.dws;*.pas;*.inc)|*.dws;*.pas;*.inc'
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Schemes = <
      item
        StartExpr = 'asm'
        EndExpr = 'end;'
        Highlighter = SynJScriptSyn
      end>
    DefaultHighlighter = SynDWSSyn
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
    Left = 48
    Top = 168
  end
  object SynDWSSyn: TSynDWSSyn
    DefaultFilter = 'DWScript Files (*.dws;*.pas;*.inc)|*.dws;*.pas;*.inc'
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 160
    Top = 24
  end
  object SynJScriptSyn: TSynJScriptSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 160
    Top = 72
  end
  object SynJSONSyn: TSynJSONSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 160
    Top = 120
  end
  object SynHTMLSyn: TSynHTMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 160
    Top = 216
  end
  object SynCssSyn: TSynCssSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 160
    Top = 168
  end
end
