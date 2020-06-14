unit Test.ModeloBD;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, SysUtils, SynDB, Ladder.ServiceLocator, Utils, Ladder.ORM.Classes,
  System.Contnrs, Ladder.ORM.ModeloBD, RTTI, Ladder.Messages, Ladder.ORM.DaoUtils, Data.DB,
  System.Classes, Math, Generics.Collections, Ladder.ORM.Repository, Test.MockClasses;

type
  // Test methods for class TFieldMapping

  TestTFieldMapping = class(TTestCase)
  strict private
    FFieldMapping: TFieldMapping;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;
  // Test methods for class TModeloBD

  TestTModeloBD = class(TTestCase)
  strict private
    FModeloBD: TModeloBD;
    FFrwRepository: TFrwRepository<TTeste>;
  private
    procedure AddTesteToDatabase;
  public
    procedure SetUp; override;
    procedure TearDown; override;
    procedure TestMap;
    procedure TestObjectToDataSet;
    procedure TestObjectFromDataSet;
    procedure TestObjectFromSql;
    procedure TestPopulaObjectListFromDataSet;
    procedure TestPopulaObjectListFromDataSet1;
    procedure TestPopulaObjectListFromSql;
    procedure TestPopulaObjectListFromSql1;
    procedure TestObjectListFromDataSet;
    procedure TestObjectListFromDataSet1;
    procedure TestObjectListFromSql1;
    procedure TestFazMapeamentoDaClasse;
    procedure TestSetKeyValue;
    procedure TestGetKeyValue;
  published
    procedure TestMapProperty;
    procedure TestObjectListFromSql;
//    procedure TestObjectListFromSqlMormot;
  end;
  // Test methods for class TQueryBuilderBase

implementation

procedure TestTFieldMapping.SetUp;
begin
  FFieldMapping := TFieldMapping.Create;
end;

procedure TestTFieldMapping.TearDown;
begin
  FFieldMapping.Free;
  FFieldMapping := nil;
end;

procedure TestTModeloBD.SetUp;
begin
  FModeloBD := TModeloBD.Create('TESTE', 'ID', TTeste);
  FFrwRepository := TFrwRepository<TTeste>.Create('TESTE', 'ID');
  FFrwRepository.ChaveIncremental:= True;
  FFrwRepository.LoadEmpty;
end;

procedure TestTModeloBD.TearDown;
begin
  FModeloBD.Free;
  FModeloBD := nil;
end;

procedure TestTModeloBD.TestMap;
var
  ReturnValue: TFieldMappingList;
  pField: string;
  pProp: string;
begin
  // TODO: Setup method call parameters
  ReturnValue := FModeloBD.Map(pProp, pField);
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestObjectToDataSet;
var
  ReturnValue: Boolean;
  pDataSet: TDataSet;
  pObjeto: TObject;
begin
  // TODO: Setup method call parameters
  ReturnValue := FModeloBD.ObjectToDataSet(pObjeto, pDataSet);
  // TODO: Validate method results
end;

procedure TestTModeloBD.AddTesteToDatabase;
begin
end;

function NewChild(pNum: Integer): TTestChild;
begin
  Result:= TTestChild.Create(pNum);
end;

procedure TestTModeloBD.TestMapProperty;
var
  ReturnValue: TObjectList<TTeste>;
begin
  FFrwRepository.Insert(TTeste.Create('t1', now, 2));

  FModeloBD.MapProperty('Childs',
    function (const pPropName: String; pCurrentValue: TValue; Instance: TObject; pDBRows: ISqlDBRows; Sender: TObject): TValue
    var
      FChilds: TObjectList<TTestChild>;
    begin
      if pCurrentValue.IsObject then
        pCurrentValue.AsObject.Free;

      FChilds:= TObjectList<TTestChild>.Create;
      FChilds.Add(NewChild(1));
      FChilds.Add(NewChild(2));
      FChilds.Add(NewChild(3));
      Result:= TValue.From<TObjectList<TTestChild>>(FChilds);
    end);

  ReturnValue:= FModeloBD.ObjectListFromSql<TTeste>('SELECT * FROM TESTE');
  Check(ReturnValue.Count > 0);
  Check(Assigned(ReturnValue[0].Childs));
  Check(ReturnValue[0].Childs.Count = 3);
  Check(ReturnValue[0].Childs[0].Num = 1);
  Check(ReturnValue[0].Childs[1].Num = 2);
end;

procedure TestTModeloBD.TestObjectFromDataSet;
var
  ReturnValue: TObject;
  pDataSet: TDataSet;
begin
  // TODO: Setup method call parameters
  ReturnValue := FModeloBD.ObjectFromDataSet(pDataSet);
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestObjectFromSql;
var
  ReturnValue: TObject;
  pSql: string;
begin
  // TODO: Setup method call parameters
  ReturnValue := FModeloBD.ObjectFromSql(pSql);
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestPopulaObjectListFromDataSet;
var
  pDataSet: TDataSet;
  pObjectList: TObjectList;
begin
  // TODO: Setup method call parameters
  FModeloBD.PopulaObjectListFromDataSet(pObjectList, pDataSet);
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestPopulaObjectListFromDataSet1;
begin
  // TODO: Setup method call parameters
//  FModeloBD.PopulaObjectListFromDataSet(pObjectList, pDataSet, pNewObjectFunction);
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestPopulaObjectListFromSql;
var
  pSql: string;
  pObjectList: TObjectList;
begin
  // TODO: Setup method call parameters
  FModeloBD.PopulaObjectListFromSql(pObjectList, pSql);
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestPopulaObjectListFromSql1;
begin
  // TODO: Setup method call parameters
//  FModeloBD.PopulaObjectListFromSql(pObjectList, pSql, pNewObjectFunction);
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestObjectListFromDataSet;
var
  ReturnValue: TObjectList;
  pDataSet: TDataSet;
begin
  // TODO: Setup method call parameters
  ReturnValue := FModeloBD.ObjectListFromDataSet(pDataSet);
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestObjectListFromDataSet1;
begin
  // TODO: Setup method call parameters
//  ReturnValue := FModeloBD.ObjectListFromDataSet(pDataSet);
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestObjectListFromSql;
var
  ReturnValue: TObjectList;
  pSql: string;
begin
  // TODO: Setup method call parameters
  FModeloBD := TModeloBD.Create('MFOR', 'CHAVENF', TMFOR);
  FModeloBD.ObjectListFromSql('SELECT * FROM MFOR');

{  ReturnValue := FModeloBD.ObjectListFromSql('SELECT * FROM TESTE');
  Check((ReturnValue.Items[0] is TTeste));}
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestObjectListFromSql1;
begin
  // TODO: Setup method call parameters
//  ReturnValue := FModeloBD.ObjectListFromSql(pSql);
  // TODO: Validate method results
end;

{procedure TestTModeloBD.TestObjectListFromSqlMormot;
var
  ReturnValue: TObjectList;
  pSql: string;
begin
  // TODO: Setup method call parameters
  FModeloBD := TModeloBD.Create('MFOR', 'CHAVENF', TMFOR);
  FModeloBD.ObjectListFromSqlMormot('SELECT * FROM MFOR');
{  ReturnValue := FModeloBD.ObjectListFromSqlMormot('SELECT * FROM TESTE');
  Check((ReturnValue.Items[0] is TTeste));
  // TODO: Validate method results
end;                                      }

procedure TestTModeloBD.TestFazMapeamentoDaClasse;
var
  ReturnValue: Boolean;
  MapeamentoCallback: TMapeamentoCallback;
begin
  // TODO: Setup method call parameters
  ReturnValue := FModeloBD.FazMapeamentoDaClasse(MapeamentoCallback);
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestSetKeyValue;
var
  fValor: Integer;
  pObject: TObject;
begin
  // TODO: Setup method call parameters
  FModeloBD.SetKeyValue(pObject, fValor);
  // TODO: Validate method results
end;

procedure TestTModeloBD.TestGetKeyValue;
var
  ReturnValue: Integer;
  pObject: TObject;
begin
  // TODO: Setup method call parameters
  ReturnValue := FModeloBD.GetKeyValue(pObject);
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTFieldMapping.Suite);
  RegisterTest(TestTModeloBD.Suite);
{  RegisterTest(TestTQueryBuilderBase.Suite);
  RegisterTest(TestTSqlServerQueryBuilder.Suite); }


end.

