unit uFormConfigurarEmailEmbalagens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFormConfigurarEmailEmbalagens = class(TForm)
    PanelBottom: TPanel;
    BtnOK: TButton;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBEditUser: TDBEdit;
    DBEditSenha: TDBEdit;
    DBEditServidor: TDBEdit;
    DBEditPorta: TDBEdit;
    QryEmail: TFDQuery;
    DsEmail: TDataSource;
    QryEmailIdentificador: TStringField;
    QryEmailUsuario: TStringField;
    QryEmailPassword: TStringField;
    QryEmailSMTPServer: TStringField;
    QryEmailPort: TIntegerField;
    QryEmailrequireAuth: TBooleanField;
    procedure BtnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure ConfiguraEmail; static;
  end;

var
  FormConfigurarEmailEmbalagens: TFormConfigurarEmailEmbalagens;

implementation

{$R *.dfm}

procedure TFormConfigurarEmailEmbalagens.BtnOKClick(Sender: TObject);
begin
  if QryEmail.State in ([dsEdit, dsInsert]) then
    QryEmail.Post;

  Close;
end;

class procedure TFormConfigurarEmailEmbalagens.ConfiguraEmail;
var
  FFrm: TFormConfigurarEmailEmbalagens;
begin
  FFrm:= TFormConfigurarEmailEmbalagens.Create(Application);
  try
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

procedure TFormConfigurarEmailEmbalagens.FormCreate(Sender: TObject);
begin
  QryEmail.Open;
end;

end.
