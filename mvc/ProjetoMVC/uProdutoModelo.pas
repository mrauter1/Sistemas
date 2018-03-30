unit uProdutoModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadModelo, DB, Provider, DBClient, uConexaoDBX;

type
  TProdutoModelo = class(TCadModelo)
    COD: TIntegerField;
    NOME: TStringField;
    VALOR: TFMTBCDField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Itens: TCadModelo;
    function ExisteProduto(Cod: Variant): Boolean;
  end;

var
  ProdutoModelo: TProdutoModelo;

implementation

uses
  uFuncoesSQL, uPedidoItemModelo;

{$R *.dfm}

procedure TProdutoModelo.DataModuleCreate(Sender: TObject);
begin
  inherited;
  NomeTabela:= 'PRODUTO';
  AutoAddPKParam:= True;
  Itens:= TPedidoItemModelo.Create(Self);
  (Itens as TPedidoItemModelo).Produto:= Self;
  RelacionaModelos(COD, (Itens as TPedidoItemModelo).CODPRODUTO, Itens);
end;

function TProdutoModelo.ExisteProduto(Cod: Variant): Boolean;
begin
  Result:= FuncoesSql.RetornaValor('Select count(cod) from produto where COD = '+VarToStrDef(Cod, '0')) > 0;
end;

end.
