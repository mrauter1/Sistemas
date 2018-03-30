unit uConexaoDBX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uConexaoBase, DB, SqlExpr, FMTBcd, MVCUtils, WideStrings,
  Data.DBXFirebird;

type
  TConexaoDBX = class(TConexaoBase)
    ConexaoBanco: TSQLConnection;
    SQLQuery1: TSQLQuery;
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
  ConexaoDBX: TConexaoDBX;

implementation

{$R *.dfm}

{ TConexaoDBX }
procedure TConexaoDBX.ChecaDataSet(DataSet: TDataSet);
begin
  if not (DataSet is TSqlQuery) then
    raise Exception.Create('DataSet não é TSQLQuery! '+Self.Name);
end;

function TConexaoDBX.CriaDataSet(Owner: TComponent): TDataSet;
var
  Query: TSqlQuery;
begin
  Query:= TSqlQuery.Create(Owner);
  Query.SQLConnection:= ConexaoBanco;
  Result:= Query;
end;

procedure TConexaoDBX.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ConexaoBanco.Params.Values['Database']:= sBancoArquivo;
  ConexaoBanco.Connected:= True;
end;

function TConexaoDBX.GetSql(Tabela: TDataSet): String;
begin
  ChecaDataSet(Tabela);
  Result:= (Tabela as TSqlQuery).SQL.Text;
end;

procedure TConexaoDBX.SetSql(SQL: String; Tabela: TDataSet);
begin
  ChecaDataSet(Tabela);
  (Tabela as TSqlQuery).Sql.Text:= SQL;
end;

function TConexaoDBX.GetParams(Tabela: TDataSet): TParams;
begin
  ChecaDataSet(Tabela);
  result:= (Tabela as TSqlQuery).Params;
end;

procedure TConexaoDBX.SetParams(Value: TParams; Tabela: TDataSet);
begin
  ChecaDataSet(Tabela);
  (Tabela as TSqlQuery).params:= Value;
end;


end.
