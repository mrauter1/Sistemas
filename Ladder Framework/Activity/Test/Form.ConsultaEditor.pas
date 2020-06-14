unit Form.ConsultaEditor;

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
  Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls, uConClasses, uConClasses.Dao,
  Ladder.Activity.Classes, cxDropDownEdit;

type
  TFormConsultaEditor = class(TFormProcessEditor)
    LblConsulta: TLabel;
    cxGridExport: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    TBExport: TFDMemTable;
    DsExport: TDataSource;
    TBExportNome: TStringField;
    TBExportVisualizacao: TStringField;
    TBExportNomeArquivo: TStringField;
    cxGridExportLevel1: TcxGridLevel;
    cxGridExportDBTableView1: TcxGridDBTableView;
    cxGridExportDBTableView1Nome: TcxGridDBColumn;
    cxGridExportDBTableView1Visualizacao: TcxGridDBColumn;
    cxGridExportDBTableView1NomeArquivo: TcxGridDBColumn;
    TBExportTipoVisualizacao: TStringField;
    cxGridExportDBTableView1TipoVisualizacao: TcxGridDBColumn;
    Splitter1: TSplitter;
    procedure BtnOKClick(Sender: TObject);
  private
    FConsulta: TConsulta;
    ConsultaDao: IConsultaDao<TConsulta>;
//    procedure CriaParametrosNaTela(pBox: TWinControl);
    function GetNomeConsulta(pIDConsulta: Integer): String;
    function GetConsulta(AProcess: TProcessoBase): TConsulta;
    procedure ExportParamToDataSet(AProcess: TProcessoBase);
    procedure DataSetToExportParam(AProcess: TProcessoBase);
    procedure RecreateParamertosDef;
    procedure SetLabelConsulta;
  protected
    procedure SetupScreen(AProcess: TProcessoBase); override;
    { Private declarations }
  public
    { Public declarations }
    function Form: TForm;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function NewProcess: TProcessoBase; override;
    procedure EditProcess(pProcesso: TProcessoBase); override;

    class function _NewProcess: TProcessoBase;
    class procedure _EditProcess(pProcesso: TProcessoBase);

    class function GetProcessEditor(AOwner: TComponent): IProcessEditor;
  end;

implementation

{$R *.dfm}

uses
  Form.SelecionaConsulta, Ladder.ServiceLocator, System.Generics.Collections, Ladder.Executor.ConsultaPersonalizada,
  Ladder.Utils, Utils, GerenciadorUtils;

procedure TFormConsultaEditor.SetupScreen(AProcess: TProcessoBase);
const
  cSqlVisualizacao = 'SELECT DESCRICAO, DESCRICAO AS DESC2 FROM CONS.VISUALIZACOES WHERE CONSULTA = %d';
begin
  inherited;
  ExportParamToDataSet(AProcess);
  SetLabelConsulta;
  FazLookupCxGrid(cxGridExportDBTableView1Visualizacao, format(cSqlVisualizacao, [FConsulta.ID]));
end;

function TFormConsultaEditor.NewProcess: TProcessoBase;
var
  FIDConsulta: Integer;
begin
  Result:= nil;

  FIDConsulta:= TFormSelecionaConsulta.SelecionaConsulta;
  if FIDConsulta = 0 then
    Exit;

  FConsulta:= ConsultaDao.SelectKey(FIDConsulta);
  if not Assigned(FConsulta) then
    raise Exception.Create(Format('TFormCadastroProcessoConsulta.NewProcess: Consulta cod.: %d não encontrada.', [FIDConsulta]));

  RecreateParamertosDef;

  Result:= inherited NewProcess;

  Result.Name:= 'Consulta'+FConsulta.Nome;
  Result.Description:= GetNomeConsulta(FIDConsulta);

  Result.Inputs.Add(TParameter.Create('IDConsulta', tbValue, IntToStr(FIDConsulta)));
end;

procedure TFormConsultaEditor.SetLabelConsulta;
begin
  LblConsulta.Caption:= Format('Consulta: %s', [GetNomeConsulta(FConsulta.ID)]);
end;

procedure TFormConsultaEditor.EditProcess(pProcesso: TProcessoBase);
var
  FIDConsulta: Integer;
begin
  if Assigned(FConsulta) then
    FreeAndNil(FConsulta);

  FConsulta:= GetConsulta(pProcesso);

  if not Assigned(FConsulta) then
    raise Exception.Create(Format('TFormCadastroProcessoConsulta.NewProcess: Consulta cod.: %d não encontrada.', [pProcesso.Inputs.ParamValue('IDConsulta', 0)]));

  RecreateParamertosDef;

  inherited EditProcess(pProcesso);
end;

function TFormConsultaEditor.GetConsulta(AProcess: TProcessoBase): TConsulta;
var
  FID, FNome: TParameter;
begin
  Result:= nil;
  FID:= AProcess.Inputs.Param('IDConsulta');
  if Assigned(FID) then
  begin
    Result:= ConsultaDao.SelectKey(StrToIntDef(FID.Expression,0));
    Exit;
  end;

  FNome:= AProcess.Inputs.Param('NomeConsulta');
  if Assigned(FNome) then
  begin
    Result:= ConsultaDao.SelectByNome(FNome.Expression);
    Exit;
  end;
end;

procedure TFormConsultaEditor.DataSetToExportParam(AProcess: TProcessoBase);
var
  FExport, FParam: TParameter;
begin
  FExport:= AProcess.Inputs.Param('Export');
  if not Assigned(FExport) then
  begin
    FExport:= TParameter.Create('Export', tbAny, '');
    AProcess.Inputs.Add(FExport);
  end;
  FExport.Parameters.Clear;

  TBExport.First;
  while not TBExport.Eof do
  begin
    FParam:= TParameter.Create(TBExportNome.AsString, tbAny, '');
    FParam.Parameters.Add(TParameter.Create('Visualizacao', tbAny, TBExportVisualizacao.AsString));
    FParam.Parameters.Add(TParameter.Create('NomeArquivo', tbAny, TBExportNomeArquivo.AsString));
    FParam.Parameters.Add(TParameter.Create('TipoVisualizacao', tbAny, TBExportTipoVisualizacao.AsString));

    FExport.Parameters.Add(FParam);
    TBExport.Next;
  end;
end;

procedure TFormConsultaEditor.ExportParamToDataSet(AProcess: TProcessoBase);
var
  FExport, FParam: TParameter;
begin
  TBExport.EmptyDataSet;

  FExport:= AProcess.Inputs.Param('Export');
  if not Assigned(FExport) then
    Exit;

  for FParam in FExport.Parameters do
  begin
    TBExport.Append;
    TBExportNome.AsString:= FParam.Name;
    TBExportVisualizacao.AsString:= FParam.Parameters.ParamExpression('Visualizacao');
    TBExportNomeArquivo.AsString:= FParam.Parameters.ParamExpression('NomeArquivo');
    TBExportTipoVisualizacao.AsString:= FParam.Parameters.ParamExpression('TipoVisualizacao');
    TBExport.Post;
  end;
end;

procedure TFormConsultaEditor.RecreateParamertosDef;
var
  FParametro: TParametroCon;
begin
  ParametrosDef.Clear;
  for FParametro in FConsulta.Parametros do
    ParametrosDef.Add(FParametro.CreateCopy(FParametro));
end;

function TFormConsultaEditor.Form: TForm;
begin
  Result:= Self;
end;

class procedure TFormConsultaEditor._EditProcess(
  pProcesso: TProcessoBase);
var
  vFrm: TFormConsultaEditor;
begin
  vFrm:= TFormConsultaEditor.Create(nil);
  try
    vFrm.EditProcess(pProcesso);
    vFrm.ShowModal;
  finally
    vFrm.Free;
  end;
end;

class function TFormConsultaEditor._NewProcess: TProcessoBase;
var
  vFrm: TFormConsultaEditor;
begin
  vFrm:= TFormConsultaEditor.Create(nil);
  try
    Result:= vFrm.NewProcess;
    vFrm.ShowModal;
  finally
    vFrm.Free;
  end;
end;

function TFormConsultaEditor.GetNomeConsulta(pIDConsulta: Integer): String;
const
  cSql = 'with Menu as '+
          '(   '+
          '  select Descricao, IDPai '+
          '  from cons.Menu '+
          '  where Tipo = 1 and IDAcao = %d '+
          '  union all '+
          '  select pai.Descricao, pai.IDPAi '+
          '  from cons.Menu pai '+
          '  inner join Menu m on m.IDPai = pai.ID '+
          ')   '+
          'select * from Menu ';
var
  FDataSet: TDataSet;
begin
  Result:= '';
  FDataSet:= TFrwServiceLocator.Context.DmConnection.RetornaDataSet(Format(cSql, [pIDConsulta]));
  try
    FDataSet.First;
    while not FDataSet.Eof do
    begin
      if Result = '' then
        Result:= FDataSet.FieldByName('Descricao').AsString
      else
        Result:= FDataSet.FieldByName('Descricao').AsString+' -> '+Result;

      FDataSet.Next;
    end;
  finally
    FDataSet.Free;
  end;
//  LblConsulta.Caption:= FNome;
end;

class function TFormConsultaEditor.GetProcessEditor(
  AOwner: TComponent): IProcessEditor;
begin
  Result:= Self.Create(AOwner);
end;

procedure TFormConsultaEditor.BtnOKClick(Sender: TObject);
begin
  DataSetToExportParam(Processo);
  inherited;
end;

constructor TFormConsultaEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TObjectList<TParametroCon>.Create, TOutputList.Create, ActivityManager.GetExecutor(TExecutorConsultaPersonalizada));
//  ArquivosExport.Active:= True;

  ConsultaDao:= TConsultaDao<TConsulta>.Create;

  TBExport.CreateDataSet;
end;

destructor TFormConsultaEditor.Destroy;
begin
  if Assigned(FConsulta) then
    FConsulta.Free;

  inherited;
end;

initialization
  TFrwServiceLocator.Context.ActivityManager.RegisterProcessEditor(TExecutorConsultaPersonalizada, TFormConsultaEditor.GetProcessEditor);


end.
