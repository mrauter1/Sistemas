unit Form.CadastroAtividade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls, Data.DB, cxGraphics, cxControls, cxLookAndFeels,
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
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uConSqlServer, Ladder.Activity.Classes,
  Ladder.ORM.Dao, Ladder.Activity.Classes.Dao, Ladder.ORM.DataSetBinding,
  Ladder.ORM.ObjectDataSet;

type
  TFormCadastroAtividade = class(TForm)
    PanelTop: TPanel;
    PanelCentro: TPanel;
    DBEditNomeAtividade: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEditID: TDBEdit;
    GroupBoxProcessos: TGroupBox;
    PanelControles: TPanel;
    DBGridRelatorios: TDBGrid;
    Panel1: TPanel;
    BtnAddProcesso: TBitBtn;
    BtnRemoveProcesso: TBitBtn;
    BtnConfiguraProcesso: TBitBtn;
    PanelBot: TPanel;
    BtnSalvar: TBitBtn;
    DsAtividade: TDataSource;
    BtnFechar: TBitBtn;
    DsProcessos: TDataSource;
    DBEditDescricao: TDBEdit;
    Label3: TLabel;
    GroupBoxInputs: TGroupBox;
    cxGridParametros: TcxGrid;
    cxGridParametrosDBTableView1: TcxGridDBTableView;
    cxGridParametrosDBTableView1IDParametro: TcxGridDBColumn;
    cxGridParametrosDBTableView1Nome: TcxGridDBColumn;
    cxGridParametrosDBTableView1Valor: TcxGridDBColumn;
    cxGridParametrosLevel1: TcxGridLevel;
    GroupBox1: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    QryInputs: TFDQuery;
    QryInputsIDAviso: TIntegerField;
    QryInputsIDConsulta: TIntegerField;
    QryInputsIDParametro: TIntegerField;
    QryInputsValor: TMemoField;
    DsInputs: TDataSource;
    DsOutputs: TDataSource;
    QryOutputs: TFDQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    MemoField1: TMemoField;
    TblProcessos: TFDMemTable;
    TblProcessosID: TIntegerField;
    TblProcessosIDActivity: TIntegerField;
    TblProcessosName: TMemoField;
    TblProcessosDescription: TMemoField;
    TblProcessosClassName: TMemoField;
    TblProcessosExecutorClass: TMemoField;
    TbActivity: TFDMemTable;
    TbActivityIDActivity: TIntegerField;
    TbActivityName: TMemoField;
    TbActivityDescription: TMemoField;
    TbActivityClassName: TMemoField;
    TbActivityExecutorClass: TMemoField;
    TbActivityID: TIntegerField;
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAddProcessoClick(Sender: TObject);
    procedure BtnRemoveProcessoClick(Sender: TObject);
    procedure BtnConfiguraProcessoClick(Sender: TObject);
    procedure FieldGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FieldSetText(Sender: TField; const Text: string);
  private
    FActivity: TActivity;
    FActivityDao: IDaoGeneric<TActivity>;

    FActivityDataSet: TObjectDataSet;
    FProcessoDataSet: TObjectDataSet;
    procedure RemoverProcesso;
    procedure ConfigurarConsultaAtual;
    function GetProcessoSelecionado: TProcessoBase;
    function ProcessoDao: IDaoBase;
    function NovaAtividade: TActivity;
    { Private declarations }
  public
    constructor Create(AOWner: TComponent); override;
    procedure AbrirConfig(pAtividade: TActivity);

    class procedure _AbrirConfigAviso(pAtividade: TActivity);
    class function _NovaAtividade: TActivity;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  Form.CadastroProcessoConsulta, Form.SelecionaConsulta, Ladder.ServiceLocator;

{ TuFormCadastrarAvisosAutomaticos }

procedure TFormCadastroAtividade.AbrirConfig(pAtividade: TActivity);
begin
  FActivity:= pAtividade;

  FActivityDataSet.SetObject(FActivity);
  FProcessoDataSet.SetObjectList<TProcessoBase>(FActivity.Processos);

  ShowModal;
end;

function TFormCadastroAtividade.NovaAtividade: TActivity;
begin
  FActivity:= TActivity.Create(TFrwServiceLocator.Context.DaoUtils);
  FActivityDataSet.SetObject(FActivity);
  FProcessoDataSet.SetObjectList<TProcessoBase>(FActivity.Processos);

  ShowModal;
end;

class procedure TFormCadastroAtividade._AbrirConfigAviso(pAtividade: TActivity);
var
  FFrm: TFormCadastroAtividade;
begin
  FFrm:= TFormCadastroAtividade.Create(Application);
  try
    FFrm.AbrirConfig(pAtividade);
  finally
    FFrm.Free;
  end;
end;


class function TFormCadastroAtividade._NovaAtividade: TActivity;
var
  FFrm: TFormCadastroAtividade;
begin
  FFrm:= TFormCadastroAtividade.Create(Application);
  try
    Result:= FFrm.NovaAtividade;
  finally
    FFrm.Free;
  end;
end;

procedure TFormCadastroAtividade.BtnConfiguraProcessoClick(Sender: TObject);
begin
  ConfigurarConsultaAtual;
end;

procedure TFormCadastroAtividade.BtnAddProcessoClick(Sender: TObject);
var
  FIDConsulta: Integer;
  FProcesso: TProcessoBase;
begin
  FProcesso:= TFormCadastroProcessoConsulta._NewProcess;

  if Assigned(FProcesso) then
  begin
    FActivity.Processos.Add(FProcesso);
    FProcessoDataSet.Synchronize;
  end;
end;

function TFormCadastroAtividade.GetProcessoSelecionado: TProcessoBase;
var
  FProcesso: TProcessoBase;
begin
  Result:= nil;
  for FProcesso in FActivity.Processos do
    if FProcesso.ID = TblProcessosID.AsInteger then
    begin
      Result:= FProcesso;
      break;
    end;
end;

procedure TFormCadastroAtividade.ConfigurarConsultaAtual;
var
  FProcesso: TProcessoBase;
begin
  FProcesso:= GetProcessoSelecionado;
  if Assigned(FProcesso) then
    TFormCadastroProcessoConsulta._EditProcess(FProcesso);

  FProcessoDataSet.Synchronize;
end;

function TFormCadastroAtividade.ProcessoDao: IDaoBase;
begin
  Result:= FActivityDao.ChildDaoByPropName('Processos');
end;

constructor TFormCadastroAtividade.Create(AOWner: TComponent);
begin
  inherited;
  FActivityDao:= TActivityDao<TActivity>.Create;
  FActivityDataSet:= TObjectDataSet.Create(Self, FActivityDao.ModeloBD);
  FProcessoDataSet:= TObjectDataSet.Create(Self, ProcessoDao.ModeloBD);

  DataSetMemoFieldsAsText(FActivityDataSet);
  DataSetMemoFieldsAsText(FProcessoDataSet);

  DsAtividade.DataSet:= FActivityDataSet;
  DsProcessos.DataSet:= FProcessoDataSet;
end;

procedure TFormCadastroAtividade.FieldGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text:= Sender.AsString;
end;

procedure TFormCadastroAtividade.FieldSetText(Sender: TField;
  const Text: string);
begin
  Sender.AsString:= Text;
end;

procedure TFormCadastroAtividade.BtnFecharClick(Sender: TObject);
begin
  if FActivityDataSet.Modified then
    if Application.MessageBox('Existem modifica��es n�o salvas, deseja sair sem salvar?', 'Aten��o!',  MB_YESNO) = ID_Yes then
      Close;

end;

procedure TFormCadastroAtividade.RemoverProcesso;
var
  FProcesso: TProcessoBase;
begin
  if not TblProcessos.IsEmpty then
  begin
    if Application.MessageBox('Voc� tem certeza que deseja excluir este proesso?', 'Aten��o!',  MB_YESNO) = ID_YES  then
    begin
      FProcesso:= GetProcessoSelecionado;

      if Assigned(FProcesso) then
      begin
        ProcessoDao.Delete(FProcesso, FActivity);
        FProcessoDataSet.Synchronize;
      end;
    end;
  end;
end;

procedure TFormCadastroAtividade.BtnRemoveProcessoClick(Sender: TObject);
begin
  RemoverProcesso;
end;

procedure TFormCadastroAtividade.BtnSalvarClick(Sender: TObject);
begin
  if FActivityDataSet.State in ([dsEdit, dsInsert])  then
    FActivityDataSet.Post;

  FActivityDao.Save(FActivity);
end;

end.
