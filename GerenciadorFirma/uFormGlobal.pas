unit uFormGlobal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxStyles, cxGridTableView, cxClasses;

type
  TFormGlobal = class(TForm)
    cxStyleRepository1: TcxStyleRepository;
    cxStyleLinhaPar: TcxStyle;
    cxStyleLinhaImpar: TcxStyle;
    cxGridTableViewStyleSheet1: TcxGridTableViewStyleSheet;
    cxStyleGroup: TcxStyle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGlobal: TFormGlobal;

implementation

{$R *.dfm}

end.
