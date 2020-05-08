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

    function FieldToSqlValue(pFieldName: String; pObject: TObject): String; virtual; abstract;

    function MapToSqlValue(pFieldMapping: TFieldMapping; pObject: TObject): String; virtual; abstract;
    function SelectWhereChave(FValor: Integer): String; virtual; abstract;
    function SelectWhere(const pWhere: String; pSelectOptions: TSelectOptions = []): String; virtual; abstract;

    function Insert(pObject: TObject; pOutputID: Boolean = False): String; virtual; abstract;
    function Update(pObject: TObject): String; virtual; abstract;
    function Delete(pObject: TObject): String; overload; virtual; abstract;
    function Delete(pKeyValue: Integer): String; overload; virtual; abstract;

    function ObjectExists(pObject: TObject): String; virtual; abstract;
    function KeyExists(pValorChave: Integer): String; virtual; abstract;
    function SelectValorUltimaChave: String; virtual; abstract;
  end;

  TSqlServerQueryBuilder = class(TQueryBuilderBase)
  private
    function GetUpdateDeleteWhere(pObject: TObject): String;
  public
//    function PropToSqlValue(pProp: TRttiProperty; pObject: TObject): string;
    function FieldToSqlValue(pFieldName: String; pObject: TObject): String; override;
    function MapToSqlValue(pFieldMapping: TFieldMapping; Instance: TObject): String; override;

    function SelectWhereChave(FValor: Integer): String; override;
    function SelectWhere(const pWhere: String; pSelectOptions: TSelectOptions = []): String; override;

    function Insert(pObject: TObject; pOutputID: Boolean = False): String; override;
    function Update(pObject: TObject): String; override;
    function Delete(pObject: TObject): String; overload; override;
    function Delete(pKeyValue: Integer): String; overload; override;

    function ObjectExists(pObject: TObject): String; override;
    function KeyExists(pValorChave: Integer): String; override;

    function SelectValorUltimaChave: String; override;

    class function DateSqlServer(pData: TDateTime; withQuotes: Boolean = true): String;
    class function DateTimeSqlServer(pData: TDateTime; withQuotes: Boolean = true): String;
  end;

implementation

uses
  Variants;

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
  FFieldMapping: TFieldMapping;
begin
  FFieldMapping:= ModeloBD.MappedFieldList.GetFieldMappingByFieldName(pFieldName);

  if not Assigned(FFieldMapping) then
    raise Exception.Create(Format('TSqlServerQueryBuilder.FieldToSqlValue: Field %s not mapped for class %s.', [pFieldName, ModeloBD.ItemClass.ClassName]));

  Result:= MapToSqlValue(FFieldMapping, pObject);
end;

function TSqlServerQueryBuilder.GetUpdateDeleteWhere(pObject: TObject): String;
var
  FFIeld: String;
  FFieldMapping: TFieldMapping;
begin
  Result:= '';
  for FFIeld in ModeloBD.FieldsInUpdateDeleteWhere do
  begin
    if Result <> '' then
      Result:= Result+ 'AND ';

    FFieldMapping:= ModeloBD.FieldMappingByFieldName(FField);
    Result:= Result+Format('%s = %s', [FFieldMapping.FieldName, MapToSqlValue(FFieldMapping, pObject)]);
  end;
end;

class function TSqlServerQueryBuilder.DateTimeSqlServer(pData: TDateTime; withQuotes: Boolean = true): String;
begin
  if withQuotes then
    Result:= QuotedStr(FormatDateTime('yyyymmdd hh:mm:ss', pData))
  else
    Result:= FormatDateTime('yyyymmdd hh:mm:ss', pData);
end;

class function TSqlServerQueryBuilder.DateSqlServer(pData: TDateTime; withQuotes: Boolean = true): String;
begin
  if withQuotes then
    Result:= QuotedStr(FormatDateTime('yyyymmdd', pData))
  else
    Result:= FormatDateTime('yyyymmdd', pData);
end;


function TSqlServerQueryBuilder.MapToSqlValue(pFieldMapping: TFieldMapping; Instance: TObject): String;
const
  cMsgErro = 'Propriedade %s do tipo %s não foi possível ser mapeada!';
var
  FVar: Variant;
begin
  FVar:= ModeloBD.GetFieldValue(pFieldMapping.FieldName, Instance);
  if VarIsNull(FVar) then
  begin
    Result:= 'NULL';
    Exit;
  end;

  case pFieldMapping.FieldType of
    ftString, ftMemo, ftWideString, ftFixedChar: Result:= QuotedStr(FVar);
    ftFloat, ftCurrency, ftBCD: Result:= FloatToSqlStr(FVar);
    ftInteger, ftSmallint, ftShortint, ftLargeint, ftByte, ftWord, ftBoolean: Result:= IntToStr(FVar);
    ftDateTime: Result:= DateTimeSqlServer(VarToDateTime(FVar));
    ftDate: Result:= DateSqlServer(VarToDateTime(FVar));
   else
     raise Exception.Create(Format(cMsgErro,[pFieldMapping.Prop.Name, GetPropertyRttiType(pFieldMapping.Prop).Name]));
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

    ModeloBD.FazMapeamentoDaClasse(fCallBack, True);

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


function TSqlServerQueryBuilder.Delete(pObject: TObject): String;
begin
  Result:= Format('DELETE FROM %s WHERE %s', [ModeloBD.NomeTabela, GetUpdateDeleteWhere(pObject)]);
end;

function TSqlServerQueryBuilder.Delete(pKeyValue: Integer): String;
begin
  Result:= Format('DELETE FROM %s WHERE %s = %d', [ModeloBD.NomeTabela, ModeloBD.NomeCampoChave, pKeyValue]);
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
    ModeloBD.FazMapeamentoDaClasse(fCallBack, True);
    fSql.AppendLine(')')
  end;

  procedure MapeiaValores;
  begin
    fPrimeiroCampo:= True;
    fMapeandoValores:= True;

    fSql.Append(' VALUES(');
    ModeloBD.FazMapeamentoDaClasse(fCallBack, True);
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
    ModeloBD.FazMapeamentoDaClasse(fCallBack, True);

    fSql.AppendFormat('WHERE %s ', [GetUpdateDeleteWhere(pObject)]);

    Result:= fSql.ToString;

  finally
    fSql.Free;
  end;
end;

function TSqlServerQueryBuilder.ObjectExists(pObject: TObject): String;
begin
  Result:= Format('SELECT COUNT(*) FROM %s WHERE %s', [ModeloBD.NomeTabela, GetUpdateDeleteWhere(pObject)]);
end;

function TSqlServerQueryBuilder.KeyExists(pValorChave: Integer): String;
begin
  Result:= Format('SELECT COUNT(*) FROM %s WHERE %s = %d', [ModeloBD.NomeTabela, ModeloBD.NomeCampoChave, pValorChave]);
end;

end.
