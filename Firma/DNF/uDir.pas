unit uDir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl;

type
  TfDir = class(TForm)
    DirectoryList: TDirectoryListBox;
    LblDir: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDir: TfDir;

implementation

{$R *.dfm}

procedure TfDir.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
