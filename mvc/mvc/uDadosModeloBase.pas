unit uDadosModeloBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uModeloBase, DB, DBClient, Provider, uConexaoBase, uMVCInterfaces;

type
  TAfterConectaEvent = procedure of object;
  TCarregaEvent = procedure of object;

  TDadosModeloBase = class(TModeloBase)
    CDS: TClientDataSet;
    Provider: TDataSetProvider;
    procedure DataModuleCreate(Sender: TObject);
  private
    fConexao: TConexaoBase;
    fAutoApplyUpdates: Boolean;
    fSql, fArquivo: String;
    fFormato: TDataPacketFormat;
    fIsDBConnection: Boolean;
    fAfterConecta: TAfterConectaEvent;
    fBeforeCarrega: TCarregaEvent;
    fAfterCarrega: TCarregaEvent;
  protected
    procedure ChecaConexao; virtual;
    procedure ChecaArquivo; virtual;
    procedure ChecaAutoApply;
    procedure ModeloApplyUpdates; virtual;
    function GetSql: String;
    procedure SetSql(Value: String);
    function GetDataSet: TDataSet;
    procedure SetDataSet(Value: TDataSet); virtual;
    procedure SetConexao(Value: TConexaoBase); virtual;
    function GetConexao: TConexaoBase;
    procedure DoAfterConecta; virtual;
    procedure DoBeforeCarrega; virtual;
    procedure DoAfterCarrega; virtual;
    function GetParams: TParams;
    procedure SetParams(Value: TParams);
  public
    property IsDBConnection: Boolean read fIsDBConnection write fIsDBConnection;
    property Conexao: TConexaoBase read GetConexao write SetConexao;
    property DataSet: TDataSet read GetDataSet write SetDataSet;
    property SQL: String read GetSql write SetSql;
    property Formato: TDataPacketFormat read fFormato write fFormato;
    property Arquivo: String read fArquivo write fArquivo;
    property Params: TParams read GetParams write SetParams;
    property AutoApplyUpdates: Boolean read fAutoApplyUpdates write fAutoApplyUpdates;
    property AfterConecta: TAfterConectaEvent read fAfterConecta write fAfterConecta;
    property BeforeCarrega: TCarregaEvent read fBeforeCarrega write FBeforeCarrega;
    property AfterCarrega: TCarregaEvent read fAfterCarrega write fAfterCarrega;
    function Salvar: Boolean; virtual;
    function Carregar: Boolean; virtual;
    procedure Adicionar; virtual;
    procedure Editar; virtual;
    procedure Deletar; virtual;
    procedure Cancelar; virtual;
    procedure Confirmar; virtual;
  end;

implementation

{$R *.dfm}

procedure TDadosModeloBase.DoBeforeCarrega;
begin
  if Assigned(fBeforeCarrega) then
    fBeforeCarrega;
end;

procedure TDadosModeloBase.DoAfterCarrega;
begin
  if Assigned(fAfterCarrega) then
    fAfterCarrega;
end;

procedure TDadosModeloBase.DoAfterConecta;
begin
  if Assigned(fAfterConecta) then
    fAfterConecta;
end;

function TDadosModeloBase.GetSql: String;
begin
  Result:= fSql;
end;

procedure TDadosModeloBase.ModeloApplyUpdates;
begin
  if CDS.ApplyUpdates(0) > 0 then
    raise EInformaErro.Create('Erro de gravação!: '+Self.Name);
end;

procedure TDadosModeloBase.ChecaAutoApply;
begin
  if fAutoApplyUpdates then
    ModeloApplyUpdates;
end;

procedure TDadosModeloBase.SetSql(Value: String);
begin
  fSql:= Value;
  if (DataSet <> nil) and (Conexao <> nil) then
    Conexao.SetSql(SQL, DataSet);
end;

function TDadosModeloBase.GetDataSet: TDataSet;
begin
  Result:= provider.DataSet;
end;

procedure TDadosModeloBase.SetDataSet(Value: TDataSet);
begin
  provider.DataSet:= Value;
  Conexao.SetSql(SQL, DataSet);
end;

procedure TDadosModeloBase.ChecaConexao;
begin
  if fConexao = nil then
    raise EInformaErro.Create('Não há conexão definida!: '+Self.Name);

  if DataSet = nil then
    raise EInformaErro.Create('Não há tabela definida!: '+Self.Name);
end;

procedure TDadosModeloBase.ChecaArquivo;
begin
  if Arquivo = '' then
    raise EInformaErro.Create('Não há local para salvar o ClientDataSet definido! '+Self.Name);
end;

procedure TDadosModeloBase.SetConexao(Value: TConexaoBase);
begin
  if fConexao = value then exit;

  fConexao:= Value;
  DataSet:= fConexao.CriaDataSet(Self);
  DoAfterConecta;
end;

function TDadosModeloBase.GetConexao: TConexaoBase;
begin
  Result:= fConexao;
end;

function TDadosModeloBase.GetParams: TParams;
begin
  ChecaConexao;

  Result:= Conexao.GetParams(DataSet);
end;

procedure TDadosModeloBase.SetParams(Value: TParams);
begin
  ChecaConexao;

  Conexao.SetParams(Value, DataSet);
end;

function TDadosModeloBase.Salvar: Boolean;
begin
  Result:= True;
  try
    if fIsDBConnection then
    begin
      ChecaConexao;
      ModeloApplyUpdates;
    end
   else
    begin
      ChecaArquivo;
      CDS.SaveToFile(Arquivo, Formato);
    end;
  Except
    Result:= False;
  end;
end;

function TDadosModeloBase.Carregar: Boolean;
begin
  DoBeforeCarrega;
  if fIsDBConnection then
  begin
    ChecaConexao;

    CDS.Close;
    DataSet.Close;
    DataSet.Open;

    CDS.Open;
  end
 else
  begin
    ChecaArquivo;
    CDS.LoadFromFile(Arquivo);
  end;
  Result:= not Cds.IsEmpty;
  DoAfterCarrega;
end;

procedure TDadosModeloBase.Adicionar;
begin
  CDS.Insert;
end;

procedure TDadosModeloBase.Editar;
begin
  CDS.Edit;
end;

procedure TDadosModeloBase.Deletar;
begin
  CDS.Delete;
  ChecaAutoApply;
end;

procedure TDadosModeloBase.Cancelar;
begin
  CDS.Cancel;
end;

procedure TDadosModeloBase.Confirmar;
begin
  CDS.Post;
  ChecaAutoApply;
end;

procedure TDadosModeloBase.DataModuleCreate(Sender: TObject);
begin
  inherited;
  fIsDBConnection:= True;
  fAutoApplyUpdates:= True;
  fFormato:= dfXml;
  Arquivo:= '';
  fSQL:= '';
end;

end.
