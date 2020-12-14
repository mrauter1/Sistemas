unit uFormConfiguraTextoEmailEmbalagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.DBCtrls,
  uFormAdicionarImagemEmailEmbalagem;

type
  TFormConfiguraTextoEmailEmbalagem = class(TForm)
    PanelBottom: TPanel;
    BtnOK: TButton;
    QryTextoEmail: TFDQuery;
    DsTextoEmail: TDataSource;
    QryTextoEmailIdentificador: TStringField;
    QryTextoEmailTitulo: TStringField;
    QryTextoEmailIntroducao: TMemoField;
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
    BtnTeste: TButton;
    QryTextoEmailCorpo: TMemoField;
    procedure BtnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAddImageClick(Sender: TObject);
    procedure BtnTesteClick(Sender: TObject);
    procedure QryTextoEmailAfterInsert(DataSet: TDataSet);
  private
    FIdentificador: String;
    procedure LoadData(AIdentificador: String);
    { Private declarations }
  public
    { Public declarations }
    class procedure ConfiguraTexto(AIdentificador: String);
  end;

var
  FormConfiguraTextoEmailEmbalagem: TFormConfiguraTextoEmailEmbalagem;

implementation

uses
  uFormEmbalagensClientes, uFormEmbalagensAVencer;

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

procedure TFormConfiguraTextoEmailEmbalagem.BtnTesteClick(Sender: TObject);
var
  FEmail: String;
  FCodCliente: String;

  procedure EnviaEmailPendentes(AEmailTeste, ACodCliente: string);
  var
    FFrm: TFormEmbalagensClientes;
  begin
    FFrm:= TFormEmbalagensClientes.Create(nil);
    try
      FFrm.CarregaEmbalagensCliente(ACodCliente, FIdentificador);
      if FFrm.QryEmbalagensCli.IsEmpty then
        Exit;

      FFrm.EnviaEmailTeste(AEmailTeste);
    finally
      FFrm.Free;
    end;
  end;

  procedure EnviaEmailAVencer(AEmailTeste, ACodCliente: string);
  var
    FFrm: TFormEmbalagensAVencer;
  begin
    FFrm:= TFormEmbalagensAVencer.Create(nil);
    try
      FFrm.CarregaEmbalagensAVencer(ACodCliente, Now+14);
      if FFrm.QryAVencer.IsEmpty then
        Exit;

      FFrm.EnviaEmailTeste(AEmailTeste);
    finally
      FFrm.Free;
    end;
  end;

  procedure EnviaEmailTeste(AEmailTeste, ACodCliente: String);
  begin
    if FIdentificador = 'AVENCER' then
      EnviaEmailAVencer(AEmailTeste, ACodCliente)
    else
      EnviaEmailPendentes(AEmailTeste, ACodCliente);
  end;
  
begin
  if QryTextoEmail.State in ([dsEdit, dsInsert]) then
    QryTextoEmail.Post;

  FEmail:= InputBox('Digite o email que será enviado o teste', 'Email de teste', 'marcelo@rauter.com.br');
  if FEmail = '' then
    Exit;

  FCodCliente:= InputBox('Digite o código do cliente a ser considerado.', 'Código', '000070');
  if FCodCliente = '' then
    Exit;

  EnviaEmailTeste(FEmail, FCodCliente);
end;

procedure TFormConfiguraTextoEmailEmbalagem.LoadData(AIdentificador: String);
begin
  FIdentificador:= AIdentificador;
  QryTextoEmail.Close;
  QryTextoEmail.ParamByName('Identificador').AsString:= FIdentificador.ToUpper;
  QryTextoEmail.Open;
  if QryTextoEmail.IsEmpty then
    QryTextoEmail.Insert;
end;

procedure TFormConfiguraTextoEmailEmbalagem.QryTextoEmailAfterInsert(
  DataSet: TDataSet);
begin
  QryTextoEmailIdentificador.AsString:= FIdentificador;
end;

class procedure TFormConfiguraTextoEmailEmbalagem.ConfiguraTexto
  (AIdentificador: String);
var
  FFrm: TFormConfiguraTextoEmailEmbalagem;
begin
  FFrm := TFormConfiguraTextoEmailEmbalagem.Create(Application);
  try
    if AIdentificador = 'AVENCER' then
      FFrm.Caption:= 'Configurar Texto de Email de Notas de Embalagens A Vencer.'
    else
      FFrm.Caption:= 'Configurar Texto de Envio de Email de Embalagem';
    
    FFrm.LoadData(AIdentificador);
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

procedure TFormConfiguraTextoEmailEmbalagem.FormCreate(Sender: TObject);
begin
  // QryTextoEmail.Open;
end;

end.
