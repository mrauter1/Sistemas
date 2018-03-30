unit uCadModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDadosModeloBase, Provider, DB, DBClient, uFuncoesSQL,
  DBCtrls;



type
  TCadModelo = Class;

  TCarregaDetalheEvent = procedure (Modelo: TCadModelo) of object;

{  TMasterDetail = class(TObject)
    MasterField: TField;
    DetailField: TField;
    ModeloDetalhe: TCadModelo;
    FOnChange: TFieldNotifyEvent;
  end;      }

  TMasterDetailLink = class(TFieldDataLink)
  private
    FModeloMaster, FModeloDetalhe: TCadModelo;
    FDetailField, FMasterField: TField;
    FOnCarregaDetalhe: TCarregaDetalheEvent;
    FCarregaOnCalc: Boolean;
    function GetMasterField: TField;
    procedure SetMasterField(Value: TField);
    procedure SetModeloDetalhe(Modelo: TCadModelo);
  protected
    procedure MasterFieldChange(Sender: TField; Refresh: Boolean = false);
  public
    constructor Create(Modelo: TCadModelo);
    property ModeloMaster: TCadModelo read FModeloMaster write FModeloMaster;
    property ModeloDetalhe: TCadModelo read FModeloDetalhe write SetModeloDetalhe;
    property DetailField: TField read FDetailField write FDetailField;
    property MasterField: TField read GetMasterField write SetMasterField;
    property OnCarregaDetalhe: TCarregaDetalheEvent read FOnCarregaDetalhe write FOnCarregaDetalhe;
    property CarregaOnCalc: Boolean read FCarregaOnCalc write FCarregaOnCalc;
    procedure RecordChanged(Field: TField); override;
  end;

  TMasterDetailList = class(TObject)
  private
    fList: TList;
  protected
    function GetCount: Integer;
    function GetMasterDetail(Index: Integer): TMasterDetailLink;
    procedure SetMasterDetail(Index: Integer; Value: TMasterDetailLink);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(MasterDetail: TMasterDetailLink);
    procedure Remove(MasterDetail: TMasterDetailLink);
    procedure Clear;
    property Count: Integer read GetCount;
    property MasterDetailList[Index: Integer]: TMasterDetailLink read GetMasterDetail write SetMasterDetail; default;
  end;

  TCadModelo = class(TDadosModeloBase)
    DataSource: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSBeforePost(DataSet: TDataSet);
    procedure CDSAfterInsert(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CDSCalcFields(DataSet: TDataSet);
  private
    fMasterLink: TMasterDetailLink;
    fMasterDetails: TMasterDetailList;
    fCarregaDetailsOnCalc: Boolean;
    FIndice, FChaveUnica, FNomeTabela: String;
    FFiltroPrincipal, FFiltroAdicional: String;
    FAutoAddPKParam, fAutoGeraIndice: Boolean;
    procedure SetAutoAddPKParam(const Value: Boolean);
    procedure ConectaModelosDetalhe;
    function GetMestre: TCadModelo;
  protected
    procedure CarregaOnCalcModelosDetalhe;
    procedure DoAfterConecta; override;
    procedure OnCarregaDetalhe(Modelo: TCadModelo); virtual;
    procedure RefreshModelosDetalhe; virtual;

    procedure AtualizaSQL; virtual;
    function GetPKParam: String; virtual;
    function FindChaveUnica: String; virtual;
    procedure AddFiltro(sFiltro: String);
    procedure VerificaChaveUnica; virtual;
    procedure ValidaRegistro; virtual;
    procedure SetFiltroPrincipal(Value: String);
    procedure SetFiltroAdicional(Value: String);
    procedure SetNomeTabela(Value: String);
    procedure DoOnGeraIndice(var NovaChave: Variant);

    //Quando carrega oncalc for true, as tabelas detalhes serão carregadas no event oncalcfields do cds
    //assim campos que dependem da tabela detalhe podem ser calculado no OnCalcFields
    function RelacionaModelos(MasterField, DetailField: TField; ModeloDetalhe: TCadModelo; CarregaOnCalc: Boolean = false): TMasterDetailLink;

    //quando o modelo for detalhe MasterLink aponta para as definições TMasterDetailLink criadas pelo modelo mestre
    property MasterLink: TMasterDetailLink read fMasterLink write fMasterLink;
    property Mestre: TCadModelo read GetMestre;
    property AutoGeraIndice: Boolean read fAutoGeraIndice write fAutoGeraIndice;
    property FiltroPrincipal: String read FFiltroPrincipal write SetFiltroPrincipal;
    property NomeTabela: String read FNomeTabela write SetNomeTabela;
    property Indice: String read FIndice write FIndice;
    property ChaveUnica: String read FChaveUnica write FChaveUnica;
  public
    property AutoAddPKParam: Boolean read FAutoAddPKParam write SetAutoAddPKParam;
    property FiltroAdicional: String read FFiltroAdicional write SetFiltroAdicional;
    function CarregaVazio: Boolean; virtual;
    function CarregarCad(ParamPK: variant): Boolean; virtual;
    function AdicionarCad(ParamPK: variant): Boolean; virtual;
  end;

var
  CadModelo: TCadModelo;

implementation

{$R *.dfm}

{ TCadModelo }
            {
procedure TCadModelo.MasterFieldChange(Sender: TField);
var
  I: Integer;
  vOnChange: TFieldNotifyEvent;
begin
  vOnChange:= nil;
  for i := 0 to fMasterDetails.Count - 1 do
  begin
    with fMasterDetails[i] do
    begin
      if MasterField = Sender then
      begin
        ModeloDetalhe.CarregarCad(MasterField.AsVariant);

      //vOnChange Guarda o evento FOnCHange para ser disparado após
      //carregar todos os detalhes
        vOnChange:= FOnChange;
      end;
    end;
  end;
  if Assigned(vOnChange) then vOnChange(Sender);
  
end;      }

procedure TCadModelo.RefreshModelosDetalhe;
var
  I: Integer;
begin
  for i := 0 to fMasterDetails.Count - 1 do
    fMasterDetails[i].MasterFieldChange(fMasterDetails[i].MasterField, True);
end;

procedure TCadModelo.CarregaOnCalcModelosDetalhe;
var
  I: Integer;
begin
  for i := 0 to fMasterDetails.Count - 1 do
    if fMasterDetails[i].FCarregaOnCalc then
      fMasterDetails[i].MasterFieldChange(fMasterDetails[i].MasterField);
end;

function TCadModelo.RelacionaModelos(MasterField, DetailField: TField; ModeloDetalhe: TCadModelo; CarregaOnCalc: Boolean = false): TMasterDetailLink;
var
  fLink: TMasterDetailLink;
begin

  fLink:= TMasterDetailLink.Create(Self);
  fLink.ModeloMaster:= Self;
  fLink.ModeloDetalhe:= ModeloDetalhe;
  fLink.MasterField:= MasterField;
  fLink.DetailField:= DetailField;
  fLink.OnCarregaDetalhe:= OnCarregaDetalhe;
  fLink.CarregaOnCalc:= CarregaOnCalc;
  fLink.DataSource:= DataSource;

  if CarregaOnCalc then
    fCarregaDetailsOnCalc:= True;

  ModeloDetalhe.MasterLink:= fLink;

  fMasterDetails.Add(fLink);

  ModeloDetalhe.AutoAddPKParam:= False;
  ModeloDetalhe.AddFiltro(DetailField.FieldName+' =:'+DetailField.FieldName);
  Result:= fLink;
end;

procedure TCadModelo.ConectaModelosDetalhe;
var
  I: Integer;
begin
  for i := 0 to fMasterDetails.Count - 1 do
    fMasterDetails[i].ModeloDetalhe.Conexao:= Conexao;
end;

procedure TCadModelo.DoAfterConecta;
begin
  inherited;
  ConectaModelosDetalhe;
end;

function TCadModelo.AdicionarCad(ParamPK: Variant): Boolean;
var
  TempGeraChave: Boolean;
begin
  TempGeraChave:= fAutoGeraIndice;
  fAutoGeraIndice:= False;
  Adicionar;
  Cds.FieldByName(Indice).AsVariant:= ParamPK;
  fAutoGeraIndice:= TempGeraChave;
  Result:= True;
end;

function TCadModelo.CarregaVazio: Boolean;
var
  sqlTemp: String;
begin
  sqlTemp:= SQL;
  Sql:= 'select * from '+ NomeTabela+' where 0 = 1';
  Result:= Carregar;
  sql:= SqlTemp;
end;

function TCadModelo.CarregarCad(ParamPK: variant): Boolean;
begin
  if VarIsNull(ParamPK) then
  begin
    Result:= CarregaVazio;
    Exit;
  end;

  if Params.Count = 0 then
    raise Exception.Create('Não há parametro definido! Defina a chave primária no ClientDataSet: '+Self.Name
      +' setando providerflags.pfInKey para true no field ou defina a propriedade PrimaryKey!');
     
  Params.ParamValues[Params[0].Name]:= ParamPK;
  Result:= Carregar;
end;

procedure TCadModelo.DoOnGeraIndice(var NovaChave: variant);
begin
  //
end;

procedure TCadModelo.CDSAfterInsert(DataSet: TDataSet);
var
  NovaChave: variant;
begin
  inherited;
  if fAutoGeraIndice then
  begin
    NovaChave:= FuncoesSQL.GeraChavePrimaria(Indice, NomeTabela);
    DoOnGeraIndice(NovaChave);
    CDS.FieldByName(Indice).AsVariant:= NovaChave;
  end;
end;

procedure TCadModelo.CDSBeforePost(DataSet: TDataSet);
begin
  inherited;
  ValidaRegistro;
end;

procedure TCadModelo.CDSCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FCarregaDetailsOnCalc then
    CarregaOnCalcModelosDetalhe;
end;

procedure TCadModelo.DataModuleCreate(Sender: TObject);
begin
  inherited;
  fMasterDetails:= TMasterDetailList.Create;
  FChaveUnica:= FindChaveUnica;
  FIndice:= GetPKParam;
  fAutoAddPKParam:= False;
  fAutoGeraIndice:= True;
  fCarregaDetailsOnCalc:= False;
  FFiltroPrincipal:= '';
  FFiltroAdicional:= '';
  fNomeTabela:= '';
//  fFuncoesSQL:= TFuncoesSQL.Create(Self);
end;

procedure TCadModelo.DataModuleDestroy(Sender: TObject);
begin
  FMasterDetails.Free;
  inherited;
end;

function TCadModelo.GetMestre: TCadModelo;
begin
  Result:= fMasterLink.ModeloMaster;
end;

function TCadModelo.GetPKParam: String;
var
  Pos: Integer;
begin
  Pos:= 1;
  if (FChaveUnica <> '') then
  begin
    Result:= ExtractFieldName(fChaveUnica, Pos);
  end;
end;

procedure TCadModelo.OnCarregaDetalhe(Modelo: TCadModelo);
begin
  //Implementado por decendentes
end;

function TCadModelo.FindChaveUnica: String;

  procedure AddChave(Chave: String);
  begin
    if Result = '' then
      Result:= Chave
    else Result:= Result+';'+Chave;
  end;

var
  i: Integer;
begin
  Result:= '';
  for I := 0 to CDS.Fields.Count - 1 do
  begin
    if pfInKey in CDS.Fields[I].ProviderFlags then
      AddChave(CDS.Fields[i].FieldName);
  end;
end;

procedure TCadModelo.SetAutoAddPKParam(const Value: Boolean);
begin
  FAutoAddPKParam := Value;
  AtualizaSQL;
end;

procedure TCadModelo.SetFiltroPrincipal(Value: String);
begin
  FFiltroPrincipal:= Value;
  AtualizaSQL;
end;

procedure TCadModelo.SetFiltroAdicional(Value: String);
begin
  FFiltroAdicional:= Value;
  AtualizaSQL;
end;

procedure TCadModelo.SetNomeTabela(Value: String);
begin
  fNomeTabela:= Value;
  AtualizaSQL;
end;

procedure TCadModelo.AddFiltro(sFiltro: String);
begin
  if FFiltroPrincipal = '' then
    FFiltroPrincipal:= sFiltro
  else FFiltroPrincipal:= FFiltroPrincipal+ ' and '+sFiltro;
  AtualizaSQL;
end;

procedure TCadModelo.AtualizaSQL;
  function GetFiltro: String;
  begin
    Result:= FFIltroPrincipal;
    if (Result <> '') and (FFiltroAdicional <> '') then
      Result:= Result+' and '+FFiltroAdicional
  else
    if FFiltroAdicional <> '' then
      Result:= FFiltroAdicional;
  end;

var
  tempSql, tempFiltro, strParam: string;
begin
  tempSql:= 'select * from '+ NomeTabela;

  if (fAutoAddPKParam) and (Indice <> '') then
    strParam:= Indice+' =:'+Indice
  else strParam:= '';

  TempFiltro:= GetFiltro;

  if (strParam <> '') and (TempFiltro <> '') then
    tempSql:= tempSql + ' where '+strParam+' and '+TempFiltro
  else if (strParam <> '') then
    tempSql:= tempSql+' where '+strParam
  else if (TempFiltro <> '') then
    tempSql:= tempSql+' where '+TempFiltro;

  Sql:= tempSql;
end;

procedure TCadModelo.ValidaRegistro;
begin
  VerificaChaveUnica;
end;

procedure TCadModelo.VerificaChaveUnica;
begin
  if ChaveUnica <> '' then
    if not FuncoesSQL.TestaChaveUnica(ChaveUnica, NomeTabela, CDS) then
      raise Exception.Create('Já existe um registro com esta chave cadastrado! Chave: '
        +ChaveUnica+'. Tabela: '+NomeTabela+'. Módulo: ' +Self.Name);
end;

{ TMasterDetailList }

constructor TMasterDetailList.Create;
begin
  inherited;
  FList:= TList.Create;
end;

destructor TMasterDetailList.Destroy;
begin
  if FList <> nil then Clear;
  FList.Free;
  inherited Destroy;
end;

procedure TMasterDetailList.Add(MasterDetail: TMasterDetailLink);
begin
  FList.Add(MasterDetail);
end;

procedure TMasterDetailList.Remove(MasterDetail: TMasterDetailLink);
begin
  FList.Remove(MasterDetail);
end;

procedure TMasterDetailList.Clear;
var
  F: TMasterDetailLink;
begin
  while FList.Count > 0 do
  begin
    F := FList.Last;
    F.Free;
    FList.Delete(FList.Count-1);
  end;
end;

function TMasterDetailList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TMasterDetailList.GetMasterDetail(Index: Integer): TMasterDetailLink;
begin
  Result := FList[Index];
end;

procedure TMasterDetailList.SetMasterDetail(Index: Integer;
  Value: TMasterDetailLink);
begin
  MasterDetailList[Index]:= Value;
end;

{ TMasterDetailLink }

constructor TMasterDetailLink.Create(Modelo: TCadModelo);
begin
  inherited Create;
  fModeloMaster:= Modelo;
  DataSource:= fModeloMaster.DataSource;
  FCarregaOnCalc:= False;
end;

procedure TMasterDetailLink.SetMasterField(Value: TField);
begin
  FMasterField:= Value;
  FieldName:= FMasterField.FieldName;
end;

procedure TMasterDetailLink.SetModeloDetalhe(Modelo: TCadModelo);
begin
  fModeloDetalhe:= Modelo;
  fModeloDetalhe.Conexao:= fModeloMaster.Conexao;
end;

procedure TMasterDetailLink.MasterFieldChange(Sender: TField; Refresh: Boolean = false);
var
  param: variant;
begin
  if MasterField = nil then
    param:= null
  else param:= MasterField .AsVariant;

  if Assigned(fModeloDetalhe) then
  begin

    if (param <> DetailField.AsVariant) or (Refresh) then
    begin
      fModeloDetalhe.CarregarCad(param);
      if Assigned(FOnCarregaDetalhe) then
        FOnCarregaDetalhe(fModeloDetalhe);
    end;
  end;
end;

procedure TMasterDetailLink.RecordChanged(Field: TField);
begin
  MasterFieldChange(Field);
end;

function TMasterDetailLink.GetMasterField: TField;
begin
  Result:= FMasterField;
end;

end.
