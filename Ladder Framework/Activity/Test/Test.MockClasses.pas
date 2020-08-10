unit Test.MockClasses;

interface

uses
  Generics.Collections, Ladder.ORM.Dao, Ladder.ORM.ModeloBD, SynDB;

type
  // Test methods for class TDaoBase
  TRecursiveObject = class
  public
    procedure AfterConstruction; override;
    destructor Destroy; override;
  public
    FID: Integer;
  published
    Childs: TObjectList<TRecursiveObject>;
    property ID: Integer read FID write FID;
  end;

  TMFor = class
  private
    FChaveNF: String;
    FSerie: String;
    FNumero: String;
    FCodComprovante: String;
    FDataComprovante: TDateTime;
    FCodFilial: String;
  published
    property ChaveNF: String read FChaveNF write FChaveNF;
    property CodFilial: String read FCodFilial write FCodFilial;
    property CodComprovante: String read FCodComprovante write FCodComprovante;
    property Serie: String read FSerie write FSerie;
    property Numero: String read FNumero write FNumero;
    property DataComprovante: TDateTime read FDataComprovante write FDataComprovante;
  end;

  TTestChild = class
  private
    FNum: Integer;
    FID: Integer;
  public
    constructor Create(pNum: Integer); overload;
    constructor Create(pNum: Integer; pTexto: String); overload;
  published
    property ID: Integer read FID write FID;
    property Num: Integer read FNum write FNum;
  end;

  TTeste = class
  private
    FID: Integer;
    FFloat: Double;
    FTexto: String;
    FData: TDateTime;
    FChilds: TObjectList<TTestChild>;
  public
    constructor Create; overload;
    constructor Create(pTexto: String; pData: TDateTime; pFloat: Double); overload;
  published
    destructor Destroy;
    property ID: Integer read FID write FID;
    property Texto: String read FTexto write FTexto;
    property Data: TDateTime read FData write FData;
    property Float: Double read FFloat write FFloat;
    property Childs: TObjectList<TTestChild> read FChilds write FChilds;
  end;

  TTesteComposite = class(TTeste)
  public
    FNumber: Double;
    FIsCool: Boolean;
  published
    constructor Create(pTexto: String; pData: TDateTime; pFloat: Double; pNumber: Double; pIsCool: Boolean); overload;
    property Number: Double read FNumber write FNumber;
    property IsCool: Boolean read FIsCool write FIsCool;
  end;

  IDaoComposite = interface(IDaoGeneric<TTesteComposite>)
    function GetCompositeDao: IDaoGeneric<TTesteComposite>;
  end;

  TTesteDao<T: TTeste> = class(TDaoGeneric<T>)
  private
    FDaoTestChild: IDaoGeneric<TTestChild>;
  public
    constructor Create;
  end;

  TDaoComposite = class(TTesteDao<TTesteComposite>, IDaoComposite)
  private
    FCompositeDao: IDaoGeneric<TTesteComposite>;
  protected
    function NewObject(pDBRows: ISqlDBRows): TObject;
  public
    constructor Create;
    function GetCompositeDao: IDaoGeneric<TTesteComposite>;
  end;

procedure CreateTables;

implementation

procedure CreateTables;
var
  FTestDao: TDaoGeneric<TTeste>;
  FCompositeDao: IDaoComposite;
begin
  FTestDao:= TTesteDao<TTeste>.Create;
  FTestDao.CreateTableAndFields;
  FCompositeDao:= TDaoComposite.Create;
  FCompositeDao.CreateTableAndFields;
end;

{ TTeste }

constructor TTeste.Create(pTexto: String; pData: TDateTime; pFloat: Double);
begin
  Create;
  Texto:= pTexto;
  Data:= pData;
  Float:= pFloat;
end;

constructor TTeste.Create;
begin
  inherited Create;
  FChilds:= TObjectList<TTestChild>.Create(True);
end;

destructor TTeste.Destroy;
begin
  FChilds.Free;
  inherited Destroy;
end;

{ TTestChild }

constructor TTestChild.Create(pNum: Integer);
begin
  inherited Create;
  Num:= pNum;
end;

constructor TTestChild.Create(pNum: Integer; pTexto: String);
begin
  Create(pNum);
end;

{ TTesteComposite }

constructor TTesteComposite.Create(pTexto: String; pData: TDateTime; pFloat,
  pNumber: Double; pIsCool: Boolean);
begin
  inherited Create(pTexto, pData, pFloat);
  FNumber:= pNumber;
  FIsCool:= pIsCool;
end;


{ TRecursiveObject }

procedure TRecursiveObject.AfterConstruction;
begin
  inherited;
  Childs:= TObjectList<TRecursiveObject>.Create;
end;

destructor TRecursiveObject.Destroy;
begin
  Childs.Free;
  inherited;
end;

{ TTesteDao }

constructor TTesteDao<T>.Create;
begin
  inherited Create('Teste', 'ID', TTeste);
  with ModeloBD do UpdateOptions:= UpdateOptions + [uoDeleteMissingChilds];

  FDaoTestChild := TDaoGeneric<TTestChild>.Create('TestChild', 'ID');
  Self.AddChildDao('Childs', 'ID', 'IDPAI', FDaoTestChild);
end;

{ TDaoComposite }

constructor TDaoComposite.Create;
var
  FModeloBD: TModeloBD;
begin
  inherited Create;

  NewObjectFunction:= NewObject; // Since ItemClass is baseclass, baseclass will be created by default, here we override

  FModeloBD:= TModeloBD.Create(TTesteComposite, False);
  FModeloBD.NomeTabela:= 'TestComposite';
  FModeloBD.NomePropChave:= 'ID';
  FModeloBD.ChaveIncremental:= False;
  FModeloBD.DoMapPublishedFields(True); // Only map published field of TTesteComposite (don't map fields from base class)
  FModeloBD.Map('ID', 'ID'); // Since ID is a member of Base Class it must be explicitly added;

  FCompositeDao:= TDaoGeneric<TTesteComposite>.Create(FModeloBD);

  AddCompositeDao(FCompositeDao);
end;

function TDaoComposite.GetCompositeDao: IDaoGeneric<TTesteComposite>;
begin
  Result:= FCompositeDao;
end;

function TDaoComposite.NewObject(pDBRows: ISqlDBRows): TObject;
begin
  Result:= TTesteComposite.Create;
end;

initialization
  CreateTables;

end.
