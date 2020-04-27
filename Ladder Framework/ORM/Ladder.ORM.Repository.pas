unit Ladder.ORM.Repository;

interface

uses
  SysUtils, Ladder.ORM.ModeloBD, Ladder.ORM.Classes, Ladder.ORM.Dao, System.Generics.Collections;

type
  TTipoAcaoRepositorio = (taInsert, taUpdate, taDelete);

  TAoManipularObjetoEvent = reference to procedure (Objeto: TObject; Acao: TTipoAcaoRepositorio);

  // Repository Pattern: Além de ser uma collection age como um mediador entre a camada de negócios e a camada de persistência,
  //                      com uma interface padrão e desacoplada - O modelo não precisa saber como e quando salvar os itens do Repositório, apenas chama a interface padrão com Insert, Delete e Update para manipular os itens do repositório.
  //                      Facilita testes unitários e diminui a complexidade no Model
  IFrwRepository<T: Class> = interface (IFrwObjectList<T>)
    function LoadByID(const pID: FrwID): T;
    function FindByID(const pID: FrwID): T;

    function GetDao: IDaoGeneric<T>;

    function GetDeveSalvarObjetos: Boolean;
    procedure SetDeveSalvarObjetos(const Value: Boolean);

    function GetAntesDeManipularObjeto: TAoManipularObjetoEvent;
    procedure SetAntesDeManipularObjeto(Value: TAoManipularObjetoEvent);

    function GetAposManipularObjeto: TAoManipularObjetoEvent;
    procedure SetAposManipularObjeto(Value: TAoManipularObjetoEvent);

    function GetIsLoaded: Boolean;
    procedure SetIsLoaded(const Value: Boolean);

   // <summary> Insert or update item </summary>
    procedure Save(Value: T);

    procedure Insert(Value: T);
    procedure Delete(Value: T);
    procedure Update(Value: T);

    function GetKeyValue(Value: T): Integer;

   // <summary> Limpa os itens do Repositório (se houver) e seta o repositório para alteração </summary>
    procedure LoadEmpty;

   // <summary> Quando é falso, nenhuma ação da Dao é feita, ou seja, não persiste o objeto no banco de dados </summary>
    property DeveSalvarObjetos: Boolean read GetDeveSalvarObjetos write SetDeveSalvarObjetos;

   // <summary> Evento disparado antes de ser feito Insert, Update ou Delete </summary>
    property AntesDeManipularObjeto: TAoManipularObjetoEvent read GetAntesDeManipularObjeto write SetAntesDeManipularObjeto;
   // <summary> Evento disparado após ser feito Insert, Update ou Delete </summary>
    property AposManipularObjeto: TAoManipularObjetoEvent read GetAposManipularObjeto write SetAposManipularObjeto;

    property IsLoaded: Boolean read GetIsLoaded write SetIsLoaded;

    property Dao: IDaoGeneric<T> read GetDao;
  end;

  TFrwRepository<T: Class> = class (TFrwObjectList<T>, IFrwRepository<T>)
  private
    FIsLoaded: Boolean;
    FDeveSalvarObjetos: Boolean;
    FCurrentObject: T;

    FDao: IDaoGeneric<T>;

    FAntesDeManipularObjeto: TAoManipularObjetoEvent;
    FAposManipularObjeto: TAoManipularObjetoEvent;
    FChaveIncremental: Boolean;

    procedure CheckContainsValue(Value: T);
    procedure CheckRepositoryIsLoaded;
    procedure SetKeyValue(pKeyValue: Integer; pObject: T);
    procedure SetChaveIncremental(const Value: Boolean);
    function GetModeloBD: TModeloBD;
  protected
    IsLoading: Boolean;

    function GetIsLoaded: Boolean;
    procedure SetIsLoaded(const Value: Boolean);

    function GetDeveSalvarObjetos: Boolean;
    procedure SetDeveSalvarObjetos(const Value: Boolean);

    function GetAntesDeManipularObjeto: TAoManipularObjetoEvent;
    procedure SetAntesDeManipularObjeto(Value: TAoManipularObjetoEvent);

    function GetAposManipularObjeto: TAoManipularObjetoEvent;
    procedure SetAposManipularObjeto(Value: TAoManipularObjetoEvent);

    procedure OnLoadObject(Value: TObject); virtual;

    function GetDao: IDaoGeneric<T>;
  public
    constructor Create(pDao: IDaoGeneric<T>); overload;
    constructor Create(const pNomeTable, pCampoChave: String); overload;

    function LoadByID(const pID: FrwID): T;
    function FindByID(const pID: FrwID): T;
    procedure LoadAll;
    procedure LoadWhere(const pSqlWhere: String);

    property IsLoaded: Boolean read GetIsLoaded write SetIsLoaded;

    procedure LoadEmpty;

    function Add(const Value: T): Integer; override;

    function GetKeyValue(Value: T): Integer;

    procedure Save(Value: T); // Insert or update value

    procedure Insert(Value: T); reintroduce;
    procedure Update(Value: T);
    procedure Delete(Value: T);

    property DeveSalvarObjetos: Boolean read GetDeveSalvarObjetos write SetDeveSalvarObjetos;

    property AntesDeManipularObjeto: TAoManipularObjetoEvent read GetAntesDeManipularObjeto write SetAntesDeManipularObjeto;
    property AposManipularObjeto: TAoManipularObjetoEvent read GetAposManipularObjeto write SetAposManipularObjeto;
    property ChaveIncremental: Boolean read FChaveIncremental write SetChaveIncremental;

    property Dao: IDaoGeneric<T> read GetDao;
    property ModeloBD: TModeloBD read GetModeloBD;
    property CurrentObject: T read FCurrentObject;
  end;

implementation

{ TFrwRepository<T> }

constructor TFrwRepository<T>.Create(pDao: IDaoGeneric<T>);
begin
  FDao:= pDao;

  IsLoading:= False;

  FIsLoaded:= False;

  FDeveSalvarObjetos:= True;

  // Se não for passada uma Dao como parâmetro então é implementada uma Dao que não faz nada, sem persistência;
{  if not Assigned(FDao) then
  begin
    FDao:= TNullDao<T>.Create;
    FIsLoaded:= True;
  end;                       }

  inherited Create;
end;

procedure TFrwRepository<T>.CheckRepositoryIsLoaded;
begin
  if not FIsLoaded then
    raise Exception.Create('Repository is not loaded! Call TFrwRepository.LoadEmpty to setup an empty repository.');
end;

constructor TFrwRepository<T>.Create(const pNomeTable, pCampoChave: String);
begin
  Create(TDaoGeneric<T>.Create(pNomeTable, pCampoChave));
end;

procedure TFrwRepository<T>.OnLoadObject(Value: TObject);
begin
  // Para ser implementado nos descendentes;
end;

procedure TFrwRepository<T>.Save(Value: T);
begin
  if Contains(Value) then
    Update(Value)
  else if Dao.KeyExists(GetKeyValue(Value)) then
    Update(Value)
  else
    Insert(Value);
end;

procedure TFrwRepository<T>.SetAntesDeManipularObjeto(
  Value: TAoManipularObjetoEvent);
begin
  FAntesDeManipularObjeto:= value;
end;

procedure TFrwRepository<T>.SetAposManipularObjeto(
  Value: TAoManipularObjetoEvent);
begin
  FAposManipularObjeto:= Value;
end;

procedure TFrwRepository<T>.SetChaveIncremental(const Value: Boolean);
begin
  FChaveIncremental := Value;
  Dao.ModeloBD.ChaveIncremental:= FChaveIncremental;
end;

procedure TFrwRepository<T>.SetDeveSalvarObjetos(const Value: Boolean);
begin
  FDeveSalvarObjetos:= Value;
end;

procedure TFrwRepository<T>.SetIsLoaded(const Value: Boolean);
begin
  FIsLoaded:= Value;
end;

procedure TFrwRepository<T>.SetKeyValue(pKeyValue: Integer; pObject: T);
begin

end;

function TFrwRepository<T>.Add(const Value: T): Integer;
begin
  if Self.Contains(Value) then
    raise Exception.Create('Object is already in repository! Can''t add it again.');

  if IsLoading then
    OnLoadObject(Value);

  Result:= inherited Add(Value);
end;

procedure TFrwRepository<T>.CheckContainsValue(Value: T);
begin
  if not Self.Contains(Value) then
    raise Exception.Create('Objeto não existe no repositório!');
end;

function TFrwRepository<T>.FindByID(const pID: FrwID): T;
var
  fItem: T;
begin
  for fItem in Self do
   if GetKeyValue(FItem) = pID then
   begin
     Result:= fItem;
     Exit;
   end;

  Result:= nil;
end;

function TFrwRepository<T>.GetAntesDeManipularObjeto: TAoManipularObjetoEvent;
begin
  Result:= FAntesDeManipularObjeto;
end;

function TFrwRepository<T>.GetAposManipularObjeto: TAoManipularObjetoEvent;
begin
  Result:= FAposManipularObjeto;
end;

function TFrwRepository<T>.GetDao: IDaoGeneric<T>;
begin
  Result:= FDao
end;

function TFrwRepository<T>.GetDeveSalvarObjetos: Boolean;
begin
  Result:= FDeveSalvarObjetos;
end;

function TFrwRepository<T>.GetIsLoaded: Boolean;
begin
  Result:= FIsLoaded;
end;

function TFrwRepository<T>.GetKeyValue(Value: T): Integer;
begin
  Result:= Dao.ModeloBD.GetKeyValue(Value);
end;

function TFrwRepository<T>.GetModeloBD: TModeloBD;
begin
  Result:= Dao.ModeloBD;
end;

procedure TFrwRepository<T>.Insert(Value: T);
begin
  CheckRepositoryIsLoaded;

  if Contains(Value) then
    raise Exception.Create('Este objeto já existe na lista, não pode ser adicionado novamente!');

  FCurrentObject:= Value;

  if Assigned(FAntesDeManipularObjeto) then FAntesDeManipularObjeto(Value, taInsert);

  if DeveSalvarObjetos then
    Dao.Insert(Value);

  Add(Value);

  if Assigned(FAposManipularObjeto) then FAposManipularObjeto(Value, taInsert);
end;

procedure TFrwRepository<T>.Update(Value: T);
begin
  CheckRepositoryIsLoaded;
  CheckContainsValue(Value);
  FCurrentObject:= Value;

  if Assigned(FAntesDeManipularObjeto) then FAntesDeManipularObjeto(Value, taUpdate);

  if DeveSalvarObjetos then
    if not Dao.Update(Value) then
      raise Exception.Create(Format('TFrwRepository<T>.Update: Value was not updated. Key %d not found on database', [Self.GetKeyValue(Value)]));

  if Assigned(FAposManipularObjeto) then FAposManipularObjeto(Value, taUpdate);
end;

procedure TFrwRepository<T>.Delete(Value: T);
var
  FInRepository: Boolean;
begin
  CheckRepositoryIsLoaded;
//  CheckContainsValue(Value);
  try
    FCurrentObject:= Value;
    if Assigned(FAntesDeManipularObjeto) then FAntesDeManipularObjeto(Value, taDelete);

    if DeveSalvarObjetos then
      Dao.Delete(Value);

    if Self.Contains(Value) then
      Remove(Value);

    if Self.OwnsObjects then
      Value:= nil;

    if Assigned(FAposManipularObjeto) then FAposManipularObjeto(Value, taDelete);
  finally
    FCurrentObject:= nil;
  end;
end;

procedure TFrwRepository<T>.LoadAll;
begin
  LoadWhere('');
end;

function TFrwRepository<T>.LoadByID(const pID: FrwID): T;
begin
  LoadWhere(Dao.ModeloBD.NomeCampoChave+' = '+IntToStr(pID));
  Result:= FindByID(pID);
end;

procedure TFrwRepository<T>.LoadEmpty;
begin
  // Limpa os dados do Repositório se houver
  Clear;

  FIsLoaded:= True;
end;

procedure TFrwRepository<T>.LoadWhere(const pSqlWhere: String);
begin
  Clear;
  IsLoading:= True;
  try
    Dao.SelectWhere(Self, pSqlWhere);
    FIsLoaded:= True;
  finally
    IsLoading:= False;
  end;
end;

end.
