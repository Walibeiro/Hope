unit Hope.DataModule.ImageLists;

{$I Hope.inc}

interface

uses
  System.SysUtils, System.Classes, Vcl.ImgList, Vcl.Imaging.PngImage,
  Vcl.Controls;

type
  TDataModuleImageLists = class(TDataModule)
    ImageList12: TImageList;
    ImageList16: TImageList;
  end;

var
  DataModuleImageLists: TDataModuleImageLists;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
