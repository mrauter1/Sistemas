unit Form.CadastroProcessoConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.Buttons, Vcl.ExtCtrls,
  Ladder.Activity.Classes, Form.SelecionaConsulta, Ladder.ORM.Dao,
  Ladder.Activity.Classes.Dao, Ladder.ORM.ObjectDataSet, uConClasses, uConClasses.Dao,
  Form.ProcessEditor;

type
  TFormCadastroProcessoConsulta = class(TProcessEditor, IProcessEditor)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BtnOK: TBitBtn;
    DBEditIDConsulta: TDBEdit;
    DBEditNomeProcesso: TDBEdit;
    DBEditDescription: TDBEdit;
    Panel2: TPanel;
    GroupBoxInputs: TGroupBox;
    GroupBoxOutputs: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    DsProcesso: TDataSource;
    QrParametros: TFDQuery;
    QrParametrosID: TFDAutoIncField;
    QrParametrosConsulta: TIntegerField;
    QrParametrosNome: TStringField;
    QrParametrosDescricao: TStringField;
    QrParametrosTipo: TIntegerField;
    QrParametrosSql: TMemoField;
    QrParametrosOrdem: TIntegerField;
    QrParametrosTamanho: TIntegerField;
    QrParametrosObrigatorio: TBooleanField;
    QrParametrosValorPadrao: TMemoField;
    DsParametros: TDataSource;
    QryOutputs: TFDQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    MemoField1: TMemoField;
    DsOutputs: TDataSource;
    GroupBox2: TGroupBox;
    ScrollBoxParametros: TScrollBox;
    GridArquivos: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    ArquivosExport: TFDMemTable;
    ArquivosExportDescription: TStringField;
    ArquivosExportVisualizacao: TStringField;
    ArquivosExportTipoVisualizacao: TStringField;
    ArquivosExportNomeArquivo: TStringField;
    DsArquivosExport: TDataSource;
    cxGridDBTableView2Description: TcxGridDBColumn;
    cxGridDBTableView2Visualizacao: TcxGridDBColumn;
    cxGridDBTableView2TipoVisualizacao: TcxGridDBColumn;
    cxGridDBTableView2NomeArquivo: TcxGridDBColumn;
    TbProcesso: TFDMemTable;
    TbProcessoIDActivity: TIntegerField;
    TbProcessoName: TMemoField;
    TbProcessoDescription: TMemoField;
    TbProcessoClassName: TMemoField;
    TbProcessoExecutorClass: TMemoField;
    TbProcessoID: TIntegerField;
  private
    FConsulta: TConsulta;
    ConsultaDao: IConsultaDao<TConsulta>;
//    procedure CriaParametrosNaTela(pBox: TWinControl);
    function GetNomeConsulta(pIDConsulta: Integer): String;
    function GetConsulta(AProcess: TProcessoBase): TConsulta;
    procedure RecreateParamertosDef;
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
  Ladder.ServiceLocator, Ladder.Executor.ConsultaPersonalizada, VCL.Checklst, uConsultaPersonalizada,
  Ladder.Utils, Utils, Ladder.Activity.Parser, SynCommons, System.Generics.Collections;

{ TFormCadastroProcessoConsulta }

function TFormCadastroProcessoConsulta.NewProcess: TProcessoBase;
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

procedure TFormCadastroProcessoConsulta.EditProcess(pProcesso: TProcessoBase);
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

function TFormCadastroProcessoConsulta.GetConsulta(AProcess: TProcessoBase): TConsulta;
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

procedure TFormCadastroProcessoConsulta.RecreateParamertosDef;
var
  FParametro: TParametroCon;
begin
  ParametrosDef.Clear;
  for FParametro in FConsulta.Parametros do
    ParametrosDef.Add(FParametro.CreateCopy(FParametro));
end;

function TFormCadastroProcessoConsulta.Form: TForm;
begin
  Result:= Self;
end;

class procedure TFormCadastroProcessoConsulta._EditProcess(
  pProcesso: TProcessoBase);
var
  vFrm: TFormCadastroProcessoConsulta;
begin
  vFrm:= TFormCadastroProcessoConsulta.Create(nil);
  try
    vFrm.EditProcess(pProcesso);
    vFrm.ShowModal;
  finally
    vFrm.Free;
  end;
end;

class function TFormCadastroProcessoConsulta._NewProcess: TProcessoBase;
var
  vFrm: TFormCadastroProcessoConsulta;
begin
  vFrm:= TFormCadastroProcessoConsulta.Create(nil);
  try
    Result:= vFrm.NewProcess;
    vFrm.ShowModal;
  finally
    vFrm.Free;
  end;
end;

function TFormCadastroProcessoConsulta.GetNomeConsulta(pIDConsulta: Integer): String;
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

class function TFormCadastroProcessoConsulta.GetProcessEditor(
  AOwner: TComponent): IProcessEditor;
begin
  Result:= Self.Create(AOwner);
end;

constructor TFormCadastroProcessoConsulta.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TObjectList<TParametroCon>.Create, TOutputList.Create, ActivityManager.GetExecutor(TExecutorConsultaPersonalizada));
  ArquivosExport.Active:= True;

  ConsultaDao:= TConsultaDao<TConsulta>.Create;
end;

destructor TFormCadastroProcessoConsulta.Destroy;
begin
  if Assigned(FConsulta) then
    FConsulta.Free;
end;

initialization
  TFrwServiceLocator.Context.ActivityManager.RegisterProcessEditor(TExecutorConsultaPersonalizada, TFormCadastroProcessoConsulta.GetProcessEditor);

end.
