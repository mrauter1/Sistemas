unit Form.ProcessEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uConSqlServer, cxDBLookupComboBox, Ladder.ServiceLocator, Vcl.ComCtrls,
  Vcl.CheckLst, Ladder.Activity.Classes, Form.ProcessEditorBase, Ladder.ORM.DAO,
  Ladder.ORM.ObjectDataSet, Ladder.Activity.Classes.Dao,
  System.Generics.Collections, uConClasses, Ladder.Activity.Manager;

type
  TFormProcessEditor = class(TFormProcessEditorBase, IProcessEditor)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBoxInputs: TGroupBox;
    BtnOK: TBitBtn;
    Label2: TLabel;
    DBEditIDConsulta: TDBEdit;
    GroupBoxOutputs: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    DBEditNomeProcesso: TDBEdit;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    ScrollBoxParametros: TScrollBox;
    DsProcesso: TDataSource;
    TbProcesso: TFDMemTable;
    TbProcessoID: TIntegerField;
    TbProcessoIDActivity: TIntegerField;
    TbProcessoName: TMemoField;
    TbProcessoDescription: TMemoField;
    TbProcessoClassName: TMemoField;
    TbProcessoExecutorClass: TMemoField;
    DsOutput: TDataSource;
    TBOutput: TFDMemTable;
    TBOutputID: TFDAutoIncField;
    TBOutputIDProcesso: TIntegerField;
    TBOutputName: TMemoField;
    TBOutputParameterType: TIntegerField;
    TBOutputExpression: TMemoField;
    TBOutputIDMaster: TIntegerField;
    cxGridDBTableView1ID: TcxGridDBColumn;
    cxGridDBTableView1Name: TcxGridDBColumn;
    cxGridDBTableView1Expression: TcxGridDBColumn;
    procedure BtnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FOK: Boolean;
    FProcessoDao: IProcessoDao<TProcessoBase>;
    FProcessoDataSet: TObjectDataSet;
    FOutputDataSet: TObjectDataSet;

    FExecutor: IExecutorBase;

    FParametrosDef: TObjectList<TParametroCon>;
    FOutputsDef: TOutputList;
    FExpressionEvaluator: IExpressionEvaluator;
  protected
    FProcesso: TProcessoBase;
    constructor Create(AOwner: TComponent); overload; override;
    procedure SetupProcess(AProcess: TProcessoBase); virtual;
    function CreateNewProcess(AExpressionEvaluator: IExpressionEvaluator): TProcessoBase; virtual;
    procedure CreateOutputs; virtual;
    procedure Synchronize; virtual;
  public
    { Public declarations }
    //WARNING: AParameterDef and AOutputs will be destroyed by this class when its freed
    constructor Create(AOwner: TComponent; AParametersDef: TObjectList<TParametroCon>; AOutputsDef: TOutputList; AExecutor: IExecutorBase); overload;
    destructor Destroy; override;

    function Form: TForm;

    function NewProcess(AExpressionEvaluator: IExpressionEvaluator): TProcessoBase; virtual;
    procedure EditProcess(pProcesso: TProcessoBase; AExpressionEvaluator: IExpressionEvaluator); virtual;

    function GetParameterContainer: IActivityElementContainer; virtual;

    class function GetProcessEmailEditor(AOwner: TComponent): IProcessEditor;

    property Processo: TProcessoBase read FProcesso;
    property ParametrosDef: TObjectList<TParametroCon> read FParametrosDef write FParametrosDef;
    property OutputsDef: TOutputList read FOutputsDef write FOutputsDef;
    property Executor: IExecutorBase read FExecutor write FExecutor;
  end;

implementation

{$R *.dfm}

uses
  Form.SelecionaConsulta, GerenciadorUtils, Ladder.Parser, Ladder.Executor.Email;

procedure TFormProcessEditor.SetupProcess(AProcess: TProcessoBase);
begin
  RefreshProcessInputs(FParametrosDef, GetParameterContainer);

  CreateOutputs;
  CreateScreenParameters(FParametrosDef, GetParameterContainer, ScrollBoxParametros);

  if FParametrosDef.Count = 0 then
    ScrollBoxParametros.Visible:= False;

  if FProcesso.Outputs.Count = 0 then
    GroupBoxOutputs.Visible:= False;

  FProcessoDataSet.SetObject(FProcesso);
  FOutputDataSet.SetObjectList<TOutputParameter>(FProcesso.Outputs);
end;

procedure TFormProcessEditor.Synchronize;
begin
  FProcessoDataSet.Synchronize;
  FOutputDataSet.Synchronize;
end;

function TFormProcessEditor.CreateNewProcess(AExpressionEvaluator: IExpressionEvaluator): TProcessoBase;
begin
  Result:= TProcessoBase.Create(FExecutor, AExpressionEvaluator);
end;

procedure TFormProcessEditor.CreateOutputs;
var
  FOutput: TOutputParameter;
begin
  if not Assigned(FOutputsDef) then
    Exit;

  for FOutput in OutputsDef do
    if Processo.Outputs.Param(FOutput.Name) = nil then
      Processo.Outputs.Add(TOutputParameter.CreateCopy(FOutput));
end;

function TFormProcessEditor.NewProcess(AExpressionEvaluator: IExpressionEvaluator): TProcessoBase;
begin
  FExpressionEvaluator:= AExpressionEvaluator;
  FProcesso:= CreateNewProcess(AExpressionEvaluator);

  SetupProcess(FProcesso);

  Result:= FProcesso;
end;

constructor TFormProcessEditor.Create(AOwner: TComponent);
begin
  raise Exception.Create('TProcessEditor.Create: Do not call this function! Call TProcessEditor.Create(AOwner: TComponent; AParametersDef: TObjectList<TParametroCon>; AOutputsDef: TOutputList; AExecutor: IExecutorBase);');
end;

procedure TFormProcessEditor.BtnOKClick(Sender: TObject);
begin
  ScreenParamToProcess(FParametrosDef, GetParameterContainer, ScrollBoxParametros) ;

  if FProcessoDataSet.State in ([dsEdit,dsInsert]) then
    FProcessoDataSet.Post;

  FProcesso.CheckValidity(FExpressionEvaluator);

  FOk:= True;
  Close;
end;

constructor TFormProcessEditor.Create(AOwner: TComponent; AParametersDef: TObjectList<TParametroCon>; AOutputsDef: TOutputList; AExecutor: IExecutorBase);
begin
  inherited Create(AOwner);
  FOk:= True;
  FProcessoDao:= TProcessoDao<TProcessoBase>.Create;
  FProcessoDataSet:= TObjectDataSet.Create(Self, FProcessoDao.ModeloBD);
  FOutputDataSet:= TObjectDataSet.Create(Self, FProcessoDao.OutputDao.ModeloBD);
  FOutputDataSet.SetMaster(FProcessoDataSet, 'Outputs');

  DsProcesso.DataSet:= FProcessoDataSet;
  DsOutput.DataSet:= FOutputDataSet;

  FParametrosDef:= AParametersDef;
  FOutputsDef:= AOutputsDef;
  FExecutor:= AExecutor;
end;

destructor TFormProcessEditor.Destroy;
begin
  FProcessoDataSet:= nil;
  DsProcesso.DataSet:= nil;
  FOutputDataSet:= nil;
  DsProcesso.DataSet:= nil;

  FParametrosDef.Free;

  if Assigned(FOutputsDef) then
    FOutputsDef.Free;
  inherited;
end;

procedure TFormProcessEditor.EditProcess(pProcesso: TProcessoBase; AExpressionEvaluator: IExpressionEvaluator);
begin
  FExpressionEvaluator:= AExpressionEvaluator;
  FProcesso:= pProcesso;

  SetupProcess(FProcesso);
end;

function TFormProcessEditor.Form: TForm;
begin
  Result:= Self;
end;

procedure TFormProcessEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
  inherited;
end;

function TFormProcessEditor.GetParameterContainer: IActivityElementContainer;
begin
  Result:= FProcesso;
end;

class function TFormProcessEditor.GetProcessEmailEditor(AOwner: TComponent): IProcessEditor;
var
  FParametrosDef: TObjectList<TParametroCon>;
  FOutputDef: TOutputList;
begin
  FParametrosDef:= TObjectList<TParametroCon>.Create;
  FParametrosDef.Add(TParametroCon.Create('Titulo', null, TTipoParametro.ptTexto, 'Título', ''));
  FParametrosDef.Add(TParametroCon.Create('Body', null, TTipoParametro.ptTexto, 'Corpo do Email', ''));
  FParametrosDef.Add(TParametroCon.Create('Destinatarios', null, TTipoParametro.ptTexto, 'Destinatários', ''));
  FParametrosDef.Add(TParametroCon.Create('Anexos', null, TTipoParametro.ptTexto, 'Anexos', ''));
  FOutputDef:= TOutputList.Create;//No outputs

  Result:= TFormProcessEditor.Create(AOwner, FParametrosDef, FOutputDef, ActivityManager.GetExecutor(TExecutorSendMail));
end;

initialization
  TFrwServiceLocator.Context.ActivityManager.RegisterProcessEditor(TExecutorSendMail, TFormProcessEditor.GetProcessEmailEditor);

end.
