unit Hope.Common;

interface

uses
  System.SysUtils, System.Classes, JvComponentBase, JvDockTree,
  JvDockControlForm, JvDockDelphiStyle;

type
  TDataModule1 = class(TDataModule)
    JvDockDelphiStyle: TJvDockDelphiStyle;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.

