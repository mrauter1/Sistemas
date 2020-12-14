unit uFormAjustaInconsistencias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.StdCtrls,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls, Utils, uConSqlServer;

type
  TFormAjustaInconsistencias = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cxGridEmbalagens: TcxGrid;
    cxGridViewClientes: TcxGridDBTableView;
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
    Panel2: TPanel;
    BtnOK: TButton;
    QryEmbalagens: TFDQuery;
    QryEmbalagensSelecionado: TBooleanField;
    QryEmbalagensDESCSTATUS: TStringField;
    QryEmbalagenscodcliente: TStringField;
    QryEmbalagensstatus: TIntegerField;
    QryEmbalagensRAZAOSOCIAL: TStringField;
    QryEmbalagensCIDADE: TStringField;
    QryEmbalagenschavenfpro: TStringField;
    QryEmbalagensdatacomprovante: TDateField;
    QryEmbalagensnumero: TStringField;
    QryEmbalagensserie: TStringField;
    QryEmbalagenscodproduto: TStringField;
    QryEmbalagensapresentacao: TStringField;
    QryEmbalagensQuantAtendida: TBCDField;
    QryEmbalagensCHAVENF: TStringField;
    QryEmbalagensTOTPAGO: TFMTBCDField;
    QryEmbalagensVALTOTAL: TBCDField;
    QryEmbalagensEntregaParcial: TStringField;
    QryEmbalagensVALUNIDADE: TFMTBCDField;
    QryEmbalagensQuantDevolvida: TFMTBCDField;
    QryEmbalagensQuantPendente: TFMTBCDField;
    DsAjustaEmbalagens: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText4: TDBText;
    QryEmbalagensENVIADOAVENCER: TBooleanField;
    QryEmbalagensDataVencimento: TDateField;
    QryEmbalagensValorPendente: TFMTBCDField;
    FDMemAjusteEmbalagens: TFDMemTable;
    FDMemAjusteEmbalagensCHAVENFPRO: TStringField;
    FDMemAjusteEmbalagensAPRESENTACAO: TStringField;
    FDMemAjusteEmbalagensQUANTATENDIDA: TBCDField;
    FDMemAjusteEmbalagensVALTOTAL: TBCDField;
    FDMemAjusteEmbalagensVALUNIDADE: TFMTBCDField;
    FDMemAjusteEmbalagensQuantDevolvida: TFMTBCDField;
    FDMemAjusteEmbalagensQuantPendente: TFMTBCDField;
    FDMemAjusteEmbalagensValorPendente: TFMTBCDField;
    cxGridViewClientesCHAVENFPRO: TcxGridDBColumn;
    cxGridViewClientesAPRESENTACAO: TcxGridDBColumn;
    cxGridViewClientesQUANTATENDIDA: TcxGridDBColumn;
    cxGridViewClientesVALTOTAL: TcxGridDBColumn;
    cxGridViewClientesVALUNIDADE: TcxGridDBColumn;
    cxGridViewClientesQuantDevolvida: TcxGridDBColumn;
    cxGridViewClientesQuantPendente: TcxGridDBColumn;
    cxGridViewClientesValorPendente: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    FDMemAjusteEmbalagensTOTPAGO: TFMTBCDField;
    FDMemAjusteEmbalagensnumero: TStringField;
    LabelValorTotal: TLabel;
    LabelValorPendente: TLabel;
    Label6: TLabel;
    LabelDevolvidoCalculado: TLabel;
    FDMemAjusteEmbalagensValorDevolvido: TCurrencyField;
    cxGridViewClientesValorDevolvido: TcxGridDBColumn;
    FDMemAjusteEmbalagensRAZAOSOCIAL: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FDMemAjusteEmbalagensCalcFields(DataSet: TDataSet);
    procedure FDMemAjusteEmbalagensAfterPost(DataSet: TDataSet);
    procedure FDMemAjusteEmbalagensBeforeEdit(DataSet: TDataSet);
    procedure FDMemAjusteEmbalagensQuantDevolvidaChange(Sender: TField);
    procedure BtnOKClick(Sender: TObject);
  private
    FAjustadoOK: Boolean;
    FValorDevolvidoAtual: Currency;
    FValorTotal: Currency;
    FValorDevolvidoCalculado: Currency;
    procedure AjustaEmbalagemInterno(AChaveNF: String);
    procedure SomaValores;
    function FormataValor(FValor: Currency): String;
    procedure SalvaQtdDevolvida;
    { Private declarations }
  public
    { Public declarations }
    class function AjustaEmbalagem(AChaveNF: String): Boolean; // Retorna verdadeiro se as embalagens foram ajustadas corretamente;
    class function VerificaEAjustaInconsistenciaEmbalagem(AChaveNF: string): Boolean;
    class function NotaEmbalagemInconsistente(AChaveNF: String): Boolean;
  end;

var
  FormAjustaInconsistencias: TFormAjustaInconsistencias;

implementation

{$R *.dfm}

{ TFormAjustaInconsistencias }

procedure TFormAjustaInconsistencias.AjustaEmbalagemInterno(AChaveNF: String);
begin
  QryEmbalagens.Close;
  QryEmbalagens.ParamByName('ChaveNF').AsString:= AChaveNF;
  QryEmbalagens.Open;

  CopyRecordsDataSet(QryEmbalagens, FDMemAjusteEmbalagens, True);
  SomaValores;
end;

function TFormAjustaInconsistencias.FormataValor(FValor: Currency): String;
begin
  Result:= 'R$ '+FormatCurr('0.00', FValor);
end;

procedure TFormAjustaInconsistencias.SalvaQtdDevolvida;
const
  cSqlStatus = 'exec SetQtdDevolvidaMCLIPROSTATUSRECB ''%s'', %d';
begin
  FDMemAjusteEmbalagens.First;
  while not FDMemAjusteEmbalagens.Eof do
  begin
    ConSqlServer.ExecutaComando(Format(cSqlStatus, [FDMemAjusteEmbalagensCHAVENFPRO.AsString, FDMemAjusteEmbalagensQuantDevolvida.AsInteger]));
    FDMemAjusteEmbalagens.Next;
  end;
end;

procedure TFormAjustaInconsistencias.BtnOKClick(Sender: TObject);
begin
  if FDMemAjusteEmbalagens.State = dsEdit then
    FDMemAjusteEmbalagens.Post;

  if FValorDevolvidoCalculado <> FDMemAjusteEmbalagensTOTPAGO.AsCurrency then
  begin
    ShowMessage(Format('O valor devolvido calculado (%s) é diferente do valor devolvido real (%s).',
                              [FormataValor(FValorDevolvidoCalculado), FormataValor(FDMemAjusteEmbalagensTOTPAGO.AsCurrency)]));
    Exit;
  end;

  SalvaQtdDevolvida;

  FAjustadoOK:= True;
  Close;
end;

procedure TFormAjustaInconsistencias.FDMemAjusteEmbalagensAfterPost(
  DataSet: TDataSet);
begin
  SomaValores;
end;

procedure TFormAjustaInconsistencias.FDMemAjusteEmbalagensBeforeEdit(
  DataSet: TDataSet);
begin
  FValorDevolvidoAtual:= FDMemAjusteEmbalagensValorDevolvido.AsCurrency;
end;

procedure TFormAjustaInconsistencias.FDMemAjusteEmbalagensCalcFields(
  DataSet: TDataSet);
var
  FValorDevolvido: Currency;
begin
  FDMemAjusteEmbalagensValorDevolvido.AsCurrency:= FDMemAjusteEmbalagensQuantDevolvida.AsInteger*FDMemAjusteEmbalagensVALUNIDADE.AsCurrency;
  FDMemAjusteEmbalagensQuantPendente.AsInteger:= FDMemAjusteEmbalagensQUANTATENDIDA.AsInteger-FDMemAjusteEmbalagensQuantDevolvida.AsInteger;
  FDMemAjusteEmbalagensValorPendente.AsCurrency:= FDMemAjusteEmbalagensVALTOTAL.AsCurrency-FDMemAjusteEmbalagensValorDevolvido.AsCurrency;

  if Dataset.State = dsEdit then
  begin
    FValorDevolvido:= 0;
    FValorDevolvido:= FValorDevolvidoCalculado+FDMemAjusteEmbalagensValorDevolvido.AsCurrency-FValorDevolvidoAtual;
    LabelDevolvidoCalculado.Caption:= FormataValor(FValorDevolvido);
  end;
end;

procedure TFormAjustaInconsistencias.FDMemAjusteEmbalagensQuantDevolvidaChange(
  Sender: TField);
begin
  if FDMemAjusteEmbalagens.State <> dsEdit then
    Exit;

  if FDMemAjusteEmbalagensQuantDevolvida.AsInteger>FDMemAjusteEmbalagensQUANTATENDIDA.AsInteger then
    FDMemAjusteEmbalagensQuantDevolvida.AsInteger:= FDMemAjusteEmbalagensQUANTATENDIDA.AsInteger;

end;

procedure TFormAjustaInconsistencias.FormCreate(Sender: TObject);
begin
  FDMemAjusteEmbalagens.CreateDataSet;
  FValorDevolvidoAtual:= 0;
  FAjustadoOK:= False;
end;

procedure TFormAjustaInconsistencias.SomaValores;
var
  FChaveNFPro: String;
  FValPendente: Currency;
begin
  FChaveNFPro:= FDMemAjusteEmbalagensCHAVENFPRO.AsString;
  FValorTotal:= 0;
  FValorDevolvidoCalculado:= 0;

  FDMemAjusteEmbalagens.DisableControls;
  try
    FDMemAjusteEmbalagens.First;
    while not FDMemAjusteEmbalagens.Eof do
    begin
      FValorTotal:= FValorTotal+FDMemAjusteEmbalagensVALTOTAL.AsCurrency;
      FValorDevolvidoCalculado:= FValorDevolvidoCalculado+FDMemAjusteEmbalagensValorDevolvido.AsCurrency;
      FDMemAjusteEmbalagens.Next;
    end;
    FDMemAjusteEmbalagens.Locate('ChaveNFPro', FChaveNFPro, []);
  finally
    FDMemAjusteEmbalagens.EnableControls;
  end;
  FValPendente:= FValorTotal-FDMemAjusteEmbalagensTotPago.AsCurrency;
  LabelValorTotal.Caption:= FormataValor(FValorTotal);
  LabelValorPendente.Caption:= FormataValor(FValPendente);
  LabelDevolvidoCalculado.Caption:= FormataValor(FValorDevolvidoCalculado);
end;

class function TFormAjustaInconsistencias.NotaEmbalagemInconsistente(AChaveNF: String): Boolean;
const
 cSql = 'select 1 '+
        'from ( '+
        'select CHAVENF, TOTPAGO, sum(QuantDevolvida*VALUNIDADE) ValDevolvidoCalculado '+
        'from vwEmbalagemPendente where ChaveNF = ''%s'' '+
        'group by CHAVENF, totpago '+
        ')X '+
        'where X.TOTPAGO <> ValDevolvidoCalculado ';
begin
  Result:= ConSqlServer.RetornaInteiro(Format(cSql, [AChaveNF]),0)=1;
end;

class function TFormAjustaInconsistencias.VerificaEAjustaInconsistenciaEmbalagem(
  AChaveNF: string): Boolean;
begin
  Result:= NotaEmbalagemInconsistente(AChaveNF) = False;
  if Result then
    Exit;

  ShowMessage('É necessário ajustar as quantidades de embalagens devolvidas pelo cliente.');
  Result:= AjustaEmbalagem(AChaveNF);
end;

class function TFormAjustaInconsistencias.AjustaEmbalagem(AChaveNF: String): Boolean;
var
  FFrm: TFormAjustaInconsistencias;
begin
  FFrm:= TFormAjustaInconsistencias.Create(Application);
  try
    FFrm.AjustaEmbalagemInterno(AChaveNF);
    FFrm.ShowModal;
    Result:= FFrm.FAjustadoOK;
  finally
    FFrm.Free;
  end;
end;

end.
