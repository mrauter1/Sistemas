unit uFormEmailEmbalagens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.StdCtrls,
  system.Generics.Collections, cxCheckBox, Vcl.Buttons, Vcl.Menus, uConSqlServer;

type
  TFormGravaEmbalagens = class(TForm)
    Panel2: TPanel;
    cxGridEmbalagens: TcxGrid;
    cxGridViewClientes: TcxGridDBTableView;
    cxGridEmbalagensDBTableView1: TcxGridDBTableView;
    cxGridClientesLevel: TcxGridLevel;
    Label1: TLabel;
    Label2: TLabel;
    BtnAtualizar: TButton;
    DataIniPicker: TDateTimePicker;
    DataFimPicker: TDateTimePicker;
    QryEmbalagens: TFDQuery;
    DsEmbalagens: TDataSource;
    QryEmbalagensdatacomprovante: TDateField;
    QryEmbalagenscodproduto: TStringField;
    QryEmbalagensapresentacao: TStringField;
    cxGridViewClientesCODCLIENTE: TcxGridDBColumn;
    QryEmbalagenscodcliente: TStringField;
    cxGridEmbalagensDBTableView2: TcxGridDBTableView;
    cxGridEmbalagensDBTableView2codcliente: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2datacomprovante: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2codproduto: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2apresentacao: TcxGridDBColumn;
    QryEmbalagensnumero: TStringField;
    QryEmbalagensserie: TStringField;
    cxGridEmbalagensDBTableView2numero: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2serie: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2NOMECLIENTE: TcxGridDBColumn;
    QryEmbalagensSelecionado: TBooleanField;
    cxGridEmbalagensDBTableView2Selecionado: TcxGridDBColumn;
    cxGridViewClientesSelecionado: TcxGridDBColumn;
    QryEmbalagenschavenfpro: TStringField;
    cxGridEmbalagensDBTableView2chavenfpro: TcxGridDBColumn;
    Panel1: TPanel;
    BtnSeleciona: TBitBtn;
    cxGridViewClienteschavenfpro: TcxGridDBColumn;
    cxGridViewClientesdatacomprovante: TcxGridDBColumn;
    cxGridViewClientesnumero: TcxGridDBColumn;
    cxGridViewClientesserie: TcxGridDBColumn;
    cxGridViewClientescodproduto: TcxGridDBColumn;
    cxGridViewClientesapresentacao: TcxGridDBColumn;
    PopupMenu: TPopupMenu;
    EmbalagensCli1: TMenuItem;
    CheckBoxMostrarIgnorados: TCheckBox;
    EditCliente: TEdit;
    Label3: TLabel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleVermelho: TcxStyle;
    cxStyleAmarelo: TcxStyle;
    QryEmbalagensstatus: TIntegerField;
    cxGridViewClientesstatus: TcxGridDBColumn;
    IgnorarEmbalagem1: TMenuItem;
    DeixardeIgnorarEmbalagem1: TMenuItem;
    N1: TMenuItem;
    QryEmbalagensQuantAtendida: TBCDField;
    cxGridViewClientesQuantAtendida: TcxGridDBColumn;
    QryEmbalagensCHAVENF: TStringField;
    QryEmbalagensRAZAOSOCIAL: TStringField;
    QryEmbalagensCIDADE: TStringField;
    QryEmbalagensTOTPAGO: TFMTBCDField;
    QryEmbalagensEntregaParcial: TStringField;
    QryEmbalagensVALTOTAL: TBCDField;
    cxGridViewClientesRAZAOSOCIAL: TcxGridDBColumn;
    cxGridViewClientesCIDADE: TcxGridDBColumn;
    cxGridViewClientesCHAVENF: TcxGridDBColumn;
    cxGridViewClientesTOTPAGO: TcxGridDBColumn;
    cxGridViewClientesVALTOTAL: TcxGridDBColumn;
    cxGridViewClientesEntregaParcial: TcxGridDBColumn;
    CheckBoxMostrarEnviados: TCheckBox;
    BtnEnviarEmail: TButton;
    QryEmbalagensDESCSTATUS: TStringField;
    cxGridViewClientesDESCSTATUS: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QryEmbalagensAfterPost(DataSet: TDataSet);
    procedure QryEmbalagensCalcFields(DataSet: TDataSet);
    procedure QryEmbalagensAfterGetRecord(DataSet: TFDDataSet);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure cxGridViewClientesCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure QryClientesCalcFields(DataSet: TDataSet);
    procedure QryClientesAfterClose(DataSet: TDataSet);
    procedure QryEmbalagensAfterClose(DataSet: TDataSet);
    procedure BtnSelecionaClick(Sender: TObject);
    procedure EmbalagensCli1Click(Sender: TObject);
    procedure cxGridViewClientesStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure CheckBoxMostrarIgnoradosClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure DeixardeIgnorarEmbalagem1Click(Sender: TObject);
    procedure IgnorarEmbalagem1Click(Sender: TObject);
    procedure EditClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnEnviarEmailClick(Sender: TObject);
  private
    { Private declarations }
    fCliSelecionados: TDictionary<String, Boolean>;
    fSelecionados: TDictionary<String, Boolean>;
    FCliEnviados: TList<String>;
    fCloneDataSet: TFDMemTable;
    FSqlQryEmbalagens: String;
    function GetChaveSelecionada(AChaveNFPro: String; pDefault: Boolean = False): Boolean;
    function GetClienteSelecionado(ACodCliente: String; pDefault: Boolean = False): Boolean;
    function SetClienteSelecionado(pCodCliente: String; pSelecionado: Boolean): Boolean;
    procedure VerificaClienteSelecionado;
    procedure SelecionaDeselecionaTodos(pSeleciona: Boolean);
    procedure VerificaEEnviaEmail;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent);
    procedure CarregaEmbalagens(ADataIni, ADataFim: TDate);

  end;

var
  FormGravaEmbalagens: TFormGravaEmbalagens;

implementation

{$R *.dfm}

uses
  uFormEmbalagensClientes;

procedure TFormGravaEmbalagens.SelecionaDeselecionaTodos(pSeleciona: Boolean);
begin
  QryEmbalagens.DisableControls;
  try
    QryEmbalagens.First;
    while not QryEmbalagens.Eof do
    begin
      fSelecionados.AddOrSetValue(QryEmbalagenschavenfpro.AsString, pSeleciona);
      QryEmbalagens.Edit;
      QryEmbalagens.Post;
      QryEmbalagens.Next;
    end;
  finally
    QryEmbalagens.EnableControls;
  end;
end;

procedure TFormGravaEmbalagens.VerificaEEnviaEmail;
var
  FFrm: TFormEmbalagensClientes;
begin
  FFrm:= TFormEmbalagensClientes.Create(nil);
  try
    FFrm.CarregaEmbalagensCliente(QryEmbalagensCodCliente.AsString);
    if FFrm.QryEmbalagensCli.IsEmpty then
    begin
      ShowMessage(Format('Sem embalagens para enviar email para o cliente %s.', [QryEmbalagensRazaoSocial.AsString]));
      Exit;
    end;
    if FFrm.QryEmbalagensCli.RecordCount > 1 then
    begin
      ShowMessage(Format('Existem outras embalagens pendentes para o cliente %s.',[QryEmbalagensRazaoSocial.AsString]));
      FFrm.ShowModal;
    end
   else
    FFrm.EnviaEmail;
  finally
    FFrm.Free;
  end;
end;

procedure TFormGravaEmbalagens.BtnEnviarEmailClick(Sender: TObject);
begin
  FCliEnviados.Clear;
  QryEmbalagens.First;
  while not QryEmbalagens.Eof do
  begin
    if (QryEmbalagensSelecionado.AsBoolean) and (FCliEnviados.Contains(QryEmbalagensCodCliente.AsString) = False) then
    begin
      VerificaEEnviaEmail;
      FCliEnviados.Add(QryEmbalagenscodcliente.AsString);
    end;

    QryEmbalagens.Next;
  end;

  QryEmbalagens.Refresh;
end;

procedure TFormGravaEmbalagens.BtnSelecionaClick(Sender: TObject);
begin
  if BtnSeleciona.Caption = '[V]' then
  begin
    SelecionaDeselecionaTodos(True);
    BtnSeleciona.Caption:= '[X]';
  end
 else
  begin
    SelecionaDeselecionaTodos(False);
    BtnSeleciona.Caption:= '[V]';
  end;
end;

procedure TFormGravaEmbalagens.BtnAtualizarClick(Sender: TObject);
begin
  CarregaEmbalagens(DataIniPicker.Date, DataFimPicker.Date);
end;

procedure TFormGravaEmbalagens.CarregaEmbalagens(ADataIni, ADataFim: TDate);
var
  FSql: String;

  function GetFiltroStatus: String;
  begin
    Result:= ' AND IsNull(MS.Status,0) in (0';
    if CheckBoxMostrarEnviados.Checked then
      Result:= Result+',1';
    if CheckBoxMostrarIgnorados.Checked then
      Result:= Result+',2';

    Result:= Result+') ';
  end;
begin
  fCloneDataSet.Close;
  QryEmbalagens.Close;

  FSql:= FSqlQryEmbalagens;
  FSql:= FSql.Replace('/*Ignorados*/', GetFiltroStatus);

  if Trim(EditCliente.Text)<>'' then
    FSql:= FSql.Replace('/*Cliente*/', ' AND C.RAZAOSOCIAL LIKE ''%'+Trim(EditCliente.Text)+'%'' ');

  QryEmbalagens.SQL.Text:= FSql;
  QryEmbalagens.ParamByName('DataIni').AsDate:= ADataIni;
  QryEmbalagens.ParamByName('DataFim').AsDate:= ADataFim;
  QryEmbalagens.Open;
  fCloneDataSet.CloneCursor(QryEmbalagens);

{  QryClientes.Close;
  QryClientes.ParamByName('DataIni').AsDate:= ADataIni;
  QryClientes.ParamByName('DataFim').AsDate:= ADataFim;
  QryClientes.Open;                }
  cxGridViewClientes.ViewData.Expand(True);
end;

procedure TFormGravaEmbalagens.CheckBoxMostrarIgnoradosClick(Sender: TObject);
begin
  CarregaEmbalagens(DataIniPicker.Date, DataFimPicker.Date);
end;

constructor TFormGravaEmbalagens.Create(AOwner: TComponent);
begin
  fSelecionados:= TDictionary<String, Boolean>.Create;
  fCliSelecionados:= TDictionary<String, Boolean>.Create;

  FCliEnviados:= TList<String>.Create;
  fCloneDataSet:= TFDMemTable.Create(Self);
  inherited;
end;

function TFormGravaEmbalagens.GetChaveSelecionada(AChaveNFPro: String; pDefault: Boolean = False): Boolean;
begin
  if not fSelecionados.TryGetValue(AChaveNFPro, Result) then
    Result:= pDefault;
end;

function TFormGravaEmbalagens.GetClienteSelecionado(ACodCliente: String; pDefault: Boolean = False): Boolean;
begin
  if not fCliSelecionados.TryGetValue(ACodCliente, Result) then
    Result:= pDefault;
end;

procedure TFormGravaEmbalagens.IgnorarEmbalagem1Click(Sender: TObject);
begin
  TFormEmbalagensClientes.IgnoraEmbalagem(QryEmbalagensCHAVENFPRO.AsString);
  QryEmbalagens.Refresh;
end;

procedure TFormGravaEmbalagens.PopupMenuPopup(Sender: TObject);
begin
  if QryEmbalagensCHAVENFPRO.AsString = '' then
    Exit;

  Ignorarembalagem1.Visible:= QryEmbalagensSTATUS.AsInteger <> 2;
  DeixardeIgnorarEmbalagem1.Visible:= QryEmbalagensSTATUS.AsInteger = 2;
end;

procedure TFormGravaEmbalagens.VerificaClienteSelecionado;
var
  fTodosSelecionados: Boolean;
  fNenhumSelecionado: Boolean;
begin
{  fCloneDataSet.Filter:= Format('CodCliente = ''%s'' ', [QryClientesCODCLIENTE.AsString]);
  fCloneDataSet.Filtered:= True;

  QryClientes.Edit;
  try
    if fCloneDataSet.IsEmpty then
    begin
      fCliSelecionados.AddOrSetValue(QryClientesCODCLIENTE.AsString, False);
      Exit;
    end;

    fCloneDataSet.First;

    fTodosSelecionados:= True;
    fNenhumSelecionado:= True;

    while not fCloneDataSet.Eof do
    begin
      fTodosSelecionados:= fTodosSelecionados and GetChaveSelecionada(fCloneDataSet.FieldByName('ChaveNFPro').AsString);
      fNenhumSelecionado:= (fNenhumSelecionado) and (GetChaveSelecionada(fCloneDataSet.FieldByName('ChaveNFPro').AsString) = False);
      fCloneDataSet.Next;
    end;

    if fNenhumSelecionado then
      fCliSelecionados.AddOrSetValue(QryClientesCODCLIENTE.AsString, False)
    else if fTodosSelecionados then
      fCliSelecionados.AddOrSetValue(QryClientesCODCLIENTE.AsString, True)
    else
      QryClientesSelecionado.Clear; // Existem alguns registros selecionados e outros não, marca nulo.
  finally
    QryClientes.Post;
  end; }
end;

function TFormGravaEmbalagens.SetClienteSelecionado(pCodCliente: String; pSelecionado: Boolean): Boolean;
begin
  QryEmbalagens.Filter:= Format('CodCliente = ''%s'' ', [pCodCliente]);
  try
    QryEmbalagens.Filtered:= True;

    QryEmbalagens.First;
    while not QryEmbalagens.Eof do
    begin
      fSelecionados.AddOrSetValue(QryEmbalagens.FieldByName('ChaveNFPro').AsString, pSelecionado);
      QryEmbalagens.Edit;
      QryEmbalagens.Post; // Refresh calc value
      QryEmbalagens.Next;
    end;

    VerificaClienteSelecionado;
  finally
    QryEmbalagens.Filtered:= False;
  end;
end;

procedure TFormGravaEmbalagens.cxGridViewClientesCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  FColChave, FCurCol: TCxGridDBColumn;
  FChaveNFPro: String;
begin
  FColChave:= TcxGridDBTableView(Sender).GetColumnByFieldName('ChaveNFPro');
  FCurCol:= TcxGridDBColumn(ACellViewInfo.Item);
  if (Assigned(FColChave)) and (Assigned(FCurCol))= False  then
    Exit;

  FChaveNFPro:= ACellViewInfo.GridRecord.Values[FColChave.Index];
  if UpperCase(FCurCol.DataBinding.Field.FieldName) = 'SELECIONADO' then
  begin
    fSelecionados.AddOrSetValue(FChaveNFPro, not GetChaveSelecionada(FChaveNFPro));
    QryEmbalagens.Edit;
    QryEmbalagens.Post;
  end;
end;

procedure TFormGravaEmbalagens.cxGridViewClientesStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if Sender.DataController.Values[ARecord.RecordIndex, cxGridViewClientesstatus.Index] = 2 then
    AStyle := cxStyleAmarelo;
end;

procedure TFormGravaEmbalagens.DeixardeIgnorarEmbalagem1Click(Sender: TObject);
const
  cSqlDelete = 'DELETE FROM MCLIPROSTATUSRECB WHERE CHAVENFPRO= ''%s'' ';
begin
  ConSqlServer.ExecutaComando(Format(cSqlDelete, [QryEmbalagensChaveNFPRo.AsString]));
  QryEmbalagens.Refresh;
end;

procedure TFormGravaEmbalagens.EditClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if KEY = VK_RETURN then
    CarregaEmbalagens(DataIniPicker.Date, DataFimPicker.Date);

end;

procedure TFormGravaEmbalagens.EmbalagensCli1Click(Sender: TObject);
begin
  if QryEmbalagenscodcliente.AsString = '' then
    Exit;

  TFormEmbalagensClientes.AbreEmbalagensCliente(QryEmbalagensCodCliente.AsString);
  QryEmbalagens.Refresh;
end;

procedure TFormGravaEmbalagens.FormCreate(Sender: TObject);
begin
  FSqlQryEmbalagens:= QryEmbalagens.SQL.Text;
  DataIniPicker.DateTime:= Now;
  DataFimPicker.DateTime:= Now;
  CarregaEmbalagens(Trunc(Now), Trunc(Now));
end;

procedure TFormGravaEmbalagens.FormDestroy(Sender: TObject);
begin
  fCliSelecionados.Free;
  fSelecionados.Free;
  FCliEnviados.Free;
end;

procedure TFormGravaEmbalagens.QryClientesAfterClose(DataSet: TDataSet);
begin
  fCliSelecionados.Clear;
end;

procedure TFormGravaEmbalagens.QryClientesCalcFields(DataSet: TDataSet);
begin
//  QryClientesSelecionado.AsBoolean:= GetClienteSelecionado(QryClientesCodCliente.AsString);
end;

procedure TFormGravaEmbalagens.QryEmbalagensAfterClose(DataSet: TDataSet);
begin
  fSelecionados.Clear;
end;

procedure TFormGravaEmbalagens.QryEmbalagensAfterGetRecord(DataSet: TFDDataSet);
begin
  fSelecionados.AddOrSetValue(QryEmbalagenschavenfPro.AsString, False);
end;

procedure TFormGravaEmbalagens.QryEmbalagensAfterPost(DataSet: TDataSet);
begin
  fSelecionados.AddOrSetValue(QryEmbalagenschavenfPro.AsString, QryEmbalagensSelecionado.AsBoolean);
end;

procedure TFormGravaEmbalagens.QryEmbalagensCalcFields(DataSet: TDataSet);
begin
  QryEmbalagensSelecionado.AsBoolean:= GetChaveSelecionada(QryEmbalagenschavenfPro.AsString);
end;

end.
