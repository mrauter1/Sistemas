unit Form.ProcessActivityEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Form.ProcessEditor, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls, Ladder.Activity.Classes,
  Ladder.Activity.Manager, Ladder.ORM.Dao, Ladder.Activity.Classes.Dao,
  Ladder.ServiceLocator, System.Generics.Collections;

type
  TFormProcessActivityEditor = class(TFormProcessEditor)
  private
    { Private declarations }
    FActivity: TActivity;
    FActivityDao: IDaoGeneric<TActivity>;
    procedure RecreateParamDefs(AActivity: TActivity);
    procedure CreateActivityOutputs(AActivity: TActivity);
    function CheckAndCreateInputParam: TParameter;
  protected
    function CreateNewProcess(AExpressionEvaluator: IExpressionEvaluator): TProcessoBase; override;
    procedure SetupProcess(AProcess: TProcessoBase); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function NewProcess(AExpressionEvaluator: IExpressionEvaluator): TProcessoBase; override;
    procedure EditProcess(pProcesso: TProcessoBase; AExpressionEvaluator: IExpressionEvaluator); override;

    function GetParameterContainer: IActivityElementContainer; override;
    class function GetProcessEditor(AOwner: TComponent): IProcessEditor;
  end;

var
  FormProcessActivityEditor: TFormProcessActivityEditor;

implementation

{$R *.dfm}

uses
  uConClasses, Form.PesquisaAviso, Ladder.Executor.Activity;

{ TFormProcessActivityEditor }

constructor TFormProcessActivityEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TObjectList<TParametroCon>.Create, TOutputList.Create, ActivityManager.GetExecutor(TExecutorActivity));
  FActivityDao:= TActivityDao<TActivity>.Create;

end;

function TFormProcessActivityEditor.GetParameterContainer: IActivityElementContainer;
begin
  Result:= CheckAndCreateInputParam;
end;

class function TFormProcessActivityEditor.GetProcessEditor(AOwner: TComponent): IProcessEditor;
begin
  Result:= Self.Create(AOwner);
end;

procedure TFormProcessActivityEditor.CreateActivityOutputs(AActivity: TActivity);
var
  FOutput, FNewOutput: TOutputParameter;
begin
  for FOutput in AActivity.Outputs do
    if Processo.Outputs.Param(FOutput.Name) = nil then
    begin
      FNewOutput:= FOutput.CreateCopy(FOutput);
      FNewOutput.Expression:= ''; // Process output should not have expression, value is set by the Executor
      Processo.Outputs.Add(FNewOutput);
    end;
end;

destructor TFormProcessActivityEditor.Destroy;
begin
  if Assigned(FActivity) then
    FActivity.Free;

  inherited;
end;

function TFormProcessActivityEditor.CheckAndCreateInputParam: TParameter;
begin
  Result:= FProcesso.Inputs.Param('Inputs');
  if not Assigned(Result) then
  begin
    Result:= TParameter.Create('Inputs', tbAny, '');
    FProcesso.Inputs.Add(Result);
  end;
end;

procedure TFormProcessActivityEditor.RecreateParamDefs(AActivity: TActivity);
var
  FInput: TParameter;

  procedure CopyParams;
  var
    FActivityInputs: TParameter;
    FInput: TParameter;
  begin
    FActivityInputs:= CheckAndCreateInputParam;

    for FInput in AActivity.Inputs do
    begin
      if FActivityInputs.Param(FInput.Name) <> nil then
        Continue;

      FActivityInputs.Parameters.Add(TParameter.CreateCopy(FInput));
    end;

  end;
begin
  CopyParams;

  ParametrosDef.Clear;
  for FInput in AActivity.Inputs do
    ParametrosDef.Add(TParametroCon.Create(FInput.Name, null, TTipoParametro.ptTexto, FInput.Name, ''));

end;

procedure TFormProcessActivityEditor.SetupProcess(AProcess: TProcessoBase);
begin
  RecreateParamDefs(FActivity);

  CreateActivityOutputs(FActivity);

  inherited;
end;

procedure TFormProcessActivityEditor.EditProcess(pProcesso: TProcessoBase; AExpressionEvaluator: IExpressionEvaluator);
var
  FParamID: TParameter;
  FIDActivity: Integer;

  function LoadActivity: TActivity;
  begin
    FParamID:= pProcesso.Inputs.Param('IDActivity');
    if not Assigned(FParamID) then
      raise Exception.Create('TFormProcessActivityEditor.EditProcess: Process of type TActivityExecutor must have a parameter named IDActivity.');

    FIDActivity:= StrToIntDef(FParamID.Expression,0);
    Result:= FActivityDao.SelectKey(FIDActivity);

    if not Assigned(Result) then
      raise Exception.Create(Format('TFormProcessActivityEditor.EditProcess: Activity ID: %d not found.', [FIDActivity]));
  end;

begin
  FProcesso:= pProcesso;
  if Assigned(FActivity) then
    FreeAndNil(FActivity);

  FActivity:= LoadActivity;

  inherited EditProcess(pProcesso, AExpressionEvaluator);
end;

function TFormProcessActivityEditor.CreateNewProcess(
  AExpressionEvaluator: IExpressionEvaluator): TProcessoBase;
var
  FIDActivity: Integer;
begin
  Result:= nil;

  FIDActivity:= TFormPesquisaAviso.SelectActivity;
  if FIDActivity = 0 then
    Exit;

  FActivity:= FActivityDao.SelectKey(FIDActivity);
  if not Assigned(FActivity) then
    raise Exception.Create(Format('TFormCadastroProcessoConsulta.NewProcess: Consulta cod.: %d não encontrada.', [FIDActivity]));

  Result:= TProcessoBase.Create(Executor, AExpressionEvaluator);
  FProcesso:= Result;

  Result.Name:= 'Activity'+FActivity.Name;
  Result.Description:= FActivity.Description;

  Result.Inputs.Add(TParameter.Create('IDActivity', tbValue, IntToStr(FIDActivity)));
end;

function TFormProcessActivityEditor.NewProcess(AExpressionEvaluator: IExpressionEvaluator): TProcessoBase;
begin
  Result:= inherited NewProcess(AExpressionEvaluator);
end;

initialization
  TFrwServiceLocator.Context.ActivityManager.RegisterProcessEditor(TExecutorActivity, TFormProcessActivityEditor.GetProcessEditor);


end.
