unit Test.Classes;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, System.SysUtils, uConsultaPersonalizada, uConClasses,
  System.Generics.Collections, Ladder.Activity.Classes, Ladder.ServiceLocator,
  Data.DB, System.Classes;

type
  // Test methods for class TOutputBase

  TestTOutputBase = class(TTestCase)
  strict private
    FOutputBase: TOutputParameter;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;

  THackProcessoBase = class(TProcessoBase);

  TestTProcessoBase = class(TTestCase)
  strict private
    FProcessoBase: THackProcessoBase;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecutar;
    procedure TestFindElementByName;

  end;
  // Test methods for class TAtividade

  TestTActivity = class(TTestCase)
  strict private
    FActivity: TActivity;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecutar;
  end;

implementation

procedure TestTOutputBase.SetUp;
begin
  FOutputBase := TOutputParameter.Create;
end;

procedure TestTOutputBase.TearDown;
begin
  FOutputBase.Free;
  FOutputBase := nil;
end;

procedure TestTProcessoBase.SetUp;
begin
  FProcessoBase := THackProcessoBase.Create(nil, TFrwServiceLocator.Context.Connection);
end;

procedure TestTProcessoBase.TearDown;
begin
  FProcessoBase.Free;
  FProcessoBase := nil;
end;

procedure TestTProcessoBase.TestExecutar;
var
  ReturnValue: TOutputList;
begin
  ReturnValue := FProcessoBase.Executar(nil);
  // TODO: Validate method results
end;

procedure TestTProcessoBase.TestFindElementByName;
var
  FInput1, FInput2, FInput3: TParameter;
begin
  FInput1:= TParameter.Create('input1', tbValue, 'teste1');
  FProcessoBase.Inputs.Add(FInput1);
  Check(TObject(FProcessoBase.FindElementByName('input1')) = FInput1);

  FInput2:= TParameter.Create('dois', tbValue, 'valordois');
  FProcessoBase.Inputs.Add(FInput2);
  Check(TObject(FProcessoBase.FindElementByName('dois'))=FInput2);

  FInput3:= TParameter.Create('tres', tbList, '[@input1, @dois]');
  FProcessoBase.Inputs.Add(FInput3);
  Check(TObject(FProcessoBase.FindElementByName('tres'))=FInput3);

  FProcessoBase.ValuateInputs(FProcessoBase.OnValuateInputExpression);

  CheckEquals('teste1', FInput1.Value);
  CheckEquals('teste1', FInput3.Value._(0));
  CheckEquals('valordois', FInput3.Value._(1));
end;

procedure TestTActivity.SetUp;
begin
  FActivity := TActivity.Create(TFrwServiceLocator.Context.Connection);
end;

procedure TestTActivity.TearDown;
begin
  FActivity.Free;
  FActivity := nil;
end;

procedure TestTActivity.TestExecutar;
var
  ReturnValue: TOutputList;
begin
  ReturnValue := FActivity.Executar;
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
//  RegisterTest(TestTOutputBase.Suite);
//  RegisterTest(TestTExecutorBase.Suite);
//  RegisterTest(TestTExecutorConsultaPersonalizada.Suite);
  RegisterTest(TestTProcessoBase.Suite);
//  RegisterTest(TestTAtividade.Suite);
end.
