unit uClienteModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uConexaoDBX, uCadModelo, DB, Provider, DBClient;

type
  TClienteModelo = class(TCadModelo)
    COD: TIntegerField;
    NOME: TStringField;
    CIDADE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TClienteModelo.DataModuleCreate(Sender: TObject);
begin
  inherited;
  NomeTabela:= 'CLIENTE';
  AutoAddPKParam:= True;
end;

end.
