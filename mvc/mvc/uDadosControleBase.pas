unit uDadosControleBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uControleBase, DB, uMVCInterfaces, uModeloBase, uDadosModeloBase,
  DBClient;

type
  TNotificaAcaoEvent = procedure (var CancelaAcao: Boolean) of object;
  TAfterAcaoEvent = procedure of object;

  TDadosControleBase = class(TControleBase, IDadosControleBase, IConexaoBase, IConexaoArquivo)
    DataSource: TDataSource;
    procedure DataSourceStateChange(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataModuleCreate(Sender: TObject);
  private
//    FConexao: TConexaoBase;
//    FConexaoArqXml: TConexaoArquivo;
    fPermissoes: TPermissoes;
    fPodeNavegar, fDesabilitaUpdatesView: Boolean;
    fBeforeInsere, FBeforeEdit, fBeforeDelet, FBeforeCancel, fBeforeConfirm, FBeforeCarrega: TNotificaAcaoEvent;
    fAfterInsere, FAfterEdit, fAfterDelet, FAfterCancel, fAfterConfirm: TAfterAcaoEvent;
    procedure SetDesabilitaUpdatesView(const Value: Boolean);
  protected
    procedure ChecaModelo;
    function GetPermissoes: TPermissoes;
    procedure DoAfterMudaModelo; virtual;
    function GetCDS: TClientDataSet;
    property CDS: TClientDataSet read GetCDS;
    function GetDadosModelo: TDadosModeloBase; virtual;
    procedure SetDadosModelo(Value: TDadosModeloBase); virtual;
    procedure DoBeforeInsere(var CancelaAcao: Boolean); virtual;
    procedure DoBeforeEdit(var CancelaAcao: Boolean); virtual;
    procedure DoBeforeDelet(var CancelaAcao: Boolean); virtual;
    procedure DoBeforeCancel(var CancelaAcao: Boolean); virtual;
    procedure DoBeforeConfirm(var CancelaAcao: Boolean); virtual;
    procedure DoBeforeCarrega(var CancelaAcao: Boolean); virtual;
    procedure DoAfterInsere; virtual;
    procedure DoAfterEdit; virtual;
    procedure DoAfterCancel; virtual;
    procedure DoAfterDelet; virtual;
    procedure DoAfterConfirm; virtual;

    procedure ErroNavegacao; virtual;
    procedure ErroPermissao(Acao: TPermissao); virtual;
    function VerificaPermissao(Acao: TPermissao): Boolean; virtual;
    
    function GetDadosView: IDadosView;
    procedure DoSetModelo; override;
    property DesabilitaUpdatesView: Boolean read FDesabilitaUpdatesView write SetDesabilitaUpdatesView;
  public
    function IsEmpty: Boolean;
    procedure SetArquivo(Value: String);
    function GetArquivo: String;
    property Arquivo: String read GetArquivo write SetArquivo;
//    property ConexaoArquivo: TConexaoArquivo read GetConexaoArquivo write FConexaoArqXml;
    function GetFormato: TDataPacketFormat;
    procedure SetFormato(Value: TDataPacketFormat);

    function GetDataSource: TDataSource;

    function Carregar: Boolean; virtual;
    function Salvar: Boolean; virtual;

    function BtnNovoClick: Boolean; virtual;
    function BtnAddClick: Boolean; virtual;
    function BtnEditClick: Boolean; virtual;
    function BtnCancelClick: Boolean; virtual;
    function BtnConfirmClick: Boolean; virtual;
    function BtnDeletClick: Boolean; virtual;

    function PodeNavegar: Boolean;
    procedure SetPodeNavegar(Value: Boolean);
    property Permissoes: TPermissoes read GetPermissoes write fPermissoes;
    property DadosModelo: TDadosModeloBase read GetDadosModelo write SetDadosModelo;
    property DadosView: IDadosView read GetDadosView;
    property Formato: TDataPacketFormat read GetFormato write SetFormato;
  published
    property BeforeCarrega: TNotificaAcaoEvent read fBeforeCarrega write fBeforeCarrega;
    property BeforeInsere: TNotificaAcaoEvent read fBeforeInsere write fBeforeInsere;
    property BeforeEdit: TNotificaAcaoEvent read fBeforeEdit write fBeforeEdit;
    property BeforeDelet: TNotificaAcaoEvent read fBeforeDelet write fBeforeDelet;
    property BeforeCancel: TNotificaAcaoEvent read fBeforeCancel write fBeforeCancel;
    property BeforeConfirm: TNotificaAcaoEvent read fBeforeConfirm write fBeforeConfirm;
    property AfterInsere: TAfterAcaoEvent read FAfterInsere write FAfterInsere;
    property AfterEdit: TAfterAcaoEvent read fAfterEdit write fAfterEdit;
    property AfterDelet: TAfterAcaoEvent read fAfterDelet write fAfterDelet;
    property AfterCancel: TAfterAcaoEvent read fAfterCancel write fAfterCancel;
    property AfterConfirm: TAfterAcaoEvent read fAfterConfirm write fAfterConfirm;
  end;

implementation

{$R *.dfm}

//function TDadosControleBase.GetConexaoArquivo: TConexaoArquivo;
//begin
//  if not (DadosModelo.Conexao is TConexaoArquivo) then
//    raise Exception.Create('Erro: Objeto de conexão não é TConexaoArquivo!');
//
//  Result:= (DadosModelo.Conexao as TConexaoArquivo);
//end;

function TDadosControleBase.PodeNavegar: Boolean;
begin
  Result:= fPodeNavegar;
end;

procedure TDadosControleBase.SetPodeNavegar(Value: Boolean);
begin
  fPodeNavegar:= Value;
end;

function TDadosControleBase.GetPermissoes: TPermissoes;
begin
  Result:= fPermissoes;
end;

procedure TDadosControleBase.ErroNavegacao;
begin
  raise Exception.Create('Usuário não tem permissão para navegar entre registros!');
end;

procedure TDadosControleBase.ErroPermissao(Acao: TPermissao);
var
  sAcao: String;
begin
  case Acao of
    Inserir: sAcao:= 'Inserir';
    Editar: sAcao:= 'Editar';
    Excluir: sAcao:= 'Excluir';
    Consultar: sAcao:= 'Consultar';
  end;
  raise Exception.Create('Usuário não tem permissão para '+sAcao+'!');
end;

function TDadosControleBase.VerificaPermissao(Acao: TPermissao): Boolean;
begin
  if not (Acao in Permissoes) then
  begin
    Result:= False;
    ErroPermissao(Acao);
  end else
    Result:= True;
end;

procedure TDadosControleBase.DoBeforeCarrega(var CancelaAcao: Boolean); 
begin
  CancelaAcao:= not VerificaPermissao(Consultar);
  if not PodeNavegar then
    if not IsEmpty then
    begin
      CancelaAcao:= False;
      ErroNavegacao;
    end;  

  if Assigned(FBeforeCarrega) then
    FBeforeCarrega(CancelaAcao);
end;

procedure TDadosControleBase.DoBeforeInsere(var CancelaAcao: Boolean);
begin
  CancelaAcao:= not VerificaPermissao(Inserir);
  if Assigned(FBeforeInsere) then
    FBeforeInsere(CancelaAcao);
end;

procedure TDadosControleBase.DoBeforeEdit(var CancelaAcao: Boolean);
begin
  CancelaAcao:= not VerificaPermissao(Editar);
  if Assigned(FBeforeEdit) then
    FBeforeEdit(CancelaAcao);
end;

procedure TDadosControleBase.DoBeforeDelet(var CancelaAcao: Boolean);
begin
  CancelaAcao:= not VerificaPermissao(Excluir);
  if Assigned(FBeforeDelet) then
    FBeforeDelet(CancelaAcao);
end;

procedure TDadosControleBase.DoBeforeCancel(var CancelaAcao: Boolean);
begin
  CancelaAcao:= False;
  if Assigned(FBeforeCancel) then
    FBeforeCancel(CancelaAcao);
end;

procedure TDadosControleBase.DoBeforeConfirm(var CancelaAcao: Boolean);
begin
  CancelaAcao:= False;
  if Assigned(FBeforeConfirm) then
    FBeforeConfirm(CancelaAcao);
end;

procedure TDadosControleBase.DoAfterInsere;
begin
  if Assigned(FAfterInsere) then
    FAfterInsere;
end;

procedure TDadosControleBase.DoAfterEdit;
begin
  if Assigned(FAfterEdit) then
    FAfterEdit;
end;

procedure TDadosControleBase.DoAfterDelet;
begin
  if Assigned(FAfterDelet) then
    FAfterDelet;
end;

procedure TDadosControleBase.DoAfterCancel;
begin
  if Assigned(FAfterCancel) then
    FAfterCancel;
end;

procedure TDadosControleBase.DoAfterConfirm;
begin
  if Assigned(FAfterConfirm) then
    FAfterConfirm;
end;

procedure TDadosControleBase.ChecaModelo;
begin
  if not Assigned(DadosModelo) then
    raise Exception.Create('Não há modelo definido!');
end;

procedure TDadosControleBase.SetArquivo(Value: String);
begin
  ChecaModelo;
  DadosModelo.Arquivo:= Value;
end;

function TDadosControleBase.GetArquivo: String;
begin
  ChecaModelo;
  Result:= DadosModelo.Arquivo;
end;

procedure TDadosControleBase.SetFormato(Value: TDataPacketFormat);
begin
  ChecaModelo;
  DadosModelo.Formato:= Value;
end;

function TDadosControleBase.GetFormato: TDataPacketFormat;
begin
  ChecaModelo;
  Result:= DadosModelo.Formato;
end;

function TDadosControleBase.IsEmpty: Boolean;
begin
  Result:= True;
  if not Assigned(DadosModelo) then Exit;

  if Cds.Active then  
    Result:= CDS.RecordCount = 0;
end;

function TDadosControleBase.BtnNovoClick: Boolean;
begin
  ChecaModelo;

  CDS.Close;
  
  if DadosModelo.IsDBConnection then
    CDS.Open
  else
    CDS.CreateDataSet;

  Result:= True;
end;

function TDadosControleBase.Carregar: Boolean;
begin
  ChecaModelo;
  DesabilitaUpdatesView:= True;
  try
    Result:= DadosModelo.Carregar;
  finally
    DesabilitaUpdatesView:= False;
  end;
end;

function TDadosControleBase.Salvar: Boolean;
begin
  ChecaModelo;
  Result:= DadosModelo.Salvar;
  DoAfterConfirm;
end;

//function TDadosControleBase.GetEstado;
//begin
//  Result:= CDS.State;
//end;

function TDadosControleBase.GetCDS: TClientDataSet;
begin
  ChecaModelo;
  Result:= DadosModelo.CDS;
end;

function TDadosControleBase.GetDadosView: IDadosView;
begin
  Result:= (View as IDadosView);
end;

function TDadosControleBase.GetDataSource: TDataSource;
begin
  Result:= DataSource;
end;
      {
procedure TDadosControleBase.SetDadosView(Value: IDadosView);
begin
  View:= Value;
//  DataSourceStateChange(Self);
end;}

procedure TDadosControleBase.DoAfterMudaModelo;
begin
  //Esta função é implementada por decendentes
end;

procedure TDadosControleBase.DoSetModelo;
begin
  DataSource.DataSet:= CDS;
  inherited;
end;

procedure TDadosControleBase.SetDadosModelo(Value: TDadosModeloBase);
begin
  Modelo:= Value;
end;

procedure TDadosControleBase.SetDesabilitaUpdatesView(const Value: Boolean);
begin
  FDesabilitaUpdatesView := Value;
  if not FDesabilitaUpdatesView then
    DataSourceStateChange(Self);
end;

function TDadosControleBase.GetDadosModelo: TDadosModeloBase;
begin
  Result:= (Modelo as TDadosModeloBase);
end;

function TDadosControleBase.BtnAddClick: Boolean;
var
  Cancela: Boolean;
begin
  ChecaModelo;
  DoBeforeInsere(Cancela);
  Result:= not Cancela;
  if Cancela then Exit;
  DadosModelo.Adicionar;
  DoAfterInsere;
end;

function TDadosControleBase.BtnEditClick: Boolean;
var
  Cancela: Boolean;
begin
  ChecaModelo;
  DoBeforeEdit(Cancela);
  Result:= not Cancela;
  if Cancela then Exit;
  DadosModelo.Editar;
  DoAfterEdit;
end;

function TDadosControleBase.BtnDeletClick: Boolean;
var
  Cancela: Boolean;
begin
  ChecaModelo;
  DoBeforeDelet(Cancela);
  Result:= not Cancela;
  if Cancela then Exit;
  DadosModelo.Deletar;
  DoAfterDelet;
end;

function TDadosControleBase.BtnCancelClick: Boolean;
var
  Cancela: Boolean;
begin
  ChecaModelo;
  DoBeforeCancel(Cancela);
  Result:= not Cancela;
  if Cancela then Exit;
  DadosModelo.Cancelar;
  DoAfterCancel;
end;

function TDadosControleBase.BtnConfirmClick: Boolean;
var
  Cancela: Boolean;
begin
  ChecaModelo;
  DoBeforeConfirm(Cancela);
  Result:= not Cancela;
  if Cancela then Exit;
  DadosModelo.Confirmar;
  DoAfterConfirm;
end;

procedure TDadosControleBase.DataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  if Assigned(DadosView) then
    DadosView.DataChange;
end;

procedure TDadosControleBase.DataSourceStateChange(Sender: TObject);
begin
  if (not Assigned(DadosView)) or (DesabilitaUpdatesView) then Exit;

  case Cds.State of
    dsInactive: DadosView.Estado:= vInativo;
    dsEdit: DadosView.Estado:= vEditando;
    dsInsert: DadosView.Estado:= vInserindo;
  else
    DadosView.Estado:= vAtivo;
  end;
end;

procedure TDadosControleBase.DataModuleCreate(Sender: TObject);
begin
  inherited;
  fPermissoes:= ([Inserir, Editar, Excluir, Consultar]);
  fPodeNavegar:= True;
  fDesabilitaUpdatesView:= False;
end;

end.
