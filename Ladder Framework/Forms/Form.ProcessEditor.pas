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
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
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
    procedure BtnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FOK: Boolean;
    FProcesso: TProcessoBase;
    FProcessoDao: IDaoGeneric<TProcessoBase>;
    FProcessoDataSet: TObjectDataSet;

    FExecutor: IExecutorBase;

    FParametrosDef: TObjectList<TParametroCon>;
    FOutputsDef: TOutputList;
    FExpressionEvaluator: IExpressionEvaluator;

  protected
    constructor Create(AOwner: TComponent); overload; override;
    procedure SetupScreen(AProcess: TProcessoBase); virtual;
  public
    { Public declarations }
    //WARNING: AParameterDef and AOutputs will be destroyed by this class when its freed
    constructor Create(AOwner: TComponent; AParametersDef: TObjectList<TParametroCon>; AOutputsDef: TOutputList; AExecutor: IExecutorBase); overload;
    destructor Destroy; override;

    function Form: TForm;

    function NewProcess(AExpressionEvaluator: IExpressionEvaluator): TProcessoBase; virtual;
    procedure EditProcess(pProcesso: TProcessoBase; AExpressionEvaluator: IExpressionEvaluator); virtual;

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

procedure TFormProcessEditor.SetupScreen(AProcess: TProcessoBase);
begin
  FProcessoDataSet.SetObject(FProcesso);

  CreateScreenParameters(FParametrosDef, FProcesso, ScrollBoxParametros);

  if FParametrosDef.Count = 0 then
    ScrollBoxParametros.Visible:= False;

  if FOutputsDef.Count = 0 then
    GroupBoxOutputs.Visible:= False;
end;

function TFormProcessEditor.NewProcess(AExpressionEvaluator: IExpressionEvaluator): TProcessoBase;
begin
  FExpressionEvaluator:= AExpressionEvaluator;
  FProcesso:= TProcessoBase.Create(FExecutor, FExpressionEvaluator);

  RefreshProcessInputs(FParametrosDef, FProcesso);

  CopyOutputList(fOutputsDef, FProcesso.Outputs);

  SetupScreen(FProcesso);

  Result:= FProcesso;
end;

constructor TFormProcessEditor.Create(AOwner: TComponent);
begin
  raise Exception.Create('TProcessEditor.Create: Do not call this function! Call TProcessEditor.Create(AOwner: TComponent; AParametersDef: TObjectList<TParametroCon>; AOutputsDef: TOutputList; AExecutor: IExecutorBase);');
end;

procedure TFormProcessEditor.BtnOKClick(Sender: TObject);
begin
  ScreenParamToProcess(FParametrosDef, FProcesso, ScrollBoxParametros) ;

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
  DsProcesso.DataSet:= FProcessoDataSet;

  FParametrosDef:= AParametersDef;
  FOutputsDef:= AOutputsDef;
  FExecutor:= AExecutor;
end;

destructor TFormProcessEditor.Destroy;
begin
  FProcessoDataSet:= nil;
  DsProcesso.DataSet:= nil;

  FParametrosDef.Free;
  FOutputsDef.Free;
  inherited;
end;

procedure TFormProcessEditor.EditProcess(pProcesso: TProcessoBase; AExpressionEvaluator: IExpressionEvaluator);
begin
  FExpressionEvaluator:= AExpressionEvaluator;
  FProcesso:= pProcesso;

  RefreshProcessInputs(FParametrosDef, FProcesso);

  SetupScreen(FProcesso);
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
