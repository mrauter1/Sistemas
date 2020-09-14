unit uFormConfiguraTextoEmailEmbalagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.DBCtrls, uFormAdicionarImagemEmailEmbalagem;

type
  TFormConfiguraTextoEmailEmbalagem = class(TForm)
    PanelBottom: TPanel;
    BtnOK: TButton;
    QryTextoEmail: TFDQuery;
    DsTextoEmail: TDataSource;
    QryTextoEmailIdentificador: TStringField;
    QryTextoEmailTitulo: TStringField;
    QryTextoEmailIntroducao: TMemoField;
    QryTextoEmailPoliticaDevolucao: TMemoField;
    QryTextoEmailAssinatura: TMemoField;
    ScrollBox1: TScrollBox;
    DBEditUser: TDBEdit;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    DBMemoIntroducao: TDBMemo;
    DBMemoPolitica: TDBMemo;
    DBMemoAssinatura: TDBMemo;
    Label4: TLabel;
    BtnAddImage: TButton;
    procedure BtnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAddImageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure ConfiguraTexto;
  end;

var
  FormConfiguraTextoEmailEmbalagem: TFormConfiguraTextoEmailEmbalagem;

implementation

{$R *.dfm}

procedure TFormConfiguraTextoEmailEmbalagem.BtnAddImageClick(Sender: TObject);
begin
  TFormAdicionarImagemEmailEmbalagem.Gerenciar;
end;

procedure TFormConfiguraTextoEmailEmbalagem.BtnOKClick(Sender: TObject);
begin
  if QryTextoEmail.State in ([dsEdit, dsInsert]) then
    QryTextoEmail.Post;

  Close;
end;

class procedure TFormConfiguraTextoEmailEmbalagem.ConfiguraTexto;
var
  FFrm: TFormConfiguraTextoEmailEmbalagem;
begin
  FFrm:= TFormConfiguraTextoEmailEmbalagem.Create(Application);
  try
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

procedure TFormConfiguraTextoEmailEmbalagem.FormCreate(Sender: TObject);
begin
  QryTextoEmail.Open;
end;

end.
