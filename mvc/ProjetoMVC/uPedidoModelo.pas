unit uPedidoModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Provider, uFuncoesSQL,
  uCadModelo, uConexaoDBX, uClienteModelo, uPedidoItemModelo;

type
  TPedidoMD = class(TCadModelo)
    COD: TIntegerField;
    NOME: TStringField;
    CODCLIENTE: TIntegerField;
    NOMECLIENTE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSBeforeDelete(DataSet: TDataSet);
    procedure CDSCalcFields(DataSet: TDataSet);
  private
  protected

  public
    Cliente: TClienteModelo;
    Itens: TPedidoItemModelo;
  end;

implementation

{$R *.dfm}

procedure TPedidoMD.CDSBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  Itens.CDS.First;
  while not Itens.CDS.IsEmpty do
  begin
    Itens.CDS.Delete;
  end;
  Itens.CDS.ApplyUpdates(0);
end;

procedure TPedidoMD.CDSCalcFields(DataSet: TDataSet);
begin
  inherited;
  CODCliente.AsString;
  NomeCliente.AsString:= Cliente.Nome.AsString;
end;

procedure TPedidoMD.DataModuleCreate(Sender: TObject);
begin
  inherited;
  NomeTabela:= 'PEDIDO';
  AutoAddPKParam:= True;
  Cliente:= TClienteModelo.Create(Self);
  RelacionaModelos(CODCliente, Cliente.COD, Cliente, true);
  Itens:= TPedidoItemModelo.Create(Self);
  RelacionaModelos(COD, Itens.CODPEDIDO, Itens);
end;

end.
