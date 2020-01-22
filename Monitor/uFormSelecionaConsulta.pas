unit uFormSelecionaConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, dxtree, dxdbtree,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFormSelecionaConsulta = class(TForm)
    TreeViewMenu: TdxDBTreeView;
    DsMenu: TDataSource;
    QryMenu: TFDQuery;
    QryMenuID: TFDAutoIncField;
    QryMenuDescricao: TStringField;
    QryMenuIDPai: TIntegerField;
    QryMenuTipo: TIntegerField;
    QryMenuIDAcao: TIntegerField;
    Panel1: TPanel;
    BtnSelecionar: TBitBtn;
    procedure BtnSelecionarClick(Sender: TObject);
    procedure TreeViewMenuDblClick(Sender: TObject);
  private
    { Private declarations }
    FIDSelecionado: Integer;
  public
    { Public declarations }
    function SelecionaConsultaInterno: Integer;
    class function SelecionaConsulta: Integer;
  end;

implementation

{$R *.dfm}

{ TFormSelecionaConsulta }

procedure TFormSelecionaConsulta.BtnSelecionarClick(Sender: TObject);
begin
  FIDSelecionado:= 0;
  if QryMenuTipo.AsInteger = 0 then
  begin
    ShowMessage('Selecione uma consulta!');
    Exit;
  end;

  FIDSelecionado:= QryMenuIDAcao.AsInteger;
  Close;
end;

class function TFormSelecionaConsulta.SelecionaConsulta: Integer;
var
  vFrm: TFormSelecionaConsulta;
begin
  vFrm:= TFormSelecionaConsulta.Create(Application);
  try
    Result:= vFrm.SelecionaConsultaInterno;
  finally
    vFrm.Free;
  end;
end;

function TFormSelecionaConsulta.SelecionaConsultaInterno: Integer;
begin
  FIDSelecionado:= 0;
  QryMenu.Open;
  ShowModal;
  Result:= FIDSelecionado;
end;

procedure TFormSelecionaConsulta.TreeViewMenuDblClick(Sender: TObject);
begin
  BtnSelecionar.Click;
end;

end.
