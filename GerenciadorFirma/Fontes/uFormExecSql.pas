unit uFormExecSql;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uFrmConsulta;

type
  TFormExecSql = class(TForm)
    MemoSql: TMemo;
    PanelTop: TPanel;
    BtnExec: TButton;
    procedure BtnExecClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure AbreForm(AOwner: TComponent); static;
  end;

var
  FormExecSql: TFormExecSql;

implementation

{$R *.dfm}

class procedure TFormExecSql.AbreForm(AOwner: TComponent);
var
  FFrm: TFormExecSql;
begin
  FFrm:= TFormExecSql.Create(AOwner);
  try
    FFrm.Show;
  except
    FFrm.Free;
    raise
  end;
end;

procedure TFormExecSql.BtnExecClick(Sender: TObject);
begin
  TFrmConsulta.AbreEExecutaSql(MemoSql.Lines.Text);
end;

procedure TFormExecSql.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

end.
