unit Ladder.ORM.QueryBuilder;

interface

uses
  Ladder.ORM.ModeloBD, System.Classes, SysUtils, System.Rtti, Ladder.ORM.Functions,
  Ladder.Messages, Data.DB;

type
//  TMappingType = (mtInteiro, mtFloat,

  TQueryBuilderBase = class(TObject)
  private
    fModeloBD: TModeloBD;
  protected
  public
    constructor Create(ModeloBD: TModeloBD);
    property ModeloBD: TModeloBD read fModeloBD write fModeloBD;
    function MappedFieldList: TFieldMappingList;

    function MapToSqlValue(pFieldMapping: TFieldMapping; pObject: TObject): String; virtual; abstract;
    function SelectWhereChave(FValor: Integer): String; virtual; abstract;
    function SelectWhere(const pWhere: String; pSelectOptions: TSelectOptions = []): String; virtual; abstract;

    function Insert(pObject: TObject; pOutputID: Boolean = False): String; virtual; abstract;
    function Update(pObject: TObject): String; virtual; abstract;
    function Delete(pKeyValue: Integer): String; virtual; abstract;

    function KeyExists(pValorChave: Integer): String; virtual; abstract;
    function SelectValorUltimaChave: String; virtual; abstract;
  end;

  TSqlServerQueryBuilder = class(TQueryBuilderBase)
  private
    function FieldToSqlValue(pFieldName: String; pObject: TObject): String;
    function DateTimeSqlServer(pData: TDateTime; withQuotes: Boolean = true): String;
    function DateSqlServer(pData: TDateTime; withQuotes: Boolean = true): String;
  public
//    function PropToSqlValue(pProp: TRttiProperty; pObject: TObject): string;
    function MapToSqlValue(pFieldMapping: TFieldMapping; pObject: TObject): String;

    function SelectWhereChave(FValor: Integer): String; override;
    function SelectWhere(const pWhere: String; pSelectOptions: TSelectOptions = []): String; override;

    function Insert(pObject: TObject; pOutputID: Boolean = False): String; override;
    function Update(pObject: TObject): String; override;
    function Delete(pValorChave: Integer): String; override;
    function KeyExists(pValorChave: Integer): String; override;

    function SelectValorUltimaChave: String; override;
  end;

implementation

{ TQueryBuilderBase }

constructor TQueryBuilderBase.Create(ModeloBD: TModeloBD);
begin
  FModeloBD:= ModeloBD;
end;

function TQueryBuilderBase.MappedFieldList: TFieldMappingList;
begin
  Result:= ModeloBD.MappedFieldList;
end;

{ TSqlServerQueryBuilder }

function TSqlServerQueryBuilder.FieldToSqlValue(pFieldName: String; pObject: TObject): String;
var
  FProperty: TRttiProperty;
begin
  FProperty:= ModeloBD.MappedFieldList.GetFieldMappingByFieldName(pFieldName).Prop;

  if not Assigned(FProperty) then
    raise Exception.Create(Format('TSqlServerQueryBuilder.FieldToSqlValue: Field %s not mapped', [pFieldName]));
end;

function TSqlServerQueryBuilder.DateTimeSqlServer(pData: TDateTime; withQuotes: Boolean = true): String;
begin
  if withQuotes then
    Result:= QuotedStr(FormatDateTime('yyyymmdd hh:mm:ss', pData))
  else
    Result:= FormatDateTime('yyyymmdd hh:mm:ss', pData);
end;

function TSqlServerQueryBuilder.DateSqlServer(pData: TDateTime; withQuotes: Boolean = true): String;
begin
  if withQuotes then
    Result:= QuotedStr(FormatDateTime('yyyymmdd', pData))
  else
    Result:= FormatDateTime('yyyymmdd', pData);
end;


function TSqlServerQueryBuilder.MapToSqlValue(pFieldMapping: TFieldMapping; pObject: TObject): String;
const
  cMsgErro = 'Propriedade %s do tipo %s não foi possível ser mapeada!';
var
  Value: TValue;
begin
  Value:= pFieldMapping.Prop.GetValue(pObject);

  case pFieldMapping.FieldType of
    ftString, ftMemo, ftWideString, ftFixedChar: Result:= QuotedStr(Value.ToString);
    ftFloat, ftCurrency, ftBCD: Result:= FloatToSqlStr(Value.AsExtended);
    ftInteger, ftSmallint, ftShortint, ftLargeint, ftByte, ftWord, ftBoolean: Result:= IntToStr(Value.AsInteger);
    ftDateTime: Result:= DateTimeSqlServer(Value.AsExtended);
    ftDate: Result:=  DateSqlServer(Value.AsExtended);
   else
     raise Exception.Create(Format(cMsgErro,[pFieldMapping.Prop.Name, pFieldMapping.Prop.PropertyType.Name]));
  end;
end;

function TSqlServerQueryBuilder.SelectValorUltimaChave: String;
begin
  Result:= ' SELECT SCOPE_IDENTITY() ';
end;

function TSqlServerQueryBuilder.SelectWhere(const pWhere: String; pSelectOptions: TSelectOptions = []): String;
var
  fSql: TStringBuilder;
  fPrimeiroCampo: Boolean;
  fCallBack: TMapeamentoCallback;
begin
  fCallBack:=
    procedure (pClass: TClass; pFieldMapping: TFieldMapping)
    begin
      if not fPrimeiroCampo then
        fSql.Append(' , ');

      fSql.Append('  ').AppendLine(pFieldMapping.FieldName);

      if fPrimeiroCampo then
        fPrimeiroCampo:= False;
    end;

  fPrimeiroCampo:= True;

  fSql:= TStringBuilder.Create;
  try
    fSql.AppendLine('SELECT ');

    if Top0 in pSelectOptions then
      fSql.AppendLine(' TOP 0 ');

    ModeloBD.FazMapeamentoDaClasse(fCallBack);

    fSql.Append('FROM ').AppendLine(ModeloBD.NomeTabela);

    if pWhere <> '' then
      fSql.AppendLine('WHERE '+pWhere);

    Result:= fSql.ToString;

  finally
    fSql.Free;
  end;
end;

function TSqlServerQueryBuilder.SelectWhereChave(FValor: Integer): String;
begin
  Result:= SelectWhere(Format('%s = %d', [ModeloBD.NomeCampoChave, FValor]));
end;

function TSqlServerQueryBuilder.Delete(pValorChave: Integer): String;
begin
  Result:= Format('DELETE FROM %s WHERE %s = %d', [ModeloBD.NomeTabela, ModeloBD.NomeCampoChave, pValorChave]);
end;

function TSqlServerQueryBuilder.Insert(pObject: TObject; pOutputID: Boolean = False): String;
var
  fSql: TStringBuilder;
  fPrimeiroCampo: Boolean;
  fCallBack: TMapeamentoCallback;
  fMapeandoValores: Boolean;

  procedure MapeiaCampos;
  begin
    fPrimeiroCampo:= True;
    fMapeandoValores:= False;

    fSql.Append(' (');
    ModeloBD.FazMapeamentoDaClasse(fCallBack);
    fSql.AppendLine(')')
  end;

  procedure MapeiaValores;
  begin
    fPrimeiroCampo:= True;
    fMapeandoValores:= True;

    fSql.Append(' VALUES(');
    ModeloBD.FazMapeamentoDaClasse(fCallBack);
    fSql.Append(')');
  end;

begin
  fCallBack:=
    procedure (pClass: TClass; pFieldMapping: TFieldMapping)
    begin
      try
        if (fModeloBD.ChaveIncremental) and (pFieldMapping.Prop = fModeloBD.PropChave) then
          Exit;

        if not fPrimeiroCampo then
          fSql.Append(', ');

        if not fMapeandoValores then
          fSql.Append('  ').Append(pFieldMapping.FieldName)
        else
          fSql.Append('  ').Append(MapToSqlValue(pFieldMapping, pObject));

        if fPrimeiroCampo then
          fPrimeiroCampo:= False;
       except
         on E: Exception do
           raise Exception.Create('Erro ao mapear propriedade: '+pFieldMapping.PropName+'. Mensagem: '+E.Message);
       end;
    end;

  fSql:= TStringBuilder.Create;
  try
    fSql.Append('INSERT INTO ').AppendLine(ModeloBD.NomeTabela);

    MapeiaCampos;

    if pOutputID then
      fSql.AppendFormat('OUTPUT INSERTED.%s', [fModeloBD.NomeCampoChave]);

    MapeiaValores;

    Result:= fSql.ToString;

  finally
    fSql.Free;
  end;
end;

function TSqlServerQueryBuilder.Update(pObject: TObject): String;
var
  fSql: TStringBuilder;
  fPrimeiroCampo: Boolean;
  fCallBack: TMapeamentoCallback;
begin
  fCallBack:=
    procedure (pClass: TClass; pFieldMapping: TFieldMapping)
    begin
      if (fModeloBD.ChaveIncremental) and (pFieldMapping.Prop = fModeloBD.PropChave) then
        Exit;

      if not fPrimeiroCampo then
        fSql.Append(' , ');

      fSql.Append('  ').Append(pFieldMapping.FieldName);

      fSql.Append(' = ').AppendLine(MapToSqlValue(pFieldMapping, pObject));

      if fPrimeiroCampo then
        fPrimeiroCampo:= False;
    end;

  fSql:= TStringBuilder.Create;
  try
    fSql.Append('UPDATE ').AppendLine(ModeloBD.NomeTabela);

    fSql.Append(' SET ');

    fPrimeiroCampo:= True;
    ModeloBD.FazMapeamentoDaClasse(fCallBack);

    fSql.AppendFormat('WHERE %s = %d ', [ModeloBD.NomeCampoChave, ModeloBD.GetValorChave(pObject)]);

    Result:= fSql.ToString;

  finally
    fSql.Free;
  end;
end;

function TSqlServerQueryBuilder.KeyExists(pValorChave: Integer): String;
begin
  Result:= Format('SELECT COUNT(*) FROM %s WHERE %s = %d', [ModeloBD.NomeTabela, ModeloBD.NomeCampoChave, pValorChave]);
end;

end.
