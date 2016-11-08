unit Hope.Project.Statistics;

interface

uses
  System.SysUtils, System.Generics.Collections, dwsJSON, Hope.Common.JSON;

type
  TStatisticsTimeType = (stEdit, stRun, stCompile, stTotal);

  TCustomProjectStatistics = class(THopeJsonBase)
  strict protected
    FTimes: array [TStatisticsTimeType] of TDateTime;
    FBackgroundCompilations: Integer;
    FTotalLinesOfCode: Integer;
  protected
    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;
    class function GetPreferredName: string; override;
  public
    procedure Clear; virtual;

    procedure Advance(TimeType: TStatisticsTimeType; Value: TDateTime);
    procedure AdvanceBackgroundCompilations; virtual;
    procedure AdvanceLinesOfCode(Delta: Integer);

    procedure Sync(New: TCustomProjectStatistics);

    property TotalTime: TDateTime read FTimes[stTotal];
    property EditTime: TDateTime read FTimes[stEdit];
    property RunningTime: TDateTime read FTimes[stRun];
    property CompileTime: TDateTime read FTimes[stCompile];
    property BackgroundCompilations: Integer read FBackgroundCompilations;
    property TotalLinesOfCode: Integer read FTotalLinesOfCode;
  end;

  TProjectStatisticSession = class(TCustomProjectStatistics)
  private
    FTimeStamp: TDateTime;
  protected
    class function GetPreferredName: string; override;
  public
    constructor Create;

    procedure ReadJson(const JsonValue: TdwsJSONObject); override;
    procedure WriteJson(const JsonValue: TdwsJSONObject); override;

    property TimeStamp: TDateTime read FTimeStamp;
  end;

implementation


{ TCustomProjectStatistics }

procedure TCustomProjectStatistics.AdvanceBackgroundCompilations;
begin
  Inc(FBackgroundCompilations);
end;

procedure TCustomProjectStatistics.AdvanceLinesOfCode(Delta: Integer);
begin
  FTotalLinesOfCode := FTotalLinesOfCode + Delta;
end;

procedure TCustomProjectStatistics.Clear;
var
  Index: TStatisticsTimeType;
begin
  for Index := Low(TStatisticsTimeType) to High(TStatisticsTimeType) do
    FTimes[Index] := 0;

  FBackgroundCompilations := 0;
  FTotalLinesOfCode := 0;
end;

class function TCustomProjectStatistics.GetPreferredName: string;
begin
  Result := 'Statistics';
end;

procedure TCustomProjectStatistics.ReadJson(const JsonValue: TdwsJSONObject);
begin
  FTimes[stEdit] := JsonValue.GetValue('EditTime', FTimes[stEdit]);
  FTimes[stRun] := JsonValue.GetValue('RunningTime', FTimes[stRun]);
  FTimes[stCompile] := JsonValue.GetValue('CompileTime', FTimes[stCompile]);
  FTimes[stTotal] := JsonValue.GetValue('TotalTime', FTimes[stTotal]);
  FBackgroundCompilations := JsonValue.GetValue('BackgroundCompilations', FBackgroundCompilations);
  FTotalLinesOfCode := JsonValue.GetValue('TotalLinesOfCode', FTotalLinesOfCode);
end;

procedure TCustomProjectStatistics.WriteJson(const JsonValue: TdwsJSONObject);
begin
  JsonValue.AddValue('EditTime', FTimes[stEdit]);
  JsonValue.AddValue('CompileTime', FTimes[stCompile]);
  JsonValue.AddValue('TotalTime', FTimes[stTotal]);
  JsonValue.AddValue('RunningTime', FTimes[stRun]);
  JsonValue.AddValue('BackgroundCompilations', FBackgroundCompilations);
  JsonValue.AddValue('TotalLinesOfCode', FTotalLinesOfCode);
end;

procedure TCustomProjectStatistics.Sync(New: TCustomProjectStatistics);
begin
  // eventually update (if values are greater)
  if New.FTimes[stTotal] > FTimes[stTotal] then
    FTimes[stTotal] := New.FTimes[stTotal];
  if New.FTimes[stEdit] > FTimes[stEdit] then
    FTimes[stEdit] := New.FTimes[stEdit];
  if New.FTimes[stCompile] > FTimes[stCompile] then
    FTimes[stCompile] := New.FTimes[stCompile];
  if New.FTimes[stRun] > FTimes[stRun] then
    FTimes[stRun] := New.FTimes[stRun];
  if New.FBackgroundCompilations > FBackgroundCompilations then
    FBackgroundCompilations := New.FBackgroundCompilations;
  FTotalLinesOfCode := New.FTotalLinesOfCode;
end;

procedure TCustomProjectStatistics.Advance(TimeType: TStatisticsTimeType;
  Value: TDateTime);
begin
  FTimes[TimeType] := Value;
end;


{ TProjectStatisticSession }

constructor TProjectStatisticSession.Create;
begin
  FTimeStamp := Now;
end;

class function TProjectStatisticSession.GetPreferredName: string;
begin
  Result := 'Session';
end;

procedure TProjectStatisticSession.ReadJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

  FTimeStamp := JsonValue.GetValue('TimeStamp', FTimeStamp);
end;

procedure TProjectStatisticSession.WriteJson(const JsonValue: TdwsJSONObject);
begin
  inherited;

  JsonValue.AddValue('TimeStamp', FTimeStamp);
end;

end.

