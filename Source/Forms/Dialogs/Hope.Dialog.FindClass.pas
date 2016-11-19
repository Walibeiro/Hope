unit Hope.Dialog.FindClass;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Hope.Dialog, VirtualTrees;

type
  TFormFindClass = class(TFormDialog)
    EditSearch: TEdit;
    LabelClasses: TLabel;
    LabelSearch: TLabel;
    TreeClasses: TVirtualStringTree;
    procedure EditSearchChange(Sender: TObject);
  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses
  Hope.DataModule.ImageLists;

{ TFormFindClass }

procedure TFormFindClass.AfterConstruction;
begin
  inherited;

  TreeClasses.Images := DataModuleImageLists.ImageList16;
  TreeClasses.StateImages := DataModuleImageLists.ImageList16;
end;

procedure TFormFindClass.EditSearchChange(Sender: TObject);
begin
  //
end;

end.

