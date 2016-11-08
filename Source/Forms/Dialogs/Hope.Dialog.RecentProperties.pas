unit Hope.Dialog.RecentProperties;

{$I Hope.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Samples.Spin,
  Hope.Dialog, VirtualTrees;

type
  THistoryItem = record
    FileName: TFileName;
  end;
  PHistoryItem = ^THistoryItem;

  TFormRecentProperties = class(TFormDialog)
    GroupBoxCapacity: TGroupBox;
    GroupBoxItems: TGroupBox;
    LabelProjectCount: TLabel;
    LabelUnitCount: TLabel;
    SpinEditProjectCount: TSpinEdit;
    SpinEditUnitCOunt: TSpinEdit;
    TreeItems: TVirtualStringTree;
    ButtonRemoveInvalid: TButton;
    ButtonDelete: TButton;
    ButtonClear: TButton;
    procedure TreeItemsGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
  public
    procedure AfterConstruction; override;

    class procedure CreateAndShow;
  end;

implementation

{$R *.dfm}

uses
  Hope.DataModule;

{ TFormRecentProperties }

procedure TFormRecentProperties.AfterConstruction;
begin
  inherited;

  TreeItems.NodeDataSize := SizeOf(THistoryItem);
end;

class procedure TFormRecentProperties.CreateAndShow;
begin
  // show project options dialog
  with TFormRecentProperties.Create(nil) do
  try
    SpinEditProjectCount.Value := DataModuleCommon.Preferences.Recent.ProjectCount;
    SpinEditUnitCount.Value := DataModuleCommon.Preferences.Recent.UnitCount;

    if (ShowModal = mrOk) then
    begin
      DataModuleCommon.Preferences.Recent.ProjectCount := SpinEditProjectCount.Value;
      DataModuleCommon.Preferences.Recent.UnitCount := SpinEditUnitCount.Value;
    end;

  finally
    Free;
  end;
end;

procedure TFormRecentProperties.TreeItemsGetText(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  NodeData: PHistoryItem;
begin
  NodeData := Sender.GetNodeData(Node);
  CellText := NodeData^.FileName;
end;

end.

