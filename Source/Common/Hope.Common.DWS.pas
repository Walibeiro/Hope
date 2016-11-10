unit Hope.Common.DWS;

interface

uses
  System.SysUtils, System.Classes, dwsSymbols;

procedure AddParametersToParameterInfo(const Params: TParamsSymbolTable;
  const List: TStrings; const SkipCount: Integer);
function CollectMethodOverloads(MethodSymbol: TMethodSymbol): TFuncSymbolList;

implementation

uses
  dwsUtils;

procedure AddParametersToParameterInfo(const Params: TParamsSymbolTable;
  const List: TStrings; const SkipCount: Integer);
var
  y: Integer;
  ParamsStr: string;
begin
  ParamsStr := '';
  if (Params <> nil) and (Params.Count > 0) then
  begin
    if SkipCount >= Params.Count then
      Exit;

    ParamsStr := '"' + Params[0].Description + ';"';
    for y := 1 to Params.Count - 1 do
      ParamsStr := ParamsStr + ',"' + Params[y].Description + ';"';
  end
  else if SkipCount > 0 then
    Exit;

  if (List.IndexOf(ParamsStr) < 0) then
    List.Add(ParamsStr);
end;

function CollectMethodOverloads(MethodSymbol: TMethodSymbol): TFuncSymbolList;
var
  Member: TSymbol;
  Struct: TCompositeTypeSymbol;
  LastOverloaded: TMethodSymbol;
begin
  LastOverloaded := MethodSymbol;
  Struct := MethodSymbol.StructSymbol;
  repeat
    for Member in Struct.Members do
    begin
      if not UnicodeSameText(Member.Name, MethodSymbol.Name) then
        Continue;
      if not (Member is TMethodSymbol) then
        Continue;

      LastOverloaded := TMethodSymbol(Member);
      if not Result.ContainsChildMethodOf(LastOverloaded) then
        Result.Add(LastOverloaded);
    end;

    Struct := Struct.Parent;
  until (Struct = nil) or not LastOverloaded.IsOverloaded;
end;

end.

