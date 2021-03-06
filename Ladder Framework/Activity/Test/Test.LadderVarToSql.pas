unit Test.LadderVarToSql;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, SysUtils, Ladder.Activity.LadderVarToSql, SynCommons, Ladder.ORM.DaoUtils,
  Ladder.ServiceLocator;

type
  // Test methods for class TLadderVarToSql

  TestTLadderVarToSql = class(TTestCase)
  strict private
    FLadderVarToSql: TLadderVarToSql;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestTableDocToSql;
    procedure TestValuesDocToSql;
    procedure TestLadderDocVariantToSql;
    procedure TestBatchInsert;
    procedure TestDataSetToDocVariant;
    procedure TestDocVariantToDataSet;
  end;

function GetDaoUtils: TDaoUtils;

implementation

uses
  DateUtils, Dialogs, Classes, Data.DB, Ladder.Utils;

function GetDaoUtils: TDaoUtils;
begin
  Result:= TFrwServiceLocator.Context.DaoUtils;
end;

procedure TestTLadderVarToSql.SetUp;
begin
  FLadderVarToSql := TLadderVarToSql.Create;
end;

procedure TestTLadderVarToSql.TearDown;
begin
  FLadderVarToSql.Free;
  FLadderVarToSql := nil;
end;

procedure TestTLadderVarToSql.TestTableDocToSql;
var
  ReturnValue: string;
  pDocVariant: TDocVariantData;
begin
  // TODO: Setup method call parameters
//  ReturnValue := FLadderVarToSql.TableDocToSql(pDocVariant);
  // TODO: Validate method results
end;

procedure TestTLadderVarToSql.TestValuesDocToSql;
var
  ReturnValue: string;
  pDocVariant: TDocVariantData;
begin
  // TODO: Setup method call parameters
  ReturnValue := FLadderVarToSql.ValuesDocToSql(pDocVariant);
  // TODO: Validate method results
end;

procedure TestTLadderVarToSql.TestBatchInsert;
var
  sStart, sFim: TDateTime;
  DocVariant: TDocVariantData;
begin
  DocVariant:= TDocVariantData(GetDaoUtils.SelectAsDocVariant('select * from MFOR'));
  sStart:= now;
  TLadderVarToSql.InsertDocVariantData(DocVariant, 'MFORTESTE', True, True);
  sFim:= now;
  Status(FOrmat('InsertDocVariantData time %d ms for %d rows; ', [MilliSecondsBetween(sStart, sFim), DocVariant.Count]));
{
  TMySqlServerConnectionProperties(TFrwServiceLocator.Context.Connection).InsertDocVariantData('##MFORTESTE',
        TDocVariantData(GetDaoUtils.SelectAsDocVariant('select top 750 * from MFOR')));}
end;

procedure TestTLadderVarToSql.TestDataSetToDocVariant;
  procedure TestSql(pSql: String);
  var
    FDataSet: TDataset;
    FCount: Integer;
    pDocVariant, ReturnValue: TDocVariantData;
    I, j: Integer;
  begin
    pDocVariant:= TDocVariantData(GetDaoUtils.SelectAsDocVariant(pSql, True));
    FDataSet:= FLadderVarToSql.DocVariantToDataSet(nil, pDocVariant);
    try
      ReturnValue:= FLadderVarToSql.DataSetToDocVariant(FDataSet);
      Check(ReturnValue.Count = FDataSet.RecordCount);
      FDataSet.First;
      for I := 0 to FDataSet.RecordCount-1 do
      begin
        for J := 0 to FDataSet.FieldCount-1 do
        begin
          CheckEquals(FDataSet.Fields[j].FieldName, ReturnValue._[I].Names[j]);
          if FDataSet.Fields[j].DataType = ftDateTime then
            Check(FDataSet.Fields[j].AsDateTime = LadderVarToDateTime(ReturnValue._[I].Values[j]))
          else
            Check(FDataSet.Fields[j].Value = ReturnValue._[I].Values[j]);

        end;
        FDataSet.Next;
      end;
    finally
      FDataset.Free;
    end;
  end;

begin
  TestSql('select top 100 chavenf, dataentrada, totitens, substituicao from mfor ');
  TestSql('select top 0 chavenf, dataentrada, totitens, substituicao from mfor ');
  TestSql('select null as chavenf, getdate() as dataentrada, 2 as totitens, null as substituicao ');
end;

procedure TestTLadderVarToSql.TestDocVariantToDataSet;
var
  FDataSet: TDataset;
  FCount: Integer;
  pDocVariant: TDocVariantData;
begin
  FDataSet:= FLadderVarToSql.DocVariantToDataSet(nil, _Safe(GetDaoUtils.SelectAsDocVariant('select dataentrada as data from MFOR'), dvArray)^);
  try
    Check(SameText(FDataSet.Fields[0].FieldName, 'data'));
    Check(FDataSet.Fields[0].DataType = Data.DB.ftDateTime); 
  finally
    FDataSet.Free;
  end;

  pDocVariant:= TDocVariantData(GetDaoUtils.SelectAsDocVariant('select * from mfor '));
  FDataSet:= FLadderVarToSql.DocVariantToDataSet(nil, pDocVariant);
  FCount:= GetDaoUtils.SelectInt('select count(*) from mfor');
  try
    checkEquals(FCount, FDataSet.RecordCount);
    Check(SameText(FDataSet.Fields[0].FieldName, 'CHAVENF'));
  finally
    FDataSet.Free;
  end;
end;

procedure TestTLadderVarToSql.TestLadderDocVariantToSql;
var
  ReturnValue: string;
  pDocVariant: TDocVariantData;
  sStart, sFim: TDateTime;
//  FStr: TStringList;
begin
  // Calls MultipleValuesInsert to insert to a temp table

  pDocVariant:= TDocVariantData(GetDaoUtils.SelectAsDocVariant('select getdate() '));
  ReturnValue := FLadderVarToSql.LadderDocVariantToSql(pDocVariant);
  pDocVariant:= TDocVariantData(GetDaoUtils.SelectAsDocVariant(ReturnValue));

  pDocVariant:= TDocVariantData(GetDaoUtils.SelectAsDocVariant('select TOP 100 * from MFOR order by newid()'));
  sStart:= now;
  ReturnValue := FLadderVarToSql.LadderDocVariantToSql(pDocVariant);
  sFim:= now;
  Status(FOrmat('GetDaoUtils.LadderDocVariantToSql time %d ms for %d rows; ', [MilliSecondsBetween(sStart, sFim), pDocVariant.Count]));

{  FStr:= TStringList.Create;
  FStr.Text:= ReturnValue;
  FStr.SaveToFile('F:\Sistemas\Ladder Framework\Activity\Test\sql.sql');
  FStr.Free;       }

  sStart:= now;
  pDocVariant:= TDocVariantData(GetDaoUtils.SelectAsDocVariant(ReturnValue));
  sFim:= now;
  Status(FOrmat('GetDaoUtils.SelectAsDocVariant time %d ms for %d rows; ', [MilliSecondsBetween(sStart, sFim), pDocVariant.Count]));

  CheckEquals(100, pDocVariant.Count);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTLadderVarToSql.Suite);
end.

