unit Hope.Common;

interface

uses
  System.SysUtils, System.Classes, JvComponentBase, JvDockTree,
  JvDockControlForm, JvDockDelphiStyle;

type
  TDataModuleCommon = class(TDataModule)
    JvDockDelphiStyle: TJvDockDelphiStyle;
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

