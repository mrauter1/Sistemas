unit uConBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DB, DBCtrls, Grids, DBGrids,  StdCtrls, ExtCtrls,
  Buttons, uMVCInterfaces, uFormViewBase, ViewBase, DadosView, CadView;

type
  TfConBase = class(TFormViewBase, IConView)
    Panel1: TPanel;
    LabelCaption: TLabel;
    BtnPesquisa: TBitBtn;
    EditNome: TEdit;
    PesquisaNome: TRadioGroup;
    BoxPesquisa: TRadioGroup;
    Panel2: TPanel;
    DBGrid: TDBGrid;
    Panel3: TPanel;
    BtnSeleciona: TBitBtn;
    DBNavigator: TDBNavigator;
    StatusBar1: TStatusBar;
    BtnSair: TBitBtn;
    procedure BtnSelecionaClick(Sender: TObject);
    procedure BoxPesquisaClick(Sender: TObject);
    procedure BtnPesquisaClick(Sender: TObject);
    procedure Panel1Enter(Sender: TObject);
    procedure DBGridEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ViewSetControle;
    procedure BtnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FOrderBy, FCampoDefault, FCamposResult: String;
    FResultado: Variant;
    FCamposFiltroList: TStringList;
  protected
    procedure UpdateBoxPesquisa;
    procedure FazConsulta; virtual;
    function GetDataSet: TDataSet;
    function GetDescricao(Indice: Integer): String;
    function GetDescricaoByName(NomeCampo: String): String;
    property DataSet: TDataSet read GetDataSet;
  public
    function GetResultado: Variant;
    property Resultado: Variant read GetResultado write FResultado;
    property CamposResult: String read FCamposResult write FCamposResult;
    property CampoDefault: String read FCampoDefault write FCampoDefault;
    property OrderBy: String read FOrderBy write FOrderBy;
    procedure SetCamposFiltro(Campos: String);
  end;

var
  fConBase: TfConBase;

implementation

{$R *.dfm}

function TfConBase.GetResultado: Variant;
begin
  Result:= FResultado;
end;

function TfConBase.GetDataSet: TDataSet;
begin
  if not Assigned(DBGrid.DataSource) then
    raise Exception.Create('N�o h� datasource definido no Grid!');

  Result:= DBGrid.DataSource.DataSet;
end;

function TfConBase.GetDescricao(Indice: Integer): String;
begin
  Result:= DataSet.FieldByName(FCamposFiltroList[Indice]).DisplayLabel;
end;

function TfConBase.GetDescricaoByName(NomeCampo: String): String;
begin
  Result:= DataSet.FieldByName(NomeCampo).DisplayLabel;
end;

procedure TfConBase.BoxPesquisaClick(Sender: TObject);
begin
  LabelCaption.Caption:= '&'+GetDescricao(BoxPesquisa.ItemIndex);
end;

procedure TfConBase.FazConsulta;
var
  sFiltro: String;
begin
  if FCamposFiltroList.Count = 0 then Exit;

  if PesquisaNome.ItemIndex = 0 then
    sFiltro:= ' ('+FCamposFiltroList[BoxPesquisa.ItemIndex]+ ' LIKE '''
      +Trim(EditNome.Text) + '%'') '
  else
    sFiltro:= ' ('+FCamposFiltroList[BoxPesquisa.ItemIndex]+ ' LIKE ''%'
      +Trim(EditNome.Text) + '%'') ';

  sFiltro:= sFiltro+' ORDER BY '+ OrderBy;

  View.CadControle.SetFiltro(sFiltro);//:= sFiltro;
  View.CadControle.Carregar;
end;

procedure TfConBase.BtnPesquisaClick(Sender: TObject);
begin
  StatusBar1.SimpleText:=' Pesquisando...';

  FazConsulta;

  if View.CadControle.IsEmpty then
  begin
    ShowMessage('NADA ENCONTRADO');
  end;

  BtnSeleciona.Enabled:=True;
  DBGrid.SetFocus;
  BtnPesquisa.Enabled:=False;
end;

procedure TfConBase.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfConBase.BtnSelecionaClick(Sender: TObject);
var
  CampoTemp: String;
begin
  if CamposResult <> '' then
    CampoTemp:= CamposResult
  else if FCamposFiltroList.Count > 0 then
    CampoTemp:= FCamposFiltroList[0]
  else CampoTemp:= '';  

  Resultado:= DataSet.FieldValues[CampoTemp];
end;

procedure TfConBase.DBGridEnter(Sender: TObject);
begin
  StatusBar1.SimpleText:=' ENTER-Seleciona  |  ESC-Cancela';
end;

procedure TfConBase.FormCreate(Sender: TObject);
begin
  inherited;
  FCamposFiltroList:= TStringList.Create;
  FCampoDefault:= '';
  FCamposResult:= '';
end;

procedure TfConBase.FormDestroy(Sender: TObject);
begin
  FCamposFiltroList.Free;
  inherited;
end;

procedure TfConBase.FormShow(Sender: TObject);
begin
  inherited;
  UpdateBoxPesquisa;
end;

procedure TfConBase.Panel1Enter(Sender: TObject);
begin
  StatusBar1.SimpleText:=' Nome para pesquisa  |  ENTER-Pesquisa  |  ESC-Sair';
  BtnPesquisa.Enabled:=True;
  BtnSeleciona.Enabled:=False;
end;

procedure TfConBase.SetCamposFiltro(Campos: String);
var
  Pos: Integer;
begin
  FCamposFiltroList.Clear;
  Pos := 1;
  while Pos <= Length(Campos) do
    FCamposFiltroList.Add(ExtractFieldName(Campos, Pos));

  if OrderBy = '' then
    OrderBy:= FCamposFiltroList[0];
end;

procedure TfConBase.UpdateBoxPesquisa;
var
  I: Integer;
begin
  if not Assigned(DBGrid.DataSource) then Exit;
  
  BoxPesquisa.Items.Clear;

  if FCamposFiltroList.Count = 0 then Exit;
  
  for I := 0 to FCamposFiltroList.Count - 1 do
    BoxPesquisa.Items.Add(GetDescricao(i));

  if FCampoDefault <> '' then
    BoxPesquisa.ItemIndex:= FCamposFiltroList.IndexOf(FCampoDefault)
  else BoxPesquisa.ItemIndex:= 0;
  BoxPesquisaClick(Self);
end;

procedure TfConBase.ViewSetControle;
begin
  inherited;
  DBGrid.DataSource:= View.CadControle.GetDataSource;
  DBNavigator.DataSource:= DBGrid.DataSource;
//  UpdateBoxPesquisa;
end;

end.
