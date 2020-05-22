unit Test.Dao;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, Ladder.ServiceLocator, System.Contnrs, Ladder.ORM.Classes,
  Generics.Collections, Ladder.ORM.ModeloBD, Ladder.ORM.QueryBuilder, RTTI,
  Ladder.Messages, Ladder.ORM.Dao, Data.DB, Ladder.ORM.DaoUtils, Test.MockClasses,
  SysUtils;

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

  TestTDaoBase = class(TTestCase)
  strict private
    FDaoBase: IDaoBase;
  private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestInsertChild;
    procedure TestRecursiveObject;
  end;
  // Test methods for class TDaoGeneric

  TestTDaoGeneric = class(TTestCase)
  strict private
    FDaoGeneric: IDaoGeneric<TTeste>;
    FDaoTestChild: IDaoGeneric<TTestChild>;
  public
    procedure SetUp; override;
    procedure TearDown; override;
    procedure TestSelectKey;
    procedure TestKeyExists;
    procedure TestSelectWhere;
    procedure TestSelectWhere1;
  published
    procedure TestInsert;
    procedure TestUpdate;
    procedure TestDelete;
    procedure TestDelete1;
  end;
  // Test methods for class TNullDao

  TestTDaoFactory = class(TTestCase)
  strict private
    FDaoFactory: TDaoFactory;
  public
    procedure SetUp; override;
    procedure TearDown; override;
    procedure TestNewDao;
    procedure TestNewDao1;
    procedure TestNewQueryBuilder;
  published

  end;

implementation

uses
  DateUtils;

procedure TestTDaoBase.SetUp;
var
  FDaoTestChild: TDaoBase;
begin
  FDaoBase:= TDaoBase.Create('Teste', 'ID', TTeste);
  FDaoTestChild := TDaoBase.Create('TestChild', 'ID', TTestChild);
  FDaoBase.AddChildDao('Childs', 'ID', 'IDPAI', FDaoTestChild);
end;

procedure TestTDaoBase.TearDown;
begin
  FDaoBase := nil;
  TFrwServiceLocator.Context.DaoUtils.ExecuteNoResult('DELETE FROM TESTE');
  TFrwServiceLocator.Context.DaoUtils.ExecuteNoResult('DELETE FROM TestChild');
end;

procedure TestTDaoBase.TestRecursiveObject;
var
  FDaoRecursive, FDaoChild: IDaoGeneric<TRecursiveObject>;
  FChave: Integer;
  FObject, FChild: TRecursiveObject;

  function AddNewObject(pObject: TRecursiveObject): TRecursiveObject;
  begin
    Result:= TRecursiveObject.Create;
    pObject.Childs.Add(Result);
  end;
begin
  FDaoRecursive:= TDaoGeneric<TRecursiveObject>.Create('test.RecursiveObject', 'ID', TRecursiveObject);
  FDaoRecursive.AddChildDao('Childs', 'ID', 'IDMaster', FDaoRecursive);

  FObject:= TRecursiveObject.Create;
  FChild:= AddNewObject(AddNewObject(AddNewObject(FObject)));
  FChild.Childs.Add(TRecursiveObject.Create);
  FChild.Childs.Add(TRecursiveObject.Create);

  FDaoRecursive.Save(FObject);
  FChave:= FObject.ID;
  FObject.Free;

  FObject:= FDaoRecursive.SelectKey(FChave);
  try
    CheckEquals(1, FObject.Childs.Count);
    CheckEquals(1, FObject.Childs[0].Childs.Count);
    CheckEquals(1, FObject.Childs[0].Childs[0].Childs.Count);
    CheckEquals(2, FObject.Childs[0].Childs[0].Childs[0].Childs.Count);
    CheckEquals(0, FObject.Childs[0].Childs[0].Childs[0].Childs[0].Childs.Count);
  finally
    FObject.Free;
  end;
end;

procedure TestTDaoBase.TestInsertChild;
var
  ChildDefs: TChildDaoDefs;
  pChild: TTestChild;
  pMaster: TTeste;
  FID: Integer;
begin
//  Setup;

  pMaster:= TTeste.Create('TestInsertChild', now, 122.22);
  FDaoBase.Insert(pMaster);
  Check(pMaster.ID <> 0);

  FID:= pMaster.ID;

  pChild:= TTestChild.Create(123);
  pMaster.Childs.Add(pChild);

  FDaoBase.InsertChild(pMaster, pChild);
  Check(pChild.ID <> 0);

  pMaster.Free;
  pMaster:= (FDaoBase.SelectKey(FID) as TTeste);
  Check(pMaster.Childs.Count > 0);
  Check(pMaster.Childs[0].Num = 123);
end;

procedure TestTDaoGeneric.SetUp;
begin
  FDaoGeneric := TDaoGeneric<TTeste>.Create('Teste', 'ID');
  with FDaoGeneric.ModeloBD do UpdateOptions:= UpdateOptions + [DeleteMissingChilds];

  FDaoTestChild := TDaoGeneric<TTestChild>.Create('TestChild', 'ID');
  FDaoGeneric.AddChildDao('Childs', 'ID', 'IDPAI', FDaoTestChild);
end;

procedure TestTDaoGeneric.TearDown;
begin
  FDaoGeneric := nil;
end;

procedure TestTDaoGeneric.TestSelectKey;
var
  ReturnValue: TTeste;
  FChave: Integer;
begin
  // TODO: Setup method call parameters
  ReturnValue := FDaoGeneric.SelectKey(FChave);
  // TODO: Validate method results
end;

procedure TestTDaoGeneric.TestKeyExists;
var
  ReturnValue: Boolean;
  ID: Integer;
begin
  // TODO: Setup method call parameters
  ReturnValue := FDaoGeneric.KeyExists(ID);
  // TODO: Validate method results
end;

procedure TestTDaoGeneric.TestInsert;
var
  pObjeto: TTeste;
  FID: Integer;
  FData: TDateTime;
  FFloat: Double;
begin
  FData:= now;
  FFloat:= 123.22;
  pObjeto:= TTeste.Create('Teste', FData, FFloat);
  FDaoGeneric.Insert(pObjeto);
  Check(pObjeto.ID <> 0);
  FID:= pObjeto.ID;
  pObjeto.Free;
  pObjeto:= FDaoGeneric.SelectKey(FID);
  CheckEquals('Teste', pObjeto.Texto);
  CheckEquals(SecondOf(FData), SecondOF(pObjeto.Data));
  CheckEquals(MinuteOf(FData), MinuteOf(pObjeto.Data));
  CheckEquals(FFloat, pObjeto.Float);
end;

procedure TestTDaoGeneric.TestUpdate;
var
  FTeste: TTeste;
  FID: Integer;
begin
  FTeste:= TTeste.Create('Teste', now, 122);
  FTeste.Childs.Add(TTestChild.Create(1));
  FTeste.Childs.Add(TTestChild.Create(2));
  FTeste.Childs.Add(TTestChild.Create(3));
  FDaoGeneric.Insert(FTeste);
  FID:= FTeste.ID;
  FTeste.Free;
  FTeste:= FDaoGeneric.SelectKey(FID);
  CheckEquals(3, FTeste.Childs.Count);
  CheckEquals(1, FTeste.Childs[0].Num);
  CheckEquals(2, FTeste.Childs[1].Num);
  CheckEquals(3, FTeste.Childs[2].Num);
  FTeste.Float:= 22;
  FDaoGeneric.Update(FTeste);
  FTeste.Free;
  FTeste:= FDaoGeneric.SelectKey(FID);
  Check(FTeste.Float = 22);
  FTeste.Childs[0].Num:= 4;
  FTeste.Childs[1].Num:= 5;
  FTeste.Childs[2].Num:= 6;
  FDaoGeneric.Update(FTeste);
  FTeste.Free;
  FTeste:= FDaoGeneric.SelectKey(FID);
  CheckEquals(4, FTeste.Childs[0].Num);
  CheckEquals(5, FTeste.Childs[1].Num);
  CheckEquals(6, FTeste.Childs[2].Num);
  FTeste.Childs.Remove(FTeste.Childs[1]);
  FDaoGeneric.Update(FTeste);
  FTeste.Free;
  FTeste:= FDaoGeneric.SelectKey(FID);

  CheckEquals(2, FTeste.Childs.Count);
  CheckEquals(4, FTeste.Childs[0].Num);
  CheckEquals(6, FTeste.Childs[1].Num);
  FTeste.Free;
end;

procedure TestTDaoGeneric.TestDelete;
var
  pObjeto: TTeste;
  FID, FIDChild: Integer;
begin
  pObjeto:= tteste.Create('teste', now, 123);
  pObjeto.Childs.Add(TTestChild.Create(222));
  FDaoGeneric.Insert(pObjeto);
  FID:= pObjeto.ID;
  FIDChild:= pObjeto.Childs[0].ID;

  FDaoGeneric.Delete(pObjeto);

  Check(FDaoGeneric.SelectKey(FID) = nil);
  Check(FDaoTestChild.SelectKey(FIDChild) = nil);
  // TODO: Validate method results
end;

procedure TestTDaoGeneric.TestDelete1;
var
  ID: Integer;
begin
  // TODO: Setup method call parameters
  FDaoGeneric.Delete(ID);
  // TODO: Validate method results
end;

procedure TestTDaoGeneric.TestSelectWhere;
var
  ReturnValue: TObjectList<TTeste>;
  pWhere: string;
begin
  // TODO: Setup method call parameters
  ReturnValue := FDaoGeneric.SelectWhereG(pWhere);
  // TODO: Validate method results
end;

procedure TestTDaoGeneric.TestSelectWhere1;
var
  pWhere: string;
  pObjectList: TFrwObjectList<TTeste>;
begin
  // TODO: Setup method call parameters
  FDaoGeneric.SelectWhere(pObjectList, pWhere);
  // TODO: Validate method results
end;
procedure TestTDaoFactory.SetUp;
begin
  FDaoFactory := TDaoFactory.Create;
end;

procedure TestTDaoFactory.TearDown;
begin
  FDaoFactory.Free;
  FDaoFactory := nil;
end;

procedure TestTDaoFactory.TestNewDao;
var
  ReturnValue: TDaoBase;
  ModeloBD: TModeloBD;
begin
  // TODO: Setup method call parameters
  ReturnValue := FDaoFactory.NewDao(ModeloBD);
  // TODO: Validate method results
end;

procedure TestTDaoFactory.TestNewDao1;
var
  ReturnValue: TDaoGeneric<TTeste>;
  ModeloBD: TModeloBD;
begin
  // TODO: Setup method call parameters
  ReturnValue := FDaoFactory.NewDao<TTeste>(ModeloBD);
  // TODO: Validate method results
end;

procedure TestTDaoFactory.TestNewQueryBuilder;
var
  ReturnValue: TQueryBuilderBase;
  ModeloBD: TModeloBD;
begin
  // TODO: Setup method call parameters
  ReturnValue := FDaoFactory.NewQueryBuilder(ModeloBD);
  // TODO: Validate method results
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

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTDaoBase.Suite);
  RegisterTest(TestTDaoGeneric.Suite);
  RegisterTest(TestTDaoFactory.Suite);
end.

