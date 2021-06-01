unit Test.Ladder;

interface

uses
  TestFramework, Ladder.Utils, Ladder.ServiceLocator, SynCommons;

type
  TLadderProcesso = record
    ID: Integer;
    IDActivity: Integer;
    Name: String;
    Description: String;
    ExecOrder: Integer;
    ExecutorClass: String;
    ClassName: String;
  end;

  TTestLadderUtils = class(TTestCase)
  private
  public
    procedure Setup; override;
    procedure TearDown; override;
  published
    procedure TestReturnSqlToRecordArray;
  end;

implementation

{ TTestLadderUtils }

procedure TTestLadderUtils.Setup;
begin
  inherited;

end;

procedure TTestLadderUtils.TearDown;
begin
  inherited;

end;

procedure TTestLadderUtils.TestReturnSqlToRecordArray;
var
  FArray: TArray<TLadderProcesso>;
  FProcesso: TLadderProcesso;
begin
  ReturnSqlToRecordArray(TFrwServiceLocator.Context.Connection, 'select * from ladder.Processos', FArray, TypeInfo(TArray<TLadderProcesso>));
  Check(Length(FArray) > 0);

  ReturnSqlToRecordArray(TFrwServiceLocator.Context.Connection, 'select * from ladder.Processos where 1=0', FArray, TypeInfo(TArray<TLadderProcesso>));
  Check(Length(FArray) = 0);

  ReturnSqlToRecord(TFrwServiceLocator.Context.Connection, 'select * from ladder.Processos', FProcesso, TypeInfo(TLadderProcesso));
  Check(FProcesso.ID <> 0);

  CheckFalse(ReturnSqlToRecord(TFrwServiceLocator.Context.Connection, 'select * from ladder.Processos where 1=0', FProcesso, TypeInfo(TLadderProcesso)));
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TTestLadderUtils.Suite);

end.
