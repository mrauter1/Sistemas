unit uDmGeradorConsultas;

interface

uses
  SysUtils, Classes, DB, ADODB, DBClient, Provider, Contnrs, variants, Windows, Utils, uDmConnection,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uConSqlServer, System.Generics.Collections, uConClasses;

type
  TDmGeradorConsultas = class(TDataModule)
    DsPara: TDataSource;
    DsConsultas: TDataSource;
    DsCampos: TDataSource;
    QryCampos: TFDQuery;
    QryParametros: TFDQuery;
    QryConsultas: TFDQuery;
    QryCamposID: TFDAutoIncField;
    QryCamposConsulta: TIntegerField;
    QryCamposNomeCampo: TStringField;
    QryCamposDescricao: TStringField;
    QryCamposTamanhoCampo: TIntegerField;
    QryCamposVisivel: TBooleanField;
    QryCamposAgrupamento: TIntegerField;
    QryCamposCor: TIntegerField;
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
    QryConsultasID: TFDAutoIncField;
    QryConsultasNome: TStringField;
    QryConsultasDescricao: TStringField;
    QryConsultasSql: TMemoField;
    QryConsultasInfoExtendida: TMemoField;
    QryConsultasTipo: TIntegerField;
    QryConsultasConfigPadrao: TIntegerField;
    QryConsultasVisualizacaoPadrao: TIntegerField;
    QryConsultasIDPai: TIntegerField;
    QryConsultasFonteDados: TIntegerField;
    QryCamposFormatacao: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure QryParametrosAfterInsert(DataSet: TDataSet);
  private
    FDmConnection: TDmConnection;
    procedure CriaListaParams;
    procedure DeletaParams;
    function GetSqlOriginal: String;
    function SubstituiParametros(const FSql: String): String;
    function FazEvolutivo(const FSql: String): String;
    function VarArrayToSql(pVar: variant): String;
    function GetCodConsulta(NomeConsulta: String): integer;
    function IntToFonteDados(pValor: Integer): TFonteDados;
    function Func_DateTime_Sql(parData: TDateTime): String;
    procedure SetDmConnection(const Value: TDmConnection);
    procedure OnGetTextPercentual(Sender: TField; var Text: string;
      DisplayText: Boolean);
  public
(*    SQLCampoTabList  : TStringList;
    CampoTelaList : TStringList;
    ObrigatorList : TStringList;
    ExcelList        : TStringList;
    ResultadoList    : TStringList;       *)

//    Params: TObjectList<TParametroCon>;
    Params: TParametros;
    SqlGerado: String;

    constructor Create(AOwner: TComponent; pDmConnection: TDmConnection); virtual;

    procedure AbrirConsulta(CodConsulta: Integer);
    procedure AbrirConsultaPorNome(NomeConsulta: String);
    procedure CriarParametrosBanco(Refresh: Boolean = False);

//    function UsuarioLogadoTemPermissao(pCodConsulta: Integer): Boolean;

    function GeraSqlConsulta: String;
    function ParamCount: Integer;
//    procedure ProcSubstVarSistema(var pSql: String);
    function SetParam(const pNomeParam: String; pValor: Variant): Boolean;
    function GetParamValue(const pNomeParam: String): Variant;
//    function GetParam(Index: Integer): TParametroCon; overload;
    function GetParam(const pNomeParam: String): TParametroCon; overload;
    procedure SetEstilosCamposQry(Qry: TDataSet);

    procedure AdicionaNovoCampo(Field: TField; pRefresh: Boolean = False);

    procedure SalvarValoresParametros(RefreshParams: Boolean = false);
    procedure RefreshQryCampos;
    procedure RefreshQryPara;
    function GetFonteDados: TFonteDados;
    function GeraSqlEvolutivo(const pSql: String; pDataIni, pDataFim: TDateTime; pEmMeses: Boolean; pPeriodo: Integer): String;

    procedure VerificaECriaParametros(pNomeInterno, pDescricao,
          pTexto: String; pParams: array of TParametroCon; pPai: String = 'PARAMETROS'; RefreshParams: Boolean = false);

    function DeletaConsulta(pIDConsulta: Integer): Boolean;

    property SqlOriginal: String read GetSqlOriginal;

    property DmConnection: TDmConnection read FDmConnection write SetDmConnection;
  end;

function FieldIsNumerico(pField: TField): Boolean;
function SetFieldDisplayFormat(pField: TField; pDisplayFormat: String): Boolean;
function GetFieldDisplayFormat(pField: TField): String;

//var
//  DmGeradorConsultas: TDmGeradorConsultas;

implementation

uses DateUtils, Ladder.Utils, SynCommons;

{$R *.dfm}

function FieldIsNumerico(pField: TField): Boolean;
begin
  Result:= (pField is TFloatField) or (pField is TBCDField) or (pField is TFMTBCDField);
end;

function GetFieldDisplayFormat(pField: TField): String;
begin
  Result:= '';

  if (pField is TFloatField) then
    Result:= (pField as TFloatField).DisplayFormat
  else if (pField is TBCDField) then
    Result:= (pField as TBCDField).DisplayFormat
  else if (pField is TFMTBCDField) then
    Result:= (pField as TFMTBCDField).DisplayFormat;
end;

function SetFieldDisplayFormat(pField: TField; pDisplayFormat: String): Boolean;
begin
  Result:= True;

  if (pField is TFloatField) then
  begin
   (pField as TFloatField).DisplayFormat:= pDisplayFormat;
  end
  else if (pField is TBCDField) then
  begin
    (pField as TBCDField).DisplayFormat:= pDisplayFormat;
  end
  else if (pField is TFMTBCDField) then
  begin
    (pField as TFMTBCDField).DisplayFormat:= pDisplayFormat;
  end
  else
   Result:= False;
end;

function TDmGeradorConsultas.DeletaConsulta(pIDConsulta: Integer): Boolean;
begin
  Result:= True;

  FDmConnection.ExecutaComando(Format('DELETE FROM Cons.Consultas Where ID = %d', [pIDConsulta]));
end;

procedure TDmGeradorConsultas.DeletaParams;
var
  FKey: String;
begin
  for FKey in Params.Keys do
    Params.Remove(FKey);
{  while Params.Count > 0 do
    Params.Delete(0);}
end;

constructor TDmGeradorConsultas.Create(AOwner: TComponent;
  pDmConnection: TDmConnection);
begin
  inherited Create(AOwner);
  SetDmConnection(pDmConnection);
end;

procedure TDmGeradorConsultas.CriaListaParams;
var
  fParam: TParametroCon;
begin
  QryParametros.First;
  while not QryParametros.Eof do
  begin
    fParam:= TParametroCon.Create;
    fParam.ID:= QryParametrosID.AsInteger;
    fParam.Nome:= QryParametrosNome.AsString;
    fParam.Descricao:= QryParametrosDescricao.AsString;
    fParam.Sql:= QryParametrosSql.AsString;
    fParam.Tipo:= TTipoParametro(QryParametrosTipo.AsInteger);
    fParam.Valor:= null;

    if not QryParametrosValorPadrao.IsNull then
    begin
      if QryParametrosTipo.AsInteger = 1 {ComboBox} then
      begin
        fParam.Valor:= QryParametrosValorPadrao.AsString;
        fParam.Tipo:= ptComboBox;
      end
      else if QryParametrosTipo.AsInteger = 2 {Campo Texto} then
      begin
        fParam.Valor:= QryParametrosValorPadrao.AsString;
        fParam.Tipo:= ptTexto;
      end
      else if QryParametrosTipo.AsInteger = 3 {Data} then
      begin
        if StrToDateDef(QryParametrosValorPadrao.AsString, 0) <> 0 then
          fParam.Valor:= StrToDate(QryParametrosValorPadrao.AsString);

        fParam.Tipo:= TTipoParametro.ptDateTime;
      end
      else if QryParametrosTipo.AsInteger = 4 {CheckListBox} then
      begin
        fParam.Valor:= StrToLadderArray(QryParametrosValorPadrao.AsString, ',');
        fParam.Tipo:= ptCheckListBox;
      end;
    end;

    Params.Add(fParam);

    QryParametros.Next;
  end;
end;

{function TDmGeradorConsultas.UsuarioLogadoTemPermissao(pCodConsulta: Integer): Boolean;
const
  cSqlTemControlePermissao = ' SELECT COUNT(*) FROM CONSULTAPERSONALIZADA_PERMISSAOUSUARIO PU '
                            +' FULL JOIN CONSULTAPERSONALIZADA_PERMISSAOSETOR PS ON PS.CppCruza = PU.CppCruza '
                            +' WHERE IsNull(ps.cppcruza, pu.cppCruza) = %d ';

  cSqlUsuTemPermissao = ' SELECT COUNT(*) FROM CONSULTAPERSONALIZADA_PERMISSAOUSUARIO PU WHERE PU.CppCruza = %d and pu.CppUsuario = %d ';

  cSqlSetorTemPermissao = ' SELECT count(*) FROM CONSULTAPERSONALIZADA_PERMISSAOSETOR PS '
                         + ' WHERE PS.CppCruza = %d and  PS.CppSetor IN (select PsuSetor '
                         + ' from PROJECT_PENDENCIAS_SETORES_USUARIOS where PsuUsuario = %d) ';

begin
  Result:= True;

  // Usuario nível 0 tem acesso a todas as consultas;
  if (FrmMenu.Loc_UsuarioNivel = 0) then
    Exit;

  // Sem controle de permissão
  if TDaoUtils.RetornaInteiro(Format(cSqlTemControlePermissao,[pCodConsulta]),0) = 0 then
    Exit;

  if TDaoUtils.RetornaInteiro(Format(cSqlUsuTemPermissao,[pCodConsulta, FrmMenu.Loc_UsuarioCodigo]),0) > 0 then
    Exit;

  if TDaoUtils.RetornaInteiro(Format(cSqlSetorTemPermissao,[pCodConsulta, FrmMenu.Loc_UsuarioCodigo]),0) > 0 then
    Exit;

  Result:= False;

  TMensagem.Aviso('Usuário sem Permissão.', 'Atenção');
end;}

procedure TDmGeradorConsultas.AbrirConsulta(CodConsulta: Integer);
begin
  QryConsultas.Active:= False;
  QryConsultas.Params.ParamByName('codConsulta').Value:= CodConsulta;
  QryConsultas.Active:= True;

  RefreshQryPara;

  RefreshQryCampos;

  DeletaParams;
  CriaListaParams;
end;

function TDmGeradorConsultas.GetCodConsulta(NomeConsulta: String): integer;
const
  cSql = 'SELECT ID FROM cons.Consultas WHERE Upper(Nome) = Upper(''%s'') ';
begin
  Result:= VarToIntDef(FDmConnection.RetornaValor(Format(cSql, [NomeConsulta])),0);
end;

function TDmGeradorConsultas.GetFonteDados: TFonteDados;
begin
  Result:= IntToFonteDados(QryConsultasFonteDados.AsInteger);
end;

procedure TDmGeradorConsultas.AbrirConsultaPorNome(NomeConsulta: String);
begin
  AbrirConsulta(GetCodConsulta(NomeConsulta));
end;

procedure TDmGeradorConsultas.AdicionaNovoCampo(Field: TField;
  pRefresh: Boolean = False);
begin
  if QryCampos.Locate('NomeCampo', Field.FieldName, [loCaseInsensitive]) then
  begin
    if not pRefresh then
      Exit;

    QryCampos.Edit;
  end
 else
   QryCampos.Append;

  QryCamposConsulta.AsInteger:= QryConsultasID.AsInteger;
  QryCamposNomeCampo.AsString:= Field.FieldName;
  QryCamposDescricao.AsString:= Field.DisplayLabel;
  QryCamposTamanhoCampo.AsInteger:= Field.DisplayWidth;
  QryCamposVisivel.AsBoolean:= Field.Visible;
  if IsCurrencyField(Field) then
    QryCamposFormatacao.AsInteger:= Ord(fcMoeda)
  else
    QryCamposFormatacao.AsInteger:= Ord(fcTexto);

  QryCampos.Post;
end;

(*procedure TDmGeradorConsultas.ProcSubstVarSistema(var pSql: String);
begin
  pSql:= StringReplace(pSql,'{CodEmpresa}',(InttoStr(FrmMenu.Loc_Empresa)),[rfReplaceAll]);
  pSql:= StringReplace(pSql,'{Usuario}',FrmMenu.Loc_UsuarioNome,[rfReplaceAll]);
end;                         *)

function TDmGeradorConsultas.VarArrayToSql(pVar: variant): String;
var
  I: Integer;
  pInStr: String;
begin
  if VarIsLadderArray(pVar) then
  begin
    for I:= 0 to TDocVariantData(pVar).Count-1 do
    begin
      if pInStr > '' then
        pInStr:= pInStr + ',';

      pInStr:= pInStr+TDocVariantData(pVar).Values[I];
    end;
    Result:= pInStr;
  end
 else
  begin
    Result:= VarToStrDef(pVar, 'nil');
  end;
end;

procedure TDmGeradorConsultas.VerificaECriaParametros(pNomeInterno, pDescricao,
  pTexto: String; pParams: array of TParametroCon; pPai: String = 'PARAMETROS'; RefreshParams: Boolean = false);
// pParams: Lista de Parâmetros
// pPai: Nome do menu pai em que esta parametrização se encontra
// RefreshParams: Se falso apenas inclui os parâmetros que não existirem no sistema, se verdadeiro atualiza os dados de todos os parametros
var
  I: Integer;
  FCodPai: Integer;
begin
  FCodPai:= GetCodConsulta(pPai);
  if FCodPai = 0 then
    FCodPai:= 108; {108 paramêtros padrão}

  AbrirConsultaPorNome(pNomeInterno);
  if QryConsultas.IsEmpty then
  begin
    QryConsultas.Insert;

    QryConsultasNome.AsString:= pNomeInterno;
    QryConsultasDescricao.AsString:= pDescricao;
    QryConsultasInfoExtendida.AsString:= pTexto;
    QryConsultasIDPai.AsInteger:= FCodPai;
    QryConsultasTipo.AsInteger:= Ord(tcParametros); // Parametrização

    QryConsultas.Post;
  end;

  DeletaParams;

  for I:= 0 to Length(pParams)-1 do
    Params.Add(pParams[I]);

  CriarParametrosBanco(RefreshParams);
end;

procedure TDmGeradorConsultas.CriarParametrosBanco(Refresh: Boolean = False);
// Refresh: Se falso apenas inclui os parâmetros que não existirem no sistema,
//                   se verdadeiro atualiza os dados de todos os parametros
var
  I: Integer;
  FParam: TParametroCon;
begin
  for FParam in Params.Values do
  begin
//    FParam:= TParametroCon(Params[I]);

    if Trim(FParam.Nome) = '' then
      Continue;

    if not QryParametros.Locate('Nome', FParam.Nome, [loCaseInsensitive]) then
    begin
      QryParametros.Insert;
      QryParametrosConsulta.AsInteger:= QryConsultasID.AsInteger;
    end
    else if Refresh then
      QryParametros.Edit
    else
      Continue; // Se Refresh igual a false e já existir vai para o próximo parâmetro

    QryParametrosNome.AsString:= FParam.Nome;
    QryParametrosTipo.AsInteger:= Integer(FParam.Tipo);
    QryParametrosDescricao.AsString:= fParam.Descricao;
    QryParametrosSql.AsString:= fParam.Sql;

    case FParam.Tipo of
      ptComboBox: QryParametrosValorPadrao.Value:= fParam.Valor;
      ptTexto: QryParametrosValorPadrao.Value:= fParam.Valor;
      TTipoParametro.ptDateTime: QryParametrosValorPadrao.Value:= FormatDateTime('dd/mm/yyyy', fParam.Valor);
      ptCheckListBox: QryParametrosValorPadrao.Value:= VarArrayToSql(fParam.Valor);
    end;

    QryParametros.Post;
  end;
end;

procedure TDmGeradorConsultas.SalvarValoresParametros;
var
  I: Integer;
  FParam: TParametroCon;
begin
  for FParam in Params.Values do
  begin
//    FParam:= TParametroCon(Params[I]);

    if Trim(FParam.Nome) = '' then
      Continue;

    if QryParametros.Locate('Nome', FParam.Nome, [loCaseInsensitive]) then
    begin
      QryParametros.Edit;

      case FParam.Tipo of
        ptComboBox: QryParametrosValorPadrao.Value:= fParam.Valor;
        ptTexto: QryParametrosValorPadrao.Value:= fParam.Valor;
        TTipoParametro.ptDateTime: QryParametrosValorPadrao.Value:= FormatDateTime('dd/mm/yyyy', fParam.Valor);
        ptCheckListBox: QryParametrosValorPadrao.Value:= VarArrayToSql(fParam.Valor);
      end;

      QryParametros.Post;
    end;
  end;
end;

function TDmGeradorConsultas.IntToFonteDados(pValor: Integer): TFonteDados;
begin
  case pValor of
    1: Result:= fdSqlServer;
    2: Result:= fdFirebird;
    else Result:= fdSqlServer;
  end;
end;

function TDmGeradorConsultas.Func_DateTime_Sql(parData: TDateTime): String;
begin
  if parData = 0 then
     Result:= 'null'
  else if GetFonteDados = fdFirebird then
    Result:= Func_DataTime_Firebird(parData)
  else
    Result:= Func_DateTime_SqlServer(parData);

end;

function TDmGeradorConsultas.SubstituiParametros(const FSql: String): String;

  function FiltroCheckListBox(const pNomeCampo: String; pParam: variant): String;
  var
    I: Integer;
    pInStr: String;
  begin
    pInStr:= '';
    Result:= '';

    if VarIsNull(pParam) then Exit;

    if not VarIsLadderArray(pParam) then
    begin
      pInStr:= pParam;
    end
   else
    begin
      for I:= 0 to TDocVariantData(pParam).Count-1 do
      begin
        if pInStr > '' then
          pInStr:= pInStr + ',';

        pInStr:= pInStr+TDocVariantData(pParam).Values[I]
      end;
    end;

    if pInStr <> '' then
      Result:= ' AND '+pNomeCampo+' in ('+pInStr+') ';
  end;

begin
  try
    Result:= FSql;

//  ProcSubstVarSistema(Result);

    QryParametros.First;

    while not QryParametros.Eof do
    begin
     { case QryParaCopTipo.AsInteger of
        1: ;//	'Combo Box'
        2: ;//	'Campo Texto'
        3: ;//	'Campo Data'
        4: ;//	'CheckBox'
      end; }
      if QryParametrosTipo.AsInteger = 4 then
        Result:= StringReplace(Result, '{'+QryParametrosNome.AsString+'}',
                                 FiltroCheckListBox(QryParametrosNome.AsString, GetParamValue(QryParametrosNome.AsString)), [rfIgnoreCase, rfReplaceAll])
      else if QryParametrosTipo.AsInteger = 3 then
        Result:= StringReplace(Result,'{'+QryParametrosNome.AsString+'}', Func_DateTime_Sql(VarToFloatDef(GetParamValue(QryParametrosNome.AsString))), [rfIgnoreCase, rfReplaceAll])
      else
        Result:= StringReplace(Result,'{'+QryParametrosNome.AsString+'}', VarToStrDef(GetParamValue(QryParametrosNome.AsString), QryParametrosValorPadrao.AsString), [rfIgnoreCase, rfReplaceAll]);

      QryParametros.Next;
    end;

  except
    on E: Exception do
      AbortMessage('Erro ao substituir parametros: '+e.Message, 'TDmGeradorConsultas');

  end;
end;

function TDmGeradorConsultas.GeraSqlConsulta():String;
begin
  Result:='';

  if QryConsultasTipo.AsInteger = Ord(tcNormal) then
    SqlGerado:= SubstituiParametros(SqlOriginal)
  else if QryConsultasTipo.AsInteger = Ord(tcEvolutivo) then
    SqlGerado:= FazEvolutivo(SqlOriginal);

  Result:=SqlGerado;
end;

function TDmGeradorConsultas.FazEvolutivo(const FSql: String): String;
var
  vEmMeses: Boolean;
  vPeriodo: Integer;

  function Get_DataIni: TDateTime;
  var
    vVar: Variant;
  begin
    Result:= now;
    vVar:= GetParamValue('geDataIni');

    if VarIsNulL(vVar) then Exit;

    Result:= StartOfTheDay(VarToDateTime(vVar));
  end;

  function Get_DataFim: TDateTime;
  var
    vVar: Variant;
  begin
    Result:= now;
    vVar:= GetParamValue('geDataFim');

    if VarIsNulL(vVar) then Exit;

    Result:= EndOfTheDay(VarToDateTime(vVar));
  end;     

begin
  vEmMeses:= VarToIntDef(GetParamValue('geTipoPeriodo'), 1) = 1;

  vPeriodo:= VarToIntDef(GetParamValue('gePeriodo'), 1);

  Result:= GeraSqlEvolutivo(FSql, Get_DataIni, Get_DataFim, vEmMeses, vPeriodo);
end;

function TDmGeradorConsultas.SetParam(const pNomeParam: String;
  pValor: Variant): Boolean;
var
  I: Integer;
  fParam: TParametroCon;
begin
  Result:= Params.TryGetValue(pNomeParam, fParam);
  fParam.Valor:= pValor;
                 {
//  for I:= 0 to Params.Count - 1 do
  for fParam in Params.Values do
  begin
//    fParam:= TParametroCon(Params[I]);
    if UpperCase(fParam.Nome) = UpperCase(pNomeParam) then
    begin
      fParam.Valor:= pValor;
      Result:= True;
      Exit;
    end;
  end;

  Result:= False;}
  //Erro Parametro não encontrado!
end;

function TDmGeradorConsultas.GetParam(const pNomeParam: String): TParametroCon;
var
  I: Integer;
begin
  Result:= nil;
  Params.TryGetValue(pNomeParam, Result);
{//  for I:= 0 to Params.Count - 1 do
  for fParam in Params.Values do
  begin
//    fParam:= TParametroCon(Params[I]);
    if UpperCase(fParam.Nome) = UpperCase(pNomeParam) then
    begin
      Result:= fParam;
      Exit;
    end;
  end;}
end;

function TDmGeradorConsultas.GetParamValue(const pNomeParam: String): Variant;
var
  fParam: TParametroCon;
begin
  Result:= null;

  fParam:= GetParam(pNomeParam);

  if Assigned(fParam) then
    Result:= fParam.Valor;

end;

procedure TDmGeradorConsultas.DataModuleCreate(Sender: TObject);
begin
  Params:= TParametros.Create;
end;

function TDmGeradorConsultas.GetSqlOriginal: String;
begin
  Result:= '';
  if QryConsultas.Active then
    if not QryConsultas.IsEmpty then
      Result:= QryConsultasSql.AsString;
end;

{function TDmGeradorConsultas.GetParam(Index: Integer): TParametroCon;
begin
  Result:= TParametroCon(Params[Index]);
end;                                }

function TDmGeradorConsultas.ParamCount: Integer;
begin
  Result:= Params.Count;
end;

procedure TDmGeradorConsultas.QryParametrosAfterInsert(DataSet: TDataSet);
begin
  QryParametrosConsulta.AsInteger:= QryConsultasID.AsInteger;
end;

procedure TDmGeradorConsultas.RefreshQryPara;
begin
  QryParametros.Active:= False;
  QryParametros.Params.ParamByName('codConsulta').Value:= QryConsultasID.AsInteger;
  QryParametros.Active:= True;
end;

procedure TDmGeradorConsultas.RefreshQryCampos;
begin
  QryCampos.Active:= False;
  QryCampos.Params.ParamByName('codConsulta').Value:= QryConsultasID.AsInteger;
  QryCampos.Active:= True;
end;

procedure TDmGeradorConsultas.SetDmConnection(const Value: TDmConnection);
begin
  FDmConnection := Value;
  QryCampos.Connection:= FDmConnection.FDConnection;
  QryParametros.Connection:= FDmConnection.FDConnection;
  QryConsultas.Connection:= FDmConnection.FDConnection;
end;

procedure TDmGeradorConsultas.SetEstilosCamposQry(Qry: TDataSet);
var
  I: Integer;
  FField: TField;
begin
  for I:= 0 to Qry.FieldCount - 1 do
  begin
    FField:= Qry.Fields[i];
    if QryCampos.Locate('NomeCampo', FField.FieldName, [loCaseInsensitive]) then
    begin
      FField.DisplayLabel:= QryCamposDescricao.AsString;
      FField.DisplayWidth:= QryCamposTamanhoCampo.AsInteger;
      FField.Visible:= QryCamposVisivel.AsBoolean;

      if QryCamposFormatacao.AsInteger = Ord(fcMoeda) then
        SetFieldDisplayFormat(FField, 'R$ #,##0.00')
      else if QryCamposFormatacao.AsInteger = Ord(fcPorcentagem) then
        FField.OnGetText:= OnGetTextPercentual;

    end;
  end;
end;

procedure TDmGeradorConsultas.OnGetTextPercentual(Sender: TField;
  var Text: string; DisplayText: Boolean);

  function FormataFieldPercentual(Sender: TField): String;
  begin
    Result:= FormatFloat('###0.00', VarToFloatDef(Sender.Value,0)*100)+' %';
  end;
begin
  Text:= FormataFieldPercentual(Sender);
end;

function TDmGeradorConsultas.GeraSqlEvolutivo(const pSql: String; pDataIni,
  pDataFim: TDateTime; pEmMeses: Boolean; pPeriodo: Integer): String;
var
  pTempDataIni, pTempDataFim: TDateTime;

  procedure SetProximaDataFim;
  begin
    if pEmMeses then
      pTempDataFim:= EndOfTheDay(IncMonth(pTempDataIni, pPeriodo)-1)
    else
      pTempDataFim:= EndOfTheDay(IncDay(pTempDataIni, pPeriodo)-1);

    if pTempDataFim > pDataFim then
      pTempDataFim:= pDataFim;
  end;

  procedure SetProximasDatas;
  begin
    if pEmMeses then
      pTempDataIni:= IncMonth(pTempDataIni, pPeriodo)
    else
      pTempDataIni:= IncDay(pTempDataIni, pPeriodo);

    SetProximaDataFim;
  end;

  function Func_Subst_PalavrasChave(const FSql: String): String;
  const
    cPeriodo = ' CASE '
             + '   WHEN {geTipoPeriodo} = 1 AND {gePeriodo} = 1 THEN RIGHT(convert(varchar, convert(date, {tmpDataIni}),103),7) '
             + '   WHEN {geTipoPeriodo} = 1 AND {gePeriodo} > 1 THEN RIGHT(convert(varchar, convert(date, {tmpDataIni}),103),7) '
             + '   +'' à ''+ RIGHT(convert(varchar, convert(date, {tmpDataFim}),103),7) '
             + '   ELSE convert(varchar, convert(date, {tmpDataIni}), 103) +'' à ''+ convert(varchar, convert(date, {tmpDataFim}), 103) '
             + ' end ';
  begin
    Result:= StringReplace(FSql, '{tmpPeriodo}', cPeriodo, [rfReplaceAll, rfIgnoreCase]);
    Result:= StringReplace(Result, '{tmpDataIni}', Func_DateTime_Sql(pTempDataIni), [rfReplaceAll, rfIgnoreCase]);
    Result:= StringReplace(Result, '{tmpDataFim}', Func_DateTime_Sql(pTempDataFim), [rfReplaceAll, rfIgnoreCase]);
  end;

begin
  Result:= '';

  pTempDataIni:= pDataIni;

  SetProximaDataFim;

  while pTempDataIni <= pDataFim do
  begin
    if Result <> '' then
      Result:= Result + sLineBreak+sLineBreak+' UNION ALL '+sLineBreak+sLineBreak;

    Result:= Result + SubstituiParametros(Func_Subst_PalavrasChave(pSql));

    SetProximasDatas;
  end;
end;

end.
