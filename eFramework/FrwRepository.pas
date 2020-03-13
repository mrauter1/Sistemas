unit FrwRepository;

interface

uses
  SysUtils, uFrwUtils, UntDaoFactory, System.Generics.Collections;

type
  TTipoAcaoRepositorio = (taInsert, taUpdate, taDelete);

  TAoManipularObjetoEvent = reference to procedure (Objeto: TObject; Acao: TTipoAcaoRepositorio);

  // Repository Pattern: Al�m de ser uma collection age como um mediador entre a camada de neg�cios e a camada de persist�ncia,
  //                      com uma interface padr�o e desacoplada - O modelo n�o precisa saber como e quando salvar os itens do Reposit�rio, apenas chama a interface padr�o com Insert, Delete e Update para manipular os itens do reposit�rio.
  //                      Facilita testes unit�rios e diminui a complexidade no Model
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

    procedure Insert(Value: T);
    procedure Delete(Value: T);
    procedure Update(Value: T);

   // <summary> Limpa os itens do Reposit�rio (se houver) e seta o reposit�rio para altera��o </summary>
    procedure LoadEmpty;

   // <summary> Quando � falso, nenhuma a��o da Dao � feita, ou seja, n�o persiste o objeto no banco de dados </summary>
    property DeveSalvarObjetos: Boolean read GetDeveSalvarObjetos write SetDeveSalvarObjetos;

   // <summary> Evento disparado antes de ser feito Insert, Update ou Delete </summary>
    property AntesDeManipularObjeto: TAoManipularObjetoEvent read GetAntesDeManipularObjeto write SetAntesDeManipularObjeto;
   // <summary> Evento disparado ap�s ser feito Insert, Update ou Delete </summary>
    property AposManipularObjeto: TAoManipularObjetoEvent read GetAposManipularObjeto write SetAposManipularObjeto;

    property IsLoaded: Boolean read GetIsLoaded write SetIsLoaded;

    property Dao: IDaoGeneric<T> read GetDao;
  end;

  TFrwRepository<T: Class> = class (TFrwObjectList<T>, IFrwRepository<T>)
  private
    FIsLoaded: Boolean;
    FDeveSalvarObjetos: Boolean;
    FDao: IDaoGeneric<T>;

    FAntesDeManipularObjeto: TAoManipularObjetoEvent;
    FAposManipularObjeto: TAoManipularObjetoEvent;

    procedure CheckContainsValue(Value: T);
    procedure CheckRepositoryIsLoaded;
  protected
    IsLoading: Boolean;

    procedure OnLoadObject(Value: TObject); virtual;

    function GetDao: IDaoGeneric<T>;
  public
    constructor Create(pDao: IDaoGeneric<T>);

    function LoadByID(const pID: FrwID): T;
    function FindByID(const pID: FrwID): T;
    procedure LoadAll;
    procedure LoadWhere(const pSqlWhere: String);

    function GetIsLoaded: Boolean;
    procedure SetIsLoaded(const Value: Boolean);

    property IsLoaded: Boolean read GetIsLoaded write SetIsLoaded;

    function GetDeveSalvarObjetos: Boolean;
    procedure SetDeveSalvarObjetos(const Value: Boolean);

    function GetAntesDeManipularObjeto: TAoManipularObjetoEvent;
    procedure SetAntesDeManipularObjeto(Value: TAoManipularObjetoEvent);

    function GetAposManipularObjeto: TAoManipularObjetoEvent;
    procedure SetAposManipularObjeto(Value: TAoManipularObjetoEvent);

    procedure LoadEmpty;

    function Add(const Value: T): Integer; override;

    procedure Insert(Value: T); reintroduce;
    procedure Delete(Value: T);
    procedure Update(Value: T);

    property DeveSalvarObjetos: Boolean read GetDeveSalvarObjetos write SetDeveSalvarObjetos;

    property AntesDeManipularObjeto: TAoManipularObjetoEvent read GetAntesDeManipularObjeto write SetAntesDeManipularObjeto;
    property AposManipularObjeto: TAoManipularObjetoEvent read GetAposManipularObjeto write SetAposManipularObjeto;

    property Dao: IDaoGeneric<T> read GetDao;
  end;

implementation

{ TFrwRepository<T> }

constructor TFrwRepository<T>.Create(pDao: IDaoGeneric<T>);
begin
  FDao:= pDao;

  IsLoading:= False;

  FIsLoaded:= False;

  FDeveSalvarObjetos:= True;

  // Se n�o for passada uma Dao como par�metro ent�o � implementada uma Dao que n�o faz nada, sem persist�ncia;
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
    raise Exception.Create('N�o � poss�vel realizar esta opera��o! Reposit�rio ainda n�o est� carregado.');
end;

procedure TFrwRepository<T>.OnLoadObject(Value: TObject);
begin
  // Para ser implementado nos descendentes;
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

procedure TFrwRepository<T>.SetDeveSalvarObjetos(const Value: Boolean);
begin
  FDeveSalvarObjetos:= Value;
end;

procedure TFrwRepository<T>.SetIsLoaded(const Value: Boolean);
begin
  FIsLoaded:= Value;
end;

function TFrwRepository<T>.Add(const Value: T): Integer;
begin
  if IsLoading then
    OnLoadObject(Value);

  inherited Add(Value);
end;

procedure TFrwRepository<T>.CheckContainsValue(Value: T);
begin
  if not Self.Contains(Value) then
    raise Exception.Create('Objeto n�o existe no reposit�rio!');
end;

function TFrwRepository<T>.FindByID(const pID: FrwID): T;
var
  fItem: T;
begin
  for fItem in Self do
   if Dao.ModeloBD.GetValorChave(fItem) = pID then
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

procedure TFrwRepository<T>.Insert(Value: T);
begin
  CheckRepositoryIsLoaded;

  if Contains(Value) then
    raise Exception.Create('Este objeto j� existe na lista, n�o pode ser adicionado novamente!');

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

  if Assigned(FAntesDeManipularObjeto) then FAntesDeManipularObjeto(Value, taUpdate);

  if DeveSalvarObjetos then
    Dao.Update(Value);

  if Assigned(FAposManipularObjeto) then FAposManipularObjeto(Value, taUpdate);
end;

procedure TFrwRepository<T>.Delete(Value: T);
begin
  CheckRepositoryIsLoaded;
  CheckContainsValue(Value);

  if Assigned(FAntesDeManipularObjeto) then FAntesDeManipularObjeto(Value, taDelete);

  if DeveSalvarObjetos then
    Dao.Delete(Value);

  Remove(Value);

  if Assigned(FAposManipularObjeto) then FAposManipularObjeto(Value, taDelete);
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
  // Limpa os dados do Reposit�rio se houver
  Clear;

  FIsLoaded:= True;
end;

procedure TFrwRepository<T>.LoadWhere(const pSqlWhere: String);
begin
  Clear;
  IsLoading:= True;
  try
    Dao.GetListWhere(Self, pSqlWhere);
    FIsLoaded:= True;
  finally
    IsLoading:= False;
  end;
end;

end.
