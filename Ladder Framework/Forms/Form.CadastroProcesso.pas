unit Form.CadastroProcesso;

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
  Vcl.CheckLst;

type
  TFormCadastroProcesso = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBoxInputs: TGroupBox;
    BtnOK: TBitBtn;
    Label2: TLabel;
    DBEditIDConsulta: TDBEdit;
    DsAvisoConsulta: TDataSource;
    QryAvisoConsulta: TFDQuery;
    QryAvisoConsultaIDAviso: TIntegerField;
    QryAvisoConsultaIDConsulta: TIntegerField;
    QryAvisoConsultaTipoVisualizacao: TIntegerField;
    QryInputs: TFDQuery;
    DsInputs: TDataSource;
    QryAvisoConsultaTitulo: TStringField;
    GroupBox1: TGroupBox;
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
    Label1: TLabel;
    DBTipoProcesso: TDBComboBox;
    QryOutputs: TFDQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    MemoField1: TMemoField;
    DsOutputs: TDataSource;
    ScrollBox1: TScrollBox;
    QryInputsID: TFDAutoIncField;
    QryInputsConsulta: TIntegerField;
    QryInputsNome: TStringField;
    QryInputsDescricao: TStringField;
    QryInputsTipo: TIntegerField;
    QryInputsSql: TMemoField;
    QryInputsOrdem: TIntegerField;
    QryInputsTamanho: TIntegerField;
    QryInputsObrigatorio: TBooleanField;
    QryInputsValorPadrao: TMemoField;
    Label5: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBEdit2: TDBEdit;
    procedure BtnSelecionarRelatorioClick(Sender: TObject);
    procedure DBEditIDConsultaChange(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    function GetNomeConsulta(pIDConsulta: Integer): String;
    function PostSeEmEdicao(pQry: TDataSet): Boolean;
    procedure SetDadosConsultaAtual;
    procedure SetDadosConsultaDefault;
    procedure CriaParametrosNaTela(pBox: TWinControl);
    { Private declarations }
  public
    { Public declarations }
    procedure AbrirConfig(pIDAviso, pIDConsulta: Integer);
    class procedure AbrirConfigRelatorio(pIDAviso, pIDConsulta: Integer); static;
  end;

implementation

{$R *.dfm}

uses
  Form.SelecionaConsulta, GerenciadorUtils, uConClasses;

procedure TFormCadastroProcesso.AbrirConfig(pIDAviso, pIDConsulta: Integer);
begin
  QryAvisoConsulta.Close;
  QryAvisoConsulta.ParamByName('IDAviso').AsInteger:= pIDAviso;
  QryAvisoConsulta.ParamByName('IDConsulta').AsInteger:= pIDConsulta;
  QryAvisoConsulta.Open;

  QryInputs.Close;
  QryInputs.ParamByName('IDAviso').AsInteger:= pIDAviso;
  QryInputs.ParamByName('IDConsulta').AsInteger:= pIDConsulta;
  QryInputs.Open;

  if QryAvisoConsulta.IsEmpty then
  begin
    ShowMessage('Consulta cod.: '+IntToStr(pIDConsulta)+' não encontrada.');
    Exit;
  end;

  QryAvisoConsulta.Edit;

  ShowModal;
end;

class procedure TFormCadastroProcesso.AbrirConfigRelatorio(pIDAviso, pIDConsulta: Integer);
var
  FFrm: TFormCadastroProcesso;
begin
  FFrm:= TFormCadastroProcesso.Create(Application);
  try
    FFrm.AbrirConfig(pIDAviso, pIDConsulta);
  finally
    FFrm.Free;
  end;
end;

procedure TFormCadastroProcesso.BtnOKClick(Sender: TObject);
begin
  PostSeEmEdicao(QryAvisoConsulta);

  Close;
end;

procedure TFormCadastroProcesso.BtnSelecionarRelatorioClick(Sender: TObject);
var
  FIDConsulta: Integer;
begin
  FIDConsulta:= TFormSelecionaConsulta.SelecionaConsulta;
  if FIDConsulta = 0 then
    Exit;

  if not (QryAvisoConsulta.State in [dsEdit, dsInsert]) then
    QryAvisoConsulta.Edit;

  QryAvisoConsultaIDConsulta.AsInteger:= FIDConsulta;
  SetDadosConsultaDefault;
end;

procedure TFormCadastroProcesso.CriaParametrosNaTela(pBox: TWinControl);
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
      Top       := FTop;
      Height    := 17;
      AutoSize  := True;
      WordWrap  := True;
      Width     := 120;
      Alignment := taRightJustify;
      Caption   := pDescricao;
      Name      := 'L'+VarToStr(pID);
      Parent    := pParent;
      Font.Color:=ClBlue;
    end;
  end;

  function GetControlHeight(pTipo: TTipoParametro): Integer;
  begin
    case TTipoParametro(QryInputsTipo.AsInteger) of
      ptCheckListBox: Result:= 70
      else Result:= 20;
    end;
  end;

  function CreateTabSheet(pPageControl: TPageControl; pCaption: String; pName: String): TTabSheet;
  begin
    Result:= TTabSheet.Create(pPageControl);
    Result.Caption:= pCaption;
    Result.Name:= pName;
    Result.Parent:= pPageControl;
  end;

  function CriaPageControl(pBox: TWinControl): TPageControl;
  begin
    Result:= TPageControl.Create(pBox);
    with Result do
    begin
      Visible   := true;
      Top       := FTop;
      Left      := 126;
      TabHeight:= 12;
      Width     := pBox.ClientWidth-Left-10;
      Anchors   := [aktop, akLeft, akRight];
      Name      := 'PG'+QryInputsID.AsString;
      CreateTabSheet(Result, 'Expressão', 'TE'+QryInputsID.AsString);
      CreateTabSheet(Result, 'Valor', 'TV'+QryInputsID.AsString);
      Height    := GetControlHeight(TTipoParametro(QryInputsTipo.AsInteger))+22;
      Parent    := pBox;
    end;
  end;

  function CriaParComboBox(pBox: TWinControl): TComboBox;
  begin
    Result:= TComboBox.Create(pBox);
    with Result do
    begin
      Visible   := true;
      Align     := alClient;
      Style     := csOwnerDrawFixed;
      Name      := 'V'+IntToStr(QryInputsID.Value);
      Parent    := pBox;
    end;
  end;

  function CriaParText(pBox: TWinControl): TComboBox;
  begin
    Result:= TComboBox.Create(pBox);
    with Result do
    begin
      Visible   := true;
      Align     := alClient;
      Style     := csOwnerDrawFixed;
      Name      := 'V'+IntToStr(QryInputsID.Value);
      Parent    := pBox;
    end;
  end;

  function CriaParMaskEdit(pBox: TWinControl): TMaskEdit;
  begin
    Result:= TMaskEdit.Create(pBox);
    with Result do
    begin
      Visible   := true;
      Align     := alClient;
      Name      := 'V'+IntToStr(QryInputsID.Value);
      Parent    := pBox;
    end;
  end;

  function CriaDateTimePicker(pBox: TWinControl): TDateTimePicker;
  begin
    Result:= TDateTimePicker.Create(pBox);
    with Result do
    begin
      Visible   := true;
      Align     := alClient;
      Name      := 'V'+IntToStr(QryInputsID.Value);
      Parent    := pBox;
    end;
  end;

  function CriaParChecklistBox(pBox: TWinControl): TCheckListBox;
  var
   FScrollBox: TScrollBox;
  begin
    FScrollBox:= TScrollBox.Create(pBox);
    with FScrollBox do
    begin
      Visible   := true;
      Align     := alClient;
      Name      := 'S'+IntToStr(QryInputsID.Value);
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
      Name      := 'V'+IntToStr(QryInputsID.Value);
      Width     := FScrollBox.ClientWidth;
      Height    := 100;
      Parent    := FScrollBox;
    end;
  end;

begin
  FTop:= 0;
  QryInputs.First;
  while not QryInputs.Eof do
  begin
    CriaLabel(pBox, QryInputsID.Value, QryInputsDescricao.AsString);
    FPageControl:= CriaPageControl(pBox);
    case TTipoParametro(QryInputsTipo.AsInteger) of
      ptComboBox: CriaParCombobox(FPageControl.Pages[1]);
      ptTexto: CriaParText(FPageControl.Pages[1]);
      ptDateTime: CriaDateTimePicker(FPageControl.Pages[1]);
      ptCheckListBox: CriaParCheckListBox(FPageControl.Pages[1]);
    end;

    FTop:= FPageControl.Top+FPageControl.Height+3;
    QryInputs.Next;
  end;
end;

function TFormCadastroProcesso.GetNomeConsulta(pIDConsulta: Integer): String;
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

procedure TFormCadastroProcesso.DBEditIDConsultaChange(Sender: TObject);
begin
  SetDadosConsultaAtual;
end;

procedure TFormCadastroProcesso.SetDadosConsultaAtual;
begin
  GetNomeConsulta(QryAvisoConsultaIDConsulta.AsInteger);
end;

function TFormCadastroProcesso.PostSeEmEdicao(pQry: TDataSet): Boolean;
begin
  Result:= pQry.State in [dsEdit, dsInsert];

  if Result then
    pQry.Post;
end;

procedure TFormCadastroProcesso.SetDadosConsultaDefault;
const
  cSql = 'SELECT * FROM cons.Consultas where ID = %d';
var
  FDataSet: TDataSet;
  FNome: String;
begin
  FNome:= '';
  FDataSet:= ConSqlServer.RetornaDataSet(Format(cSql, [QryAvisoConsultaIDConsulta.AsInteger]));
  try
    QryAvisoConsultaTitulo.AsString:= FDataSet.FieldByName('Descricao').AsString;
    QryAvisoConsultaTipoVisualizacao.AsInteger:= FDataSet.FieldByName('VisualizacaoPadrao').AsInteger;
  finally
    FDataSet.Free;
  end;
end;

procedure TFormCadastroProcesso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PostSeEmEdicao(QryInputs);
  PostSeEmEdicao(QryAvisoConsulta);
end;

procedure TFormCadastroProcesso.FormCreate(Sender: TObject);
begin
  //LblConsulta.Caption:= '';
//  FazLookupCxGrid(cxGridParametrosDBTableView1Nome, 'SELECT ID, DESCRICAO FROM cons.Parametros');
end;

end.
