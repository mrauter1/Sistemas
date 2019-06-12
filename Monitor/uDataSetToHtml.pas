unit uDataSetToHtml;

interface

uses
  Utils, uSendMail, System.Classes, Data.DB, SysUtils,
  System.Generics.Collections, uDmGeradorConsultas, uConSqlServer,
  uConFirebird, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uConsultaPersonalizada,
  Forms;

type
  TEnviaEmailConsulta = class(TComponent)
  protected
    FDMGeradorConsultas: TDmGeradorConsultas;

    FQry: TFDQuery;

    procedure ExecutaConsulta;

    function ConsultaParaHtml: String; virtual;
  public
    Titulo: String;
    Texto: String;
    ConsultaNome: String;
    Params: TDictionary<String, variant>;
    Destinatarios: string;
    TipoVisualizacao: TTipoVisualizacao;
    Visualizacao: String;

    constructor Create(AOwner: TComponent); override;

    procedure Enviar; virtual;

    procedure EnviarTabela; virtual;
    function ExportaTabelaParaExcel: String; virtual;
  end;

procedure WriteLog(pTexto: String);

function DataSetToHtml(pDataSet: TDataSet): String;
function ObterCabecalhoHtml(pDataSet: TDataSet): String;
function ObterValoresRecordHtml(pDataSet: TDataSet): String;
function RecordToHtml(pDataSet: TDataSet): String;
function RecordToHtmlTable(pDataSet: TDataSet): String;
function RecordCompareToHtml(pDataSetOld: TDataSet; pDataSetNew: TDataSet): String;
function WrapHtml(pConteudo: String): String;

var
  FMailSender: TMailSender;

implementation

procedure WriteLog(pTexto: String);
begin
  Utils.WriteLog('Monitor.log', pTexto);
end;

function WrapHtml(pConteudo: String): String;
begin
  Result:= '<html>'
          +'<head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"></head>'
//          +' <style> h1 { color: blue; } </style> '
          +pConteudo
          +'</html>';
end;

function RecordToHtml(pDataSet: TDataSet): String;
var
  FField: TField;
begin
  Result:= '';
  for FFIeld in pDataSet.Fields do
    if FField.Visible then
      Result:= Result+' <h2>'+FField.DisplayLabel+': '+FField.DisplayText+'</h2> ';

end;

function GetCssStyle(pStyle: String): String;
begin
  Result:= ' <style>'+pStyle+'</style>';
end;

function RecordToHtmlTable(pDataSet: TDataSet): String;
begin
  Result:= ' <table border="1"> ';
  Result:= Result+ObterCabecalhoHtml(pDataSet);
  Result:= Result+ObterValoresRecordHtml(pDataSet);
  Result:= Result+'</table>';
end;

function RecordCompareToHtml(pDataSetOld: TDataSet; pDataSetNew: TDataSet): String;
var
  FFieldNew, FFieldOld: TField;
begin
  Result:= '';
  for FFIeldNew in pDataSetNew.Fields do
  begin
    if not FFIeldNew.Visible then
      Continue;

    FFieldOld:= pDataSetOld.FindField(FFieldNew.FieldName);
    if not Assigned(FFieldOld) then
      Continue;

    if FFieldOld.Value <> FFieldNew.Value then
      Result:= Result+' <h2>'+FFieldNew.DisplayLabel+'(ALTERADO)=> Valor anterior: '+FFieldOld.DisplayText+'; Novo Valor: '+FFieldNew.DisplayText+'</h2> ';
  end;

end;

function ObterCabecalhoHtml(pDataSet: TDataSet): String;
var
  FField: TField;
begin
  Result:= '<tr>';
  for FField in pDataSet.Fields do
    if FField.Visible then
      Result:= Result+' <th>'+FField.DisplayLabel+'</th> ';
  Result:= Result+'</tr>';
end;

function FieldToTD(pField: TField): String;
var
  sAlign: String;
begin
  case pField.Alignment of
    taLeftJustify: sAlign:= '"left"';
    taRightJustify: sAlign:= '"right"';
    taCenter: sAlign:= '"center"';
  end;
  Result:= ' <td align='+sAlign+' >'+pField.DisplayText+'</td> ';
end;

function ObterValoresRecordHtml(pDataSet: TDataSet): String;
var
  FField: TField;
begin
  Result:= '<tr>';
  for FField in pDataSet.Fields do
    if FField.Visible then
      Result:= Result+FieldToTD(FField);

  Result:= Result+'</tr>';
end;

function DataSetToHtml(pDataSet: TDataSet): String;
begin
  Result:= '<table> ';
  Result:= Result+ObterCabecalhoHtml(pDataSet);

  pDataSet.First;
  while not pDataSet.Eof do
  begin
    Result:= Result+ObterValoresRecordHtml(pDataSet);
    pDataSet.Next;
  end;
  Result:= Result+'</table>';
end;

{ TEnviaEmailConsulta }

function TEnviaEmailConsulta.ConsultaParaHtml: String;
begin
  Result:= WrapHtml('<h1>'+Titulo+'</h1>'+DataSetToHtml(FQry));
end;

constructor TEnviaEmailConsulta.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Params:= TDictionary<String, variant>.Create;

  TipoVisualizacao:= tvTabela;

  Visualizacao:= '';

  FDmGeradorConsultas:= TDmGeradorConsultas.Create(Self, ConSqlServer);

  FQry:= TFDQuery.Create(Self);
end;

procedure TEnviaEmailConsulta.Enviar;
var
  FHtml: String;
begin
  ExecutaConsulta;

  FHtml:= ConsultaParaHtml;

  WriteLog('Enviando email consulta: '+ConsultaNome+', para os emails: '+Destinatarios);
  FMailSender.EnviarEmail(Titulo, FHtml,
      Destinatarios, 'marcelo@rauter.com.br');
end;

procedure TEnviaEmailConsulta.EnviarTabela;
var
  FAnexo: String;
begin
  FAnexo:= ExportaTabelaParaExcel;

  if FAnexo = '' then
  begin
    WriteLog('Erro ao exportar consulta: '+ConsultaNome+', para excel');
    Exit;
  end;

  WriteLog('Enviando email consulta: '+ConsultaNome+', para os emails: '+Destinatarios);

  FMailSender.EnviarEmailComAnexo(Titulo, Texto,
      Destinatarios, '', '', FAnexo);
{  FMailSender.EnviarEmail(Titulo, 'Tabela em anexo',
      Destinatarios, 'marcelo@rauter.com.br');      }
end;

function TEnviaEmailConsulta.ExportaTabelaParaExcel: String;
var
  FNomeArquivo: String;
begin
  FNomeArquivo:= ExtractFilePath(Application.ExeName)+'Temp\'+ConsultaNome;
  Result:= TFrmConsultaPersonalizada.ExportaTabelaParaExcel(ConsultaNome, FNomeArquivo, Params, TipoVisualizacao, Visualizacao);
end;

procedure TEnviaEmailConsulta.ExecutaConsulta;
var
  FParam: String;
begin
  FDmGeradorConsultas.AbrirConsultaPorNome(ConsultaNome);

  for FParam in Params.Keys do
    FDMGeradorConsultas.SetParam(FParam, Params[FParam]);

  FQry.Close;

  case FDmGeradorConsultas.GetFonteDados of
    fdSqlServer: FQry.Connection:= ConSqlServer.FDConnection;
    fdFirebird: FQry.Connection:= ConFirebird.FDConnection;
  end;

  FQry.Open(FDMGeradorConsultas.GeraSqlConsulta);

  FDmGeradorConsultas.SetEstilosCamposQry(FQry);
end;

initialization
  FMailSender:= TMailSender.Create(nil, 'smtp.rauter.com.br', 587, 'marcelo@rauter.com.br', 'rtq1825', True, 'marcelo@rauter.com.br');

finalization
  FMailSender.Free;

end.
