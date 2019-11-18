unit uFormConfGrupo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uDtm_PF,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uDmDados;

type
  TFormConfGrupo = class(TForm)
    Panel1: TPanel;
    BtnOk: TBitBtn;
    Panel2: TPanel;
    EditComprov: TEdit;
    BtnAdd: TButton;
    BtnDel: TButton;
    DBGrid1: TDBGrid;
    procedure BtnAddClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConfGrupo: TFormConfGrupo;

implementation

{$R *.dfm}


procedure TFormConfGrupo.BtnAddClick(Sender: TObject);
begin
  DmDados.CdsConfGrupo.Append;
  DmDados.CdsConfGrupoCodGrupoSub.AsString:= EditComprov.Text;
  DmDados.AtualizaConfGrupoAtual;
  DmDados.CdsConfGrupo.Post;
end;

procedure TFormConfGrupo.BtnDelClick(Sender: TObject);
begin
  DmDados.CdsConfGrupo.Delete;
end;

procedure TFormConfGrupo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DmDados.RevalidaConfGrupos;
end;

end.
