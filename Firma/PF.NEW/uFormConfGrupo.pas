unit uFormConfGrupo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uDtm_PF,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

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
  Dtm_PF.CdsConfGrupo.Append;
  Dtm_PF.CdsConfGrupoCodGrupoSub.AsString:= EditComprov.Text;
  Dtm_PF.AtualizaConfGrupoAtual;
  Dtm_PF.CdsConfGrupo.Post;
end;

procedure TFormConfGrupo.BtnDelClick(Sender: TObject);
begin
  Dtm_PF.CdsConfGrupo.Delete;
end;

end.
