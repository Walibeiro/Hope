unit Hope.Dialog.AddToDoItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Samples.Spin, Hope.Dialog;

type
  TFormAddToDoItem = class(TFormDialog)
    ComboBoxCategory: TComboBox;
    ComboBoxOwner: TComboBox;
    LabelCategory: TLabel;
    LabelOwner: TLabel;
    LabelPriority: TLabel;
    LabelText: TLabel;
    MemoItem: TMemo;
    SpinEditPriority: TSpinEdit;
  end;

implementation

{$R *.dfm}

end.

