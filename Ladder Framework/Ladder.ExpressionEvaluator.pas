unit Ladder.ExpressionEvaluator;

interface

uses
  Ladder.Parser, Ladder.Activity.Classes, Ladder.ORM.DaoUtils;

type
  TExpressionEvaluator = class(TInterfacedObject, IExpressionEvaluator)
  private
    FParser: TActivityParser;
    FSyntaxChecker: TSyntaxChecker;
    FDaoUtils: TDaoUtils;
    FCurrentContainer: IActivityElementContainer;
    FRootContainer: IActivityElementContainer;
  protected
    procedure OnElementEval(const pElement: String; var Return: Variant); virtual;
    procedure OnSqlEval(const pSql: String; var Return: Variant); virtual;
  public
    constructor Create(pDaoUtils: TDaoUtils);
    destructor Destroy;

    procedure EvaluateExpression(AContainer: IActivityElementContainer; AExpression: String; var AResult: Variant);
    function CheckExpressionSyntax(AContainer: IActivityElementContainer; AExpression: String; out AErrorMessage: String): Boolean;

    procedure SetRootContainer(const AValue: IActivityElementContainer);
    function GetRootContainer: IActivityElementContainer;
    property RootContainer: IActivityElementContainer read GetRootContainer write SetRootContainer;
  end;

implementation

uses
  SysUtils;

{ TExpressionEvaluator }

function TExpressionEvaluator.CheckExpressionSyntax(AContainer: IActivityElementContainer; AExpression: String;
  out AErrorMessage: String): Boolean;
begin
  FCurrentContainer:= AContainer;
  try
    Result:= FSyntaxChecker.DoCheckSyntax(AExpression, AErrorMessage);
  finally
    FCurrentContainer:= nil;
  end;
end;

constructor TExpressionEvaluator.Create(pDaoUtils: TDaoUtils);
begin
  FDaoUtils:= pDaoUtils;

  FParser:= TActivityParser.Create;
  FParser.OnSqlEval:= OnSqlEval;
  FParser.OnElementEval:= OnElementEval;

  FSyntaxChecker:= TSyntaxChecker.Create(FParser);
end;

destructor TExpressionEvaluator.Destroy;
begin
  FSyntaxChecker.Free;
  FParser.Free;
end;

procedure TExpressionEvaluator.EvaluateExpression(AContainer: IActivityElementContainer; AExpression: String;
  var AResult: Variant);
begin
  FCurrentContainer:= AContainer;
  try
    FParser.DoParseExpression(AExpression, AResult);
  finally
    FCurrentContainer:= nil;
  end;
end;

function TExpressionEvaluator.GetRootContainer: IActivityElementContainer;
begin
  Result:= FRootContainer;
end;

procedure TExpressionEvaluator.OnElementEval(const pElement: String; var Return: Variant);
var
  FElement: IActivityElement;
begin
  Assert(Assigned(FCurrentContainer), 'TExpressionEvaluator.OnElementEval: FContainer must be assigned!');
  Assert(Assigned(FRootContainer), 'TExpressionEvaluator.OnElementEval: FRootContainer must be assigned!');

  FElement:= FRootContainer.FindElement(pElement, FCurrentContainer);

  if not Assigned(FElement) then
    raise Exception.Create(Format('TProcessoBase.OnElementEval: Element %s not found on Process %s.', [pElement, FCurrentContainer.GetName]));

  if not Supports(FElement, IActivityValue) then
    raise Exception.Create('TProcessoBase.OnElementEval: Element '+FElement.GetName+' is not a value!');

  Return:= (FElement as IActivityValue).GetValue;
end;

procedure TExpressionEvaluator.OnSqlEval(const pSql: String; var Return: Variant);
begin
  Return:= FDaoUtils.SelectAsDocVariant(pSql);
end;

procedure TExpressionEvaluator.SetRootContainer(const AValue: IActivityElementContainer);
begin
  FRootContainer:= AValue;
end;


end.
