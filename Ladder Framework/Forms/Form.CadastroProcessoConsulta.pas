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
  Ladder.Activity.Classes.Dao, Ladder.ORM.DataSetBinding, uConClasses;

type
  TFormCadastroProcessoConsulta = class(TForm)
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
    GroupBox1: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    DsProcesso: TDataSource;
    QryParametros: TFDQuery;
    QryParametrosID: TFDAutoIncField;
    QryParametrosConsulta: TIntegerField;
    QryParametrosNome: TStringField;
    QryParametrosDescricao: TStringField;
    QryParametrosTipo: TIntegerField;
    QryParametrosSql: TMemoField;
    QryParametrosOrdem: TIntegerField;
    QryParametrosTamanho: TIntegerField;
    QryParametrosObrigatorio: TBooleanField;
    QryParametrosValorPadrao: TMemoField;
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
    TblProcesso: TFDMemTable;
    TblProcessoIDActivity: TIntegerField;
    TblProcessoName: TMemoField;
    TblProcessoDescription: TMemoField;
    TblProcessoClassName: TMemoField;
    TblProcessoExecutorClass: TMemoField;
    TblProcessoID: TIntegerField;
    procedure BtnOKClick(Sender: TObject);
  private
    FOK: Boolean;
    FProcesso: TProcessoBase;
    FProcessoDao: IDaoGeneric<TProcessoBase>;
    FProcessoBinder: TDataSetBinder;
    procedure CriaParametrosNaTela(pBox: TWinControl);
    function GetNomeConsulta(pIDConsulta: Integer): String;
    { Private declarations }
  public
    { Public declarations }
    property Processo: TProcessoBase read FProcesso write FProcesso;

    constructor Create(AOwner: TComponent); override;

    function NewProcess: TProcessoBase;
    procedure EditProcess(pProcesso: TProcessoBase);

    class function _NewProcess: TProcessoBase;
    class procedure _EditProcess(pProcesso: TProcessoBase);
  end;

  type
    Consulta = record

    end;

implementation

{$R *.dfm}

uses
  Ladder.ServiceLocator, Ladder.Executor.ConsultaPersonalizada, VCL.Checklst, uConsultaPersonalizada,
  Ladder.Utils;

{ TFormCadastroProcessoConsulta }

function TFormCadastroProcessoConsulta.NewProcess: TProcessoBase;
var
  FIDConsulta: Integer;
  FConsulta: RConsulta;
begin
  Result:= nil;

  FIDConsulta:= TFormSelecionaConsulta.SelecionaConsulta;
  if FIDConsulta = 0 then
    Exit;

  FConsulta:= Default(RConsulta);
  TFrwServiceLocator.Context.DaoUtils.SelectAsRecord(Fconsulta, TypeInfo(RConsulta),
                Format('SELECT * FROM Cons.Consultas where ID = %d', [FIDConsulta]));

  FProcesso:= TProcessoBase.Create(TExecutorConsultaPersonalizada.GetExecutor, TFrwServiceLocator.Context.DaoUtils);
  FProcesso.Name:= 'Consulta'+FConsulta.Nome;
  FProcesso.Description:= GetNomeConsulta(FIDConsulta);

  FProcesso.Inputs.Add(TParameter.Create('IDConsulta', tbValue, IntToStr(FIDConsulta)));

  FProcessoBinder.PullFromObject(FProcesso);

  QryParametros.Params[0].AsInteger:= FIDConsulta;
  QryParametros.Open;

  CriaParametrosNaTela(ScrollBoxParametros);

  Result:= FProcesso;
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

procedure TFormCadastroProcessoConsulta.BtnOKClick(Sender: TObject);
begin
  if TblProcesso.State in ([dsEdit,dsInsert]) then
    TblProcesso.Post;

  FProcessoBinder.PushToObject(FProcesso);
  FOk:= True;
  Close;
end;

constructor TFormCadastroProcessoConsulta.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOk:= True;
  ArquivosExport.Active:= True;
  FProcessoDao:= TProcessoDao<TProcessoBase>.Create;
  TblProcesso.Active:= True;
  FProcessoBinder:= TDataSetBinder.Create(TblProcesso, FProcessoDao.ModeloBD);

  DataSetMemoFieldsAsText(TblProcesso);
end;

procedure TFormCadastroProcessoConsulta.EditProcess(pProcesso: TProcessoBase);
begin
  FProcesso:= pProcesso;
  FProcessoBinder.PullFromObject(FProcesso);
end;

procedure TFormCadastroProcessoConsulta.CriaParametrosNaTela(pBox: TWinControl);
var
  FTop: Integer;
  FPageControl: TPageControl;

  function CriaLabel(pParent: TWinControl; pID: Variant; pDescricao: String): TLabel;
  begin
    Result:= TLabel.Create(pParent);
    with Result do
    begin
      Visible   := true;
      Left      := 4;
      Top       := FTop+16;
      Height    := 17;
      AutoSize  := True;
      WordWrap  := True;
      Width     := 70;
      Alignment := taRightJustify;
      Caption   := pDescricao;
      Name      := 'L'+VarToStr(pID);
      Font.Color:=ClBlue;
      Parent    := pParent;
    end;
  end;

  function GetControlHeight(pTipo: TTipoParametro): Integer;
  begin
    case TTipoParametro(QryParametrosTipo.AsInteger) of
      ptCheckListBox: Result:= 70
      else Result:= 20;
    end;
  end;

  function CriaEdit(pBox: TWinControl): TEdit;
  begin
    Result:= TEdit.Create(pBox);
    with Result do
    begin
      Visible   := true;
      Align     := alClient;
      Name      := 'E'+IntToStr(QryParametrosID.Value);
      Text      := '';
      Parent    := pBox;
    end;
  end;

  function CreateTabSheet(pPageControl: TPageControl; pCaption: String; pName: String): TTabSheet;
  begin
    Result:= TTabSheet.Create(pPageControl);
    Result.Caption:= pCaption;
    Result.Name:= pName;
    Result.Parent:= pPageControl;
    Result.PageControl:= pPageControl;
  end;

  function CriaPageControl(pBox: TWinControl): TPageControl;
  begin
    Result:= TPageControl.Create(pBox);
    with Result do
    begin
      Visible   := true;
      Top       := FTop;
      Left      := 80;
      Width     := pBox.ClientWidth-Left-10;
      Anchors   := [aktop, akLeft, akRight];
      Name      := 'PG'+QryParametrosID.AsString;
      Height    := GetControlHeight(TTipoParametro(QryParametrosTipo.AsInteger))+22;
      Parent    := pBox;
      CreateTabSheet(Result, 'Expressão', 'TE'+QryParametrosID.AsString);
      CreateTabSheet(Result, 'Valor', 'TV'+QryParametrosID.AsString);
      TabIndex  := 1;
      TabHeight:= 14;
      Font.Size:= 7;
    end;
  end;

  function CriaParComboBox(pBox: TWinControl; pValorPadrao: Variant; pSql: String): TComboBox;
  begin
    Result:= TComboBox.Create(pBox);
    with Result do
    begin
      Visible   := true;
      Top:= 0;
      Left:= 0;
//      Align     := alClient;
      Style     := csOwnerDrawFixed;
      Name      := 'V'+IntToStr(QryParametrosID.Value);
      PopulaComboBoxQry(Result, pSql, pValorPadrao);
      Parent    := pBox;
    end;
  end;

  function CriaParMaskEdit(pBox: TWinControl; pValorPadrao: Variant; pSql: String): TMaskEdit;
  begin
    Result:= TMaskEdit.Create(pBox);
    with Result do
    begin
      Visible   := true;
      Top:= 0;
      Left:= 0;
//      Align     := alClient;
      Name      := 'V'+IntToStr(QryParametrosID.Value);
      Text      := VarToStrDef(pValorPadrao, '');
      Parent    := pBox;
    end;
  end;

  function CriaDateTimePicker(pBox: TWinControl; pValorPadrao: Variant; pSql: String): TDateTimePicker;
  begin
    Result:= TDateTimePicker.Create(pBox);
    with Result do
    begin
      Visible   := true;
      Top:= 0;
      Left:= 0;
//      Align     := alClient;
      Name      := 'V'+IntToStr(QryParametrosID.Value);
      if LadderVarIsDateTime(pValorPadrao) then
        Date:= LadderVarToDateTime(pValorPadrao);

      Parent    := pBox;
    end;
  end;

  function CriaParChecklistBox(pBox: TWinControl; pValorPadrao: Variant; pSql: String): TCheckListBox;
  var
   FScrollBox: TScrollBox;
  begin
    FScrollBox:= TScrollBox.Create(pBox);
    with FScrollBox do
    begin
      Visible   := true;
      Align     := alClient;
      Name      := 'S'+IntToStr(QryParametrosID.Value);
      BevelEdges:= [];
      BevelKind:= TBevelKind.bkNone;
      BevelOuter:= bvNone;
      BorderStyle:= bsNone;
      BorderWidth:= 0;
      Parent    := pBox;
    end;
    Result:= TCheckListBox.Create(FScrollBox);
    with Result do
    begin
      Visible   := true;
      Top       := 0;
      Left      := 0;
      Name      := 'V'+IntToStr(QryParametrosID.Value);
      Width     := FScrollBox.ClientWidth;
      Height    := 100;
      Parent    := FScrollBox;
      PopulaCheckListBoxQry(Result, pSql, pValorPadrao);
    end;
  end;

const
  cMaxHeight = 250;

begin
  FTop:= 0;
  QryParametros.First;
  while not QryParametros.Eof do
  begin
    CriaLabel(pBox, QryParametrosID.Value, QryParametrosDescricao.AsString);
    FPageControl:= CriaPageControl(pBox);
    CriaEdit(FPageControl.Pages[0]);
    case TTipoParametro(QryParametrosTipo.AsInteger) of
      ptComboBox: CriaParCombobox(FPageControl.Pages[1], QryParametrosValorPadrao.Value, QryParametrosSql.AsString);
      ptTexto: CriaParMaskEdit(FPageControl.Pages[1], QryParametrosValorPadrao.Value, QryParametrosSql.AsString);
      ptDateTime: CriaDateTimePicker(FPageControl.Pages[1], QryParametrosValorPadrao.Value, QryParametrosSql.AsString);
      ptCheckListBox: CriaParCheckListBox(FPageControl.Pages[1], QryParametrosValorPadrao.Value, QryParametrosSql.AsString);
    end;

    FTop:= FPageControl.Top+FPageControl.Height+3;
    QryParametros.Next;
  end;

  if FTop >= cMaxHeight then
    Self.Height:= Self.Height + cMaxHeight - ScrollBoxParametros.Height
  else
    Self.Height:= Self.Height + FTop - ScrollBoxParametros.Height;


end;

end.
