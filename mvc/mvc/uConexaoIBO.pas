unit uConexaoIBO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uConexaoBase, DB, IBODataset, IB_Components, MVCUtils;

type
  TConexaoIBO = class(TConexaoBase)
    ConexaoBanco: TIB_Connection;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure ChecaDataSet(DataSet: TDataSet);
  public
    function GetParams(Tabela: TDataSet): TParams; override;
    procedure SetParams(Value: TParams; Tabela: TDataSet); override;
    function GetSql(Tabela: TDataSet): String; override;
    procedure SetSql(SQL: String; Tabela: TDataSet); override;
    function CriaDataSet(Owner: TComponent): TDataSet; override;
  end;

var
  ConexaoIBO: TConexaoIBO;

implementation

{$R *.dfm}

{ TConexaoIBO }

procedure TConexaoIBO.ChecaDataSet(DataSet: TDataSet);
begin
  if not (DataSet is TIBOQuery) then
    raise Exception.Create('DataSet não é TIBOQuery! '+Self.Name);
end;

function TConexaoIBO.CriaDataSet(Owner: TComponent): TDataSet;
var
  Query: TIBOQuery;
begin
  Query:= TIBOQuery.Create(Owner);
  Query.IB_Connection:= ConexaoBanco;
  Result:= Query;
end;

procedure TConexaoIBO.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ConexaoBanco.Path:= sBancoArquivo; 
  ConexaoBanco.Connected:= True;
end;

function TConexaoIBO.GetSql(Tabela: TDataSet): String;
begin
  ChecaDataSet(Tabela);
  Result:= (Tabela as TIBOQuery).SQL.Text;
end;

procedure TConexaoIBO.SetSql(SQL: String; Tabela: TDataSet);
begin
  ChecaDataSet(Tabela);
  (Tabela as TIBOQuery).Sql.Text:= SQL;
end;

function TConexaoIBO.GetParams(Tabela: TDataSet): TParams;
begin
  ChecaDataSet(Tabela);
  result:= (Tabela as TIBOQuery).Params;
end;

procedure TConexaoIBO.SetParams(Value: TParams; Tabela: TDataSet);
begin
  ChecaDataSet(Tabela);
  (Tabela as TIBOQuery).params:= Value;
end;

end.
