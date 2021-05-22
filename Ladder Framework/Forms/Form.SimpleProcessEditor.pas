unit Form.SimpleProcessEditor;

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
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls, Ladder.Executor.Simple,
  System.Generics.Collections, Ladder.Activity.Classes, uConClasses,
  Ladder.Activity.Manager, Ladder.ORM.ObjectDataSet, cxSplitter;

type
  TFormSimpleProcessEditor = class(TFormProcessEditor)
    DsInput: TDataSource;
    TBInput: TFDMemTable;
    FDAutoIncField1: TFDAutoIncField;
    IntegerField1: TIntegerField;
    MemoField1: TMemoField;
    IntegerField2: TIntegerField;
    MemoField2: TMemoField;
    IntegerField3: TIntegerField;
    cxGridInputs: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
  private
    { Private declarations }
    FInputDataSet: TObjectDataSet;
  protected
    procedure SetupProcess(AProcess: TProcessoBase); override;
    procedure Synchronize; override;
  public
    { Public declarations }
    constructor Create(AOWner: TComponent);
    class function GetSimpleEditor(AOwner: TComponent): IProcessEditor;
  end;

var
  FormSimpleProcessEditor: TFormSimpleProcessEditor;

implementation

uses
  Ladder.ServiceLocator;

{$R *.dfm}

{ TFormProcessEditor1 }

constructor TFormSimpleProcessEditor.Create(AOWner: TComponent);
var
  FParametrosDef: TObjectList<TParametroCon>;
  FOutputDef: TOutputList;
begin
  FParametrosDef:= TObjectList<TParametroCon>.Create; // No inputs
  FOutputDef:= TOutputList.Create;//No outputs

  inherited Create(AOwner, FParametrosDef, FOutputDef, ActivityManager.GetExecutor(TExecutorSimple));
  ShowInputBoxWhenNoInputs:= True;
  ShowOutputBoxWhenNoOutputs:= True;
  DefaultName:= 'Process';
  FInputDataSet:= TObjectDataSet.Create(Self, TParameter);
  FInputDataSet.SetMaster(ProcessoDataSet, 'Inputs');
  DsInput.DataSet:= FInputDataSet;
end;

class function TFormSimpleProcessEditor.GetSimpleEditor(
  AOwner: TComponent): IProcessEditor;
begin
  Result:= TFormSimpleProcessEditor.Create(AOwner);
end;

procedure TFormSimpleProcessEditor.SetupProcess(AProcess: TProcessoBase);
begin
  inherited;
  FInputDataSet.SetObjectList<TParameter>(FProcesso.Inputs);
  Self.Height:= 480;
  Splitter1.Visible:= True;
end;

procedure TFormSimpleProcessEditor.Synchronize;
begin
  inherited;
  FInputDataSet.Synchronize;
end;

initialization
  TFrwServiceLocator.ActivityManager.RegisterProcessEditor(TExecutorSimple, TFormSimpleProcessEditor.GetSimpleEditor);

end.
