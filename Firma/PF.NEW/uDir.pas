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
    class function SelecionaDiretorio(pDirPadrao: String): String;
  end;

implementation

{$R *.dfm}

uses
  uPF;

procedure TfDir.Button1Click(Sender: TObject);
begin
//  Diretorio:= DirectoryList.Directory;
  Close;
end;

class function TfDir.SelecionaDiretorio(pDirPadrao: String): String;
var
  fDir: TfDir;
begin
  fDir:= TfDir.Create(Application);
  try
//    fDir.LblDir.Caption:= pDirPadrao;
    fDir.DirectoryList.Directory:= pDirPadrao;
    fDir.ShowModal;
    Result:= fDir.DirectoryList.Directory;
  finally
    fDir.Free;
  end;

end;

end.
