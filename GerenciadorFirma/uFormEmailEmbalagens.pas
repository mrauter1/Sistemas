unit uFormEmailEmbalagens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.StdCtrls,
  System.Generics.Collections, cxCheckBox, Vcl.Buttons, Vcl.Menus,
  uConSqlServer, Vcl.Grids, Vcl.DBGrids, uFormGlobal, uFormEmbalagensAVencer;

type
  TFormGravaEmbalagens = class(TForm)
    QryEmbalagens: TFDQuery;
    DsEmbalagens: TDataSource;
    QryEmbalagensdatacomprovante: TDateField;
    QryEmbalagenscodproduto: TStringField;
    QryEmbalagensapresentacao: TStringField;
    QryEmbalagenscodcliente: TStringField;
    QryEmbalagensnumero: TStringField;
    QryEmbalagensserie: TStringField;
    QryEmbalagensSelecionado: TBooleanField;
    QryEmbalagenschavenfpro: TStringField;
    PopupMenu: TPopupMenu;
    EmbalagensCli1: TMenuItem;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleVermelho: TcxStyle;
    cxStyleAmarelo: TcxStyle;
    QryEmbalagensstatus: TIntegerField;
    IgnorarEmbalagem1: TMenuItem;
    DeixardeIgnorarEmbalagem1: TMenuItem;
    N1: TMenuItem;
    QryEmbalagensQuantAtendida: TBCDField;
    QryEmbalagensCHAVENF: TStringField;
    QryEmbalagensRAZAOSOCIAL: TStringField;
    QryEmbalagensCIDADE: TStringField;
    QryEmbalagensTOTPAGO: TFMTBCDField;
    QryEmbalagensEntregaParcial: TStringField;
    QryEmbalagensVALTOTAL: TBCDField;
    QryEmbalagensDESCSTATUS: TStringField;
    QryEmbalagensVALUNIDADE: TFMTBCDField;
    QryEmbalagensQuantDevolvida: TFMTBCDField;
    PopupOpcoes: TPopupMenu;
    ConfiguarEmaildeEnvio1: TMenuItem;
    QryEmbalagensQuantPendente: TFMTBCDField;
    ConfigurarTextodoEmail1: TMenuItem;
    PageControl1: TPageControl;
    TabPendentes: TTabSheet;
    PanelBotPendentes: TPanel;
    BtnSeleciona: TBitBtn;
    PanelPendentes: TPanel;
    cxGridEmbalagens: TcxGrid;
    cxGridViewClientes: TcxGridDBTableView;
    cxGridViewClientesSelecionado: TcxGridDBColumn;
    cxGridViewClientesDESCSTATUS: TcxGridDBColumn;
    cxGridViewClientesstatus: TcxGridDBColumn;
    cxGridViewClientesCODCLIENTE: TcxGridDBColumn;
    cxGridViewClientesRAZAOSOCIAL: TcxGridDBColumn;
    cxGridViewClientesCIDADE: TcxGridDBColumn;
    cxGridViewClientesdatacomprovante: TcxGridDBColumn;
    cxGridViewClienteschavenfpro: TcxGridDBColumn;
    cxGridViewClientesnumero: TcxGridDBColumn;
    cxGridViewClientesserie: TcxGridDBColumn;
    cxGridViewClientescodproduto: TcxGridDBColumn;
    cxGridViewClientesapresentacao: TcxGridDBColumn;
    cxGridViewClientesQuantPendente: TcxGridDBColumn;
    cxGridViewClientesQuantDevolvida: TcxGridDBColumn;
    cxGridViewClientesTOTPAGO: TcxGridDBColumn;
    cxGridViewClientesVALTOTAL: TcxGridDBColumn;
    cxGridViewClientesEntregaParcial: TcxGridDBColumn;
    cxGridViewClientesCHAVENF: TcxGridDBColumn;
    cxGridViewClientesVALUNIDADE: TcxGridDBColumn;
    cxGridViewClientesQuantAtendida: TcxGridDBColumn;
    cxGridEmbalagensDBTableView1: TcxGridDBTableView;
    cxGridEmbalagensDBTableView2: TcxGridDBTableView;
    cxGridEmbalagensDBTableView2Selecionado: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2chavenfpro: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2codcliente: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2numero: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2serie: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2datacomprovante: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2codproduto: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2apresentacao: TcxGridDBColumn;
    cxGridEmbalagensDBTableView2NOMECLIENTE: TcxGridDBColumn;
    cxGridClientesLevel: TcxGridLevel;
    PanelTopPendentes: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BtnAtualizar: TButton;
    DataIniPicker: TDateTimePicker;
    DataFimPicker: TDateTimePicker;
    CheckBoxMostrarIgnorados: TCheckBox;
    EditCliente: TEdit;
    CheckBoxMostrarEnviados: TCheckBox;
    BtnEnviarEmail: TButton;
    BtnOpcoes: TButton;
    TabSheetAVencer: TTabSheet;
    PanelTopAVencer: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BtnAtualizaAVencer: TButton;
    DataIniAVencer: TDateTimePicker;
    DataFimAVencer: TDateTimePicker;
    CbxIgnoradasAVencer: TCheckBox;
    EditAVencerCli: TEdit;
    CbxEnviadasAVencer: TCheckBox;
    BtnEnviarEmailPrestesAVencer: TButton;
    Button3: TButton;
    PanelBotAVencer: TPanel;
    BtnSelecionaAVencer: TBitBtn;
    DSAVencer: TDataSource;
    QryAVencer: TFDQuery;
    Panel1: TPanel;
    QryAVencerSelecionado: TBooleanField;
    QryAVencercodcliente: TStringField;
    QryAVencerstatus: TIntegerField;
    QryAVencerRAZAOSOCIAL: TStringField;
    QryAVencerCIDADE: TStringField;
    QryAVencerchavenfpro: TStringField;
    QryAVencerdatacomprovante: TDateField;
    QryAVencernumero: TStringField;
    QryAVencerserie: TStringField;
    QryAVencercodproduto: TStringField;
    QryAVencerapresentacao: TStringField;
    QryAVencerQuantAtendida: TBCDField;
    QryAVencerCHAVENF: TStringField;
    QryAVencerTOTPAGO: TFMTBCDField;
    QryAVencerVALTOTAL: TBCDField;
    QryAVencerEntregaParcial: TStringField;
    QryAVencerVALUNIDADE: TFMTBCDField;
    QryAVencerQuantDevolvida: TFMTBCDField;
    QryAVencerQuantPendente: TFMTBCDField;
    QryAVencerDataVencimento: TDateField;
    QryAVencerValorPendente: TFMTBCDField;
    QryAVencerDiasParaVencimento: TIntegerField;
    QryAVencerSATUSAVENCER: TStringField;
    QryAVencerENVIADOAVENCER: TBooleanField;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Selecionado: TcxGridDBColumn;
    cxGrid1DBTableView1chavenfpro: TcxGridDBColumn;
    cxGrid1DBTableView1codcliente: TcxGridDBColumn;
    cxGrid1DBTableView1status: TcxGridDBColumn;
    cxGrid1DBTableView1RAZAOSOCIAL: TcxGridDBColumn;
    cxGrid1DBTableView1CIDADE: TcxGridDBColumn;
    cxGrid1DBTableView1datacomprovante: TcxGridDBColumn;
    cxGrid1DBTableView1DataVencimento: TcxGridDBColumn;
    cxGrid1DBTableView1numero: TcxGridDBColumn;
    cxGrid1DBTableView1serie: TcxGridDBColumn;
    cxGrid1DBTableView1codproduto: TcxGridDBColumn;
    cxGrid1DBTableView1apresentacao: TcxGridDBColumn;
    cxGrid1DBTableView1QuantAtendida: TcxGridDBColumn;
    cxGrid1DBTableView1CHAVENF: TcxGridDBColumn;
    cxGrid1DBTableView1VALTOTAL: TcxGridDBColumn;
    cxGrid1DBTableView1QuantDevolvida: TcxGridDBColumn;
    cxGrid1DBTableView1QuantPendente: TcxGridDBColumn;
    cxGrid1DBTableView1ValorPendente: TcxGridDBColumn;
    cxGrid1DBTableView1DiasParaVencimento: TcxGridDBColumn;
    cxGrid1DBTableView1SATUSAVENCER: TcxGridDBColumn;
    AjustarEmbalagens1: TMenuItem;
    QryEmbalagensSEQUENCIADOPRODUTO: TIntegerField;
    QryEmbalagensENVIADOAVENCER: TBooleanField;
    QryEmbalagensDataVencimento: TDateField;
    QryEmbalagensValorPendente: TFMTBCDField;
    QryAVencerSEQUENCIADOPRODUTO: TIntegerField;
    QryAVencerDESCSTATUS: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QryEmbalagensCalcFields(DataSet: TDataSet);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure cxGridViewClientesCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure QryClientesCalcFields(DataSet: TDataSet);
    procedure QryEmbalagensAfterClose(DataSet: TDataSet);
    procedure BtnSelecionaClick(Sender: TObject);
    procedure EmbalagensCli1Click(Sender: TObject);
    procedure cxGridViewClientesStylesGetContentStyle
      (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure CheckBoxMostrarIgnoradosClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure DeixardeIgnorarEmbalagem1Click(Sender: TObject);
    procedure IgnorarEmbalagem1Click(Sender: TObject);
    procedure EditClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnEnviarEmailClick(Sender: TObject);
    procedure ConfiguarEmaildeEnvio1Click(Sender: TObject);
    procedure BtnOpcoesClick(Sender: TObject);
    procedure ConfigurarTextodoEmail1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure BtnAtualizaAVencerClick(Sender: TObject);
    procedure cxGridDBTableViewAVencerCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure QryAVencerCalcFields(DataSet: TDataSet);
    procedure BtnSelecionaAVencerClick(Sender: TObject);
    procedure BtnEnviarEmailPrestesAVencerClick(Sender: TObject);
    procedure AjustarEmbalagens1Click(Sender: TObject);
    procedure CbxEnviadasAVencerClick(Sender: TObject);
  private
    { Private declarations }
    fSelecionados: TDictionary<String, Boolean>;
    fAVencerSelecionados: TDictionary<String, Boolean>;
    FCliEnviados: TList<String>;
    fCloneDataSet: TFDMemTable;
    FSqlQryEmbalagens: String;
    FSqlQryAVencer: String;
    function GetChaveSelecionada(ADictionary: TDictionary<String, Boolean>;
      AChaveNFPro: String; pDefault: Boolean = False): Boolean;
    procedure SelecionaDeselecionaTodos(pSeleciona: Boolean);
    procedure VerificaEEnviaEmail;
    procedure CarregaAVencer(ADataIni, ADataFim: TDate);
    procedure SelecionaDeselecionaTodosAVencer(pSeleciona: Boolean);
    function GetActiveQuery: TFDQuery;
    function GetIdentificadorTextoEmail: String;
    function VerificaEEnviaEmailAVencer: Boolean;

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
  uFormEmbalagensClientes, uFormConfigurarEmailEmbalagens,
  uFormConfiguraTextoEmailEmbalagem, cxUtils, Utils, uFormAjustaInconsistencias;

procedure TFormGravaEmbalagens.SelecionaDeselecionaTodosAVencer
  (pSeleciona: Boolean);
begin
  QryAVencer.DisableControls;
  try
    QryAVencer.First;
    while not QryAVencer.Eof do
    begin
      fAVencerSelecionados.AddOrSetValue(QryAVencerchavenfpro.AsString,
        pSeleciona);
      QryAVencer.Edit;
      QryAVencer.Post;
      QryAVencer.Next;
    end;
  finally
    QryAVencer.EnableControls;
  end;
end;

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

function TFormGravaEmbalagens.VerificaEEnviaEmailAVencer: Boolean;
var
  FFrm: TFormEmbalagensAVencer;
begin
  Result:= False;// TODO: Retornar verdadeiro somente quando o email for enviado
  FFrm := TFormEmbalagensAVencer.Create(nil);
  try
    FFrm.CarregaEmbalagensAVencer(QryAVencercodcliente.AsString, DataFimAVencer.Date);
    if FFrm.QryAVencer.IsEmpty then
    begin
      ShowMessage(Format('Sem embalagens à vencer para o cliente %s.',
        [QryAVencerRAZAOSOCIAL.AsString]));
      Exit;
    end;
    if Trim(FFrm.EditEmails.Text) = '' then
    begin
      ShowMessage
        (Format('É preciso indicar o email para envio de embalagens pendentes para o cliente %s.',
        [QryAVencerRAZAOSOCIAL.AsString]));
      FFrm.ShowModal;
      Result:= FFrm.EmailEnviado;
    end
    else
      Result:= FFrm.EnviaEmailAVencer;
  finally
    FFrm.Free;
  end;
end;

procedure TFormGravaEmbalagens.VerificaEEnviaEmail;
var
  FFrm: TFormEmbalagensClientes;
begin
  FFrm := TFormEmbalagensClientes.Create(nil);
  try
    FFrm.CarregaEmbalagensCliente(QryEmbalagenscodcliente.AsString,
      GetIdentificadorTextoEmail);
    if FFrm.QryEmbalagensCli.IsEmpty then
    begin
      ShowMessage(Format('Sem embalagens para enviar email para o cliente %s.',
        [QryEmbalagensRAZAOSOCIAL.AsString]));
      Exit;
    end;
    if FFrm.QryEmbalagensCli.RecordCount > 1 then
    begin
      ShowMessage
        (Format('Existem outras embalagens pendentes para o cliente %s.',
        [QryEmbalagensRAZAOSOCIAL.AsString]));
      FFrm.ShowModal;
    end
    else if Trim(FFrm.EditEmails.Text) = '' then
    begin
      ShowMessage
        (Format('É preciso indicar o email para envio de embalagens pendentes para o cliente %s.',
        [QryEmbalagensRAZAOSOCIAL.AsString]));
      FFrm.ShowModal;
    end
    else
      FFrm.EnviaEmaiL;
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
    if (QryEmbalagensSelecionado.AsBoolean) and
      (FCliEnviados.Contains(QryEmbalagenscodcliente.AsString) = False) then
    begin
      //TODO:
      VerificaEEnviaEmail;
      FCliEnviados.Add(QryEmbalagenscodcliente.AsString);
    end;

    QryEmbalagens.Next;
  end;

  QryEmbalagens.Refresh;
end;

procedure TFormGravaEmbalagens.BtnOpcoesClick(Sender: TObject);
var
  pnt: TPoint;
begin
  GetCursorPos(pnt);
  PopupOpcoes.Popup(pnt.X - 20, pnt.Y - 8);
end;

procedure TFormGravaEmbalagens.BtnSelecionaClick(Sender: TObject);
begin
  if BtnSeleciona.Caption = '[V]' then
  begin
    SelecionaDeselecionaTodos(True);
    BtnSeleciona.Caption := '[X]';
  end
  else
  begin
    SelecionaDeselecionaTodos(False);
    BtnSeleciona.Caption := '[V]';
  end;
end;

procedure TFormGravaEmbalagens.BtnAtualizaAVencerClick(Sender: TObject);
begin
  CarregaAVencer(DataIniAVencer.Date, DataFimAVencer.Date);
end;

procedure TFormGravaEmbalagens.BtnEnviarEmailPrestesAVencerClick
  (Sender: TObject);
begin
  FCliEnviados.Clear;
  QryAVencer.First;
  while not QryAVencer.Eof do
  begin
    if (QryAVencerSelecionado.AsBoolean) and
      (FCliEnviados.Contains(QryAVencercodcliente.AsString) = False) then
    begin
       VerificaEEnviaEmailAVencer;
       FCliEnviados.Add(QryAVencercodcliente.AsString);
    end;

    QryAVencer.Next;
  end;

  QryAVencer.Refresh;
end;

procedure TFormGravaEmbalagens.BtnSelecionaAVencerClick(Sender: TObject);
begin
  if BtnSelecionaAVencer.Caption = '[V]' then
  begin
    SelecionaDeselecionaTodosAVencer(True);
    BtnSelecionaAVencer.Caption := '[X]';
  end
  else
  begin
    SelecionaDeselecionaTodosAVencer(False);
    BtnSelecionaAVencer.Caption := '[V]';
  end;
end;

procedure TFormGravaEmbalagens.AjustarEmbalagens1Click(Sender: TObject);
var
  FQry: TFDQuery;
begin
  FQry := GetActiveQuery;
  if TFormAjustaInconsistencias.AjustaEmbalagem(FQry.FieldByName('ChaveNF').AsString) then
    FQry.Refresh;
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
    Result := ' AND IsNull(Status,0) in (0';
    if CheckBoxMostrarEnviados.Checked then
      Result := Result + ',1';
    if CheckBoxMostrarIgnorados.Checked then
      Result := Result + ',2';

    Result := Result + ') ';
  end;

begin
  fCloneDataSet.Close;
  QryEmbalagens.Close;

  FSql := FSqlQryEmbalagens;
  FSql := FSql.Replace('/*Ignorados*/', GetFiltroStatus);

  if Trim(EditCliente.Text) <> '' then
    FSql := FSql.Replace('/*Cliente*/', ' AND RAZAOSOCIAL LIKE ''%' +
      Trim(EditCliente.Text) + '%'' ');

  QryEmbalagens.SQL.Text := FSql;
  QryEmbalagens.ParamByName('DataIni').AsDate := ADataIni;
  QryEmbalagens.ParamByName('DataFim').AsDate := ADataFim;
  QryEmbalagens.Open;
  fCloneDataSet.CloneCursor(QryEmbalagens);

  cxGridViewClientes.ViewData.Expand(True);
end;

procedure TFormGravaEmbalagens.CbxEnviadasAVencerClick(Sender: TObject);
begin
  BtnAtualizaAVencer.Click;
end;

procedure TFormGravaEmbalagens.CheckBoxMostrarIgnoradosClick(Sender: TObject);
begin
  CarregaEmbalagens(DataIniPicker.Date, DataFimPicker.Date);
end;

function TFormGravaEmbalagens.GetIdentificadorTextoEmail: String;
begin
  if PageControl1.ActivePage = TabSheetAVencer then
    Result := 'AVENCER'
  else
    Result := 'EMBALAGEM';
end;

procedure TFormGravaEmbalagens.ConfiguarEmaildeEnvio1Click(Sender: TObject);
begin
  TFormConfigurarEmailEmbalagens.ConfiguraEmail;
end;

procedure TFormGravaEmbalagens.ConfigurarTextodoEmail1Click(Sender: TObject);
begin
  TFormConfiguraTextoEmailEmbalagem.ConfiguraTexto(GetIdentificadorTextoEmail);
end;

constructor TFormGravaEmbalagens.Create(AOwner: TComponent);
begin
  fSelecionados := TDictionary<String, Boolean>.Create;
  fAVencerSelecionados := TDictionary<String, Boolean>.Create;

  FCliEnviados := TList<String>.Create;
  fCloneDataSet := TFDMemTable.Create(Self);
  inherited;
end;

function TFormGravaEmbalagens.GetChaveSelecionada
  (ADictionary: TDictionary<String, Boolean>; AChaveNFPro: String;
  pDefault: Boolean = False): Boolean;
begin
  if not ADictionary.TryGetValue(AChaveNFPro, Result) then
    Result := pDefault;
end;

procedure TFormGravaEmbalagens.IgnorarEmbalagem1Click(Sender: TObject);
var
  FQry: TFDQuery;
begin
  FQry := GetActiveQuery;

  if FQry.FieldByName('ChaveNFPro').AsString = '' then
    Exit;

  TFormEmbalagensAVencer.IgnoraEmbalagem(FQry.FieldByName('ChaveNFPro').AsString, FQry.FieldByName('SequenciaDoProduto').AsInteger);
  FQry.Refresh;
end;

procedure TFormGravaEmbalagens.CarregaAVencer(ADataIni, ADataFim: TDate);
var
  FSql: String;

  function GetFiltro: String;
  begin
    Result:= ' ';
    if CbxIgnoradasAVencer.Checked = False then
      Result:= ' AND IsNull(Status,0) <> 2 ';

   if CbxEnviadasAVencer.Checked = False then
     Result:= Result+' AND IsNull(EnviadoAVencer,0) <> 1 ';
  end;
begin
  QryAVencer.Close;

  FSql := FSqlQryAVencer;
  FSql:= FSql.Replace('/*Ignorados*/', GetFiltro);

  if Trim(EditAVencerCli.Text) <> '' then
    FSql := FSql.Replace('/*Cliente*/', ' AND RAZAOSOCIAL LIKE ''%' +
      Trim(EditAVencerCli.Text) + '%'' ');

  QryAVencer.SQL.Text := FSql;

  QryAVencer.Close;
  QryAVencer.ParamByName('DataIni').AsDate := ADataIni;
  QryAVencer.ParamByName('DataFim').AsDate := ADataFim;
  QryAVencer.Open;
end;

procedure TFormGravaEmbalagens.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = TabSheetAVencer then
  begin
    if (QryAVencer.ParamByName('DataIni').AsDate <> DataIniAVencer.Date) or
      (QryAVencer.ParamByName('DataFim').AsDate <> DataFimAVencer.Date) then

      CarregaAVencer(DataIniAVencer.Date, DataFimAVencer.Date);
  end;
end;

procedure TFormGravaEmbalagens.PopupMenuPopup(Sender: TObject);
begin
  if QryEmbalagenschavenfpro.AsString = '' then
    Exit;

  IgnorarEmbalagem1.Visible := QryEmbalagensstatus.AsInteger <> 2;
  DeixardeIgnorarEmbalagem1.Visible := QryEmbalagensstatus.AsInteger = 2;
end;

procedure TFormGravaEmbalagens.cxGridDBTableViewAVencerCellClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  FColChave, FCurCol: TcxGridDBColumn;
  FChaveNFPro: String;
begin
  FChaveNFPro := VarToStrDef
    (GetColumnValueByFieldName(TcxGridDBTableView(Sender), 'ChaveNFPro'), '');
  FCurCol := TcxGridDBColumn(ACellViewInfo.Item);
  if (FChaveNFPro = '') or (not Assigned(FCurCol)) then
    Exit;

  if UpperCase(FCurCol.DataBinding.Field.FieldName) = 'SELECIONADO' then
  begin
    fAVencerSelecionados.AddOrSetValue(FChaveNFPro,
      not GetChaveSelecionada(fAVencerSelecionados, FChaveNFPro));
    QryAVencer.Edit;
    QryAVencer.Post;
  end;
end;

procedure TFormGravaEmbalagens.cxGridViewClientesCellClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  FCurCol: TcxGridDBColumn;
  FChaveNFPro: String;
begin
  FChaveNFPro := VarToStrDef
    (GetColumnValueByFieldName(TcxGridDBTableView(Sender), 'ChaveNFPro'), '');
  FCurCol := TcxGridDBColumn(ACellViewInfo.Item);
  if (FChaveNFPro = '') or (not Assigned(FCurCol)) then
    Exit;

  if UpperCase(FCurCol.DataBinding.Field.FieldName) = 'SELECIONADO' then
  begin
    fSelecionados.AddOrSetValue(FChaveNFPro,
      not GetChaveSelecionada(fSelecionados, FChaveNFPro));
    QryEmbalagens.Edit;
    QryEmbalagens.Post;
  end;
end;

procedure TFormGravaEmbalagens.cxGridViewClientesStylesGetContentStyle
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if Sender.DataController.Values[ARecord.RecordIndex, cxGridViewClientesstatus.
    Index] = 2 then
    AStyle := cxStyleAmarelo;
end;

procedure TFormGravaEmbalagens.DeixardeIgnorarEmbalagem1Click(Sender: TObject);
var
  FQry: TFDQuery;
begin
  FQry := GetActiveQuery;

  if FQry.FieldByName('ChaveNFPro').AsString = '' then
    Exit;

  TFormEmbalagensAVencer.DeixarDeIgnorarEmbalagem(FQry.FieldByName('ChaveNFPro').AsString, FQry.FieldByName('SequenciaDoProduto').AsInteger);

//  ConSqlServer.ExecutaComando(Format(cSqlDelete,
//    [FQry.FieldByName('ChaveNFPro').AsString, FQry.FieldByName('SequenciaDoProduto').AsInteger]));
  FQry.Refresh;
end;

procedure TFormGravaEmbalagens.EditClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    CarregaEmbalagens(DataIniPicker.Date, DataFimPicker.Date);

end;

function TFormGravaEmbalagens.GetActiveQuery: TFDQuery;
begin
  if PageControl1.ActivePage = TabSheetAVencer then
    Result := QryAVencer
  else
    Result := QryEmbalagens;
end;

procedure TFormGravaEmbalagens.EmbalagensCli1Click(Sender: TObject);
var
  FQry: TFDQuery;
begin
  FQry := GetActiveQuery;

  if FQry.FieldByName('CodCliente').AsString = '' then
    Exit;

  if PageControl1.ActivePage = TabSheetAVencer then
    TFormEmbalagensAVencer.AbreEmbalagensAVencer(FQry.FieldByName('CodCliente').AsString, GetIdentificadorTextoEmail, DataFimAVencer.Date)
  else
    TFormEmbalagensClientes.AbreEmbalagensCliente(FQry.FieldByName('CodCliente').AsString, GetIdentificadorTextoEmail);

  FQry.Refresh;
end;

function IncDiaUtil(AData: TDateTime; ADias: Integer): TDateTime;
const
  cSql = 'select dbo.IncDiaUtil(%s, %d)';
begin
  Result := VarToDateTime(ConSqlServer.RetornaValor(Format(cSql,
    [Func_DateTime_SqlServer(AData), ADias])));
end;

procedure TFormGravaEmbalagens.FormCreate(Sender: TObject);
begin
  FSqlQryEmbalagens := QryEmbalagens.SQL.Text;
  FSqlQryAVencer := QryAVencer.SQL.Text;
  DataIniPicker.DateTime := IncDiaUtil(Now, -1);
  DataFimPicker.DateTime := Now;
  DataIniAVencer.DateTime := Now + 4;
  DataFimAVencer.DateTime := Now + 14;
  CarregaEmbalagens(DataIniPicker.Date, DataFimPicker.Date);
  PageControl1.ActivePage := TabPendentes;
end;

procedure TFormGravaEmbalagens.FormDestroy(Sender: TObject);
begin
  fSelecionados.Free;
  fAVencerSelecionados.Free;
  FCliEnviados.Free;
end;

procedure TFormGravaEmbalagens.QryAVencerCalcFields(DataSet: TDataSet);
begin
  QryAVencerSelecionado.AsBoolean := GetChaveSelecionada(fAVencerSelecionados,
    QryAVencerchavenfpro.AsString);
end;

procedure TFormGravaEmbalagens.QryClientesCalcFields(DataSet: TDataSet);
begin
  // QryClientesSelecionado.AsBoolean:= GetClienteSelecionado(QryClientesCodCliente.AsString);
end;

procedure TFormGravaEmbalagens.QryEmbalagensAfterClose(DataSet: TDataSet);
begin
  // fSelecionados.Clear;
end;

procedure TFormGravaEmbalagens.QryEmbalagensCalcFields(DataSet: TDataSet);
begin
  QryEmbalagensSelecionado.AsBoolean := GetChaveSelecionada(fSelecionados,
    QryEmbalagenschavenfpro.AsString);
end;

end.
