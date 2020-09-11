unit uFormSelecionaEmailCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uConFirebird, Vcl.Menus;

type
  TFormSelecionaEmailCliente = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    BtnSelecionar: TButton;
    EditEmails: TEdit;
    QryContatosCliente: TFDQuery;
    DsContatosCliente: TDataSource;
    QryContatosClienteCODCLIENTE: TStringField;
    QryContatosClienteCODSEQUENCIA: TIntegerField;
    QryContatosClienteTELEFONE: TStringField;
    QryContatosClienteCONTATO: TStringField;
    QryContatosClienteEMAIL: TStringField;
    PopupMenu1: TPopupMenu;
    AdicionarEmail1: TMenuItem;
    procedure AdicionarEmail1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BtnSelecionarClick(Sender: TObject);
  private
    procedure CarregaContatos(ACodCliente: String);
    { Private declarations }
  public
    { Public declarations }
    class function SelecionaEmailContatos(ACodCliente: String; AEmailAtual: String): String;
  end;

var
  FormSelecionaEmailCliente: TFormSelecionaEmailCliente;

implementation

{$R *.dfm}

{ TFormSelecionaEmailCliente }

class function TFormSelecionaEmailCliente.SelecionaEmailContatos(ACodCliente,
  AEmailAtual: String): String;
var
  FFrm: TFormSelecionaEmailCliente;
begin
  FFrm:= TFormSelecionaEmailCliente.Create(nil);
  try
    FFrm.EditEmails.Text:= AEmailAtual;
    FFrm.CarregaContatos(ACodCliente);
    FFrm.ShowModal;
    Result:= FFrm.EditEmails.Text;
  finally
    FFrm.Free;
  end;
end;

procedure TFormSelecionaEmailCliente.AdicionarEmail1Click(Sender: TObject);
begin
  if Trim(QryContatosClienteEMAIL.AsString) = '' then
    Exit;

  if Trim(EditEmails.Text) <> '' then
    EditEmails.Text:= EditEmails.Text+'; ';

  EditEmails.Text:= EditEmails.Text+Trim(QryContatosClienteEMAIL.AsString);
end;

procedure TFormSelecionaEmailCliente.BtnSelecionarClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSelecionaEmailCliente.CarregaContatos(ACodCliente: String);
begin
  QryContatosCliente.Close;
  QryContatosCliente.ParamByName('CodCliente').AsString:= ACodCliente;
  QryContatosCliente.Open;
end;

procedure TFormSelecionaEmailCliente.DBGrid1DblClick(Sender: TObject);
begin
  AdicionarEmail1Click(Sender);
end;

end.
